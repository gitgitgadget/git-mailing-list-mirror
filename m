Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E3534C990
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 08:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771834444; cv=pass; b=BxRao4PM0cquzu7wTWBpBduCh6XjzhQ/bgeUVouAbIvwGxL9tMt6G2Vussh8DZIRMVbhp7zoYoIyNxMVRTvTzW8WDaKoAMDNkxIF85LQ8qfAuP8+B/3vzyCZ1ZrrICRSDPeSeNABYjVGDEh/MEwABNa64C+6KMODnALQOtgkmnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771834444; c=relaxed/simple;
	bh=oIXdK6BT+9I0y6c0N5jrfM7Z3LiBEyeX30lzzBaCeVs=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=o01c4kirJaVaRixrqvKzL/X9iOYm0lT4ogWtEpcYMtNfJEVEzYMrgTAc4NcXD+E0462TgfolXGGZp9fPhkOQ9W3eLDbwR6l54GFoN7ZXJtmH08spSrjdXgFfKyl4/GibUAIwmaVkpAfjU50IafhWGfFDGkS3QAb51swPLIicIcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VYnNm0Fe; arc=pass smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYnNm0Fe"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-5fe086fb0bdso915218137.0
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 00:14:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771834442; cv=none;
        d=google.com; s=arc-20240605;
        b=MJ0cYe8LntiBaHJBVfnP6XwtfpP5pIJJOK/xUshtnBvWHBEwwsQv3k2oesXiO4ejbC
         XOuwFxPee9vwAqkYHXE7ulMkmPhSeIu0CLkpNlmL9h2F7eat5d/D1rxnlHm41iCvmse6
         /i7DSiT9O5fAQZoowcKu7pGBGLtwt/2AEGoIsC50VvtIzm/hX5pyhDDYDG41mpaTP+qa
         fZC7XE08RNklooMsWWQulCdJ2pTP2ERHLSMhN7Aos5Bw+oyRTiw/KmQiliCvSxXu4EKM
         3SteTm+RVWQamSqQYkJsdQzGViJRRtzIcP8xe63N+vIQd6jZU9ZPoxTdaj9fElLR5+Bs
         6b6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=0nxHouw2vu7LSO8Frlmcg8WqS7kDMTzSzJs4e7WdTEs=;
        fh=ngquqKarufM01ZtayiMG538sUQxT6U3id+bwfQm6G0k=;
        b=gxv6HGbVynY/16cJnNzZNY3EWS4DxGqBLSvqsQ5FJJJJQ5yQQcIsEzgiwmx2PNrIPi
         LilwVLY/x8ThQtIDHxBsGn2lKQisC8ESSe6DUQw0AxhGupQDbzmeHEQHQ07bS3C2pK52
         qyPj+dSdsfvAf3Nkmy3jjfsTCRM6o/Hyv+4B5m2aereONS1pnO4Ls37ytyz7N5kgdfyt
         SBN17R8xMzzYjs6RmxqDSQaZENEteLeEWCDiavGXy0+5NwnsgD0NhYKGBmjnQoEFy0dk
         yyu+ykPmWGJeEc0ti0IcqzgOdzHxVVj8mHqBW6TOBVLhXY1j61dgPkn20mpRAluRE5MI
         A+tQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771834442; x=1772439242; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0nxHouw2vu7LSO8Frlmcg8WqS7kDMTzSzJs4e7WdTEs=;
        b=VYnNm0FenI2cqdWogmmZLIxvx0fO+gUcqmlPjqhAfwrIhP7cHeviPkJ2omrrgzL9g6
         +WP1HNQf1C8nACHBnINFyC2R5Uz9iPeQ+Hh3x5b4mFZEhmbadCekgU9uStwoJ6wrGSij
         4spFiZCwWBZGsrj6XPsD4rhmlcz7eNThp3ro5gUBPjt5gVe2wy4pByJoB8mcvNxqQnZO
         gQ66A7/UPZhIned0nD3IeaoGxokqlj4KoGQOF6UxXQzFZul5eGybF44vuIlFFjHzMWHV
         XzcVuEfQWDfXUB0rRlGR5BViLEPq5rKcrz7Tn6n7gL/zbBMphnXTxC3wWbEMBF4D6RgY
         HjnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771834442; x=1772439242;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0nxHouw2vu7LSO8Frlmcg8WqS7kDMTzSzJs4e7WdTEs=;
        b=OT4f8ilUcRZ9Uqoxd3Uu3l05KcCFDAo1vLhZUP+J5FMfA8QJN+XxxsBCoa1daVTQVA
         BqNcrsALRs4c14qgzvYZYzwlPiqcGIJABtd/BxqYyIvQe0rZ71tO8YjBelHZqQl8NYRd
         PncZqcTNMW+9rKX5JraARTcdCgsVzM7C0m9+VXVW5n4BdFs9kFqqH2/dFwsL4QBo+a0w
         lV4R9H+125rJI8P1NCJ8Mes54/qpgFFe1+Xcsars/s5iMMOjAPdR2ge/FjZ2TELoQSL8
         A5GU0233ixbRJ6JFVHVTsFKZlrLaIAsEdBB5yXJpIN8gjf0LKbKiVoEf7+c2GoKbS9J2
         0w4A==
