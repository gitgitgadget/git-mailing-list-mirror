Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61C7E1F42D
	for <e@80x24.org>; Wed, 30 May 2018 18:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753659AbeE3ShE (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 14:37:04 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:34683 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751684AbeE3ShB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 14:37:01 -0400
Received: by mail-qk0-f193.google.com with SMTP id q70-v6so6554710qke.1
        for <git@vger.kernel.org>; Wed, 30 May 2018 11:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=nu2Lp8poo3Q4KUbYEE3Ei4fE9/XC+DjYiwxgMJiy4pg=;
        b=fqBiE3fnXfDVetItgEb4b8DZ46e42cvzKrHLVPfKpCY0aK2RzbAFdDBPsX9sMYPoph
         0+X2zWw0k4uYBQ/nDPbh1IVlig3scV7SyVzIcIeIVQR4jfEdlJSdQQZMkfaIIVUhH3ip
         gkHQpieyXT1wWKvNzMdfIeecKchcqZHPT/ksiTTpUPUavDDYkMVUn0eC4EZM8/RoCWzE
         ultlvoF8bunmhuYVHy9pTXbfMZqOYHej1gnZgNG3iIGMv0nO9sNi38nOzl6dxnabPSyF
         CwVKwML8G3wYpoOcthqrP+spNeGwdUEw8hLpQysQknsnmOD3QKN/jWc3n5QJ5oNrCqto
         5+cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=nu2Lp8poo3Q4KUbYEE3Ei4fE9/XC+DjYiwxgMJiy4pg=;
        b=SqQxEZusJuFkFxDTntoYC+IOVbC5a1uTS9KfjuyEH+Dkx5MGvMKzkg+WUupRdcteem
         Bt9CZYlDqAA6XcdCOQ8e27Ka0XkIzhM9ezxB7PkHDDmKk1/77Jm8la5tbNf8jWr9ScGZ
         RY3TtfizElmkxdeV5IEhHwo35pcbKnBftBp3ZNZija05t6IiX1+UqSbAwFCtJaTNphmP
         K6GEKz6p54LOBKyBB+O4EaLTj7D7It0PaPPhXROCT5UZA3q+22sZRjs7SYG1umaDTOih
         nXB4Zah2jAKqCno22bgi2C+j1G3SL4baNHHBYK4BxEDTqr8NUASTSP8agWtk57oEl7zw
         deIw==
X-Gm-Message-State: APt69E20/f8bF2OsV3AatPG8uYwGJFoa42SrdIViQp+q9Y5+dqtrbNw/
        BBbfspdYpjP8NRiv0N0bxoE=
X-Google-Smtp-Source: ADUXVKIrTnTmXknKTkkaMaoQq5wYkhFHIEy+aZj3RxgkDC19vvnOttleqmZkFGcei35lvmN+JEwIvQ==
X-Received: by 2002:a37:b943:: with SMTP id j64-v6mr3557490qkf.362.1527705420651;
        Wed, 30 May 2018 11:37:00 -0700 (PDT)
Received: from [10.0.1.20] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id h48-v6sm28863786qta.43.2018.05.30.11.36.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 May 2018 11:36:59 -0700 (PDT)
Subject: Re: [PATCH 06/35] blob: add repository argument to lookup_blob
To:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>
References: <20180530004810.30076-1-sbeller@google.com>
 <20180530004810.30076-7-sbeller@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <defafdc6-e3e2-381e-3239-926a7df43146@gmail.com>
Date:   Wed, 30 May 2018 14:36:59 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180530004810.30076-7-sbeller@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/29/2018 8:47 PM, Stefan Beller wrote:
> Add a repository argument to allow the callers of lookup_blob
> to be more specific about which repository to act on. This is a small
> mechanical change; it doesn't change the implementation to handle
> repositories other than the_repository yet.
>
> As with the previous commits, use a macro to catch callers passing a
> repository other than the_repository at compile time.
>
> Add the cocci patch that converted the callers.
(this is the last time I'll point this out. I'll wait until I read to 
the end to see if the coccinelle patch is included in the series.)
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>   blob.c                   | 2 +-
>   blob.h                   | 3 ++-
>   builtin/fast-export.c    | 2 +-
>   builtin/fsck.c           | 3 ++-
>   builtin/index-pack.c     | 2 +-
>   builtin/merge-tree.c     | 3 ++-
>   builtin/unpack-objects.c | 2 +-
>   fsck.c                   | 2 +-
>   http-push.c              | 3 ++-
>   list-objects.c           | 2 +-
>   object.c                 | 4 ++--
>   reachable.c              | 2 +-
>   revision.c               | 4 ++--
>   tag.c                    | 2 +-
>   walker.c                 | 3 ++-
>   15 files changed, 22 insertions(+), 17 deletions(-)
>
> diff --git a/blob.c b/blob.c
> index dada295698c..17b9314f0a0 100644
> --- a/blob.c
> +++ b/blob.c
> @@ -5,7 +5,7 @@
>   
>   const char *blob_type = "blob";
>   
> -struct blob *lookup_blob(const struct object_id *oid)
> +struct blob *lookup_blob_the_repository(const struct object_id *oid)
>   {
>   	struct object *obj = lookup_object(the_repository, oid->hash);
>   	if (!obj)
> diff --git a/blob.h b/blob.h
> index 44606168310..08bc34487a0 100644
> --- a/blob.h
> +++ b/blob.h
> @@ -9,7 +9,8 @@ struct blob {
>   	struct object object;
>   };
>   
> -struct blob *lookup_blob(const struct object_id *oid);
> +#define lookup_blob(r, o) lookup_blob_##r(o)
> +struct blob *lookup_blob_the_repository(const struct object_id *oid);
>   
>   int parse_blob_buffer(struct blob *item, void *buffer, unsigned long size);
>   
> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> index a34ab9768f4..23ca46e6008 100644
> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> @@ -237,7 +237,7 @@ static void export_blob(const struct object_id *oid)
>   
>   	if (anonymize) {
>   		buf = anonymize_blob(&size);
> -		object = (struct object *)lookup_blob(oid);
> +		object = (struct object *)lookup_blob(the_repository, oid);
>   		eaten = 0;
>   	} else {
>   		buf = read_object_file(oid, &type, &size);
> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index 82a5acaf76e..6e2b204e938 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -808,7 +808,8 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
>   			mode = active_cache[i]->ce_mode;
>   			if (S_ISGITLINK(mode))
>   				continue;
> -			blob = lookup_blob(&active_cache[i]->oid);
> +			blob = lookup_blob(the_repository,
> +					   &active_cache[i]->oid);
>   			if (!blob)
>   				continue;
>   			obj = &blob->object;
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index 0dd10693597..51c5244a15a 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -832,7 +832,7 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
>   	if (strict || do_fsck_object) {
>   		read_lock();
>   		if (type == OBJ_BLOB) {
> -			struct blob *blob = lookup_blob(oid);
> +			struct blob *blob = lookup_blob(the_repository, oid);
>   			if (blob)
>   				blob->object.flags |= FLAG_CHECKED;
>   			else
> diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
> index 8a8d5797520..f8023bae1e2 100644
> --- a/builtin/merge-tree.c
> +++ b/builtin/merge-tree.c
> @@ -2,6 +2,7 @@
>   #include "tree-walk.h"
>   #include "xdiff-interface.h"
>   #include "object-store.h"
> +#include "repository.h"
>   #include "blob.h"
>   #include "exec-cmd.h"
>   #include "merge-blobs.h"
> @@ -170,7 +171,7 @@ static struct merge_list *create_entry(unsigned stage, unsigned mode, const stru
>   	res->stage = stage;
>   	res->path = path;
>   	res->mode = mode;
> -	res->blob = lookup_blob(oid);
> +	res->blob = lookup_blob(the_repository, oid);
>   	return res;
>   }
>   
> diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
> index 8e454c48649..dfea7790fde 100644
> --- a/builtin/unpack-objects.c
> +++ b/builtin/unpack-objects.c
> @@ -254,7 +254,7 @@ static void write_object(unsigned nr, enum object_type type,
>   		added_object(nr, type, buf, size);
>   		free(buf);
>   
> -		blob = lookup_blob(&obj_list[nr].oid);
> +		blob = lookup_blob(the_repository, &obj_list[nr].oid);
>   		if (blob)
>   			blob->object.flags |= FLAG_WRITTEN;
>   		else
> diff --git a/fsck.c b/fsck.c
> index f9476f56e93..2d372f2a3f3 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -367,7 +367,7 @@ static int fsck_walk_tree(struct tree *tree, void *data, struct fsck_options *op
>   			result = options->walk(obj, OBJ_TREE, data, options);
>   		}
>   		else if (S_ISREG(entry.mode) || S_ISLNK(entry.mode)) {
> -			obj = (struct object *)lookup_blob(entry.oid);
> +			obj = (struct object *)lookup_blob(the_repository, entry.oid);
>   			if (name && obj)
>   				put_object_name(options, obj, "%s%s", name,
>   					entry.path);
> diff --git a/http-push.c b/http-push.c
> index 04d95bd5da8..730e9cd0667 100644
> --- a/http-push.c
> +++ b/http-push.c
> @@ -1314,7 +1314,8 @@ static struct object_list **process_tree(struct tree *tree,
>   			p = process_tree(lookup_tree(entry.oid), p);
>   			break;
>   		case OBJ_BLOB:
> -			p = process_blob(lookup_blob(entry.oid), p);
> +			p = process_blob(lookup_blob(the_repository, entry.oid),
> +					 p);
>   			break;
>   		default:
>   			/* Subproject commit - not in this repository */
> diff --git a/list-objects.c b/list-objects.c
> index 7ae0eb8ebc7..56682c2a441 100644
> --- a/list-objects.c
> +++ b/list-objects.c
> @@ -167,7 +167,7 @@ static void process_tree(struct rev_info *revs,
>   					cb_data);
>   		else
>   			process_blob(revs,
> -				     lookup_blob(entry.oid),
> +				     lookup_blob(the_repository, entry.oid),
>   				     show, base, entry.path,
>   				     cb_data, filter_fn, filter_data);
>   	}
> diff --git a/object.c b/object.c
> index bd5df7d007a..80a8e44832f 100644
> --- a/object.c
> +++ b/object.c
> @@ -193,7 +193,7 @@ struct object *parse_object_buffer_the_repository(const struct object_id *oid, e
>   
>   	obj = NULL;
>   	if (type == OBJ_BLOB) {
> -		struct blob *blob = lookup_blob(oid);
> +		struct blob *blob = lookup_blob(the_repository, oid);
>   		if (blob) {
>   			if (parse_blob_buffer(blob, buffer, size))
>   				return NULL;
> @@ -266,7 +266,7 @@ struct object *parse_object_the_repository(const struct object_id *oid)
>   			error("sha1 mismatch %s", oid_to_hex(oid));
>   			return NULL;
>   		}
> -		parse_blob_buffer(lookup_blob(oid), NULL, 0);
> +		parse_blob_buffer(lookup_blob(the_repository, oid), NULL, 0);
>   		return lookup_object(the_repository, oid->hash);
>   	}
>   
> diff --git a/reachable.c b/reachable.c
> index 2ee55695595..cc25f012e5d 100644
> --- a/reachable.c
> +++ b/reachable.c
> @@ -91,7 +91,7 @@ static void add_recent_object(const struct object_id *oid,
>   		obj = (struct object *)lookup_tree(oid);
>   		break;
>   	case OBJ_BLOB:
> -		obj = (struct object *)lookup_blob(oid);
> +		obj = (struct object *)lookup_blob(the_repository, oid);
>   		break;
>   	default:
>   		die("unknown object type for %s: %s",
> diff --git a/revision.c b/revision.c
> index f051c6c5806..aeccbf5fe24 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -69,7 +69,7 @@ static void mark_tree_contents_uninteresting(struct tree *tree)
>   			mark_tree_uninteresting(lookup_tree(entry.oid));
>   			break;
>   		case OBJ_BLOB:
> -			mark_blob_uninteresting(lookup_blob(entry.oid));
> +			mark_blob_uninteresting(lookup_blob(the_repository, entry.oid));
>   			break;
>   		default:
>   			/* Subproject commit - not in this repository */
> @@ -1338,7 +1338,7 @@ static void do_add_index_objects_to_pending(struct rev_info *revs,
>   		if (S_ISGITLINK(ce->ce_mode))
>   			continue;
>   
> -		blob = lookup_blob(&ce->oid);
> +		blob = lookup_blob(the_repository, &ce->oid);
>   		if (!blob)
>   			die("unable to add index blob to traversal");
>   		add_pending_object_with_path(revs, &blob->object, "",
> diff --git a/tag.c b/tag.c
> index a14a4f23037..a31ae75e960 100644
> --- a/tag.c
> +++ b/tag.c
> @@ -154,7 +154,7 @@ int parse_tag_buffer(struct tag *item, const void *data, unsigned long size)
>   	bufptr = nl + 1;
>   
>   	if (!strcmp(type, blob_type)) {
> -		item->tagged = (struct object *)lookup_blob(&oid);
> +		item->tagged = (struct object *)lookup_blob(the_repository, &oid);
>   	} else if (!strcmp(type, tree_type)) {
>   		item->tagged = (struct object *)lookup_tree(&oid);
>   	} else if (!strcmp(type, commit_type)) {
> diff --git a/walker.c b/walker.c
> index aea96f0eaff..a36f53f37be 100644
> --- a/walker.c
> +++ b/walker.c
> @@ -54,7 +54,8 @@ static int process_tree(struct walker *walker, struct tree *tree)
>   				obj = &tree->object;
>   		}
>   		else {
> -			struct blob *blob = lookup_blob(entry.oid);
> +			struct blob *blob = lookup_blob(the_repository,
> +							entry.oid);
>   			if (blob)
>   				obj = &blob->object;
>   		}
