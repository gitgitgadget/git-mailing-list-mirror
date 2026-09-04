Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143282D73A0
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 13:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788527123; cv=pass; b=hxahjF5ztshDxEX5hU8tFlxjehOoMCSrQYSN0MaKAIZwleNIYodyswOAP+TkmA5RGQHK7dN7GMRdRY0yMSi5vtbaqLRQGY7kl1uOIoE5STlt5mPYXeMNIpAGamlnUuksOMWU73S7u0rRdJ3W2wF+P/JpOscbZd5ExZc8c38fCCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788527123; c=relaxed/simple;
	bh=9tT8R/AmJc9AccVFoR0SC6p+3i6AREVyaPxUMWVrjz0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=sm17UVnyt1KdSNwOkZJIvWf76j+SIRievKHxGG5gwEB1ROy+Lo7Dyr5z4rYMqbgwc+LxoBxigsXWxS8PK+WeKBXbYf6s8ycsplQUP3OFccqQu5VJlu55tjM5xXTR/TAaJ5/Fqsk3h/o9Zd46xkAZq0knHwfKnHNxLOpy6KCiumU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DsOc9Izl; arc=pass smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DsOc9Izl"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-782af6c753cso963085137.3
        for <git@vger.kernel.org>; Fri, 04 Sep 2026 06:05:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788527121; cv=none;
        d=google.com; s=arc-20260327;
        b=qpehr4zM0F5f3MoV8cigrnJBWYMxwWOB0Lm1ES6jlXFiLS8/e7OCi6qOw+rsSeKAuu
         /oUZkSXE7ZRKD87WGAb0I8olg2GxkhLetZsrdNCM4XT0Ly6T6Oz5Dzwmzpf4grOPYHN4
         5JN383GM0ju+0Rs7ebd+oDuDeHAc/ybQkkxRsrXQ3AO220y1j1ckrGTHywiw0k/j9Fp/
         Kaup3TikzpQkpTjVzqUVJjiHDElbGPCvmkVjNc1/3CvoJjm7i8sJxNRHPbqv25OswUI0
         te6kj8ggxBEBZ43V2lPisD2PSm1m1873XOKc9cl/cFrhCEBp0mVxbTyNSqtgC/D4laQL
         cmVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=wbrK+/ckowjenKibpOBHDJc2LjTkqUl6AE9K4mh5emI=;
        fh=hVHT3MgKz0qiUfp0H9ZiWAps/Wo9m/QSQFJdyo/fSe0=;
        b=YXySPsLYb4DkCngjN6qmMellZ5kdZrdr2XtEOEwf+chZ/1jJ20pS7BXlSQrSY8iGsA
         KhmD/2feiOmWMYTR4Gqt1W3frSB4ASdChb50cyACTAup4TWNN0I3duqSlTSn1m8rMAQS
         vP8ThcGR6wPN4yoXQ5cChsxS5cKqEKr3DCEFQFdqjIpSMc2qqPpxxgoLNpUcMAzlRGGk
         M902okgNTLBkCL7Szmo96aLp/lsepM8T9cSLSZ4NWq9HVjn2H995K2u3QOh0jAItmK9d
         GvWRVZpjE47rI9PLzk4eb/M6ef6ZjvppwY+bPOsPEFVbvmTpC0rBsQBt0Zgu4QHBvTnW
         mK3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788527121; x=1789131921; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wbrK+/ckowjenKibpOBHDJc2LjTkqUl6AE9K4mh5emI=;
        b=DsOc9IzlHQ2/p+sJlsf7JdSbpTiiHmfmlv9Jm2kLBgGnv9x8hqFm6A+mCnoUNtqiL6
         Lodd0IxWkXCeZ068Z2Y1bg275NuqGH/sL+ZDgdNFosGFJj7uNs39lMg2B2py7i6XLy3j
         onV+rRWKegi6WZ2xmgO9eqqjiC5oNKRhWE7YmGaVOoJuqURpxU7ORunhXZ/v3FXKt3Xp
         5/fIEbaNfPkFyrKM5bNNt4FVRH+Am99Llz99CYY4q5fDLetU2k9sxR6FXL+UqIXromeE
         UMAtSlda1aos9QSDxywGkUiJ8kggwQ1kLQ6Kkc4hu/PSjZRutGwM3CRGZkR2cyB5wCpV
         STUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788527121; x=1789131921;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wbrK+/ckowjenKibpOBHDJc2LjTkqUl6AE9K4mh5emI=;
        b=FiDvYjxZ5oQEKFNiaflEnunPW1Hei4/Y9yTY54wzdAT4J1lGtn5SzJNActruqzDdc2
         z7NFZc0lg1WCq/gEuYFLa2wpl+pE/xKbm6kIourtIdTfp15Lp+o+LSbMNjTgAr3fIj1z
         FJaGNpWp94wbkNCzzv5lzyxZWQs1xY1FGv95Dlqtq/verei35kuhm1pvTwviq8IoYNCK
         QHKZ2smbW0ChXLOsJyhKZrT0DDGM9CfYer6N17cCBxwLdBMoLwFlHX6Xr7Ailcb4eLrT
         2abfmw2lJbHlmtSxTBf4/G0px8u6YgvNRfXzK9AJr6EX/QBl/dnFKapJlBVCH+4lAICQ
         lHfQ==
