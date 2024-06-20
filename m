Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF3E19DF51
	for <git@vger.kernel.org>; Thu, 20 Jun 2024 09:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718876752; cv=none; b=giNue7dRjhCagDRAeXkVs12spFf12OS2y7e09XdF65OW5asqWI388ILFp5zBuIJEX3vluefqykZu40mKqwSH973mJJOPI7Fstayz56O23zO++4Ad9Oj0/R5HDCriW09l+WRpOsxGkPh6MaiTI/TbiewGc1WCaynn4wf2YA4T8yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718876752; c=relaxed/simple;
	bh=c3tveax7Zc9D5mx3+6Gj/ds6a0G+7x3kQ5hUWzaZoU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FmCpIWQI3uu6b3oAjBkEBqnLpfxyD3JGkmpZAFJTMWOvRVWUM/RvpNboAaX+Kqm2A5i/aJMkm1J35EXA/JCVdZi93UGjrdykbKD9jjJpMaT1dAK2B7NpORgaawJWH664mpLCoI/bbyNmM0hAanBQ2nWwM/0cqHnENU2gYREeqL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kk73/kSw; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kk73/kSw"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2c2d25b5432so569972a91.2
        for <git@vger.kernel.org>; Thu, 20 Jun 2024 02:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718876750; x=1719481550; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KYSX9zBzyXKpxZC8p+RbAG3uQ8Nk6QLe7c+AjLMTrpU=;
        b=Kk73/kSwOpqqNhoJZ71iOWH43hE6vHUG+zhxIhHVN0bChb+r2a15NnpSRMAMb5oz20
         LyElXHh1Sus6UREPbDzytjXNL9+NCAA8uViYwa3RTKNPk2vZ8OL54EQv9rQ4rzHNCU+q
         Cbz6CWUYx6KjELW09CUdPiS9SO2c5kmqpoxGtfzv/eRR1NaQHOMYFEQOk4zlfBZNQ7Wh
         8fjcpeTqQ9a4Q9MApN6QAhxJWTN4V7ZQQUdOhNmMOo1w+q/Ynfb4xn+kaCdWN+G/IAqt
         NzSWc6HMxHwWx5XCfjRbRq6b8Ul20amfprZS2HM4hp02kY+umt7V5AcnZpt4VT2cwzm1
         yzPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718876750; x=1719481550;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KYSX9zBzyXKpxZC8p+RbAG3uQ8Nk6QLe7c+AjLMTrpU=;
        b=WOuIoxINhT2eOXAYqU798sbkN3/dEeMne/VbiKGIrn+uqlsQIEwqPv9fOA+2O0f2bp
         9hNMZlr2d9+NDBHKBKBBfceB9ncqotgD/qIQhU/viHglisRYGbHQ3XCy0ficz24YOBoD
         +79/CdjirBSq5bDKyAaSLJf86Mcxq02IbBd/cd9AlVX/RUmgdN3Fo6awQwVYN3T7WDTf
         KRjSXKbHb5CsnDFO4KfqRsz3L1xEI7BCVcHHlpbzvpcrOvXxFhqgFoO7+iyd2byMhSQ/
         eVk6lwKUg0ggoqZ7kLAaLuDlu0xlyOL/DXNlTOQUFhfDgtyzQW2Ejx6uNtwFc47ltX8B
         dEBQ==
X-Gm-Message-State: AOJu0Yzl9kQ2gIpc8Rv3wJ9aNJYlvdKOda2Tg6Ysj9ZlFYXvXhM6a7Zh
	9hFc9NAdSPeueSLZaMv5OHkOq44jhtin6axV2lX6lf4fjYqK5/3R
X-Google-Smtp-Source: AGHT+IEhtvUHc/gW498dj0zjMSTqaNTebG3POUgXST0WUzcOUANTSDoQFmpWVZ1s0tojOUf8nIVjxw==
X-Received: by 2002:a17:90a:f3c5:b0:2c3:195b:dc2e with SMTP id 98e67ed59e1d1-2c7b57fefacmr5086824a91.9.1718876749961;
        Thu, 20 Jun 2024 02:45:49 -0700 (PDT)
Received: from google.com (182.51.125.34.bc.googleusercontent.com. [34.125.51.182])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c7e56d5d31sm1236978a91.27.2024.06.20.02.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 02:45:49 -0700 (PDT)
Date: Thu, 20 Jun 2024 11:45:47 +0200
From: Jonathan Nieder <jrnieder@gmail.com>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Christian Couder <chriscool@tuxfamily.org>,
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
	Josh Steadmon <steadmon@google.com>
