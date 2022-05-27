Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C2BC433F5
	for <git@archiver.kernel.org>; Fri, 27 May 2022 19:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354457AbiE0TgT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 15:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352079AbiE0TgR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 15:36:17 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AA25FFE
        for <git@vger.kernel.org>; Fri, 27 May 2022 12:36:16 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id r71so4779042pgr.0
        for <git@vger.kernel.org>; Fri, 27 May 2022 12:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=wY1a3ZImK7h2Q3W6nyH3Lik/igfmcMUdjsfZUaAySvc=;
        b=Cq2CraDytK+J4mcw7RnI9etqDZQHU2UeM1AJomWQxhxKd1ZIYqPrfkw6BvZflmtdKN
         xyp5zvuNeGuEauPMUIMNsvfPjYdf+ScTqhztLUqtwqfJqmUoXQt91qk7fcn9Uhur/p6q
         itfLUnsolvW6vg0FCxiPNBFFlXAxaDRpuprBKA+Mu5iWcdZbMK9Rr0neQSV9uVbYLtW4
         moF00bpJy6Ch67NUK5q9hri7wfsHnAD3UxPO5e018Erarltml7pI23evoW9m7v7P6qvN
         qMlyNfyKNxVkp3uoKjE3gKcxshu6kmY0Or14eFVzHatSpv0ejspr4S369QllCLYdxMPq
         mcfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wY1a3ZImK7h2Q3W6nyH3Lik/igfmcMUdjsfZUaAySvc=;
        b=RXsn8h4oTg3v/FtPn4AoWOdov5/xHwj5b5HDEyLg0nhEDNnSpfi4JX+JJw13Inm1Hn
         SoyRk9ejPlnRJGMUqf/OfcllE85BOJjUKOEDFGBV0WAhP/6BOCSpCNLCdjHj+WBz+X1L
         CvQ0I/1XpnvEvn871LYPG3Corw9G5uxng6qMUxGSh56OXGF2nYIM/XmolyWoKTR59+jR
         8Z317HRdDOhmia8RytgyexVHv1W44YX/DBzRT6y+FQI2bvtsMj0gHDFlaWJbtVH4FheE
         z3dj7xwHExyxLvSG3AQaspAAlGmhmqpmk5GecOTyqDlN+2TsmEB0pjg0ojD9xOtOqKXS
         GhMA==
X-Gm-Message-State: AOAM5306rLP3GqS9augBLZzdgTyJihhNSUvqNxxBgrDPku7uZ8WC9C4Y
        jOmWdGiVUJNIw4m65q4P82Tu
X-Google-Smtp-Source: ABdhPJw4NhizdnIzVzcvWi3VvlKmGfPVJy3jHOSGaqpcOVUyQUfIW5sJB+dvh8lflGULfqtrD4GeCg==
X-Received: by 2002:a63:8841:0:b0:3fa:efcd:245e with SMTP id l62-20020a638841000000b003faefcd245emr11126829pgd.34.1653680174970;
        Fri, 27 May 2022 12:36:14 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id v189-20020a6389c6000000b003c14af50607sm3868952pgd.31.2022.05.27.12.36.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 May 2022 12:36:14 -0700 (PDT)
Message-ID: <077a0579-903e-32ad-029c-48572d471c84@github.com>
Date:   Fri, 27 May 2022 12:36:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [WIP v2 5/5] mv: use update_sparsity() after touching sparse
 contents
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org
Cc:     derrickstolee@github.com, gitster@pobox.com, newren@gmail.com
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220527100804.209890-1-shaoxuan.yuan02@gmail.com>
 <20220527100804.209890-6-shaoxuan.yuan02@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20220527100804.209890-6-shaoxuan.yuan02@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shaoxuan Yuan wrote:
> Originally, "git mv" a sparse file/directory from out/in-cone to
> in/out-cone does not update the sparsity following the sparse-checkout
> patterns.
> 

I generally agree with the intent here - that, if you move a non-sparse file
out-of-cone, it should become sparse (and vice versa). However, that result
can be reached by simply flipping the 'SKIP_WORKTREE' bit(s) on the
resultant index entry/entries (which you already have, since they're renamed
with 'rename_cache_entry_at()' below). 

