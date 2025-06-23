Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600E6248F7E
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 19:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750707815; cv=none; b=UMqeh/YQhBecpN6P+/i6aCPjFuKcoDzpHVnq3c3zcDVRlfB9cl+AmRxhakf7Y1BejIcU/3E95FBxro02nyRjbujPSTOCJhoMlbwMZFvbD5OAGXZw4v+WyS//58SFNjsPwvX6qzfOulELi7yReIu+ZMDZQtFDWhsuwSg8iazCD1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750707815; c=relaxed/simple;
	bh=c9gqOpxcSDm3CD3QZ4H7SDwCAzXjxAjpf+Wnv/bsjaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=daT6DKvNSM66ozgPSNlSwiLYr+QANVEzHYr4E+M/GZZlLWNrYlgpxSvixY8t3MmhqxFF6txPEIUuPsCyXdqwhfRiWQ6t0swUuJkYNVYb1r1edlInii+d+zu4An+2QBdt/sQX1x2NeTmK4n1H6TfE3BPZcGtKYMlm90IDHc8A4VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TaS0N7tj; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TaS0N7tj"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-735a6faec9eso3132018a34.3
        for <git@vger.kernel.org>; Mon, 23 Jun 2025 12:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750707811; x=1751312611; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8+6Mnr6mHrKrA+bfkpsJ8HrxvN/21x82SMFJf5FOhqM=;
        b=TaS0N7tjxI1E5cObEcx5Zj74k81/dwMJIjz0QtQU8jHp+ltuFbuVXcpHiUFORA8HNL
         2VlBzM1WtHErtp9uJ+KtvadKwbu4Ile5HsbrmGHcA3ToE3JMkjpCR5FV9igy7WrNI0sp
         QWbXKbm6SglubD8mXg91SgSOH/fkKbAvOGTzoAvH4loJpcPlQa5Gq1s7D7wmkpvieBfA
         qV7gJxxrEnzea5mQUiXWi/Ob3A7yM6lNDAd5gnezJX11czjEVw1d0QyT901Lbz7hgX2K
         QZRhhh2yAVADxbXrDEKFBOjI3XqPqjza/+UtW+o7RZryLN6Mw4O7XBryYK80Jb6CFSko
         WCbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750707811; x=1751312611;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+6Mnr6mHrKrA+bfkpsJ8HrxvN/21x82SMFJf5FOhqM=;
        b=fUBbYceTStwvM1lvqrEY+Q85ZLP+7ebm2m0posfLsGE+7/+/8Qy3D/lbk73c45j5XZ
         F2Otviyzn9GpBbM+htEcGK/FxqCGauO8s9tN9aUccBaDJpKefY7AzVyRAzBqBDZI7Zbr
         iPvYEmvmZ2yc9+leRw82a6V4eUBhqckza2b/Tdq2JMRI1SKPfz98/SAc3h9cEjgT4Iq9
         stkzmAcbRd9H0P12LFXY4N86koXv9QU6KLvU+AsQO0Y3bG1cwYmdoLCETqMFKDeptewi
         xfmwvIYkIRFbYK1RH6dW9EbW5oSmjIAe3GSFjPbO7BX+ybCKPjxe6kHtRY+VoF+9hcJs
         hMKw==
X-Gm-Message-State: AOJu0Yx6yTDnx6Sm73pnAsBAH9ntRVEyA0DgEvn4mRpSmJPiGNG0NxKY
	OJ/8tfAmDHeacmocZ/FiRt87ZBsEexzrDWi67FHh+ifKaEaGEeVag/6EyLych10F