Subject: Re: [GSoC][PATCH] t: migrate helper/test-oidmap.c to
 unit-tests/t-oidmap.c
Message-ID: <ZnP6G6SSBynlBNUj@google.com>
References: <20240619175036.64291-1-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619175036.64291-1-shyamthakkar001@gmail.com>

Ghanshyam Thakkar wrote:

> helper/test-oidmap.c along with t0016-oidmap.sh test the oidmap.h
> library which is built on top of hashmap.h to store arbitrary
> datastructure (which must contain oidmap_entry, which is a wrapper
> around object_id). These entries can be accessed by querying their
> associated object_id.
>
> Migrate them to the unit testing framework for better performance,
> concise code and better debugging. Along with the migration also plug
> memory leaks and make the test logic independent for all the tests.
> The migration removes 'put' tests from t0016, because it is used as
> setup to all the other tests, so testing it separately does not yield
> any benefit.
>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
> ---
> This patch is depenedent on 'gt/unit-test-oidtree' for lib-oid.

Very neat!  I'm cc-ing Josh Steadmon for unit test framework expertise.

Patch left unsnipped for reference.

>  Makefile                |   2 +-
>  t/helper/test-oidmap.c  | 123 ------------------------------
>  t/helper/test-tool.c    |   1 -
>  t/helper/test-tool.h    |   1 -
>  t/t0016-oidmap.sh       | 112 ---------------------------
>  t/unit-tests/t-oidmap.c | 165 ++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 166 insertions(+), 238 deletions(-)
>  delete mode 100644 t/helper/test-oidmap.c
>  delete mode 100755 t/t0016-oidmap.sh
>  create mode 100644 t/unit-tests/t-oidmap.c
> 
> diff --git a/Makefile b/Makefile
> index 03751e0fc0..f7ed50f3a9 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -810,7 +810,6 @@ TEST_BUILTINS_OBJS += test-match-trees.o
>  TEST_BUILTINS_OBJS += test-mergesort.o
>  TEST_BUILTINS_OBJS += test-mktemp.o
>  TEST_BUILTINS_OBJS += test-oid-array.o
> -TEST_BUILTINS_OBJS += test-oidmap.o
>  TEST_BUILTINS_OBJS += test-online-cpus.o
>  TEST_BUILTINS_OBJS += test-pack-mtimes.o
>  TEST_BUILTINS_OBJS += test-parse-options.o
> @@ -1334,6 +1333,7 @@ THIRD_PARTY_SOURCES += sha1dc/%
>  
>  UNIT_TEST_PROGRAMS += t-ctype
>  UNIT_TEST_PROGRAMS += t-mem-pool
> +UNIT_TEST_PROGRAMS += t-oidmap
>  UNIT_TEST_PROGRAMS += t-oidtree
>  UNIT_TEST_PROGRAMS += t-prio-queue
>  UNIT_TEST_PROGRAMS += t-strbuf
> diff --git a/t/helper/test-oidmap.c b/t/helper/test-oidmap.c
> deleted file mode 100644
> index bd30244a54..0000000000
> --- a/t/helper/test-oidmap.c
> +++ /dev/null
> @@ -1,123 +0,0 @@
> -#include "test-tool.h"
> -#include "hex.h"
> -#include "object-name.h"
> -#include "oidmap.h"
> -#include "repository.h"
> -#include "setup.h"
> -#include "strbuf.h"
> -#include "string-list.h"
> -
> -/* key is an oid and value is a name (could be a refname for example) */
> -struct test_entry {
> -	struct oidmap_entry entry;
> -	char name[FLEX_ARRAY];
> -};
> -
> -#define DELIM " \t\r\n"
> -
> -/*
> - * Read stdin line by line and print result of commands to stdout:
> - *
> - * hash oidkey -> sha1hash(oidkey)
> - * put oidkey namevalue -> NULL / old namevalue
> - * get oidkey -> NULL / namevalue
> - * remove oidkey -> NULL / old namevalue
> - * iterate -> oidkey1 namevalue1\noidkey2 namevalue2\n...
> - *
> - */
> -int cmd__oidmap(int argc UNUSED, const char **argv UNUSED)
> -{
> -	struct string_list parts = STRING_LIST_INIT_NODUP;
> -	struct strbuf line = STRBUF_INIT;
> -	struct oidmap map = OIDMAP_INIT;
> -
> -	setup_git_directory();
> -
> -	/* init oidmap */
> -	oidmap_init(&map, 0);
> -
> -	/* process commands from stdin */
> -	while (strbuf_getline(&line, stdin) != EOF) {
> -		char *cmd, *p1, *p2;
> -		struct test_entry *entry;
> -		struct object_id oid;
> -
> -		/* break line into command and up to two parameters */
> -		string_list_setlen(&parts, 0);
> -		string_list_split_in_place(&parts, line.buf, DELIM, 2);
> -		string_list_remove_empty_items(&parts, 0);
> -
> -		/* ignore empty lines */
> -		if (!parts.nr)
> -			continue;
> -		if (!*parts.items[0].string || *parts.items[0].string == '#')
> -			continue;
> -
> -		cmd = parts.items[0].string;
> -		p1 = parts.nr >= 1 ? parts.items[1].string : NULL;
> -		p2 = parts.nr >= 2 ? parts.items[2].string : NULL;
> -
> -		if (!strcmp("put", cmd) && p1 && p2) {
> -
> -			if (repo_get_oid(the_repository, p1, &oid)) {
> -				printf("Unknown oid: %s\n", p1);
> -				continue;
> -			}
> -
> -			/* create entry with oid_key = p1, name_value = p2 */
> -			FLEX_ALLOC_STR(entry, name, p2);
> -			oidcpy(&entry->entry.oid, &oid);
> -
> -			/* add / replace entry */
> -			entry = oidmap_put(&map, entry);
> -
> -			/* print and free replaced entry, if any */
> -			puts(entry ? entry->name : "NULL");
> -			free(entry);
> -
> -		} else if (!strcmp("get", cmd) && p1) {
> -
> -			if (repo_get_oid(the_repository, p1, &oid)) {
> -				printf("Unknown oid: %s\n", p1);
> -				continue;
> -			}
> -
> -			/* lookup entry in oidmap */
> -			entry = oidmap_get(&map, &oid);
> -
> -			/* print result */
> -			puts(entry ? entry->name : "NULL");
> -
> -		} else if (!strcmp("remove", cmd) && p1) {
> -
> -			if (repo_get_oid(the_repository, p1, &oid)) {
> -				printf("Unknown oid: %s\n", p1);
> -				continue;
> -			}
> -
> -			/* remove entry from oidmap */
> -			entry = oidmap_remove(&map, &oid);
> -
> -			/* print result and free entry*/
> -			puts(entry ? entry->name : "NULL");
> -			free(entry);
> -
> -		} else if (!strcmp("iterate", cmd)) {
> -
> -			struct oidmap_iter iter;
> -			oidmap_iter_init(&map, &iter);
> -			while ((entry = oidmap_iter_next(&iter)))
> -				printf("%s %s\n", oid_to_hex(&entry->entry.oid), entry->name);
> -
> -		} else {
> -
> -			printf("Unknown command %s\n", cmd);
> -
> -		}
> -	}
> -
> -	string_list_clear(&parts, 0);
> -	strbuf_release(&line);
> -	oidmap_free(&map, 1);
> -	return 0;
> -}
> diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
> index 253324a06b..5f013d8b2b 100644
> --- a/t/helper/test-tool.c
> +++ b/t/helper/test-tool.c
> @@ -45,7 +45,6 @@ static struct test_cmd cmds[] = {
>  	{ "mergesort", cmd__mergesort },
>  	{ "mktemp", cmd__mktemp },
>  	{ "oid-array", cmd__oid_array },
> -	{ "oidmap", cmd__oidmap },
>  	{ "online-cpus", cmd__online_cpus },
>  	{ "pack-mtimes", cmd__pack_mtimes },
>  	{ "parse-options", cmd__parse_options },
> diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
> index 460dd7d260..c7d3e43694 100644
> --- a/t/helper/test-tool.h
> +++ b/t/helper/test-tool.h
> @@ -38,7 +38,6 @@ int cmd__lazy_init_name_hash(int argc, const char **argv);
>  int cmd__match_trees(int argc, const char **argv);
>  int cmd__mergesort(int argc, const char **argv);
>  int cmd__mktemp(int argc, const char **argv);
> -int cmd__oidmap(int argc, const char **argv);
>  int cmd__online_cpus(int argc, const char **argv);
>  int cmd__pack_mtimes(int argc, const char **argv);
>  int cmd__parse_options(int argc, const char **argv);
> diff --git a/t/t0016-oidmap.sh b/t/t0016-oidmap.sh
> deleted file mode 100755
> index 0faef1f4f1..0000000000
> --- a/t/t0016-oidmap.sh
> +++ /dev/null
> @@ -1,112 +0,0 @@
> -#!/bin/sh
> -
> -test_description='test oidmap'
> -
> -TEST_PASSES_SANITIZE_LEAK=true
> -. ./test-lib.sh
> -
> -# This purposefully is very similar to t0011-hashmap.sh
> -
> -test_oidmap () {
> -	echo "$1" | test-tool oidmap $3 >actual &&
> -	echo "$2" >expect &&
> -	test_cmp expect actual
> -}
> -
> -
> -test_expect_success 'setup' '
> -
> -	test_commit one &&
> -	test_commit two &&
> -	test_commit three &&
> -	test_commit four
> -
> -'
> -
> -test_expect_success 'put' '
> -
> -test_oidmap "put one 1
> -put two 2
> -put invalidOid 4
> -put three 3" "NULL
> -NULL
> -Unknown oid: invalidOid
> -NULL"
> -
> -'
> -
> -test_expect_success 'replace' '
> -
> -test_oidmap "put one 1
> -put two 2
> -put three 3
> -put invalidOid 4
> -put two deux
> -put one un" "NULL
> -NULL
> -NULL
> -Unknown oid: invalidOid
> -2
> -1"
> -
> -'
> -
> -test_expect_success 'get' '
> -
> -test_oidmap "put one 1
> -put two 2
> -put three 3
> -get two
> -get four
> -get invalidOid
> -get one" "NULL
> -NULL
> -NULL
> -2
> -NULL
> -Unknown oid: invalidOid
> -1"
> -
> -'
> -
> -test_expect_success 'remove' '
> -
> -test_oidmap "put one 1
> -put two 2
> -put three 3
> -remove one
> -remove two
> -remove invalidOid
> -remove four" "NULL
> -NULL
> -NULL
> -1
> -2
> -Unknown oid: invalidOid
> -NULL"
> -
> -'
> -
> -test_expect_success 'iterate' '
> -	test-tool oidmap >actual.raw <<-\EOF &&
> -	put one 1
> -	put two 2
> -	put three 3
> -	iterate
> -	EOF
> -
> -	# sort "expect" too so we do not rely on the order of particular oids
> -	sort >expect <<-EOF &&
> -	NULL
> -	NULL
> -	NULL
> -	$(git rev-parse one) 1
> -	$(git rev-parse two) 2
> -	$(git rev-parse three) 3
> -	EOF
> -
> -	sort <actual.raw >actual &&
> -	test_cmp expect actual
> -'
> -
> -test_done
> diff --git a/t/unit-tests/t-oidmap.c b/t/unit-tests/t-oidmap.c
> new file mode 100644
> index 0000000000..9b98a3ed09
> --- /dev/null
> +++ b/t/unit-tests/t-oidmap.c
> @@ -0,0 +1,165 @@
> +#include "test-lib.h"
> +#include "lib-oid.h"
> +#include "oidmap.h"
> +#include "hash.h"
> +#include "hex.h"
> +
> +/*
> + * elements we will put in oidmap structs are made of a key: the entry.oid
> + * field, which is of type struct object_id, and a value: the name field (could
> + * be a refname for example)
> + */
> +struct test_entry {
> +	struct oidmap_entry entry;
> +	char name[FLEX_ARRAY];
> +};
> +
> +static const char *key_val[][2] = { { "11", "one" },
> +				    { "22", "two" },
> +				    { "33", "three" } };
> +
> +static int put_and_check_null(struct oidmap *map, const char *hex,
> +			      const char *entry_name)
> +{
> +	struct test_entry *entry;
> +
> +	FLEX_ALLOC_STR(entry, name, entry_name);
> +	if (get_oid_arbitrary_hex(hex, &entry->entry.oid))
> +		return -1;
> +	if (!check(oidmap_put(map, entry) == NULL))
> +		return -1;
> +	return 0;
> +}
> +
> +static void setup(void (*f)(struct oidmap *map))
> +{
> +	struct oidmap map = OIDMAP_INIT;
> +	int ret = 0;
> +
> +	for (size_t i = 0; i < ARRAY_SIZE(key_val); i++)
> +		if ((ret = put_and_check_null(&map, key_val[i][0],
> +					      key_val[i][1])))
> +			break;
> +
> +	if (!ret)
> +		f(&map);
> +	oidmap_free(&map, 1);
> +}
> +
> +static void t_replace(struct oidmap *map)
> +{
> +	struct test_entry *entry, *prev;
> +
> +	FLEX_ALLOC_STR(entry, name, "un");
> +	if (get_oid_arbitrary_hex("11", &entry->entry.oid))
> +		return;
> +	prev = oidmap_put(map, entry);
> +	if (!check(prev != NULL))
> +		return;
> +	check_str(prev->name, "one");
> +	free(prev);
> +
> +	FLEX_ALLOC_STR(entry, name, "deux");
> +	if (get_oid_arbitrary_hex("22", &entry->entry.oid))
> +		return;
> +	prev = oidmap_put(map, entry);
> +	if (!check(prev != NULL))
> +		return;
> +	check_str(prev->name, "two");
> +	free(prev);
> +}
> +
> +static void t_get(struct oidmap *map)
> +{
> +	struct test_entry *entry;
> +	struct object_id oid;
> +
> +	if (get_oid_arbitrary_hex("22", &oid))
> +		return;
> +	entry = oidmap_get(map, &oid);
> +	if (!check(entry != NULL))
> +		return;
> +	check_str(entry->name, "two");
> +
> +	if (get_oid_arbitrary_hex("44", &oid))
> +		return;
> +	check(oidmap_get(map, &oid) == NULL);
> +
> +	if (get_oid_arbitrary_hex("11", &oid))
> +		return;
> +	entry = oidmap_get(map, &oid);
> +	if (!check(entry != NULL))
> +		return;
> +	check_str(entry->name, "one");
> +}
> +
> +static void t_remove(struct oidmap *map)
> +{
> +	struct test_entry *entry;
> +	struct object_id oid;
> +
> +	if (get_oid_arbitrary_hex("11", &oid))
> +		return;
> +	entry = oidmap_remove(map, &oid);
> +	if (!check(entry != NULL))
> +		return;
> +	check_str(entry->name, "one");
> +	check(oidmap_get(map, &oid) == NULL);
> +	free(entry);
> +
> +	if (get_oid_arbitrary_hex("22", &oid))
> +		return;
> +	entry = oidmap_remove(map, &oid);
> +	if (!check(entry != NULL))
> +		return;
> +	check_str(entry->name, "two");
> +	check(oidmap_get(map, &oid) == NULL);
> +	free(entry);
> +
> +	if (get_oid_arbitrary_hex("44", &oid))
> +		return;
> +	check(oidmap_remove(map, &oid) == NULL);
> +}
> +
> +static int key_val_contains(struct test_entry *entry)
> +{
> +	/* the test is small enough to be able to bear O(n) */
> +	for (size_t i = 0; i < ARRAY_SIZE(key_val); i++) {
> +		if (!strcmp(key_val[i][1], entry->name)) {
> +			struct object_id oid;
> +			if (get_oid_arbitrary_hex(key_val[i][0], &oid))
> +				return -1;
> +			if (oideq(&entry->entry.oid, &oid))
> +				return 0;
> +		}
> +	}
> +	return 1;
> +}
> +
> +static void t_iterate(struct oidmap *map)
> +{
> +	struct oidmap_iter iter;
> +	struct test_entry *entry;
> +	int ret;
> +
> +	oidmap_iter_init(map, &iter);
> +	while ((entry = oidmap_iter_next(&iter))) {
> +		if (!check_int((ret = key_val_contains(entry)), ==, 0)) {
> +			if (ret == -1)
> +				return;
> +			test_msg("obtained entry was not given in the input\n"
> +				 "  name: %s\n   oid: %s\n",
> +				 entry->name, oid_to_hex(&entry->entry.oid));
> +		}
> +	}
> +	check_int(hashmap_get_size(&map->map), ==, ARRAY_SIZE(key_val));
> +}
> +
> +int cmd_main(int argc UNUSED, const char **argv UNUSED)
> +{
> +	TEST(setup(t_replace), "replace works");
> +	TEST(setup(t_get), "get works");
> +	TEST(setup(t_remove), "remove works");
> +	TEST(setup(t_iterate), "iterate works");
> +	return test_done();
> +}
> -- 
> 2.45.2
> 
> 
