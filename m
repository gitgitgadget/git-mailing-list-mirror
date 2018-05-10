Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F3FB1F406
	for <e@80x24.org>; Thu, 10 May 2018 16:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966187AbeEJQTD (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 12:19:03 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:42504 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966087AbeEJQTC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 12:19:02 -0400
Received: by mail-ua0-f194.google.com with SMTP id f3-v6so1682718uan.9
        for <git@vger.kernel.org>; Thu, 10 May 2018 09:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FSuAgiC328HsqJe+zcGnDWQi/2QERZSYo2RMogG9N9M=;
        b=jILcKKXHVzHlx9UayFH7nVWfGegkBVt81a4CiS0EfNfgibB/ehL+FRFTZaX0SrR3JP
         BNYrtzDiaTn7+jm/XVbVrJsM74klqe4+uPZd3Xts3FU2SA6QOT/yZAYahKat/QzgRSQr
         UIASOOcwCRdQfjs5uJw+yES1+VpOLZ75n3LiYWQape7FZIgt5TUd//vSUOh6l03hblrh
         XVf1CLHLVn8qhBQH70B+NInNEuK4JO3epZsuXkj7M4HRCJXn4B9IgeKrokvWC80wH3bM
         6h9Q1E/vLF8oMJZd3CzOfoyXJpi+53S05CLN2/tr1QWpRWRmLswP2ZJ3R/iPA7AvmfHm
         JEfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FSuAgiC328HsqJe+zcGnDWQi/2QERZSYo2RMogG9N9M=;
        b=Dqs0Oac8WYUdHh9Y+QdTZfxzGYn/jEUrIC9sfAbPzFrlBOVnlv3n2BMWqr4ylqe9mU
         SvWfM/uQ3xtusaLcwZ2/8IVGevTgf0JKjy+HqDcTjbJlswJ3b51WlZtCxOOu76jxzlJ/
         ZhB+1FUY/ELK7uE0105fNg6KYFUyxrvyYlHnHxUyD8vwEt9bqZC32+BIl5ByqQPRO+Rg
         Opc8t85HmMWFid+O5AERvK29k3tg7aGCTSjRP9LP3LAZ1om2/PXrsfgVn/iRD4Gi89p6
         UmGEwyT58Zkyj0+m+SUOIoyDKpfOLb4KnjiOaKb3uLMJQUqzmp4UWFYrKu7zBZ5iBswm
         hbjQ==
X-Gm-Message-State: ALKqPwcjXyXecHHHLla8jagXKQWPtJr77Jri6XlUYvBYR6oIbHFvdv7U
        uNTntS7jbPZ0VX0LIgQ50Hm2MbRCupFfcrJ5MrQ=
X-Google-Smtp-Source: AB8JxZqXglKisAVcF1c9vyYW735ieepr34ED7A+NAHHxqaV4ozNhr4MabodddhZPbrtzpJwrMiYVDsUu62PTBBai5TU=
X-Received: by 2002:ab0:5a30:: with SMTP id l45-v6mr1529014uad.79.1525969141315;
 Thu, 10 May 2018 09:19:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Thu, 10 May 2018 09:19:00 -0700 (PDT)
In-Reply-To: <20180510141621.9668-1-benpeart@microsoft.com>
References: <20180509144213.18032-1-benpeart@microsoft.com> <20180510141621.9668-1-benpeart@microsoft.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 10 May 2018 09:19:00 -0700
Message-ID: <CABPp-BGE6RXv3ka8wGXruFjk3W=kDEDJ6zpH3t5=_CGSTONCHQ@mail.gmail.com>
Subject: Re: [PATCH v2] add status config and command line options for rename detection
To:     Ben Peart <Ben.Peart@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "vmiklos@frugalware.org" <vmiklos@frugalware.org>,
        Alejandro Pauly <alpauly@microsoft.com>,
        "Johannes.Schindelin@gmx.de" <Johannes.Schindelin@gmx.de>,
        "eckhard.s.maass@googlemail.com" <eckhard.s.maass@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ben,

On Thu, May 10, 2018 at 7:16 AM, Ben Peart <Ben.Peart@microsoft.com> wrote:
> After performing a merge that has conflicts, git status will by default attempt
> to detect renames which causes many objects to be examined.  In a virtualized
> repo, those objects do not exist locally so the rename logic triggers them to be
> fetched from the server. This results in the status call taking hours to
> complete on very large repos.  Even in a small repo (the GVFS repo) turning off
> break and rename detection has a significant impact:

It'd be nice if you could show that impact by comparing 'git status'
to 'git status --no-renames', for some repo.  Showing only the latter
gives us no way to assess the impact.

> git status --no-renames:
> 31 secs., 105 loose object downloads
>
> git status --no-breaks
> 7 secs., 17 loose object downloads
>
> git status --no-breaks --no-renames
> 1 sec., 1 loose object download

This patch doesn't add a --no-breaks option and it doesn't exist
previously, so adding it to the commit message serves to confuse
rather than help.  I'd just drop the last two of these (and redo the
timing for --no-renames assuming you are built on
em/status-rename-config).

