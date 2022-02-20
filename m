Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B92C433EF
	for <git@archiver.kernel.org>; Sun, 20 Feb 2022 22:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242065AbiBTW3d (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Feb 2022 17:29:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbiBTW3c (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Feb 2022 17:29:32 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6789C4B871
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 14:29:09 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id t11so8196148ioi.7
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 14:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mKed+O2WU9TlAp0Vl7QpzMkS66i7MEYNM+q9xkeyVBo=;
        b=dd21mMG63o6ZmHre2zvrmmhBzKiecOT7+tv66XDmarGGvgCe65vQg1aT+iqB1zZlBb
         19pnOz4ijyq0OYEImFB8zDKFa997/1zGbA27yxVIigeTcPOHOc+o/w1O9vJ5vRzUk/zF
         HVSCKWTnaPNKJyxmM2itvZXkErp8q2NvUUy7QkgfAq/C35JBBdBJnb/McAX+OlFwO198
         cFtMmtcW5L08YxKMqpIkaRGnrmL80LjzoFvsvMquK6BI0Ww2fe1rPL7aVqjC1H/PTCKu
         IEDXKwKwZhFM+jshWheiMLmOD6n18e0Aiz8scVzQWINRrrP8IOlZLqulj+BQ0t5o9j4D
         IxRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mKed+O2WU9TlAp0Vl7QpzMkS66i7MEYNM+q9xkeyVBo=;
        b=qfc4TB+MoAwleWqO9ceczwjkr4GAG50hhr+K8L9HANEozJ9UOKBIoPegT6xc1cT7Dz
         8F8Vuj5NOoDP8piRLy+/E/KFY8xJ0rbTNJzx3XiueLLvcMeESwkYmSQTFuFC5YHSSOzw
         MrPwNyOTqpZlPyTnn3wnMjE9eyuufBhU1BYu/lK1GtUiYMT68iV/YHczBHqwcUgtE6g4
         VOC99J7kVgxMwJYWf38ATwK1S3fXPoHxOnvhEDCg5mNsmeguVBpcoHiG4UGAs9lxvTiB
         mBcRnE9LUg0nb/OkoAqtDSkYlcdqpkCOBEtL3rIFj6BtoS+oZ/nTNlKTdziT2zD3kePh
         C00g==
X-Gm-Message-State: AOAM531xJNPhdpScCRLY+nW8Ai8m8whv/t7EuetZoM5r5hN/hvyC6DAb
        7DuGiTkvYI1siCNTuNT9n7FAYg==
X-Google-Smtp-Source: ABdhPJxO9MOO5S588rw8rSRuxZcWgJXeEOVV1/tJxuRsxxSpTfDF3CYy6ygGy+pcCaXUrq5KZOWhyw==
X-Received: by 2002:a05:6638:40b:b0:314:af71:b2f9 with SMTP id q11-20020a056638040b00b00314af71b2f9mr9247549jap.73.1645396148748;
        Sun, 20 Feb 2022 14:29:08 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s18sm8723562iov.5.2022.02.20.14.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 14:29:08 -0800 (PST)
Date:   Sun, 20 Feb 2022 17:29:07 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 08/11] worktree: use 'worktree' over 'working tree'
Message-ID: <YhLAs7OykfkrCzo7@nand.local>
References: <pull.1154.git.1645379667.gitgitgadget@gmail.com>
 <e7e579d2995288de13a2328e592e61f2b6dfaf63.1645379667.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e7e579d2995288de13a2328e592e61f2b6dfaf63.1645379667.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 20, 2022 at 05:54:24PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
>
> It is helpful to distinguish between a 'working tree' and a 'worktree'.
> A worktree contains a working tree plus additional metadata. This
> metadata includes per-worktree refs and worktree-specific config.
>
> This is the fourth of multiple changes to git-worktree.txt, restricted
> to the REFS section.
>
> This section previously described "per working tree" refs but they are
> now replaced with "per-worktree" refs, which matches the definition in
> glossary-content.txt.
>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  Documentation/git-worktree.txt | 31 +++++++++++++++----------------
>  1 file changed, 15 insertions(+), 16 deletions(-)
>
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> index 10021c85e77..54a2c335fd5 100644
> --- a/Documentation/git-worktree.txt
> +++ b/Documentation/git-worktree.txt
> @@ -255,24 +255,23 @@ have two worktrees, at `/abc/def/ghi` and `/abc/def/ggg`, then `ghi` or
>
>  REFS
>  ----
> -In multiple working trees, some refs may be shared between all working
> -trees and some refs are local. One example is `HEAD` which is different for each
> -working tree. This section is about the sharing rules and how to access
> -refs of one working tree from another.

Not the fault of this patch, but I have a tough time deciphering this
first sentence. Would the first part be clearer as:

    When using multiple worktrees, some refs are shared among all
    worktrees, but others are specific to an individual worktree.

?

Otherwise, this patch (and all of the replacement one preceding it)
look good to me.

Thanks,
Taylor
