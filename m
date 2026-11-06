Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793965480;
	b=ikmupVqMHxDI6sHp5DBrv8ij8BcGpcd1KseTNDY6WQf/8wBNU/+qoOClmbmCGdHA0o/P
	 z/jFcEA/WH7vUv9sdJvE9bCFOpDxytSU+SHm35EMJn6vGQPhvFDo+RMikmYtA19ZsmM7u
	 OapaFQ06opVIL32roI54rCkypmC/WtLwM6sErJVvR+QpzKeAYedPRuSoTH2lECw5hJGl1
	 NykY5Zuhav3kplb8ALtAsyfEiax9L/b5SiCS7AOG6oEqY3h05TrJn4bVe8cubv79KmBHd
	 x5oCx3fF4WKJ1ALlZmzp8pj5qMGE9h3u6McN3dqN+1pCDZ3JEG4T4MH1TaFD82Xmyvg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793965480;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=jarBhV1azawxRht0LiMXgtnNlYdCeb2BsKKsnAZ91+A=;
	b=08DU50z2tuozLJ7MkuxHAbbAB0QKi5EcxIIuThPbA3H2a4tVNN87U1Y71jcYeIp3/iLy
	 lWlBIlo70UIAW2QLVKsiKsZK6FZgFLpDuvsh5QSC3XtQYWkgZo/brZB9UgEZ1fhNDc9+w
	 fbB8sK3XmquGLNjR7ZnTS2foIhCo+VLkGTfRWzik9xnK42+IfTKsJnjmc0Dm14LHCSoFB
	 4mDYPlSBhWFCYr/hOVJGTKsASxKc0A52fmhbavKzCm10geyzq1bKcvMk35QFsm+V9oqeY
	 o/vJvTBf9/7TFLCGPH0hPObUiu2mZfyCv9mEDkhr4RqGIlWH6ZAeK5+s8cqfr0bXyyw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Nu36T/gE";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.43
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84911606A936
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 11:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84911606A936
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nu36T/gE
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-7ce645a1c6aso377683137.3
        for <git@vger.kernel.org>; Fri, 06 Nov 2026 03:44:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793965479; cv=none;
        d=google.com; s=arc-20260327;
        b=Pd4e7yg7J/zNWfCiYd+4nYF/uhqkwui7zQLofkz2kwNUrnFQtnI/bZCDcNDrzA2LeU
         Ks3OnR6grdGPXGOkIKk4x7eYMZU1Zhf9gzZm3dxBFVuS5sSoVhIPl3qFNQdZkBUZiFaD
         Ds6qgGTIoNRBq00ojI4wB/qZiLQ7Qp4NY2/V/Xa/CpTS7lsfNoLa88zHHDo+QWtc+WEG
         As1JMIWvQ/ACc1s2F7KCW7RKVsn43BC5PWIztRbTnjnJJ4ZWWff/mxs81Pz1BAyrt057
         xG4i0eF//FyqGiv84pFaxZCGmzuTBv0Kvtf7PJCaP8f2yp7oipQi9RW/dpma0oqfqOwW
         Nkvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=jarBhV1azawxRht0LiMXgtnNlYdCeb2BsKKsnAZ91+A=;
        fh=tBjl88AaUH5jjawRuBKquDE3KpKVQqDSSspko7Pia4k=;
        b=Xls+ycH6jVlOxeDmtIYkddwcV7hH50+0mgHNR2TAgo5adkdNSeDu+UtABpkGZM80F7
         DnbshKuzU4aPuCq2op4eiYGBeNaVrvG8LQ6KVJ3M2B5xy62IVGxZ1vggypIHst14GyWj
         9o3h+cd12ghQd1OxJY4FwH2RADXKwIWE2l3qroWfpvoU9juezRaHL/qRXVo5Pj/7bjK/
         J2nIxg7Ln6s1Tbgjn5b+/+jl1eFA/awcn15TwfP9COkj4EWRAJ2N6epsppd/wCmtwnM/
         C1LUtedKrdgfXB1iH7ecNDDqAhyfwfKqYt+vjYs0fSyxnop27hNpforMq5QeP8ywgHN+
         QWAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793965479; x=1794570279; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jarBhV1azawxRht0LiMXgtnNlYdCeb2BsKKsnAZ91+A=;
        b=Nu36T/gEQBx/XG/3CNiam2XhFf08eJc9J80u5a6l9EPyID28qiQFlCl3Dpz55pIZP2
         d2rrJ0i/MnRnHzHFuKb2kiQfKCmYk3aKgIHMs/5fr2bqfcgg/dVlAPPMpNHoFtyJWvQO
         W7VZlWl/dBfVS4WVxSIwnxAZ7Vq8dec3AOai+BAAJT8eQg8IBzCVr2fJn2LzFzBF2D8B
         x/GYDFNutEHEAJJ/JapdXo8fKmh+W9oYBCHZyvJUGngUvo6dmBAEw+95apH25pkFcmi4
         kqod7f6TS0UtRQ1IIFbhNU6CSIdQ771VRs1XY44VE0zrR9s3I7MmPOGqCJwyRA9Z9RdK
         QW7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793965479; x=1794570279;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jarBhV1azawxRht0LiMXgtnNlYdCeb2BsKKsnAZ91+A=;
        b=NYp9Z/sfSXc3mPnDVkWxE4+aZZ+a/kJ/YtKmueAD946sZfYYn2My4khwQKuHyE7jKx
         pfhpK16dDj/0yz8sGcntXQn2MYAoPgTPkAvLNsAjSgVirSvcsB6aigDUzb+/rebqO+ku
         UaNr+bEzSUwoLjwRewsTzflRkprz5X/5Ik+EBg1Tn0YVcNqWLdAsaRFonJDwtZj9Ln7q
         UAdwu3qUxp8y8cl+Dq85k3+uN06fYetV5JMtPUGfUgqQVtIgmcMQ54HXBdBvnY2YlBAC
         /LxbERAM26eG2wLm/9Q281jc0VI4XyMYAiFVyc4LoKi99ycXGUiWJoP9Uitn0F91UYBW
         mR+w==
