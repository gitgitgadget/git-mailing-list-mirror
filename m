Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9467635C190
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 09:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771837603; cv=pass; b=swoQ/gBUJXivONb3e86pyma1Wom1un/RE1N27yhQj8a5n+1stXPk+h+dpSpP7XInc+TTuhnaSvqOuUvv3pnKjlI6qlkpxOCCjA8ag1ZZdnnoyow0A1/pQos4eY1g91KobFHur3ufcqLfYE68F8UqSQmTeqJTF/tKedcKc/7oDTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771837603; c=relaxed/simple;
	bh=Tg4FklpoT5tJ/m4/n6/FFLO/7I3Auob6wS9bdOMRl6k=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=RHJvj9OkvdOmUEYDw6UfEuE5/9VA4Kj+YZe6QFO5XAHRRDBYmcmT5allqHU9ikRfTLZed6B9+ro8/hA2rWvHIwGk4Ze/nRkzGSr0eHAqOYgMNv1/ovSQUTUY2ZsCASWr9HfwOU43G5eo6W8ljfNzanI1YlswROW0XRBpV7mdPEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S8LMaZAe; arc=pass smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8LMaZAe"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-5fc41f88ff1so953401137.2
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 01:06:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771837600; cv=none;
        d=google.com; s=arc-20240605;
        b=QvT5adPVD8NghqKpnFahkxeCXD36tdIln4X1rFwJVEXxM/nt2jAkOvOxhGuu/OjWEd
         2m+RrTP52HSG3blI+c7Lsul3+VxsjcKkPjnlEHoUmh1TcggAbMlxmdf7sYpIAknr5CWv
         PdFG2AQBo249Zh4n9IS3E07YretMpmaHlzgk1gifHxHXs0llaJBTkfmOx58jpnE52xmx
         60B0kVztMwN4EMy4n3wU89WqtSWtknL1PlW5wMEkKzWapHaQmB1lt17oXPlJI6kbLaNL
         xp0IwnzCLORrH7O7A7lkatdafuys/Y2TUeml/uWfwiLuZSRiKHbxdqmNagUcre8e9urM
         xZMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=Vf8OCkLcF925yHhQDRYccujsEGySF7mdTQjjKgoTi8A=;
        fh=+AdotoCj3nf9MYu725b5iQ8s/2BsiKyuDkgRoyPAnPc=;
        b=eRrXAXX4a/JeqC8aboVliBgHgLnlcxQgIsBz4gp/4jUlAc/9XKwS3r8gSd8s6fsPqI
         LaswRLgB1dDhDUsaDS5XyGklo5bzw/QHUAZ56lxGGb8CqbK5Wwcy0uTTzLfy7GIfMu7R
         14SXs7g3UtFonK3IcU6IoMaoZZrwVYyIVCV7GvNt0/qJo/KVpjfIszTzEFlA/u+3BSsy
         ZveioFi6hYqhUQRbG+0CX8w6xjm84KXClWIU7dkFgxUwIsA7JWK/d49KxDbXu+hLjUTZ
         6aByEGSDwmYlxvd/6pmtCARyBJrX61DDTCLXFcm9jCOlbM/2AMxrsOXeSTLPCiuucLLE
         R/Rw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771837600; x=1772442400; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vf8OCkLcF925yHhQDRYccujsEGySF7mdTQjjKgoTi8A=;
        b=S8LMaZAeL7pV5mD5lwjUYzO9X7+2DSkmAb82Qrv7Ifs2qFxBxgRcg4GiNIQXMkrgxq
         jTW5F3TmP6hLhKHC+isdKTxffRa1uXGu/yZdEbEYZnjuGbcy7AkpPxES1Y7KUCQjNaq9
         LH5QF8ZdyCkbmtg5Ur6pWfYeOv/MhehF7DpWY2xmWT7hhpKKhbXGB7kqqVbRGLcmGuDy
         s/mTghdwF+EoRr1QExCyaa5Ee+G2jsPO8dqhjts3CKtY00N4PK0m6YU4yotr4WEaEnOb
         olKW54lZWOZUTYmaVwETORK6vJoDT7dOThVK3gaJLAqJzaaWOjvUdXxIRSEwoZvVyNpr
         rK8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771837600; x=1772442400;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vf8OCkLcF925yHhQDRYccujsEGySF7mdTQjjKgoTi8A=;
        b=UMMEQG+eG3gsU/zbaNj64Aym2LxeImFcCTpp9kAfTXR7pTjnv5zITittD44+8XD3Ku
         z8qHfxC9X9W0dzQAuCy+1bdm0VrXG83X9ncFd55JNlMyooSqcnN3u1FLJ+xd45UbLKQr
         /Nc9XiZfK4HFdr/rTw1z9dj0+e3w76AO8Yddbdw+WY2LK6tm7simSLmTaCxeZfm39iXc
         ppMct4CN+gdmz2TWo8cH6pPVICMceWqZXNNRWKjySePIPUacJsQKzN/+XtbcACawDYq/
         E4jDw3Zcr6r3+QWnXZr1453IVfI6eCLCIwg+Qdo+t2oBKkAH6QPzZOTob84FbFmheMww
         +HNw==
