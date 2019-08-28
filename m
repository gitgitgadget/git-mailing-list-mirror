Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 348E31F461
	for <e@80x24.org>; Wed, 28 Aug 2019 16:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfH1Qaw (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 12:30:52 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51130 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfH1Qaw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 12:30:52 -0400
Received: by mail-wm1-f66.google.com with SMTP id v15so752853wml.0
        for <git@vger.kernel.org>; Wed, 28 Aug 2019 09:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=nESZQ+2OR3JI6AgiOFDzOHte75ILqc3RVQA5VcCKlhc=;
        b=iZfYKxU/liH/QhII8hS7Jm+PuVjjlJjM3jFX4bv7KI4hWe+0xxq8pEdrATXRbmbTvb
         btQlupo8vKIya1Dh9AD0nbw7o/vTH2KVDKTtTJtmu0Zqe5HgGNWBeyVXLT8ol+DiVX8Y
         TgYjI31Q/QC5Z8VwWJnsrYI614qrEE3dO3SZQ1bIS604TM5lO1aDMegJeUKfoWoWsDxj
         ObzjxyFal4vo+/tA1rKd5SHqW8eDUKsaBUpgxuzIYnHK4FqegmJhXYNOjoZ/QmU9pmXz
         sp3pRFKmqgwDzsW3R5gM+dCAD0eXw/Q9GbBfpAvFu1z7GYKYxX4WHKj9BUJGViqjGR+B
         l2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=nESZQ+2OR3JI6AgiOFDzOHte75ILqc3RVQA5VcCKlhc=;
        b=ucJqSU307DhIYTycu/iP/gpPfcSv+nemE9Jqg+5prOVIMICGEj785csyWh3z6L7Mt1
         lxms2oOQnfpehRLuOjHggtPF2CaLS0krxr1Bewn5ZOhBpd0A8wi1SYruT+rIbM5E9HHG
         nlRULyQRA2gOxsqtphTu1jRkeiROxlM2ngE/a9VeQBTbNw4F59dqsu8P6yt464ofYK2n
         OuRvbFSSgPu27sdur1E+wUlU3AX2MKAVJjKCu503SZ5rB8temg2LjSbVRy3SHootYo/I
         dGR8Byx1J/kxqbSfn/xGZouKR6kZeUZK5qukjUNTg0wn6JnaTi6kVtsA52OG1sgKyDRy
         jxqQ==
X-Gm-Message-State: APjAAAUsBq1vbRlExEIsl0mv9gFCgfj24G1X/5QCrQnLC6+GXdY68eeI
        KDpZEElq4k8h4t7uX3K+UrhcNQHG
X-Google-Smtp-Source: APXvYqxYWE/kUaSS7pwn5omEKGV/auefdtFie5/I7p2/uIiJhss8dkWByhKrI7KB0HhEw2yvtSLRfQ==
X-Received: by 2002:a1c:544e:: with SMTP id p14mr5702569wmi.4.1567009848443;
        Wed, 28 Aug 2019 09:30:48 -0700 (PDT)
Received: from szeder.dev (x4db66bea.dyn.telefonica.de. [77.182.107.234])
        by smtp.gmail.com with ESMTPSA id e9sm4045815wmd.25.2019.08.28.09.30.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2019 09:30:47 -0700 (PDT)
Date:   Wed, 28 Aug 2019 18:30:45 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Slavica Djukic via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Slavica Djukic <slawica92@hotmail.com>
Subject: Re: [PATCH v3 07/11] Add a function to determine unique prefixes for
 a list of strings
Message-ID: <20190828163045.GF8571@szeder.dev>
References: <pull.170.v2.git.gitgitgadget@gmail.com>
 <pull.170.v3.git.gitgitgadget@gmail.com>
 <3000d7d08dfb64511b4ebf9d05617897dd7252f7.1563289115.git.gitgitgadget@gmail.com>
 <20190824123811.GL20404@szeder.dev>
 <nycvar.QRO.7.76.6.1908271342140.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.1908271342140.46@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 27, 2019 at 02:14:06PM +0200, Johannes Schindelin wrote:
> Hi Gábor,
> 
> On Sat, 24 Aug 2019, SZEDER Gábor wrote:
> 
> > On Tue, Jul 16, 2019 at 07:58:42AM -0700, Slavica Djukic via GitGitGadget wrote:
> > > In the `git add -i` command, we show unique prefixes of the commands and
> > > files, to give an indication what prefix would select them.
> > >
> > > Naturally, the C implementation looks a lot different than the Perl
> > > implementation: in Perl, a trie is much easier implemented, while we
> > > already have a pretty neat hashmap implementation in C that we use for
> > > the purpose of storing (not necessarily unique) prefixes.
> > >
> > > The idea: for each item that we add, we generate prefixes starting with
> > > the first letter, then the first two letters, then three, etc, until we
> > > find a prefix that is unique (or until the prefix length would be
> > > longer than we want). If we encounter a previously-unique prefix on the
> > > way, we adjust that item's prefix to make it unique again (or we mark it
> > > as having no unique prefix if we failed to find one). These partial
> > > prefixes are stored in a hash map (for quick lookup times).
> > >
> > > To make sure that this function works as expected, we add a test using a
> > > special-purpose test helper that was added for that purpose.
> > >
> > > Note: We expect the list of prefix items to be passed in as a list of
> > > pointers rather than as regular list to avoid having to copy information
> > > (the actual items will most likely contain more information than just
> > > the name and the length of the unique prefix, but passing in `struct
> > > prefix_item *` would not allow for that).
> >
> > > diff --git a/prefix-map.c b/prefix-map.c
> > > new file mode 100644
> > > index 0000000000..747ddb4ebc
> > > --- /dev/null
> > > +++ b/prefix-map.c
> > > @@ -0,0 +1,109 @@
> > > +#include "cache.h"
> > > +#include "prefix-map.h"
> > > +
> > > +static int map_cmp(const void *unused_cmp_data,
> > > +		   const void *entry,
> > > +		   const void *entry_or_key,
> > > +		   const void *unused_keydata)
> > > +{
> > > +	const struct prefix_map_entry *a = entry;
> > > +	const struct prefix_map_entry *b = entry_or_key;
> > > +
> > > +	return a->prefix_length != b->prefix_length ||
> > > +		strncmp(a->name, b->name, a->prefix_length);
> > > +}
> > > +
> > > +static void add_prefix_entry(struct hashmap *map, const char *name,
> > > +			     size_t prefix_length, struct prefix_item *item)
> > > +{
> > > +	struct prefix_map_entry *result = xmalloc(sizeof(*result));
> > > +	result->name = name;
> > > +	result->prefix_length = prefix_length;
> > > +	result->item = item;
> > > +	hashmap_entry_init(result, memhash(name, prefix_length));
> > > +	hashmap_add(map, result);
> > > +}
> > > +
> > > +static void init_prefix_map(struct prefix_map *prefix_map,
> > > +			    int min_prefix_length, int max_prefix_length)
> > > +{
> > > +	hashmap_init(&prefix_map->map, map_cmp, NULL, 0);
> > > +	prefix_map->min_length = min_prefix_length;
> > > +	prefix_map->max_length = max_prefix_length;
> > > +}
> > > +
> > > +static void add_prefix_item(struct prefix_map *prefix_map,
> > > +			    struct prefix_item *item)
> > > +{
> > > +	struct prefix_map_entry e = { { NULL } }, *e2;
> > > +	int j;
> > > +
> > > +	e.item = item;
> > > +	e.name = item->name;
> > > +
> > > +	for (j = prefix_map->min_length;
> > > +	     j <= prefix_map->max_length && e.name[j]; j++) {
> > > +		/* Avoid breaking UTF-8 multi-byte sequences */

Ok, that's a good idea, but...

> > > +		if (!isascii(e.name[j]))
> > > +			break;

This doesn't seem right.  It just breaks the loop, potentially leaving
'item->prefix_length' set from the previous iteration.  Try the two
strings "123" and "12ő", in this order: they both get prefix_length =
3, i.e. the prefix ends between the two bytes of the multi-byte
character.

Furthermore, neither the docstring of find_unique_prefixes() nor the
commit message mention what is supposed to happen with paths with
multi-byte characters.  I think at least one of them should.

> > > +
> > > +		e.prefix_length = j;
> > > +		hashmap_entry_init(&e, memhash(e.name, j));
> > > +		e2 = hashmap_get(&prefix_map->map, &e, NULL);
> > > +		if (!e2) {
> > > +			/* prefix is unique at this stage */
> > > +			item->prefix_length = j;
> > > +			add_prefix_entry(&prefix_map->map, e.name, j, item);
> > > +			break;
> > > +		}
> > > +
> > > +		if (!e2->item)
> > > +			continue; /* non-unique prefix */
> > > +
> > > +		if (j != e2->item->prefix_length || memcmp(e.name, e2->name, j))
> > > +			BUG("unexpected prefix length: %d != %d (%s != %s)",
> > > +			    j, (int)e2->item->prefix_length, e.name, e2->name);
> > > +
> > > +		/* skip common prefix */
> > > +		for (; j < prefix_map->max_length && e.name[j]; j++) {
> > > +			if (e.item->name[j] != e2->item->name[j])
> > > +				break;
> > > +			add_prefix_entry(&prefix_map->map, e.name, j + 1,
> > > +					 NULL);
> > > +		}
> > > +
> > > +		/* e2 no longer refers to a unique prefix */
> > > +		if (j < prefix_map->max_length && e2->name[j]) {
> > > +			/* found a new unique prefix for e2's item */
> > > +			e2->item->prefix_length = j + 1;
> > > +			add_prefix_entry(&prefix_map->map, e2->name, j + 1,
> > > +					 e2->item);
> > > +		}
> > > +		else
> > > +			e2->item->prefix_length = 0;
> > > +		e2->item = NULL;
> > > +
> > > +		if (j < prefix_map->max_length && e.name[j]) {
> > > +			/* found a unique prefix for the item */
> > > +			e.item->prefix_length = j + 1;
> > > +			add_prefix_entry(&prefix_map->map, e.name, j + 1,
> > > +					 e.item);
> > > +		} else
> > > +			/* item has no (short enough) unique prefix */
> > > +			e.item->prefix_length = 0;
> > > +
> > > +		break;
> > > +	}
> > > +}
> > > +
> > > +void find_unique_prefixes(struct prefix_item **list, size_t nr,
> > > +			  int min_length, int max_length)
> > > +{
> > > +	int i;
> > > +	struct prefix_map prefix_map;
> > > +
> > > +	init_prefix_map(&prefix_map, min_length, max_length);
> > > +	for (i = 0; i < nr; i++)
> > > +		add_prefix_item(&prefix_map, list[i]);
> > > +	hashmap_free(&prefix_map.map, 1);
> > > +}
> >
> > Between the commit message, the in-code comment, the names of the new
> > files, and implementation I was left somewhat confused about what this
> > is about and how it works.  TBH, I didn't even try to understand how
> > all the above works, in particular the add_prefix_item() function.
> 
> Let me try to explain it here, and maybe you can help me by suggesting
> an improved commit message and/or code comments?
> 
> The problem is this: given a set of items with labels (e.g. file names),
> find, for each item, the unique prefix that identifies it. Example:
> given the files `hello.txt`, `heaven.txt` and `hell.txt`, the items'
> unique prefixes would be `hello`, `hea` and `hell.`, respectively.
> 
> In `git add -i`, we actually only want to allow alphanumerical prefixes,
> and we also want at least one, and at most three characters, so only the
> second item would have an admissible unique prefix: `hea`.

