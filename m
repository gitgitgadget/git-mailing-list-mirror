Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 985DF1F597
	for <e@80x24.org>; Tue, 17 Jul 2018 18:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbeGQT3R (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 15:29:17 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44515 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729755AbeGQT3R (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 15:29:17 -0400
Received: by mail-wr1-f67.google.com with SMTP id r16-v6so2230582wrt.11
        for <git@vger.kernel.org>; Tue, 17 Jul 2018 11:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=sZCVJvPko7P6Tcdy8r8VHnRrpo0cAQrukWoSXTmTgQ0=;
        b=k5nIREa58+GbfMQOKM5ye5RmOSWlKRuNW2X1UkqPdeyUyuXJiwaLrAeUl94AJJOUpB
         QweeZC5/i3v+3Zc4jLs6jdz+IL6L2zhQCbC1aR+axXAywfffSr0Hg01Rsosjzjh3TNkZ
         k4xVaElhOW/fnIxOXh0CpgMo/D8SLQt3PYSz212dYL6tZ0C2so99iZPcxkvfn1bkx/HS
         b6rn8WxYlNKZc3hoTsjwpZ2dFU2HF8oJMlrlxugpGHlPwEh/pmwyNmDdGlhdQDQOOCLY
         HJDUIbzqeLr3QL1Qv/fO+zalH/EqPx0DP432R/z+WlOFoRYE6E/5hT1W0Zr+gCBVARMI
         5uSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=sZCVJvPko7P6Tcdy8r8VHnRrpo0cAQrukWoSXTmTgQ0=;
        b=oHSH95TFvZmqEQ9NFuXgjw52JNIGfz6ZR553MD8jtGAuilkniNBw7k6z7M9k/fvUZi
         j8mrOCS11NC4ruww1YtBPlbWrdnEj82YuzFp3ecx4ZCqmhLpCDwXnVSVL/ol91J+PAXd
         Vw3k/ln1TMW9mLr1Z4zovD3/DI3yDFBfk4EPGhlHrRKQ4RRO5vIVp3Fr4rlZC92rkkZu
         hUbk/tappjWHNHNn3cInpRh6me9xwo0tPTiRcavteyI+wgBMsGYirO2tikC47Tbze2Ro
         C16chqjwe3urNniZvs+8scxpUugQY3JzFNhguPZA3k0Tw2sPb7utNQ2qWBejsIR76UOA
         MgyQ==
X-Gm-Message-State: AOUpUlFSbDFg0hOOfjHKuKccXuWBQzjhjrUYy3qZfG3xAXuoN2ZDH7G7
        n9PFjUyR6kz3eN/FrGx7hRA=
X-Google-Smtp-Source: AAOMgpeogm7J+IU6zxdFNCjSRUPQmvSHfbW7bGJsnnp/yF0HAYO0ebgTvGdfzdfwlbnpkMbJ3sN0uQ==
X-Received: by 2002:adf:a211:: with SMTP id p17-v6mr2238925wra.196.1531853717516;
        Tue, 17 Jul 2018 11:55:17 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id i1-v6sm3046196wrq.69.2018.07.17.11.55.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 11:55:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 2/6] tree-walk: Add three new gentle helpers
References: <cover.1531778417.git.ungureanupaulsebastian@gmail.com>
        <b1f385105f790cafc65c26699282919a2735d4bd.1531778417.git.ungureanupaulsebastian@gmail.com>
Date:   Tue, 17 Jul 2018 11:55:16 -0700
In-Reply-To: <b1f385105f790cafc65c26699282919a2735d4bd.1531778417.git.ungureanupaulsebastian@gmail.com>
        (Paul-Sebastian Ungureanu's message of "Tue, 17 Jul 2018 15:06:32
        +0300")
Message-ID: <xmqqin5dofor.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com> writes:

> Add `get_tree_entry_gently()`, `find_tree_entry_gently()`
> and `get_tree_entry_follow_symlinks_gently()`, which will
> make `get_oid()` to be more gently.
>
> Since `get_tree_entry()` is used in more than 20 places,
> adding a new parameter will make this commit harder to read.
> In every place it is called there will need to be an additional
> 0 parameter at the end of the call. The solution to avoid this is
> to rename the function in `get_tree_entry_gently()` which gets
> an additional `flags` variable. A new `get_tree_entry()`
> will call `get_tree_entry_gently()` with `flags` being 0.
> This way, no additional changes will be needed.

And that is the right way to introduce a new feature to existing API
with many callers in general.

I wonder if the GENTLY option should apply to update_tree_entry()
the same way as it would to the other codepaths that currently die
to express "we were handed this string by the caller and told to
give back object ID the string represents, and we found no good
answer".  In this one (and the "bad ref" one), the existing failures
in these two codepaths are not "we got a string and that does not
resolve to an object name", but "we didn't have the data to work on
to begin with (either a corrupt tree object or a corrupt ref").

In other words, it's not like "We were given HEAD:no-such-path and
there is no such path in that tree"; it is "We tried to read HEAD:
tree for no-such-path in it, but the tree was corrupt and we couldn't
even tell if such a path is or is not in it", no?

> Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
> ---
>  sha1-name.c |   2 +-
>  tree-walk.c | 108 +++++++++++++++++++++++++++++++++++++++++++---------
>  tree-walk.h |   3 +-
>  3 files changed, 94 insertions(+), 19 deletions(-)
>
> diff --git a/sha1-name.c b/sha1-name.c
> index 60d9ef3c7..d741e1129 100644
> --- a/sha1-name.c
> +++ b/sha1-name.c
> @@ -1721,7 +1721,7 @@ static int get_oid_with_context_1(const char *name,
>  			if (flags & GET_OID_FOLLOW_SYMLINKS) {
>  				ret = get_tree_entry_follow_symlinks(&tree_oid,
>  					filename, oid, &oc->symlink_path,
> -					&oc->mode);
> +					&oc->mode, flags);
>  			} else {
>  				ret = get_tree_entry(&tree_oid, filename, oid,
>  						     &oc->mode);
> diff --git a/tree-walk.c b/tree-walk.c
> index 8f5090862..2925eaec2 100644
> --- a/tree-walk.c
> +++ b/tree-walk.c
> @@ -491,7 +491,9 @@ struct dir_state {
>  	struct object_id oid;
>  };
>  
> -static int find_tree_entry(struct tree_desc *t, const char *name, struct object_id *result, unsigned *mode)
> +static int find_tree_entry(struct tree_desc *t, const char *name,
> +				  struct object_id *result, unsigned *mode,
> +				  int flags)
>  {
>  	int namelen = strlen(name);
>  	while (t->size) {
> @@ -501,7 +503,11 @@ static int find_tree_entry(struct tree_desc *t, const char *name, struct object_
>  
>  		oid = tree_entry_extract(t, &entry, mode);
>  		entrylen = tree_entry_len(&t->entry);
> -		update_tree_entry(t);
> +
> +		if (!(flags & GET_OID_GENTLY))
> +			update_tree_entry(t);
> +		else if (update_tree_entry_gently(t))
> +			return -1;
>  		if (entrylen > namelen)
>  			continue;
>  		cmp = memcmp(name, entry, entrylen);
> @@ -521,19 +527,28 @@ static int find_tree_entry(struct tree_desc *t, const char *name, struct object_
>  			oidcpy(result, oid);
>  			return 0;
>  		}
> -		return get_tree_entry(oid, name + entrylen, result, mode);
> +		return get_tree_entry_gently(oid, name + entrylen, result, mode, flags);
>  	}
>  	return -1;
>  }
>  
> -int get_tree_entry(const struct object_id *tree_oid, const char *name, struct object_id *oid, unsigned *mode)
> +int get_tree_entry_gently(const struct object_id *tree_oid, const char *name,
> +			  struct object_id *oid, unsigned *mode, int flags)
>  {
>  	int retval;
>  	void *tree;
>  	unsigned long size;
>  	struct object_id root;
>  
> -	tree = read_object_with_reference(tree_oid, tree_type, &size, &root);
> +	if (!(flags & GET_OID_GENTLY)) {
> +		tree = read_object_with_reference(tree_oid, tree_type, &size, &root);
> +	} else {
> +		struct object_info oi = OBJECT_INFO_INIT;
> +
> +		oi.contentp = tree;
> +		if (oid_object_info_extended(the_repository, tree_oid, &oi, 0) < 0)
> +			return -1;
> +	}
>  	if (!tree)
>  		return -1;
>  
> @@ -547,13 +562,27 @@ int get_tree_entry(const struct object_id *tree_oid, const char *name, struct ob
>  		retval = -1;
>  	} else {
>  		struct tree_desc t;
> -		init_tree_desc(&t, tree, size);
> -		retval = find_tree_entry(&t, name, oid, mode);
> +		if (!(flags & GET_OID_GENTLY)) {
> +			init_tree_desc(&t, tree, size);
> +		} else {
> +			if (init_tree_desc_gently(&t, tree, size)) {
> +				retval = -1;
> +				goto done;
> +			}
> +		}
> +		retval = find_tree_entry(&t, name, oid, mode, flags);
>  	}
> +done:
>  	free(tree);
>  	return retval;
>  }
>  
> +int get_tree_entry(const struct object_id *tree_oid, const char *name,
> +		   struct object_id *oid, unsigned *mode)
> +{
> +	return get_tree_entry_gently(tree_oid, name, oid, mode, 0);
> +}
> +
>  /*
>   * This is Linux's built-in max for the number of symlinks to follow.
>   * That limit, of course, does not affect git, but it's a reasonable
> @@ -576,7 +605,7 @@ int get_tree_entry(const struct object_id *tree_oid, const char *name, struct ob
>   * See the code for enum follow_symlink_result for a description of
>   * the return values.
>   */
> -enum follow_symlinks_result get_tree_entry_follow_symlinks(struct object_id *tree_oid, const char *name, struct object_id *result, struct strbuf *result_path, unsigned *mode)
> +enum follow_symlinks_result get_tree_entry_follow_symlinks(struct object_id *tree_oid, const char *name, struct object_id *result, struct strbuf *result_path, unsigned *mode, int flags)
>  {
>  	int retval = MISSING_OBJECT;
>  	struct dir_state *parents = NULL;
> @@ -600,9 +629,21 @@ enum follow_symlinks_result get_tree_entry_follow_symlinks(struct object_id *tre
>  			void *tree;
>  			struct object_id root;
>  			unsigned long size;
> -			tree = read_object_with_reference(&current_tree_oid,
> -							  tree_type, &size,
> -							  &root);
> +			if (!(flags & GET_OID_GENTLY)) {
> +				tree = read_object_with_reference(&current_tree_oid,
> +								  tree_type, &size,
> +								  &root);
> +			} else {
> +				struct object_info oi = OBJECT_INFO_INIT;
> +
> +				oi.contentp = tree;
> +				if (oid_object_info_extended(the_repository,
> +				    &current_tree_oid, &oi, 0) < 0) {
> +					retval = MISSING_OBJECT;
> +					goto done;
> +				}
> +			}
> +
>  			if (!tree)
>  				goto done;
>  
> @@ -622,7 +663,14 @@ enum follow_symlinks_result get_tree_entry_follow_symlinks(struct object_id *tre
>  				goto done;
>  
>  			/* descend */
> -			init_tree_desc(&t, tree, size);
> +			if (!(flags & GET_OID_GENTLY)) {
> +				init_tree_desc(&t, tree, size);
> +			} else {
> +				if (init_tree_desc_gently(&t, tree, size)) {
> +					retval = MISSING_OBJECT;
> +					goto done;
> +				}
> +			}
>  		}
>  
>  		/* Handle symlinks to e.g. a//b by removing leading slashes */
> @@ -656,7 +704,15 @@ enum follow_symlinks_result get_tree_entry_follow_symlinks(struct object_id *tre
>  			free(parent->tree);
>  			parents_nr--;
>  			parent = &parents[parents_nr - 1];
> -			init_tree_desc(&t, parent->tree, parent->size);
> +			if (!(flags & GET_OID_GENTLY)) {
> +				init_tree_desc(&t, parent->tree, parent->size);
> +			} else {
> +				if (init_tree_desc_gently(&t, parent->tree,
> +				    parent->size)) {
> +					retval = MISSING_OBJECT;
> +					goto done;
> +				}
> +			}
>  			strbuf_remove(&namebuf, 0, remainder ? 3 : 2);
>  			continue;
>  		}
> @@ -670,7 +726,7 @@ enum follow_symlinks_result get_tree_entry_follow_symlinks(struct object_id *tre
>  
>  		/* Look up the first (or only) path component in the tree. */
>  		find_result = find_tree_entry(&t, namebuf.buf,
> -					      &current_tree_oid, mode);
> +					      &current_tree_oid, mode, flags);
>  		if (find_result) {
>  			goto done;
>  		}
> @@ -713,8 +769,19 @@ enum follow_symlinks_result get_tree_entry_follow_symlinks(struct object_id *tre
>  			 */
>  			retval = DANGLING_SYMLINK;
>  
> -			contents = read_object_file(&current_tree_oid, &type,
> -						    &link_len);
> +			if (!(flags & GET_OID_GENTLY)) {
> +				contents = read_object_file(&current_tree_oid,
> +							    &type, &link_len);
> +			} else {
> +				struct object_info oi = OBJECT_INFO_INIT;
> +				oi.contentp = (void*) contents;
> +
> +				if (oid_object_info_extended(the_repository,
> +				    &current_tree_oid, &oi, 0) < 0) {
> +					retval = MISSING_OBJECT;
> +					goto done;
> +				}
> +			}
>  
>  			if (!contents)
>  				goto done;
> @@ -735,7 +802,14 @@ enum follow_symlinks_result get_tree_entry_follow_symlinks(struct object_id *tre
>  			contents_start = contents;
>  
>  			parent = &parents[parents_nr - 1];
> -			init_tree_desc(&t, parent->tree, parent->size);
> +			if (!(flags & GET_OID_GENTLY)) {
> +				init_tree_desc(&t, parent->tree, parent->size);
> +			} else {
> +				if (init_tree_desc_gently(&t, parent->tree, parent->size)) {
> +					retval = MISSING_OBJECT;
> +					goto done;
> +				}
> +			}
>  			strbuf_splice(&namebuf, 0, len,
>  				      contents_start, link_len);
>  			if (remainder)
> diff --git a/tree-walk.h b/tree-walk.h
> index 805f58f00..6f043af6e 100644
> --- a/tree-walk.h
> +++ b/tree-walk.h
> @@ -64,7 +64,7 @@ enum follow_symlinks_result {
>  		       */
>  };
>  
> -enum follow_symlinks_result get_tree_entry_follow_symlinks(struct object_id *tree_oid, const char *name, struct object_id *result, struct strbuf *result_path, unsigned *mode);
> +enum follow_symlinks_result get_tree_entry_follow_symlinks(struct object_id *tree_oid, const char *name, struct object_id *result, struct strbuf *result_path, unsigned *mode, int flags);
>  
>  struct traverse_info {
>  	const char *traverse_path;
> @@ -79,6 +79,7 @@ struct traverse_info {
>  	int show_all_errors;
>  };
>  
> +int get_tree_entry_gently(const struct object_id *, const char *, struct object_id *, unsigned *, int);
>  int get_tree_entry(const struct object_id *, const char *, struct object_id *, unsigned *);
>  extern char *make_traverse_path(char *path, const struct traverse_info *info, const struct name_entry *n);
>  extern void setup_traverse_info(struct traverse_info *info, const char *base);
