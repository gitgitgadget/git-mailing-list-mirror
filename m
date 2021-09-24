Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED840C433FE
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 11:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D822D610F7
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 11:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239961AbhIXLtl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 07:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343693AbhIXLtb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 07:49:31 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBF7C061764
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 04:47:56 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id e15so39290043lfr.10
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 04:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=euewuloKFSznvQ6KCerzI1qeSBk5XFvc8AwefOtFX7I=;
        b=MNSYFBu8RPbriUINL3g7bjjj2JmnAO+tuhmTFO0/E7zwxpvxaUn33imhBwfjTgBGHM
         C/KRtJj747xO59u06EHNNUEFi+keqivbQ9gKTrNtc9iFwiXoKo92ung4q+ggpalvgDPB
         d0/zxT8gvQ4tdp0nSKNkmpRQj1/yJO+OR9JCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=euewuloKFSznvQ6KCerzI1qeSBk5XFvc8AwefOtFX7I=;
        b=nXVR7c8HbSv1eChtu/5CxZjKkX1QtQT3d09AQ4FdM8x3/dhH+JZVRFDBOb/j/GgWs9
         Xb3SFXPoQfNtNWN5wdxiAxD1raxBlV9B4UypmppkXNyhpUh7nDZ84RVsyWSBni54rKnV
         HWKiGU8XFY6RUMEDTBEWOoQUnwZ8LznjXar5UZmujB7rarJJNGa5lL+NqTHBkqsB+sHQ
         HXceYVUDx5PPOOG4spDVpi/n+MfGLHQBAPm1jzJAXX44HxVfYnMmr/n0T5Vq+81r70X3
         1fAyi4gDa86D7MukT4cyuCtWuF6BDBxoLMr3D/q2rfeLezd5lSk4lYWK+R/jOfB9S8GU
         x10A==
X-Gm-Message-State: AOAM531fAgv5KsOOzhbsnrotp0GmPkrpDT6JjeJ3prkE/cN95brzT2Z3
        vKdJC8HeqqK7rwWeHn66QD9BEakvX/23X8fMoP9FcLSCNe5HZrqP
X-Google-Smtp-Source: ABdhPJwLUfu/1Hi7inaEwbd/Q6KVpkyqh5JnHh2SERPYPweOwcIc8VTGZ0Rf/I3CLhllLEx52m2N9p9FzICQlqPQ400=
X-Received: by 2002:a05:6512:690:: with SMTP id t16mr9653901lfe.316.1632484075232;
 Fri, 24 Sep 2021 04:47:55 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1036.git.1632006923.gitgitgadget@gmail.com> <60c5d6b4615a6ac4179ec6c10e17cca480bc147a.1632006924.git.gitgitgadget@gmail.com>
In-Reply-To: <60c5d6b4615a6ac4179ec6c10e17cca480bc147a.1632006924.git.gitgitgadget@gmail.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Fri, 24 Sep 2021 12:47:43 +0100
Message-ID: <CAE5ih79bzExNrp__GAUaVZWvMucYDrvSHSJe_+dNyeVR3VXynw@mail.gmail.com>
Subject: Re: [PATCH 5/6] Comment important codepaths regarding nuking
 untracked files/dirs
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Users <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Fedor Biryukov <fedor.birjukov@gmail.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 19 Sept 2021 at 00:15, Elijah Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Elijah Newren <newren@gmail.com>
>
> In the last few commits we focused on code in unpack-trees.c that
> mistakenly removed untracked files or directories.  There may be more of
> those, but in this commit we change our focus: callers of toplevel
> commands that are expected to remove untracked files or directories.
>
> As noted previously, we have toplevel commands that are expected to
> delete untracked files such as 'read-tree --reset', 'reset --hard', and
> 'checkout --force'.  However, that does not mean that other highlevel
> commands that happen to call these other commands thought about or
> conveyed to users the possibility that untracked files could be removed.
> Audit the code for such callsites, and add comments near existing
> callsites to mention whether these are safe or not.
>
> My auditing is somewhat incomplete, though; it skipped several cases:
>   * git-rebase--preserve-merges.sh: is in the process of being
>     deprecated/removed, so I won't leave a note that there are
>     likely more bugs in that script.
>   * contrib/git-new-workdir: why is the -f flag being used in a new
>     empty directory??  It shouldn't hurt, but it seems useless.
>   * git-p4.py: Don't see why -f is needed for a new dir (maybe it's
>     not and is just superfluous), but I'm not at all familiar with
>     the p4 stuff

Assuming you're talking about this code in git-p4.py:

            print("Synchronizing p4 checkout...")
            if new_client_dir:
                # old one was destroyed, and maybe nobody told p4
                p4_sync("...", "-f")
            else:
                p4_sync("...")

This is doing a Perforce sync in the P4 repo, not the git repo.

In the usual/happy case, this directory already exists, the Perforce
server knows about its state, and a normal "p4 sync ..." will bring it
up to date.

But, if someone manually deleted the directory then "p4 sync ..." will
only update modified files, and all sorts of things will then go wrong
(e.g. the files we updated in the git view won't be present, and
git-p4 will fall flat on its face).

So in this case, do a forced sync, which syncs everything ignoring the
P4 server's idea of what files are/not present.

Luke