You say "at most three characters", but I notive that the call added
to 'add-interactive.c' in a later commit specifies 4.

I wonder what's the reason for the minimum prefix length, though.  I
mean, you can't really have a unique prefix shorter than one
character...

> > However, I think it would be much-much simpler to first sort (a copy
> > of?) the array of prefix item pointers based on their 'name' field,
> > and then look for a unique prefix in each neighboring pair.  Perhaps
> > it would even be faster, because it doesn't have to allocate a bunch
> > of hashmap items, though I don't think that it matters much in
> > practice (i.e. I expect the number of items to be fairly small;
> > presumably nobody will run interactive add after a mass refactoring
> > modifying thousands of files).
> 
> The time complexity of the sorted list would be O(n*log(n)), while the
> hashmap-based complexity would be an amortized O(n).

Oh, so you don't know how/why it works, either!? ;)

This hashmap-based implementation calls hashmap_get() approx.
n * (max_length - min_length) times.

Furthermore, depending on the strings and 'max_length', it can call
add_prefix_entry() more than n times.  E.g. the six strings "a1",
"a2", "ab1", "ab2", "abc1", "abc2", in this order, and max_length=4
result in 9 add_prefix_entry() calls.  And each add_prefix_entry()
call involves a memory allocation.

Ok, that's theory, let's see practice.

