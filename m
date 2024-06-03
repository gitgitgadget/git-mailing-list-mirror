Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61EA74069
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 08:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717404974; cv=none; b=fOR6P68sF1xN2etjC+sVOyelmkp1IxUdS4jydC7LQrajioD4EZjzaH1ijxmZbCMB9gpRaM2Fi8ffLX000ubwqVfdOAM3ZN9AsmtJRWObV3b7GxCfYtjwDLhttTxnTPLsqPrnlju+lnZkQ+XnLxU6AuaDNmYWeANCI/OWCXTSkx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717404974; c=relaxed/simple;
	bh=PvvUWlhDjEmavHPSlbAUXef9RtRMPvb1VWGt7/O0fX0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LNAREJV6GCvqLY8gK6absCtk+3ZeBkxFWbE7zmT5JkwrMbmUkBPINBBRy9kl93jqlDLEX3swwQ7xIEBONCYxzbJn8pmm0vdlhTzE0CpGYUGCBO76GnOK05guuawKXrVHmsDYhTGj8vSCSm+tArINS2xeDph4cVdpNtRBIjC4KJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cVKxFoDC; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVKxFoDC"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5b96ae827d2so1932655eaf.0
        for <git@vger.kernel.org>; Mon, 03 Jun 2024 01:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717404972; x=1718009772; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=heb0U0wOojUbcaNuB8RFl+8fANJ/bwY6oR09d9oQ+Sc=;
        b=cVKxFoDCWs/0VbI9RvwClzKMtMHLSBegZbIzVjTVFaDsh0Z1x3LsQluLy8Y/rXV3F+
         SgKQXWkx0BU86cwIQUsLbfBMbP4F4xTsFCUzA4KXGzPT8tDy/OMc0kBpTviM6Vi/8SFH
         48ISy7I+tZ7MIC/s5az+auAZjlAajgnBRsgdXMgJgpgC8ct/G3u3g3TmZfmsWpM/mS71
         zezYTY7qMtjKJmEcnI21TXLlU/npBC195alVvxQAVedX/n/xcPmhog/o3ZOLbLTq5m/r
         jwvpQeC+EOfR5TGm6pZU7lmRvoFw/UQ0XTfrFwXMxcUxIsU5UvHLjIHPH/tuVgyGYT9t
         C/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717404972; x=1718009772;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=heb0U0wOojUbcaNuB8RFl+8fANJ/bwY6oR09d9oQ+Sc=;
        b=gEkbwjNorr/qraBW9XNZeTj/15yxbGs72DPz+dNREh51wgHjYrV5uGt0pFzHUkRQSU
         SwYvMpQisQ/aZZVldRvphhgX9Fe9tQo2BbnpjKdTSxEg/p13sDyAA6JdTLmysnTCzAAw
         uGnP2+0SAHUhMnTOZRogORB7gqJCSAbpSjQru15L4WF1CIZt8aEnvWkCKPwSsE8N2l1q
         qOOXOVAtttA5xMnIVpuUkoPTcqEqHAAw90kX+23g5aMN0vT9GO34/FOl/SmFsy9wofO6
         0vW9uiuWgBG2Xj5xnTFUkgnpYcGSv8Pf3QR2F69ESBuizchVQsORLuGz9ZS7Jb4rdbHA
         +bIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhF7n+BS5TGK9lDQJ1jNjGOai9dup0iue6HuWTHFknia6XQloVP2ZNXnIv1OU97vboD+o6YfxKQME8wv3A0KCuTLAw
X-Gm-Message-State: AOJu0YyeHYyNlimOX6pINxomnN5bEHukM3N/9Kwl1RPohkJ4sqLf247J
	x/L3jvCanadUTvVQu39VL4nyZaRbvWrMDcNlMisda9QN41PpDefm0/GSwFocrdCLmu0yTCKl6iG
	0Er2PRUEEAkqeSrZBAKT6Hii8Oag=
X-Google-Smtp-Source: AGHT+IEm6Sn5V8Ch0Kh/lwu5b8CP4uvAjwJAQjIalIPxzME+B2SCd/3bGJewaIpjCm4AaukkXFzZDsoF1N0/LSxZlII=
X-Received: by 2002:a05:6871:408b:b0:24f:d9e5:b208 with SMTP id
 586e51a60fabf-2508ad96dfcmr3822279fac.6.1717404971706; Mon, 03 Jun 2024
 01:56:11 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 3 Jun 2024 08:56:10 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20240530122753.1114818-2-shejialuo@gmail.com>
References: <20240530122753.1114818-1-shejialuo@gmail.com> <20240530122753.1114818-2-shejialuo@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 3 Jun 2024 08:56:10 +0000
Message-ID: <CAOLa=ZT895c-ag-8_r7SfJ+n92-S16JfCYgYhQf0caxg63cisg@mail.gmail.com>
Subject: Re: [GSoC][PATCH 1/2] refs: setup ref consistency check infrastructure
To: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Content-Type: multipart/mixed; boundary="000000000000464d100619f881cd"

--000000000000464d100619f881cd
Content-Type: text/plain; charset="UTF-8"

Hello,

shejialuo <shejialuo@gmail.com> writes:

[snip]

