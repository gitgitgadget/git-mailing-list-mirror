Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 404941F406
	for <e@80x24.org>; Tue, 15 May 2018 20:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752150AbeEOUPX (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 16:15:23 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:42204 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752059AbeEOUPW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 May 2018 16:15:22 -0400
Received: by mail-yw0-f195.google.com with SMTP id q7-v6so471766ywd.9
        for <git@vger.kernel.org>; Tue, 15 May 2018 13:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:in-reply-to:references:mime-version:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RTdPgDMltl+/y72iaQwUbpDUi8H5BSPYRXzX9fFkYi4=;
        b=F5fz7gHBDjle+ww7GGk6TLjhuVonF+VtbZ/cGNyhW///yzmqpkwJEnNKpoGL7rfcMD
         z/rsTi6dNkQQZK94geau10CF8OWgIFrIQm1jgCaawiCYIXIfhCOpF0VVk6n5jzk3L2yh
         PXku8L91yoVuK89REB9X379uTxa4Wwr89MqE+3Z/mEq6FkBkPBJvX+dPjMYS/o/H/jP4
         YUGGAkV3XoDIyPKnKuyMN4zO1lrFmj10DVBdWiI/LkSZCkmNn7cZWYOI1CxTr2wirna3
         SZ7QD/2FqIhjGyHmVOBo8tLEHxDvDyJdm3URo30uQj+Bb875Neh/xfirZHSeWurnjNWy
         FjMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:in-reply-to:references:mime-version:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RTdPgDMltl+/y72iaQwUbpDUi8H5BSPYRXzX9fFkYi4=;
        b=nf8PC96Uj8PLYbpHpi+o0fQYRlgbNWMKtFlM856JyWz87wFOT4zso7WQpW+kdiC+62
         goJFQv5dUEmPCO4dqABzU1fDnUZ7NCKbDYtT9OFHEFJEGnRfAJkKz/seLybbeqsnuGcw
         cqTkrz9j5bMsoW4jEmWLvpJJiu0ddCTQ9Jycz3TBBjhJf/6mIA8UOzDlb/OAPLmVAhdC
         BEnW2+lPxlOHb5LvjKRLBljVemrbtT9Q+ozJpOHEjuCN8sVtqlWaSZxzJBExbvvHT+b5
         91HyXbS8Iu/rfR/OxjXFlIOMe4GRDLr4Wx6RIT5ICiFq3DwAx5V2YUWuXbdC5EV92Y9d
         S1RQ==
X-Gm-Message-State: ALKqPwd1/g7nYhKH3OZyMidmDSYPthVkP3popHFjPJDFkRbjijxa4Iv4
        eqYyuQBafYNTfys6MBMKiwlsiVmtdqTBczB/uWhN4Q==
X-Google-Smtp-Source: AB8JxZoNVbjXzahKnhFzogYaDYB2AtpyYkkycZ3EtrD1N9S+NHyxD4QaoUFE5YNw45XHVXnzfvT918parPGwtBPBtYA=
X-Received: by 2002:a81:4109:: with SMTP id o9-v6mr7202882ywa.411.1526415321840;
 Tue, 15 May 2018 13:15:21 -0700 (PDT)
Received: from 1058052472880 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 May 2018 13:15:21 -0700
From:   Leif Middelschulte <leif.middelschulte@gmail.com>
In-Reply-To: <20180515200030.88731-1-sbeller@google.com>
References: <20180515200030.88731-1-sbeller@google.com>
X-Mailer: Airmail (481)
MIME-Version: 1.0
Date:   Tue, 15 May 2018 13:15:21 -0700
Message-ID: <CANw0+A-FK-zkuhX-jU8q7LfqgaNM6E4Xy92UOs2gkwkBf1TYOA@mail.gmail.com>
Subject: Re: [PATCHv2 0/3] Reroll of sb/submodule-merge-in-merge-recursive
To:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Stefan,

thank you once again for your effort.

Am 15. Mai 2018 um 22:00:34, Stefan Beller
(sbeller@google.com(mailto:sbeller@google.com)) schrieb:

> This rerolls the two commits found at [1] with the feedback of Eliah
> and puts Leifs patch[2] on top, that I edited according to Eliahs feedbac=
k,
> but kept Leifs ownership.
>
> This has addressed all of Eliahs feedback AFAICT.
> You'll find a branch-diff below[3], which lacks
> the new patch of Leif in that series, but is part of the reroll?
>
> Leif, what do you think?

Seems great to me. Thank you for picking up and improving my changes :)
One Question though: Shouldn=E2=80=99t an enum (like
NOTES_MERGE_VERBOSITY_DEFAULT) be used instead of numbers?


Cheers,


Leif

>
> Thanks,
> Stefan
>
> [1] https://public-inbox.org/git/20180510211917.138518-1-sbeller@google.c=
om/
> [2] https://public-inbox.org/git/20180514205737.21313-2-leif.middelschult=
e@gmail.com/
> [3] git branch-diff origin/master..origin/sb/submodule-merge-in-merge-rec=
ursive origin/master..HEAD >>0000-cover-letter.patch
>
> Leif Middelschulte (1):
> Inform about fast-forwarding of submodules during merge
>
> Stefan Beller (2):
> submodule.c: move submodule merging to merge-recursive.c
> merge-recursive: i18n submodule merge output and respect verbosity
>
> merge-recursive.c | 185 +++++++++++++++++++++++++++++++++++++++++++++-
> submodule.c | 168 +----------------------------------------
> submodule.h | 6 +-
> 3 files changed, 186 insertions(+), 173 deletions(-)
>
> --
> 2.17.0.582.gccdcbd54c44.dirty
>
>
>
> 1: e022c7976ae ! 1: 3b638ccac64 submodule.c: move submodule merging to me=
rge-recursive.c
> @@ -20,7 +20,6 @@
> This commit is best viewed with --color-moved.
>
> Signed-off-by: Stefan Beller
> - Signed-off-by: Junio C Hamano
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> --- a/merge-recursive.c
> 2: 2c02ece7e01 ! 2: eb43110df9d merge-recursive: i18n submodule merge out=
put and respect verbosity
> @@ -7,7 +7,6 @@
> internationalisation as well as the verbosity setting.
>
> Signed-off-by: Stefan Beller
> - Signed-off-by: Junio C Hamano
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> --- a/merge-recursive.c
> @@ -73,10 +72,10 @@
> - fprintf(stderr, "Found a possible merge resolution "
> - "for the submodule:\n");
> + output(o, 1, _("Failed to merge submodule %s (not fast-forward)"), path=
);
> -+ output(o, 1, _("Found a possible merge resolution for the submodule:\n=
"));
> ++ output(o, 2, _("Found a possible merge resolution for the submodule:\n=
"));
> print_commit((struct commit *) merges.objects[0].item);
> - fprintf(stderr,
> -+ output(o, 1, _(
> ++ output(o, 2, _(
> "If this is correct simply add it to the index "
> "for example\n"
> "by using:\n\n"
> -: ----------- > 3: 4a3bc435023 Inform about fast-forwarding of submodule=
s during merge