For a (very) quick'n'dirty performance test I replaced those five
items in 't/helper/test-prefix-map.c' with the output of:

  git -C ..../webkit.git/ ls-tree -r --name-only HEAD | sed -e 's/^/{ "/; s/$/" },/'

That's 280734 real paths.  Then a simple 'time test-tool prefix-map'
with the hashmap-based implementation ran for 0.055s, while using my
PoC sort-based algorithm it ran for 0.063s.  So while the
hashmap-based implementation is indeed faster, they are both well
below 0.1s, so in the context of 'git add -i' the performance
difference between the two approaches doesn't really matter.  

If we look beyond 'git add -i's requirements, and specify larger
max_length values, the hashmap-based implementation gets progressively
slower.  Already at max_length=5 it's a tad slower than the sort-based
implementation, and at 9 it takes twice as long.

The current hashmap-based implementation is ~50% more lines than my
sort-based PoC.  I'll send it out in a minute.

> And yes, you would not _want_ to run interactive add after a mass
> refactoring. But it happens. It happens to me more times than I care to
> admit. And you know what? I really appreciate that even the Perl version
> is relatively snappy in those circumstances.
> 
> > > diff --git a/prefix-map.h b/prefix-map.h
> > > new file mode 100644
> > > index 0000000000..ce3b8a4a32
> > > --- /dev/null
> > > +++ b/prefix-map.h
> > > @@ -0,0 +1,40 @@
> > > +#ifndef PREFIX_MAP_H
> > > +#define PREFIX_MAP_H
> > >
> > > +#include "hashmap.h"
> > > +
> > > +struct prefix_item {
> > > +	const char *name;
> > > +	size_t prefix_length;
> > > +};
> >
> > This struct is part of find_unique_prefixes()'s signature, good.
> >
> > > +struct prefix_map_entry {
> > > +	struct hashmap_entry e;
> > > +	const char *name;
> > > +	size_t prefix_length;
> > > +	/* if item is NULL, the prefix is not unique */
> > > +	struct prefix_item *item;
> > > +};
> > > +
> > > +struct prefix_map {
> > > +	struct hashmap map;
> > > +	int min_length, max_length;
> > > +};
> >
> > However, neither of these two structs nor the hashmap appear in the
> > function's signature, but are all implementation details.  Therefore,
> > they should not be defined and included here in the header but in the
> > .c source file.  (But as mentioned above, I think this could be
> > implemented much simpler without these data structures.)
> 
> Right you are!
> 
> > Furthermore, this is not a map.
> > A map, in general, is a container of key-value pairs that allows
> > efficient insertion, removal and lookup.  This so-called prefix_map
> > does none of that, so it should not be called a map.
> 
> What would you call it instead?

