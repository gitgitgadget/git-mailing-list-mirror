Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D938220687
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 11:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788263606; cv=pass; b=Wv6NCeOq2GHH8UWC0lCpOsMGI2i8CY5d/T6kP+aJ6A4Z9Q8iGE9Uyh9of08GXLX9mGtqFcokk+zF/Pg2MGT5Wq/gGil1lvnTXLb9/mQFIAZImZFMI6VivZqH1rkPZ14bTtN5qgq9DYpLod1iQOQfJ1OYOlQgOYWkiy3vafDWg9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788263606; c=relaxed/simple;
	bh=8m3Rtku1GGcOAJnZPQziFe8c7KLHZOWIoQm+2cxQkvY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=OqrHKE4SatE6qs4Uha8ZEnpZvnpXhmfOZHqZnvX7kMeN4hpZKwFsW4TBN9JogZQlVbb8ltNi77T5DSCWdySTEgLZerd+0XrMfV/wsPWvImrm+RJvu+A6+s0LTUfDR7JklyO3e4kRDNnzv+abk5f5jRBRRCFpC4U1n1z1nFgF8pI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oGvlX1a3; arc=pass smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oGvlX1a3"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-97cb5850a93so1825566241.0
        for <git@vger.kernel.org>; Tue, 01 Sep 2026 04:53:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788263604; cv=none;
        d=google.com; s=arc-20260327;
        b=ofTHcLSLTioQJZJv/J2xJNpnuTBJfKv9CljCW2rGA7NAHBioqskeUdjitEP+hg1aZW
         wv2qnbmVEau9yP+r05usdP7aqQn8+NtMuqyhOv42lMiCo4frOjmLl9Aqdt8wG99PDv5x
         vxv5gfx+pEZe4VevOsnDtQPrPy+m0eqZG3fShWI1cdLvb9amQsQHyVpnYRt2OItz4JaK
         l6Jq0dAqn1TLamWaLg1qT2kJ8g336MzYrLiKj3l5Ux8G7AuKoXkE5HHvdYs2qDxL4IT1
         1jN0EWUURCy5/yHWLlej4+04m9ZXMlFgBFCdyt2BNgaJKbHPvAIEwnxCeS/34fv7teWI
         kOGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=DlAILIAzfAlTqyYilDxYpN2WJxxnunA7WXkbOa71YBc=;
        fh=0NxfZKOh9gKSjBVBc1BVKyRu38ovb5T1WZriIlFjKBk=;
        b=GasPgYGdPxy2AvHMIyby/sjG2Bo3NbeAHFO3TSNfvD2SbnMEXkpwZdI+JFKFORprFJ
         /H+BeB4uLp/O1//xBd0s4HN0gohdtLrHxtHuXI7v0hrqW70H8TfLUyZlDgI/uMdAnxWN
         DZWrB9vOpt20xfacjllOHLc/Nwe6WX5E/urANWFGOPAVJvail66T5Ytn4YExpXBEjgr2
         tMP1Mk5JyVxH6OunSADvd4vVFwhRFpoma6iaMyQNkCS9phvbY7ZmTHNZCvKpvnGWWco2
         E90Ifk58OsWKP4DCtXK3/ygkH6OpCm7NPCFGVkvJPv+yOhNSCrQR87kNy9r3nGT7/VmO
         cxXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788263604; x=1788868404; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DlAILIAzfAlTqyYilDxYpN2WJxxnunA7WXkbOa71YBc=;
        b=oGvlX1a32LHhULy6px0QCCRx6C0YSbK7Lorh3IENTYwU2ahhdytWMfNm7Dj/HNCg1H
         PyQmJdk89iMWHwOkxt3FLNYLxqmUe3KqCB4nYvce7teJrfz1skE/+ziJrWWkJyix/8g6
         C1BIj90vILTPzfHNyz6h/j9ZVJbF6cJafOJKzIaxbRKf5dohcJAGB3xmBDObXfrAI67L
         mGvFDdAsQ/abavKT3OZw+mCkLJUbTo8SCbeo3oXBZhlrkBS5o8SVuUTW0sxo+CP53xS8
         uan9ZoQz1Eg9bNi5Jfz1KqXG9ilSUB4a8XT4FZZHZLe1MCwhph/SEj/elS0HVwMvnHU/
         GBfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788263604; x=1788868404;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DlAILIAzfAlTqyYilDxYpN2WJxxnunA7WXkbOa71YBc=;
        b=i3dTz1r7m5FbfLQI/JgPjH9YiDRREtdXi9qajpYU10EhFqv2Qzh8Uys3P2hac+n/em
         kY/vbExJkison2ELqNqx6LVd5/Zypv3jaoltsUl9A87nJU9/s/yYzPuMfXaGZrJOvPY/
         o+QN+v7uunXk1sJwqAHkCSBqUeBUxKjoXpiIYKkOsyjrzzg+QuvtbapVNL+tpyb8Uztk
         h+rCqvrSvO/d/YVVoVTAqY3v4sgg7At/ZnvlMzYYh3URqCI0Fh1811qReH5Jz2kXIDsk
         EWiSzQztI7kuhvqacHSWIV/ztdrEzCYqq+IYU3Iw1dfcVFg1F6DTGhU79yrIYhWHbVU2
         Suww==
