Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2739C5479D
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 04:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235078AbjAIEtD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Jan 2023 23:49:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjAIEs7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jan 2023 23:48:59 -0500
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718A51EF
        for <git@vger.kernel.org>; Sun,  8 Jan 2023 20:48:58 -0800 (PST)
Received: by mail-pj1-f53.google.com with SMTP id c8-20020a17090a4d0800b00225c3614161so11538041pjg.5
        for <git@vger.kernel.org>; Sun, 08 Jan 2023 20:48:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tsen2O5Y9gpALBfRpomjwlMQ0gb74SvgS7y/z/YbRHQ=;
        b=rTUvOwcHkvGiljQwdQqOLjPlE8tLgrNLy8yi+uEXryO2jSOLQHGctWydFR//xrfWzw
         ERT11ZzCuGXgWlkx0mXWix4LKx5lDYfXwW64fhHfBCqlFYkYQDe5/R5Z2seEKblT3us0
         YF7wVK+GMc771Dh8iW3z3YzRJwERBZ1YsqYbXsWEcJMM2oQxbqLP5aM0ThLGdSeEufrv
         /+X97Y03KWnyiESWnnD/SCGRx4PDpdS2DzlT2C8talCDXDNQefxz81qiqCgESTOnR4zr
         pNGY1tYqHxX5XpG+uLlMVt9ri5/btbkmC2klfTfnTdZggBQ6gDWMgnPVm+yN6ft9ks8+
         bKog==
X-Gm-Message-State: AFqh2kot0AnNvc5dWIv/uLEMewJ+47vgk/5NllZLoF7y2VWJqAK+TOy0
        uLqg8uHpzijMDSgZKyXwxyxWTiyx+hIz1O4lmk0=
X-Google-Smtp-Source: AMrXdXtFbVChtnlJVzYu43E8XXQ6Bz2rSqEgYD2mSmoL6qLNpVpwh8JvRJCSRquP9EyR21m391p+grp3jioQL4nJcZM=
X-Received: by 2002:a17:902:cf08:b0:191:34ee:a3fc with SMTP id
 i8-20020a170902cf0800b0019134eea3fcmr4335924plg.12.1673239737822; Sun, 08 Jan
 2023 20:48:57 -0800 (PST)
MIME-Version: 1.0
References: <pull.1422.git.git.1673166241185.gitgitgadget@gmail.com> <xmqqbkn8wcqo.fsf@gitster.g>
In-Reply-To: <xmqqbkn8wcqo.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 8 Jan 2023 23:48:46 -0500
Message-ID: <CAPig+cQe_VMW2KV+ZyZwosFw07Q+hePryDVushRJ-jFfD4yzpw@mail.gmail.com>
Subject: Re: [PATCH] doc: use "git switch -c" rather than "git checkout -b" consistently
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Yutaro Ohno via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Yutaro Ohno <yutaro.ono.418@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 8, 2023 at 11:36 PM Junio C Hamano <gitster@pobox.com> wrote:
> > From: Yutaro Ohno <yutaro.ono.418@gmail.com>
> > Subject: Re: [PATCH] doc: use "git switch -c" rather than "git checkout -b" consistently
>
> Hmph.  When two things work equally well, is it a good idea to
> describe only one "consistently", or mention both that can be used
> pretty much interchangeably in different places?  I am not 100% sure
> "consistently" is a good thing here.
>
> Thoughts from others?

Perhaps if the patch was sold as filling in a gap left by 328c6cb853
(doc: promote "git switch", 2019-03-29) it would be more palatable.

It does feel a bit strange that within the git-checkout documentation,
this patch is replacing an example invocation of git-checkout with an
invocation of git-switch. However, as the list of commands the patch
touches is given merely as examples one might use, then I could see
git-switch being prepended to the list rather than entirely replacing
git-checkout. For instance:

    If we have not yet moved away from commit `f`,
    any of these will create a reference to it:

    ------------
    $ git switch -c foo     <1>
    $ git checkout -b foo   <1>
    $ git branch foo        <2>
    $ git tag foo           <3>
    ------------
