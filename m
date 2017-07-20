Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AB801F600
	for <e@80x24.org>; Thu, 20 Jul 2017 19:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936628AbdGTT7A (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jul 2017 15:59:00 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:35452 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934707AbdGTT64 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2017 15:58:56 -0400
Received: by mail-qt0-f193.google.com with SMTP id p25so4686438qtp.2
        for <git@vger.kernel.org>; Thu, 20 Jul 2017 12:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ijYi6RCMl9YB3iE01OTgolKFWvf6YTNWrxVqa8FdQsw=;
        b=DT4MLOCvJSq8u7nVZLCD+y1jy5jkhwxlxDJqWFzSZyiweSgtPnYYnTkn98m+a2TFki
         yOWdPyjhOb1V6y0AofLMSRzu77QDaxbw9SEiK0FP3hy33HpGcFrV3wVGtjN/vQ5U9O73
         6eSrlEJoYB406LyKBGPLGdjpVSy5cMcUlHrqvIHc7PtgWLBXH2cut6xiLM8jZ/i7yxOp
         c5q/4dSEhFr5uDIIurjVySPXUmur8He/IY1iBtadi9UDhp6gwDBi+JGkdNVuREIkz88R
         87lJ3tCVdp6eZhSKQq8wvHeuySI6/oUMzZadJTDS9XnQLFO2KI6hAS9T+oOehnZUcS8z
         iyEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ijYi6RCMl9YB3iE01OTgolKFWvf6YTNWrxVqa8FdQsw=;
        b=KpPCRZf7KXM48v54JKo5t+aIssH2dh03wLKVOi8S8adoKlE1px9k9R+7KfwDrj24Sp
         H2mKdAlzSbPpz0sKKYfHNpEKkOK+O3nGBNYY/BWsNYkTuoabMrhogEhgEfsXfPtwCztK
         3mTys0HN2PeVhwnt5GVZKU7usEt4ThL0YZ7fSHG6N2a9b82IOmwRk6+bS8fAaJt28tZM
         tHQ3MKBDDEc1z/9KDrehI+tqeDpCQiYweNjroK6+6LamLIGHmmx1F/PySITid0TrVQSa
         ukr3YWQyDcLHZiUA4FT5eDDWyJ12u1b6Y5IlMjv2wH67rv+mwV7C/YuQ1gqrP4/pjnJ/
         a0yA==
X-Gm-Message-State: AIVw113Uy7Dc3eSskJIrwJC1AUIqVGZSHO+VttPGEFNCAoWyTOZ56tnN
        iBf/azIpFzUevw==
X-Received: by 10.200.11.67 with SMTP id m3mr7210665qti.265.1500580735036;
        Thu, 20 Jul 2017 12:58:55 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id r58sm2345954qtc.42.2017.07.20.12.58.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jul 2017 12:58:53 -0700 (PDT)
Subject: Re: [RFC PATCH v2 2/4] promised-object, fsck: introduce promised
 objects
To:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Cc:     jrnieder@gmail.com, sbeller@google.com, git@jeffhostetler.com,
        philipoakley@iee.org
References: <cover.1500508695.git.jonathantanmy@google.com>
 <3420d9ae9ef86b78af1abe721891233e3f5865a2.1500508695.git.jonathantanmy@google.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <d8beb406-6d03-d893-4f37-83a7bdd6b9ac@gmail.com>
Date:   Thu, 20 Jul 2017 15:58:51 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <3420d9ae9ef86b78af1abe721891233e3f5865a2.1500508695.git.jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/19/2017 8:21 PM, Jonathan Tan wrote:
> Currently, Git does not support repos with very large numbers of objects
> or repos that wish to minimize manipulation of certain blobs (for
> example, because they are very large) very well, even if the user
> operates mostly on part of the repo, because Git is designed on the
> assumption that every referenced object is available somewhere in the
> repo storage.
> 

Great to see this idea making progress. Making git able to gracefully 
handle partial clones (beyond the existing shallow clone support) is a 
key piece of dealing with very large objects and repos.

> As a first step to reducing this problem, introduce the concept of
> promised objects. Each Git repo can contain a list of promised objects
> and their sizes (if blobs) at $GIT_DIR/objects/promised. This patch
> contains functions to query them; functions for creating and modifying
> that file will be introduced in later patches.

If I'm reading this patch correctly, for a repo to successfully pass 
"git fsck" either the object or a promise must exist for everything fsck 
checks.  From the documentation for fsck it says "git fsck defaults to 
using the index file, all SHA-1 references in refs namespace, and all 
reflogs (unless --no-reflogs is given) as heads." Doesn't this then 
imply objects or promises must exist for all objects referenced by any 
of these locations?

We're currently in the hundreds of millions of objects on some of our 
repos so even downloading the promises for all the objects in the index 
is unreasonable as it is gigabytes of data and growing.

I think we should have a flag (off by default) that enables someone to 
say that promised objects are optional. If the flag is set, 
"is_promised_object" will return success and pass the OBJ_ANY type and a 
size of -1.

Nothing today is using the size and in the two places where the object 
type is being checked for consistency (fsck_cache_tree and 
fsck_handle_ref) the test can add a test for OBJ_ANY as well.

This will enable very large numbers of objects to be omitted from the 
clone without triggering a download of the corresponding number of 
promised objects.

> 
> A repository that is missing an object but has that object promised is not
> considered to be in error, so also teach fsck this. As part of doing
> this, object.{h,c} has been modified to generate "struct object" based
> on only the information available to promised objects, without requiring
> the object itself.

In your work on this, did you investigate if there are other commands 
(ie repack/gc) that will need to learn about promised objects? Have you 
had a chance (or have plans) to hack up the test suite so that it runs 
all tests with promised objects and see what (if anything) breaks?

> 
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>   Documentation/technical/repository-version.txt |   6 ++
>   Makefile                                       |   1 +
>   builtin/fsck.c                                 |  18 +++-
>   cache.h                                        |   2 +
>   environment.c                                  |   1 +
>   fsck.c                                         |   6 +-
>   object.c                                       |  19 ++++
>   object.h                                       |  19 ++++
>   promised-object.c                              | 130 +++++++++++++++++++++++++
>   promised-object.h                              |  22 +++++
>   setup.c                                        |   7 +-
>   t/t3907-promised-object.sh                     |  41 ++++++++
>   t/test-lib-functions.sh                        |   6 ++
>   13 files changed, 273 insertions(+), 5 deletions(-)
>   create mode 100644 promised-object.c
>   create mode 100644 promised-object.h
>   create mode 100755 t/t3907-promised-object.sh
> 
> diff --git a/Documentation/technical/repository-version.txt b/Documentation/technical/repository-version.txt
> index 00ad37986..f8b82c1c7 100644
> --- a/Documentation/technical/repository-version.txt
> +++ b/Documentation/technical/repository-version.txt
> @@ -86,3 +86,9 @@ for testing format-1 compatibility.
>   When the config key `extensions.preciousObjects` is set to `true`,
>   objects in the repository MUST NOT be deleted (e.g., by `git-prune` or
>   `git repack -d`).
> +
> +`promisedObjects`
> +~~~~~~~~~~~~~~~~~
> +
> +(Explain this - basically a string containing a command to be run
> +whenever a missing object needs to be fetched.)
> diff --git a/Makefile b/Makefile
> index 9c9c42f8f..c1446d5ef 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -828,6 +828,7 @@ LIB_OBJS += preload-index.o
>   LIB_OBJS += pretty.o
>   LIB_OBJS += prio-queue.o
>   LIB_OBJS += progress.o
> +LIB_OBJS += promised-object.o
>   LIB_OBJS += prompt.o
>   LIB_OBJS += quote.o
>   LIB_OBJS += reachable.o
> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index 462b8643b..49e21f361 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -15,6 +15,7 @@
>   #include "progress.h"
>   #include "streaming.h"
>   #include "decorate.h"
> +#include "promised-object.h"
>   
>   #define REACHABLE 0x0001
>   #define SEEN      0x0002
> @@ -44,6 +45,7 @@ static int name_objects;
>   #define ERROR_REACHABLE 02
>   #define ERROR_PACK 04
>   #define ERROR_REFS 010
> +#define ERROR_PROMISED_OBJECT 011
>   
>   static const char *describe_object(struct object *obj)
>   {
> @@ -436,7 +438,7 @@ static int fsck_handle_ref(const char *refname, const struct object_id *oid,
>   {
>   	struct object *obj;
>   
> -	obj = parse_object(oid);
> +	obj = parse_or_promise_object(oid);
>   	if (!obj) {
>   		error("%s: invalid sha1 pointer %s", refname, oid_to_hex(oid));
>   		errors_found |= ERROR_REACHABLE;
> @@ -592,7 +594,7 @@ static int fsck_cache_tree(struct cache_tree *it)
>   		fprintf(stderr, "Checking cache tree\n");
>   
>   	if (0 <= it->entry_count) {
> -		struct object *obj = parse_object(&it->oid);
> +		struct object *obj = parse_or_promise_object(&it->oid);
>   		if (!obj) {
>   			error("%s: invalid sha1 pointer in cache-tree",
>   			      oid_to_hex(&it->oid));
> @@ -635,6 +637,12 @@ static int mark_packed_for_connectivity(const struct object_id *oid,
>   	return 0;
>   }
>   
> +static int mark_have_promised_object(const struct object_id *oid, void *data)
> +{
> +	mark_object_for_connectivity(oid);
> +	return 0;
> +}
> +
>   static char const * const fsck_usage[] = {
>   	N_("git fsck [<options>] [<object>...]"),
>   	NULL
> @@ -690,6 +698,11 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
>   
>   	git_config(fsck_config, NULL);
>   
> +	if (fsck_promised_objects()) {
> +		error("Errors found in promised object list");
> +		errors_found |= ERROR_PROMISED_OBJECT;
> +	}
> +
>   	fsck_head_link();
>   	if (connectivity_only) {
>   		for_each_loose_object(mark_loose_for_connectivity, NULL, 0);
> @@ -727,6 +740,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
>   			stop_progress(&progress);
>   		}
>   	}
> +	for_each_promised_object(mark_have_promised_object, NULL);
>   
>   	heads = 0;
>   	for (i = 0; i < argc; i++) {
> diff --git a/cache.h b/cache.h
> index 71fe09264..dd94b5ffc 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -853,10 +853,12 @@ extern int grafts_replace_parents;
>   #define GIT_REPO_VERSION 0
>   #define GIT_REPO_VERSION_READ 1
>   extern int repository_format_precious_objects;
> +extern char *repository_format_promised_objects;
>   
>   struct repository_format {
>   	int version;
>   	int precious_objects;
> +	char *promised_objects;
>   	int is_bare;
>   	char *work_tree;
>   	struct string_list unknown_extensions;
> diff --git a/environment.c b/environment.c
> index 3fd4b1084..82658470d 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -27,6 +27,7 @@ int warn_ambiguous_refs = 1;
>   int warn_on_object_refname_ambiguity = 1;
>   int ref_paranoia = -1;
>   int repository_format_precious_objects;
> +char *repository_format_promised_objects;
>   const char *git_commit_encoding;
>   const char *git_log_output_encoding;
>   const char *apply_default_whitespace;
> diff --git a/fsck.c b/fsck.c
> index b4204d772..f08ff0675 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -460,8 +460,10 @@ int fsck_walk(struct object *obj, void *data, struct fsck_options *options)
>   	if (!obj)
>   		return -1;
>   
> -	if (obj->type == OBJ_NONE)
> -		parse_object(&obj->oid);
> +	if (!obj->parsed && !obj->promised)
> +		parse_or_promise_object(&obj->oid);
> +	if (obj->promised)
> +		return 0;
>   
>   	switch (obj->type) {
>   	case OBJ_BLOB:
> diff --git a/object.c b/object.c
> index 321d7e920..0aeb95084 100644
> --- a/object.c
> +++ b/object.c
> @@ -4,6 +4,7 @@
>   #include "tree.h"
>   #include "commit.h"
>   #include "tag.h"
> +#include "promised-object.h"
>   
>   static struct object **obj_hash;
>   static int nr_objs, obj_hash_size;
> @@ -141,6 +142,7 @@ void *create_object(const unsigned char *sha1, void *o)
>   	struct object *obj = o;
>   
>   	obj->parsed = 0;
> +	obj->promised = 0;
>   	obj->flags = 0;
>   	hashcpy(obj->oid.hash, sha1);
>   
> @@ -279,6 +281,23 @@ struct object *parse_object(const struct object_id *oid)
>   	return NULL;
>   }
>   
> +struct object *parse_or_promise_object(const struct object_id *oid)
> +{
> +	enum object_type type;
> +
> +	if (has_object_file(oid))
> +		return parse_object(oid);
> +
> +	if (is_promised_object(oid, &type, NULL)) {
> +		struct object *obj = lookup_unknown_object(oid->hash);
> +		obj->promised = 1;
> +		obj->type = type;
> +		return obj;
> +	}
> +
> +	return NULL;
> +}
> +
>   struct object_list *object_list_insert(struct object *item,
>   				       struct object_list **list_p)
>   {
> diff --git a/object.h b/object.h
> index 0a419ba8d..640c8bff1 100644
> --- a/object.h
> +++ b/object.h
> @@ -46,7 +46,17 @@ struct object_array {
>    * The object type is stored in 3 bits.
>    */
>   struct object {
> +	/*
> +	 * Set if this object is parsed. If set, "type" is populated and this
> +	 * object can be casted to "struct commit" or an equivalent.
> +	 */
>   	unsigned parsed : 1;
> +	/*
> +	 * Set if this object is not in the repo but is promised. If set,
> +	 * "type" is populated, but this object cannot be casted to "struct
> +	 * commit" or an equivalent.
> +	 */
> +	unsigned promised : 1;
>   	unsigned type : TYPE_BITS;
>   	unsigned flags : FLAG_BITS;
>   	struct object_id oid;
> @@ -104,6 +114,15 @@ struct object *parse_object_or_die(const struct object_id *oid, const char *name
>    */
>   struct object *parse_object_buffer(const struct object_id *oid, enum object_type type, unsigned long size, void *buffer, int *eaten_p);
>   
> +/*
> + * Returns the object, having parsed it if possible. In the returned object,
> + * either "parsed" or "promised" will be set.
> + *
> + * Returns NULL if the object is missing and not promised, or if the object is
> + * corrupt.
> + */
> +struct object *parse_or_promise_object(const struct object_id *oid);
> +
>   /** Returns the object, with potentially excess memory allocated. **/
>   struct object *lookup_unknown_object(const unsigned  char *sha1);
>   
> diff --git a/promised-object.c b/promised-object.c
> new file mode 100644
> index 000000000..487ade437
> --- /dev/null
> +++ b/promised-object.c
> @@ -0,0 +1,130 @@
> +#include "cache.h"
> +#include "promised-object.h"
> +#include "sha1-lookup.h"
> +#include "strbuf.h"
> +
> +#define ENTRY_SIZE (GIT_SHA1_RAWSZ + 1 + 8)
> +/*
> + * A mmap-ed byte array of size (promised_object_nr * ENTRY_SIZE). Each
> + * ENTRY_SIZE-sized entry consists of the SHA-1 of the promised object, its
> + * 8-bit object type, and its 64-bit size in network byte order. The entries
> + * are sorted in ascending SHA-1 order.
> + */
> +static char *promised_objects;
> +static int64_t promised_object_nr = -1;
> +
> +static void prepare_promised_objects(void)
> +{
> +	char *filename;
> +	int fd;
> +	struct stat st;
> +
> +	if (promised_object_nr >= 0)
> +		return;
> +
> +	if (!repository_format_promised_objects ||
> +	    getenv("GIT_IGNORE_PROMISED_OBJECTS")) {
> +		promised_object_nr = 0;
> +		return;
> +	}
> +
> +	filename = xstrfmt("%s/promised", get_object_directory());
> +	fd = git_open(filename);
> +	if (fd < 0) {
> +		if (errno == ENOENT) {
> +			promised_object_nr = 0;
> +			goto cleanup;
> +		}
> +		perror("prepare_promised_objects");
> +		die("Could not open %s", filename);
> +	}
> +	if (fstat(fd, &st)) {
> +		perror("prepare_promised_objects");
> +		die("Could not stat %s", filename);
> +	}
> +	if (st.st_size == 0) {
> +		promised_object_nr = 0;
> +		goto cleanup;
> +	}
> +	if (st.st_size % ENTRY_SIZE) {
> +		die("Size of %s is not a multiple of %d", filename, ENTRY_SIZE);
> +	}
> +
> +	promised_objects = xmmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
> +	promised_object_nr = st.st_size / ENTRY_SIZE;
> +
> +cleanup:
> +	free(filename);
> +	if (fd >= 0)
> +		close(fd);
> +}
> +
> +int is_promised_object(const struct object_id *oid, enum object_type *type,
> +		       unsigned long *size)
> +{
> +	int result;
> +
> +	prepare_promised_objects();
> +	result = sha1_entry_pos(promised_objects, ENTRY_SIZE, 0, 0,
> +				promised_object_nr, promised_object_nr,
> +				oid->hash);
> +	if (result >= 0) {
> +		if (type) {
> +			char *ptr = promised_objects +
> +				    result * ENTRY_SIZE + GIT_SHA1_RAWSZ;
> +			*type = *ptr;
> +		}
> +		if (size) {
> +			uint64_t size_nbo;
> +			char *ptr = promised_objects +
> +				    result * ENTRY_SIZE + GIT_SHA1_RAWSZ + 1;
> +			memcpy(&size_nbo, ptr, sizeof(size_nbo));
> +			*size = ntohll(size_nbo);
> +		}
> +		return 1;
> +	}
> +	return 0;
> +}
> +
> +int for_each_promised_object(each_promised_object_fn cb, void *data)
> +{
> +	struct object_id oid;
> +	int i, r;
> +
> +	prepare_promised_objects();
> +	for (i = 0; i < promised_object_nr; i++) {
> +		memcpy(oid.hash, &promised_objects[i * ENTRY_SIZE],
> +		       GIT_SHA1_RAWSZ);
> +		r = cb(&oid, data);
> +		if (r)
> +			return r;
> +	}
> +	return 0;
> +}
> +
> +int fsck_promised_objects(void)
> +{
> +	int i;
> +	prepare_promised_objects();
> +	for (i = 0; i < promised_object_nr; i++) {
> +		enum object_type type;
> +		if (i != 0 && memcmp(&promised_objects[(i - 1) * ENTRY_SIZE],
> +				     &promised_objects[i * ENTRY_SIZE],
> +				     GIT_SHA1_RAWSZ) >= 0)
> +			return error("Error in list of promised objects: not "
> +				     "in ascending order of object name");
> +		type = promised_objects[i * ENTRY_SIZE + GIT_SHA1_RAWSZ];
> +		switch (type) {
> +			case OBJ_BLOB:
> +			case OBJ_TREE:
> +			case OBJ_COMMIT:
> +			case OBJ_TAG:
> +				break;
> +			default:
> +				return error("Error in list of promised "
> +					     "objects: found object of type %d",
> +					     type);
> +		}
> +	}
> +	return 0;
> +}
> diff --git a/promised-object.h b/promised-object.h
> new file mode 100644
> index 000000000..7eaedff17
> --- /dev/null
> +++ b/promised-object.h
> @@ -0,0 +1,22 @@
> +#ifndef PROMISED_OBJECT_H
> +#define PROMISED_OBJECT_H
> +
> +#include "cache.h"
> +
> +/*
> + * Returns 1 if oid is the name of a promised object. For non-blobs, 0 is
> + * reported as their size.
> + */
> +int is_promised_object(const struct object_id *oid, enum object_type *type,
> +		       unsigned long *size);
> +
> +typedef int each_promised_object_fn(const struct object_id *oid, void *data);
> +int for_each_promised_object(each_promised_object_fn, void *);
> +
> +/*
> + * Returns 0 if there is no list of promised objects or if the list of promised
> + * objects is valid.
> + */
> +int fsck_promised_objects(void);
> +
> +#endif
> diff --git a/setup.c b/setup.c
> index 860507e1f..36022452f 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -425,7 +425,11 @@ static int check_repo_format(const char *var, const char *value, void *vdata)
>   			;
>   		else if (!strcmp(ext, "preciousobjects"))
>   			data->precious_objects = git_config_bool(var, value);
> -		else
> +		else if (!strcmp(ext, "promisedobjects")) {
> +			if (!value)
> +				return config_error_nonbool(var);
> +			data->promised_objects = xstrdup(value);
> +		} else
>   			string_list_append(&data->unknown_extensions, ext);
>   	} else if (strcmp(var, "core.bare") == 0) {
>   		data->is_bare = git_config_bool(var, value);
> @@ -468,6 +472,7 @@ static int check_repository_format_gently(const char *gitdir, int *nongit_ok)
>   	}
>   
>   	repository_format_precious_objects = candidate.precious_objects;
> +	repository_format_promised_objects = candidate.promised_objects;
>   	string_list_clear(&candidate.unknown_extensions, 0);
>   	if (!has_common) {
>   		if (candidate.is_bare != -1) {
> diff --git a/t/t3907-promised-object.sh b/t/t3907-promised-object.sh
> new file mode 100755
> index 000000000..3e0caf4f9
> --- /dev/null
> +++ b/t/t3907-promised-object.sh
> @@ -0,0 +1,41 @@
> +#!/bin/sh
> +
> +test_description='promised objects'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'fsck fails on missing objects' '
> +	test_create_repo repo &&
> +
> +	test_commit -C repo 1 &&
> +	test_commit -C repo 2 &&
> +	test_commit -C repo 3 &&
> +	git -C repo tag -a annotated_tag -m "annotated tag" &&
> +	C=$(git -C repo rev-parse 1) &&
> +	T=$(git -C repo rev-parse 2^{tree}) &&
> +	B=$(git hash-object repo/3.t) &&
> +	AT=$(git -C repo rev-parse annotated_tag) &&
> +
> +	# missing commit, tree, blob, and tag
> +	rm repo/.git/objects/$(echo $C | cut -c1-2)/$(echo $C | cut -c3-40) &&
> +	rm repo/.git/objects/$(echo $T | cut -c1-2)/$(echo $T | cut -c3-40) &&
> +	rm repo/.git/objects/$(echo $B | cut -c1-2)/$(echo $B | cut -c3-40) &&
> +	rm repo/.git/objects/$(echo $AT | cut -c1-2)/$(echo $AT | cut -c3-40) &&
> +	test_must_fail git -C repo fsck
> +'
> +
> +test_expect_success '...but succeeds if they are promised objects' '
> +	printf "%s01%016x\n%s02%016x\n%s03%016x\n%s04%016x" \
> +		"$C" 0 "$T" 0 "$B" "$(wc -c <repo/3.t)" "$AT" 0 |
> +		sort | tr -d "\n" | hex_pack >repo/.git/objects/promised &&
> +	git -C repo config core.repositoryformatversion 1 &&
> +	git -C repo config extensions.promisedobjects "arbitrary string" &&
> +	git -C repo fsck
> +'
> +
> +test_expect_success '...but fails again with GIT_IGNORE_PROMISED_OBJECTS' '
> +	GIT_IGNORE_PROMISED_OBJECTS=1 test_must_fail git -C repo fsck &&
> +	unset GIT_IGNORE_PROMISED_OBJECTS
> +'
> +
> +test_done
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index db622c355..1ebdd2d04 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -1018,3 +1018,9 @@ nongit () {
>   		"$@"
>   	)
>   }
> +
> +# Converts big-endian pairs of hexadecimal digits into bytes. For example,
> +# "printf 61620d0a | hex_pack" results in "ab\r\n".
> +hex_pack () {
> +	perl -e '$/ = undef; $input = <>; print pack("H*", $input)'
> +}
> 
