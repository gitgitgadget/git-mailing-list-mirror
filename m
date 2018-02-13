Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 655081F404
	for <e@80x24.org>; Tue, 13 Feb 2018 18:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965477AbeBMSvZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 13:51:25 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:39411 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965425AbeBMSvX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 13:51:23 -0500
Received: by mail-pg0-f67.google.com with SMTP id w17so478407pgv.6
        for <git@vger.kernel.org>; Tue, 13 Feb 2018 10:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R77r28UQ/4WbrGQRBrPfDaWoPcticS36a3kbqhZd4Jo=;
        b=t+827BCzM68yYik0z2MEFrCou9viOG7nGLAfhoUaTm1l5GDTuy4q2I8I8xuLz68hw1
         DRqJW7yWPebvE57LpsijRZVFS31uXAixAP9yb2zylamlE383PgJKyIz49pmhWozc4QjZ
         DIAXcNkVj8eD+hK3iQrKRabCxAdNDvtWwnxo2VYg0oOMbW+KcJkHr5MbLnaUzyLaQZLG
         gT84HY3Qsgbre3B28596mmwxnKfZ+Ky66u6nU0NBi5YrZqz4zGM3WgTLRU82AGJLgHKD
         fnr5lkQH6yAizh8luzdJb/UhkNSqDSU6ZldzxrAPU/D3oV/uTOMHWH/Q6Lk9KHta67KZ
         eZ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R77r28UQ/4WbrGQRBrPfDaWoPcticS36a3kbqhZd4Jo=;
        b=hHzTvtedPJZxCuRLXz1pvGhT188hpS7woIA1b51BYSUEKsaS4gFXLPNWQpHStxq2m0
         ye0pn2eAD+YbF5xOmsojezat9fkpAGVrb3Pw941A77eE5pTWdbtS8fQ9EOWs/LC12sXE
         w/ZnxhsS3W6BDxrQXE3Yp0Jy4dW2eamEdlfHG2PSVToSrBjsrjDQbzW9ROmrHN1vEDfA
         CflX1CYnpSGal5UledbO05Km3vtQ6K1LmyLE703bsJuGwrxH2xOP0kQiXn6eP0jcma+n
         0UU1CM6OJX89hPAmepRI6fD284WuncFAuQT41QfjC1BDpkSzakP+vrczHqD3KAA1mlhk
         yR3g==
X-Gm-Message-State: APf1xPBnfX87uC8lB50ZefNBMYloHq2nG1APi3F33ymvAAKwR89h95wb
        IZEKerZs/LM1fqRnn+1lQ54Iaw==
X-Google-Smtp-Source: AH8x224PkL6BXHu4/CjOvKJ9O/yOg0YFzFJXd8jbgSMSbZVYAIfWIPflxUu1XEWsolufyh7GO50kng==
X-Received: by 10.98.15.15 with SMTP id x15mr2189169pfi.197.1518547882896;
        Tue, 13 Feb 2018 10:51:22 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id h2sm25080325pgp.65.2018.02.13.10.51.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Feb 2018 10:51:21 -0800 (PST)
Date:   Tue, 13 Feb 2018 10:51:20 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, pclouds@gmail.com,
        sunshine@sunshineco.com, jonathantanmy@google.com,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 02/26] object-store: move alt_odb_list and alt_odb_tail
 to object store
Message-ID: <20180213185120.GA108526@google.com>
References: <20180213012241.187007-1-sbeller@google.com>
 <20180213012241.187007-3-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180213012241.187007-3-sbeller@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/12, Stefan Beller wrote:
