Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C660BC433F5
	for <git@archiver.kernel.org>; Mon, 16 May 2022 21:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348972AbiEPVBx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 May 2022 17:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349454AbiEPVBV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 May 2022 17:01:21 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62D14FC53
        for <git@vger.kernel.org>; Mon, 16 May 2022 13:38:12 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id x23so15061405pff.9
        for <git@vger.kernel.org>; Mon, 16 May 2022 13:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=CIMcc/srAV1gt16EB59tl23Y1fo6WN9L0f2duqNmVO8=;
        b=KsrWwcyoiI4g4ljtjCrv+v/dSSje6DGmfpvHip6GvAPFQY/rRa3OjumVMXswpD062k
         RpAlxhbllZhM8FgL9zXZ8+Yvf+DXtkmHxOEl95kz6bYzfRegBLORKOna9Bx8VgnCxO2f
         FSr0m6vw40jzCs3g3qmpL0x1zKykUc3r8L3fApgyEQ8dXJC9CARiVHGRZMoywUxYDUxX
         DK1Lzn9bnNiKs5wABJcjtDRGTk/EgdrUfoDVdoAfph6W0TA13C0q+/4KsbqaKGaZbEeO
         XeycKMFj7pJOkLxyw1TgujuDrQmZJs7Q88Ukt83MNgaZ92cAtooQ3ZTLjQtKOzAOAj8t
         5mxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CIMcc/srAV1gt16EB59tl23Y1fo6WN9L0f2duqNmVO8=;
        b=5eJmHqqqbQjblnjYOeV0m0g5faOZ5ozOJkarWQcSC7V/b6YacOJEM+heXfPNLq26z9
         zoM6QWI5WnR+c3iX+IZet7LBcxaifeCVsIAs64BkVMMtG9LKjARsrrE3Sp/e5yXvPU1k
         Ulqn+psEcBg8bZQBBD6kXhHhbnbM7KcAoKsY/viCNLqHdC27PWP0GKipbaJpleLQsH8h
         3urdga7fOhMuvTncEWmzRXEw1OrzSIxZlE20BR3zb80PcXTEa1+mWq1iU1RCR4Gi8m1n
         4MBLhJJCLMCGJ8Copg48Iyx54sIgyk1mBD2ieigsFHjC4cdCBrZAIz1CKgyAihIIRQWo
         M93A==
X-Gm-Message-State: AOAM531S1y+s3V+epvYwMd04dpy2HtHRkVzecVQmGoQeNFICQ97+TWt6
        zMXLG6OQh8RmpDhcYtSJbJiw
X-Google-Smtp-Source: ABdhPJygBOiea5Wc/a5d1lpKgzx92sjDZchmlTk1ifrBsm+ZiQcL8XD492QgBZ55/ZiR8o8tXkiA1A==
X-Received: by 2002:a05:6a00:1152:b0:4be:ab79:fcfa with SMTP id b18-20020a056a00115200b004beab79fcfamr18964730pfm.3.1652733492094;
        Mon, 16 May 2022 13:38:12 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id w22-20020a1709027b9600b0015e8d4eb25fsm7450136pll.169.2022.05.16.13.38.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 13:38:11 -0700 (PDT)
Message-ID: <ac3869a5-3592-5408-587a-178afde3f7e9@github.com>
Date:   Mon, 16 May 2022 13:38:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH 6/8] sparse-index: complete partial expansion
Content-Language: en-US
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, shaoxuan.yuan02@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1208.git.1652724693.gitgitgadget@gmail.com>
 <eba63cc12af4f60320b34a54eef691b9f59d86bc.1652724693.git.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <eba63cc12af4f60320b34a54eef691b9f59d86bc.1652724693.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> To complete the implementation of expand_to_pattern_list(), we need to
