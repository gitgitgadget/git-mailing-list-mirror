Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBBA1202A0
	for <e@80x24.org>; Thu, 16 Nov 2017 21:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759010AbdKPV5U (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Nov 2017 16:57:20 -0500
Received: from mail-io0-f180.google.com ([209.85.223.180]:44125 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751029AbdKPV5S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Nov 2017 16:57:18 -0500
Received: by mail-io0-f180.google.com with SMTP id w127so6780119iow.11
        for <git@vger.kernel.org>; Thu, 16 Nov 2017 13:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rVGUcT11xCcyy9X0jiOk9AKdXkf7HqHTnVpQsMA+82Y=;
        b=hrtKmM0Z2oA/iYVcEc5G2X92MMnMVbtQo4tiV1Bt8wM79P2KnoDyFsp72U49VX3igZ
         JJQa0ItxyW1bW7XNZp4vybnGdkdW9jxS6u2HuZ8+azhkgb4F1mVeKmF+Gbf1jZVN4V67
         3FT/JghtmSsgVvQ1dTcNEDb87BlllefcXZaU2aCBA2IUVj1xGUVMb9XTynB5kGl1lcG/
         kSvilPzTQwePuiEkE5ddIj5mdm+m3d7B3+iyFubL8b9DZIXN66OLkZg5XuG0h3e+TdVn
         OFNwVAgxudelPwNf+3qjxDaaqPI63ihRIHsP0qfQRgqcEOVZGzGBZeSp15x1RGnXveJL
         4xog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rVGUcT11xCcyy9X0jiOk9AKdXkf7HqHTnVpQsMA+82Y=;
        b=QwxF/IzPiTwwLZyVxrElW20V/bwvSv0kA6wL9axCWDt6z4CdzxaBcGNiAbCJWy1yf4
         D85ymAwMkjXO4/8dGmqi2kxynasixOb0ZjRCGSdM2kT9IHeGq37d+wFuwhLBEq6WY+fs
         rrIrvDQWdVc5i1/FPGzoDzt/Il/d8552e6+ayXY51gAQzaRWS86Uw7VKE6WdyKUlCkQS
         s9EDeV44ENN9ZaTnAYdtKeOrvEgIX8LOt+JrgieVY02OZJcA+qt63StDubb6iY660LRo
         lGjXw8RS2wmuCobAwVEh0b4pQoVcXErBchn5t4bMSkiCMt1rvaS5NBw/YXVohXn23HqC
         M8SQ==
X-Gm-Message-State: AJaThX7v2Qjc3xTzRWE71/MggtxFhZa6FEm8ewQ0KHRJcaWIU7+93VGF
        z7kLUm9/JanTlqUr9cyaDngqkw==
X-Google-Smtp-Source: AGs4zMaeO8i2/R4zj3mkR2zL7B7vWT7P4hTr/IF7t+0/dJpNZZajKUyw+I7bnOqy9otnLk8oi+SIeg==
X-Received: by 10.107.169.146 with SMTP id f18mr448130ioj.30.1510869437073;
        Thu, 16 Nov 2017 13:57:17 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:31ba:dcfe:1f70:9194])
        by smtp.gmail.com with ESMTPSA id o71sm1193208itc.30.2017.11.16.13.57.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Nov 2017 13:57:16 -0800 (PST)
Date:   Thu, 16 Nov 2017 13:57:15 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4 00/10] Partial clone part 2: fsck and promisors
Message-Id: <20171116135715.7d4650f3365a678399397d01@google.com>
In-Reply-To: <20171116181257.61673-1-git@jeffhostetler.com>
References: <20171116181257.61673-1-git@jeffhostetler.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I patched both this series and the first 9 patches of mine [1] on part 1
of the entire partial clone implementation [2], and then
diffed them. I'll review just the differences between the two.

