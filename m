Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B5D2EEE75
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 13:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788527559; cv=pass; b=NbHzXko6zk7TVHZNfK/Q2bfdiI8HvqT7LF0Jiohy4hXCYa50mkweLS1JrrtazEp2F+CtMIyhDWVEl1ofs48li17+g6gEiisaO4o0vvv7+/6LaRmnRx3UnGF5tigAaofU76jh7cS2tute9b1mlfvYG++1579LV//jRc+01wR3xCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788527559; c=relaxed/simple;
	bh=na0d/Rhy+OuywFX/DhoG7loF0RnHKGZz8dH5DpLSs5w=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=hHEfdwfOppoCapD/S7YUYah25CGtoh/I/EagZ48tHjXOHQ1DoFPdxmZ7sX3z7vLFixacq4sH6zIW7mg6SLPO63MNwpWRIPJEoKKN707gkr2IFdR8A/lfgVCjgRCZGAk6llVrnM974kO3frBTj46YUzWQIaexfIZ0VNp/+nGO40s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SxCmMJ/j; arc=pass smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxCmMJ/j"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-97e986f1996so298316241.0
        for <git@vger.kernel.org>; Fri, 04 Sep 2026 06:12:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788527557; cv=none;
        d=google.com; s=arc-20260327;
        b=Sj6FCtEV0g7fngWntKfXJ/MIunWvhTMRNnxuRz8oy0tmVJ/8gpSOQIkbSzlcJYYiSd
         hm0xGL03EH1FCrFvnCPSn8hRnL7BX18ghdehRQ1+jKM/0TBn/uje0at17ynxQlvMmZ3L
         qKyFcHoVaLat1CgtQWv5J0FuMUIoGBva35bF60CV9J6nHgpWYTxgx798+qXmKPQ8JReQ
         O6oEDB0XuxAqnjS2WVS2n/FFgelOpDSYwiMfhwiiSaZw9Q/8DS5oyrAj68Z0pKuxlsTY
         ziJHzoA/Kd7alBe5WcksP6I3GFoKvtWk1qVLyRiASi1OKRE7HcvYFELm9oTvULTTWOH3
         m9Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=THSm+DHKZJN2CsKv9s/h9u0Y9DY5qEDcluYcExZJZSI=;
        fh=YoXfyQqEPOuZBbujubIberArLJXchVeKdjv0XxeQrC8=;
        b=SYU05+z++dx4xCAdTUjjLA4g4PknUH/ORi7aBdeIuNAUzXCxm/CXPeZNB+O+Pz6a2U
         SSAnmbKHGsGBtyP3s+8PzdCcj88yAa26OnGD7dhrsFitE1/yjPuPrxk3yEpQUG1JfZDJ
         9ubpzDn2rN9KEM9pzzW52cg3pUZirikVbGrZLP2ZsA08TfVHv6rPmdDKy28UKtEYzNBD
         N5FesWv8S8/fx9/jByGWaeURhpC5jKK8XRZaRFZNlERMxd57X614ucP+7D/Ljlp1PgSd
         XK9psdfB1XWZVVrXcH7a7zZwCbKxbG5w0pKWmiuCyfIm96ZVJbjmkAv0BJRmU6fV491D
         u2tg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788527557; x=1789132357; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=THSm+DHKZJN2CsKv9s/h9u0Y9DY5qEDcluYcExZJZSI=;
        b=SxCmMJ/jmubcSib1L8V7+HZuJOYVxovtD5vHicW74/sLZs2ABfTF2vU8rhDFfazzi3
         ufVp/GAzJf5P+POWc1jR1Yvx1ukix3QxRGw4nGOWXT/uIhMlwXXDYvugue9wFeHStvzP
         G7dOdke9JsFr/M/wpJtFXdk7QOoKJ4HZgnV27OHXwSLdDEyDcncVL0o+5mi8qDEivKtS
         CcrPI8Cq5i7oZyVoXycaV5dYYxcOlNLpqAT/5JdlRDp5WI7PfeBIp20XwbFjoRNP9eYG
         GXkeBbf0g3w5MSvk+iqSVhwhKHzeMcIh05gz6IXPfbZW/faKiGvHoImpwDz6U6YW+Sfa
         nzlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788527557; x=1789132357;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=THSm+DHKZJN2CsKv9s/h9u0Y9DY5qEDcluYcExZJZSI=;
        b=I4mdldDmtaa8AXdzx8ZDZoK4WmijfTP01P2U0DKV24b0gnUSLNsvBDY3e2FYFtvRBA
         vgUwq+wiwpQqAwBw+88gTNMU75XEmcM26uMEWuAMfQ8jq7OaOtAXHLO370lrL4KuDby2
         ENlI3v+d3mWmb+s/CAqobQvZNz2zPtXDVNo47Shwim2bEnQ8RNghaAnlMjzgF9gdXlp6
         +ZBsgaQRdzbgs7qfQMI9qE0hDUWUzx5FnEsvQGReQ42RWJdpUG0/BM2mwVUiFiNSXK0j
         Xdc5feTeYVEG9ZZjtdu9hvcGiXxlQqIHHrcoafXcnnQ0o5eGLbLUYDu3cr12ThEKqLtA
         UfAQ==