X-Gm-Gg: ASbGncvCEVFJnJ6EFw1at8MGaxVKV9Z3q8qlrzR+pkNgS9ogdlJE+Yc13t5lrBb97tq
	5TpRwZt2u40ZvUBQGNpWmS7g3XbsshgEpdvkVv333nyyTJbC/FDrKWiNmkbrJE/CDc/jQ3jkDYA
	arTPllvGb8GKwZzwxiCyja/QJhDy073tEA6ZAVuafwK/B508r2V9EFQaryhLwqvt9Lw+ubGs8PI
	lBHJLypdqA6iq1H5w67yQhxoeKipOdWclLNazfulpHIhKQykOjNidl9MWLWAsd8djZLKGG49fKq
	bboGqosZLEMZKIc6SkqBxO7Ci8s3tuLoFJs/M+d0nCGkEmAh9WXZ1oc=
X-Google-Smtp-Source: AGHT+IHgn7kH16kdXMWMP89ZMhJQq8rwMJlnKItasPGok5OXBosnN0YZc9AkhO45PxHgImCGyeT77g==
X-Received: by 2002:a05:6830:43a8:b0:72b:823c:8f66 with SMTP id 46e09a7af769-73a91c75512mr10076842a34.9.1750707811075;
        Mon, 23 Jun 2025 12:43:31 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-73a9cb5d071sm1238110a34.31.2025.06.23.12.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 12:43:30 -0700 (PDT)
Date: Mon, 23 Jun 2025 14:38:15 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4 1/5] promisor-remote: refactor to get rid of 'struct
 strvec'
Message-ID: <2z3uanklsfnrgxmiqjt2innv2diownbpwtgcj67bi7udwjdqpg@ackusinuz7c6>
References: <20250519141259.3061550-1-christian.couder@gmail.com>
 <20250611134506.2975856-1-christian.couder@gmail.com>
 <20250611134506.2975856-2-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611134506.2975856-2-christian.couder@gmail.com>

On 25/06/11 03:45PM, Christian Couder wrote:
> In a following commit, we will use the new 'promisor-remote' protocol
> capability introduced by d460267613 (Add 'promisor-remote' capability
> to protocol v2, 2025-02-18) to pass and process more information
> about promisor remotes than just their name and url.
> 
> For that purpose, we will need to store information about other
> fields, especially information that might or might not be available
> for different promisor remotes. Unfortunately using 'struct strvec',
> as we currently do, to store information about the promisor remotes
> with one 'struct strvec' for each field like "name" or "url" does not
> scale easily in that case.
> 
> Let's refactor this and introduce a new 'struct promisor_info'.
> 
> It will only store promisor remote information in its members. For now
> it has only a 'name' member for the promisor remote name and an 'url'
> member for its URL. We will use use a 'struct string_list' to store

s/use use/use/

> the instances of 'struct promisor_info'. For each 'item' in the
> string_list, 'item->string' will point to the promisor remote name and
> 'item->util' will point to the corresponding 'struct promisor_info'
> instance.
> 
> Explicit members are used within 'struct promisor_info' for type
> safety and clarity regarding the specific information being handled,
> rather than a generic key-value store. We want to specify and document
> each field and its content, so adding new members to the struct as
> more fields are supported is fine.
> 
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  promisor-remote.c | 111 +++++++++++++++++++++++++++++-----------------
>  1 file changed, 70 insertions(+), 41 deletions(-)
> 
> diff --git a/promisor-remote.c b/promisor-remote.c
> index 9d058586df..90a063ea53 100644
> --- a/promisor-remote.c
> +++ b/promisor-remote.c
> @@ -314,9 +314,35 @@ static int allow_unsanitized(char ch)
>  	return ch > 32 && ch < 127;
>  }
>  
> -static void promisor_info_vecs(struct repository *repo,
> -			       struct strvec *names,
> -			       struct strvec *urls)
> +/*
> + * Struct for promisor remotes involved in the "promisor-remote"
> + * protocol capability.
> + *
> + * Except for "name", each <member> in this struct and its <value>
> + * should correspond (either on the client side or on the server side)
> + * to a "remote.<name>.<member>" config variable set to <value> where
> + * "<name>" is a promisor remote name.
> + */
> +struct promisor_info {
> +	const char *name;
> +	const char *url;
> +};