X-Forwarded-Encrypted: i=1; AKwUvByKcQ8zxyE9QVbjeizaU4Y6/jFx9XbTklIUeWFQDNfOAbiGX3VbgvRf7VfOm0pSkxe0X8Q=@vger.kernel.org
X-Gm-Message-State: AFuF++mkZjOgqhba3b3CkoTjIP7tfO4yU9aMrbPRT0F23RErUra0Wt8l
	ME41Gjp4F5EsH4YOVyKlVlOGzm0pZgYVeIV2MzpaL4v2giLIeZyHLSnskH2D8T0PdDabwWgpTrF
	n2yFSGT69Q1EA+H7t0+mAqqPV6bcf3oU0Ef01
X-Gm-Gg: AYBFou34lmmTblBZblzKl+9QURQW2LzzeSEzfIStsmuB+AP8W39JLvVWWRIcKh2wpwa
	bHqY6XXT6cFZz+GeMX4yrKsIAEYTMAPqqZWD3p79/I37dbDdiedMeuiHeW1OClSIK3oUTzDt7DC
	d+lk+wUAME2mTMD6a7KkgDbF2Bu/D9JORQQBrUUAhLdpDSVs0FrlQXM4zMXyvIjdTRsu6uzh3FY
	0zDoksNYbMCVPwKEni8V55NeOqrLN6vzFCg9C0dPUV+Hz4VIMXAnmCJ0GTbmic5TOtZf8RVEDyb
	Tsu4JayfQyWCOxOR8rUsTHPOWCPnZBVFjK8oYsAGyygi3rnS5DFJBMyi1sm3O3niwiY8ud0FS82
	CRbksAgI8Zvr2kPfPhNzUKpr5HY4lLhBWe7Y=
X-Received: by 2002:a05:6102:1481:b0:784:b9ec:9144 with SMTP id
 ada2fe7eead31-78a4a9c3a45mr2163766137.8.1788527120891; Fri, 04 Sep 2026
 06:05:20 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 4 Sep 2026 09:05:20 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 4 Sep 2026 09:05:20 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260904-b4-pks-unify-ref-storage-format-v1-1-08144e5004ff@pks.im>
References: <20260904-b4-pks-unify-ref-storage-format-v1-0-08144e5004ff@pks.im>
 <20260904-b4-pks-unify-ref-storage-format-v1-1-08144e5004ff@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 4 Sep 2026 09:05:20 -0400