X-Forwarded-Encrypted: i=1; AJvYcCWvduNhUsKJeMXs7GnKVPuMIu7MeClDhhMa8iXwepelLDLc3Q126MJguctfkIhW+hasl50=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCTUfkTcS5y5lXLRVsfCyevtxltZ/11em+F2tpCOdWERMgwLiB
	94FZcalR+diVO7ZfHessJ5SRvoiCwd3n70PMigK7mkr+pBLs2Rowdn1kS4QPY0XrQuUoV9J+kXY
	t4Skr1l+uTGoAiBB1194c23iIXAvwkzaCaglQ
X-Gm-Gg: AZuq6aKiBjWL/r6brP4i2UCGy/FcKrb8A0iDHw62N3Z/ly4t6ASRA4KanxpqYlK4R2W
	MMwhNR542WJsqa+yFJrGv8EljhhDOweab2mLhmAthQm1DNkd2B1Pas+TLO3rbXodc/kZuxSoGO2
	7iQJV07lHseUTxaQb7UKL4vBO+wBCFRNy4dwgcLgoKjUed9IzU4hZ6PvwRMVg9kZQtEqXx9jmbW
	L9KYEhQVsE9tLOqaT4gdE3o1x2yxsew1zHx3NZB15HEe4v5s7wIQHCw6+WI14gs985F+hxdRhdP
	FkGBtBwxYuTWqe30LudycfZbuQjmYLgEt6LPfr5Vgz2YorUV7+c=
X-Received: by 2002:a05:6102:3048:b0:5f8:e2cb:d245 with SMTP id
 ada2fe7eead31-5feb2c23567mr2751351137.0.1771837600223; Mon, 23 Feb 2026
 01:06:40 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 23 Feb 2026 04:06:38 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 23 Feb 2026 04:06:38 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260220-pks-refs-for-each-unification-v1-9-17170bd99de1@pks.im>
References: <20260220-pks-refs-for-each-unification-v1-0-17170bd99de1@pks.im> <20260220-pks-refs-for-each-unification-v1-9-17170bd99de1@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 23 Feb 2026 04:06:38 -0500
X-Gm-Features: AaiRm508_xkFWErcjW9tgNalfm45WROHYC-9VbfKVnes1uMt0WKvWlq88TsalW4
Message-ID: <CAOLa=ZSKF1WoE_2q5oEjU8MOh=_0s--cPwf0R8xnQQF8=9dWDw@mail.gmail.com>
Subject: Re: [PATCH 09/17] refs: generalize `refs_for_each_fullref_in_prefixes()`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000c2f89f064b7a16a2"