X-Forwarded-Encrypted: i=1; AJvYcCUUgHf44F7Sl2yT9k0ZcHg5gpBBWh+5ZBSHZVTUwDTKlRWwqWuBwsosoz1gfglvqO+LcmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiAsM4RUGg3t5nUVxd3hsaI1Nq+KGadfoGyyVLSQtwEms0hPNa
	dwNWohUrsptZRSG4cYa1E7VM/688n8gn0Z++5HPuIuxheKKe1CgyhzNf39mYhWw2CBhECYsi1iE
	HdVOhpAwLAjCYm4pSXV0Wg3Gj29m4430VyQ9y
X-Gm-Gg: AZuq6aIOpJXKXTsY3eqR9aTfDNOnjf0lkPMmqv1KTYgT4YQ584oENpyBbHJAD7k9C+M
	+7qwMEPTrzUQDJVjoxAeiIJCbs4UyxuhMDm8V8q94+O5DzD5SOOqxNQUDu9AoWaQPS5KyMosBv2
	PceYlIc4iBzERQV+OpU2RR+WSZ/FVJ/mQBqLlDIGKWLmxr6E2VLqnkHq0fCNkeTayvTPLTjpaAa
	Gc17O3lNlH/Uf3oBS2mxyIJejoizgzz3KB+TvicLsAiilp52OBpgO+fYOKglH1M6IJtSvsl/6cC
	3D6K+dlpaJ7+EdM+UU4HYgc0oJ2Axgd50h5JFmuOtK0R/qob1OL+
X-Received: by 2002:a05:6102:c04:b0:5ef:ac78:3c71 with SMTP id
 ada2fe7eead31-5feb2f03598mr2163369137.14.1771834441558; Mon, 23 Feb 2026
 00:14:01 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 23 Feb 2026 10:14:00 +0200
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 23 Feb 2026 10:14:00 +0200
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260220-pks-refs-for-each-unification-v1-6-17170bd99de1@pks.im>
References: <20260220-pks-refs-for-each-unification-v1-0-17170bd99de1@pks.im> <20260220-pks-refs-for-each-unification-v1-6-17170bd99de1@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 23 Feb 2026 10:14:00 +0200
X-Gm-Features: AaiRm52QLIFJ5ry40_C8PgCrefUSTXTUTVJcE9mjUT-e-fx7f1CdiN1oCqa4lu4
Message-ID: <CAOLa=ZQN3FfZAQpRGOdd_VDWKodYGw8jpKbt2R08FbZLN0+RPw@mail.gmail.com>
Subject: Re: [PATCH 06/17] refs: introduce `refs_for_each_ref_ext`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000007d89d6064b795a3f"

