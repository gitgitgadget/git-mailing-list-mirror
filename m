Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793013914;
	b=mzTPhrhwhdLFY2AZbS2ym1naa47OsEzX+hjrSfRaiOp7zEvM7pNymVgZxA3fGJEHFNAD
	 siADk4zplHehtk/YZM5PqPzFOzCkY575ptmaEPNgUNX3gliYjWRAEDh5J/BekN2SmHXQO
	 W6bfYhU8EWH4RwNMWpMshy/TXFmZGQzcgc1i5cjXQ4FSDki9QWO9dHXyqcddjL707uA3H
	 B0SQ1a/RTE1hBaEfQCexX9xbOkfpA+saPUbOnOfKOg87l0JaLtvd3dndzf9kF3YeGD8TX
	 Djz6W81earQW5TnhZqtZjk3zPgA6mlqU1Y2UOZY0kDcN+hQLjq6rZKKEMaCWjKVKw9w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793013914;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Content-Type;
	bh=QYMVwYcxo9i0Kv8TeRzdw/AwrHRhANOny1kOzSonyZE=;
	b=G1yIgl6hgVQ04UFeMbnYrUhpKICl38LgN8GYDCJ11K3g5hHciKmTAbuzNpH0yEtHPSXg
	 +hL2gBy0gy9Bh3B/CKG6EAgD7jYPriPmu16Wj5AIYnrXOGRYyDeuULXgKsre2ztExKF/R
	 BkKaJ6J7vtccBpFZ/qF83GUKpssPCkYEx28Qr1/Kiz9zaX3os+h+vmZqzV1ntnsHeOI0U
	 1D3/ODkBm0M8BGXZEU72wQ8gzoZjuAeRSdOj0iQeGQd1EskyrvyzF+lcJtgzBPwlEJ1M/
	 BILqn/HWtVXdE9LK9xtqPAC7NghBnEVgyATO81ezNc911SL+w3kTUbilLSbqEq9jC2g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=H10lqv20;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.44
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7879606A322
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 11:25:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7879606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=H10lqv20
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-9906034086cso823613241.1
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 04:25:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793013913; cv=none;
        d=google.com; s=arc-20260327;
        b=APkEt2DaeG9sKmcniTpi1BOBpxDZMdJ8E++L176nicBVNeSUZM+HWco6HE9d/yLbYY
         XHLrru3KvuFRw2ZViBgT+qqXXXzbZ3EkhfA/TOoe9W6aJck7PhAbRgE1y521FCIrXFMY
         5hu6qtpbCc/ZIm9yMb304fcbOOT0yGwyh+KDBQjbxkHbQPRyWnof19FA3yCSqq6YuDcK
         TVgtXSZUMsUz/igPc3Qe21HEsILaMs84bL2V6NgMhK+vihs9psQxbp5HQwN6g7yuh1Ul
         Msacl/4jwW7AZTFogrCZeyewjOaplI1g0ef/VNQX8a8CwTjdAWHBAHOBOUsTbK1haGfu
         p2MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=QYMVwYcxo9i0Kv8TeRzdw/AwrHRhANOny1kOzSonyZE=;
        fh=ez/15x2lV8BSK8Zw1IYe2frJKF+i6x5E0KRZTQd8GLY=;
        b=hERcZEK6QEd0/oh8MyX8ybkTxB+1IaG3QgQMQOAvk0hFzem/J+3u4VwqIVn2nACBeS
         zXBe06TyH07evizoq7Coh7Q7/uCdWA2xswFjIR28Z/XYq5H44+M7w6rkxaJDnNOKpfAU
         KxoB9nYHOhVY05j3EF9lb+TG6nF+f/O+dnV/w9R5w76qnVuwX8eEpjHqZtH9Pua1y6hh
         htSBjQZyiLVSGlxBNZSB1mM32G41lx5TL2Yg/qQdqkqSNMVl/6atmfyL0EGv8TFvdgwS
         142ydlXmJ9ref6sn7frqsJAW5FPNCEjetIa/so0vN+SHlf2QsCQG6wda4JnMD1cUlIdP
         I/NQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793013913; x=1793618713; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QYMVwYcxo9i0Kv8TeRzdw/AwrHRhANOny1kOzSonyZE=;
        b=H10lqv20ajxOhdJKtdzxNaKP6teLzH6isYaF31Vdyi9A1JnHLe/kKJMqbaLFdVsEGj
         SAbmgq+IUX1uf2s+Md1I2v0OHgaVjQMiTg/yJqdMZSAe64Ae+AptS/2JG8e65AJmpdgE
         mZ3pynwI96efvFPGllDC+z30VLyhXHMt3wGfkvf/u2WforgDcT++1gfxNCbFighCXnDL
         Lrli+KB57m1EIm6j22bTbpL6opSwjnGqjjLXz9i6aV+9VpuYenREB620ZWwQmxsiQCqN
         Z0m4JOcFQ+4TSP3ykHiHW4aFQ4cpm2IQKsOrLncVjsqnbIYsxPsi6hGHVpvs5mwiywac
         VQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793013913; x=1793618713;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QYMVwYcxo9i0Kv8TeRzdw/AwrHRhANOny1kOzSonyZE=;
        b=y6sbFdjMk2fuXLWcNA2qlkG03b+jWotmIry+oKBXfYWzc073j3x/Z4XLqPQUKeuwSL
         Sp1Qm6IErYRVIytn+N954p9GPXWuPvDn7sBq7McbKpmwCMOF2Cj6iVxU0MPfYkOHNYxS
         ESFCH7QDsWaLOZe8AdKkKDE7CJKqnAb59V+73VUPASnLqSnddrAv1qUwhhuVWEyxq3Es
         m7A+f5Cefiz2BrZQd8CuRr4zZDzdB7NZmB2TpHBWZ7oStxwGkdf6gou6BuvRC7xJV4pO
         8+2b8NbpCa6E8Z8gmQ3gpboBhnv8juEz3KtlNcpPfsVbcrPyoLeyX0MDvRduTem7zrdt
         SLWA==