> Add a new config status.renames setting to enable turning off rename detection
> during status.  This setting will default to the value of diff.renames.
>
> Add a new config status.renamelimit setting to to enable bounding the time spent
> finding out inexact renames during status.  This setting will default to the
> value of diff.renamelimit.

It may be worth mentioning that these config settings also affect 'git
commit' (and it does, in my testing, which I think is a good thing).

> Add status --no-renames command line option that enables overriding the config
> setting from the command line. Add --find-renames[=<n>] to enable detecting
> renames and optionally setting the similarity index from the command line.

The command line options are specific to 'git status'.  I don't really
have a strong opinion on whether they should also be added to
git-commit; I suspect users would be more likely to use the config
options in order to set it once and forget about it and that users
would be more likely to want to override their config setting for
status than for commit.

> Note: I removed the --no-breaks command line option from the original patch as
> it will no longer be needed once the default has been changed [1] to turn it off.
>
> [1] https://public-inbox.org/git/20180430093421.27551-2-eckhard.s.maass@gmail.com/

I'd just drop these lines from the commit message, and instead mention
that your patch depends on em/status-rename-config.

> Original-Patch-by: Alejandro Pauly <alpauly@microsoft.com>
> Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>
> ---
>
> Notes:
>     Base Ref: master

This patch does not apply to master; it has conflicts.

>     Web-Diff: https://github.com/benpeart/git/commit/823212725b

This web diff shows em/status-rename-config as the parent commit, not
master.  Since your commit message mentions you want the change to
break detection provided by that series, just listing it as the
explicit base seems like the right way to go.

>     ### Interdiff (v1..v2):

Thanks.

> +       if ((intptr_t)rename_score_arg != -1) {
> +               s.detect_rename = DIFF_DETECT_RENAME;

I'd still prefer this was a
        if (s.detect_rename < DIFF_DETECT_RENAME)
                s.detect_rename = DIFF_DETECT_RENAME;

If a user specifies they are willing to pay for copy detection, but
then just passes --find-renames=40% because they want to find more
renames, it seems odd to disable copy detection to me.

> +++ b/t/t7525-status-rename.sh

Testcases look good.  It'd be nice to also add a few testcases where
copy detection is turned on -- in particular, I'd like to see one with
--find-renames=$DIFFERENT_THAN_DEFAULT being passed when
merge.renames=copies.


> +test_expect_success 'setup' '
> +       echo 1 >original &&
> +       git add . &&
> +       git commit -m"Adding original file." &&
> +       mv original renamed &&
> +       echo 2 >> renamed &&
> +       git add .
> +'


> +cat >.gitignore <<\EOF
> +.gitignore
> +expect*
> +actual*
> +EOF

Can this just be included in the setup?


Everything else in the patch looked good to me.
