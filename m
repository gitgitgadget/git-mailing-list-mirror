Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CAB020281
	for <e@80x24.org>; Mon,  2 Oct 2017 23:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751019AbdJBXsw (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 19:48:52 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:44584 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750846AbdJBXsv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 19:48:51 -0400
Received: by mail-pg0-f54.google.com with SMTP id b1so2289704pge.1
        for <git@vger.kernel.org>; Mon, 02 Oct 2017 16:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FwUdsjRRSWSH1l+WKPhsLB4MkyaNqRoCm/foB541bZ0=;
        b=cNsto72rOAIU894EIOdCOPnR+yQk6Ik7PgdkESutG4fqDLx/1VIuZzupjArB8m8aSB
         LqpyHNjco+PahBlQHvYKdwWGguVr1KoQhJFtd+f5qDJZFknX318GvPtYm/vDSZStWCLB
         4ZNOXAiEjEwqYXjM6rwOJT9PdAeO7que3C3eKn/NJxVW6MX1JMQI3cLeU8DRTKh5XBLZ
         9w/mlVXRJ6WV6EdJl1DSwoGbzYmu4RqUXhuC5oNSK4t4MYny2MkSEWm7l3McRhORSGLp
         +6MDNCdRttdGtPTMyvvWBNVWERXBAnhOn/xp0s0IhWppuSEAAHnxU/2uqMMiol6LLIcZ
         mzxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FwUdsjRRSWSH1l+WKPhsLB4MkyaNqRoCm/foB541bZ0=;
        b=NqmgUGaUOOq2ywZxc584LI5nncG5vBfz2MdBsKBGqL35kNuy7Sk9Ecjk92rJQEpUcT
         GCALaaYZA+CwgJfcT4cXh26w9V48ywd+1FRGGch/bEQ+uQcp+Oj5Psl2ql+9yBUh7upF
         ZyCiKFMLluwUi8rCfEf5JA+cL3u9uhkwKafiwI4htX6/1RSJU6JRpEKCW95/Yn44wWRN
         RI4fF9d5NbeGWf0Qa+PiHvYaA7SVH6/ALZ05TRo+lo36uBEUZpePIofww0P7ZJFSceWu
         Db6hujJ5UPlmcA7FsvJ/8EfWP7gH/x+xOYDkCE1jFK0EVPd1o1HZS56ZQw4MwhwU5nWn
         HkfA==
X-Gm-Message-State: AHPjjUj/YLbK8P8KI9RI1P1CWk1QLMidVZexTvwm6ZOZfnGzWPbBzTmY
        Z+w/hTj01e6s7y2HWo51viXlkS6i94Q=
X-Google-Smtp-Source: AOwi7QCE2fJYGEKfFabLEUJxrh67s6g7sl2r7auSymuZaPMti9busx05/FgOP+3KjF0nKy5b30MOUw==
X-Received: by 10.98.101.4 with SMTP id z4mr15663929pfb.6.1506988130424;
        Mon, 02 Oct 2017 16:48:50 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:585e:6aa2:d831:b9e9])
        by smtp.gmail.com with ESMTPSA id s81sm20678869pfg.162.2017.10.02.16.48.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 02 Oct 2017 16:48:49 -0700 (PDT)
Date:   Mon, 2 Oct 2017 16:48:48 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Subject: Re: [PATCH v2] oidmap: map with OID as key
Message-ID: <20171002234848.GG5189@google.com>
References: <20170927221910.164552-1-jonathantanmy@google.com>
 <20170929225422.81467-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170929225422.81467-1-jonathantanmy@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/29, Jonathan Tan wrote:
> This is similar to using the hashmap in hashmap.c, but with an
> easier-to-use API. In particular, custom entry comparisons no longer
> need to be written, and lookups can be done without constructing a
> temporary entry structure.
> 
> This is implemented as a thin wrapper over the hashmap API. In
> particular, this means that there is an additional 4-byte overhead due
> to the fact that the first 4 bytes of the hash is redundantly stored.
> For now, I'm taking the simpler approach, but if need be, we can
> reimplement oidmap without affecting the callers significantly.
> 
> oidset has been updated to use oidmap.
> 
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> Some replies to v1 [1] [2] seem to indicate that simpler non-duplicated
> code should be preferred over optimizing away the storage of the 4-byte
> hash code, and I have no objection to that, so I have updated this code
> to be a thin wrapper over hashmap with the 4-byte overhead.
> 
> After this patch, if the 4-byte overhead is found to be too much, we can
> migrate to something similar to v1 relatively easily.
> 
> I decided not to go with the util pointer method because we will not be
> able to migrate away from it so easily if need be.

