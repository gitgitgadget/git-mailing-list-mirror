Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5EC320A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 22:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729741AbeLJW5B (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 17:57:01 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39123 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729606AbeLJW5B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 17:57:01 -0500
Received: by mail-ed1-f68.google.com with SMTP id b14so10929921edt.6
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 14:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JZVS9/v3dGO/mRth7TPWcPnEu5FDCDf72aoV16oe8pg=;
        b=L5jisJs657OOTi1o/5rF1YWZQaRSAx4S2DWE0d36Yv9BqvxLsGxuU3W0g1FtFO4WXl
         q6qOMl/qb/I8AXHmASUSGj91H5S+Qq1Y48BHXmOoiWtcIbshst9T9wBwSAE2cPfFzsiF
         sj0qQZlraWVPb3O8xP2gHrxUNdVRJc4l8GVbV6vN9Ai9947b+lF6eCzPTrfqQJwzTPId
         C81bUZltNIV2YBug2SDafdz4QPxLccsfzIRyjsJRKFj75TYFxHDG8uJArVHIcQR/R0Vb
         hcRMUD3V9Li1+yba2gd3ZrArx4FS/3z0kLniTpc31whI1YXWEjhESC4mku/12DNE8DvC
         zY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JZVS9/v3dGO/mRth7TPWcPnEu5FDCDf72aoV16oe8pg=;
        b=uWCEJmUuk7Ii+IZ/l1gUEDl++AX/K9X2c1yEiNV6npC03DZA/muCpdDG8/9xFwALtq
         qn21wFXA+2iz0difKBOoflfTmx2ig/Fn+pKsiuV3AfFZPHJBFQekZmWY6uc/eEO/1Jg2
         8TD6YPGf+GwofyLBjbFeNYtl8RbVfRuFS+6KlqTX6SNdlRrr1l0d5ww5n/LxtoAfFjk5
         V39SarsxTzpwfgtj1G8oQZpP3O3l3iB4CBmWhJEYkXqYe/TTzPcDOVpN0lRlslK1bF9F
         /2cm7fl/EUKn3MglGRdaFMoZxOQsCi86sp7HUpZQJAFZGvHHP1BcGVFS6oZhwoH83pFH
         9kOg==
X-Gm-Message-State: AA+aEWZ7oTE7iP6pTPT2KFjqi3qxIsVmEU5C1zDzavqxWizOKm0rzNO/
        2oYEzPRbpKfT5EGyWSAfcF96NxKe7u44DIXLRzRQJOFepww=
X-Google-Smtp-Source: AFSGD/WAb+0jDwcy33dxg6kQV0yPIXImh42dDl3TVLipjGzq931uk9FbZaU67C9m76K67UmacY1uTDw3EA3phMTsspY=
X-Received: by 2002:a17:906:45d8:: with SMTP id z24-v6mr10695774ejq.19.1544482618436;
 Mon, 10 Dec 2018 14:56:58 -0800 (PST)
MIME-Version: 1.0
References: <pull.90.git.gitgitgadget@gmail.com> <d2c317fd-d10a-19c1-8b4f-a7311c69a52f@kdbg.org>
In-Reply-To: <d2c317fd-d10a-19c1-8b4f-a7311c69a52f@kdbg.org>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 10 Dec 2018 14:56:47 -0800
Message-ID: <CAGZ79kY18SCaCBvkWyeVd+oeJ4EhoJK4=QxGhJ9a77iX2sR8ew@mail.gmail.com>
Subject: Re: [PATCH 0/3] rebase: offer to reschedule failed exec commands automatically
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     gitgitgadget@gmail.com, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 10, 2018 at 2:08 PM Johannes Sixt <j6t@kdbg.org> wrote:
>
> Am 10.12.18 um 20:04 schrieb Johannes Schindelin via GitGitGadget:
> > The idea was brought up by Paul Morelle.
> >
> > To be honest, this idea of rescheduling a failed exec makes so much sense
> > that I wish we had done this from the get-go.
>
> The status quo was actually not that bad a decision, because it made 'x
> false' as a substitute for 'break' very convenient.
>
> But now that we have a real 'break', I'm very much in favor of flipping
> the behavior over to rescheduling. (I'm actually not a user of the
> feature, but the proposed behavior is so compellingly logical.)

In rare cases I had commands that may be dangerous if rerun,
but I'd just not run them with -y but with -x.

That brings me to some confusion I had in the last patch:
To catch a flaky test I surely would be tempted to
    git rebase -x make -y "make test"
but that might reschedule a compile failure as well,
as a single -y has implications on all other -x's.

I wonder if it might be better to push this mechanism
one layer down: Instead of having a flag that changes
the behavior of the "exec" instructions and having a
handy '-y' short cut for the new mode, we'd rather have
a new type of command that executes&retries a command
("exnrt", 'n'), which can still get the '-y' command line flag,
but more importantly by having 2 separate sets of
commands we'd have one set that is a one-shot, and the
other that is retried. Then we can teach the user which
is safe and which isn't for rescheduling.

By having two classes, I would anticipate fewer compatibility
issues ('"Exec" behaves differently, and I forgot I had turned
on the rescheduling').

Talking about rescheduling: In the above example the flaky
test can flake more than once, so I'd be stuck with keeping
'git rebase --continue'ing after I see the test flaked once again.

My workflow with interactive rebase and fixing up things as I go
always involves a manual final "make test" to check "for real",
which I could lose now, which is nice.

Thanks,
Stefan