> diff --git a/refs.h b/refs.h
> index 34568ee1fb..2799820c40 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -544,6 +544,11 @@ int refs_for_each_reflog(struct ref_store *refs, each_reflog_fn fn, void *cb_dat
>   */
>  int check_refname_format(const char *refname, int flags);
>
> +/*
> +  * Return 0 iff all refs in filesystem are consistent.
> +*/

s/iff/if

The indentation seems to be wrong here. Also since we want to check refs
and reflogs, it might be better to mention that the function checks the
reference database for consistency.

> +int refs_fsck(struct ref_store *refs);
> +
>  /*
>   * Apply the rules from check_refname_format, but mutate the result until it
>   * is acceptable, and place the result in "out".
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 5f3089d947..b6147c588b 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -3299,6 +3299,11 @@ static int files_init_db(struct ref_store *ref_store,
>  	return 0;
>  }
>
> +static int files_fsck(struct ref_store *ref_store)
> +{
> +	return 0;
> +}
> +
>  struct ref_storage_be refs_be_files = {
>  	.name = "files",
>  	.init = files_ref_store_create,
> @@ -3322,5 +3327,7 @@ struct ref_storage_be refs_be_files = {
>  	.reflog_exists = files_reflog_exists,
>  	.create_reflog = files_create_reflog,
>  	.delete_reflog = files_delete_reflog,
> -	.reflog_expire = files_reflog_expire
> +	.reflog_expire = files_reflog_expire,
> +
> +	.fsck = files_fsck,
>  };
> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index a937e7dbfc..0617321634 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -1704,6 +1704,11 @@ static struct ref_iterator *packed_reflog_iterator_begin(struct ref_store *ref_s
>  	return empty_ref_iterator_begin();
>  }
>
> +static int packed_fsck(struct ref_store *ref_store)
> +{
> +	return 0;
> +}
> +
>  struct ref_storage_be refs_be_packed = {
>  	.name = "packed",
>  	.init = packed_ref_store_create,
> @@ -1728,4 +1733,6 @@ struct ref_storage_be refs_be_packed = {
>  	.create_reflog = NULL,
>  	.delete_reflog = NULL,
>  	.reflog_expire = NULL,
> +
> +	.fsck = packed_fsck,
>  };
> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> index 53a6c5d842..ef697bf3bf 100644
> --- a/refs/refs-internal.h
> +++ b/refs/refs-internal.h
> @@ -675,6 +675,8 @@ typedef int read_raw_ref_fn(struct ref_store *ref_store, const char *refname,
>  typedef int read_symbolic_ref_fn(struct ref_store *ref_store, const char *refname,
>  				 struct strbuf *referent);
>
> +typedef int fsck_fn(struct ref_store *ref_store);
> +
>  struct ref_storage_be {
>  	const char *name;
>  	ref_store_init_fn *init;
> @@ -700,6 +702,8 @@ struct ref_storage_be {
>  	create_reflog_fn *create_reflog;
>  	delete_reflog_fn *delete_reflog;
>  	reflog_expire_fn *reflog_expire;
> +
> +	fsck_fn *fsck;
>  };
>
>  extern struct ref_storage_be refs_be_files;
> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> index 1af86bbdec..f3f85cd2f0 100644
> --- a/refs/reftable-backend.c
> +++ b/refs/reftable-backend.c
> @@ -2167,6 +2167,11 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
>  	return ret;
>  }
>
> +static int reftable_be_fsck(struct ref_store *ref_store)
> +{
> +	return 0;
> +}
> +
>  struct ref_storage_be refs_be_reftable = {
>  	.name = "reftable",
>  	.init = reftable_be_init,
> @@ -2191,4 +2196,6 @@ struct ref_storage_be refs_be_reftable = {
>  	.create_reflog = reftable_be_create_reflog,
>  	.delete_reflog = reftable_be_delete_reflog,
>  	.reflog_expire = reftable_be_reflog_expire,
> +
> +	.fsck = reftable_be_fsck,
>  };
> --
> 2.45.1

--000000000000464d100619f881cd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e3cd4d377ae37f5b_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1aZGhTZ1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNDY3Qy85bURmbkhrTk9MT284SkFYWFRnZ09uSjc2WAplV2JXNmp0THF3
UWNvcG9Ed084aGZyaGRuZGFmYU9wK3V6RVB6ZVFieFV4MklmY2ptazZTaW5lVS9wVTIxd0dOCmpV
RXN6NGh0VG91eUN1cjFtRXV5QWM0bklZZjBUVktiQWExVWdMVVlmb05WVTZwc0VKY2N0MmxXeXNt
RE1FVk4KelI2SWhEc25YdU5FOEV6QjZvbW15ZmR5U0pSNzJ3L1R4bDFYMGc4Rk5hZ096b09tMGJT
UnVjS1JOeVhpWFMwRgpnR3V1TEZ3ZXpmRmgvb0dhM1ZuL1VwN3BhQytoRWE2eHRCMkhSQXMwc21J
NFFrRlArcmllYUQ2SWVhOVBNVDVGCldCWThyOThLc2s0ZlIvU1p4UWxHQUROT3VETXBROW9NcnZD
RXZTNTh4bFM4a1NGL2pPRDNycldrUnhnM1lKWisKU3MwMG4yazRpQ21PT3VOY25xRUtOeDlyTUpw
S3lHd1prbkRxWXc3dnZ6WFVmOEJyZjVXRUJMNU5QMjE2TEhTaQphZGhxTG1LZGhMU1ZCam8xb3hU
S2lLTHptZ1JveExsbDNhQXp3d3I4cmJBdldFK3BrTk1YNEl0VjAwektnWnMwClplNWtEd3dzTC9j
b1Q3WkkzcFN5SFF4ZDU3Z3dkTytJN3FRMXRBaz0KPWxpWDgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000464d100619f881cd--