--0000000000007d89d6064b795a3f
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> In the refs subsystem we have a proliferation of functions that all
> iterate through references. (Almost) all of these functions internally
> call `do_for_each_ref()` and provide slightly different arguments so
> that one can control different aspects of its behaviour. This approach
> doesn't really scale: every time there is a slightly different use case
> for iterating through refs we create another new function.
>
> This combinatorial explosion doesn't make a lot of sense: it leads to
> confusing interfaces and heightens the maintenance burden.
>
> Refactor the code to become more composable by:
>
>   - Exposing `do_for_each_ref()` as `refs_for_each_ref_ext()`.
>
>   - Introducing an options structure that lets the caller control
>     individual options.
>
> This gives us a much better foundation to build on going forward.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  refs.c | 78 ++++++++++++++++++++++++++++++++++++++++--------------------------
>  refs.h | 29 +++++++++++++++++++++++++
>  2 files changed, 77 insertions(+), 30 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index a45cc61211..ec9e466381 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1858,62 +1858,76 @@ struct ref_iterator *refs_ref_iterator_begin(
>  	return iter;
>  }
>
> -static int do_for_each_ref(struct ref_store *refs, const char *prefix,
> -			   const char **exclude_patterns,
> -			   refs_for_each_cb fn, int trim,
> -			   enum refs_for_each_flag flags, void *cb_data)
> +int refs_for_each_ref_ext(struct ref_store *refs,
> +			  refs_for_each_cb cb, void *cb_data,
> +			  const struct refs_for_each_ref_options *opts)

So instead of passing prefix, exclude_patterns and trim, we pass in a
struct which contains the options. Ok.

We also rename fn to cb, since that is more legible.

