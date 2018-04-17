Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 932D31F404
	for <e@80x24.org>; Tue, 17 Apr 2018 23:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752747AbeDQXMC (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 19:12:02 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:38652 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751164AbeDQXMB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 19:12:01 -0400
Received: by mail-qk0-f175.google.com with SMTP id b39so16698823qkb.5
        for <git@vger.kernel.org>; Tue, 17 Apr 2018 16:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4PRazPlJ5V8Dpfxkvy6SDepTetkQK2FWiMb9CvD69hQ=;
        b=kfJP3ttSjmXJpVKE67qdX1iDo4y+Htm3WUTl78nKUY8aF26WwGegrabGVD+623hsdD
         wIcV3NGBwmSjukt/CCdwJ2pp42pqOJ3XSCVfbVSCUcgy46tkD3ztyvtiasPghxjObMC2
         BX+b9RvvVsOBEoHj8NW8+hlRQs2obUts9CmpUhSJqi37RAGUQ1ynnEYjwDPRSgVn/134
         8WXkDrfiGazDZJ7Sy5zDb7lkO/7FpYljSimcMvSu0ABvlK7e8U6bU2P3c78Li0UnoZ6B
         K9AUy+fwAWQNKE8/xxJeThdFgK830NZ3AGhHpTI+pdylK343jVmX7RbVmQWDPOR2eotR
         rL9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4PRazPlJ5V8Dpfxkvy6SDepTetkQK2FWiMb9CvD69hQ=;
        b=STv8PzqQDcs9M4c2jiRNgrOrUai9IDzOvvLR+kCdHOazxYG47GY5clefiev8BBKoZx
         ooYzsEJOClsOdE5nT5+8B1Sz0SG3OOLlrQFtJzQTqyBSZ4nJ6RKs7f+rfIuPy+MVsS7C
         eL0LVa+J7zCEmi9xh1VZllqBZNNAzTI+7OF0dYvg5TGS9yYVCWkm8IR8oKx3d7YBffz6
         bHFecj3mbU7Cjsy50XKtmqQO8ngKPhEJsfU3BMfhu91Ld8sFG84DkjzkjeJ/Rh8WF4h2
         KxGgzA9YvnmprBWKhoHik/H24gtdlGKeFIGCxeilQt8ABFEzBD9UOOGc+Kmq47fNUjUO
         1rYA==
X-Gm-Message-State: ALQs6tBjBMEbAK/rMnt9HV6dUf1cue4ZVUQJ3UhXX0fFbHdHjj375GKR
        ZHuZS2SpZdItYArAgbQv4DA=
X-Google-Smtp-Source: AIpwx4+D8Q2HJPAe2N2RL2yT/eLBBEqcdRb7vhxBreSFwOqBJf8IaRjSh4XS5FtyOORaRSkB9cZGyQ==
X-Received: by 10.55.123.3 with SMTP id w3mr3968535qkc.220.1524006720289;
        Tue, 17 Apr 2018 16:12:00 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id v25sm11750298qkl.59.2018.04.17.16.11.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Apr 2018 16:11:59 -0700 (PDT)
Subject: Re: [PATCH v1 2/5] Add an API creating / discarding cache_entry
 structs
To:     Jameson Miller <jamill@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Cc:     "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>
References: <20180417163400.3875-1-jamill@microsoft.com>
 <20180417163400.3875-4-jamill@microsoft.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <921a8d5c-b118-c5b1-35dd-459130faeed9@gmail.com>
Date:   Tue, 17 Apr 2018 19:11:59 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180417163400.3875-4-jamill@microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/17/2018 12:34 PM, Jameson Miller wrote:
> Add an API around managing the lifetime of cache_entry structs. Abstracting
> memory management details behind an API will allow for alternative memory
> management strategies without affecting all the call sites.  This commit does
> not change how memory is allocated / freed. A later commit in this series will
> allocate cache entries from memory pools as appropriate.
> 
> Motivation:
> It has been observed that the time spent loading an index with a large
> number of entries is partly dominated by malloc() calls. This
> change is in preparation for using memory pools to reduce the number
> of malloc() calls made when loading an index.
> 
> This API makes a distinction between cache entries that are intended for use
> with a particular to an index and cache entries that are not. 

The wording here is awkward.  Did you mean "intended for use with a 
particular index?"

This enables us
> to use the knowledge about how a cache entry will be used to make informed
> decisions about how to handle the corresponding memory.
> ---
>   apply.c                |  26 ++++++------
>   blame.c                |   5 +--
>   builtin/checkout.c     |   8 ++--
>   builtin/difftool.c     |   8 ++--
>   builtin/reset.c        |   6 +--
>   builtin/update-index.c |  26 ++++++------
>   cache.h                |  29 +++++++++++++-
>   merge-recursive.c      |   2 +-
>   read-cache.c           | 105 +++++++++++++++++++++++++++++++++++--------------
>   resolve-undo.c         |   6 ++-
>   split-index.c          |   8 ++--
>   tree.c                 |   4 +-
>   unpack-trees.c         |  27 ++++++++-----
>   13 files changed, 166 insertions(+), 94 deletions(-)
> 
> diff --git a/apply.c b/apply.c
> index 7e5792c996..47903f427b 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -4090,12 +4090,12 @@ static int build_fake_ancestor(struct apply_state *state, struct patch *list)
>   			return error(_("sha1 information is lacking or useless "
>   				       "(%s)."), name);
>   
> -		ce = make_cache_entry(patch->old_mode, oid.hash, name, 0, 0);
> +		ce = make_index_cache_entry(&result, patch->old_mode, oid.hash, name, 0, 0);
>   		if (!ce)
> -			return error(_("make_cache_entry failed for path '%s'"),
> +			return error(_("make_index_cache_entry failed for path '%s'"),
>   				     name);
>   		if (add_index_entry(&result, ce, ADD_CACHE_OK_TO_ADD)) {
> -			free(ce);
> +			index_cache_entry_discard(ce);

I personally prefer name symmetry.  To me, make_index_cache_entry() 
should be paired with discard_index_cache_entry().

The rest of this patch looks like a fairly mechanical refactoring with 
the biggest exception being the difference between the the 
*_index_cache_entry() APIs and the *_transient_cache_entry() APIs.

There are quite a few changes but I didn't see any instances that were 
missed or any errors.  I see that later patches will put verification 
code in place to detect if any were done incorrectly and to prevent 
regressions moving forward.

Overall, it looks correct and reasonable.

<snip>

>   
> -struct cache_entry *make_cache_entry(unsigned int mode,
> -		const unsigned char *sha1, const char *path, int stage,
> -		unsigned int refresh_options)
> +struct cache_entry *make_empty_index_cache_entry(struct index_state *istate, size_t len)
> +{
> +	return xcalloc(1, cache_entry_size(len));
> +}
> +
> +struct cache_entry *make_empty_transient_cache_entry(size_t len)
> +{
> +	return xcalloc(1, cache_entry_size(len));
> +}
> +
> +struct cache_entry *make_index_cache_entry(struct index_state *istate, unsigned int mode,
> +			    const unsigned char *sha1, const char *path,
> +			    int stage, unsigned int refresh_options)
>   {
> -	int size, len;
>   	struct cache_entry *ce, *ret;
> +	int len;
>   
>   	if (!verify_path(path)) {
>   		error("Invalid path '%s'", path);
> @@ -758,8 +767,7 @@ struct cache_entry *make_cache_entry(unsigned int mode,
>   	}
>   
>   	len = strlen(path);
> -	size = cache_entry_size(len);
> -	ce = xcalloc(1, size);
> +	ce = make_empty_index_cache_entry(istate, len);
>   
>   	hashcpy(ce->oid.hash, sha1);
>   	memcpy(ce->name, path, len);
> @@ -769,10 +777,34 @@ struct cache_entry *make_cache_entry(unsigned int mode,
>   
>   	ret = refresh_cache_entry(&the_index, ce, refresh_options);
>   	if (ret != ce)
> -		free(ce);
> +		index_cache_entry_discard(ce);
> +
>   	return ret;
>   }
>   
> +struct cache_entry *make_transient_cache_entry(unsigned int mode, const unsigned char *sha1,
> +			   const char *path, int stage)
> +{
> +	struct cache_entry *ce;
> +	int len;
> +
> +	if (!verify_path(path)) {
> +		error("Invalid path '%s'", path);
> +		return NULL;
> +	}
> +
> +	len = strlen(path);
> +	ce = make_empty_transient_cache_entry(len);
> +
> +	hashcpy(ce->oid.hash, sha1);
> +	memcpy(ce->name, path, len);
> +	ce->ce_flags = create_ce_flags(stage);
> +	ce->ce_namelen = len;
> +	ce->ce_mode = create_ce_mode(mode);
> +

Nit, feel free to ignore. There isn't a lot of initialization here but I 
wonder if it makes sense to have an internal helper function to ensure 
these stay the same.

> +	return ce;
> +}
> +
>   /*
>    * Chmod an index entry with either +x or -x.
>    *
> @@ -1243,7 +1275,7 @@ static struct cache_entry *refresh_cache_ent(struct index_state *istate,
>   {
>   	struct stat st;
>   	struct cache_entry *updated;
> -	int changed, size;
> +	int changed;
>   	int refresh = options & CE_MATCH_REFRESH;
>   	int ignore_valid = options & CE_MATCH_IGNORE_VALID;
>   	int ignore_skip_worktree = options & CE_MATCH_IGNORE_SKIP_WORKTREE;
> @@ -1323,8 +1355,7 @@ static struct cache_entry *refresh_cache_ent(struct index_state *istate,
>   		return NULL;
>   	}
>   
> -	size = ce_size(ce);
> -	updated = xmalloc(size);
> +	updated = make_empty_index_cache_entry(istate, ce_namelen(ce));
>   	copy_cache_entry(updated, ce);
>   	memcpy(updated->name, ce->name, ce->ce_namelen + 1);
>   	fill_stat_cache_info(updated, &st);
> @@ -1610,12 +1641,13 @@ int read_index(struct index_state *istate)
>   	return read_index_from(istate, get_index_file(), get_git_dir());
>   }
>   
> -static struct cache_entry *cache_entry_from_ondisk(struct ondisk_cache_entry *ondisk,
> +static struct cache_entry *cache_entry_from_ondisk(struct index_state *istate,
> +						   struct ondisk_cache_entry *ondisk,
>   						   unsigned int flags,
>   						   const char *name,
>   						   size_t len)
>   {
> -	struct cache_entry *ce = xmalloc(cache_entry_size(len));
> +	struct cache_entry *ce = make_empty_index_cache_entry(istate, len);
>   
>   	ce->ce_stat_data.sd_ctime.sec = get_be32(&ondisk->ctime.sec);
>   	ce->ce_stat_data.sd_mtime.sec = get_be32(&ondisk->mtime.sec);
> @@ -1657,7 +1689,8 @@ static unsigned long expand_name_field(struct strbuf *name, const char *cp_)
>   	return (const char *)ep + 1 - cp_;
>   }
>   
> -static struct cache_entry *create_from_disk(struct ondisk_cache_entry *ondisk,
> +static struct cache_entry *create_from_disk(struct index_state *istate,
> +					    struct ondisk_cache_entry *ondisk,
>   					    unsigned long *ent_size,
>   					    struct strbuf *previous_name)

Nit. Just wondering why you pulled refresh_cache_entry() out into an 
earlier/separate commit but then did create_from_disk() as part of the 
large refactoring focused on adding the create/discard APIs?

<snip>

> diff --git a/unpack-trees.c b/unpack-trees.c
> index e73745051e..232cdecc72 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -192,10 +192,10 @@ static int do_add_entry(struct unpack_trees_options *o, struct cache_entry *ce,
>   			       ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE);
>   }
>   
> -static struct cache_entry *dup_entry(const struct cache_entry *ce)
> +static struct cache_entry *dup_entry(const struct cache_entry *ce, struct index_state *istate)

Ditto with the dup_entry() and create_ce_entry() functions refactoring.

> -static struct cache_entry *create_ce_entry(const struct traverse_info *info, const struct name_entry *n, int stage)
> +static struct cache_entry *create_ce_entry(const struct traverse_info *info,
> +	const struct name_entry *n,
> +	int stage,
> +	struct index_state *istate,
> +	int is_transient)
