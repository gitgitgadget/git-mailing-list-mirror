Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CA213D891
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 09:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771837379; cv=pass; b=AImil/DMcYvb9smcpUUkuINdAAY4Dwk1zXd9+RCUkfTQ+BNnZfEIj1nli+HA9p7Fg+UtCkNX8RpYgDepjRwXD34vd8VxrMFg9tZ6aXTxkjZZjLsHuvRIjyWc/R/A1MDH5ZfH90hbJCHC3TfI2eri8mT7raM5bdr3Ei7CNHFVLHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771837379; c=relaxed/simple;
	bh=8LHZxRBMo4bAiVNctbunNCOXU+5g1g87qSFlXLKi9/w=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=U1Qn6cPyL7hSUbtOKi8bekb2ytjBN3mBAUBvvLzASzPjXIOYKzFfl7P0BB2KzSMe43MY2GXLtjpw1QEetKR3svA09vEwF+2iqjm1VXAUhg9Xme96zKXkweam5faxWrOhzNzPpLNJ6p8D926FonDAUKsajHfTbv1cBWjDYTwoVrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+GIPD8L; arc=pass smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+GIPD8L"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-56743b33c67so1763572e0c.2
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 01:02:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771837377; cv=none;
        d=google.com; s=arc-20240605;
        b=lFSb3O7gWR0laNqO8DGVKt2rl+sHv66oLZk/7W+V3aflstwqWeOa5sGwDw3zSYcpKh
         6dnDoEK0UYz2xeqQWRpxx7nFLVBy6ZETSSr9vhgXtYMVIshLPWt4gOhDQZ9ZqbwcJ4I+
         tjSVWpEFc1FmfIGwIGIK1b8sRsbmSpj8ynzPqZIOX+pb6Okt4S9uoPWFfSBnHs1HE1+3
         SCRVE2myQqtj0kAf88ndmiFceZrZ8mQ5liGL73uMKyShhMgMMvVYIcRtFu1fcWtT1f+K
         PuZiQaW72FZW4/A5zmZJwnSLrTNOIKpl5yhTErBohUHJk+48q/I3vxr0YyOnTCBl1838
         SzMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=ittFZeo9lQe4laAZ/1Hd0EyxcLdkqk97UiCpdoAWUT8=;
        fh=AiiKlACw5ic0k5UGf1vyFkQhwztneOTZZYIfLI5IqiE=;
        b=Hzww2iCGknvBeVZRFaTMGjDuQfjfhwwvKlz6USrsWNkQjaMR9gpL9osWIVyxBGBqpX
         gCq9cZF3+8+LF96EFAOfOYmdo4iklrxH0LKTp/Wq0vjF/iJsRH4D/1xMcPAdq1ZVKiVQ
         4KSM+6idm48vs3qmMX+JPe/rLXIq8gVaArqUgMpQp4coBFl2vqT9mNMA7mESI1A/De0k
         TrlqBOqn2siuBqaRohoGJ66I9NiyVLGOL9MNbk8r7LMQ2mtO40Ri17YQ48DFTfoRvJnR
         VIrarfOFSlekYSO+oYIwTWreRPVe3Kjoao0A43halu79EeIW1rbrjcv7hCcfPJTP9aPy
         m3ZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771837377; x=1772442177; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ittFZeo9lQe4laAZ/1Hd0EyxcLdkqk97UiCpdoAWUT8=;
        b=b+GIPD8L6beM/1hs6P0xe3M5vD565kx+BKzlt8pgczu5bcj8APbxtZo2GJEn7pH/dd
         y9JhSvDCvJ4Y8K5D+ug3oNad/+U0OOEDjeqMswe5n8OHDfTScT1kMnePX2xEVNNVazc9
         alrfhbGPu/uXHpLR6YlMeDnKfRM6ucgFEKzk0mEpjOwubU+ir73o+DXFKeO5fPlCMN5D
         Hk2CWq0rdyrwnO5bDicSe5T2mXCbB0j93H/udx/t/sQ4rLdwTGW9RIOv5uICBjYDF4mK
         qYu8oPHkhkgSCmc3Ts0dnB/CwQqRg/G2nnrg0foY1mZ6x5k7zeamPdAGwsGO/Yynrgtl
         oHwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771837377; x=1772442177;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ittFZeo9lQe4laAZ/1Hd0EyxcLdkqk97UiCpdoAWUT8=;
        b=iPvZsCItFdismuNzZUoAU8rPYrf6HBZFRKhu1rtf8kOo9fADvfA68/H2XjxKrAgUvr
         FL1XiFv7PeIf4pa3LipQyIC+NHO1mfsx+y7W7z08A4sLXhkjoTjliNTHdNZLjfA1MraC
         mzbtieuNQQl2FhHH2x+QYaluFapVKwbxCexeaZnu4nbidj6zhovxzA0PKfznPhbfwtic
         UqIst6CfP2lriG5uwWsa35omrn5qRTYyhlaAYZqulwKz8tTEZYDpkfKQnTdXLcjKT9gu
         NXfuyA5RDACQhWaXUe9SeVnDXqwkRgW46ga7BnMNitVI3npGI+xgYJ0z6GFQBVlXHKd2
         DCOA==
