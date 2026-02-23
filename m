Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6300A34C818
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 08:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771835238; cv=pass; b=eklihNRtLEzNf98OPxAHJv7jsqxVjTX7EHdwdtST1ytgEPD34LMMP8cx7nMmF07s6ZKcpw7oGovlVWZ/IPw5UAj46z29wEAAXjOwNlFpRBAVsamNn5McnRJrW3L4gjKz+O865CefaEc3cZ+Czlv4w6BTg5RnrKmvGYNUf4eNCDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771835238; c=relaxed/simple;
	bh=ZPV85Mj/YHvOv9xIF6ciU2EM/OPHwKKYTi8+NmmrAo0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=RibGNpQB4rVcaem+lhHmZb/gtXFGMmQkIjVMoqEzhRMs1G9SMzu0fwCiR7fAX5ZGASrG826NoXNnkLXhVHieaX2DxEIUgxP97HtOddwhK8ZRZH1x6cwWAXDcpHjeq7R0EYcVnzCx3Qh050+JsyMzxxxmFBnyLuPIEFkJaycivCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sx8ddbTZ; arc=pass smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sx8ddbTZ"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-94acb3d6cceso2491813241.2
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 00:27:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771835236; cv=none;
        d=google.com; s=arc-20240605;
        b=C9wY4Ue4g4sbxCLte1NTGdIJe1fmknpT58LHqKT283iV56HNyEn/XXv9Oaoh1Tx3iM
         paCaD+YZeFZj13v/VLcxwPliY8FctRS9OL95oOzB2pz/rBtv8vkjvX1OiGLgBK5wtNVa
         Z3kAnkxZVmnqLLpq1M3hcA+4HwUCQkIGolWgOQBtCHyZA7re6rWa8aRdv8lFNZu7d8ho
         kssWeHE+rEH+LfkQ9axFV1th8iq+dfFycDDvA3dJgtmUkdJEXXQgQmmXM7RGI7YfqwYd
         D4NNb61BSgAZbRUwJwpYi57riMHXBBCvtqYahHDLCX8yH6mzJwoJPFJd5OlTS9iYJ3/V
         I4Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=BhBi1wSF9IndDeZwcZBLJcLwU8AcypOWcfCTT3bepw4=;
        fh=qZSafb6fVCwClqkeswskNHT2/6xG2/GlslQDPTDMabI=;
        b=FduezVlXYhMRTbqwaNnVfeSRSmukphMVN1Eugw3eHXAd/4NW5WlRNBzl6AjPwnsLVf
         FJIBNlDKvZyEAFloh+Ihem2an4iUvRBRD+sSWYAAsPijWU321FtXQ54EhP7LInqa4ANC
         MqHH68zI8mUekdpNBCjewN7dZXbyt7nJpdbvvbrm4Sz9keVlfGRf3gRUPCIkg7FbIgPN
         mwfu7fUPvSEAyiZ3Lsbyebni0+7+SjgG72VnDCfqnjKWgT7kaTjQNh2H5uyKuHucqjfT
         9CwkHmk55UK/6eBww+d0BBGu1E7rEXQIx3LqGfs8b8oMUSh2CvEvgGX5kkj0twT2zkhz
         lzug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771835236; x=1772440036; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BhBi1wSF9IndDeZwcZBLJcLwU8AcypOWcfCTT3bepw4=;
        b=Sx8ddbTZ5f+ayo8ALKkiM6b8li+VSzK8d8VwA8qol3DjG9EzY8jZ8I5APOQww8xV8h
         mlLeN+TQieNQ9A0n+2XSpbfHlHjkZ0PHQz8h+zdRr53BGKyPNaRVjdvUKgBDJ1z4N+gu
         4OGUHDRwVuqR658WRF1o3yKOqmiSQFgGe2tdfha3CDcXWxUeVDaDRjcQIYWqC0Nda0Qi
         8qDg6ObB/WjihHxMN8l67FK0ShX4O7E0tWg0SJIk3bj6PoibFJ6oLnPUTUHv/s4x5cyY
         fe8H4s9JvNjXXUPy0xtFGbjPuIB4oJhglpquLt8rCfK+fvaLYHEcjXcOe6i+En1Vb2me
         7c3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771835236; x=1772440036;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BhBi1wSF9IndDeZwcZBLJcLwU8AcypOWcfCTT3bepw4=;
        b=WbP6TOmzzjjpwZkAZHUlnlsieoCnm4wysIabCIvVn+hKT4h/3m9ehEEOUYiE5K0Dds
         ys0kt0IcPV3uUgoSSDh8lZtcaEfD7FlTCHefJCZuZ+7Ny0OQ8LiF8ks5nQiX+vLk5nY7
         R/aiSwZRlYPI5hB9xuUqhsuXC4Wdp4hmSnUYW/19PnOKR/5UQJUU1WTjHYuRwUOKWb9Q
         n/D7LSullRUlRMmGYFMteYaas7DvQG6wxN5gGTnta82apYXlNeYWyjk+8xBmuH5iQB0B
         oCdm7L20f+5ScvWADPl4krpkIdZVx4jAbtrMBmg8HqAmgI7ld9bCpaRH10YgIAR4tDSI
         lDyA==