Note that you'll also probably need to check out the file(s) (if moving into
the cone) or remove them from disk (if moving out of cone). If you don't,
files moved into cone will appear "deleted" on-disk, and files moved
out-of-cone that still appear on disk will have 'SKIP_WORKTREE'
automatically disabled (see [1]).

For reference, I'd advise against reapplying the sparsity patterns - as you
do below - because involves a much more expensive traversal of the entire
repository. It also has the possibly unwanted side effect of resetting the
'SKIP_WORKTREE' bit to match the sparse patterns on *all* files, not just
the one(s) you moved. 

[1] https://lore.kernel.org/git/11d46a399d26c913787b704d2b7169cafc28d639.1642175983.git.gitgitgadget@gmail.com/

> Use update_sparsity() after touching sparse contents, so the sparsity
> will be updated after the move.
> 
> Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
> ---
>  builtin/mv.c                  | 19 +++++++++++++++++++
>  t/t7002-mv-sparse-checkout.sh | 16 ++++++++++++++++
>  2 files changed, 35 insertions(+)
> 
> diff --git a/builtin/mv.c b/builtin/mv.c
> index e64f251a69..2c02120941 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -13,6 +13,7 @@
>  #include "string-list.h"
>  #include "parse-options.h"
>  #include "submodule.h"
> +#include "unpack-trees.h"
>  
>  static const char * const builtin_mv_usage[] = {
>  	N_("git mv [<options>] <source>... <destination>"),
> @@ -158,6 +159,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  {
>  	int i, flags, gitmodules_modified = 0;
>  	int verbose = 0, show_only = 0, force = 0, ignore_errors = 0, ignore_sparse = 0;
> +	int sparse_moved = 0;
>  	struct option builtin_mv_options[] = {
>  		OPT__VERBOSE(&verbose, N_("be verbose")),
>  		OPT__DRY_RUN(&show_only, N_("dry run")),
> @@ -376,6 +378,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  		const char *src = source[i], *dst = destination[i];
>  		enum update_mode mode = modes[i];
>  		int pos;
> +		if (!sparse_moved && mode & (SPARSE | SKIP_WORKTREE_DIR))
> +			sparse_moved = 1;
>  		if (show_only || verbose)
>  			printf(_("Renaming %s to %s\n"), src, dst);
>  		if (show_only)
> @@ -403,6 +407,21 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  		rename_cache_entry_at(pos, dst);
>  	}
>  
> +	if (sparse_moved) {
> +		struct unpack_trees_options o;
> +		memset(&o, 0, sizeof(o));
> +		o.verbose_update = isatty(2);
> +		o.update = 1;
> +		o.head_idx = -1;
> +		o.src_index = &the_index;
> +		o.dst_index = &the_index;
> +		o.skip_sparse_checkout = 0;
> +		o.pl = the_index.sparse_checkout_patterns;
> +		setup_unpack_trees_porcelain(&o, "mv");
> +		update_sparsity(&o);
> +		clear_unpack_trees_porcelain(&o);
> +	}
> +
>  	if (gitmodules_modified)
>  		stage_updated_gitmodules(&the_index);
>  
> diff --git a/t/t7002-mv-sparse-checkout.sh b/t/t7002-mv-sparse-checkout.sh
> index cf2f5dc46f..1fd3e3c0fc 100755
> --- a/t/t7002-mv-sparse-checkout.sh
> +++ b/t/t7002-mv-sparse-checkout.sh
> @@ -287,6 +287,22 @@ test_expect_success 'refuse to move sparse file to existing destination' '
>  	test_cmp expect stderr
>  '
>  
> +# Need fix.
> +#
> +# The *expected* behavior:
> +#
> +# Using --sparse to accept a sparse file, --force to overwrite the destination.
> +# The folder1/file1 should replace the sub/file1 without error.
> +#
> +# The *actual* behavior:
> +#
> +# It emits a warning:
> +#
> +# warning: Path ' sub/file1
> +# ' already present; will not overwrite with sparse update.
> +# After fixing the above paths, you may want to run `git sparse-checkout
> +# reapply`.
> +
>  test_expect_failure 'move sparse file to existing destination with --force and --sparse' '
>  	git sparse-checkout disable &&
>  	git reset --hard &&

This error is (I think) part of 'update_sparsity()'. If you change the
approach to only modifying the 'SKIP_WORKTREE' bit, hopefully you'll get the
behavior you're looking for.
