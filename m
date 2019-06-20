Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A76F1F462
	for <e@80x24.org>; Thu, 20 Jun 2019 14:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfFTOem (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 10:34:42 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36901 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfFTOem (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 10:34:42 -0400
Received: by mail-qk1-f194.google.com with SMTP id d15so2051837qkl.4
        for <git@vger.kernel.org>; Thu, 20 Jun 2019 07:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=qxqMMKIZatFRtAld61md+S3I1VWfpL5wv1FuZskRzgg=;
        b=pduejDKDdxiWrVBvVK4SvUPiKP9QdliU0hTko/0YuMdEpJsHCvxY8XwNGDxApK+/BQ
         eRmrp9e+K/siIVNG+fhBOIPFzPZXTjVZ92gLLgOSM5kTplFhr2bEGLkDfuAAoYqY2hO+
         zJ3YoB2YRvSV9gn9PYSgh+bYntWI+FIMFRASDLMnReRl1PFDaLx8tb1fqIRQr+jgOSIL
         jlC7k//xKpgGZcmdZ9+0iujiGld2DJr1V1zU9Lm9yZQPEOF/nlX2wJ0c/PAyIVT+uLyD
         18evNmWLBOIhHOYjdj6d/pC/zO69Po6hsigxt32HJd1pvjQDqdQ6JLVlsLcR/Cx7sJc7
         tdpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qxqMMKIZatFRtAld61md+S3I1VWfpL5wv1FuZskRzgg=;
        b=SiFj8gH0tUeTgbMR6ANCCL942xjvJhj4C1dotHsY+L2Os89kpS53wwM4dZ24FnwQmP
         9iW60oTixgEnMztljYPqnjWKlUpYkvBjB008Cz7/DM3oYeY08CsQoPXx/zNegmuQkTlG
         aDtvdeLtzzftayHOR6B/jYxOngvE19viQ1+MwIEESAxNd7iIHvGfz2heE7yGoK/R+X3q
         LFlAVc0LztXuAxKZPFOX3wjWh0sMtFLwcN78RMM38N5+tgn5qQZ5giHjenc+R/Mytphz
         LKXC9vy1FUb/zeBXWkIlZOgaJZRy6tjdV1JncaGsUZdA6/hHtKtrvKy018Y5bv08v+E4
         KHNg==
X-Gm-Message-State: APjAAAUuXIUEpE0bdQnN5kEdSGNayN0V4jOnHBZSjP5bNVoZZVVPlTOt
        DImYmcFngNphbV34nD1P3QxNfMl5
X-Google-Smtp-Source: APXvYqzXOnz2nlaPWMeYMaw1sYl7/sHIVXISuHBl15y2/e9OGzYFnlVUd6kTvgzJUBoqozpVZqbNZA==
X-Received: by 2002:a37:a413:: with SMTP id n19mr51444173qke.98.1561041280868;
        Thu, 20 Jun 2019 07:34:40 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:a934:2ce3:312e:b671? ([2001:4898:a800:1010:5a6a:2ce3:312e:b671])
        by smtp.gmail.com with ESMTPSA id d194sm290971qkg.102.2019.06.20.07.34.39
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 07:34:40 -0700 (PDT)
Subject: Re: [PATCH 4/4] restore: add --intent-to-add (restoring worktree
 only)
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20190620095523.10003-1-pclouds@gmail.com>
 <20190620095523.10003-5-pclouds@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e232fbc4-06ec-d4ed-826a-3bcbc923cafe@gmail.com>
Date:   Thu, 20 Jun 2019 10:34:39 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <20190620095523.10003-5-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/20/2019 5:55 AM, Nguyễn Thái Ngọc Duy wrote:
> "git restore --source" (without --staged) could create new files
> (i.e. not present in index) on worktree to match the given source. But
> the new files are not tracked, so both "git diff" and "git diff
> <source>" ignore new files. "git commit -a" will not recreate a commit
> exactly as the given source either.
> 
> Add --intent-to-add to help track new files in this case, which is the
> default on the least surprise principle.

I was unfamiliar with this behavior, but did check the 'restore' command
myself and saw that it would register the file as untracked. I agree that
could be confusing for a user, so adding it to the staging environment
makes this more in-line with `git checkout <rev> -- <path>`.

> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  Documentation/git-restore.txt |  7 ++++
>  builtin/checkout.c            | 78 +++++++++++++++++++++++++++++++++++
>  t/t2070-restore.sh            | 17 ++++++++
>  3 files changed, 102 insertions(+)
> 
> diff --git a/Documentation/git-restore.txt b/Documentation/git-restore.txt
> index d90093f195..43a7f43b2b 100644
> --- a/Documentation/git-restore.txt
> +++ b/Documentation/git-restore.txt
> @@ -93,6 +93,13 @@ in linkgit:git-checkout[1] for details.
>  	are "merge" (default) and "diff3" (in addition to what is
>  	shown by "merge" style, shows the original contents).
>  
> +--intent-to-add::
> +--no-intent-to-add::
> +	When restoring files only on working tree with `--source`,
> +	new files are marked as "intent to add" (see
> +	linkgit:git-add[1]). This is the default behavior. Use
> +	`--no-intent-to-add` to disable it.
> +
>  --ignore-unmerged::
>  	When restoring files on the working tree from the index, do
>  	not abort the operation if there are unmerged entries and
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index f884d27f1f..c519067d3d 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -70,6 +70,7 @@ struct checkout_opts {
>  	int checkout_worktree;
>  	const char *ignore_unmerged_opt;
>  	int ignore_unmerged;
> +	int intent_to_add;
>  
>  	const char *new_branch;
>  	const char *new_branch_force;
> @@ -392,6 +393,69 @@ static int checkout_worktree(const struct checkout_opts *opts)
>  	return errs;
>  }
>  
> +/*
> + * Input condition: r->index contains the file list matching worktree.
> + *
> + * r->index is reloaded with $GIT_DIR/index. Files that exist in the
> + * current worktree but not in $GIT_DIR/index are added back as
> + * intent-to-add.
> + */

Reading this code (and being unfamiliar with the cache array) I thought
it might accidentally add untracked files from the working directory into
the index. A local test verified that was not the case. Is that worth
adding to your test below?
  
> +test_expect_success 'restore worktree only adds new files back as intent-to-add' '
> +	git init ita &&
> +	(
> +		cd ita &&
> +		test_commit one &&
> +		test_commit two &&
> +		git rm one.t &&
> +		git commit -m one-is-gone &&
+		touch garbage &&
> +		git restore --source one one.t &&
> +		git diff --summary >actual &&
> +		echo " create mode 100644 one.t" >expected &&
> +		test_cmp expected actual &&
> +		git diff --cached >empty &&
> +		test_must_be_empty empty
> +	)
> +'
> +
>  test_done

Perhaps the line I inserted above would suffice to add this extra check?

Outside of that extra test (which may not be necessary), this series makes
sense to me.

Thanks,
-Stolee


