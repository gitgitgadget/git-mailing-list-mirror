Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 655921F461
	for <e@80x24.org>; Sat, 24 Aug 2019 12:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbfHXMiS (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Aug 2019 08:38:18 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40608 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727779AbfHXMiS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Aug 2019 08:38:18 -0400
Received: by mail-wr1-f67.google.com with SMTP id c3so10985877wrd.7
        for <git@vger.kernel.org>; Sat, 24 Aug 2019 05:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vOMXOqdz6GnDZ4w09o6Fe/v6OnCjNwxOObhWkFBvjqE=;
        b=ThDEsoos912+uPEz8iaV56w9h4YjYPXazSXDCy4GuwKuriM++usKUcZJrXn4JUEhk1
         4NCEKvmrHqVhnCjdU1dIlmkFhG3O1CKVpTmMmUB98yhEvtk2PPEsi+lNoUoN53Gd8S56
         qnI3+bbfqDyQZm/OQjjyZmSGjWHnoUtBL2p5tPlBS/lht3/ml1JDBoxosC1wwebyGqiW
         ys2tfNnsmIDVGRIKcp5YtZqNNSWX/HpjETJB40qsiVZU/i+Ob+ZlB0iSUuvhDFJqSzyN
         dZIBXkztrDbbARzWZyCpyCt9ftvwbyEo1WPvOsKpldS+1WtFp1Wk5fJ0t09mEMOLCzER
         mPtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vOMXOqdz6GnDZ4w09o6Fe/v6OnCjNwxOObhWkFBvjqE=;
        b=uf0FhNra8h44GqV/OnoAaRKPd1ALsimqIdOOVInn/MtpXkzwZT9ACI4WIdcUycGr6H
         vGs+sliNHQPn/WpLLnC+PXRjkszrld7S5Gunob3mbG3K58/hN2TPJ8B8Oky76qgvxMAo
         FbrzBY1U8TfifSThMS3Gv/+P5jg1gVINAHn7HFCjMG195Kof5d0Kk/XB1Q24/QBBriEw
         dc//fTn0iAxmmlvNfqtolUzuunw3gP6AtMCtrcuT/tuN/DZyFFysfAVuiLHTOIYRtr73
         MMFaPxSfCp9AK/JksVdjZN5gBjr45cIMPE6Wup6vcSPse716gYrTKvLU1EJePOoKfRlU
         lJrg==
X-Gm-Message-State: APjAAAWBmx955nmFADanbD2Xqfnm6Mx7vmxO2mwgAhMYKheUJhoJifsv
        VaSbSGKvSzh56wVIquYyeUk=
X-Google-Smtp-Source: APXvYqzrUjKCsOnusZdM8itxeLJnEYyIOQ5LjiCJKJrT50eWs20METKkWi6tejH5Vo4XktkNjtUwsA==
X-Received: by 2002:a5d:4492:: with SMTP id j18mr10757139wrq.53.1566650294697;
        Sat, 24 Aug 2019 05:38:14 -0700 (PDT)
Received: from szeder.dev (x4db936d2.dyn.telefonica.de. [77.185.54.210])
        by smtp.gmail.com with ESMTPSA id b4sm6253274wma.5.2019.08.24.05.38.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Aug 2019 05:38:13 -0700 (PDT)
Date:   Sat, 24 Aug 2019 14:38:11 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Slavica Djukic via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Slavica Djukic <slawica92@hotmail.com>
Subject: Re: [PATCH v3 07/11] Add a function to determine unique prefixes for
 a list of strings
Message-ID: <20190824123811.GL20404@szeder.dev>
References: <pull.170.v2.git.gitgitgadget@gmail.com>
 <pull.170.v3.git.gitgitgadget@gmail.com>
 <3000d7d08dfb64511b4ebf9d05617897dd7252f7.1563289115.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3000d7d08dfb64511b4ebf9d05617897dd7252f7.1563289115.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 16, 2019 at 07:58:42AM -0700, Slavica Djukic via GitGitGadget wrote:
> In the `git add -i` command, we show unique prefixes of the commands and
> files, to give an indication what prefix would select them.
> 
> Naturally, the C implementation looks a lot different than the Perl
> implementation: in Perl, a trie is much easier implemented, while we
> already have a pretty neat hashmap implementation in C that we use for
> the purpose of storing (not necessarily unique) prefixes.
> 
> The idea: for each item that we add, we generate prefixes starting with
> the first letter, then the first two letters, then three, etc, until we
> find a prefix that is unique (or until the prefix length would be
> longer than we want). If we encounter a previously-unique prefix on the
> way, we adjust that item's prefix to make it unique again (or we mark it
> as having no unique prefix if we failed to find one). These partial
> prefixes are stored in a hash map (for quick lookup times).
> 
> To make sure that this function works as expected, we add a test using a
> special-purpose test helper that was added for that purpose.
> 
> Note: We expect the list of prefix items to be passed in as a list of
> pointers rather than as regular list to avoid having to copy information
> (the actual items will most likely contain more information than just
> the name and the length of the unique prefix, but passing in `struct
> prefix_item *` would not allow for that).

