Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9BA51F9AF
	for <e@80x24.org>; Fri,  3 Feb 2017 09:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752415AbdBCJGZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Feb 2017 04:06:25 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:33782 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752385AbdBCJGW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2017 04:06:22 -0500
Received: by mail-ot0-f193.google.com with SMTP id f9so1522321otd.0
        for <git@vger.kernel.org>; Fri, 03 Feb 2017 01:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=eSkGHzgJguAHpOw0eO95yCnMoJsIaUT/ZwZl+tgt3gI=;
        b=ZW69Gbw8ekfJ2wogetvLpZGFYfkxwMQCEQzoez6hyODrtErZ35Sn7gJmz7YuTVkUIv
         IAFoFpNsf1FENX94ZppW8uHY5k4KPboBCDv2xb2dzz8HtxqN2lG8ATG31ZiKn31+fb5c
         Jj4olYd/lymW+WjKJY07lqpsplsIxf56jsG6s5Ag3NZy3lUedlIR0C3Segy05gr4uXZV
         Tl1yEmbkwa1D+ogYFtgdY4qjhu49StldmhZFxOHB7mhw0fzAe1DpJyM9Y7DLq2bTh37h
         JFgSz/2H3d2FGUukCGFmsY/cGOTyHnPHosIPRt+wTS5IJ9t8RKRlVqbdpt3vufGBzU33
         uL6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=eSkGHzgJguAHpOw0eO95yCnMoJsIaUT/ZwZl+tgt3gI=;
        b=tweMT6EJ29T5/7pLEdAIHjOAiXea5iKkmwAZ0M/dK4gpOq5J32jOUaZ7jB29jvEuIy
         onw2M7ZlRPQ70s8cZSgGK+R5VS9//IvVF95QgbE0zNH/LpUFMQIuS2hRjcfbtPOKEopx
         S92WMl46d28gpwIi1SdY6CDrqy2j1lzMVTaICEpBkpMvr33VSbuCV+W16ErWyKq6tFWJ
         Sm9CmKtU45wgLlXyKT8x4S2yykfM/lKjIaAJK+67l2+UjJgWBX63RDoHLxbbwk1Wnvoz
         K6MtM9zEp8nC2BEDaDcicJUNsXSAsE6XbdWJQWBLQBwzP+xMB+5Lchk+UvOmsgrHBq2G
         3/ag==
X-Gm-Message-State: AIkVDXIgU18G1QbDePHG8VjlNq4rblJGJsyg0hTBC5kFurZbhwiMhW0V8XRjlh7Piil5ImUvUBZgXS1FavZHgA==
X-Received: by 10.157.37.54 with SMTP id k51mr5742456otb.271.1486112781482;
 Fri, 03 Feb 2017 01:06:21 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.1 with HTTP; Fri, 3 Feb 2017 01:05:48 -0800 (PST)
In-Reply-To: <20170203003038.22278-1-jacob.e.keller@intel.com>
References: <20170203003038.22278-1-jacob.e.keller@intel.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 3 Feb 2017 16:05:48 +0700
Message-ID: <CACsJy8B=OEdUbc3_Svci_whtk=-Bz-4BP4y-Xr_u3CU81dxvCA@mail.gmail.com>
Subject: Re: [PATCH] reset: add an example of how to split a commit into two
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 3, 2017 at 7:30 AM, Jacob Keller <jacob.e.keller@intel.com> wrote:
> From: Jacob Keller <jacob.keller@gmail.com>
>
> It is sometimes useful to break a commit into parts to more logically
> show how the code changes. There are many possible ways to achieve this
> result, but one simple and powerful one is to use git reset -p.
>
> Add an example to the documentation showing how this can be done so that
> users are more likely to discover this, instead of inventing more
> painful methods such as re-writing code from scratch, or duplicating git
> add -p more times than necessary.
>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
>  Documentation/git-reset.txt | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
> index 25432d9257f9..4adac7a25bf9 100644
> --- a/Documentation/git-reset.txt
> +++ b/Documentation/git-reset.txt
> @@ -292,6 +292,29 @@ $ git reset --keep start                    <3>
>  <3> But you can use "reset --keep" to remove the unwanted commit after
>      you switched to "branch2".
>
> +Split a commit into two::
> ++
> +Suppose that you have created a commit, but later decide that you want to split
> +the changes into two separate commits, including only part of the old commit
> +into the first commit, and including the rest as a separate commit on top. You
> +can use git reset in patch mode to interactively select which hunks to split
> +out into a separate commit.
> ++
> +------------
> +$ git reset -p HEAD^                        <1>

For good practice, perhaps put "git diff --cached HEAD^" before "git commit".

I tend to avoid "reset -p" and "checkout -p" though because sometimes
it does not work. Not sure if it's just me, I think it may have
something to do with splitting hunks. So I usually go with "reset
HEAD^" then "add -p" and "commit -c HEAD@{1}" instead.

> +$ git commit --amend                        <2>
> +$ git commit ...                            <3>
> +------------
> ++
> +<1> This lets you interactively undo changes between HEAD^ and HEAD, so you can
> +    select which parts to remove from the initial commit. The changes are
> +    placed into the index, leaving the working tree untouched.
> +<2> Now, you ammend the initial commit with the modifications that you just

s/ammend/amend/

> +    made in the index.
> +<3> Finally, you can add and then commit the final original unmodified files
> +    back as the second commit, enabling you to logically separate a commit
> +    into a sequence of two commits instead.
-- 
Duy