You can see the entire diff below (minus means in my patch set but not
in Jeff's, plus means the contrary) - I did not trim it.

[1] https://public-inbox.org/git/cover.1506714999.git.jonathantanmy@google.com/
[2] https://public-inbox.org/git/20171116180743.61353-1-git@jeffhostetler.com/T/#t

> diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
> index 5fad696c5..33a824eed 100644
> --- a/Documentation/git-pack-objects.txt
> +++ b/Documentation/git-pack-objects.txt
> @@ -242,9 +242,19 @@ So does `git bundle` (see linkgit:git-bundle[1]) when it creates a bundle.
>  	the resulting packfile.  See linkgit:git-rev-list[1] for valid
>  	`<filter-spec>` forms.
>  
> ---missing=(error|allow-any):
> +--missing=(error|allow-any|allow-promisor):
>  	Specifies how missing objects are handled.  This is useful, for
>  	example, when there are missing objects from a prior partial clone.
> +	This is stronger than `--missing=allow-promisor` because it limits
> +	the traversal, rather than just silencing errors about missing
> +	objects.

What is stronger than `--missing=allow-promisor`?

> +
> +--exclude-promisor-objects::
> +	Omit objects that are known to be in the promisor remote". (This

Stray quote.

> +	option has the purpose of operating only on locally created objects,
> +	so that when we repack, we still maintain a distinction between
> +	locally created objects [without .promisor] and objects from the
> +	promisor remote [with .promisor].)  This is used with partial clone.
>  
>  SEE ALSO
>  --------
> diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
> index 4a584f3c5..1ceab8944 100644
> --- a/Documentation/gitremote-helpers.txt
> +++ b/Documentation/gitremote-helpers.txt
> @@ -466,6 +466,12 @@ set by Git if the remote helper has the 'option' capability.
>  	Transmit <string> as a push option. As the push option
>  	must not contain LF or NUL characters, the string is not encoded.
>  
> +'option from-promisor' {'true'|'false'}::
> +	Indicate that these objects are being fetch by a promisor.

Should be: ...are being fetched from a promisor.