X-Forwarded-Encrypted: i=1; AKwUvBybA757T0M4NetHmnLQPUXijK09jmKcgldH6WNwkBmmK2F9AyjxUybfWzznznq4i+hX9X0=@vger.kernel.org
X-Gm-Message-State: AFuF++mOcco5+4Wm0jdXWYiA/Q55ULdLjRYcGuPROCSAyFDRSkxqHDoK
	/6go1OUTp8r6lJoKyzEPLo4V8ChJTjdKegzru+T67NLMKOs2lyA46AAAcRAtBKGrVaqwFBMklzG
	eDuYorfrHay7ifN2xwEdw9wLpEyJa3HRJFzZ2
X-Gm-Gg: AYBFou3Zh/wBWEYSmRcoq5xliD4o/lASiHTjxdZaazL2B9iR8c9EP1U21xC+EnUTu3L
	PN4lOPj6M9pfnJDea+zNmZLICRMf9TcXZHeYTlLuQddArRVJ76grZNc5MZgkucxgLomYVRnNkyW
	gp2q5LZWzcy3VxHJhzP66kSPKAFgrUdO/drfwZUzB1V+KKQmxMOM1TqT7Mh78sgH0ATN9RyO1pF
	IBUPbCnuu7/axr7Efv3F3dIrdMXaR1tYeX6kad1ifOnbuE4r3i3/0zfaxB7WcZC4xdEGyHiVwas
	Tq3gfI39cpiQphbNkOBrO7PijT57g7O6Q+LXQ3nvCbG4KDmpiogvKczUdxYNK1FnuSeiHZAb6Jc
	+52n2xIdzhl0XOCnZWXWreP5kyliaGAidnGQ=
X-Received: by 2002:a05:6102:160e:b0:778:5369:763d with SMTP id
 ada2fe7eead31-78a4a6df1c0mr1606591137.1.1788527556583; Fri, 04 Sep 2026
 06:12:36 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 4 Sep 2026 09:12:35 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 4 Sep 2026 09:12:35 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260904-b4-pks-unify-ref-storage-format-v1-7-08144e5004ff@pks.im>
References: <20260904-b4-pks-unify-ref-storage-format-v1-0-08144e5004ff@pks.im>
 <20260904-b4-pks-unify-ref-storage-format-v1-7-08144e5004ff@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 4 Sep 2026 09:12:35 -0400
X-Gm-Features: AcwNN1VHZEcRT3BSZv8brEuD924l4qA1oFw4yKkXtK1WECSQ78DeQjTIbP4B7rQ
Message-ID: <CAOLa=ZR3xtwK_EzxjaOc0qN0oE51oDaKk4UMBTJqP+g+exr-Dg@mail.gmail.com>
Subject: Re: [PATCH 07/11] refs: expose function to parse reference URIs
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000ae809e065aa80562"

