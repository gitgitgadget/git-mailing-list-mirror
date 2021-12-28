Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DBDC433EF
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 17:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236699AbhL1RrW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 12:47:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233463AbhL1RrV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 12:47:21 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8A5C061574
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 09:47:21 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id z29so76582143edl.7
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 09:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f2ug+EMi3igLkOf6hfp6fMpCWjwKrOmv/FZ8Ng0oO1A=;
        b=VOrg4bIIDMLIV/C3J2tuIlLaIHRfd32s5dLc4JJaCwXocEDJtov5aR3w7hyBQ/pmNG
         BGJqga2SmvIkV85e2ZGRzV3Yo92Vqz+JnOFJzBUEl84VYkfJIpBjDd2+u3giuxKG+XNC
         BBgWTbXtkXmKX283kgG4ZxPCKanorcKnaKV1faBgIME5eYtNhzA8p/GZdtSTXgBEK/el
         NQtbeTwQGEGY9/yIr+5wO9rA8e6edtx45wpm9lOFZcHsSGgoFoDdzWFK2ufSNZaxxfig
         99CRRPxP+cQS7qdP2OHWKwyOATVKiTwixKFrxPQJz1GOOM8p9G8ts/QJP18PO1lByLgy
         d1Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f2ug+EMi3igLkOf6hfp6fMpCWjwKrOmv/FZ8Ng0oO1A=;
        b=mqSLiEsdOAsxzLC/zU4VxrOZVXtzA+M25G/R7P8wsTkGPERMzyEAd05M2PanPcjXfb
         mbckxSLgmvx6BUGCXrqZ+XWC4GAVtmFNRM7SPqFuCXzmDlhgHp4/+vAJIxm41JY/Y22r
         mB9xxS8tkM/yPWnACBkk60kGn8z69rkLIXnggWacMqOb7bTkS48el3/bOZRH28xLw2Rs
         tL0kOyYH8/gB299ydNhw+XW8v+usbtpEc1zJdfXlMI6axOBi6ex7ieeLJyMoNS7tmChE
         1+HlAML5k/Qma2LMkqMkPqpefeAlJ+LAnZpat4ajm3aiSLHq2I9MK2WkoQ1pCHY+hiAu
         Jm3w==
X-Gm-Message-State: AOAM533O5u8LvCVBkSSx2Y7wO4nPDFtt71cmWBSmscc81FtWDA6qjgdl
        /SoQNrxzQm+6wC7Zkcd6dMfklBnFs3yXDUShWz8=
X-Google-Smtp-Source: ABdhPJynRmco+gkqHJXoTxSWrZe5dZrUCZf4wQFZEJ5CycR8LYI0zvMFAEPSVIh1Msm8RKPJeX2gHHE9XjfpfWtMEPY=
X-Received: by 2002:a17:907:60c8:: with SMTP id hv8mr17951597ejc.192.1640713639846;
 Tue, 28 Dec 2021 09:47:19 -0800 (PST)
