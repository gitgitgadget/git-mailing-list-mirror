Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3FA1C8633
	for <git@vger.kernel.org>; Wed, 21 May 2025 20:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747859788; cv=none; b=aq6HCJ9oi+vCrSy3L92+AY4KBDPOpLXMhpdbplf1ksQR9jr2I0QOzfoMOV2TXYyzi9qNC+EVPii+qA9LfQ44B6N4YEoeBDABEDV/VDvQc5kEejtnJeIgVydEWpDUE9ADLFLOZMOyyHBNPvTgMOwyhky88rLMpUotHDAicynfogI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747859788; c=relaxed/simple;
	bh=faeP3a8IlzqvKkR3rdrJeLP/Tph9S1HwUDVUKOzoIYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A7IR+fruB98mmvS7xuoUCTxzh9O5+YInbSBCRdeT0obTsRzQv325zlq9ylqI05B9jeA0w51vbstVqd8BGlEPb8zuPYLdoWdnr0vYng8K8ZSW9YaErwFmGU16wVoY4w2roXVkixZVKeVPn80rBgi2HwWHNMsIaQkHWxQHzlL8wdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LPvHoBw5; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LPvHoBw5"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-40337dd3847so4917989b6e.0
        for <git@vger.kernel.org>; Wed, 21 May 2025 13:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747859785; x=1748464585; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZgC3sgk4ozaFZswzJQmC8Ek9dGt1fVlKvScU7E5O/+M=;
        b=LPvHoBw5Q4I3DusOYTD2L2PFwoaglNzxOjiQWOK8/vNSZTYLxFUuRHwUvp2/cl1RqY
         uFO/VDWoxwy0Gzb0nZ7VLf0WfjXAINSPxTgOSVktyFYKKen1xxHP66ZlFXBCaZ5PhQRM
         Z4AX+hQDPEfsC1YIdg7ptfEJX9xDmR9dA72/AtDgg4ND6NYiq/mnevco6axaWpHOGuAw
         55P9kIwJd0MiyOYXxhZAIXMptZd/XMkHr78B1NOQFEeNZd+IRGLyCR4CJOenBxWsKZGQ
         RBCjuJow+5K2xYU60yXQcbNyGPiZYcDUDUPenKa+d2JVNzjlJQvoWqxE0Hzq0nUJKjbn
         CRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747859785; x=1748464585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZgC3sgk4ozaFZswzJQmC8Ek9dGt1fVlKvScU7E5O/+M=;
        b=clwfImE/yO2w8eiZqqywQVkDSCmhjPg61BJX2gyRuzM0wXi6GJJcIXxFYnFwx2Vmhc
         9Gmj3XJk2Zj7PaN/qFuAJsLlvcpb8ZtzYBG+f9f5Ih6pGPvAqyv205pm9kca0SXbGB1J
         0dxvh6NX0XbLpQRCaYvCzFePUHQwJN0ABUdF8OIGaCWB/7etF23lnU6yZHHmOd+4huQc
         mTCYl2LzOyQ5tBhc4zGyHwzUO7dvSidoD3tlMaHFwfq652irFWuc2hwBggBhZKE2smHS
         4nS8ENOLV0gfqo953h/wiBb5Pwr5mGXv6DPpixoN0hXTMjGf0oPNfIAh5i/CszNl9CwV
         ffmw==
X-Gm-Message-State: AOJu0YxxlNurldTUWrjJG5ZObGk8HRYmabKM8uBvxUoZXmz0vzVG4dF0
	3YrODENB2UarLkdbxzkkhGpeIIZiGMiNwNR2m6uBP1WmWUKebJ0uT6Pw2XtEFxjP52w=
X-Gm-Gg: ASbGncuZC7oKp3ritUpqJ6U6j9z/3W6QzyxwM30/uSy3xNNeSbSz/jXBjXrYMrVHyl2
	uzakEbt3zejbQlYpoH76NtvU+tNOm2UeJBVe0Gchta60e4LApkFnCoJNfXGTPDCf/YnJwV0+GVC
	PohcP/e2EP/DxBXSjQkO8FkKM9hgLje54St4E91VqlSVCsNVDJSMKd0k7RbU5fFz+HLwgOEG7NB
	91WZB6Q+d52tKj/U3v8d9JG+JF0av/R4DJM1tv3zIlt/7a0T7yEam9i7r0JEQLQ91k1B7C05WzB
	BKj/up5+xdOwVF+K8nJWcabSugs+LCV1ycg+26+JI1yl