X-Forwarded-Encrypted: i=1; AJvYcCVPvdLOSDxCBCV8wCmPNiwQHylebMjRQjn1JrIW0IWej2j1+lJfLr8nCBpcXJ05zMCuyHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/JxZJbVjPNM9w1yuL0Kt6ZXn7+bt/eSeT4ulf0dWGxLjUXLDZ
	xdKqKFmNyZWl+y8J5Zmxg1fsCDItN58oyl+YcGY/KrFkpBqsLIL8pNtLJNdjemCozzvJUxKOCWZ
	bsYflw5/4IZ4nFpibpRhucJqXOlbEhIXV5STb
X-Gm-Gg: AZuq6aJH6x0A0GN/o3JKTgflRWicH/+1Z7yB/y6WKo46MFDgkB8kHecrkFhwtR/u/Sn
	TGwIf3NmL3EXTYYqgh4HWH4Ya1snEHUKuxmB385+qEbbjqaPjIUi7NW6D+wOsUZp+nQJvH/kvnk
	LrtHctgcNEPa+SWVwW2DvD9L4TlaNIkkzISGW3kSar5XgfPFuuVwRBFAnIMWiyZC2JyyWbyKoIe
	CmeC4/bb4vd8+XfXAjDc5NnAukwgsZIYr8lTOkiGknZ0orhPSPlse3bnZ6BWpdabFqWA8TXsFMF
	LPIomg4yVSNGSfqUIc8Lwb5iuitbTi+KXLj8VbJHWw==
X-Received: by 2002:a05:6102:e0e:b0:5ef:a77d:6876 with SMTP id
 ada2fe7eead31-5feb311b856mr3926019137.35.1771835236220; Mon, 23 Feb 2026
 00:27:16 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 23 Feb 2026 00:27:15 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 23 Feb 2026 00:27:15 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260220-pks-refs-for-each-unification-v1-7-17170bd99de1@pks.im>
References: <20260220-pks-refs-for-each-unification-v1-0-17170bd99de1@pks.im> <20260220-pks-refs-for-each-unification-v1-7-17170bd99de1@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 23 Feb 2026 00:27:15 -0800
X-Gm-Features: AaiRm50_6w9lOLuG4k8YyjzIHgewtqB3gGZhMZzfeiTFxlEA6QmPSyKJDGtxj7s
Message-ID: <CAOLa=ZRogQCpsD5eXOQrgt_DvgsXNfagbaxQm2eL+NwfUpw9OQ@mail.gmail.com>
Subject: Re: [PATCH 07/17] refs: speed up `refs_for_each_glob_ref_in()`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000db1f84064b7989e1"

--000000000000db1f84064b7989e1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Patrick Steinhardt <ps@pks.im> writes:

> The function `refs_for_each_glob_ref_in()` can be used to iterate
> through all refs in a specific prefix with globbing. The logic to handle
> this is currently hosted by `refs_for_each_glob_ref_in()`, which sets up
> a callback function that knows to filter out refs that _don't_ match the
> given globbing pattern.
>
> The way we do this is somewhat inefficient though: even though the
> function is expected to only yield refs in the given prefix, we still
> end up iterating through _all_ references, regardless of whether or not
> their name matches the given prefix.
>

So currently instead of relying on the backends to do the prefix
matching, the function uses its own callback to do the prefix matching.

> Extend `refs_for_each_ref_ext()` so that it can handle patterns and
> adapt `refs_for_each_glob_ref_in()` to use it. This means we continue to
> use the same callback-based infrastructure to filter individual refs via
> the globbing pattern, but we can now also use the other functionality of
> the `_ext()` variant.
>