X-Forwarded-Encrypted: i=1; AKwUvBwOuq6tLi61jQDrCWax/sx6tj86qze9A0ByyrG2HX2KEBn7cnI77KDO3FW+q5O6XStsszU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+DUxHFnQ96TRB2Da7ueycn8WPXGMscQ5g97zZBtXKaFgyh1IG3
	DcOjwyX1o0gkCVjk1QBymIZAKS7hq7yBcsAFpEpnIJbDscVShdLHZR3WH+RD/2oWns6o8JHT6Pa
	DpQ5yyvZ4ZKYqJWKRDmjqqk2GeaVah48=
X-Gm-Gg: AYBFou31ij85Fviz0g1V4XAGnQ2Fzhe1oXQfG6Xrqgp/5gM7lPclWhn7hotCof0tPEV
	VK/w2UYYSRvGVxXXBZP/6TfMDvvzO5KiB7+mX+nQZO/OhnjhCCB2qZcBw59qzKiARjXiBV5ui0t
	JVB6H2hJk/CXeW0d0jCatvomiULWM0rlEzcRRWThS4sT7emnnS4D9PnavHAhTG2QgUk+2kamzhA
	0yXdhGhJiKKhmsnd2+VYS1P2hFhKmXNvTXnwClU/PQeqzMJBUvGlYwoGlVZpeamXy1jYikZPU0u
	rahXEsmeUCdvhxJ0BbDZeouUVHat4bGi1kG/3PT/oiEN8UOYRaHmD6VcufAqhyoUgJuqld8w4au
	0zTbPpHON4FCdfmMxA9iyohjBq0pfP+2+ibn5rHSeMKzAyU6FnXv4pgzPQ/vsooAeP4to/DM4A6
	+v8jWWQkXubHesgduU5uABBxz82Ww=
X-Received: by 2002:a05:6102:440b:b0:7cc:174b:f7c3 with SMTP id
 ada2fe7eead31-7d2a167642amr1257925137.30.1793965479296; Fri, 06 Nov 2026
 03:44:39 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 6 Nov 2026 03:44:38 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20261029-pks-rerere-subcommands-v2-11-07d5ba18e882@pks.im>