X-Google-Smtp-Source: AGHT+IHT/Pd+GPzNENdYbwAcxAVYgRRtnvv3f79UnNqWfJRav6NVeJA4C9Nclv1SZhoGWqeZqleDJw==
X-Received: by 2002:a05:6808:6c82:b0:3f8:91d1:d950 with SMTP id 5614622812f47-404da7d8ff7mr12411841b6e.38.1747859785070;
        Wed, 21 May 2025 13:36:25 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-404d98cef4esm2252635b6e.45.2025.05.21.13.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 13:36:24 -0700 (PDT)
Date: Wed, 21 May 2025 15:31:45 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 2/5] promisor-remote: allow a server to advertise more
 fields
Message-ID: <agvpcmvdxxpfwr34mw34dvatqr3rlc72zntgbrhlzynvn4h5rh@5mdgt4mdocnx>
References: <20250429145243.992252-1-christian.couder@gmail.com>
 <20250519141259.3061550-1-christian.couder@gmail.com>
 <20250519141259.3061550-3-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519141259.3061550-3-christian.couder@gmail.com>

On 25/05/19 04:12PM, Christian Couder wrote:
> For now the "promisor-remote" protocol capability can only pass "name"
> and "url" information from a server to a client in the form
> "name=<remote_name>,url=<remote_url>".
> 
> Let's make it possible to pass more information by introducing a new
> "promisor.sendFields" configuration variable. This variable should
> contain a comma or space separated list of fields that will be looked
> up in the configuration of the remote on the server to find the values
> that will be passed to the client.
> 
> Only a set of predefined fields are allowed. The only fields in this
> set are "partialCloneFilter" and "token". The "partialCloneFilter"
> field specifies the filter definition used by the promisor remote,
> and the "token" field can provide an authentication credential for
> accessing it.
> 
> For example if "promisor.sendFields" is set to "partialCloneFilter",
> and the server has the "remote.<name>.partialCloneFilter" config
> variable set to a value for a remote, then that value will be passed
> in the form "partialCloneFilter=<value>" after the "name" and "url"
> fields.
> 
> A following commit will allow the client to use the information to
> decide if it accepts the remote or not. For now the client doesn't do
> anything with the additional information it receives.
> 
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  Documentation/config/promisor.adoc    |  18 ++++
>  Documentation/gitprotocol-v2.adoc     |  59 ++++++++----
>  promisor-remote.c                     | 128 ++++++++++++++++++++++++--
>  t/t5710-promisor-remote-capability.sh |  32 +++++++
>  4 files changed, 212 insertions(+), 25 deletions(-)
> 
> diff --git a/Documentation/config/promisor.adoc b/Documentation/config/promisor.adoc
> index 2638b01f83..71311b70c8 100644
> --- a/Documentation/config/promisor.adoc
> +++ b/Documentation/config/promisor.adoc
> @@ -9,6 +9,24 @@ promisor.advertise::
>  	"false", which means the "promisor-remote" capability is not
>  	advertised.
>  
> +promisor.sendFields::
> +	A comma or space separated list of additional remote related
> +	fields that a server will send while advertising its promisor
> +	remotes using the "promisor-remote" capability, see
> +	linkgit:gitprotocol-v2[5]. Currently, only the
> +	"partialCloneFilter" and "token" fields are supported. The
> +	"partialCloneFilter" field contains the partial clone filter
> +	used for the remote, and the "token" field contains an
> +	authentication token for the remote.
> ++
> +When a field is part of this list and a corresponding
> +"remote.foo.<field>" config variable is set on the server to a
> +non-empty value, then the field and its value will be sent when
> +advertising the promisor remote "foo". This list has no effect unless
> +the "promisor.advertise" config variable is set to "true", and the
> +"name" and "url" fields are always advertised regardless of this
> +setting.
> +
>  promisor.acceptFromServer::
>  	If set to "all", a client will accept all the promisor remotes
>  	a server might advertise using the "promisor-remote"
> diff --git a/Documentation/gitprotocol-v2.adoc b/Documentation/gitprotocol-v2.adoc
> index 5598c93e67..3c12c158fd 100644
> --- a/Documentation/gitprotocol-v2.adoc
> +++ b/Documentation/gitprotocol-v2.adoc
> @@ -785,33 +785,59 @@ retrieving the header from a bundle at the indicated URI, and thus
>  save themselves and the server(s) the request(s) needed to inspect the
>  headers of that bundle or bundles.
>  
> -promisor-remote=<pr-infos>
> +promisor-remote=<pr-info>
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~
>  
>  The server may advertise some promisor remotes it is using or knows
>  about to a client which may want to use them as its promisor remotes,
> -instead of this repository. In this case <pr-infos> should be of the
> +instead of this repository. In this case <pr-info> should be of the
>  form:
>  
> -	pr-infos = pr-info | pr-infos ";" pr-info
> +	pr-info = pr-fields | pr-info ";" pr-info
>  
> -	pr-info = "name=" pr-name | "name=" pr-name "," "url=" pr-url
> +	pr-fields = field-name "=" field-value | pr-fields "," pr-fields
>  
> -where `pr-name` is the urlencoded name of a promisor remote, and
> -`pr-url` the urlencoded URL of that promisor remote.
> +where all the `field-name` and `field-value` in a given `pr-fields`
> +are field names and values related to a single promisor remote.
>  
> -In this case, if the client decides to use one or more promisor
> -remotes the server advertised, it can reply with
> -"promisor-remote=<pr-names>" where <pr-names> should be of the form:
> +The server MUST advertise at least the "name" and "url" field names
> +along with the associated field values, which are the name of a valid
> +remote and its URL, in each `pr-fields`. The "name" and "url" fields
> +MUST appear first in each pr-fields, in that order.
>  
> -	pr-names = pr-name | pr-names ";" pr-name
> +After these mandatory fields, the server MAY advertise the following
> +optional fields in any order:
> +
> +- "partialCloneFilter": The filter specification used by the remote.
> +Clients can use this to determine if the remote's filtering strategy
> +is compatible with their needs (e.g., checking if both use "blob:none").
> +It corresponds to the "remote.<name>.partialCloneFilter" config setting.
> +
> +- "token": An authentication token that clients can use when
> +connecting to the remote. It corresponds to the "remote.<name>.token"
> +config setting.
> +
> +No other fields are defined by the protocol at this time. Clients MUST
> +ignore fields they don't recognize to allow for future protocol
> +extensions.
> +
> +For now, the client can only use information transmitted through these
> +fields to decide if it accepts the advertised promisor remote. In the
> +future that information might be used for other purposes though.
> +
> +Field values MUST be urlencoded.
> +
> +If the client decides to use one or more promisor remotes the server
> +advertised, it can reply with "promisor-remote=<pr-names>" where
> +<pr-names> should be of the form:
> +
> +	pr-names = pr-name | pr-names ";" pr-names
>  
>  where `pr-name` is the urlencoded name of a promisor remote the server
>  advertised and the client accepts.
>  
> -Note that, everywhere in this document, `pr-name` MUST be a valid
> -remote name, and the ';' and ',' characters MUST be encoded if they
> -appear in `pr-name` or `pr-url`.
> +Note that, everywhere in this document, the ';' and ',' characters
> +MUST be encoded if they appear in `pr-name` or `field-value`.
>  
>  If the server doesn't know any promisor remote that could be good for
>  a client to use, or prefers a client not to use any promisor remote it
> @@ -822,9 +848,10 @@ In this case, or if the client doesn't want to use any promisor remote
>  the server advertised, the client shouldn't advertise the
>  "promisor-remote" capability at all in its reply.
>  
> -The "promisor.advertise" and "promisor.acceptFromServer" configuration
> -options can be used on the server and client side to control what they
> -advertise or accept respectively. See the documentation of these
> +On the server side, the "promisor.advertise" and "promisor.sendFields"
> +configuration options can be used to control what it advertises. On
> +the client side, the "promisor.acceptFromServer" configuration option
> +can be used to control what it accepts. See the documentation of these
>  configuration options for more information.
>  
>  Note that in the future it would be nice if the "promisor-remote"
> diff --git a/promisor-remote.c b/promisor-remote.c
> index 94e87f2f48..cde4079d8c 100644
> --- a/promisor-remote.c
> +++ b/promisor-remote.c
> @@ -314,6 +314,73 @@ static int allow_unsanitized(char ch)
>  	return ch > 32 && ch < 127;
>  }
>  
> +static const char promisor_field_filter[] = "partialCloneFilter";
> +static const char promisor_field_token[] = "token";
> +
> +/*
> + * List of optional field names that can be used in the
> + * "promisor-remote" protocol capability (others must be
> + * ignored). Each field should correspond to a configurable property
> + * of a remote that can be relevant for the client.
> + */
> +static const char *known_fields[] = {
> +	promisor_field_filter, /* Filter used for partial clone */
> +	promisor_field_token,  /* Authentication token for the remote */
> +	NULL
> +};
> +
> +/*
> + * Check if 'field' is in the list of the known field names for the
> + * "promisor-remote" protocol capability.
> + */
> +static int is_known_field(const char *field)
> +{
> +	const char **p;
> +
> +	for (p = known_fields; *p; p++)
> +		if (!strcasecmp(*p, field))
> +			return 1;
> +	return 0;
> +}
> +
> +static int is_valid_field(struct string_list_item *item, void *cb_data)
> +{
> +	const char *field = item->string;
> +	const char *config_key = (const char *)cb_data;
> +
> +	if (!is_known_field(field)) {
> +		warning(_("unsupported field '%s' in '%s' config"), field, config_key);
> +		return 0;
> +	}
> +	return 1;
> +}