--000000000000c2f89f064b7a16a2
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The function `refs_for_each_fullref_in_prefixes()` can be used to
> iterate over all references part of any of the user-provided prefixes.
> In contrast to the `prefix` parameter of `refs_for_each_ref_ext()` it
> knows to handle the case well where multiple of the passed-in prefixes
> start with a common prefix by computing longest common prefixes and then
> iterating over those.
>
> While we could move this logic into `refs_for_each_ref_ext()`, this one
> feels somewhat special as we perform multiple iterations. But what we
> _can_ do is to generalize how this function works: instead of accepting
> only a small handful of parameters, we can have it accept the full
> options structure.
>
> One obvious exception is that the caller must not provide a prefix via
> the options. But this case can be easily detected.
>
> Refactor the code accordingly.
>

I've attempted the refactoring that this series is doing a couple of
times, I always got stuck up on how to integrate this function with the
rest. This is a novel approach.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  ls-refs.c    | 11 +++++++----
>  ref-filter.c | 11 +++++++----
>  refs.c       | 39 +++++++++++++++------------------------
>  refs.h       | 16 +++++-----------
>  4 files changed, 34 insertions(+), 43 deletions(-)
>
> diff --git a/ls-refs.c b/ls-refs.c
> index 8641281b86..9759826ca7 100644
> --- a/ls-refs.c
> +++ b/ls-refs.c
> @@ -160,6 +160,7 @@ static int ls_refs_config(const char *var, const char *value,
>
>  int ls_refs(struct repository *r, struct packet_reader *request)
>  {
> +	struct refs_for_each_ref_options opts = { 0 };
>  	struct ls_refs_data data;
>
>  	memset(&data, 0, sizeof(data));
> @@ -201,10 +202,12 @@ int ls_refs(struct repository *r, struct packet_reader *request)
>  	send_possibly_unborn_head(&data);
>  	if (!data.prefixes.nr)
>  		strvec_push(&data.prefixes, "");
> -	refs_for_each_fullref_in_prefixes(get_main_ref_store(r),
> -					  get_git_namespace(), data.prefixes.v,
> -					  hidden_refs_to_excludes(&data.hidden_refs),
> -					  send_ref, &data);
> +
> +	opts.exclude_patterns = hidden_refs_to_excludes(&data.hidden_refs);
> +	opts.namespace = get_git_namespace();
> +
> +	refs_for_each_ref_in_prefixes(get_main_ref_store(r), data.prefixes.v,
> +				      &opts, send_ref, &data);
>  	packet_fflush(stdout);
>  	strvec_clear(&data.prefixes);
>  	strbuf_release(&data.buf);
> diff --git a/ref-filter.c b/ref-filter.c
> index 049e845a19..7c682e0a33 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -2807,6 +2807,10 @@ static int for_each_fullref_in_pattern(struct ref_filter *filter,
>  				       refs_for_each_cb cb,
>  				       void *cb_data)
>  {
> +	struct refs_for_each_ref_options opts = {
> +		.exclude_patterns = filter->exclude.v,
> +	};
> +
>  	if (filter->kind & FILTER_REFS_ROOT_REFS) {
>  		/* In this case, we want to print all refs including root refs. */
>  		return for_each_fullref_with_seek(filter, cb, cb_data,
> @@ -2836,10 +2840,9 @@ static int for_each_fullref_in_pattern(struct ref_filter *filter,
>  		return for_each_fullref_with_seek(filter, cb, cb_data, 0);
>  	}
>
> -	return refs_for_each_fullref_in_prefixes(get_main_ref_store(the_repository),
> -						 NULL, filter->name_patterns,
> -						 filter->exclude.v,
> -						 cb, cb_data);
> +	return refs_for_each_ref_in_prefixes(get_main_ref_store(the_repository),
> +					     filter->name_patterns, &opts,
> +					     cb, cb_data);
>  }
>
>  /*
> diff --git a/refs.c b/refs.c
> index 99994879d9..20d34faeb5 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2029,40 +2029,31 @@ static void find_longest_prefixes(struct string_list *out,
>  	strbuf_release(&prefix);
>  }
>
> -int refs_for_each_fullref_in_prefixes(struct ref_store *ref_store,
> -				      const char *namespace,
> -				      const char **patterns,
> -				      const char **exclude_patterns,
> -				      refs_for_each_cb fn, void *cb_data)
> +int refs_for_each_ref_in_prefixes(struct ref_store *ref_store,
> +				  const char **prefixes,
> +				  const struct refs_for_each_ref_options *opts,
> +				  refs_for_each_cb cb, void *cb_data)
>  {
> -	struct strvec namespaced_exclude_patterns = STRVEC_INIT;
> -	struct string_list prefixes = STRING_LIST_INIT_DUP;
> +	struct string_list longest_prefixes = STRING_LIST_INIT_DUP;
>  	struct string_list_item *prefix;
> -	struct strbuf buf = STRBUF_INIT;
> -	int ret = 0, namespace_len;
> +	int ret = 0;
>
> -	find_longest_prefixes(&prefixes, patterns);
> +	if (opts->prefix)
> +		BUG("refs_for_each_ref_in_prefixes called with specific prefix");
>
> -	if (namespace)
> -		strbuf_addstr(&buf, namespace);
> -	namespace_len = buf.len;
> +	find_longest_prefixes(&longest_prefixes, prefixes);
>
> -	exclude_patterns = get_namespaced_exclude_patterns(exclude_patterns,
> -							   namespace,
> -							   &namespaced_exclude_patterns);
> +	for_each_string_list_item(prefix, &longest_prefixes) {
> +		struct refs_for_each_ref_options prefix_opts = *opts;
> +		prefix_opts.prefix = prefix->string;
>
> -	for_each_string_list_item(prefix, &prefixes) {
> -		strbuf_addstr(&buf, prefix->string);
> -		ret = refs_for_each_fullref_in(ref_store, buf.buf,
> -					       exclude_patterns, fn, cb_data);
> +		ret = refs_for_each_ref_ext(ref_store, cb, cb_data,
> +					    &prefix_opts);

Okay so it still calls `refs_for_each_ref_ext()` on the longest prefix.
Makes sense.

[snip]

--000000000000c2f89f064b7a16a2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 19cfe9ccc207e841_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tY0dKMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mKzM2Qy9zRTlmVTZxVk9QUGhWQ3Z4c3g2QUc0dnNxVwo5N1NNREdSWTZI
ME1uWXphdUZWRS9EQkhCMTBGb1g0ODZYZ0dIajNjTE9qSHo0Q0RtUU5SemxXbDFtMy8xZElOCkxh
WklOK1BlNkVQRXBwNnBuSmlueDhOYVpES0lpdU5Da2tzc3BLTzBHc1lZZEdKMW1ua2hESmtMQXVF
K0R5dEIKWC9iOUFHY0NDQ1N2RzlUaHhMUWNEeEdCUUcwU3pqZHZ1Zi9QdjQzNGkyaGNsRFFnZ2th
VEoyaW05cHNsLzJUVQpxd3UxRWZhU0EwRXVZKzBtWldaU2JvSVZYOFBDTW1mRUZmMGN0NzJ3RVAw
S296TjhlWklaTVNJc3RiUkI0RkN0CmpJRDVkeGFseWlsbzZpUGJOb1pnNzhESTFMZEdJRERxcHFm
bkJ1bllkODR6MjIyZklhSHR3M1QvNmxYSzYvN0cKMjl1aXBDR042RjlsaGZOWTJWVFNxRDUyK25J
Z041TXZBd1FRd3I0bE4zTGRrSzk1YXRqekw3clNxTGNKM001YQpOR21jT1lCdUVDUE5lWGtHU0hE
T3orWTZQdUpXdlRJUkJiU3FzUEZKQmZDWjcwVzhLQThTUkRWNzY0V2hzWk5OCkluSVp4RTJ6MXVq
aFdhNHZ3TkplYjdodzRNVytXeWV6aUNiQUswRT0KPUpyWG8KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000c2f89f064b7a16a2--