> detect when a sparse directory entry should remain sparse. This avoids a
> full expansion, so we now need to use the PARTIALLY_SPARSE mode to
> indicate this state.
> 
> There still are no callers to this method, but we will add one in the
> next change.
> 
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  sparse-index.c | 41 +++++++++++++++++++++++++++++++++++++----
>  1 file changed, 37 insertions(+), 4 deletions(-)
> 
> diff --git a/sparse-index.c b/sparse-index.c
> index 3d8eed585b5..0bad5503304 100644
> --- a/sparse-index.c
> +++ b/sparse-index.c
> @@ -297,8 +297,24 @@ void expand_to_pattern_list(struct index_state *istate,
>  	 * continue. A NULL pattern set indicates a full expansion to a
>  	 * full index.
>  	 */
> -	if (pl && !pl->use_cone_patterns)
> +	if (pl && !pl->use_cone_patterns) {
>  		pl = NULL;
> +	} else {
> +		/*
> +		 * We might contract file entries into sparse-directory
> +		 * entries, and for that we will need the cache tree to
> +		 * be recomputed.
> +		 */
> +		cache_tree_free(&istate->cache_tree);
> +
> +		/*
> +		 * If there is a problem creating the cache tree, then we
> +		 * need to expand to a full index since we cannot satisfy
> +		 * the current request as a sparse index.
> +		 */
> +		if (cache_tree_update(istate, WRITE_TREE_MISSING_OK))
> +			pl = NULL;
> +	}
>  
>  	if (!istate->repo)
>  		istate->repo = the_repository;
> @@ -317,8 +333,14 @@ void expand_to_pattern_list(struct index_state *istate,
>  	full = xcalloc(1, sizeof(struct index_state));
>  	memcpy(full, istate, sizeof(struct index_state));
>  
> +	/*
> +	 * This slightly-misnamed 'full' index might still be sparse if we
> +	 * are only modifying the list of sparse directories. This hinges
> +	 * on whether we have a non-NULL pattern list.
> +	 */
> +	full->sparse_index = pl ? PARTIALLY_SPARSE : COMPLETELY_FULL;
> +
>  	/* then change the necessary things */
> -	full->sparse_index = 0;
>  	full->cache_alloc = (3 * istate->cache_alloc) / 2;
>  	full->cache_nr = 0;
>  	ALLOC_ARRAY(full->cache, full->cache_alloc);
> @@ -330,11 +352,22 @@ void expand_to_pattern_list(struct index_state *istate,
>  		struct cache_entry *ce = istate->cache[i];
>  		struct tree *tree;
>  		struct pathspec ps;
> +		int dtype;
>  
>  		if (!S_ISSPARSEDIR(ce->ce_mode)) {
>  			set_index_entry(full, full->cache_nr++, ce);
>  			continue;
>  		}
> +
> +		/* We now have a sparse directory entry. Should we expand? */
> +		if (pl &&
> +		    path_matches_pattern_list(ce->name, ce->ce_namelen,
> +					      NULL, &dtype,
> +					      pl, istate) <= 0) {

If I'm reading this correctly, what this is doing is:

- if we have a sparse directory entry
- ...and we're expanding only what matches the pattern list (i.e., not
  'ensure_full_index')
- ...and that sparse directory path is either *not matching* or *undecided
  whether it matches* the pattern list
- ...then we add the sparse directory to the result index and continue. 

The part that's confusing me is the "<= 0", which means a return value of
'UNDECIDED' from 'path_matches_pattern_list' adds the sparse directory
as-is. At the moment, it looks like 'UNDECIDED' is only returned if not
using cone patterns (so it shouldn't make a functional difference at this
point), but wouldn't that return value indicate that the pattern *may or may
not* match the path, so we should continue on to 'read_tree_at()'?

All that to say, should the condition be:

		/* We now have a sparse directory entry. Should we expand? */
		if (pl &&
		    path_matches_pattern_list(ce->name, ce->ce_namelen,
					      NULL, &dtype,
					      pl, istate) == NOT_MATCHED) {

to reflect that a sparse directory should only be added to the index if we
*know* it isn't matched?

To be clear, this is ultimately a non-functional nit - my question is mostly
to make sure I understand the intent of the code.

> +			set_index_entry(full, full->cache_nr++, ce);
> +			continue;
> +		}
> +
>  		if (!(ce->ce_flags & CE_SKIP_WORKTREE))
>  			warning(_("index entry is a directory, but not sparse (%08x)"),
>  				ce->ce_flags);
> @@ -360,7 +393,7 @@ void expand_to_pattern_list(struct index_state *istate,
>  	/* Copy back into original index. */
>  	memcpy(&istate->name_hash, &full->name_hash, sizeof(full->name_hash));
>  	memcpy(&istate->dir_hash, &full->dir_hash, sizeof(full->dir_hash));
> -	istate->sparse_index = 0;
> +	istate->sparse_index = pl ? PARTIALLY_SPARSE : COMPLETELY_FULL;
>  	free(istate->cache);
>  	istate->cache = full->cache;
>  	istate->cache_nr = full->cache_nr;
> @@ -374,7 +407,7 @@ void expand_to_pattern_list(struct index_state *istate,
>  
>  	/* Clear and recompute the cache-tree */
>  	cache_tree_free(&istate->cache_tree);
> -	cache_tree_update(istate, 0);
> +	cache_tree_update(istate, WRITE_TREE_MISSING_OK);
>  
>  	trace2_region_leave("index",
>  			    pl ? "expand_to_pattern_list" : "ensure_full_index",