>  {
>  	struct ref_iterator *iter;
>
>  	if (!refs)
>  		return 0;
>
> -	iter = refs_ref_iterator_begin(refs, prefix, exclude_patterns, trim,
> -				       flags);
> +	iter = refs_ref_iterator_begin(refs, opts->prefix ? opts->prefix : "",
> +				       opts->exclude_patterns,
> +				       opts->trim_prefix, opts->flags);
>
> -	return do_for_each_ref_iterator(iter, fn, cb_data);
> +	return do_for_each_ref_iterator(iter, cb, cb_data);
>  }
>
> -int refs_for_each_ref(struct ref_store *refs, refs_for_each_cb fn, void *cb_data)
> +int refs_for_each_ref(struct ref_store *refs, refs_for_each_cb cb, void *cb_data)
>  {
> -	return do_for_each_ref(refs, "", NULL, fn, 0, 0, cb_data);
> +	struct refs_for_each_ref_options opts = { 0 };
> +	return refs_for_each_ref_ext(refs, cb, cb_data, &opts);
>  }
>
>  int refs_for_each_ref_in(struct ref_store *refs, const char *prefix,
> -			 refs_for_each_cb fn, void *cb_data)
> +			 refs_for_each_cb cb, void *cb_data)
>  {
> -	return do_for_each_ref(refs, prefix, NULL, fn, strlen(prefix), 0, cb_data);
> +	struct refs_for_each_ref_options opts = {
> +		.prefix = prefix,
> +		.trim_prefix = strlen(prefix),
> +	};
> +	return refs_for_each_ref_ext(refs, cb, cb_data, &opts);
>  }
>
>  int refs_for_each_fullref_in(struct ref_store *refs, const char *prefix,
>  			     const char **exclude_patterns,
> -			     refs_for_each_cb fn, void *cb_data)
> +			     refs_for_each_cb cb, void *cb_data)
>  {
> -	return do_for_each_ref(refs, prefix, exclude_patterns, fn, 0, 0, cb_data);
> +	struct refs_for_each_ref_options opts = {
> +		.prefix = prefix,
> +		.exclude_patterns = exclude_patterns,
> +	};
> +	return refs_for_each_ref_ext(refs, cb, cb_data, &opts);
>  }
>
> -int refs_for_each_replace_ref(struct ref_store *refs, refs_for_each_cb fn, void *cb_data)
> +int refs_for_each_replace_ref(struct ref_store *refs, refs_for_each_cb cb, void *cb_data)
>  {
>  	const char *git_replace_ref_base = ref_namespace[NAMESPACE_REPLACE].ref;
> -	return do_for_each_ref(refs, git_replace_ref_base, NULL, fn,
> -			       strlen(git_replace_ref_base),
> -			       REFS_FOR_EACH_INCLUDE_BROKEN, cb_data);
> +	struct refs_for_each_ref_options opts = {
> +		.prefix = git_replace_ref_base,
> +		.trim_prefix = strlen(git_replace_ref_base),
> +		.flags = REFS_FOR_EACH_INCLUDE_BROKEN,
> +	};
> +	return refs_for_each_ref_ext(refs, cb, cb_data, &opts);
>  }
>
>  int refs_for_each_namespaced_ref(struct ref_store *refs,
>  				 const char **exclude_patterns,
> -				 refs_for_each_cb fn, void *cb_data)
> +				 refs_for_each_cb cb, void *cb_data)
>  {
> +	struct refs_for_each_ref_options opts = { 0 };
>  	struct strvec namespaced_exclude_patterns = STRVEC_INIT;
>  	struct strbuf prefix = STRBUF_INIT;
>  	int ret;
>
> -	exclude_patterns = get_namespaced_exclude_patterns(exclude_patterns,
> -							   get_git_namespace(),
> -							   &namespaced_exclude_patterns);
> -
> +	opts.exclude_patterns = get_namespaced_exclude_patterns(exclude_patterns,
> +								get_git_namespace(),
> +								&namespaced_exclude_patterns);
>  	strbuf_addf(&prefix, "%srefs/", get_git_namespace());
> -	ret = do_for_each_ref(refs, prefix.buf, exclude_patterns, fn, 0, 0, cb_data);
> +	opts.prefix = prefix.buf;
> +
> +	ret = refs_for_each_ref_ext(refs, cb, cb_data, &opts);
>
>  	strvec_clear(&namespaced_exclude_patterns);
>  	strbuf_release(&prefix);
> @@ -1926,10 +1940,13 @@ int refs_for_each_rawref(struct ref_store *refs, refs_for_each_cb fn, void *cb_d
>  }
>
>  int refs_for_each_rawref_in(struct ref_store *refs, const char *prefix,
> -			    refs_for_each_cb fn, void *cb_data)
> +			    refs_for_each_cb cb, void *cb_data)
>  {
> -	return do_for_each_ref(refs, prefix, NULL, fn, 0,
> -			       REFS_FOR_EACH_INCLUDE_BROKEN, cb_data);
> +	struct refs_for_each_ref_options opts = {
> +		.prefix = prefix,
> +		.flags = REFS_FOR_EACH_INCLUDE_BROKEN,
> +	};
> +	return refs_for_each_ref_ext(refs, cb, cb_data, &opts);
>  }
>
>  static int qsort_strcmp(const void *va, const void *vb)
> @@ -3187,6 +3204,9 @@ int repo_migrate_ref_storage_format(struct repository *repo,
>  				    struct strbuf *errbuf)
>  {
>  	struct ref_store *old_refs = NULL, *new_refs = NULL;
> +	struct refs_for_each_ref_options for_each_ref_opts = {
> +		.flags = REFS_FOR_EACH_INCLUDE_ROOT_REFS | REFS_FOR_EACH_INCLUDE_BROKEN,
> +	};
>  	struct ref_transaction *transaction = NULL;
>  	struct strbuf new_gitdir = STRBUF_INIT;
>  	struct migration_data data = {
> @@ -3270,7 +3290,7 @@ int repo_migrate_ref_storage_format(struct repository *repo,
>  	data.errbuf = errbuf;
>
>  	/*
> -	 * We need to use the internal `do_for_each_ref()` here so that we can
> +	 * We need to use `refs_for_each_ref_ext()` here so that we can
>  	 * also include broken refs and symrefs. These would otherwise be
>  	 * skipped silently.
>  	 *
> @@ -3280,9 +3300,7 @@ int repo_migrate_ref_storage_format(struct repository *repo,
>  	 * allow for a central lock due to its design. It's thus on the user to
>  	 * ensure that there are no concurrent writes.
>  	 */
> -	ret = do_for_each_ref(old_refs, "", NULL, migrate_one_ref, 0,
> -			      REFS_FOR_EACH_INCLUDE_ROOT_REFS | REFS_FOR_EACH_INCLUDE_BROKEN,
> -			      &data);
> +	ret = refs_for_each_ref_ext(old_refs, migrate_one_ref, &data, &for_each_ref_opts);
>  	if (ret < 0)
>  		goto done;
>

Then we modify all the callees to use the new options struct instead of
passing in the arguments individually. Seems good.

> diff --git a/refs.h b/refs.h
> index 5190e98b2c..bb9c64a51c 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -453,8 +453,37 @@ int refs_head_ref(struct ref_store *refs,
>  int refs_head_ref_namespaced(struct ref_store *refs,
>  			     refs_for_each_cb fn, void *cb_data);
>
> +
> +struct refs_for_each_ref_options {
> +	/* Only iterate over references that have this given prefix. */
> +	const char *prefix;
> +
> +	/*
> +	 * Exclude any references that match any of these patterns on a
> +	 * best-effort basis. The caller needs to be prepared for the exclude
> +	 * patterns to be ignored.
> +	 *
> +	 * The array must be terminated with a NULL sentinel value.
> +	 */
> +	const char **exclude_patterns;
> +
> +	/*
> +	 * The number of bytes to trim from the refname. Note that the trimmed
> +	 * bytes must not cause the reference to become empty. As such, this
> +	 * field should typically only be set when one uses a `prefix` ending
> +	 * in a slash.
> +	 */
> +	size_t trim_prefix;
> +
> +	/* Flags that change which refs will be included. */
> +	enum refs_for_each_flag flags;
> +};
> +
>  int refs_for_each_ref(struct ref_store *refs,
>  		      refs_for_each_cb fn, void *cb_data);
> +int refs_for_each_ref_ext(struct ref_store *refs,
> +			  refs_for_each_cb cb, void *cb_data,
> +			  const struct refs_for_each_ref_options *opts);
>  int refs_for_each_ref_in(struct ref_store *refs, const char *prefix,
>  			 refs_for_each_cb fn, void *cb_data);
>  int refs_for_each_tag_ref(struct ref_store *refs,
>
> --
> 2.53.0.414.gf7e9f6c205.dirty

--0000000000007d89d6064b795a3f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 667de6fc8eff709a_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tY0RFY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mdzB0REFDaUVzWTNtRUJYZEEvSmtiUW42UmI2M1UybAp4cWxwVFdXTith
bnFEUm04RUpIQ3pXR0VEOGJ4KytIV2I0QW5pa1ZuK2JxMVBhZjg1YmhyVmhBV0hYSXFkR3drCmIv
RXF0WEFTQ1JYMzkxMjhrZnZNVm5GL2xSZldwTDl6dzFaalc0UE9jakh2N09wbW5xNEw3QnBjcHUr
eXhYSmsKcjF2T0J0WjBoeGdVYkg5bXFUK04xcE1tcTB2VlNyYURvZnc0Uy9DZzFJeHlWY3hJTFdV
aWQ2QWR0UGExMS91YgpyN2lNdXRnRmljV3lCMTZSV25aS2hEZlcwRVdqYnNTOWpKMU4wQ1RQc0Ix
QXhINC9pNU55WlBRc1RkZkczb1JnCk9melNxK0lHSG1WNjNYVkdmQXFrdTlpZk1zcnhRZHgrYzUx
b21mWkE4aElQZXBTYW56bkJYb3FyeFpTcktkUjEKZjYwV25ZRmxUdUU0UllPZEd2WGR0RGxUU1c4
Z3V5WTQwai9Xem9UNWRjb0hqTDhSS2N4QjhYSU55cDlSdm96bApUZlFqTlFnc1VxcEpNUzFoQ1BV
QXlpWUZIVmx2aDBHR2hIT0h6WnRJaU5VbnJXOUg2RXJkSlM1bW13cUprV1JTCmRpanU3YUdWMFJG
aGxuNlVYbjJ3S1VBUFpOaUVCVDFRYW5BVkZkaz0KPTh6Vm0KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000007d89d6064b795a3f--