Ok, so if the server has an unknown sendField value configured, the
value is ignored by the server and a warning printed.

> +
> +static char *fields_from_config(struct string_list *fields_list, const char *config_key)
> +{
> +	char *fields = NULL;
> +
> +	if (!git_config_get_string(config_key, &fields) && *fields) {

We could use `repo_config_get_string()` here instead and wire the nearby
`struct repository`, but as the rest of the file is not doing so it's
not really a big deal.

> +		string_list_split_in_place(fields_list, fields, ", ", -1);
> +		filter_string_list(fields_list, 0, is_valid_field, (void *)config_key);
> +	}
> +
> +	return fields;
> +}
> +
> +static struct string_list *fields_sent(void)
> +{
> +	static struct string_list fields_list = STRING_LIST_INIT_NODUP;
> +	static int initialized = 0;
> +
> +	if (!initialized) {
> +		fields_list.cmp = strcasecmp;
> +		fields_from_config(&fields_list, "promisor.sendFields");
> +		initialized = 1;
> +	}
> +
> +	return &fields_list;
> +}

Are there scenarios where `fields_sent()` is getting invoked more than
once? My understanding is that this is invoked only when the capability
is being advertised. Regardless, I wonder if we really need the static
initialization here.

> +
>  /*
>   * Linked list for promisor remotes involved in the "promisor-remote"
>   * protocol capability.
> @@ -326,6 +393,8 @@ struct promisor_info {
>  	struct promisor_info *next;
>  	const char *name;
>  	const char *url;
> +	const char *filter;
> +	const char *token;
>  };
>  
>  static void promisor_info_list_free(struct promisor_info *p)
> @@ -336,12 +405,45 @@ static void promisor_info_list_free(struct promisor_info *p)
>  		next = p->next;
>  		free((char *)p->name);
>  		free((char *)p->url);
> +		free((char *)p->filter);
> +		free((char *)p->token);
>  		free(p);
>  	}
>  }
>  
> -/* Prepare a 'struct promisor_info' linked list with config information. */
> -static struct promisor_info *promisor_config_info_list(struct repository *repo)
> +static void set_one_field(struct promisor_info *p,
> +			  const char *field, const char *value)
> +{
> +	if (!strcasecmp(field, promisor_field_filter))
> +		p->filter = xstrdup(value);
> +	else if (!strcasecmp(field, promisor_field_token))
> +		p->token = xstrdup(value);
> +	else
> +		BUG("Invalid field '%s'", field);
> +}
> +
> +static void set_fields(struct promisor_info *p,
> +		       struct string_list *field_names)
> +{
> +	struct string_list_item *item;
> +
> +	for_each_string_list_item(item, field_names) {
> +		char *key = xstrfmt("remote.%s.%s", p->name, item->string);
> +		const char *val;
> +		if (!git_config_get_string_tmp(key, &val) && *val)
> +			set_one_field(p, item->string, val);
> +		free(key);
> +	}
> +}
> +
> +/*
> + * Prepare a 'struct promisor_info' linked list of promisor remotes
> + * with config information. Only members of that struct specified by
> + * the 'field_names' linked list are set (using values from the
> + * configuration).
> + */
> +static struct promisor_info *promisor_config_info_list(struct repository *repo,
> +						       struct string_list *field_names)
>  {
>  	struct promisor_info *infos = NULL;
>  	struct promisor_info **last_info = &infos;
> @@ -360,6 +462,9 @@ static struct promisor_info *promisor_config_info_list(struct repository *repo)
>  			new_info->name = xstrdup(r->name);
>  			new_info->url = xstrdup(url);
>  
> +			if (field_names)
> +				set_fields(new_info, field_names);
> +
>  			*last_info = new_info;
>  			last_info = &new_info->next;
>  		}
> @@ -382,7 +487,7 @@ char *promisor_remote_info(struct repository *repo)
>  	if (!advertise_promisors)
>  		return NULL;
>  
> -	config_info = promisor_config_info_list(repo);
> +	config_info = promisor_config_info_list(repo, fields_sent());
>  
>  	if (!config_info)
>  		return NULL;
> @@ -395,6 +500,15 @@ char *promisor_remote_info(struct repository *repo)
>  		strbuf_addstr_urlencode(&sb, p->name, allow_unsanitized);
>  		strbuf_addstr(&sb, ",url=");
>  		strbuf_addstr_urlencode(&sb, p->url, allow_unsanitized);
> +
> +		if (p->filter) {
> +			strbuf_addf(&sb, ",%s=", promisor_field_filter);
> +			strbuf_addstr_urlencode(&sb, p->filter, allow_unsanitized);
> +		}
> +		if (p->token) {
> +			strbuf_addf(&sb, ",%s=", promisor_field_token);
> +			strbuf_addstr_urlencode(&sb, p->token, allow_unsanitized);
> +		}
>  	}
>  
>  	promisor_info_list_free(config_info);
> @@ -489,7 +603,7 @@ static void filter_promisor_remote(struct repository *repo,
>  		return;
>  
>  	if (accept != ACCEPT_ALL)
> -		config_info = promisor_config_info_list(repo);
> +		config_info = promisor_config_info_list(repo, NULL);
>  
>  	/* Parse remote info received */
>  
> @@ -506,13 +620,9 @@ static void filter_promisor_remote(struct repository *repo,
>  		elems = strbuf_split(remotes[i], ',');
>  
>  		for (size_t j = 0; elems[j]; j++) {
> -			int res;
>  			strbuf_strip_suffix(elems[j], ",");
> -			res = skip_prefix(elems[j]->buf, "name=", &remote_name) ||
> +			if (!skip_prefix(elems[j]->buf, "name=", &remote_name))
>  				skip_prefix(elems[j]->buf, "url=", &remote_url);
> -			if (!res)
> -				warning(_("unknown element '%s' from remote info"),
> -					elems[j]->buf);
>  		}
>  
>  		if (remote_name)
> diff --git a/t/t5710-promisor-remote-capability.sh b/t/t5710-promisor-remote-capability.sh
> index cb061b1f35..27c32b2573 100755
> --- a/t/t5710-promisor-remote-capability.sh
> +++ b/t/t5710-promisor-remote-capability.sh
> @@ -295,6 +295,38 @@ test_expect_success "clone with 'KnownUrl' and empty url, so not advertised" '
>  	check_missing_objects server 1 "$oid"
>  '
>  
> +test_expect_success "clone with promisor.sendFields" '
> +	git -C server config promisor.advertise true &&
> +	test_when_finished "rm -rf client" &&
> +
> +	git -C server remote add otherLop "https://invalid.invalid"  &&
> +	git -C server config remote.otherLop.token "fooBar" &&
> +	git -C server config remote.otherLop.stuff "baz" &&
> +	git -C server config remote.otherLop.partialCloneFilter "blob:limit=10k" &&
> +	test_when_finished "git -C server remote remove otherLop" &&
> +	git -C server config promisor.sendFields "partialCloneFilter, token" &&

This configuration results in the unsupported field warning message
being printed. This is because of the SP following the comma resulting
in an empty value in the middle after the string split.

> +	test_when_finished "git -C server config unset promisor.sendFields" &&

I think we could use `test_config` which would automatically unset the
configuration after the test.

> +	test_when_finished "rm trace" &&
> +
> +	# Clone from server to create a client
> +	GIT_TRACE_PACKET="$(pwd)/trace" GIT_NO_LAZY_FETCH=0 git clone \
> +		-c remote.lop.promisor=true \
> +		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
> +		-c remote.lop.url="file://$(pwd)/lop" \
> +		-c promisor.acceptfromserver=All \
> +		--no-local --filter="blob:limit=5k" server client &&
> +
> +	# Check that fields are properly transmitted
> +	ENCODED_URL=$(echo "file://$(pwd)/lop" | sed -e "s/ /%20/g") &&
> +	PR1="name=lop,url=$ENCODED_URL,partialCloneFilter=blob:none" &&
> +	PR2="name=otherLop,url=https://invalid.invalid,partialCloneFilter=blob:limit=10k,token=fooBar" &&
> +	test_grep "clone< promisor-remote=$PR1;$PR2" trace &&
> +	test_grep "clone> promisor-remote=lop;otherLop" trace &&
> +
> +	# Check that the largest object is still missing on the server
> +	check_missing_objects server 1 "$oid"
> +'
> +
>  test_expect_success "clone with promisor.advertise set to 'true' but don't delete the client" '
>  	git -C server config promisor.advertise true &&
>  
> -- 
> 2.49.0.596.g707f6eb7a2.dirty
> 
> 
