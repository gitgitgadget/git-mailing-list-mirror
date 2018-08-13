Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E5641F404
	for <e@80x24.org>; Mon, 13 Aug 2018 17:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730113AbeHMTzL (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 15:55:11 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44028 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729070AbeHMTzL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 15:55:11 -0400
Received: by mail-pf1-f193.google.com with SMTP id j26-v6so7940504pfi.10
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 10:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=pg+voe6KNC6c0UzpM30y0u12AQOQOMmYenYp5KoO5JI=;
        b=sYBY7V/wnGC9RFwvDPgIDJBaaowumvjqPErHKc7J85zYNCVVS2hAgxKNYT2lhYL/eZ
         NN5LIetvjbfrre7agjLsG8Omu6DefMVUzRXRt+OmDoCgsIwRHwqsNuv18o5/cdaA0cUd
         +xQB7BmXtKckN0kV5UYEIHQo5ZCUavt4Q19LZX+WvjrB8NqaQQMitL4AOZp/9ebHprzR
         GjvjLLjVogYLEk91Bf+HVXkye66Snl1Y07nYO40CwR0dcfXt/VF/KpW0m8LYLymjgDem
         94vf+FsquXVxBwn9om2N42FTHfVIcpdfpc7njR04jpHGnT3fU3Z/rxWtqyepc6J+NGHy
         aZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=pg+voe6KNC6c0UzpM30y0u12AQOQOMmYenYp5KoO5JI=;
        b=bF72uvLm1O2hE0/56K8E7/IFsYkoy4yjHF4XbemRb5eWmWIOCYJFYX6mo3SMCSEk1p
         QMMptN6+ftvk2r0TepPyOq8QfFcbvRtnC3ByAy1w+0UDb+2VhihQ07ZEqAkCXm4rduLU
         mHUWDXbJ2VuevafpoJ+qfBUt9uhjajD5BLzYLRvg7BJwZ+lpUSm+hK4niNrv6h5+oSHY
         udRRizz80oBBqqW86UAWrXRPPtW8Dh+fvZJHWe13IcIHOY5AkI2FLhFv3MIOs7Uv4wKk
         gLkdb+jegAVwDoulNgSzmad8Uw0ePHFJ3m6552oIykGlOmTo3AUTG7DCrhA22PJDyThA
         oQFg==
X-Gm-Message-State: AOUpUlHdpH+hgdljQm6Odqd7Cz1a5V3xJ6STgT22s5ud7BAncvdiGWv4
        ggOlPigd1Ojez1K4/v6pQs4vA/KX3XE=
X-Google-Smtp-Source: AA+uWPxMlTAvSNogRtzCYsLIGk+RE00CtzvJQgUWjRpLz+ncsp9mQ7awiwUp5AOzwPjT1q0D32tS/Q==
X-Received: by 2002:a62:67c2:: with SMTP id t63-v6mr19794462pfj.204.1534180324623;
        Mon, 13 Aug 2018 10:12:04 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id l84-v6sm32344600pfg.3.2018.08.13.10.12.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 10:12:03 -0700 (PDT)
Date:   Mon, 13 Aug 2018 10:12:02 -0700
From:   Brandon Williams <bmwill@google.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 03/24] attr: remove an implicit dependency on the_index
Message-ID: <20180813171202.GA240194@google.com>
References: <20180813161441.16824-1-pclouds@gmail.com>
 <20180813161441.16824-4-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180813161441.16824-4-pclouds@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/13, Nguyễn Thái Ngọc Duy wrote:
> Make the attr API take an index_state instead of assuming the_index in
> attr code. All call sites are converted blindly to keep the patch
> simple and retain current behavior. Individual call sites may receive
> further updates to use the right index instead of the_index.
> 
> There is one ugly temporary workaround added in attr.c that needs some
> more explanation.
> 
> Commit c24f3abace (apply: file commited with CRLF should roundtrip
> diff and apply - 2017-08-19) forces one convert_to_git() call to NOT
> read the index at all. But what do you know, we read it anyway by
> falling back to the_index. When "istate" from convert_to_git is now
> propagated down to read_attr_from_array() we will hit segfault
> somewhere inside read_blob_data_from_index.
> 
> The right way of dealing with this is to kill "use_index" variable and
> only follow "istate" but at this stage we are not ready for that:
> while most git_attr_set_direction() calls just passes the_index to be
> assigned to use_index, unpack-trees passes a different one which is
> used by entry.c code, which has no way to know what index to use if we
> delete use_index. So this has to be done later.

Yep, I remember back when I was doing some refactorings on the attr
system trying to get rid of the whole "use_index" thing.  At that point
in time it wasn't feasible to do so, so i'm excited that it should be
done soon! :D

> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  archive.c              |  2 +-
>  attr.c                 | 57 ++++++++++++++++++++++++++++--------------
>  attr.h                 | 10 +++++---
>  builtin/check-attr.c   |  4 +--
>  builtin/pack-objects.c |  2 +-
>  convert.c              |  2 +-
>  dir.c                  |  2 +-
>  ll-merge.c             |  4 +--
>  userdiff.c             |  2 +-
>  ws.c                   |  2 +-
>  10 files changed, 55 insertions(+), 32 deletions(-)
> 
> diff --git a/archive.c b/archive.c
> index 78b0a398a0..a8397e6173 100644
> --- a/archive.c
> +++ b/archive.c
> @@ -109,7 +109,7 @@ static const struct attr_check *get_archive_attrs(const char *path)
>  	static struct attr_check *check;
>  	if (!check)
>  		check = attr_check_initl("export-ignore", "export-subst", NULL);
> -	return git_check_attr(path, check) ? NULL : check;
> +	return git_check_attr(&the_index, path, check) ? NULL : check;
>  }
>  
>  static int check_attr_export_ignore(const struct attr_check *check)
> diff --git a/attr.c b/attr.c
> index 067fb9e0c0..863fad3bd1 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -708,10 +708,10 @@ static struct attr_stack *read_attr_from_array(const char **list)
>   * another thread could potentially be calling into the attribute system.
>   */
>  static enum git_attr_direction direction;
> -static struct index_state *use_index;
> +static const struct index_state *use_index;
>  
>  void git_attr_set_direction(enum git_attr_direction new_direction,
> -			    struct index_state *istate)
> +			    const struct index_state *istate)
>  {
>  	if (is_bare_repository() && new_direction != GIT_ATTR_INDEX)
>  		BUG("non-INDEX attr direction in a bare repo");
> @@ -743,13 +743,24 @@ static struct attr_stack *read_attr_from_file(const char *path, int macro_ok)
>  	return res;
>  }
>  
> -static struct attr_stack *read_attr_from_index(const char *path, int macro_ok)
> +static struct attr_stack *read_attr_from_index(const struct index_state *istate,
> +					       const char *path,
> +					       int macro_ok)
>  {
>  	struct attr_stack *res;
>  	char *buf, *sp;
>  	int lineno = 0;
> +	const struct index_state *to_read_from;
>  
> -	buf = read_blob_data_from_index(use_index ? use_index : &the_index, path, NULL);
> +	/*
> +	 * Temporary workaround for c24f3abace (apply: file commited
> +	 * with CRLF should roundtrip diff and apply - 2017-08-19)
> +	 */
> +	to_read_from = use_index ? use_index : istate;
> +	if (!to_read_from)
> +		return NULL;
> +
> +	buf = read_blob_data_from_index(to_read_from, path, NULL);
>  	if (!buf)
>  		return NULL;
>  
> @@ -768,15 +779,16 @@ static struct attr_stack *read_attr_from_index(const char *path, int macro_ok)
>  	return res;
>  }
>  
> -static struct attr_stack *read_attr(const char *path, int macro_ok)
> +static struct attr_stack *read_attr(const struct index_state *istate,
> +				    const char *path, int macro_ok)
>  {
>  	struct attr_stack *res = NULL;
>  
>  	if (direction == GIT_ATTR_INDEX) {
> -		res = read_attr_from_index(path, macro_ok);
> +		res = read_attr_from_index(istate, path, macro_ok);
>  	} else if (!is_bare_repository()) {
>  		if (direction == GIT_ATTR_CHECKOUT) {
> -			res = read_attr_from_index(path, macro_ok);
> +			res = read_attr_from_index(istate, path, macro_ok);
>  			if (!res)
>  				res = read_attr_from_file(path, macro_ok);
>  		} else if (direction == GIT_ATTR_CHECKIN) {
> @@ -788,7 +800,7 @@ static struct attr_stack *read_attr(const char *path, int macro_ok)
>  				 * We allow operation in a sparsely checked out
>  				 * work tree, so read from it.
>  				 */
> -				res = read_attr_from_index(path, macro_ok);
> +				res = read_attr_from_index(istate, path, macro_ok);
>  		}
>  	}
>  
> @@ -859,7 +871,8 @@ static void push_stack(struct attr_stack **attr_stack_p,
>  	}
>  }
>  
> -static void bootstrap_attr_stack(struct attr_stack **stack)
> +static void bootstrap_attr_stack(const struct index_state *istate,
> +				 struct attr_stack **stack)
>  {
>  	struct attr_stack *e;
>  
> @@ -883,7 +896,7 @@ static void bootstrap_attr_stack(struct attr_stack **stack)
>  	}
>  
>  	/* root directory */
> -	e = read_attr(GITATTRIBUTES_FILE, 1);
> +	e = read_attr(istate, GITATTRIBUTES_FILE, 1);
>  	push_stack(stack, e, xstrdup(""), 0);
>  
>  	/* info frame */
> @@ -896,7 +909,8 @@ static void bootstrap_attr_stack(struct attr_stack **stack)
>  	push_stack(stack, e, NULL, 0);
>  }
>  
> -static void prepare_attr_stack(const char *path, int dirlen,
> +static void prepare_attr_stack(const struct index_state *istate,
> +			       const char *path, int dirlen,
>  			       struct attr_stack **stack)
>  {
>  	struct attr_stack *info;
> @@ -917,7 +931,7 @@ static void prepare_attr_stack(const char *path, int dirlen,
>  	 * .gitattributes in deeper directories to shallower ones,
>  	 * and finally use the built-in set as the default.
>  	 */
> -	bootstrap_attr_stack(stack);
> +	bootstrap_attr_stack(istate, stack);
>  
>  	/*
>  	 * Pop the "info" one that is always at the top of the stack.
> @@ -973,7 +987,7 @@ static void prepare_attr_stack(const char *path, int dirlen,
>  		strbuf_add(&pathbuf, path + pathbuf.len, (len - pathbuf.len));
>  		strbuf_addf(&pathbuf, "/%s", GITATTRIBUTES_FILE);
>  
> -		next = read_attr(pathbuf.buf, 0);
> +		next = read_attr(istate, pathbuf.buf, 0);
>  
>  		/* reset the pathbuf to not include "/.gitattributes" */
>  		strbuf_setlen(&pathbuf, len);
> @@ -1095,7 +1109,9 @@ static void determine_macros(struct all_attrs_item *all_attrs,
>   * If check->check_nr is non-zero, only attributes in check[] are collected.
>   * Otherwise all attributes are collected.
>   */
> -static void collect_some_attrs(const char *path, struct attr_check *check)
> +static void collect_some_attrs(const struct index_state *istate,
> +			       const char *path,
> +			       struct attr_check *check)
>  {
>  	int i, pathlen, rem, dirlen;
>  	const char *cp, *last_slash = NULL;
> @@ -1114,7 +1130,7 @@ static void collect_some_attrs(const char *path, struct attr_check *check)
>  		dirlen = 0;
>  	}
>  
> -	prepare_attr_stack(path, dirlen, &check->stack);
> +	prepare_attr_stack(istate, path, dirlen, &check->stack);
>  	all_attrs_init(&g_attr_hashmap, check);
>  	determine_macros(check->all_attrs, check->stack);
>  
> @@ -1136,11 +1152,13 @@ static void collect_some_attrs(const char *path, struct attr_check *check)
>  	fill(path, pathlen, basename_offset, check->stack, check->all_attrs, rem);
>  }
>  
> -int git_check_attr(const char *path, struct attr_check *check)
> +int git_check_attr(const struct index_state *istate,
> +		   const char *path,
> +		   struct attr_check *check)
>  {
>  	int i;
>  
> -	collect_some_attrs(path, check);
> +	collect_some_attrs(istate, path, check);
>  
>  	for (i = 0; i < check->nr; i++) {
>  		size_t n = check->items[i].attr->attr_nr;
> @@ -1153,12 +1171,13 @@ int git_check_attr(const char *path, struct attr_check *check)
>  	return 0;
>  }
>  
> -void git_all_attrs(const char *path, struct attr_check *check)
> +void git_all_attrs(const struct index_state *istate,
> +		   const char *path, struct attr_check *check)
>  {
>  	int i;
>  
>  	attr_check_reset(check);
> -	collect_some_attrs(path, check);
> +	collect_some_attrs(istate, path, check);
>  
>  	for (i = 0; i < check->all_attrs_nr; i++) {
>  		const char *name = check->all_attrs[i].attr->name;
> diff --git a/attr.h b/attr.h
> index 46340010bb..3daca3c0cb 100644
> --- a/attr.h
> +++ b/attr.h
> @@ -1,6 +1,8 @@
>  #ifndef ATTR_H
>  #define ATTR_H
>  
> +struct index_state;
> +
>  /* An attribute is a pointer to this opaque structure */
>  struct git_attr;
>  
> @@ -60,13 +62,15 @@ void attr_check_free(struct attr_check *check);
>   */
>  const char *git_attr_name(const struct git_attr *);
>  
> -int git_check_attr(const char *path, struct attr_check *check);
> +int git_check_attr(const struct index_state *istate,
> +		   const char *path, struct attr_check *check);
>  
>  /*
>   * Retrieve all attributes that apply to the specified path.
>   * check holds the attributes and their values.
>   */
> -void git_all_attrs(const char *path, struct attr_check *check);
> +void git_all_attrs(const struct index_state *istate,
> +		   const char *path, struct attr_check *check);
>  
>  enum git_attr_direction {
>  	GIT_ATTR_CHECKIN,
> @@ -74,7 +78,7 @@ enum git_attr_direction {
>  	GIT_ATTR_INDEX
>  };
>  void git_attr_set_direction(enum git_attr_direction new_direction,
> -			    struct index_state *istate);
> +			    const struct index_state *istate);
>  
>  void attr_start(void);
>  
> diff --git a/builtin/check-attr.c b/builtin/check-attr.c
> index 91444dc044..f7b59993d3 100644
> --- a/builtin/check-attr.c
> +++ b/builtin/check-attr.c
> @@ -63,9 +63,9 @@ static void check_attr(const char *prefix,
>  		prefix_path(prefix, prefix ? strlen(prefix) : 0, file);
>  
>  	if (collect_all) {
> -		git_all_attrs(full_path, check);
> +		git_all_attrs(&the_index, full_path, check);
>  	} else {
> -		if (git_check_attr(full_path, check))
> +		if (git_check_attr(&the_index, full_path, check))
>  			die("git_check_attr died");
>  	}
>  	output_attr(check, file);
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 4391504a91..3ff6da441f 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -945,7 +945,7 @@ static int no_try_delta(const char *path)
>  
>  	if (!check)
>  		check = attr_check_initl("delta", NULL);
> -	if (git_check_attr(path, check))
> +	if (git_check_attr(&the_index, path, check))
>  		return 0;
>  	if (ATTR_FALSE(check->items[0].value))
>  		return 1;
> diff --git a/convert.c b/convert.c
> index 7907efd16f..1935bde929 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -1303,7 +1303,7 @@ static void convert_attrs(struct conv_attrs *ca, const char *path)
>  		git_config(read_convert_config, NULL);
>  	}
>  
> -	if (!git_check_attr(path, check)) {
> +	if (!git_check_attr(&the_index, path, check)) {
>  		struct attr_check_item *ccheck = check->items;
>  		ca->crlf_action = git_path_check_crlf(ccheck + 4);
>  		if (ca->crlf_action == CRLF_UNDEFINED)
> diff --git a/dir.c b/dir.c
> index 21e6f2520a..29fbbd48c8 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -281,7 +281,7 @@ static int match_attrs(const char *name, int namelen,
>  {
>  	int i;
>  
> -	git_check_attr(name, item->attr_check);
> +	git_check_attr(&the_index, name, item->attr_check);
>  	for (i = 0; i < item->attr_match_nr; i++) {
>  		const char *value;
>  		int matched;
> diff --git a/ll-merge.c b/ll-merge.c
> index a6ad2ec12d..0e2800f7bb 100644
> --- a/ll-merge.c
> +++ b/ll-merge.c
> @@ -371,7 +371,7 @@ int ll_merge(mmbuffer_t *result_buf,
>  	if (!check)
>  		check = attr_check_initl("merge", "conflict-marker-size", NULL);
>  
> -	if (!git_check_attr(path, check)) {
> +	if (!git_check_attr(&the_index, path, check)) {
>  		ll_driver_name = check->items[0].value;
>  		if (check->items[1].value) {
>  			marker_size = atoi(check->items[1].value);
> @@ -398,7 +398,7 @@ int ll_merge_marker_size(const char *path)
>  
>  	if (!check)
>  		check = attr_check_initl("conflict-marker-size", NULL);
> -	if (!git_check_attr(path, check) && check->items[0].value) {
> +	if (!git_check_attr(&the_index, path, check) && check->items[0].value) {
>  		marker_size = atoi(check->items[0].value);
>  		if (marker_size <= 0)
>  			marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
> diff --git a/userdiff.c b/userdiff.c
> index 36af25e7f9..f3f4be579c 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -278,7 +278,7 @@ struct userdiff_driver *userdiff_find_by_path(const char *path)
>  		check = attr_check_initl("diff", NULL);
>  	if (!path)
>  		return NULL;
> -	if (git_check_attr(path, check))
> +	if (git_check_attr(&the_index, path, check))
>  		return NULL;
>  
>  	if (ATTR_TRUE(check->items[0].value))
> diff --git a/ws.c b/ws.c
> index a07caedd5a..5b67b426e7 100644
> --- a/ws.c
> +++ b/ws.c
> @@ -78,7 +78,7 @@ unsigned whitespace_rule(const char *pathname)
>  	if (!attr_whitespace_rule)
>  		attr_whitespace_rule = attr_check_initl("whitespace", NULL);
>  
> -	if (!git_check_attr(pathname, attr_whitespace_rule)) {
> +	if (!git_check_attr(&the_index, pathname, attr_whitespace_rule)) {
>  		const char *value;
>  
>  		value = attr_whitespace_rule->items[0].value;
> -- 
> 2.18.0.1004.g6639190530
> 

-- 
Brandon Williams