> diff --git a/prefix-map.c b/prefix-map.c
> new file mode 100644
> index 0000000000..747ddb4ebc
> --- /dev/null
> +++ b/prefix-map.c
> @@ -0,0 +1,109 @@
> +#include "cache.h"
> +#include "prefix-map.h"
> +
> +static int map_cmp(const void *unused_cmp_data,
> +		   const void *entry,
> +		   const void *entry_or_key,
> +		   const void *unused_keydata)
> +{
> +	const struct prefix_map_entry *a = entry;
> +	const struct prefix_map_entry *b = entry_or_key;
> +
> +	return a->prefix_length != b->prefix_length ||
> +		strncmp(a->name, b->name, a->prefix_length);
> +}
> +
> +static void add_prefix_entry(struct hashmap *map, const char *name,
> +			     size_t prefix_length, struct prefix_item *item)
> +{
> +	struct prefix_map_entry *result = xmalloc(sizeof(*result));
> +	result->name = name;
> +	result->prefix_length = prefix_length;
> +	result->item = item;
> +	hashmap_entry_init(result, memhash(name, prefix_length));
> +	hashmap_add(map, result);
> +}
> +
> +static void init_prefix_map(struct prefix_map *prefix_map,
> +			    int min_prefix_length, int max_prefix_length)
> +{
> +	hashmap_init(&prefix_map->map, map_cmp, NULL, 0);
> +	prefix_map->min_length = min_prefix_length;
> +	prefix_map->max_length = max_prefix_length;
> +}
> +
> +static void add_prefix_item(struct prefix_map *prefix_map,
> +			    struct prefix_item *item)
> +{
> +	struct prefix_map_entry e = { { NULL } }, *e2;
> +	int j;
> +
> +	e.item = item;
> +	e.name = item->name;
> +
> +	for (j = prefix_map->min_length;
> +	     j <= prefix_map->max_length && e.name[j]; j++) {
> +		/* Avoid breaking UTF-8 multi-byte sequences */
> +		if (!isascii(e.name[j]))
> +			break;
> +
> +		e.prefix_length = j;
> +		hashmap_entry_init(&e, memhash(e.name, j));
> +		e2 = hashmap_get(&prefix_map->map, &e, NULL);
> +		if (!e2) {
> +			/* prefix is unique at this stage */
> +			item->prefix_length = j;
> +			add_prefix_entry(&prefix_map->map, e.name, j, item);
> +			break;
> +		}
> +
> +		if (!e2->item)
> +			continue; /* non-unique prefix */
> +
> +		if (j != e2->item->prefix_length || memcmp(e.name, e2->name, j))
> +			BUG("unexpected prefix length: %d != %d (%s != %s)",
> +			    j, (int)e2->item->prefix_length, e.name, e2->name);
> +
> +		/* skip common prefix */
> +		for (; j < prefix_map->max_length && e.name[j]; j++) {
> +			if (e.item->name[j] != e2->item->name[j])
> +				break;
> +			add_prefix_entry(&prefix_map->map, e.name, j + 1,
> +					 NULL);
> +		}
> +
> +		/* e2 no longer refers to a unique prefix */
> +		if (j < prefix_map->max_length && e2->name[j]) {
> +			/* found a new unique prefix for e2's item */
> +			e2->item->prefix_length = j + 1;
> +			add_prefix_entry(&prefix_map->map, e2->name, j + 1,
> +					 e2->item);
> +		}
> +		else
> +			e2->item->prefix_length = 0;
> +		e2->item = NULL;
> +
> +		if (j < prefix_map->max_length && e.name[j]) {
> +			/* found a unique prefix for the item */
> +			e.item->prefix_length = j + 1;
> +			add_prefix_entry(&prefix_map->map, e.name, j + 1,
> +					 e.item);
> +		} else
> +			/* item has no (short enough) unique prefix */
> +			e.item->prefix_length = 0;
> +
> +		break;
> +	}
> +}
> +
> +void find_unique_prefixes(struct prefix_item **list, size_t nr,
> +			  int min_length, int max_length)
> +{
> +	int i;
> +	struct prefix_map prefix_map;
> +
> +	init_prefix_map(&prefix_map, min_length, max_length);
> +	for (i = 0; i < nr; i++)
> +		add_prefix_item(&prefix_map, list[i]);
> +	hashmap_free(&prefix_map.map, 1);
> +}

Between the commit message, the in-code comment, the names of the new
files, and implementation I was left somewhat confused about what this
is about and how it works.  TBH, I didn't even try to understand how
all the above works, in particular the add_prefix_item() function.

However, I think it would be much-much simpler to first sort (a copy
of?) the array of prefix item pointers based on their 'name' field,
and then look for a unique prefix in each neighboring pair.  Perhaps
it would even be faster, because it doesn't have to allocate a bunch
of hashmap items, though I don't think that it matters much in
practice (i.e. I expect the number of items to be fairly small;
presumably nobody will run interactive add after a mass refactoring
modifying thousands of files).