X-Forwarded-Encrypted: i=1; AKwUvBy6i9OZXoYN6KsBUIsikZNNC4C7bkb5KBRBQLZQQwxrjkitCFs9M351mezXiUVcy1jp10c=@vger.kernel.org
X-Gm-Message-State: AFq9FYL3nIOI3j79IYNXsP0uuO5ZDZ0RxTY+ikQcU1ys1Pnk+XpFTLLr
	w259QsmR9/qlKiCPpFvBkz7ZFxw9KT47EpnyFe6LBnaoyvMeNTTBcEb0yjrkupMzYhYGm4GvfoZ
	rx3i0mhscGzTVhxRn5eWXMErVXFLb0qyHKQ==
X-Gm-Gg: AYBFou0s6h2YSZgKYgQuy0qVCldrRj2uLhireXAf3bwggnXCaBoEbmmi0Q5ToEvso7l
	IYkqTIVgV+IdJq6dcyOfBZT7YoyMiL9ml9tGw++UphLOcTvSI/asFxz/q4lh1IJ9KWBVJbHYhYE
	LQ5YS4dt+ukqL1GXQ2FYr9sXGjE2k/eeoLOKK+EC0V0qNL/FPG/E1g24htkD5wrzUQhn1/EmECl
	g+GQ4rhe8wHf5ARbMpTG5S2wZ0B0p3maJIipnGZrP1JS1XPrhaHa/KW5Evf/6ltEPAiA19k9hNj
	5LTFMtHvLXqER65QC4E3ZVvIK27EhPYJ+us6Leihwev86I2ABysmX9jCTlpHGDpfZDAdKaozYN8
	1xy0LrwoXzpPf15amox3eOprU69kpP72ag7A9htZOne4pE18uPZoFIO3I98YE7D8VdhxeYCjFm8
	ImZQEOLKUrbXmsDR2UnFCbcnP/iwU=
X-Received: by 2002:a05:6102:a187:10b0:7cc:b246:31e2 with SMTP id
 ada2fe7eead31-7ce5cdcaef7mr904506137.22.1793013912581; Mon, 26 Oct 2026
 04:25:12 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 04:25:11 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 04:25:11 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20261023-b4-pks-odb-extension-v3-3-b1bb30a006db@pks.im>