Ok so now all promisor info for a given remote is stored in its own
struct. This will enable easier extension in the future to add
additional fields.

> +
> +static void promisor_info_list_clear(struct string_list *list)
> +{
> +	for (size_t i = 0; i < list->nr; i++) {
> +		struct promisor_info *p = list->items[i].util;
> +		free((char *)p->name);
> +		free((char *)p->url);
> +	}
> +	string_list_clear(list, 1);
> +}
> +
> +/*
> + * Populate 'list' with promisor remote information from the config.
> + * The 'util' pointer of each list item will hold a 'struct promisor_info'.
> + */
> +static void promisor_config_info_list(struct repository *repo, struct string_list *list)
>  {
>  	struct promisor_remote *r;
>  
> @@ -328,8 +354,14 @@ static void promisor_info_vecs(struct repository *repo,
>  
>  		/* Only add remotes with a non empty URL */
>  		if (!git_config_get_string_tmp(url_key, &url) && *url) {
> -			strvec_push(names, r->name);
> -			strvec_push(urls, url);
> +			struct promisor_info *new_info = xcalloc(1, sizeof(*new_info));
> +			struct string_list_item *item;
> +
> +			new_info->name = xstrdup(r->name);
> +			new_info->url = xstrdup(url);
> +
> +			item = string_list_append(list, new_info->name);
> +			item->util = new_info;
>  		}

In this version, each remote is now stored as a member of a `struct
string_list` instead of a custom collection type specific to promisor
remote info. Nice

>  		free(url_key);
> @@ -340,47 +372,36 @@ char *promisor_remote_info(struct repository *repo)
>  {
>  	struct strbuf sb = STRBUF_INIT;
>  	int advertise_promisors = 0;
> -	struct strvec names = STRVEC_INIT;
> -	struct strvec urls = STRVEC_INIT;
> +	struct string_list config_info = STRING_LIST_INIT_NODUP;

nit: Ok in this context, "config_info" is specific to the list of
promisor_info not just generic git configuration. Something like
"promisor_info_list" would be a bit more explicit, but I don't feel
super strongly.

> +	struct string_list_item *item;
>  
>  	git_config_get_bool("promisor.advertise", &advertise_promisors);
>  
>  	if (!advertise_promisors)
>  		return NULL;
>  
> -	promisor_info_vecs(repo, &names, &urls);
> +	promisor_config_info_list(repo, &config_info);
>  
> -	if (!names.nr)
> +	if (!config_info.nr)
>  		return NULL;
>  
> -	for (size_t i = 0; i < names.nr; i++) {
> -		if (i)
> +	for_each_string_list_item(item, &config_info) {
> +		struct promisor_info *p = item->util;
> +
> +		if (item != config_info.items)
>  			strbuf_addch(&sb, ';');

Out of curiousity, is it invalid for the trailing promisor remote entry
to end with a ';'? It would be simpler if each entry could just end with
a semi-colon.

> +
>  		strbuf_addstr(&sb, "name=");
> -		strbuf_addstr_urlencode(&sb, names.v[i], allow_unsanitized);
> +		strbuf_addstr_urlencode(&sb, p->name, allow_unsanitized);
>  		strbuf_addstr(&sb, ",url=");
> -		strbuf_addstr_urlencode(&sb, urls.v[i], allow_unsanitized);
> +		strbuf_addstr_urlencode(&sb, p->url, allow_unsanitized);
>  	}
>  
> -	strvec_clear(&names);
> -	strvec_clear(&urls);
> +	promisor_info_list_clear(&config_info);
>  
>  	return strbuf_detach(&sb, NULL);
>  }
>  
> -/*
> - * Find first index of 'nicks' where there is 'nick'. 'nick' is
> - * compared case sensitively to the strings in 'nicks'. If not found
> - * 'nicks->nr' is returned.
> - */
> -static size_t remote_nick_find(struct strvec *nicks, const char *nick)
> -{
> -	for (size_t i = 0; i < nicks->nr; i++)
> -		if (!strcmp(nicks->v[i], nick))
> -			return i;
> -	return nicks->nr;
> -}
> -
>  enum accept_promisor {
>  	ACCEPT_NONE = 0,
>  	ACCEPT_KNOWN_URL,
> @@ -390,19 +411,23 @@ enum accept_promisor {
>  
>  static int should_accept_remote(enum accept_promisor accept,
>  				const char *remote_name, const char *remote_url,
> -				struct strvec *names, struct strvec *urls)
> +				struct string_list *config_info)
>  {
> -	size_t i;
> +	struct promisor_info *p;
> +	struct string_list_item *item;
>  
>  	if (accept == ACCEPT_ALL)
>  		return 1;
>  
> -	i = remote_nick_find(names, remote_name);
> +	/* Get config info for that promisor remote */
> +	item = string_list_lookup(config_info, remote_name);
>  
> -	if (i >= names->nr)
> +	if (!item)
>  		/* We don't know about that remote */
>  		return 0;
>  
> +	p = item->util;
> +
>  	if (accept == ACCEPT_KNOWN_NAME)
>  		return 1;
>  
> @@ -414,11 +439,15 @@ static int should_accept_remote(enum accept_promisor accept,
>  		return 0;
>  	}
>  
> -	if (!strcmp(urls->v[i], remote_url))
> +	if (!p->url)
> +		BUG("bad config_info (invalid URL) for remote '%s'",
> +		    remote_name);

Ok just to clarify, it is invalid for a promisor remote to not have a
URL specified. If so, it might be better to say "empty URL" or something
along those lines.

> +
> +	if (!strcmp(p->url, remote_url))
>  		return 1;
>  
>  	warning(_("known remote named '%s' but with URL '%s' instead of '%s'"),
> -		remote_name, urls->v[i], remote_url);
> +		remote_name, p->url, remote_url);
>  
>  	return 0;
>  }
> @@ -430,8 +459,7 @@ static void filter_promisor_remote(struct repository *repo,
>  	struct strbuf **remotes;
>  	const char *accept_str;
>  	enum accept_promisor accept = ACCEPT_NONE;
> -	struct strvec names = STRVEC_INIT;
> -	struct strvec urls = STRVEC_INIT;
> +	struct string_list config_info = STRING_LIST_INIT_NODUP;
>  
>  	if (!git_config_get_string_tmp("promisor.acceptfromserver", &accept_str)) {
>  		if (!*accept_str || !strcasecmp("None", accept_str))
> @@ -450,8 +478,10 @@ static void filter_promisor_remote(struct repository *repo,
>  	if (accept == ACCEPT_NONE)
>  		return;
>  
> -	if (accept != ACCEPT_ALL)
> -		promisor_info_vecs(repo, &names, &urls);
> +	if (accept != ACCEPT_ALL) {
> +		promisor_config_info_list(repo, &config_info);
> +		string_list_sort(&config_info);
> +	}
>  
>  	/* Parse remote info received */
>  
> @@ -482,7 +512,7 @@ static void filter_promisor_remote(struct repository *repo,
>  		if (remote_url)
>  			decoded_url = url_percent_decode(remote_url);
>  
> -		if (decoded_name && should_accept_remote(accept, decoded_name, decoded_url, &names, &urls))
> +		if (decoded_name && should_accept_remote(accept, decoded_name, decoded_url, &config_info))
>  			strvec_push(accepted, decoded_name);
>  
>  		strbuf_list_free(elems);
> @@ -490,8 +520,7 @@ static void filter_promisor_remote(struct repository *repo,
>  		free(decoded_url);
>  	}
>  
> -	strvec_clear(&names);
> -	strvec_clear(&urls);
> +	promisor_info_list_clear(&config_info);
>  	strbuf_list_free(remotes);
>  }
>  
> -- 
> 2.50.0.rc2.5.ge8efe62b7f
> 