> diff --git a/prefix-map.h b/prefix-map.h
> new file mode 100644
> index 0000000000..ce3b8a4a32
> --- /dev/null
> +++ b/prefix-map.h
> @@ -0,0 +1,40 @@
> +#ifndef PREFIX_MAP_H
> +#define PREFIX_MAP_H
>
> +#include "hashmap.h"
> +
> +struct prefix_item {
> +	const char *name;
> +	size_t prefix_length;
> +};

This struct is part of find_unique_prefixes()'s signature, good.

> +struct prefix_map_entry {
> +	struct hashmap_entry e;
> +	const char *name;
> +	size_t prefix_length;
> +	/* if item is NULL, the prefix is not unique */
> +	struct prefix_item *item;
> +};
> +
> +struct prefix_map {
> +	struct hashmap map;
> +	int min_length, max_length;
> +};

However, neither of these two structs nor the hashmap appear in the
function's signature, but are all implementation details.  Therefore,
they should not be defined and included here in the header but in the
.c source file.  (But as mentioned above, I think this could be
implemented much simpler without these data structures.)

Furthermore, this is not a map.
A map, in general, is a container of key-value pairs that allows
efficient insertion, removal and lookup.  This so-called prefix_map
does none of that, so it should not be called a map.

> +/*
> + * Find unique prefixes in a given list of strings.

... and stores the length of the unique prefixes in the
'prefix_length' field of the elements of the given array.

> + *
> + * Typically, the `struct prefix_item` information will be but a field in the

s/but //, perhaps?

> + * actual item struct; For this reason, the `list` parameter is specified as a
> + * list of pointers to the items.
> + *
> + * The `min_length`/`max_length` parameters define what length the unique
> + * prefixes should have.
> + *
> + * If no unique prefix could be found for a given item, its `prefix_length`
> + * will be set to 0.
> + */
> +void find_unique_prefixes(struct prefix_item **list, size_t nr,

The first argument is not a list but an array.

> +			  int min_length, int max_length);

size_t, perhaps?  These are closely related to
'prefix_item.prefix_length', which is already (rightfully) size_t.

> +
> +#endif
> diff --git a/t/helper/test-prefix-map.c b/t/helper/test-prefix-map.c
> new file mode 100644
> index 0000000000..3f1c90eaf0
> --- /dev/null
> +++ b/t/helper/test-prefix-map.c
> @@ -0,0 +1,58 @@
> +#include "test-tool.h"
> +#include "cache.h"
> +#include "prefix-map.h"
> +
> +static size_t test_count, failed_count;
> +
> +static void check(int succeeded, const char *file, size_t line_no,
> +		  const char *fmt, ...)
> +{
> +	va_list ap;
> +
> +	test_count++;
> +	if (succeeded)
> +		return;
> +
> +	va_start(ap, fmt);
> +	fprintf(stderr, "%s:%d: ", file, (int)line_no);
> +	vfprintf(stderr, fmt, ap);
> +	fputc('\n', stderr);
> +	va_end(ap);
> +
> +	failed_count++;
> +}
> +
> +#define EXPECT_SIZE_T_EQUALS(expect, actual, hint) \
> +	check(expect == actual, __FILE__, __LINE__, \
> +	      "size_t's do not match: %" \
> +	      PRIdMAX " != %" PRIdMAX " (%s) (%s)", \
> +	      (intmax_t)expect, (intmax_t)actual, #actual, hint)
> +
> +int cmd__prefix_map(int argc, const char **argv)
> +{
> +#define NR 5
> +	struct prefix_item items[NR] = {

You don't have to tell the compiler how many elements this array will
contain, it will figure that out on its own.

> +		{ "unique" },
> +		{ "hell" },
> +		{ "hello" },
> +		{ "wok" },
> +		{ "world" },
> +	};
> +	struct prefix_item *list[NR] = {

Likewise.

> +		items, items + 1, items + 2, items + 3, items + 4
> +	};
> +
> +	find_unique_prefixes(list, NR, 1, 3);

This could be find_unique_prefixes(list, ARRAY_SIZE(list), 1, 3), and
then there is no need for that NR macro anymore.

> +
> +#define EXPECT_PREFIX_LENGTH_EQUALS(expect, index) \
> +	EXPECT_SIZE_T_EQUALS(expect, list[index]->prefix_length, \
> +			     list[index]->name)
> +
> +	EXPECT_PREFIX_LENGTH_EQUALS(1, 0);
> +	EXPECT_PREFIX_LENGTH_EQUALS(0, 1);
> +	EXPECT_PREFIX_LENGTH_EQUALS(0, 2);
> +	EXPECT_PREFIX_LENGTH_EQUALS(3, 3);
> +	EXPECT_PREFIX_LENGTH_EQUALS(3, 4);
> +
> +	return !!failed_count;
> +}