X-Gm-Features: AcwNN1WZkV6Mr4Ww0ARPratLRsf_VfbgZ2u7ImYE0r5s6a-8f-ZwvCBpCW_Q8Gk
Message-ID: <CAOLa=ZQO05kg6ekVJf-0Hkmq8rMVQuGox6O7DJL6mMTRA7_HLw@mail.gmail.com>
Subject: Re: [PATCH 01/11] builtin/init: rename "--ref-format=" to "--ref-storage="
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000b67815065aa7ebf3"

--000000000000b67815065aa7ebf3
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Back when we gained support for reftables we of course introduced the
> ability to control the reference storage format that is used by newly
> created repositories. This infrastructure has grown over time, and
> unfortunately without consistency:
>
>   - The command line parameter to specify the ref storage format is
>     called "--ref-format=", while the corresponding repository extension
>     is called "refStorage".
>
>   - In most cases we refer to the "ref storage format" in our docs, so
>     calling it "--ref-format=" is being inconsistent with them.
>
>   - It is possible to override the ref storage format via an environment
>     variable that is called "GIT_REFERENCE_BACKEND", which is not even
>     remotely consistent with anything else.
>
>   - There is also an "object format", but that format does not control
>     how we store objects but rather whether we use SHA1 or SHA256.
>
> So in summary, it's a huge mess.
>
> This problem is about to become even worse though, as we're soon going
> to introduce an object storage extension. This extension is the
> equivalent to the ref storage extension, and of course we also want
> users to be able to control which object storage format new repositories
> are using. But we cannot properly name that parameter without creating
> even more inconsistencies:
>
>   - "--object-format=" would match "--ref-format=", but that parameter
>     name is already taken to specify the hash function.
>
>   - "--object-storage=" would be a good fit, but be inconsistent with
>     "--ref-format=". Asking the user to execute `git init --ref-format=
>     --object-storage=` just feels extremely awkward.
>
> Instead, this and subsequent patches will fix the mess by consistently
> referring to the ref storage format as "ref storage" throughout all
> options, environment variables and config settings. This new name much
> more closely indicates that it is about how we store data and finally
> brings consistency into this area. We will keep the old names working of
> course for the sake of backwards compatibility.
>
> Start with git-init(1).
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Documentation/config/init.adoc         |  2 +-
>  Documentation/git-init.adoc            |  4 ++--
>  Documentation/git.adoc                 |  2 +-
>  builtin/init-db.c                      | 16 ++++++++-------
>  t/perf/p1401-ref-store-tombstones.sh   |  4 ++--
>  t/perf/perf-lib.sh                     |  2 +-
>  t/t0001-init.sh                        | 24 +++++++++++------------
>  t/t0610-reftable-basics.sh             | 14 ++++++-------
>  t/t0611-reftable-httpd.sh              |  2 +-
>  t/t1400-update-ref.sh                  |  2 +-
>  t/t1423-ref-backend.sh                 |  6 +++---
>  t/t1460-refs-migrate.sh                | 36 +++++++++++++++++-----------------
>  t/t1900-repo-info.sh                   |  6 +++---
>  t/t5510-fetch.sh                       |  8 ++++----
>  t/t7424-submodule-mixed-ref-formats.sh |  2 +-
>  15 files changed, 66 insertions(+), 64 deletions(-)
>
> diff --git a/Documentation/config/init.adoc b/Documentation/config/init.adoc
> index 7b4abdaf8b..9c78440192 100644
> --- a/Documentation/config/init.adoc
> +++ b/Documentation/config/init.adoc
> @@ -15,7 +15,7 @@ endif::[]
>  	this config.
>  `init.defaultRefFormat`::
>  	Allows overriding the default ref storage format for new repositories.
> -	See `--ref-format=` in linkgit:git-init[1]. Both the command line
> +	See `--ref-storage=` in linkgit:git-init[1]. Both the command line
>  	option and the `GIT_DEFAULT_REF_FORMAT` environment variable take
>  	precedence over this config.

[snip]

