Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CEB31F404
	for <e@80x24.org>; Wed, 28 Feb 2018 14:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752778AbeB1Orw (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 09:47:52 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33360 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752773AbeB1Oru (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 09:47:50 -0500
Received: by mail-qt0-f196.google.com with SMTP id a23so3258788qtn.0
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 06:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=hsg+S9luZ+2CwsFq5a5m7NgvpE7JESr5w2UcxXfOYpM=;
        b=RP2u3HAnu/XU3Qk/G3DF0H1i+4DSVGVYWymE1YrG6ya9yv+1qvPhzsNWBDEhbOLhlO
         jrXFx+otWh8p9vXDvWFbfJ9R/PkTo0sd0CWD2Ni8afGzc3m2ulYyKas3Us2TXKHnPIGN
         RwP93HdqlMu0y1jgge+3hwxCzDn6PNchw1nk5IcFm0amKjzI5cswbdm9rKBezv/gEoCi
         dwCptnegkjVsAU3Tg3Oxj8Br0HwjXlL5iMulLVGP9SjFh2EUnR/wBNjBu4EBrQAGynAu
         r5AqKNxNoa8Dt/ypddHqSSfH5idgR/OY6dJEm5joO53riE1C0glg8Zw++Y5oyAQuPJ5v
         EYLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=hsg+S9luZ+2CwsFq5a5m7NgvpE7JESr5w2UcxXfOYpM=;
        b=pJenZRW51eO99DbxLsv4tm2aGvvxu7Rp9On9Ubne8WtK07qHtkZtBrkdnoYCmHZF5q
         zGfbCOKx/reVYrDs6BwyUzESijkBcBYSgfKCK9yZ157sATr7Tcn50qhXpmKIazChHZmC
         f5V0v8wBxVm+sWeZTCpHpKwTA9BROcHtsXh+KfyfsQbcG5tOzYnuLT0CD4d29o53UFE6
         iaTKQxW14hOInYT51qZ2myoeM53PUKUBRqV/ywKW9iT4CV4HBa5zOYQkQ+u/GJtOOAkK
         vtM4ggCuatY9VrvD3x5Q6cI/5CTWb3V7rjvjVc0lDpByDNEdRlySc2KX+herzOn1Prsh
         rVjw==
X-Gm-Message-State: APf1xPCLxNLMr2leIgzjRf0FZC3TfCV3LuogJb6lVUBP3nhzP7ymc5nY
        FtC6En0/sfbaDVfgpyaWLLL7YYUU
X-Google-Smtp-Source: AG47ELuxr/SwtvcK2njXyT7Y43IGAop3NA+G7BjRPdOZvzRBftJMqvXipbfHuh6QZc6w7HkMVrCkCA==
X-Received: by 10.200.8.56 with SMTP id u53mr31118804qth.315.1519829268967;
        Wed, 28 Feb 2018 06:47:48 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id a73sm1160905qkb.14.2018.02.28.06.47.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Feb 2018 06:47:48 -0800 (PST)
Subject: Re: [PATCH 00/11] Moving global state into the repository object
 (part 2)
To:     Duy Nguyen <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
References: <20180228010608.215505-1-sbeller@google.com>
 <20180228021530.GA20625@duynguyen.dek-tpc.internal>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <db9d8194-aeb0-92c2-aea0-1ec9fbbfd8ae@gmail.com>
Date:   Wed, 28 Feb 2018 09:47:47 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180228021530.GA20625@duynguyen.dek-tpc.internal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/27/2018 9:15 PM, Duy Nguyen wrote:
> On Tue, Feb 27, 2018 at 05:05:57PM -0800, Stefan Beller wrote:
>> This applies on top of origin/sb/object-store and is the continuation of
>> that series, adding the repository as a context argument to functions.
>>
>> This series focusses on packfile handling, exposing (re)prepare_packed_git
>> and find_pack_entry to a repository argument.
> It looks good.

I agree.

> Looking at the full-series diff though, it makes me wonder if we
> should keep prepare_packed_git() private (i.e. how we initialize the
> object store, packfile included, is a private matter). How about
> something like this on top?

I think the get_packed_git() approach is cleaner than navigating 
directly to the_repository->objects.packed_git that you expect to be 
initialized by an earlier method call.

Thanks,
-Stolee

> -- 8< --
> Subject: [PATCH] packfile: keep raw_object_store.packed_git{,_mru} fields private
>
> These fields are initialized lazily via prepare_packed_git(). All
> access to these must call that function first but unless you know the
> implementation details, you may not see the connection.
>
> Keep that connection internal. These fields should only be accessed
> via get_packed_git() and get_packed_git_mru() outside packfile.c.
>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>   builtin/count-objects.c  |  4 +---
>   builtin/fsck.c           |  6 ++----
>   builtin/gc.c             |  3 +--
>   builtin/pack-objects.c   | 21 +++++++++++----------
>   builtin/pack-redundant.c |  6 ++----
>   fast-import.c            |  7 ++-----
>   http-backend.c           |  5 ++---
>   object-store.h           |  4 ++--
>   pack-bitmap.c            |  3 +--
>   packfile.c               | 15 ++++++++++++++-
>   packfile.h               |  6 +++++-
>   server-info.c            |  5 ++---
>   sha1_name.c              |  6 ++----
>   13 files changed, 47 insertions(+), 44 deletions(-)
>
> diff --git a/builtin/count-objects.c b/builtin/count-objects.c
> index d480301763..088309945b 100644
> --- a/builtin/count-objects.c
> +++ b/builtin/count-objects.c
> @@ -121,9 +121,7 @@ int cmd_count_objects(int argc, const char **argv, const char *prefix)
>   		struct strbuf loose_buf = STRBUF_INIT;
>   		struct strbuf pack_buf = STRBUF_INIT;
>   		struct strbuf garbage_buf = STRBUF_INIT;
> -		if (!the_repository->objects.packed_git)
> -			prepare_packed_git(the_repository);
> -		for (p = the_repository->objects.packed_git; p; p = p->next) {
> +		for (p = get_packed_git(the_repository); p; p = p->next) {
>   			if (!p->pack_local)
>   				continue;
>   			if (open_pack_index(p))
> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index 0a043a43c2..6d86f2581a 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -732,10 +732,8 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
>   			uint32_t total = 0, count = 0;
>   			struct progress *progress = NULL;
>   
> -			prepare_packed_git(the_repository);
> -
>   			if (show_progress) {
> -				for (p = the_repository->objects.packed_git; p;
> +				for (p = get_packed_git(the_repository); p;
>   				     p = p->next) {
>   					if (open_pack_index(p))
>   						continue;
> @@ -744,7 +742,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
>   
>   				progress = start_progress(_("Checking objects"), total);
>   			}
> -			for (p = the_repository->objects.packed_git; p;
> +			for (p = get_packed_git(the_repository); p;
>   			     p = p->next) {
>   				/* verify gives error messages itself */
>   				if (verify_pack(p, fsck_obj_buffer,
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 80d19c54d5..be63bec09c 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -173,8 +173,7 @@ static int too_many_packs(void)
>   	if (gc_auto_pack_limit <= 0)
>   		return 0;
>   
> -	prepare_packed_git(the_repository);
> -	for (cnt = 0, p = the_repository->objects.packed_git; p; p = p->next) {
> +	for (cnt = 0, p = get_packed_git(the_repository); p; p = p->next) {
>   		if (!p->pack_local)
>   			continue;
>   		if (p->pack_keep)
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 5e2590f882..a305f50100 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -1026,7 +1026,7 @@ static int want_object_in_pack(const struct object_id *oid,
>   		if (want != -1)
>   			return want;
>   	}
> -	list_for_each(pos, &the_repository->objects.packed_git_mru) {
> +	list_for_each(pos, get_packed_git_mru(the_repository)) {
>   		struct packed_git *p = list_entry(pos, struct packed_git, mru);
>   		off_t offset;
>   
> @@ -1045,7 +1045,7 @@ static int want_object_in_pack(const struct object_id *oid,
>   			want = want_found_object(exclude, p);
>   			if (!exclude && want > 0)
>   				list_move(&p->mru,
> -					  &the_repository->objects.packed_git_mru);
> +					  get_packed_git_mru(the_repository));
>   			if (want != -1)
>   				return want;
>   		}
> @@ -2674,7 +2674,7 @@ static void add_objects_in_unpacked_packs(struct rev_info *revs)
>   
>   	memset(&in_pack, 0, sizeof(in_pack));
>   
> -	for (p = the_repository->objects.packed_git; p; p = p->next) {
> +	for (p = get_packed_git(the_repository); p; p = p->next) {
>   		struct object_id oid;
>   		struct object *o;
>   
> @@ -2737,8 +2737,10 @@ static int has_sha1_pack_kept_or_nonlocal(const struct object_id *oid)
>   	static struct packed_git *last_found = (void *)1;
>   	struct packed_git *p;
>   
> -	p = (last_found != (void *)1) ? last_found :
> -					the_repository->objects.packed_git;
> +	if (last_found != (void *)1)
> +		p = last_found;
> +	else
> +		p = get_packed_git(the_repository);
>   
>   	while (p) {
>   		if ((!p->pack_local || p->pack_keep) &&
> @@ -2747,7 +2749,7 @@ static int has_sha1_pack_kept_or_nonlocal(const struct object_id *oid)
>   			return 1;
>   		}
>   		if (p == last_found)
> -			p = the_repository->objects.packed_git;
> +			p = get_packed_git(the_repository);
>   		else
>   			p = p->next;
>   		if (p == last_found)
> @@ -2783,7 +2785,7 @@ static void loosen_unused_packed_objects(struct rev_info *revs)
>   	uint32_t i;
>   	struct object_id oid;
>   
> -	for (p = the_repository->objects.packed_git; p; p = p->next) {
> +	for (p = get_packed_git(the_repository); p; p = p->next) {
>   		if (!p->pack_local || p->pack_keep)
>   			continue;
>   
> @@ -3151,10 +3153,9 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
>   	if (progress && all_progress_implied)
>   		progress = 2;
>   
> -	prepare_packed_git(the_repository);
>   	if (ignore_packed_keep) {
>   		struct packed_git *p;
> -		for (p = the_repository->objects.packed_git; p; p = p->next)
> +		for (p = get_packed_git(the_repository); p; p = p->next)
>   			if (p->pack_local && p->pack_keep)
>   				break;
>   		if (!p) /* no keep-able packs found */
> @@ -3167,7 +3168,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
>   		 * also covers non-local objects
>   		 */
>   		struct packed_git *p;
> -		for (p = the_repository->objects.packed_git; p; p = p->next) {
> +		for (p = get_packed_git(the_repository); p; p = p->next) {
>   			if (!p->pack_local) {
>   				have_non_local_packs = 1;
>   				break;
> diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
> index 3b02f94248..02b5f0becc 100644
> --- a/builtin/pack-redundant.c
> +++ b/builtin/pack-redundant.c
> @@ -572,7 +572,7 @@ static struct pack_list * add_pack(struct packed_git *p)
>   
>   static struct pack_list * add_pack_file(const char *filename)
>   {
> -	struct packed_git *p = the_repository->objects.packed_git;
> +	struct packed_git *p = get_packed_git(the_repository);
>   
>   	if (strlen(filename) < 40)
>   		die("Bad pack filename: %s", filename);
> @@ -587,7 +587,7 @@ static struct pack_list * add_pack_file(const char *filename)
>   
>   static void load_all(void)
>   {
> -	struct packed_git *p = the_repository->objects.packed_git;
> +	struct packed_git *p = get_packed_git(the_repository);
>   
>   	while (p) {
>   		add_pack(p);
> @@ -630,8 +630,6 @@ int cmd_pack_redundant(int argc, const char **argv, const char *prefix)
>   			break;
>   	}
>   
> -	prepare_packed_git(the_repository);
> -
>   	if (load_all_packs)
>   		load_all();
>   	else
> diff --git a/fast-import.c b/fast-import.c
> index f2e255ed7e..041217eedf 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -1111,8 +1111,7 @@ static int store_object(
>   	if (e->idx.offset) {
>   		duplicate_count_by_type[type]++;
>   		return 1;
> -	} else if (find_sha1_pack(oid.hash,
> -				  the_repository->objects.packed_git)) {
> +	} else if (find_sha1_pack(oid.hash, get_packed_git(the_repository))) {
>   		e->type = type;
>   		e->pack_id = MAX_PACK_ID;
>   		e->idx.offset = 1; /* just not zero! */
> @@ -1309,8 +1308,7 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
>   		duplicate_count_by_type[OBJ_BLOB]++;
>   		truncate_pack(&checkpoint);
>   
> -	} else if (find_sha1_pack(oid.hash,
> -				  the_repository->objects.packed_git)) {
> +	} else if (find_sha1_pack(oid.hash, get_packed_git(the_repository))) {
>   		e->type = OBJ_BLOB;
>   		e->pack_id = MAX_PACK_ID;
>   		e->idx.offset = 1; /* just not zero! */
> @@ -3474,7 +3472,6 @@ int cmd_main(int argc, const char **argv)
>   		rc_free[i].next = &rc_free[i + 1];
>   	rc_free[cmd_save - 1].next = NULL;
>   
> -	prepare_packed_git(the_repository);
>   	start_packfile();
>   	set_die_routine(die_nicely);
>   	set_checkpoint_signal();
> diff --git a/http-backend.c b/http-backend.c
> index defa6ba350..22d2e1668e 100644
> --- a/http-backend.c
> +++ b/http-backend.c
> @@ -518,14 +518,13 @@ static void get_info_packs(struct strbuf *hdr, char *arg)
>   	size_t cnt = 0;
>   
>   	select_getanyfile(hdr);
> -	prepare_packed_git(the_repository);
> -	for (p = the_repository->objects.packed_git; p; p = p->next) {
> +	for (p = get_packed_git(the_repository); p; p = p->next) {
>   		if (p->pack_local)
>   			cnt++;
>   	}
>   
>   	strbuf_grow(&buf, cnt * 53 + 2);
> -	for (p = the_repository->objects.packed_git; p; p = p->next) {
> +	for (p = get_packed_git(the_repository); p; p = p->next) {
>   		if (p->pack_local)
>   			strbuf_addf(&buf, "P %s\n", p->pack_name + objdirlen + 6);
>   	}
> diff --git a/object-store.h b/object-store.h
> index afe2f93459..636375753f 100644
> --- a/object-store.h
> +++ b/object-store.h
> @@ -87,9 +87,9 @@ struct raw_object_store {
>   	 */
>   	char *objectdir;
>   
> -	struct packed_git *packed_git;
> +	struct packed_git *packed_git; /* private */
>   	/* A most-recently-used ordered version of the packed_git list. */
> -	struct list_head packed_git_mru;
> +	struct list_head packed_git_mru; /* private */
>   
>   	struct alternate_object_database *alt_odb_list;
>   	struct alternate_object_database **alt_odb_tail;
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index bcc04bc45e..2a007b5539 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -335,8 +335,7 @@ static int open_pack_bitmap(void)
>   
>   	assert(!bitmap_git.map && !bitmap_git.loaded);
>   
> -	prepare_packed_git(the_repository);
> -	for (p = the_repository->objects.packed_git; p; p = p->next) {
> +	for (p = get_packed_git(the_repository); p; p = p->next) {
>   		if (open_pack_bitmap_1(p) == 0)
>   			ret = 0;
>   	}
> diff --git a/packfile.c b/packfile.c
> index d9065ccd32..ed26ab1b3b 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -802,6 +802,7 @@ static void prepare_packed_git_one(struct repository *r, char *objdir, int local
>   	strbuf_release(&path);
>   }
>   
> +static void prepare_packed_git(struct repository *r);
>   /*
>    * Give a fast, rough count of the number of objects in the repository. This
>    * ignores loose objects completely. If you have a lot of them, then either
> @@ -882,7 +883,7 @@ static void prepare_packed_git_mru(struct repository *r)
>   		list_add_tail(&p->mru, &r->objects.packed_git_mru);
>   }
>   
> -void prepare_packed_git(struct repository *r)
> +static void prepare_packed_git(struct repository *r)
>   {
>   	struct alternate_object_database *alt;
>   
> @@ -897,6 +898,18 @@ void prepare_packed_git(struct repository *r)
>   	r->objects.packed_git_initialized = 1;
>   }
>   
> +struct packed_git *get_packed_git(struct repository *r)
> +{
> +	prepare_packed_git(r);
> +	return r->objects.packed_git;
> +}
> +
> +struct list_head *get_packed_git_mru(struct repository *r)
> +{
> +	prepare_packed_git(r);
> +	return &r->objects.packed_git_mru;
> +}
> +
>   void reprepare_packed_git(struct repository *r)
>   {
>   	r->objects.approximate_object_count_valid = 0;
> diff --git a/packfile.h b/packfile.h
> index 6f7b9e91d6..1903984e22 100644
> --- a/packfile.h
> +++ b/packfile.h
> @@ -3,6 +3,9 @@
>   
>   #include "oidset.h"
>   
> +struct list_head;
> +struct packed_git;
> +
>   /*
>    * Generate the filename to be used for a pack file with checksum "sha1" and
>    * extension "ext". The result is written into the strbuf "buf", overwriting
> @@ -34,7 +37,8 @@ extern struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_
>   #define PACKDIR_FILE_GARBAGE 4
>   extern void (*report_garbage)(unsigned seen_bits, const char *path);
>   
> -extern void prepare_packed_git(struct repository *r);
> +extern struct packed_git *get_packed_git(struct repository *r);
> +extern struct list_head *get_packed_git_mru(struct repository *r);
>   extern void reprepare_packed_git(struct repository *r);
>   extern void install_packed_git(struct repository *r, struct packed_git *pack);
>   
> diff --git a/server-info.c b/server-info.c
> index f5e4d1cc89..af737acd24 100644
> --- a/server-info.c
> +++ b/server-info.c
> @@ -200,8 +200,7 @@ static void init_pack_info(const char *infofile, int force)
>   	objdir = get_object_directory();
>   	objdirlen = strlen(objdir);
>   
> -	prepare_packed_git(the_repository);
> -	for (p = the_repository->objects.packed_git; p; p = p->next) {
> +	for (p = get_packed_git(the_repository); p; p = p->next) {
>   		/* we ignore things on alternate path since they are
>   		 * not available to the pullers in general.
>   		 */
> @@ -211,7 +210,7 @@ static void init_pack_info(const char *infofile, int force)
>   	}
>   	num_pack = i;
>   	info = xcalloc(num_pack, sizeof(struct pack_info *));
> -	for (i = 0, p = the_repository->objects.packed_git; p; p = p->next) {
> +	for (i = 0, p = get_packed_git(the_repository); p; p = p->next) {
>   		if (!p->pack_local)
>   			continue;
>   		info[i] = xcalloc(1, sizeof(struct pack_info));
> diff --git a/sha1_name.c b/sha1_name.c
> index 773322ac81..f25a0970ca 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -195,8 +195,7 @@ static void find_short_packed_object(struct disambiguate_state *ds)
>   {
>   	struct packed_git *p;
>   
> -	prepare_packed_git(the_repository);
> -	for (p = the_repository->objects.packed_git; p && !ds->ambiguous;
> +	for (p = get_packed_git(the_repository); p && !ds->ambiguous;
>   	     p = p->next)
>   		unique_in_pack(p, ds);
>   }
> @@ -566,8 +565,7 @@ static void find_abbrev_len_packed(struct min_abbrev_data *mad)
>   {
>   	struct packed_git *p;
>   
> -	prepare_packed_git(the_repository);
> -	for (p = the_repository->objects.packed_git; p; p = p->next)
> +	for (p = get_packed_git(the_repository); p; p = p->next)
>   		find_abbrev_len_for_pack(p, mad);
>   }
>   