--000000000000ae809e065aa80562
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> In the next commit we're about to add more sites that want to parse a
> reference backends URI into a format and payload. Expose a new function
> `ref_storage_format_by_uri()` that enables this.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  refs.c  | 23 +++++++++++++++++++++++
>  refs.h  |  4 ++++
>  setup.c | 48 ++++++++++++------------------------------------
>  3 files changed, 39 insertions(+), 36 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 92d5df5b71..951db56113 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -54,6 +54,29 @@ enum ref_storage_format ref_storage_format_by_name(const char *name)
>  	return REF_STORAGE_FORMAT_UNKNOWN;
>  }
>
> +enum ref_storage_format ref_storage_format_by_uri(const char *uri,
> +						  char **payload)
> +{
> +	enum ref_storage_format format;
> +	const char *schema_end;
> +	char *name;
> +
> +	schema_end = strstr(uri, "://");
> +	if (!schema_end) {
> +		name = xstrdup(uri);
> +		if (payload)
> +			*payload = NULL;
> +	} else {
> +		name = xstrndup(uri, schema_end - uri);
> +		if (payload)
> +			*payload = xstrdup(schema_end + 3);
> +	}
> +
> +	format = ref_storage_format_by_name(name);
> +	free(name);
> +	return format;
> +}
> +

Okay, we move the existing code in setup.c to the refs.c and clean it
up.