References: <20261029-pks-rerere-subcommands-v2-0-07d5ba18e882@pks.im> <20261029-pks-rerere-subcommands-v2-11-07d5ba18e882@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Fri, 6 Nov 2026 03:44:38 -0800
X-Gm-Features: AclHuK_nrotLKXcimvroOkZ-OS_TEzsxyAR8qTXNe8fb5MsDNqjwJJ-jUabrXd0
Message-ID: <CAOLa=ZQrOyA2k+5EDmh+VJD=gC=68m3D17uKvNUTmaxH2FuNZg@mail.gmail.com>
Subject: Re: [PATCH v2 11/12] builtin/rerere: use `OPT_SUBCOMMAND()`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="000000000000223665065f9a23fe"

--000000000000223665065f9a23fe
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> In git-rerere(1) we have our own custom logic to parse subcommands. In
> preceding commits we have refactored all of those subcommands so that
> they are ready to be used as `OPT_SUBCOMMAND()`s. Switch over to use
> these so that we get rid of our custom subcommand parsing.
>
> Unfortunately this means that we have a backwards-incompatible change
> because we no longer accept the "--[no-]rerere-autoupdate" flag for all
> subcommands. But this was arguably broken and misleading as we ignore
> this flag for any other subcommand aynway. So we cheat a bit and simply
> call it a bug that those flags were accepted in the first place.
>

Okay.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/rerere.c | 84 +++++++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 56 insertions(+), 28 deletions(-)
>
> diff --git a/builtin/rerere.c b/builtin/rerere.c
> index 3162b074ec6..97c791e420b 100644
> --- a/builtin/rerere.c
> +++ b/builtin/rerere.c
> @@ -5,6 +5,7 @@
>  #include "rerere.h"
>  #include "strbuf.h"
>  #include "string-list.h"
> +#include "strvec.h"
>  #include "xdiff/xdiff.h"
>  #include "xdiff-interface.h"
>  #include "pathspec.h"
> @@ -152,6 +153,31 @@ static int cmd_rerere_gc(int argc,
>  	return 0;
>  }
>
> +static int cmd_rerere_perform(int argc,
> +			      const char **argv,
> +			      const char *prefix,
> +			      struct repository *repo)
> +{
> +	int autoupdate = -1;
> +	struct option options[] = {
> +		OPT_SET_INT(0, "rerere-autoupdate", &autoupdate,
> +			N_("register clean resolutions in index"), 1),
> +		OPT_END(),
> +	};
> +	enum rerere_flags flags = 0;
> +
> +	argc = parse_options(argc, argv, prefix, options, rerere_usage, 0);
> +	if (argc)
> +		usage(_("too many arguments"));
> +
> +	if (autoupdate == 1)
> +		flags = RERERE_AUTOUPDATE;
> +	if (autoupdate == 0)
> +		flags = RERERE_NOAUTOUPDATE;
> +
> +	return rerere(repo, flags);
> +}
> +

So I guess this would be the default case if no subcommand is used,
meaning the subcommands should be optional.