> +
> +'option no-haves' {'true'|'false'}::
> +	Do not send "have" lines.
> +
>  SEE ALSO
>  --------
>  linkgit:git-remote[1]
> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> index c84e46522..2beffe320 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -730,7 +730,7 @@ specification contained in <path>.
>  	Only useful with `--filter=`; prints a list of the omitted objects.
>  	Object IDs are prefixed with a ``~'' character.
>  
> ---missing=(error|allow-any|print)::
> +--missing=(error|allow-any|allow-promisor|print)::
>  	Specifies how missing objects are handled.  The repository may
>  	have missing objects after a partial clone, for example.
>  +
> @@ -741,10 +741,20 @@ The value 'allow-any' will allow object traversal to continue if a
>  missing object is encountered.  Missing objects will silently be omitted
>  from the results.
>  +
> +The value 'allow-promisor' is like 'allow-any' in that it will allow
> +object traversal to continue, but only for EXPECTED missing objects.
> ++
>  The value 'print' is like 'allow-any', but will also print a list of the
>  missing objects.  Object IDs are prefixed with a ``?'' character.
>  endif::git-rev-list[]
>  
> +--exclude-promisor-objects::
> +	(For internal use only.)  Prefilter object traversal at
> +	promisor boundary.  This is used with partial clone.  This is
> +	stronger than `--missing=allow-promisor` because it limits the
> +	traversal, rather than just silencing errors about missing
> +	objects.
> +
>  --no-walk[=(sorted|unsorted)]::
>  	Only show the given commits, but do not traverse their ancestors.
>  	This has no effect if a range is specified. If the argument
> diff --git a/Documentation/technical/repository-version.txt b/Documentation/technical/repository-version.txt
> index 074ccb9e0..e03eacceb 100644
> --- a/Documentation/technical/repository-version.txt
> +++ b/Documentation/technical/repository-version.txt
> @@ -87,14 +87,14 @@ When the config key `extensions.preciousObjects` is set to `true`,
>  objects in the repository MUST NOT be deleted (e.g., by `git-prune` or
>  `git repack -d`).
>  
> -`partialClone`
> +`partialclone`
>  ~~~~~~~~~~~~~~
>  
> -When the config key `extensions.partialClone` is set, a remote is
> -designated as a "promisor remote". Objects referenced by packed objects
> -obtained from that promisor remote do not need to be in the local repo.
> -Instead, the promisor remote promises that all such objects can be
> -fetched from it in the future, and Git will fetch those objects when
> -needed.
> +When the config key `extensions.partialclone` is set, it indicates
> +that the repo was created with a partial clone (or later performed
> +a partial fetch) and that the remote may have omitted sending
> +certain unwanted objects.  Such a remote is called a "promisor remote"
> +and it promises that all such omitted objects can be fetched from it
> +in the future.
>  
> -The value of this key is the name of the aforementioned promisor remote.
> +The value of this key is the name of the promisor remote.
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index f31f92a8e..32e92dbeb 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -88,6 +88,7 @@ static struct list_objects_filter_options filter_options;
>  enum missing_action {
>  	MA_ERROR = 0,    /* fail if any missing objects are encountered */
>  	MA_ALLOW_ANY,    /* silently allow ALL missing objects */
> +	MA_ALLOW_PROMISOR, /* silently allow all missing PROMISOR objects */
>  };
>  static enum missing_action arg_missing_action;
>  static show_object_fn fn_show_object;
> @@ -2580,6 +2581,20 @@ static void show_object__ma_allow_any(struct object *obj, const char *name, void
>  	show_object(obj, name, data);
>  }
>  
> +static void show_object__ma_allow_promisor(struct object *obj, const char *name, void *data)
> +{
> +	assert(arg_missing_action == MA_ALLOW_PROMISOR);
> +
> +	/*
> +	 * Quietly ignore EXPECTED missing objects.  This avoids problems with
> +	 * staging them now and getting an odd error later.
> +	 */
> +	if (!has_object_file(&obj->oid) && is_promisor_object(&obj->oid))
> +		return;
> +
> +	show_object(obj, name, data);
> +}
> +
>  static int option_parse_missing_action(const struct option *opt,
>  				       const char *arg, int unset)
>  {
> @@ -2594,10 +2609,18 @@ static int option_parse_missing_action(const struct option *opt,
>  
>  	if (!strcmp(arg, "allow-any")) {
>  		arg_missing_action = MA_ALLOW_ANY;
> +		fetch_if_missing = 0;
>  		fn_show_object = show_object__ma_allow_any;
>  		return 0;
>  	}
>  
> +	if (!strcmp(arg, "allow-promisor")) {
> +		arg_missing_action = MA_ALLOW_PROMISOR;
> +		fetch_if_missing = 0;
> +		fn_show_object = show_object__ma_allow_promisor;
> +		return 0;
> +	}
> +
>  	die(_("invalid value for --missing"));
>  	return 0;
>  }
> @@ -3062,6 +3085,9 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
>  		use_internal_rev_list = 1;
>  		fetch_if_missing = 0;
>  		argv_array_push(&rp, "--exclude-promisor-objects");
> +		/* silently override any "--missing=" value */
> +		arg_missing_action = MA_ALLOW_PROMISOR;
> +		fn_show_object = show_object__ma_allow_promisor;

--exclude-promisor-objects should be orthogonal to handling of missing
objects (and the tests pass when I remove these lines, showing that to
be true in practice).

If mixing the two is problematic from a UI standpoint, maybe it's better
to warn or die about them. But probably the best thing to do is to
document --exclude-promisor-objects as "internal use only".

>  	}
>  
>  	if (!reuse_object)
> diff --git a/builtin/repack.c b/builtin/repack.c
> index f43317bb5..7bdb40142 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -234,7 +234,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  	argv_array_push(&cmd.args, "--all");
>  	argv_array_push(&cmd.args, "--reflog");
>  	argv_array_push(&cmd.args, "--indexed-objects");
> -	argv_array_push(&cmd.args, "--exclude-promisor-objects");
> +	if (repository_format_partial_clone)
> +		argv_array_push(&cmd.args, "--exclude-promisor-objects");
>  	if (window)
>  		argv_array_pushf(&cmd.args, "--window=%s", window);
>  	if (window_memory)
> diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> index e17ab2b0f..5c5acd3d6 100644
> --- a/builtin/rev-list.c
> +++ b/builtin/rev-list.c
> @@ -68,6 +68,7 @@ enum missing_action {
>  	MA_ERROR = 0,    /* fail if any missing objects are encountered */
>  	MA_ALLOW_ANY,    /* silently allow ALL missing objects */
>  	MA_PRINT,        /* print ALL missing objects in special section */
> +	MA_ALLOW_PROMISOR, /* silently allow all missing PROMISOR objects */
>  };
>  static enum missing_action arg_missing_action;
>  
> @@ -198,6 +199,12 @@ static void finish_commit(struct commit *commit, void *data)
>  
>  static inline void finish_object__ma(struct object *obj)
>  {
> +	/*
> +	 * Whether or not we try to dynamically fetch missing objects
> +	 * from the server, we currently DO NOT have the object.  We
> +	 * can either print, allow (ignore), or conditionally allow
> +	 * (ignore) them.
> +	 */
>  	switch (arg_missing_action) {
>  	case MA_ERROR:
>  		die("missing blob object '%s'", oid_to_hex(&obj->oid));
> @@ -210,25 +217,36 @@ static inline void finish_object__ma(struct object *obj)
>  		oidset_insert(&missing_objects, &obj->oid);
>  		return;
>  
> +	case MA_ALLOW_PROMISOR:
> +		if (is_promisor_object(&obj->oid))
> +			return;
> +		die("unexpected missing blob object '%s'",
> +		    oid_to_hex(&obj->oid));
> +		return;
> +
>  	default:
>  		BUG("unhandled missing_action");
>  		return;
>  	}
>  }
>  
> -static void finish_object(struct object *obj, const char *name, void *cb_data)
> +static int finish_object(struct object *obj, const char *name, void *cb_data)
>  {
>  	struct rev_list_info *info = cb_data;
> -	if (obj->type == OBJ_BLOB && !has_object_file(&obj->oid))
> +	if (obj->type == OBJ_BLOB && !has_object_file(&obj->oid)) {
>  		finish_object__ma(obj);
> +		return 1;
> +	}
>  	if (info->revs->verify_objects && !obj->parsed && obj->type != OBJ_COMMIT)
>  		parse_object(&obj->oid);
> +	return 0;
>  }