Well, I would rather get rid of it in the first place :)

In my PoC I called the files 'unique-prefix.{c,h}'.

> > > +/*
> > > + * Find unique prefixes in a given list of strings.
> >
> > ... and stores the length of the unique prefixes in the
> > 'prefix_length' field of the elements of the given array.
> 
> Good idea. I changed it to also explain what is meant by "unique
> prefix":
> 
>  * Given a list of names, find unique prefixes (i.e. the first <n> characters
>  * that uniquely identify the names) and store the lengths of the unique
>  * prefixes in the 'prefix_length' field of the elements of the given array..

Sounds good.

> > > + *
> > > + * Typically, the `struct prefix_item` information will be but a field in the

> > > + * actual item struct; For this reason, the `list` parameter is specified as a
> > > + * list of pointers to the items.
> > > + *
> > > + * The `min_length`/`max_length` parameters define what length the unique
> > > + * prefixes should have.
> > > + *
> > > + * If no unique prefix could be found for a given item, its `prefix_length`
> > > + * will be set to 0.

I ran into cases where the hashmap-based implementation didn't set
'prefix_length' to 0 when it, in my opinion, should have, but left it
untouched.  Just try any string shorter than 'min_length'.

May or may not be related: try "ab", "ab", "abc", in this order: both
"ab" get their 'prefix_length' set to 0, as they should, but the
'prefix_length' of "abc" is left untouched, although it should be set
to 3.

Hmm, now that I've mentioned "in this order" three times already:
another benefit of the sort-based approach is that the order of
elements doesn't matter.

> > > + */
> > > +void find_unique_prefixes(struct prefix_item **list, size_t nr,
> >
> > The first argument is not a list but an array.
> 
> Indeed.
> 
> > > +			  int min_length, int max_length);
> >
> > size_t, perhaps?  These are closely related to
> > 'prefix_item.prefix_length', which is already (rightfully) size_t.
> 
> True.
> 
> > > +#endif
> > > diff --git a/t/helper/test-prefix-map.c b/t/helper/test-prefix-map.c
> > > new file mode 100644
> > > index 0000000000..3f1c90eaf0
> > > --- /dev/null
> > > +++ b/t/helper/test-prefix-map.c
> > > @@ -0,0 +1,58 @@
> > > +#include "test-tool.h"
> > > +#include "cache.h"
> > > +#include "prefix-map.h"
> > > +
> > > +static size_t test_count, failed_count;
> > > +
> > > +static void check(int succeeded, const char *file, size_t line_no,
> > > +		  const char *fmt, ...)
> > > +{
> > > +	va_list ap;
> > > +
> > > +	test_count++;
> > > +	if (succeeded)
> > > +		return;
> > > +
> > > +	va_start(ap, fmt);
> > > +	fprintf(stderr, "%s:%d: ", file, (int)line_no);
> > > +	vfprintf(stderr, fmt, ap);
> > > +	fputc('\n', stderr);
> > > +	va_end(ap);
> > > +
> > > +	failed_count++;
> > > +}
> > > +
> > > +#define EXPECT_SIZE_T_EQUALS(expect, actual, hint) \
> > > +	check(expect == actual, __FILE__, __LINE__, \
> > > +	      "size_t's do not match: %" \
> > > +	      PRIdMAX " != %" PRIdMAX " (%s) (%s)", \
> > > +	      (intmax_t)expect, (intmax_t)actual, #actual, hint)
> > > +
> > > +int cmd__prefix_map(int argc, const char **argv)
> > > +{
> > > +#define NR 5
> > > +	struct prefix_item items[NR] = {
> >
> > You don't have to tell the compiler how many elements this array will
> > contain, it will figure that out on its own.
> >
> > > +		{ "unique" },
> > > +		{ "hell" },
> > > +		{ "hello" },
> > > +		{ "wok" },
> > > +		{ "world" },
> > > +	};
> > > +	struct prefix_item *list[NR] = {
> >
> > Likewise.
> 
> That is correct.
> 
> What the compiler _cannot_ figure out, on its own, however, is that
> `items` and `list` _need_ to contain the same number of items.
> 
> Hence the need for `NR`.

OK, that's a good point.  I'd still like to get rid of that NR with
something like this instead:

  struct prefix_item items[] = { .... };
  struct prefix_item *list[ARRAY_SIZE(items)];
  for (i = 0; i < ARRAY_SIZE(items); i++) {
      list[i] = &items[i];
      list[i]->prefix_length = 12345; /* dummy */
  }
  find_unique_prefixes(list, ARRAY_SIZE(list), 0, 3);

Note the dummy value, to catch cases when 'prefix_length' is left
untouched.

This made this test tool more convenient to use, because I didn't have
to fiddle with NR and, worse, with those 'items, items+1, items+N'.

It's still a bit PITA (having to re-build each time I change the test
vector), though, compared to driving it from stdin and verifying it
through its stdout.

> > > +		items, items + 1, items + 2, items + 3, items + 4
> > > +	};
> > > +
> > > +	find_unique_prefixes(list, NR, 1, 3);
> >
> > This could be find_unique_prefixes(list, ARRAY_SIZE(list), 1, 3), and
> > then there is no need for that NR macro anymore.
> >
> > > +
> > > +#define EXPECT_PREFIX_LENGTH_EQUALS(expect, index) \
> > > +	EXPECT_SIZE_T_EQUALS(expect, list[index]->prefix_length, \
> > > +			     list[index]->name)
> > > +
> > > +	EXPECT_PREFIX_LENGTH_EQUALS(1, 0);
> > > +	EXPECT_PREFIX_LENGTH_EQUALS(0, 1);
> > > +	EXPECT_PREFIX_LENGTH_EQUALS(0, 2);
> > > +	EXPECT_PREFIX_LENGTH_EQUALS(3, 3);
> > > +	EXPECT_PREFIX_LENGTH_EQUALS(3, 4);
> > > +
> > > +	return !!failed_count;
> > > +}
> 
> Thank you for your review!
> Dscho