> In a process with multiple repositories open, alternates should be
> associated to a single repository and not shared globally. Move
> alt_odb_list and alt_odb_tail into the_repository and adjust callers
> to reflect this.
> 
> Now that the alternative object data base is per repository, we're
> leaking its memory upon freeing a repository. The next patch plugs
> this hole.
> 
> No functional change intended.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
>  builtin/fsck.c |  4 +++-
>  cache.h        |  4 ++--
>  object-store.h |  7 ++++++-
>  packfile.c     |  3 ++-
>  sha1_file.c    | 25 ++++++++++++-------------
>  sha1_name.c    |  3 ++-
>  6 files changed, 27 insertions(+), 19 deletions(-)
> 
> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index 04846d46f9..1048255da1 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -1,5 +1,6 @@
>  #include "builtin.h"
>  #include "cache.h"
> +#include "repository.h"
>  #include "config.h"
>  #include "commit.h"
>  #include "tree.h"
> @@ -694,7 +695,8 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
>  		fsck_object_dir(get_object_directory());
>  
>  		prepare_alt_odb();
> -		for (alt = alt_odb_list; alt; alt = alt->next)
> +		for (alt = the_repository->objects.alt_odb_list;
> +				alt; alt = alt->next)
>  			fsck_object_dir(alt->path);
>  
>  		if (check_full) {
> diff --git a/cache.h b/cache.h
> index d8b975a571..918c2f15b4 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1573,7 +1573,7 @@ extern int has_dirs_only_path(const char *name, int len, int prefix_len);
>  extern void schedule_dir_for_removal(const char *name, int len);
>  extern void remove_scheduled_dirs(void);
>  
> -extern struct alternate_object_database {
> +struct alternate_object_database {
>  	struct alternate_object_database *next;
>  
>  	/* see alt_scratch_buf() */
> @@ -1591,7 +1591,7 @@ extern struct alternate_object_database {
>  	struct oid_array loose_objects_cache;
>  
>  	char path[FLEX_ARRAY];
> -} *alt_odb_list;
> +};
>  extern void prepare_alt_odb(void);
>  extern char *compute_alternate_path(const char *path, struct strbuf *err);
>  typedef int alt_odb_fn(struct alternate_object_database *, void *);
> diff --git a/object-store.h b/object-store.h
> index cf35760ceb..44b8f84753 100644
> --- a/object-store.h
> +++ b/object-store.h
> @@ -1,14 +1,19 @@
>  #ifndef OBJECT_STORE_H
>  #define OBJECT_STORE_H
>  
> +#include "cache.h"
> +

Maybe we would want to move the definition of the alternate store to
this header file?  That way we don't need to include cache.h here.

>  struct raw_object_store {
>  	/*
>  	 * Path to the repository's object store.
>  	 * Cannot be NULL after initialization.
>  	 */
>  	char *objectdir;
> +
> +	struct alternate_object_database *alt_odb_list;
> +	struct alternate_object_database **alt_odb_tail;
>  };
> -#define RAW_OBJECT_STORE_INIT { NULL }
> +#define RAW_OBJECT_STORE_INIT { NULL, NULL, NULL }
>  
>  void raw_object_store_clear(struct raw_object_store *o);
>  
> diff --git a/packfile.c b/packfile.c
> index 4a5fe7ab18..d61076faaf 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -1,6 +1,7 @@
>  #include "cache.h"
>  #include "mru.h"
>  #include "pack.h"
> +#include "repository.h"
>  #include "dir.h"
>  #include "mergesort.h"
>  #include "packfile.h"
> @@ -880,7 +881,7 @@ void prepare_packed_git(void)
>  		return;
>  	prepare_packed_git_one(get_object_directory(), 1);
>  	prepare_alt_odb();
> -	for (alt = alt_odb_list; alt; alt = alt->next)
> +	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next)
>  		prepare_packed_git_one(alt->path, 0);
>  	rearrange_packed_git();
>  	prepare_packed_git_mru();
> diff --git a/sha1_file.c b/sha1_file.c
> index 3da70ac650..2826d5d6ed 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -22,6 +22,7 @@
>  #include "pack-revindex.h"
>  #include "sha1-lookup.h"
>  #include "bulk-checkin.h"
> +#include "repository.h"
>  #include "streaming.h"
>  #include "dir.h"
>  #include "mru.h"
> @@ -346,9 +347,6 @@ static const char *alt_sha1_path(struct alternate_object_database *alt,
>  	return buf->buf;
>  }
>  
> -struct alternate_object_database *alt_odb_list;
> -static struct alternate_object_database **alt_odb_tail;
> -
>  /*
>   * Return non-zero iff the path is usable as an alternate object database.
>   */
> @@ -368,7 +366,7 @@ static int alt_odb_usable(struct strbuf *path, const char *normalized_objdir)
>  	 * Prevent the common mistake of listing the same
>  	 * thing twice, or object directory itself.
>  	 */
> -	for (alt = alt_odb_list; alt; alt = alt->next) {
> +	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next) {
>  		if (!fspathcmp(path->buf, alt->path))
>  			return 0;
>  	}
> @@ -428,8 +426,8 @@ static int link_alt_odb_entry(const char *entry, const char *relative_base,
>  	ent = alloc_alt_odb(pathbuf.buf);
>  
>  	/* add the alternate entry */
> -	*alt_odb_tail = ent;
> -	alt_odb_tail = &(ent->next);
> +	*the_repository->objects.alt_odb_tail = ent;
> +	the_repository->objects.alt_odb_tail = &(ent->next);
>  	ent->next = NULL;
>  
>  	/* recursively add alternates */
> @@ -563,7 +561,7 @@ void add_to_alternates_file(const char *reference)
>  		fprintf_or_die(out, "%s\n", reference);
>  		if (commit_lock_file(&lock))
>  			die_errno("unable to move new alternates file into place");
> -		if (alt_odb_tail)
> +		if (the_repository->objects.alt_odb_tail)
>  			link_alt_odb_entries(reference, '\n', NULL, 0);
>  	}
>  	free(alts);
> @@ -661,7 +659,7 @@ int foreach_alt_odb(alt_odb_fn fn, void *cb)
>  	int r = 0;
>  
>  	prepare_alt_odb();
> -	for (ent = alt_odb_list; ent; ent = ent->next) {
> +	for (ent = the_repository->objects.alt_odb_list; ent; ent = ent->next) {
>  		r = fn(ent, cb);
>  		if (r)
>  			break;
> @@ -673,12 +671,13 @@ void prepare_alt_odb(void)
>  {
>  	const char *alt;
>  
> -	if (alt_odb_tail)
> +	if (the_repository->objects.alt_odb_tail)
>  		return;
>  
>  	alt = getenv(ALTERNATE_DB_ENVIRONMENT);
>  
> -	alt_odb_tail = &alt_odb_list;
> +	the_repository->objects.alt_odb_tail =
> +			&the_repository->objects.alt_odb_list;
>  	link_alt_odb_entries(alt, PATH_SEP, NULL, 0);
>  
>  	read_info_alternates(get_object_directory(), 0);
> @@ -717,7 +716,7 @@ static int check_and_freshen_nonlocal(const unsigned char *sha1, int freshen)
>  {
>  	struct alternate_object_database *alt;
>  	prepare_alt_odb();
> -	for (alt = alt_odb_list; alt; alt = alt->next) {
> +	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next) {
>  		const char *path = alt_sha1_path(alt, sha1);
>  		if (check_and_freshen_file(path, freshen))
>  			return 1;
> @@ -873,7 +872,7 @@ static int stat_sha1_file(const unsigned char *sha1, struct stat *st,
>  
>  	prepare_alt_odb();
>  	errno = ENOENT;
> -	for (alt = alt_odb_list; alt; alt = alt->next) {
> +	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next) {
>  		*path = alt_sha1_path(alt, sha1);
>  		if (!lstat(*path, st))
>  			return 0;
> @@ -899,7 +898,7 @@ static int open_sha1_file(const unsigned char *sha1, const char **path)
>  	most_interesting_errno = errno;
>  
>  	prepare_alt_odb();
> -	for (alt = alt_odb_list; alt; alt = alt->next) {
> +	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next) {
>  		*path = alt_sha1_path(alt, sha1);
>  		fd = git_open(*path);
>  		if (fd >= 0)
> diff --git a/sha1_name.c b/sha1_name.c
> index 611c7d24dd..957ce25680 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -10,6 +10,7 @@
>  #include "dir.h"
>  #include "sha1-array.h"
>  #include "packfile.h"
> +#include "repository.h"
>  
>  static int get_oid_oneline(const char *, struct object_id *, struct commit_list *);
>  
> @@ -104,7 +105,7 @@ static void find_short_object_filename(struct disambiguate_state *ds)
>  		 */
>  		fakeent = alloc_alt_odb(get_object_directory());
>  	}
> -	fakeent->next = alt_odb_list;
> +	fakeent->next = the_repository->objects.alt_odb_list;
>  
>  	for (alt = fakeent; alt && !ds->ambiguous; alt = alt->next) {
>  		int pos;
> -- 
> 2.16.1.73.ga2c3e9663f.dirty
> 

-- 
Brandon Williams
