Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 845C31F62E
	for <e@80x24.org>; Thu, 17 Jan 2019 10:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfAQKWk (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 05:22:40 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:43669 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbfAQKWk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 05:22:40 -0500
Received: by mail-io1-f66.google.com with SMTP id b23so7344155ios.10
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 02:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nk8NJWRRAlQDDp7RN8ZzOJNv0Ft1ovwTKdrM9PycTcE=;
        b=LMVs2R2KxmyOxZnSYQ2eJNzDKdHa5sHkaJ8oLY5agkSnQDegr2S90FCQRv0gq7UBg0
         kK0LWMWtuFOv3fnlkku0srtnV5+V0kH+dNm6IkGOcTFNn7ZrH7Qig2e1V7KwIcbfhbQp
         7G3YQyW/SnCfoTa373LNeemlj9qorUItFZ21auRchaHRel0Qy3wW2vlqzWOqZST5A/Yf
         JnR4m95voo/9gnVuYpL5xE9mAHMVmr295Qz52kstGj/mE+3aVkGz+pYtTPGglrRsTh7h
         uswH6eWKUmBQre3c4mB5NwkC5JMYA7pYp02+oPaBnDqS3bUw1P1B9mapOWxRwJYwazEk
         NyoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nk8NJWRRAlQDDp7RN8ZzOJNv0Ft1ovwTKdrM9PycTcE=;
        b=erifgYeDEwAKQYPclNT0p1aV9f4zGheNw3iBx1Tdvh1PRg2XGjNmizl+rt/5dKWZRV
         cbQ89vxS+3ThloVXP7JbY0IGy7FwxkY66td4k7jOtMnN9H96XfQTVobgeyGLhMQzgimu
         /bv1+h/s3OmPpALVSdQwEGvKb01vhaw41Er/dqoNe6E7HiG1c8xyd4kmC5h0ZWReHZ8l
         Wj1tfGv3KqQyVlchnNHAQgzP/aUyd7oLWlEBF9WHwk6fTjCA7nHSN4FGcLLGGllT9X2Z
         SYjuGqU2Qs5Qf+gXLwGH54v5WGVwRsApfprbpbge52Co0HCaeujVBBN5M+2O6WOb4Fu2
         6bpg==
X-Gm-Message-State: AJcUukca4OgEsNZYMyZt/25XV9O3TNqzutqDNok1lpj52Hvw/5rR7akD
        5GKXUlHeiKMvgWYwTGi3lTqwn9mHH4HBXlYYUgA=
X-Google-Smtp-Source: ALg8bN7/P74us/ei/GvbY+dx0N+JJUzJlmx5LJyAV30AHuKd8n8h/F84cTD2RLafiERjORVt9PfuBeGIaO1GBjAa3sI=
X-Received: by 2002:a6b:c544:: with SMTP id v65mr7309828iof.118.1547720558883;
 Thu, 17 Jan 2019 02:22:38 -0800 (PST)
MIME-Version: 1.0
References: <20190116103159.9305-1-pclouds@gmail.com> <20190116103159.9305-2-pclouds@gmail.com>
 <CAGZ79kYWi0EDr-XvoXm=-Oo-_9FiieNHbWzA5o8TiirLw+xXBg@mail.gmail.com>
In-Reply-To: <CAGZ79kYWi0EDr-XvoXm=-Oo-_9FiieNHbWzA5o8TiirLw+xXBg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 17 Jan 2019 17:22:12 +0700
Message-ID: <CACsJy8DV=BF44j8Eu01At1fwD2FH9ANa+7g66xn82du3yhQJKA@mail.gmail.com>
Subject: Re: [PATCH 01/10] doc: about submodule support with multiple worktrees
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>,
        =?UTF-8?Q?Tomasz_=C5=9Aniatowski?= <tsniatowski@vewd.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Marc Branchaud <marcnarc@xiplink.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 17, 2019 at 5:06 AM Stefan Beller <sbeller@google.com> wrote:
> > clones from $GIT_COMMON_DIR/worktrees/X/modules to
> > $GIT_COMMON_DIR/common/modules.
>
> ... from the submodule side of things this is big problem,
> as the submodule is usually assumed at $GIT_DIR/modules/<name>
> (I think we have not been strict in $GIT_DIR $GIT_COMMON_DIR
> in the submodule code)
>
> So the plan is to neither use
>
> $GIT_COMMON_DIR/worktrees/X/modules/Y
> $GIT_COMMON_DIR/modules/Y/worktrees/X
>
> but to create a new third location at
>
> $GIT_COMMON_DIR/common/modules
>
> to which either new submodule worktrees
> or superproject worktrees that happen to have this submodule
> can point to?

Yes. And this is yet another "absorb" operation to move from the
current location to the new one. The code will have to check both
places, just as it has to check if "foo/bar/.git" is a real repo
before it goes to $GIT_DIR/.git/modules/bar (at least this is how I
understand it).

> > The latter directory is shared across all worktrees. Once we keep the
> > clone in a common place, the submodule's worktree can be created and
> > managed with git-worktree[1].
>
> So even when the user has never heard of worktrees, the internal structure
> will be worktree oriented, the common dir in common/modules/Y and in
> $GIT_DIR/modules/Y we could just have a worktree git dir?

I think the .git dir will be in common/modules/Y. $GIT_DIR/modules/Y
is basically replaced by $GIT_COMMON_DIR/common/modules/Y, which
should work even when you don't use git-worktree (in single-worktree
setting, $GIT_COMMON_DIR == $GIT_DIR).
-- 
Duy
