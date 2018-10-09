Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9D3D1F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 14:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbeJIWFz (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 18:05:55 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35207 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeJIWFz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 18:05:55 -0400
Received: by mail-qt1-f194.google.com with SMTP id v19-v6so1902450qtg.2
        for <git@vger.kernel.org>; Tue, 09 Oct 2018 07:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=7kXYWFR2aeOamZuqUEBjJeCIBElTAH6SZh2/nzBS3V4=;
        b=gkFas/HLQ1Mokf5QK6TPntv/hiACLYW0iwsbdQa4PA/wfWTJgjXaxnoH7YqZ6JoQKd
         QQcyaChX7JNPsdn4zzUgEGrMvOkMAcv2B1EFUvWG2oU64aIR5S8amdZTzQm8oM0t1FsI
         tY4klY1WNoeLgpEFl5LAXXVRVvTEk1FGZX9zvo8KXpC1ZcRW4RGJHrpOjhJDx5LeL2Ez
         B4TIja5XpMCihEDHSfe+he1v93pJ2/yzybA5bwmU1An+uIZnX7Uh1cs4kZgmV8a+dTmf
         Aod7BPKNOn/BX4OA7dgDTjGKav32qYwdQPb9Bt8PIjE13pGfUdTYLM0LizI9C14Pbsl+
         7XVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7kXYWFR2aeOamZuqUEBjJeCIBElTAH6SZh2/nzBS3V4=;
        b=b0Xsp/C4xr8Kiex3yLuUJ1vJbIPlt6nXOLlP2HxOzBxjlDSG3CKrNthV0qpniY7wYx
         PBs9N3h72g0HgTxxWlb7kZ/qtx2z4BceVOe3UYPIfw7v5xsihFKjU/iC3pH/Ql50oivh
         lbbzmUmu1SXUyBR2+M8C86tbUAGOqtoiGQd2haoS2zvbld+ljiC3PmRr0zGEnpaSv86G
         1SDX2Io2ahfeB7bng9+csEhWKmTbv9paNZTgenCw/GwXzdr1Hf7uaVpCHFmKemXrDQdK
         6oJuT4T9JopLqcc80r3AUZjPBj9p7qEEIrqVGksTxoWwQiYeaqd5otv/rXnYQONC04Oq
         DnVw==
X-Gm-Message-State: ABuFfojz49jRWHtgCWdgS06ocyYX5kZ3n3VPkRbrxVlCbMnIRvarMBLy
        fRcOCnsiKhVF5NyIIS19eWapeQCetDM=
X-Google-Smtp-Source: ACcGV60pskT+K200fIF85RWDC0b11cBDyCiheYRekIePUcPi0ZK6j9FYqbfHgvxqjB26X9Hwk94VjQ==
X-Received: by 2002:aed:2e04:: with SMTP id j4-v6mr22269800qtd.47.1539096516649;
        Tue, 09 Oct 2018 07:48:36 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id j6-v6sm4031226qtb.25.2018.10.09.07.48.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 07:48:35 -0700 (PDT)
Subject: Re: [PATCH] unpack-trees: allow missing CE_SKIP_WORKTREE objs
To:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
References: <20181008214816.42856-1-jonathantanmy@google.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <7ac4ea1d-596d-cffd-337f-bf1879d982e1@gmail.com>
Date:   Tue, 9 Oct 2018 10:48:34 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181008214816.42856-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/8/2018 5:48 PM, Jonathan Tan wrote:
> Whenever a sparse checkout occurs, the existence of all blobs in the
> index is verified, whether or not they are included or excluded by the
> .git/info/sparse-checkout specification. This degrades performance,
> significantly in the case of a partial clone, because a lazy fetch
> occurs whenever the existence of a missing blob is checked.
> 
> At the point of invoking cache_tree_update() in unpack_trees(),
> CE_SKIP_WORKTREE is already set on all excluded blobs
> (mark_new_skip_worktree() is called twice to set CE_NEW_SKIP_WORKTREE,
> then apply_sparse_checkout() is called which copies over
> CE_NEW_SKIP_WORKTREE to CE_SKIP_WORKTREE). cache_tree_update() can use
> this information to know which blobs are excluded, and thus skip the
> checking of these.
> 
> Because cache_tree_update() is used from multiple places, this new
> behavior is guarded by a new flag WRITE_TREE_SKIP_WORKTREE_MISSING_OK.
> Implement this new flag, and teach unpack_trees() to invoke
> cache_tree_update() with this new flag.
> 

I wonder if preventing the download of all missing blobs should be 
limited to only the checkout command.  When you looked at the other 
places that call cache_tree_update(), does it make sense that they 
trigger the download of all the missing blobs?  For example, I suspect 
you would not want them all downloaded just to do a merge-recursive.

In full disclosure, we implemented this a couple of years ago [1] for 
GVFS and opted to do the logic a little differently.  We found that we 
didn't want to trigger the download of all missing blobs in 
cache_tree_update() for _any_ command that was executing in a partially 
cloned repo.  This is safe because if any individual blob is actually 
needed, it will get downloaded "on demand" already.

[1] https://github.com/Microsoft/git/commit/ec865500d98


> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>   cache-tree.c                     |  6 +++++-
>   cache-tree.h                     |  4 ++++
>   t/t1090-sparse-checkout-scope.sh | 33 ++++++++++++++++++++++++++++++++
>   unpack-trees.c                   |  1 +
>   4 files changed, 43 insertions(+), 1 deletion(-)
> 
> diff --git a/cache-tree.c b/cache-tree.c
> index 5ce51468f0..340caf2d34 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -246,6 +246,8 @@ static int update_one(struct cache_tree *it,
>   	int missing_ok = flags & WRITE_TREE_MISSING_OK;
>   	int dryrun = flags & WRITE_TREE_DRY_RUN;
>   	int repair = flags & WRITE_TREE_REPAIR;
> +	int skip_worktree_missing_ok =
> +		flags & WRITE_TREE_SKIP_WORKTREE_MISSING_OK;
>   	int to_invalidate = 0;
>   	int i;
>   
> @@ -356,7 +358,9 @@ static int update_one(struct cache_tree *it,
>   		}
>   
>   		if (is_null_oid(oid) ||
> -		    (mode != S_IFGITLINK && !missing_ok && !has_object_file(oid))) {
> +		    (mode != S_IFGITLINK && !missing_ok &&
> +		     !(skip_worktree_missing_ok && ce_skip_worktree(ce)) &&
> +		     !has_object_file(oid))) {
>   			strbuf_release(&buffer);
>   			if (expected_missing)
>   				return -1;
> diff --git a/cache-tree.h b/cache-tree.h
> index 0ab6784ffe..655d487619 100644
> --- a/cache-tree.h
> +++ b/cache-tree.h
> @@ -40,6 +40,10 @@ void cache_tree_verify(struct index_state *);
>   #define WRITE_TREE_DRY_RUN 4
>   #define WRITE_TREE_SILENT 8
>   #define WRITE_TREE_REPAIR 16
> +/*
> + * Do not check for the presence of cache entry objects with CE_SKIP_WORKTREE.
> + */
> +#define WRITE_TREE_SKIP_WORKTREE_MISSING_OK 32
>   
>   /* error return codes */
>   #define WRITE_TREE_UNREADABLE_INDEX (-1)
> diff --git a/t/t1090-sparse-checkout-scope.sh b/t/t1090-sparse-checkout-scope.sh
> index 25d7c700f6..090b7fc3d3 100755
> --- a/t/t1090-sparse-checkout-scope.sh
> +++ b/t/t1090-sparse-checkout-scope.sh
> @@ -63,4 +63,37 @@ test_expect_success 'return to full checkout of master' '
>   	test "$(cat b)" = "modified"
>   '
>   
> +test_expect_success 'in partial clone, sparse checkout only fetches needed blobs' '
> +	test_create_repo server &&
> +	git clone "file://$(pwd)/server" client &&
> +
> +	test_config -C server uploadpack.allowfilter 1 &&
> +	test_config -C server uploadpack.allowanysha1inwant 1 &&
> +	echo a >server/a &&
> +	echo bb >server/b &&
> +	mkdir server/c &&
> +	echo ccc >server/c/c &&
> +	git -C server add a b c/c &&
> +	git -C server commit -m message &&
> +
> +	test_config -C client core.sparsecheckout 1 &&
> +	test_config -C client extensions.partialclone origin &&
> +	echo "!/*" >client/.git/info/sparse-checkout &&
> +	echo "/a" >>client/.git/info/sparse-checkout &&
> +	git -C client fetch --filter=blob:none origin &&
> +	git -C client checkout FETCH_HEAD &&
> +
> +	git -C client rev-list HEAD \
> +		--quiet --objects --missing=print >unsorted_actual &&
> +	(
> +		printf "?" &&
> +		git hash-object server/b &&
> +		printf "?" &&
> +		git hash-object server/c/c
> +	) >unsorted_expect &&
> +	sort unsorted_actual >actual &&
> +	sort unsorted_expect >expect &&
> +	test_cmp expect actual
> +'
> +
>   test_done
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 51bfac6aa0..39e0e7a6c7 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -1635,6 +1635,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>   				o->result.cache_tree = cache_tree();
>   			if (!cache_tree_fully_valid(o->result.cache_tree))
>   				cache_tree_update(&o->result,
> +						  WRITE_TREE_SKIP_WORKTREE_MISSING_OK |
>   						  WRITE_TREE_SILENT |
>   						  WRITE_TREE_REPAIR);
>   		}
> 