> @@ -83,7 +83,7 @@ int cmd_init_db(int argc,
>  	unsigned int flags = 0;
>  	int bare = startup_info->force_bare_repository ? 1 : -1;
>  	const char *object_format = NULL;
> -	const char *ref_format = NULL;
> +	const char *ref_storage = NULL;
>  	const char *initial_branch = NULL;
>  	int hash_algo = GIT_HASH_UNKNOWN;
>  	enum ref_storage_format ref_storage_format = REF_STORAGE_FORMAT_UNKNOWN;
> @@ -109,8 +109,10 @@ int cmd_init_db(int argc,
>  			   N_("override the name of the initial branch")),
>  		OPT_STRING(0, "object-format", &object_format, N_("hash"),
>  			   N_("specify the hash algorithm to use")),
> -		OPT_STRING(0, "ref-format", &ref_format, N_("format"),
> -			   N_("specify the reference format to use")),
> +		OPT_STRING(0, "ref-storage", &ref_storage, N_("format"),
> +			   N_("specify the reference storage format to use")),

shouldn't we use 'ref-storage' for the argh value too?

> +		OPT_STRING_F(0, "ref-format", &ref_storage, N_("format"),
> +			   N_("specify the reference storage format to use"), PARSE_OPT_HIDDEN),
>  		OPT_END()
>  	};
>

So we stay backwards compatible by leaving the old 'ref-format' as is.
Makes sense.

>  	int ret;
> @@ -173,10 +175,10 @@ int cmd_init_db(int argc,
>  			die(_("unknown hash algorithm '%s'"), object_format);
>  	}
>
> -	if (ref_format) {
> -		ref_storage_format = ref_storage_format_by_name(ref_format);
> +	if (ref_storage) {
> +		ref_storage_format = ref_storage_format_by_name(ref_storage);
>  		if (ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
> -			die(_("unknown ref storage format '%s'"), ref_format);
> +			die(_("unknown ref storage format '%s'"), ref_storage);

Funny that we error'd out with 'ref storage' while the name was
ref_format.

>  	}
>
>  	if (init_shared_repository != -1)
[snip]

--000000000000b67815065aa7ebf3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: cfc144129aff282e_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xYXdnNFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md3RvQy85Qjl2MC8yeml1bjVlTlVoTmIxZ2pRV29EZQpKcHgxQ1hwTklT
ODFKT2dpbW1ldVFQeVhEdCsySjRDUHZObDdqU1huYmxEMG5haFZqRExZKzlkR2dCV256TnArCjQx
cFFkejFHYnE3cXhaN21uSUZDVlJNNEhvVHkzNDg4YmdHZ0lPb3Z1MUlpdEpmTExmY2JoSTFoMmdR
bTNaWVUKMXhwOWF6bzFnTnQ5aTk3N01BRWZGTXY3UXYySi9RQmdrNCtickkxYU90K0pmQ2pTVm9t
SnZHOFBiUnkrSEI4Kwp4OXl4Mll0Mk1uamZpallvY0JhbkFIdGJLeHhPUnZiMW1OWUVmMng2NEJR
VXFOekFZTE1UaStsbHBWZ2ZJazlHCmwxaUJNZVM4SmpFQm9wc0FzSnBZalFBQTUxOTFqNlpXNjhu
dFd3R1NDajhLUFVpeU5jRGFETXhyalBpeUk2bzUKRS9Nb05KcFRwMXlZUG14dlJrLzVCcE1ETENt
QmxJMDNyNG95c05CUzYvTTMzbkpRaHBUbURHTWpHVWVVYXFPaQpwQVY2MHRkeDVOWjRuQ2lrakdk
LzcyZDZnVVpzME42M3JJbGc4QW1sOWtHam5lL0piUTJJOVh6VS82UHhHa2g3ClR1NmFUTG1OOWM0
R1ZLU3RZbTNYdW14bFZsdEV3cHB0Y043TVpGUT0KPU9FaUMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000b67815065aa7ebf3--