So this change, ensures we don't do the filtering for prefix match
ourselves and allows the backend to do it.

> Most importantly, this means that we now properly handle the prefix.
> This results in a performance improvement when using a prefix where a
> significant majority of refs exists outside of the prefix. The following
> benchmark is an extreme case, with 1 million refs that exist outside the
> prefix and a single ref that exists inside it:
>
>     Benchmark 1: git rev-parse --branches=3Drefs/heads/* (rev =3D HEAD~)
>       Time (mean =C2=B1 =CF=83):     115.9 ms =C2=B1   0.7 ms    [User: 1=
13.0 ms, System: 2.4 ms]
>       Range (min =E2=80=A6 max):   114.9 ms =E2=80=A6 117.8 ms    25 runs
>
>     Benchmark 2: git rev-parse --branches=3Drefs/heads/* (rev =3D HEAD)
>       Time (mean =C2=B1 =CF=83):       1.1 ms =C2=B1   0.1 ms    [User: 0=
.3 ms, System: 0.7 ms]
>       Range (min =E2=80=A6 max):     1.0 ms =E2=80=A6   2.3 ms    2092 ru=
ns
>
>     Summary
>       git rev-parse --branches=3Drefs/heads/* (rev =3D HEAD) ran
>       107.01 =C2=B1 6.49 times faster than git rev-parse --branches=3Dref=
s/heads/* (rev =3D HEAD~)
>

Nice. That's a really neat bump in speed.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  refs.c | 69 ++++++++++++++++++++++++++++++++++++++----------------------=
------
>  refs.h | 10 ++++++++++
>  2 files changed, 50 insertions(+), 29 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index ec9e466381..ac34bbe6c1 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -590,40 +590,23 @@ void normalize_glob_ref(struct string_list_item *it=
em, const char *prefix,
>  	strbuf_release(&normalized_pattern);
>  }
>
> -int refs_for_each_glob_ref_in(struct ref_store *refs, refs_for_each_cb f=
n,
> +int refs_for_each_glob_ref_in(struct ref_store *refs, refs_for_each_cb c=
b,
>  			      const char *pattern, const char *prefix, void *cb_data)
>  {
> -	struct strbuf real_pattern =3D STRBUF_INIT;
> -	struct for_each_ref_filter filter;
> -	int ret;
> -
> -	if (!prefix && !starts_with(pattern, "refs/"))
> -		strbuf_addstr(&real_pattern, "refs/");
> -	else if (prefix)
> -		strbuf_addstr(&real_pattern, prefix);
> -	strbuf_addstr(&real_pattern, pattern);
> -
> -	if (!has_glob_specials(pattern)) {
> -		/* Append implied '/' '*' if not present. */
> -		strbuf_complete(&real_pattern, '/');
> -		/* No need to check for '*', there is none. */
> -		strbuf_addch(&real_pattern, '*');
> -	}
> -
> -	filter.pattern =3D real_pattern.buf;
> -	filter.prefix =3D prefix;
> -	filter.fn =3D fn;
> -	filter.cb_data =3D cb_data;
> -	ret =3D refs_for_each_ref(refs, for_each_filter_refs, &filter);
> -
> -	strbuf_release(&real_pattern);
> -	return ret;
> +	struct refs_for_each_ref_options opts =3D {
> +		.pattern =3D pattern,
> +		.prefix =3D prefix,
> +	};
> +	return refs_for_each_ref_ext(refs, cb, cb_data, &opts);
>  }
>
> -int refs_for_each_glob_ref(struct ref_store *refs, refs_for_each_cb fn,
> +int refs_for_each_glob_ref(struct ref_store *refs, refs_for_each_cb cb,
>  			   const char *pattern, void *cb_data)
>  {
> -	return refs_for_each_glob_ref_in(refs, fn, pattern, NULL, cb_data);
> +	struct refs_for_each_ref_options opts =3D {
> +		.pattern =3D pattern,
> +	};
> +	return refs_for_each_ref_ext(refs, cb, cb_data, &opts);
>  }
>
>  const char *prettify_refname(const char *name)
> @@ -1862,16 +1845,44 @@ int refs_for_each_ref_ext(struct ref_store *refs,
>  			  refs_for_each_cb cb, void *cb_data,
>  			  const struct refs_for_each_ref_options *opts)
>  {
> +	struct strbuf real_pattern =3D STRBUF_INIT;
> +	struct for_each_ref_filter filter;
>  	struct ref_iterator *iter;
> +	int ret;
>
>  	if (!refs)
>  		return 0;
>
> +	if (opts->pattern) {
> +		if (!opts->prefix && !starts_with(opts->pattern, "refs/"))
> +			strbuf_addstr(&real_pattern, "refs/");
> +		else if (opts->prefix)
> +			strbuf_addstr(&real_pattern, opts->prefix);
> +		strbuf_addstr(&real_pattern, opts->pattern);
> +
> +		if (!has_glob_specials(opts->pattern)) {
> +			/* Append implied '/' '*' if not present. */
> +			strbuf_complete(&real_pattern, '/');
> +			/* No need to check for '*', there is none. */
> +			strbuf_addch(&real_pattern, '*');
> +		}
> +
> +		filter.pattern =3D real_pattern.buf;
> +		filter.prefix =3D opts->prefix;

Can't we now remove this option and cleanup `for_each_filter_refs()` to
remove prefix trimming?

> +		filter.fn =3D cb;
> +		filter.cb_data =3D cb_data;
> +
> +		cb =3D for_each_filter_refs;
> +		cb_data =3D &filter;
> +	}
> +
>  	iter =3D refs_ref_iterator_begin(refs, opts->prefix ? opts->prefix : ""=
,
>  				       opts->exclude_patterns,
>  				       opts->trim_prefix, opts->flags);
>
> -	return do_for_each_ref_iterator(iter, cb, cb_data);
> +	ret =3D do_for_each_ref_iterator(iter, cb, cb_data);
> +	strbuf_release(&real_pattern);
> +	return ret;
>  }
>
>  int refs_for_each_ref(struct ref_store *refs, refs_for_each_cb cb, void =
*cb_data)
> diff --git a/refs.h b/refs.h
> index bb9c64a51c..a66dbf3865 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -458,6 +458,16 @@ struct refs_for_each_ref_options {
>  	/* Only iterate over references that have this given prefix. */
>  	const char *prefix;
>
> +	/*
> +	 * A globbing pattern that can be used to only yield refs that match.
> +	 * If given, refs will be matched against the pattern with
> +	 * `wildmatch()`.
> +	 *
> +	 * If the pattern doesn't contain any globbing characters then it is
> +	 * treated as if it was ending with "/" and "*".
> +	 */
> +	const char *pattern;
> +
>  	/*
>  	 * Exclude any references that match any of these patterns on a
>  	 * best-effort basis. The caller needs to be prepared for the exclude
>
> --
> 2.53.0.414.gf7e9f6c205.dirty

--000000000000db1f84064b7989e1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: c8ef39f98c901e37_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tY0QySVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMXVOREFDV2xNMG1YN2w1QzNLdEc2MTE0ck9McnpuSgp3M0hDcmhnMmJS
cXhveTJCYjMyTEpLN0RCa3VWLzhFL01FbTd0LzFLNzVRTjBxdFBFd0lMaGpERUppNW9taFdICjZa
MGNEdWhQa2lZNUoxWk5ZWHlsMjRUQXpEWVdPVzJUSk5CV0RQck1KaGpIcXBuSTF2MmxoaU52OU5G
WmhrcXcKWDhVQXlDcHRwYTBHZWtWUXg1TEkrdCtOTGlQdk5JVG9BN3lydW92Q3BYNlNkUmxLeVhQ
RkIvaE95VzE0YlhUVQpNcmZuRTZkS1FyaWlYWXF4QUp1cVc2VTZ3N0FCZ0pnQmFrMGE2cUlhRmhL
b0VweEVyR0RDOHN3SU5XLzhNQWt3Cmxnc05PZWpGT0VWS2ltRTlVTUxBLy9TVVVvNU9FYWFCMlkw
QzVlSG5rZlJMVTh1OXFha2NMQkxpdFQrcmp3N1AKMEZ4cXkvdEJKNjJtek5hd3QybkZqRDRFdXdv
R0FLcHdTTStDZ3IxVjEwVFo2czkvaC8wcVEzSmVhR1VLNFhDMAprR3NGWXRucERzSHpQUGR5aG1P
aWF4NU5wMjd5K0VxUksydHI3RWNyWGZ1WTgzVEQwd0sxcGtKWHdCMzg4OGZFCmJJRWtYRVZhUXl4
Q1ppYUhuSWRXYUZwaEZiNmx3WjBGVHFZN0hnVT0KPXBBcFEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000db1f84064b7989e1--