References: <20261023-b4-pks-odb-extension-v3-0-b1bb30a006db@pks.im> <20261023-b4-pks-odb-extension-v3-3-b1bb30a006db@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Mon, 26 Oct 2026 04:25:11 -0700
X-Gm-Features: AclHuK9pLO47vQbz238iSr7FxQO5Ylvgj-m66brzqLLIonLOTx09dugQuj05_5w
Message-ID: <CAOLa=ZTrYBtLOPMh04-J8AkH0797aeKsnXB61H-V8vb1x0r2Jg@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] setup: allow overriding object storage format via environment
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000565a42065ebc955f"

--000000000000565a42065ebc955f
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The ref storage format configured via "extensions.refStorage" can be
> overridden with the GIT_REF_STORAGE_FORMAT environment variable.
> Introduce the GIT_OBJECT_STORAGE_FORMAT environment variable that
> overrides "extensions.objectStorage" in the same way.

[snip]

> diff --git a/setup.c b/setup.c
> index 249bd67876..70aa90a9cb 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -2097,6 +2098,21 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
>  					die(_("unknown ref storage format: '%s'"), ref_backend_uri);
>  			}
>
> +			/*
> +			 * Likewise, the GIT_OBJECT_STORAGE_FORMAT environment

Really nitpicking today: I would drop the 'Likewise' here as this binds
this section of the code to the previous, which may not stay the same
over time.

> +			 * variable should override the repository config for
> +			 * 'extensions.objectStorage'.
> +			 */
> +			object_storage_uri = getenv(GIT_OBJECT_STORAGE_FORMAT_ENVIRONMENT);
> +			if (object_storage_uri) {
> +				FREE_AND_NULL(discovery.format.object_storage_payload);
> +				discovery.format.object_storage_format =
> +					object_storage_format_by_uri(object_storage_uri,
> +								     &discovery.format.object_storage_payload);
> +				if (discovery.format.object_storage_format == OBJECT_STORAGE_FORMAT_UNKNOWN)
> +					die(_("unknown object storage format: '%s'"), object_storage_uri);
> +			}
> +
>  			if (apply_repository_format(repo, &discovery.format,
>  						    APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
>  				die("%s", err.buf);

[snip]

--000000000000565a42065ebc955f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: a7b91b13b1ec8a14_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yZk9KWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mME1OQy93UC94bW5uSFgxc243N0VYdFA3bHNaVFRPWgp0TnhMZnM2VGpU
SzJFd0VGM3NOVXpPVmhkUGxwT0ZRdjAyYUh5RXNHNDV6QmVyRVlOT1EwTHFKeThrUzRWTUdTCjdU
T3E3U0xFSDdTZG9tMHFvaGJPTE1tNmc4aTk2S0UwdzZzWTlycnJNMkwrWHNyR3JoQmVPeDVmUWdq
SW9UdC8KdjJoa2lHbFpRbTZZUjdZUFd1dEN1WUtaSmJwcjU1V1NNMWh6L0syekFLZjN0VjhycmxN
eXk2M3RhbWtROUFENAo2QS9NaFdONjBSZXA1bS9CRHpaVi91SXMwTisrMDRDV1d0ajNKZFJrcHNF
bXhESWd1TkcvdnlEWnpzWkVFTnJBCmd5eVpUbG9GcURxTjdmZG1JNUNRSXJMUklodHRCcVZxQVFh
VC8xSWhzZmxhUi9GZmRiaW1QZHcyT2dud3p5UjUKc2RubXFQdEpQT1Y3dk9PVjVsbzNGVUdpWXZ3
Yllkc1gzdDF3dnR1aTlRQkxzcUw5SmtvMzFYa1B6MS9XMFJxQQpJdlFUNFVRWDEwN0FBNzkzY0F4
MzZ1VEhBdDgxcG5sYjBlYjhGdWpGMldKckpiY2lGd2t6SytyR2FMN1R5NVFjCk9uYzlVczF0QnUz
SjE0aGwrQ2VtRHBuT3BqYlJxNE1xaHdwMHdtdz0KPVlVSXIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000565a42065ebc955f--