X-Forwarded-Encrypted: i=1; AJvYcCXDnrbQLihtxcJl7hjGHFB5IC7MYAAuyS8tFuTEOdRnFXKGAqPs/Ml+hyQpaXxMOyPoass=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhgclCgJyqq0V2LVWGQrr0ysbS9WBWrBSSVV9eNGmrkw9PhJv0
	82+izdUCO4nGzCQkWwbNr1vQ3jQCXZzHB4eQcm+l2tA+MWmzxZ5kI6lSc+ZGlXRkU0i8IqS6srb
	mv0s+nSj90/Kxqsop5M3Pr/4SB7OEDTfzhPGQ
X-Gm-Gg: AZuq6aKkmWb/F19MhbT959E88djzC3h6WpprNzk9WgMRSm/qBfRmchSSP9qFiwWHveB
	nv+BI48tpiB+MdUjk6+OmJ8DkB4+/4DPGaH52tsqCXCadQokAEC6q/wiyW2otxONPY9K/ELm/yU
	DqYk2qVjFfQUsElUPb00OWiPu5Wq2DCMm2Aakhzb9plO9xpRVbfPBsvGhQghbDg5lbYwCwGy7ci
	+wc5ah8OguUdqeyt8iALKKWvGvWAOGTOwSvHTiojYsbLVgmKdDBRI1UR9VkIfPReWDibxbTkXo9
	Kc4183XDIi37RMKcPLjYm5DEnmjjZ71aVB6nj/tW
X-Received: by 2002:a05:6102:26d4:b0:5f9:35a4:f5e3 with SMTP id
 ada2fe7eead31-5feb2f0fa16mr2673417137.12.1771837376941; Mon, 23 Feb 2026
 01:02:56 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 23 Feb 2026 01:02:56 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 23 Feb 2026 01:02:56 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260220-pks-refs-for-each-unification-v1-8-17170bd99de1@pks.im>
References: <20260220-pks-refs-for-each-unification-v1-0-17170bd99de1@pks.im> <20260220-pks-refs-for-each-unification-v1-8-17170bd99de1@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 23 Feb 2026 01:02:56 -0800
X-Gm-Features: AaiRm52So48fg3l4mzxw1FyI94ehjVNq6BHC0rXI6F0yPpvtjwGCT9m34wYy2pA
Message-ID: <CAOLa=ZQjZ-YLedF=Cqn=Tb8-rhX8=+Lnd2VKv0fn_ryrO563_g@mail.gmail.com>
Subject: Re: [PATCH 08/17] refs: generalize `refs_for_each_namespaced_ref()`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000073f506064b7a0970"