MIME-Version: 1.0
References: <xmqqa6izcwio.fsf_-_@gitster.g> <xmqq5yre7w5o.fsf@gitster.g>
In-Reply-To: <xmqq5yre7w5o.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 28 Dec 2021 09:47:08 -0800
Message-ID: <CABPp-BFp=UnK=EEmr4GLp4m3e9pZ1yks0gt6yTk5OcNXD3LNKA@mail.gmail.com>
Subject: Re: [PATCH v2] SubmittingPatchs: clarify choice of base and testing
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Fabian Stelzer <fs@gigacodes.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 24, 2021 at 5:25 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> We encourage identifying what, among many topics on `next`, exact
> topics a new work depends on, instead of building directly on
> `next`.  Let's clarify this in the documentation.
>
> Developers should know what they are building on top of, and be
> aware of which part of the system is currently being worked on.
> Encouraging them to make trial merges to `next` and `seen`
> themselves will incentivize them to read others' changes and
> understand them, eventually helping the developers to coordinate
> among themselves and reviewing each others' changes.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/SubmittingPatches | 53 ++++++++++++++++++++++++++++++-----------
>  1 file changed, 39 insertions(+), 14 deletions(-)
>
>  * I've been trying to clear the deck, and noticed that this has
>    been untended for quite some time.  With some clarification to
>    a place I was even confused myself while responding to Fabian's
>    comments in the earlier round.
>
> diff --git c/Documentation/SubmittingPatches w/Documentation/SubmittingPatches
> index e409022d93..3c4c5d9f18 100644
> --- c/Documentation/SubmittingPatches
> +++ w/Documentation/SubmittingPatches
> @@ -19,8 +19,10 @@ change is relevant to.
>    base your work on the tip of the topic.
>
>  * A new feature should be based on `master` in general. If the new
> -  feature depends on a topic that is in `seen`, but not in `master`,
> -  base your work on the tip of that topic.
> +  feature depends on other topics that are in `next`, but not in
> +  `master`, fork a branch from the tip of `master`, merge these topics
> +  to the branch, and work on that branch.  You can remind yourself of
> +  how you prepared the base with `git log --first-parent master..`.
>
>  * Corrections and enhancements to a topic not yet in `master` should
>    be based on the tip of that topic. If the topic has not been merged
> @@ -28,10 +30,10 @@ change is relevant to.
>    into the series.
>
>  * In the exceptional case that a new feature depends on several topics
> -  not in `master`, start working on `next` or `seen` privately and send
> -  out patches for discussion. Before the final merge, you may have to
> -  wait until some of the dependent topics graduate to `master`, and
> -  rebase your work.
> +  not in `master`, start working on `next` or `seen` privately and
> +  send out patches only for discussion. Once your new feature starts
> +  to stabilize, you would have to rebase it (see the "depends on other
> +  topics" above).
>
>  * Some parts of the system have dedicated maintainers with their own
>    repositories (see the section "Subsystems" below).  Changes to
> @@ -71,8 +73,13 @@ Make sure that you have tests for the bug you are fixing.  See
>  [[tests]]
>  When adding a new feature, make sure that you have new tests to show
>  the feature triggers the new behavior when it should, and to show the
> -feature does not trigger when it shouldn't.  After any code change, make
> -sure that the entire test suite passes.
> +feature does not trigger when it shouldn't.  After any code change,
> +make sure that the entire test suite passes.  When fixing a bug, make
> +sure you have new tests that breaks if somebody else breaks what you
> +fixed by accident to avoid regression.  Also, try merging your work to
> +'next' and 'seen' and make sure the tests still pass; topics by others
> +that are still in flight may have unexpected interactions with what
> +you are trying to do in your topic.
>
>  Pushing to a fork of https://github.com/git/git will use their CI
>  integration to test your changes on Linux, Mac and Windows. See the
> @@ -144,8 +151,21 @@ without external resources. Instead of giving a URL to a mailing list
>  archive, summarize the relevant points of the discussion.
>
>  [[commit-reference]]
> -If you want to reference a previous commit in the history of a stable
> -branch, use the format "abbreviated hash (subject, date)", like this:
> +
> +There are a few reasons why you may want to refer to another commit in
> +the "more stable" part of the history (i.e. on branches like `maint`,
> +`master`, and `next`):
> +
> +. A commit that introduced the root cause of a bug you are fixing.
> +
> +. A commit that introduced a feature that is what you are enhancing.
> +
> +. A commit that conflicts with your work when you made a trial merge
> +  of your work into `next` and `seen` for testing.
> +
> +When you reference a commit on a more stable branch (like `master`,
> +`maint` and `next`), use the format "abbreviated hash (subject,
> +date)", like this:

I was going to comment that this would be a good place to mention
--pretty=reference, but looking at the file in question, that is
exactly what the text after this already does.

>  ....
>         Commit f86a374 (pack-bitmap.c: fix a memleak, 2015-03-30)
> @@ -259,9 +279,11 @@ Please make sure your patch does not add commented out debugging code,
>  or include any extra files which do not relate to what your patch
>  is trying to achieve. Make sure to review
>  your patch after generating it, to ensure accuracy.  Before
> -sending out, please make sure it cleanly applies to the `master`
> -branch head.  If you are preparing a work based on "next" branch,
> -that is fine, but please mark it as such.
> +sending out, please make sure it cleanly applies to the base you
> +have chosen in the "Decide what to base your work on" section,
> +and unless it targets the `master` branch (which is the default),
> +mark your patches as such.
> +
>
>  [[send-patches]]
>  === Sending your patches.
> @@ -365,7 +387,10 @@ Security mailing list{security-ml-ref}.
>  Send your patch with "To:" set to the mailing list, with "cc:" listing
>  people who are involved in the area you are touching (the `git
>  contacts` command in `contrib/contacts/` can help to
> -identify them), to solicit comments and reviews.
> +identify them), to solicit comments and reviews.  Also, when you made
> +trial merges of your topic to `next` and `seen`, you may have noticed
> +work by others conflicting with your changes.  There is a good possibility
> +that these people may know the area you are touching well.
>
>  :current-maintainer: footnote:[The current maintainer: gitster@pobox.com]
>  :git-ml: footnote:[The mailing list: git@vger.kernel.org]

This patch looks good to me.
