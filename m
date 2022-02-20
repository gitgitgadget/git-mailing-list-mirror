Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFFE5C433EF
	for <git@archiver.kernel.org>; Sun, 20 Feb 2022 22:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242815AbiBTWcN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Feb 2022 17:32:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242065AbiBTWcM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Feb 2022 17:32:12 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7583DE9A
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 14:31:49 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id r7so8565269iot.3
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 14:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cD+r4rFe7UeKri/8lrw7TgrlXa9c9Yyz/CQUfCB1Buo=;
        b=4b4IiUm0niSgHRBTpd9OSPuqMwmYatI8Lx/lXSDT7PiY2JSuReBV/9V0sJTRctoplZ
         eKULgEsTaBY65p6LakXurr+76Yl8Jcigaj/YNaBk7MZqYVkHjlaeHkaoqwkzUNHArREm
         P89XbsXJPqYfYX8YI9E6Fkka3lD7LknLHFn94XpzjxIpW/TUm6gmwBTkMiYXe1qIhStv
         33qgmWt5E62Ax+wAQ5mfuAbAqrG2wEnlvshOcSwS95rqwwwxKqGhzfhjH7reFg4GrM5U
         P8MrPqNgxMDiGgq9tY7mLC2dntbJ1/Of5t3a48ASEbW9EZcchShW1eAGcw38hp5Yn7qk
         zsfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cD+r4rFe7UeKri/8lrw7TgrlXa9c9Yyz/CQUfCB1Buo=;
        b=oQJIjLdOghGsMi6E45fLEJFaeFnmmA4ibmO/pA4+jolfKydq+saHyzss0fMRwj0Ikg
         bpzpPC3/kyOl8KpXrqwApxDsM1iV21nzZDjlAvg/NeOkekx5NTWMezRETogZpZnMe4e0
         XPz+N9b+u3A6Iqmg0L30HsXV6J5nknx0lwKmCWABVlbqKWm3qkS3jIkUpevKRLnlUarD
         WeWj3VfJJSKNF/CE52C7X/IQnl1s9JtfqT/ZuH4RcLVhhaQCKp55ZoJwApbV01wMmGzw
         czl6DLS8jhgau7whaqrZJcELtIKLwkqTmcEK0CBf1tlvJJYRpF5R1wVCoSxYT2ALZesV
         4sQQ==
X-Gm-Message-State: AOAM530kvdG4Qd62YN25JfvOejLUROuVXqdmhug40UFXoot7EsBwCmaj
        ZRUeRTqlBwr0c17CK7Y9ItN6LBJUpyY7TXOT
X-Google-Smtp-Source: ABdhPJwyyRX44ahrq28D0rALPUPakNBgc63YF9eQ8dw3whxp2SXPlwvB6lgL2/BVDtKz9e7U439x0w==
X-Received: by 2002:a5d:8508:0:b0:62f:1fc2:d5d2 with SMTP id q8-20020a5d8508000000b0062f1fc2d5d2mr13305403ion.13.1645396308844;
        Sun, 20 Feb 2022 14:31:48 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s15sm1410478ilq.66.2022.02.20.14.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 14:31:48 -0800 (PST)
Date:   Sun, 20 Feb 2022 17:31:48 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 09/11] worktree: use 'worktree' over 'working tree'
Message-ID: <YhLBVJ9guBF/9/A0@nand.local>
References: <pull.1154.git.1645379667.gitgitgadget@gmail.com>
 <23e74c87116175924bfc389eb07fa96b4040fa0d.1645379667.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <23e74c87116175924bfc389eb07fa96b4040fa0d.1645379667.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 20, 2022 at 05:54:25PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
>
> It is helpful to distinguish between a 'working tree' and a 'worktree'.
> A worktree contains a working tree plus additional metadata. This
> metadata includes per-worktree refs and worktree-specific config.
>
> This is the fifth of multiple changes to git-worktree.txt, restricted to
> the CONFIGURATION FILE section.
>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  Documentation/git-worktree.txt | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> index 54a2c335fd5..8821e56c6ec 100644
> --- a/Documentation/git-worktree.txt
> +++ b/Documentation/git-worktree.txt
> @@ -283,12 +283,12 @@ which will handle refs correctly.
>
>  CONFIGURATION FILE
>  ------------------
> -By default, the repository `config` file is shared across all working
> -trees. If the config variables `core.bare` or `core.worktree` are
> -present in the common config file and `extensions.worktreeConfig` is
> -disabled, then they will be applied to the main working tree only.
> +By default, the repository `config` file is shared across all worktrees.
> +If the config variables `core.bare` or `core.worktree` are present in the
> +common config file and `extensions.worktreeConfig` is disabled, then they
> +will be applied to the main worktree only.
>
> -In order to have configuration specific to working trees, you can turn
> +In order to have configuration specific to worktrees, you can turn

Also not the fault of this patch, but I wonder if this would be more
clearly worded as:

    In order to have worktree-specific configuration, you can [...].

>  on the `worktreeConfig` extension, e.g.:
>
>  ------------
> @@ -302,16 +302,16 @@ versions will refuse to access repositories with this extension.
>
>  Note that in this file, the exception for `core.bare` and `core.worktree`
>  is gone. If they exist in `$GIT_DIR/config`, you must move
> -them to the `config.worktree` of the main working tree. You may also
> -take this opportunity to review and move other configuration that you
> -do not want to share to all working trees:
> +them to the `config.worktree` of the main worktree. You may also take this
> +opportunity to review and move other configuration that you do not want to
> +share to all worktrees:
>
>   - `core.worktree` should never be shared.
>
>   - `core.bare` should not be shared if the value is `core.bare=true`.
>
> - - `core.sparseCheckout` is recommended per working tree, unless you
> -   are sure you always use sparse checkout for all working trees.
> + - `core.sparseCheckout` is recommended per worktree, unless you are sure
> +   you always use sparse checkout for all worktrees.

Another minor point, but perhaps the third bullet should share more
language with the first two. Maybe instead:

    - `core.sparseCheckout` should not be shared, unless you are sure
      you always use sparse checkout among all worktrees.

Feel free (in this instance, and in any others) to ignore these
suggestions. I wouldn't raise them in an ordinary review, but I figure
since we are already tweaking the language in this file, it couldn't
hurt to mention here...

Thanks,
Taylor
