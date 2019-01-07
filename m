Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5078D1F803
	for <e@80x24.org>; Mon,  7 Jan 2019 20:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfAGUj4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 15:39:56 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:46254 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbfAGUj4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 15:39:56 -0500
Received: by mail-ua1-f65.google.com with SMTP id v24so564884uap.13
        for <git@vger.kernel.org>; Mon, 07 Jan 2019 12:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lU1J7McmjjKLe3E2H6Cip72/Z6nVbLKTbHGs+VyLLbQ=;
        b=qVbVp3VQMUa0Q6B6i/iNgnl0VdGplkHY2jqysMc4G2H6aSmpGErvFx1vHJWtir2wR5
         53DaKt5ZsFpjsCdV4DA8EH1YuO9XJO3Vk8pFCuKj1ao0TFcC3BAkHrBuZNEv6lJxbR73
         Srooh1YOdaQWOJXTum+YrCvkUcv1xErbjnkXO6a+mAHEkED+1W1/H+FnOvDbaV58jphC
         m1wvfGGQnSov44F0YWlQgR3xFpcBxOHjFJVUySRHyQx+6euf61olTBC4DnOpEWsFmAYm
         7xciCn1GAyGVgNjKcnyzJSklD6QVaHyNYKPuVP/NtrPc/90ya3JKRP0j34kbekaDiR4K
         jPWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lU1J7McmjjKLe3E2H6Cip72/Z6nVbLKTbHGs+VyLLbQ=;
        b=efI5I2Nkla7Qf0U4cSy271/SU17nXH81yU/p9nMSNu/1Q80jaXkG6Vj1+GmfpAI2Z7
         xa77npN1b0lGSv74bPhCWs2lX3BDCX5/nIOylHxFF4GXzwjpf5QoyT0V4I0KziCOHsGh
         twf8wflEcn0Rs6xQQf3+7zKmhUWaBabHaXA5R/DPtQW3g8yl8tuqw+/DIEzKY3Y41Rq2
         6/mVW2HgTR983tlhnt0z6PvhSfGTM79c/s+jgjfpnVkE0QuQ1zxmMHZ0397KPQi9kHaj
         7SFoaN27gE8cgYUGau4Je0oni+G9uwlh4TlkDrLMh4oG601WC9ywsLUafDNY2oqX8pfy
         0AOg==
X-Gm-Message-State: AJcUukdS576SePDYCgBGJLKe1qM9Mh7kM2Ksh198VpJ8Lb4KnqBAbc7/
        X5VtZMfUR5t0ukfWn6LgZM/CE/LCVcSFIPIq5g4=
X-Google-Smtp-Source: ALg8bN7l3d1NcpLL7Lk3i2Q/rYG6RDmt+Q+qyYApbrtDVpdX3qSIuc5g2nryIfZIQxH1CvvZm0MUi3fAZ0GrmUpkfkY=
X-Received: by 2002:ab0:60da:: with SMTP id g26mr22573152uam.104.1546893594341;
 Mon, 07 Jan 2019 12:39:54 -0800 (PST)
MIME-Version: 1.0
References: <20181122044841.20993-1-newren@gmail.com> <20181211161139.31686-1-newren@gmail.com>
 <CABPp-BE83Oe15U4yrkcV_-qzWocMS4UcVeG1VEoac-jXgw9Peg@mail.gmail.com>
 <xmqq4lak8d4g.fsf@gitster-ct.c.googlers.com> <xmqqzhsc6xdk.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqzhsc6xdk.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 7 Jan 2019 12:39:42 -0800
Message-ID: <CABPp-BFckuONYcGGkCY3BuPypRULmhsk_OFHyYA2E4jM66BfeQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] Reimplement rebase --merge via interactive machinery
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Pratik Karki <predatoramigo@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, Jan 7, 2019 at 12:11 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Elijah Newren <newren@gmail.com> writes:
> >
> >> On Tue, Dec 11, 2018 at 8:11 AM Elijah Newren <newren@gmail.com> wrote:
> >>>
> >>> This series continues the work of making rebase more self-consistent
> >>> by removing inconsistencies between different backends.  In
> >>> particular, this series focuses on making the merge machinery behave
> >>> like the interactive machinery (though a few differences between the am
> >>> and interactive backends are also fixed along the way), and ultimately
> >>> removes the merge backend in favor of reimplementing the relevant
> >>> options on top of the interactive machinery.
> >>
> >> Friendly ping...let me know if you want me to simply resend v4.
> >>
> >
> > If you have anything newer than 90673135 ("rebase: Implement --merge
> > via the interactive machinery", 2018-12-11), then yeah, I haven't
> > seen it.
> >
> > Thanks.
> >
> > P.S. even if that one is latest, I would need to downcase Implement
> > before it hits 'next' ;-)
>
> Ah, one thing I forgot to mention.  Some of the tests updated in
> this series are unhappy with Dscho's "drive 'am' directly from the
> built-in code, bypassing git-rebase--am.sh scriptlet" topic.

2018-12-11 is the newest (and is almost the same as the version from
mid November); it's just been waiting for review.  I'll fix up the
casing of 'Implement' along with any other feedback, if any...maybe
including rebasing on Dscho's series depending on how he wants to take
it.


Dscho: Looks like our series conflicts slightly.  Would you like me to
rebase mine on top of yours and squash the following change into
commit c91c944a068e ("rebase: define linearization ordering and
enforce it", 2018-12-11), or do you want to rebase your series on mine
and either make a new commit out of this change or squash it in
somewhere?

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 0317280f83..54023547ff 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -578,7 +578,8 @@ static int run_am(struct rebase_options *opts)
        argv_array_pushl(&format_patch.args, "format-patch", "-k", "--stdout",
                         "--full-index", "--cherry-pick", "--right-only",
                         "--src-prefix=a/", "--dst-prefix=b/", "--no-renames",
-                        "--no-cover-letter", "--pretty=mboxrd", NULL);
+                        "--no-cover-letter", "--pretty=mboxrd",
+                        "--topo-order", NULL);
        if (opts->git_format_patch_opt.len)
                argv_array_split(&format_patch.args,
                                 opts->git_format_patch_opt.buf);


Elijah