--00000000000073f506064b7a0970
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The function `refs_for_each_namespaced_ref()` iterates through all
> references that are part of the current ref namespace. This namespace
> can be configured by setting the `GIT_NAMESPACE` environment variable
> and is then retrieved by calling `get_git_namespace()`.
>
> If a namespace is configured, then we:
>
>   - Obviously only yield refs that exist in this namespace.
>
>   - Rewrite exclude patterns so that they work for the given namespace,
>     if any namespace is currently configured.
>
> Port this logic to `refs_for_each_ref_ext()` by adding a new `namespace`
> field to the options structure. This gives callers more flexibility as
> they can decide by themselves whether they want to use the globally
> configured or an arbitrary other namespace.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  refs.c | 47 +++++++++++++++++++++++++++++------------------
>  refs.h |  6 ++++++
>  2 files changed, 35 insertions(+), 18 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index ac34bbe6c1..99994879d9 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1845,9 +1845,13 @@ int refs_for_each_ref_ext(struct ref_store *refs,
>  			  refs_for_each_cb cb, void *cb_data,
>  			  const struct refs_for_each_ref_options *opts)
>  {
> +	struct strvec namespaced_exclude_patterns = STRVEC_INIT;
> +	struct strbuf namespaced_prefix = STRBUF_INIT;
>  	struct strbuf real_pattern = STRBUF_INIT;
>  	struct for_each_ref_filter filter;
>  	struct ref_iterator *iter;
> +	const char **exclude_patterns;
> +	const char *prefix;
>  	int ret;
>
>  	if (!refs)
> @@ -1876,11 +1880,29 @@ int refs_for_each_ref_ext(struct ref_store *refs,
>  		cb_data = &filter;
>  	}
>
> -	iter = refs_ref_iterator_begin(refs, opts->prefix ? opts->prefix : "",
> -				       opts->exclude_patterns,
> +	if (opts->namespace) {
> +		strbuf_addstr(&namespaced_prefix, opts->namespace);
> +		if (opts->prefix)
> +			strbuf_addstr(&namespaced_prefix, opts->prefix);
> +		else
> +			strbuf_addstr(&namespaced_prefix, "refs/");
> +

So if the namespace is 'foo', we'll have the namespace folder as
'refs/namespace/foo', and a prefix of 'refs/heads/' would mean that the
'namespaced_prefix' is now 'refs/namespace/foo/refs/heads'. Looks good.

> +		prefix = namespaced_prefix.buf;
> +		exclude_patterns = get_namespaced_exclude_patterns(opts->exclude_patterns,
> +								   opts->namespace,
> +								   &namespaced_exclude_patterns);
> +	} else {
> +		prefix = opts->prefix ? opts->prefix : "";
> +		exclude_patterns = opts->exclude_patterns;
> +	}
> +
> +	iter = refs_ref_iterator_begin(refs, prefix, exclude_patterns,
>  				       opts->trim_prefix, opts->flags);
>
>  	ret = do_for_each_ref_iterator(iter, cb, cb_data);
> +
> +	strvec_clear(&namespaced_exclude_patterns);
> +	strbuf_release(&namespaced_prefix);
>  	strbuf_release(&real_pattern);
>  	return ret;
>  }
> @@ -1927,22 +1949,11 @@ int refs_for_each_namespaced_ref(struct ref_store *refs,
>  				 const char **exclude_patterns,
>  				 refs_for_each_cb cb, void *cb_data)
>  {
> -	struct refs_for_each_ref_options opts = { 0 };
> -	struct strvec namespaced_exclude_patterns = STRVEC_INIT;
> -	struct strbuf prefix = STRBUF_INIT;
> -	int ret;
> -
> -	opts.exclude_patterns = get_namespaced_exclude_patterns(exclude_patterns,
> -								get_git_namespace(),
> -								&namespaced_exclude_patterns);
> -	strbuf_addf(&prefix, "%srefs/", get_git_namespace());
> -	opts.prefix = prefix.buf;
> -
> -	ret = refs_for_each_ref_ext(refs, cb, cb_data, &opts);
> -
> -	strvec_clear(&namespaced_exclude_patterns);
> -	strbuf_release(&prefix);
> -	return ret;
> +	struct refs_for_each_ref_options opts = {
> +		.exclude_patterns = exclude_patterns,
> +		.namespace = get_git_namespace(),
> +	};
> +	return refs_for_each_ref_ext(refs, cb, cb_data, &opts);
>  }
>
>  int refs_for_each_rawref(struct ref_store *refs, refs_for_each_cb fn, void *cb_data)
> diff --git a/refs.h b/refs.h
> index a66dbf3865..2bde60aa0e 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -468,6 +468,12 @@ struct refs_for_each_ref_options {
>  	 */
>  	const char *pattern;
>
> +	/*
> +	 * If set, only yield refs part of the configured namespace. Exclude
> +	 * patterns will be rewritten to apply to the namespace.
> +	 */
> +	const char *namespace;

Nit: should we also mention how prefix is appended to namespace?

> +
>  	/*
>  	 * Exclude any references that match any of these patterns on a
>  	 * best-effort basis. The caller needs to be prepared for the exclude
>
> --
> 2.53.0.414.gf7e9f6c205.dirty

--00000000000073f506064b7a0970
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 6cf2e46abbfd9f34_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEpCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tY0Y3NFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meFpMQy9pU1VRT0NKKzltQ2V5YldRL24xL1dMa3c0RAp4dU5KMkFOK2Qz
RXVTYm1EYWpPcXF0Qkx0bjlReW51L3BMS1E5bUkyVXBHaFBEVEttRzRlYnA0cG5lQnN6K1dzCjRR
Q3Y5cUlrbFNBT3MzYWRjZzFqNlhHWjA1dWhKQXRNbVVKazdOSHgyOW9sTlFoTWhLMnpBTFNORHZM
aDRXWmIKdkFhSHRNeWZnQWFtV3UveXdDMkR5ME9SdVFuS1djanI1TDNSTUUybDN0dXhZTjRqWDFt
a05NajdxMUt3SmJjMwpFeU5lUURlWWE5QXF3MWJHSE9hRDJCaktzQ0x3Uy9lSERnZFdhSm5iS1Vh
aGpzMy9tdGErM0FNWC9ucURXVmhwCkpHQ2VvQVYrK2MyOWZLNjZucUh6aHl5N3NzbmlzSGkrTVJD
RE1xMXNyVmFOREUrL2JQREFla20vQWlXek1ZbGoKTDhnUkNBUk5pQjdkZExvaituaDhta1dsZE01
dzkva2tqbmJNTnVJVWxKSGhFdFdRM2p4bjJQWnBnRjNLQXRheQpYN0NKTVdKUW1oc1AvTWdGbFBX
dzliNTRTQkl6Q09BR0h6dkN5WDVxdTRSQzVwMzNGcGFTRzFQYUxDUHZobGJqCjIwSjQ5VysyanVO
OHIwdnp5cmk4SDZjdVhCNmlKZVdHSW1ITDlnPT0KPWNVK0oKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000073f506064b7a0970--