This makes me a bit sad because I tend to lean more towards making
things simpler.  I'm still a supporter of the 'util' pointer but I
understand why we would choose otherwise.

> 
> [1] https://public-inbox.org/git/xmqqr2ur348z.fsf@gitster.mtv.corp.google.com/
> [2] https://public-inbox.org/git/20170929192624.4ukvpjujgiyzgibb@sigill.intra.peff.net/
> ---
>  Makefile     |  1 +
>  fetch-pack.c |  2 +-
>  oidmap.c     | 51 +++++++++++++++++++++++++++++++++++++++++++++
>  oidmap.h     | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  oidset.c     | 36 +++++++-------------------------
>  oidset.h     |  6 ++++--
>  6 files changed, 133 insertions(+), 31 deletions(-)
>  create mode 100644 oidmap.c
>  create mode 100644 oidmap.h
> 
> diff --git a/Makefile b/Makefile
> index ed4ca438b..64136dde4 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -821,6 +821,7 @@ LIB_OBJS += notes-cache.o
>  LIB_OBJS += notes-merge.o
>  LIB_OBJS += notes-utils.o
>  LIB_OBJS += object.o
> +LIB_OBJS += oidmap.o
>  LIB_OBJS += oidset.o
>  LIB_OBJS += packfile.o
>  LIB_OBJS += pack-bitmap.o
> diff --git a/fetch-pack.c b/fetch-pack.c
> index 105506e9a..008b25d3d 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -611,7 +611,7 @@ static int tip_oids_contain(struct oidset *tip_oids,
>  	 * add to "newlist" between calls, the additions will always be for
>  	 * oids that are already in the set.
>  	 */
> -	if (!tip_oids->map.tablesize) {
> +	if (!tip_oids->map.map.tablesize) {
>  		add_refs_to_oidset(tip_oids, unmatched);
>  		add_refs_to_oidset(tip_oids, newlist);
>  	}
> diff --git a/oidmap.c b/oidmap.c
> new file mode 100644
> index 000000000..6db4fffcd
> --- /dev/null
> +++ b/oidmap.c
> @@ -0,0 +1,51 @@
> +#include "cache.h"
> +#include "oidmap.h"
> +
> +static int cmpfn(const void *hashmap_cmp_fn_data,
> +		 const void *entry, const void *entry_or_key,
> +		 const void *keydata)
> +{
> +	const struct oidmap_entry *entry_ = entry;
> +	if (keydata)
> +		return oidcmp(&entry_->oid, (const struct object_id *) keydata);
> +	return oidcmp(&entry_->oid,
> +		      &((const struct oidmap_entry *) entry_or_key)->oid);
> +}
> +
> +static int hash(const struct object_id *oid)
> +{
> +	int hash;
> +	memcpy(&hash, oid->hash, sizeof(hash));
> +	return hash;
> +}
> +
> +void oidmap_init(struct oidmap *map, size_t initial_size)
> +{
> +	hashmap_init(&map->map, cmpfn, NULL, initial_size);
> +}
> +
> +void oidmap_free(struct oidmap *map, int free_entries)
> +{
> +	if (!map)
> +		return;
> +	hashmap_free(&map->map, free_entries);
> +}
> +
> +void *oidmap_get(const struct oidmap *map, const struct object_id *key)
> +{
> +	return hashmap_get_from_hash(&map->map, hash(key), key);
> +}
> +
> +void *oidmap_remove(struct oidmap *map, const struct object_id *key)
> +{
> +	struct hashmap_entry entry;
> +	hashmap_entry_init(&entry, hash(key));
> +	return hashmap_remove(&map->map, &entry, key);
> +}
> +
> +void *oidmap_put(struct oidmap *map, void *entry)
> +{
> +	struct oidmap_entry *to_put = entry;
> +	hashmap_entry_init(&to_put->internal_entry, hash(&to_put->oid));
> +	return hashmap_put(&map->map, to_put);
> +}
> diff --git a/oidmap.h b/oidmap.h
> new file mode 100644
> index 000000000..18f54cde1
> --- /dev/null
> +++ b/oidmap.h
> @@ -0,0 +1,68 @@
> +#ifndef OIDMAP_H
> +#define OIDMAP_H
> +
> +#include "hashmap.h"
> +
> +/*
> + * struct oidmap_entry is a structure representing an entry in the hash table,
> + * which must be used as first member of user data structures.
> + *
> + * Users should set the oid field. oidmap_put() will populate the
> + * internal_entry field.
> + */
> +struct oidmap_entry {
> +	/* For internal use only */
> +	struct hashmap_entry internal_entry;
> +
> +	struct object_id oid;
> +};
> +
> +struct oidmap {
> +	struct hashmap map;
> +};
> +
> +#define OIDMAP_INIT { { NULL } }
> +
> +/*
> + * Initializes an oidmap structure.
> + *
> + * `map` is the oidmap to initialize.
> + *
> + * If the total number of entries is known in advance, the `initial_size`
> + * parameter may be used to preallocate a sufficiently large table and thus
> + * prevent expensive resizing. If 0, the table is dynamically resized.
> + */
> +extern void oidmap_init(struct oidmap *map, size_t initial_size);
> +
> +/*
> + * Frees an oidmap structure and allocated memory.
> + *
> + * If `free_entries` is true, each oidmap_entry in the map is freed as well
> + * using stdlibs free().
> + */
> +extern void oidmap_free(struct oidmap *map, int free_entries);
> +
> +/*
> + * Returns the oidmap entry for the specified oid, or NULL if not found.
> + */
> +extern void *oidmap_get(const struct oidmap *map,
> +			const struct object_id *key);
> +
> +/*
> + * Adds or replaces an oidmap entry.
> + *
> + * ((struct oidmap_entry *) entry)->internal_entry will be populated by this
> + * function.
> + *
> + * Returns the replaced entry, or NULL if not found (i.e. the entry was added).
> + */
> +extern void *oidmap_put(struct oidmap *map, void *entry);
> +
> +/*
> + * Removes an oidmap entry matching the specified oid.
> + *
> + * Returns the removed entry, or NULL if not found.
> + */
> +extern void *oidmap_remove(struct oidmap *map, const struct object_id *key);
> +
> +#endif
> diff --git a/oidset.c b/oidset.c
> index a6a08ba52..f1f874aaa 100644
> --- a/oidset.c
> +++ b/oidset.c
> @@ -1,50 +1,30 @@
>  #include "cache.h"
>  #include "oidset.h"
>  
> -struct oidset_entry {
> -	struct hashmap_entry hash;
> -	struct object_id oid;
> -};
> -
> -static int oidset_hashcmp(const void *unused_cmp_data,
> -			  const void *va, const void *vb,
> -			  const void *vkey)
> -{
> -	const struct oidset_entry *a = va, *b = vb;
> -	const struct object_id *key = vkey;
> -	return oidcmp(&a->oid, key ? key : &b->oid);
> -}
> -
>  int oidset_contains(const struct oidset *set, const struct object_id *oid)
>  {
> -	struct hashmap_entry key;
> -
> -	if (!set->map.cmpfn)
> +	if (!set->map.map.tablesize)
>  		return 0;
> -
> -	hashmap_entry_init(&key, sha1hash(oid->hash));
> -	return !!hashmap_get(&set->map, &key, oid);
> +	return !!oidmap_get(&set->map, oid);
>  }
>  
>  int oidset_insert(struct oidset *set, const struct object_id *oid)
>  {
> -	struct oidset_entry *entry;
> -
> -	if (!set->map.cmpfn)
> -		hashmap_init(&set->map, oidset_hashcmp, NULL, 0);
> +	struct oidmap_entry *entry;
>  
> -	if (oidset_contains(set, oid))
> +	if (!set->map.map.tablesize)
> +		oidmap_init(&set->map, 0);
> +	else if (oidset_contains(set, oid))
>  		return 1;
>  
>  	entry = xmalloc(sizeof(*entry));
> -	hashmap_entry_init(&entry->hash, sha1hash(oid->hash));
>  	oidcpy(&entry->oid, oid);
>  
> -	hashmap_add(&set->map, entry);
> +	oidmap_put(&set->map, entry);
>  	return 0;
>  }
>  
>  void oidset_clear(struct oidset *set)
>  {
> -	hashmap_free(&set->map, 1);
> +	oidmap_free(&set->map, 1);
>  }
> diff --git a/oidset.h b/oidset.h
> index b7eaab5b8..f4c9e0f9c 100644
> --- a/oidset.h
> +++ b/oidset.h
> @@ -1,6 +1,8 @@
>  #ifndef OIDSET_H
>  #define OIDSET_H
>  
> +#include "oidmap.h"
> +
>  /**
>   * This API is similar to sha1-array, in that it maintains a set of object ids
>   * in a memory-efficient way. The major differences are:
> @@ -17,10 +19,10 @@
>   * A single oidset; should be zero-initialized (or use OIDSET_INIT).
>   */
>  struct oidset {
> -	struct hashmap map;
> +	struct oidmap map;
>  };
>  
> -#define OIDSET_INIT { { NULL } }
> +#define OIDSET_INIT { OIDMAP_INIT }
>  
>  /**
>   * Returns true iff `set` contains `oid`.
> -- 
> 2.14.2.822.g60be5d43e6-goog
> 

-- 
Brandon Williams