X-Forwarded-Encrypted: i=1; AHgh+RpzwVUyqA7ZzxEoN130zNjtUxfwar3srfyKEdRguujPC9fV0JPMccELWqeZOR1rgNQD4ps=@vger.kernel.org
X-Gm-Message-State: AFuF++lkxu2QNqR4xI3ldoiWWM6aaDQz9o4YmdXyIg1nVZ5GEn7wLfIp
	HOlI+0473tmMxLz8i0V7f4AvQWnDO0MCrYG0UBnUx1s6msxBUatz22KakFsrmJnz988maszEPRe
	YuU2np/MPpc/H8KIEwJELrFXzST5UHN0=
X-Gm-Gg: AR+sD10niZ+S54aEKBZ0fGzll+GIWoZYpFIOIiSAe89amVFIaJGn3NLAh6RKX0ewhX7
	sdzjw+8/cRyb69lH2zXEQvLDKpy3L92Ft47UizOyeHGjNma3WxPUVrGNkI8GCxPjbmb8YIMPHIf
	srNKTRARzv4yge4qW0Mqqj6podHUAHXjqgF8uJ4/8C4ZRbxnWWOgrNyz8KjqAdWCsYZZeT7NfoM
	cNEgu7cbo1zlSdoKG+3QjrFGJ0wF47SDmjd06X4clb4S4pn4J1rVx2RTNbRotshAm5rVg1mnPE0
	X1fVa3b/CTXJ1OB0Ke/acULLAIBwYzGyt0ikfTxN7XmJecRlSq5I9AB+JDngx4EQTLwtVoTiLQ1
	VlIZm8Sr4gGV068ukgA0ryxtNVdo6lh8O6Ys=
X-Received: by 2002:a05:6102:3594:b0:786:fb19:d5d6 with SMTP id
 ada2fe7eead31-789fc12ecf3mr3393011137.1.1788263604187; Tue, 01 Sep 2026
 04:53:24 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 1 Sep 2026 04:53:23 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 1 Sep 2026 04:53:23 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260830204835.1040408-4-gitster@pobox.com>
References: <20260828225206.310500-1-gitster@pobox.com> <20260830204835.1040408-1-gitster@pobox.com>
 <20260830204835.1040408-4-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 1 Sep 2026 04:53:23 -0700
X-Gm-Features: AcwNN1XLoXAcwurEUBu2ovOuGw4bLTc-unbuAjxpJHv7LOM_6kqOIZReRjPVXeA
Message-ID: <CAOLa=ZTA=xmPnEkMsncwd=3iZA62nsXq0jk-KiUr=GU7OUhh1Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] checkout: validate stage and merge option
 compatibility in checkout_paths()
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000e49149065a6a9064"

