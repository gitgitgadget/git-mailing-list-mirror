Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3515FC433EF
	for <git@archiver.kernel.org>; Sun, 20 Feb 2022 22:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243751AbiBTWhh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Feb 2022 17:37:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbiBTWhh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Feb 2022 17:37:37 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B36F40A27
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 14:37:15 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id 195so3779450iou.0
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 14:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s4eF32V4L7XafqH+00PItQNdI9rL7SGS5/ImA9GG+Og=;
        b=Juo1zpvTSZ9CwfVc8eVbjD5YkmQWKMzYQizsbdb90tT5jEZNGkkQa1csMvsvj9bEz3
         t+rgDK4lqVZHF/qsEcU77HlktaOQc/brxSauepz8KJBNsAb5tRCQPhQg+aJvLQz39Z7b
         Yl+SeGMJYeOy+VcFDZQqz2GtjAq9gKNaKQDp2wvHYqNYIcCn8KvsEn/KfFwO9Jijv1AF
         vyjWmLA7aMAgbaHxl+Gd6OwZu7YW+I2i4XoH3YHsoURs0MhGOkRUlyjFL416dxguFQng
         f0ehK4bGURz5a4Fekrrp0w/JSr6b+e/X2cZXvKWLro15MP3iNcsHK7HLzCnmulpLy7kV
         jwPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s4eF32V4L7XafqH+00PItQNdI9rL7SGS5/ImA9GG+Og=;
        b=jvP29qny9R/xXuGA0Y3NLTwdES/ic0L3aKa4AY8WowoMR7K24m8TmuwCgZnfIqkwZ2
         WzbbMRRhhJukwWWGbX4n9osrlLv7t9Kt75TgxfhmTkxTyrAv99/rON9nlr9h3KSkUmt6
         8byxLcaOTyruORxkcxlHBlYlSVYAtV/VhSHwBYPNR0DGgB/d2fu4WHmMbBhY7vxh8PR6
         apBNWCfEldjOyw8JsvsogPQHTXojNZDBNoxYtQ/Usz2bkPqYSZQ3v1S1cdofknlIYcpv
         gry5C0PuoFAqNcEO1bIp6L+rY8NHzvNZggM6frpRsLbyhufgERIIKD8MQSg3GGwDOb8j
         wybg==
X-Gm-Message-State: AOAM530FfIzVaUI7jYZHXOJsQHmiRKG9BBqMfJE1/v2iBIwwgiH85Fpg
        +/eShaxcqLRln6RybYVrEcSQWViZSXHVBssL
X-Google-Smtp-Source: ABdhPJxSJ6PJfHuz2b37dvZAfWMDhxy/x/PTDr8RAa51agclDucfKflhK4x85KsgAoMpXfUX4loEJw==
X-Received: by 2002:a02:aa85:0:b0:314:c152:4c89 with SMTP id u5-20020a02aa85000000b00314c1524c89mr6915818jai.93.1645396634771;
        Sun, 20 Feb 2022 14:37:14 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i6sm1532457ioj.46.2022.02.20.14.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 14:37:13 -0800 (PST)
Date:   Sun, 20 Feb 2022 17:37:13 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 11/11] worktree: use 'worktree' over 'working tree'
Message-ID: <YhLCmWlmf+9MbECN@nand.local>
References: <pull.1154.git.1645379667.gitgitgadget@gmail.com>
 <91773337675b05b0c0e323211899c64d5b8102e6.1645379667.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <91773337675b05b0c0e323211899c64d5b8102e6.1645379667.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 20, 2022 at 05:54:27PM +0000, Derrick Stolee via GitGitGadget wrote:
> @@ -404,14 +404,14 @@ $ git worktree list --verbose
>  /path/to/linked-worktree              abcd1234 [master]
>  /path/to/locked-worktree-no-reason    abcd5678 (detached HEAD) locked
>  /path/to/locked-worktree-with-reason  1234abcd (brancha)
> -	locked: working tree path is mounted on a portable device
> +	locked: worktree path is mounted on a portable device

I thought this might have been an over-zealous find-and-replace, since I
had assumed that the "locked: working tree path ..." message came from
Git. But my assumption was wrong, and this is the `<reason>` in `git
worktree --reason=<reason> <worktree>`.

So it makes sense to update here along with the rest of these other
instances.

>  /path/to/prunable-worktree            5678abc1 (detached HEAD)
>  	prunable: gitdir file points to non-existent location
>  ------------
>
>  Note that the annotation is moved to the next line if the additional
>  information is available, otherwise it stays on the same line as the
> -working tree itself.
> +worktree itself.
>
>  Porcelain Format
>  ~~~~~~~~~~~~~~~~
> @@ -420,7 +420,7 @@ label and value separated by a single space.  Boolean attributes (like `bare`
>  and `detached`) are listed as a label only, and are present only
>  if the value is true.  Some attributes (like `locked`) can be listed as a label
>  only or with a value depending upon whether a reason is available.  The first
> -attribute of a working tree is always `worktree`, an empty line indicates the
> +attribute of a worktree is always `worktree`, an empty line indicates the
>  end of the record.  For example:
>
>  ------------
> @@ -470,9 +470,9 @@ EXAMPLES
>  You are in the middle of a refactoring session and your boss comes in and
>  demands that you fix something immediately. You might typically use
>  linkgit:git-stash[1] to store your changes away temporarily, however, your
> -working tree is in such a state of disarray (with new, moved, and removed
> +worktree is in such a state of disarray (with new, moved, and removed

This one should probably remain as "working tree", since the example
being given here is focused on disarray in the working tree itself, not
in the worktree's metadata.

>  files, and other bits and pieces strewn around) that you don't want to risk
> -disturbing any of it. Instead, you create a temporary linked working tree to
> +disturbing any of it. Instead, you create a temporary linked worktree to
>  make the emergency fix, remove it when done, and then resume your earlier
>  refactoring session.

But this one is in the context of "create a _worktree_", which makes
sense and should probably be updated as you have done here.

Thanks,
Taylor