>  static int cmd_rerere_remaining(int argc,
>  				const char **argv,
>  				const char *prefix,
> @@ -211,41 +237,43 @@ int cmd_rerere(int argc,
>  	       const char *prefix,
>  	       struct repository *repo)
>  {
> -	int autoupdate = -1, flags = 0;
> -
> +	parse_opt_subcommand_fn *fn = NULL;
>  	struct option options[] = {
> -		OPT_SET_INT(0, "rerere-autoupdate", &autoupdate,
> -			N_("register clean resolutions in index"), 1),
> +		OPT_SUBCOMMAND("clear", &fn, cmd_rerere_clear),
> +		OPT_SUBCOMMAND("diff", &fn, cmd_rerere_diff),
> +		OPT_SUBCOMMAND("forget", &fn, cmd_rerere_forget),
> +		OPT_SUBCOMMAND("gc", &fn, cmd_rerere_gc),
> +		OPT_SUBCOMMAND("remaining", &fn, cmd_rerere_remaining),
> +		OPT_SUBCOMMAND("status", &fn, cmd_rerere_status),
>  		OPT_END(),
>  	};
>
>  	argc = parse_options(argc, argv, prefix, options, rerere_usage,
> -			     PARSE_OPT_KEEP_UNKNOWN_OPT);
> -
> +			     PARSE_OPT_KEEP_UNKNOWN_OPT | PARSE_OPT_SUBCOMMAND_OPTIONAL);

So this matches what I thought.

>  	repo_config(repo, git_xmerge_config, NULL);
>
> -	if (autoupdate == 1)
> -		flags = RERERE_AUTOUPDATE;
> -	if (autoupdate == 0)
> -		flags = RERERE_NOAUTOUPDATE;
> +	if (!fn) {

Okay if there's no function we call the default case. I wonder if we
could've done the inverse to reduce code block. if (fn) reutrn fn(...).
Doesn't matter much anyway.

> +		struct strvec args = STRVEC_INIT;
> +		const char **args_copy;
> +		int ret;
>
> -	if (argc < 1)
> -		return rerere(repo, flags);
> -
> -	if (!strcmp(argv[0], "forget"))
> -		return cmd_rerere_forget(argc, argv, prefix, repo);
> -	else if (!strcmp(argv[0], "clear"))
> -		return cmd_rerere_clear(argc, argv, prefix, repo);
> -	else if (!strcmp(argv[0], "gc"))
> -		return cmd_rerere_gc(argc, argv, prefix, repo);
> -	else if (!strcmp(argv[0], "status"))
> -		return cmd_rerere_status(argc, argv, prefix, repo);
> -	else if (!strcmp(argv[0], "remaining"))
> -		return cmd_rerere_remaining(argc, argv, prefix, repo);
> -	else if (!strcmp(argv[0], "diff"))
> -		return cmd_rerere_diff(argc, argv, prefix, repo);
> -	else
> -		usage_with_options(rerere_usage, options);
> +		strvec_push(&args, "perform");

Worthwhile adding a comment that this is a dummy placeholder subcommand?

> +		strvec_pushv(&args, argv);
>
> -	return 0;
> +		/*
> +		 * We need to copy the array as it will be modified by
> +		 * `parse_options()`, and if so we leak the strings
> +		 * referenced by `args`.
> +		 */
> +		CALLOC_ARRAY(args_copy, args.nr);
> +		COPY_ARRAY(args_copy, args.v, args.nr);
> +

Since we need to add the dummy 'perform' and don't want to clear the
actual argv, we copy it over. makes sense.

> +		ret = cmd_rerere_perform(args.nr, args_copy, prefix, repo);
> +
> +		strvec_clear(&args);
> +		free(args_copy);
> +		return ret;
> +	}
> +
> +	return fn(argc, argv, prefix, repo);
>  }
>
> --
> 2.56.0.341.g393f52fd96.dirty

--000000000000223665065f9a23fe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: f65a2813d0d32b0d_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ydHZhUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN2MvQy9vQzhaaDZISXpYRExzekJkSEVyZnhaRzk3SwpOL1FGSWh1OUND
a0FBTUFuVTNua2hQaUhNYjNzSkNndjNKWlRIcFRWUlJGM2N6aklaTkU4RUluaGFHd29TaTNKClZl
Z2tab2NnS2NkOURXZGRzYmVVZXdFS1dSbGNCd1VTVWloWkM1aEtNV2w1QUsrQUUzc25xWW5ndDc4
UTFtUSsKZEllZUt2WngxK0lIb3FNZWt0N3VSWHJsa0htck9BdTVtM09wMjN5V3Zpb2NuMVBhMkx2
SzA1c255RTQ5bVRTMApJSndUVlphK0Q3bUFZVUxmeTNXYzVEcVVyYnBnQW0zY2w3ZEV4dkdiZVhJ
UEhIUVlDRVlVekVaWTZvWHhTNVpyCnR5MVVMYklDcmZQT0FIL0tFNUplNktaUVk2eGE1dmtzeklU
NE12ZXErNU9FbS9vQzNpYndkckxtQVFFM1hqK2IKaFVDdFV1eUVLZ2lnMk1RVXJMQTNoV0ZnQ2lL
V0pwdVRINlZ0cEdsNWxpY3d5ZStELzFmeDFGR0NFTDdqVGpIaQpTK3Y1SVh3Q2FoNkR0a0oyRUI0
MVpreUI0VVNmd0IyMkdDckFUc1JWTFdlUDl3dVR4L3ZyWHVtQ1FPcDdWT1pLCkZNdkpQWHAwTU45
ZVF6d2RQOTNnYkFUSXZaeko2MlV0bThKQUFZcz0KPTNPQXAKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000223665065f9a23fe--