--000000000000e49149065a6a9064
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> In checkout_main(), checking that no more than one of --ours/--theirs,
> --force, and --merge is specified is performed when pathspecs are
> present, before dispatching to checkout_paths().  Checking out a
> branch does not use index stages, so this validation belongs in
> checkout_paths().
>
> Move the incompatibility check from checkout_main() into
> checkout_paths().
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/checkout.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 14542626e9..e3d23256e2 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -591,6 +591,10 @@ static int checkout_paths(const struct checkout_opts *opts,
>  		die(_("'%s', '%s', or '%s' cannot be used when checking out of a tree"),
>  		    "--merge", "--ours", "--theirs");
>
> +	if (1 < !!opts->writeout_stage + !!opts->force + !!opts->merge)
> +		die(_("git checkout: --ours/--theirs, --force and --merge are incompatible when\n"
> +		      "checking out of the index."));
> +

Doesn't checkout_paths() also get triggered when using '--patch',
shouldn't this go below...

>  	if (opts->patch_mode) {
>  		enum add_p_mode patch_mode;
>  		struct interactive_options interactive_opts = {
>

...this block? As the original checked for `opts->patchspec.nr`

> @@ -2063,11 +2067,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
>
>  	opts->pathspec.recursive = 1;
>
> -	if (opts->pathspec.nr) {
> -		if (1 < !!opts->writeout_stage + !!opts->force + !!opts->merge)
> -			die(_("git checkout: --ours/--theirs, --force and --merge are incompatible when\n"
> -			      "checking out of the index."));
> -	} else {
> +	if (!opts->pathspec.nr) {
>  		if (opts->accept_pathspec && !opts->empty_pathspec_ok &&
>  		    !opts->patch_mode)	/* patch mode is special */
>  			die(_("you must specify path(s) to restore"));
> --
> 2.55.0-884-g76cf8659c2

--000000000000e49149065a6a9064
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 153a90d9e7d840e5_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xV3ZMRVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNnQ2Qy8wVWkydDZzQUEvbmRnMjNJb2xXNFZyamxabwo5RkxjS0lkTkdh
ZUNVWGE0ZThsaVdnWFhYT0FkWW5aTDEvdkVGeEpMRXI4UE90YUphT3NJMW4xV21UeHZ2UDRjCjho
T3VZc0NPeW5uM3lkM1IrQkJ3STc5NDRKQjFnOUZRWXRMMXJLYTBmOU1NN0puSXR0Y2xHVkZpKzQ0
aHdKOHMKQVppRXFnNXJXMmNXdnF3dUVWbVgzSWpPWVlicklGcDRycWpqR2J6aUxDRHc3TEc1ZEd0
WGNrTG02Ky9MOWdzaApQSDFsS0dOQndOYmpob2lnMmZGYTNEazZVaHFkU3Frd0RSbUR2NHl5MHp3
YTdVVDZIYlVKTnZmc1FGUW1hNTRICmFqV01SU3JRS2tydDdsbnZXL3dIMEhnbGMyTTgrOHdQbzZk
eU9ZZW5FcGRkdUxLVlJsL1VGSjFlcXNxV3NHNWQKVzdDcEZpbXRSNUtyK08yZzJoVWtDRmJhY2JB
L0lZNDMvd0s3VTFWYXNFN0lid1BqMWlYeFMxa3VGNHp2Z2k4TgpmeVpxZnJBVlZhaDFUTUtVVTFR
N3lKeEQyM3Z5dlArL28rLzczVGVDQmNZVlBZYTRrd2VCRnNqK2RTR1NRN2FUCkFGYmlHb0Y4K0tR
VlExb0tlSmFGUUtGUVlQbFhWeWhTa29hcDR2MD0KPWZkVUsKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000e49149065a6a9064--
