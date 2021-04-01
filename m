Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D571FC433ED
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 20:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA08B610CF
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 20:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234744AbhDAUCi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Apr 2021 16:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234194AbhDAUCi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Apr 2021 16:02:38 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A9DC0613E6
        for <git@vger.kernel.org>; Thu,  1 Apr 2021 13:02:37 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id y1so3487461ljm.10
        for <git@vger.kernel.org>; Thu, 01 Apr 2021 13:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k5QFK8W25UrsuUwsYaWq9m2hzmquVwanJoDIEBnpHFU=;
        b=hBVVM/5SVlnMvajR0YPFU7xQJ+WvbFlEbqYc6kvblFyIzn17lyqYIBhI/+XxYLjVTI
         sZk2z+783C6u7Yt7rggQ8S8VqdbluRK+ilVCamCpoYV7mS9UnJwca1m6crPXGHuhHIFf
         CyYG6pMLIY9Mn4cO+R4/LoAUKueCi4Fm12NYpN+kha2WYb2WxeqszX/IBfY0zWGwejV1
         C4xyNE988vRIkVyvhCsFSHzRa+jMB3+ExJka+D39TBf74iDgknmWPeWk1fJy4bKJ1nMu
         4FqPVnbffata3ICdCox3vDffBWOerki5IGYL7a3y6zBohiliBOeKNryd5j+34HAIRhnX
         01Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k5QFK8W25UrsuUwsYaWq9m2hzmquVwanJoDIEBnpHFU=;
        b=Blr9GvAbkp5uV3ZDkXpes0sEoIMUWNRHHq4FFCv1WMJYdP1TOtQNGPR1hAefl4+EWv
         SeIC5vZNLWIdiQMnnjNgSipelg6vwQp64VJ/MYuvaJihHQPJg0hk6A/UXPw2kB5wlic/
         1s1gpFhBME6rqdhQ+QAJF41odGjtU0zaSKDlR/r0L6jZHcAbgmudyHay8BahVLl9FBo+
         8y0D5DW56kZRD5X1cFXTfxYszUAgz0oN+0FaKRMy8XfBpSAEwsTk2B1LZHiB5002Xj1V
         qu9jq3IZm2cundDXYjT9zEBCj/saX8600mDdRFy2L3B1SVSYIxEJG0EsiYWilM6TNado
         1Bnw==
X-Gm-Message-State: AOAM531JJMiKJkKMzo7ISkf8y5MGzT2IFfxNfzGBXk/gv7Avu/idodRz
        4ox8YefeaTiOMjgxVXEMLMaDjttTWa6ufjHDFIM=
X-Google-Smtp-Source: ABdhPJx5niBqxBQQzlb81LPCb4gz2OMX1YPt6aB++E2gj0VqUU7qjLDky7WF7jyfLnm52JXZDul1qKYoN0Kk20Mc4N8=
X-Received: by 2002:a2e:9148:: with SMTP id q8mr6235086ljg.356.1617307356221;
 Thu, 01 Apr 2021 13:02:36 -0700 (PDT)
MIME-Version: 1.0
References: <pull.908.git.1616105016055.gitgitgadget@gmail.com>
 <pull.908.v2.git.1616723016659.gitgitgadget@gmail.com> <YGJgw5QPKFyv4HSG@google.com>
In-Reply-To: <YGJgw5QPKFyv4HSG@google.com>
From:   Albert Cui <albertqcui@gmail.com>
Date:   Thu, 1 Apr 2021 13:02:24 -0700
Message-ID: <CAMbkP-T4xUNb2SyXPic_XcJXUNGa2kKTADdTJ45-e+rw8aNa5g@mail.gmail.com>
Subject: Re: [PATCH v2] hooks: propose project configured hooks
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Albert Cui via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 29, 2021 at 4:20 PM Emily Shaffer <emilyshaffer@google.com> wrote:
>
> > +Security Considerations and Design Principles
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> [snip]
> > +  ** Since developers will likely build their local clone in their development
> > +  process, at some point, arbitrary code from the repository will be executed.
> > +  In this sense, hooks _with user consent_ do not introduce a new attack surface.
>
> It might be worth saying that we want to make configuration of
> project-configured hooks to be approximately as easy/automatic as
> building (that is, the user still has to explicitly run a build, and
> isn't prompted at the end of their clone whether they want to build it
> right away).

+1, I like phrasing it this way.
> > +
> > +* Give users visibility: Git must allow users to make informed decisions. This
> > +means surfacing essential information to the user in a visible manner e.g. what
> > +remotes the hooks are coming from, whether the hooks have changed in the latest
> > +checkout.
>    ^~~~~~~~
> Better say "fetch", if we are proposing this magic branch thing.
>
> > +* This configuration should only apply if it was received over HTTPS
>
> Meaning, non-HTTPS fetches should just not update this special branch?

Yes, though I erroneously forgot to include SSH as well. I think the
main issue is
person-in-the-middle type attacks.

> > +* A setup command for users to set up hooks
> AIUI, this is proposed to be part of `git hook`, right?
>
> I don't think it needs to be part of this doc but it'd be nice to also
> support installing just a subset, like:
>
>   git hook setup pre-commit
>   git hook setup --interactive
>
Correct, I think `git hook` is a natural evolution. This is a nice to
have that we can document.

>
> > +Fast Follows
> > +^^^^^^^^^^^^
> > +
> > +* When prompted to execute a hook, users can specify always or never, even if
> > +the hook updates
>
> I think we want to base this on the remote URL, right? I know we talked
> a little offline about how to mitigate vs. malicious maintainer (for
> example this whole mess with The Great Suspender) and I'm not sure what
> solution there might be.
>
> I wonder if it's worth it to notify users that their always-okayed hooks
> were updated during fetch?
>
It definitely aligns with the security principles to notify, even if
they have OK'd updates.

> > +Implementation Exploration: Check "magic" branch for configs at fetch time
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +Example User Experience
> > +^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > +===== Case 1: Consent through clone
> > +
> > +....
> > +$ git clone --setup-hooks
> > +...
> > +
> > +The following hooks were installed from remote `origin` ($ORIGIN_URL):
> > +
> > +pre-commit: git-secrets --pre_commit_hook
> > +pre-push:  $GIT_ROOT/pre_push.sh
>
> Hm, I thought we wanted to consider storing the hook body in the magic
> branch as well? To avoid changing hook implementation during bisect, for
> example?
>

Good question. If we consider this as an extension of config-based
hooks, then I think
it's logical to still support hooks in the repo itself. In
documentation, we might suggest
that people who want to use this feature store the hook in the magic
branch for that
reason.