>  const char *ref_storage_format_to_name(enum ref_storage_format ref_storage_format)
>  {
>  	const struct ref_storage_be *be = find_ref_storage_backend(ref_storage_format);
> diff --git a/refs.h b/refs.h
> index 9979446d15..ee3b8a62ef 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -17,6 +17,10 @@ struct worktree;
>  enum ref_storage_format ref_storage_format_by_name(const char *name);
>  const char *ref_storage_format_to_name(enum ref_storage_format ref_storage_format);
>
> +/* Parse a reference storage URI in the format "<format>[://<payload>]". */
> +enum ref_storage_format ref_storage_format_by_uri(const char *uri,
> +						  char **payload);
> +
>  enum ref_transaction_error {
>  	/* Default error code */
>  	REF_TRANSACTION_ERROR_GENERIC = -1,
> diff --git a/setup.c b/setup.c
> index dfe05d9a03..3be7dac452 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -632,21 +632,6 @@ static enum extension_result handle_extension_v0(const char *var,
>  		return EXTENSION_UNKNOWN;
>  }
>
> -static void parse_reference_uri(const char *value, char **format,
> -				char **payload)
> -{
> -	const char *schema_end;
> -
> -	schema_end = strstr(value, "://");
> -	if (!schema_end) {
> -		*format = xstrdup(value);
> -		*payload = NULL;
> -	} else {
> -		*format = xstrndup(value, schema_end - value);
> -		*payload = xstrdup_or_null(schema_end + 3);
> -	}
> -}
> -
>  /*
>   * Record any new extensions in this function.
>   */
> @@ -689,16 +674,13 @@ static enum extension_result handle_extension(const char *var,
>  		return EXTENSION_OK;
>  	} else if (!strcmp(ext, "refstorage")) {
>  		unsigned int format;
> -		char *format_str;
>
>  		if (!value)
>  			return config_error_nonbool(var);
>
> -		parse_reference_uri(value, &format_str,
> -				    &data->ref_storage_payload);
> -
> -		format = ref_storage_format_by_name(format_str);
> -		free(format_str);
> +		FREE_AND_NULL(data->ref_storage_payload);
> +		format = ref_storage_format_by_uri(value,
> +						   &data->ref_storage_payload);
>
>  		if (format == REF_STORAGE_FORMAT_UNKNOWN)
>  			return error(_("invalid value for '%s': '%s'"),
> @@ -2069,16 +2051,12 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
>  			 */
>  			ref_backend_uri = getenv(GIT_REFERENCE_BACKEND_ENVIRONMENT);
>  			if (ref_backend_uri) {
> -				char *format;
> -
> -				free(discovery.format.ref_storage_payload);
> -
> -				parse_reference_uri(ref_backend_uri, &format, &discovery.format.ref_storage_payload);
> -				discovery.format.ref_storage_format = ref_storage_format_by_name(format);
> +				FREE_AND_NULL(discovery.format.ref_storage_payload);
> +				discovery.format.ref_storage_format =
> +					ref_storage_format_by_uri(ref_backend_uri,
> +								  &discovery.format.ref_storage_payload);
>  				if (discovery.format.ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
> -					die(_("unknown ref storage format: '%s'"), format);
> -
> -				free(format);
> +					die(_("unknown ref storage format: '%s'"), ref_backend_uri);
>  			}
>
>  			if (apply_repository_format(repo, &discovery.format,
> @@ -2806,18 +2784,16 @@ static void repository_format_configure(struct repository_format *repo_fmt,
>
>  	ref_backend_uri = getenv(GIT_REFERENCE_BACKEND_ENVIRONMENT);
>  	if (ref_backend_uri) {
> -		char *backend, *payload;
>  		enum ref_storage_format format;
> +		char *payload;
>
> -		parse_reference_uri(ref_backend_uri, &backend, &payload);
> -		format = ref_storage_format_by_name(backend);
> +		format = ref_storage_format_by_uri(ref_backend_uri, &payload);
>  		if (format == REF_STORAGE_FORMAT_UNKNOWN)
> -			die(_("unknown ref storage format: '%s'"), backend);
> +			die(_("unknown ref storage format: '%s'"), ref_backend_uri);
>
>  		repo_fmt->ref_storage_format = format;
> +		free(repo_fmt->ref_storage_payload);
>  		repo_fmt->ref_storage_payload = payload;
> -
> -		free(backend);
>  	}
>  }
>
>
> --
> 2.55.0.1007.g17ff1f9808.dirty

Then, modify all the call sites to use the new function. Makes sense.

--000000000000ae809e065aa80562
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 66f0f1f3e600b03b_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xYXc4SVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNFR5Qy8wVUlRZWxmVUVhNS9mUmJYaDFSZUxzKy8yZgp6MEQ3d0pTL0Vv
NDMxOEF2OUN5WGpuVFJFMG1SVFBtQjhsRlB2TVR1ckFZUXRZaktTL0hzSEJ1UHJvQzBPOFd2Cmpr
SXFpcE1jVmd0MzNJNy84Rzl1QTNGN3ljUmwwVUw1MU1jcXdvd01tQUYwcEgzbFd0R3l0aldQUk5T
NmlKQTAKaWk0QnZXVkgvWTlQL3VhdHVJNFB0c2YyTVBmOWdyTWdDY21MNUtpZHA4MDhpeThTVGp6
cnlPcCtUam93NWI5SwpSMUdWaXpuOXphU0VFeGJuVDN3NElJdkE4cDdZWXBNbEtQQVcwaDRRQzgr
RUdiMGhVdlVFRUUvTm5QL2c5bVVuCk54Z1QxT0tKR0k1a1JyUXpUSjZ5bmR2SVMzWWJGQjVxSzAw
bmk1VWNsajVmdzc3bzBkK0dHNWRhZ2w0bkFGdWQKRVQ2VHhFNjF3bE5VU1lMUUs5aXZ0anpVZ3h1
b0FmbVVpWnpOeFo5SjBXQ2tES3M1enBVQk9Ha2p4VUZmdTYyRQo0MGxvcWJWdkxrQnhzQ0hEMmtI
ei9VbE01bmh3TFUyS1ZXVFIwd3VOZkxxNnp1Wk9tS2VFREpMTll3K0FMK3RSCjRZWlc1S2U1aXFO
THFLeE14c0NZb2NRSGJ5RXZiTWRrK21LOGxOdz0KPWhtcTUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000ae809e065aa80562--