As I said in [3], making finish_object() return int makes sense, because
we might want to suppress the object from being shown. (My version of
the code was not designed with the --missing parameter in mind.)

[3] https://public-inbox.org/git/20171108135116.f96c58500caa302583bb2810@google.com/

>  
>  static void show_object(struct object *obj, const char *name, void *cb_data)
>  {
>  	struct rev_list_info *info = cb_data;
> -	finish_object(obj, name, cb_data);
> +	if (finish_object(obj, name, cb_data))
> +		return;
>  	display_progress(progress, ++progress_counter);
>  	if (info->flags & REV_LIST_QUIET)
>  		return;
> @@ -316,11 +334,19 @@ static inline int parse_missing_action_value(const char *value)
>  
>  	if (!strcmp(value, "allow-any")) {
>  		arg_missing_action = MA_ALLOW_ANY;
> +		fetch_if_missing = 0;
>  		return 1;
>  	}
>  
>  	if (!strcmp(value, "print")) {
>  		arg_missing_action = MA_PRINT;
> +		fetch_if_missing = 0;
> +		return 1;
> +	}
> +
> +	if (!strcmp(value, "allow-promisor")) {
> +		arg_missing_action = MA_ALLOW_PROMISOR;
> +		fetch_if_missing = 0;
>  		return 1;
>  	}
>  
> @@ -349,13 +375,33 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
>  	/*
>  	 * Scan the argument list before invoking setup_revisions(), so that we
>  	 * know if fetch_if_missing needs to be set to 0.
> +	 *
> +	 * "--exclude-promisor-objects" acts as a pre-filter on missing objects
> +	 * by not crossing the boundary from realized objects to promisor
> +	 * objects.  This overrides any "--missing" value.  For consistency in
> +	 * our variables, we force MA_ALLOW_PROMISOR knowning that list-objects
> +	 * should not touch other missing objects unless there is an error.
> +	 *
> +	 * Otherwise, let "--missing" to conditionally set fetch_if_missing.
>  	 */
>  	for (i = 1; i < argc; i++) {
> -		if (!strcmp(argv[i], "--exclude-promisor-objects")) {
> +		const char *arg = argv[i];
> +		if (!strcmp(arg, "--exclude-promisor-objects")) {
>  			fetch_if_missing = 0;
> +			revs.exclude_promisor_objects = 1;
> +			arg_missing_action = MA_ALLOW_PROMISOR;
>  			break;
>  		}
>  	}
> +	for (i = 1; i < argc; i++) {
> +		const char *arg = argv[i];
> +		if (skip_prefix(arg, "--missing=", &arg)) {
> +			if (revs.exclude_promisor_objects)
> +				die(_("cannot combine --exclude-promisor-objects and --missing"));
> +			if (parse_missing_action_value(arg))
> +				break;
> +		}
> +	}

Same comment as above about the orthogonality of
--exclude-promisor-objects and --missing.

>  
>  	argc = setup_revisions(argc, argv, &revs, NULL);
>  
> @@ -421,10 +467,11 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
>  			continue;
>  		}
>  
> -		if (skip_prefix(arg, "--missing=", &arg) &&
> -		    parse_missing_action_value(arg))
> -			continue;
> -		
> +		if (!strcmp(arg, "--exclude-promisor-objects"))
> +			continue; /* already handled above */
> +		if (skip_prefix(arg, "--missing=", &arg))
> +			continue; /* already handled above */
> +
>  		usage(rev_list_usage);
>  
>  	}
> diff --git a/cache.h b/cache.h
> index 38ea41efc..05e979d4d 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -889,7 +889,7 @@ extern char *repository_format_partial_clone;
>  struct repository_format {
>  	int version;
>  	int precious_objects;
> -	char *partial_clone;
> +	char *partial_clone; /* value of extensions.partialclone */
>  	int is_bare;
>  	char *work_tree;
>  	struct string_list unknown_extensions;
> diff --git a/list-objects.c b/list-objects.c
> index bdf12c500..58621fc6e 100644
> --- a/list-objects.c
> +++ b/list-objects.c
> @@ -30,13 +30,20 @@ static void process_blob(struct rev_info *revs,
>  		die("bad blob object");
>  	if (obj->flags & (UNINTERESTING | SEEN))
>  		return;
> -	if (!has_object_file(&obj->oid)) {
> -		if (revs->exclude_promisor_objects &&
> -		    is_promisor_object(&obj->oid)) {
> -			return;
> -		}
> -		/* error message will be reported later */
> -	}
> +
> +	/*
> +	 * Pre-filter known-missing objects when explicitly requested.
> +	 * Otherwise, a missing object error message may be reported
> +	 * later (depending on other filtering criteria).
> +	 *
> +	 * Note that this "--exclude-promisor-objects" pre-filtering
> +	 * may cause the actual filter to report an incomplete list
> +	 * of missing objects.
> +	 */
> +	if (revs->exclude_promisor_objects &&
> +	    !has_object_file(&obj->oid) &&
> +	    is_promisor_object(&obj->oid))
> +		return;
>  
>  	pathlen = path->len;
>  	strbuf_addstr(path, name);
> @@ -111,10 +118,16 @@ static void process_tree(struct rev_info *revs,
>  	if (parse_tree_gently(tree, gently) < 0) {
>  		if (revs->ignore_missing_links)
>  			return;
> +
> +		/*
> +		 * Pre-filter known-missing tree objects when explicitly
> +		 * requested.  This may cause the actual filter to report
> +		 * an incomplete list of missing objects.
> +		 */
>  		if (revs->exclude_promisor_objects &&
> -		    is_promisor_object(&obj->oid)) {
> +		    is_promisor_object(&obj->oid))
>  			return;
> -		}
> +

The {} here are unnecessary for a one-line block.

>  		die("bad tree object %s", oid_to_hex(&obj->oid));
>  	}
