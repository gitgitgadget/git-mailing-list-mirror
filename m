Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793026917;
	b=ve/05/Zc6W21kyHEgrhqCarx5+IM+MGy9Nm+TaEy22tn1tYss0RjTGxspoW3iguC5o5X
	 xOt3BFP1oT5486nh4zR65HsXAZPnXx7TNP9DaVNNvrwRc8AlojpVcYr0y4qQoXJ5ggHpT
	 K0GCiWLM1kX5u2b///7XI96ES3MHw9Ed+q94BfQulvSz0wLZUh3ZtcFAU0vDqBLBrNr5h
	 ypyCnYNmrZa0VlWNHlKNJNiAimdzWb2/jplGCJn32AokgxgrOxbuVW9RH/1/Xa1S0S2J7
	 7bDBUgblzRtGNvgFhl7q9ObnnORSbg4HNF/ld9ixjwO1h2w4ktm29wnyutt2z8gQaWQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793026917;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=kuu7CrZE1sLNt6H8dCKcaNw/H1kganiyMf2ZSt6C48E=;
	b=e5Mhga8GrG03DzoRriajQqJwtvikCn/ZicOw1DR70lvis3Zx0Bpwp7jF6egW8hl+PiBo
	 PMYDRZc1o5GIQRnCxsN5XY4vNm95XijTKHGB6klTl3Q+P83jYnXbCLi9tRab+RLlBUZBw
	 Wm7RvQNtIHbVwtnV3xvPvxInXe22qQ4dN01QuKV47JegnF74RYaoclwSTnumZJkECd8uG
	 CCCjhy14le3T1RrCWPvMDASNOknP+uI87Fd/5Q1czvCyQGjGnn6IMMFdgeSyL/GgZmqO8
	 8c/sA8LPyOCDPzv77Kz23UZpgTaej9vQF0azL9RTtAycKmeYffsgYn8rmBwsVc8Rfrw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GBEGYemd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.48
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B1B606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 15:01:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68B1B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GBEGYemd
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-990703f817fso1744555241.1
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 08:01:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793026916; cv=none;
        d=google.com; s=arc-20260327;
        b=ThQgTDaK2MibKSa2Y+2l88mP7jz4JBSUwjCNcZEQI41exl8SoXUJRfxTohBWnEZOSv
         +3RYTzbfxEXLS5DwXITZVHpkjuuNqnjVP58wBN3nEssWt1s1Ts9ewAgz7Ntuigz5/hS5
         GHXRHoAjDaTdGMLTsM/9b3n08qy/fqdOO08TjOn6iqeyUpHiZxd0IE2KkvQwxwR3ycDZ
         vA3B/hfuyUxk4e05TrRhN8/09nPFTzlIXf3SRQftpTp0rledXb5DmvOKen/MZSR+vuTM
         +zHKU8JQJVJTJWW6mV3O4YUm2fl1PCQOYLOCovNhbbK5DcJpm5z83wdRmY3G8dLZXo2o
         4mBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=kuu7CrZE1sLNt6H8dCKcaNw/H1kganiyMf2ZSt6C48E=;
        fh=fkvnNpD2MEmt0GczymPcvtgt9l0YqK7HnbLjzIGgJm4=;
        b=oKoM0r/lWEyLgJpyJ4JdYDiWIRCAC8leVb0gYuTCtaxvflwpx69h5QDSFbY1AVx3GG
         PTGvF25UrRT6nxFl2BtehACKb8jqOw5ihp0fhfKZX0fXErX8eBK8XK5htCoPs+CXBLSF
         YJVU+F9V3+7fc/a6B3wsKE9IQ4hCFeci1Nht+GDsbusi3GDrPci3lOmjfpblr/v/L7Iw
         tEcg0hOYvXT9LAEcF5JzdFSOWok7q9UnCraZQ0RK6k9lIs37fsh2U9zA6gbJQdTn45YR
         FN2mb8yvc0jjxL6Ydr83FTDLHeIefichZwukNBZhS8PM6WIPrHoJponWxIlxvc2qvkva
         4kNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793026916; x=1793631716; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kuu7CrZE1sLNt6H8dCKcaNw/H1kganiyMf2ZSt6C48E=;
        b=GBEGYemddJR9W7CvDtBVRqk+xMzEFR7jUyd3Sj5xX/KhCB7+a6eoNkgP2n2Nw2+Ade
         qdtH6+cUtgmLVBhlPRxBNXXR8O2LHdsJ5A9IFYNMGkbKj7J+quavDFLornC2e6iVn6CE
         MupJin8E3xaVD6WF4s8z3Kr4mQ/R6P5EC8bSYwMd80cJpYjPmtbRUanq3j1F75TF9Dox
         SBIPh8dA+teIeKMGWFTx/Wz+k8vdq0t+VSvrLSouxnC62ZPq+49QQuqrkpCtMVAtzRm1
         yjTt+toBxdDGiseiBr/+SPYIUp+rDIomUs83g9W8wkIIl7eIGxp1VdIU+aAj6aPpIb/f
         hiFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793026916; x=1793631716;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kuu7CrZE1sLNt6H8dCKcaNw/H1kganiyMf2ZSt6C48E=;
        b=Ogomf+OOSJXk2QGnczhgKL3IFe5TfBanSm0DrfsDceHkjadoXWFJs0RzPbHtMOYI3K
         yQ09dg8Xk/BDouKo4XqCDotGjbkdeVzgGAFqPl/nkZPzSw1t3MJMmEN7elvOsXLcQtHT
         CT/hxB7ttoGY5O5wLeNS6xuuhBQVxQw1k0yp6Voqg0oYMSpUjezanOYol1DlTLfquqxI
         BnUL5mb8Ucz2HFzU6Razp2s13aUp4wvX2yDhkOa2+E/9+5jr7h/AOsFOGk/YM4cSEGB4
         0ulBqwC3rGQ1W6yxyZbl911bLZdFalgTqS5uMNkyZrDrX95bXY4m68UwvFZmB0r3Ndli
         Injw==
X-Forwarded-Encrypted: i=1; AKwUvBzP59NUOQ7n7uhbUpJot/zttShgv7k76VtMg68axStHLgOZgXtmNSr9VnU9r8oDAKs3Tio=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ7h1KLV2RutFoIAhWt/QHiiNg/Ntf17judB3mJtI93oE0A+JpD
	54psYc48VYXH4PKJxcY+gbOYTup8E72+m6Qfy4FZmDLp6tpbZYTCRQjp7cCbb6C5so+iSwHHdGJ
	7KXu4VQDsoxsSk2q/AZntiIf+JUe73wRm7w==
X-Gm-Gg: AYBFou0i/yVmTatBGx5EDckuCWTNj8wEZRrECXxQvK2K7mYEJmUESvUrej0njtgRbRw
	qbzir5sfSCNXOhhNDC8qcVZ32baSRRXMvz8YQ+ojrojsyOSuhAo/45ccSVSgPFBaRywWVmR07YR
	rNRNzOt0eU0QFTP6UIVCQsofBReVtvaw6/tP04M1xEqhdjbi+C5eGr8Jw4W0jdN+sGBRvyRaUkl
	HBskQlgkKgcGYn8owjUUNo/qgrctislIIAfSpklumq0yvRL8jsSjKDmHBV+X4dsQg23WpcSD3Fw
	YNNV/ji2PR4qcHDxqfsNWDmd1yF88dDYT4nsMch+1Q+xG7qwiWf1l5cnmvEUuFiELxJtPB5NFwP
	YLYVZ5z3SWzL0kmDKKBbiHcLg4bNXZm0rNDDl/PSNwdi5xCoYS5b3wbDyMSKwon59G0pNSaVtFf
	hRvAW1HcofRiykPkWPlsq0ZvtZxwE=
X-Received: by 2002:a05:6102:161e:b0:7cc:3eb0:6ef5 with SMTP id
 ada2fe7eead31-7ce5cca8591mr2678744137.11.1793026914835; Mon, 26 Oct 2026
 08:01:54 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 08:01:53 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 08:01:53 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20261021182528.3055494-2-jltobler@gmail.com>
References: <20261020132900.1208343-1-jltobler@gmail.com> <20261021182528.3055494-1-jltobler@gmail.com>
 <20261021182528.3055494-2-jltobler@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Mon, 26 Oct 2026 08:01:53 -0700
X-Gm-Features: AclHuK_hdO3ZlkNr0PanfYo5Ykd0_DHll6jKT4JBc1Uz2HZgX-OBaNpjbWojle8
Message-ID: <CAOLa=ZTnEJDPB6_fdFQFcM=zV21HEZ4gzzhWqB=A_euSzUut_w@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] pack-write: make index-pack output comment hash agnostic
To: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im
Content-Type: multipart/mixed; boundary="000000000000552890065ebf9c30"

--000000000000552890065ebf9c30
Content-Type: text/plain; charset="UTF-8"

Justin Tobler <jltobler@gmail.com> writes:

> The code comment in `index_pack_lockfile()` explains the expected format
> of output from git-index-pack(1). As written it explicitly mentions
> SHA1, but both the git-index-pack(1) output and the parsing are not
> specific to SHA1 and also support SHA256.
>
> Update the comment explanation to be hash agnostic accordingly.
>
> Signed-off-by: Justin Tobler <jltobler@gmail.com>
> ---
>  pack-write.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/pack-write.c b/pack-write.c
> index 85674e4b72..b1311c9923 100644
> --- a/pack-write.c
> +++ b/pack-write.c
> @@ -476,11 +476,15 @@ char *index_pack_lockfile(struct odb_source *source, int ip_out,
>  	const int len = source->odb->repo->hash_algo->hexsz + 6;
>
>  	/*
> -	 * The first thing we expect from index-pack's output
> -	 * is "pack\t%40s\n" or "keep\t%40s\n" (46 bytes) where
> -	 * %40s is the newly created pack SHA1 name.  In the "keep"
> -	 * case, we need it to remove the corresponding .keep file
> -	 * later on.  If we don't get that then tough luck with it.
> +	 * The first thing we expect from index-pack's output is
> +	 * "pack\t<name>\n" or "keep\t<name>\n", where <name> is the hexadecimal
> +	 * name of the packfile it has just written. The line is therefore five
> +	 * bytes of prefix, `hexsz` bytes of name, and a trailing newline. A
> +	 * "keep" prefix tells us that index-pack has also created the
> +	 * corresponding ".keep" file.
> +	 *
> +	 * In the "keep" case, we need it to remove the corresponding ".keep"
> +	 * file later on. If we don't get that then tough luck with it.

We start off saying we expect either '"pack\t<name>\n" or
"keep\t<name>\n"'. But the last line makes it seem like the latter is
always expected? Is that the case, or should this comment be moved to
the caller in 'fetch-pack.c'?

>  	 */
>  	if (read_in_full(ip_out, packname, len) == len && packname[len-1] == '\n') {
>  		const char *name;
> --
> 2.56.0.173.gf57c9a7388

--000000000000552890065ebf9c30
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 5fee3d3d0cd28b1b_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yZmExOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNVR3Qy80bWZsdnJVb3NUek1yU2pQeFVmTnU3bzloaApIT3pGV3A3RExZ
NmxZY3lpNTdGYzJjRnFUU01zc1h6SzdHK3haN3RTb2hOaU1SWUozNFZZYW9vaWlpMXAwMTZQCit6
RWE4dXFhSjFuSlVLQmUxN0pFbjhIRXE0R1NQWklnZTNyTFozOWpOR1BlalZBRjBQR3BadG9VMmt0
T1hiRm8KVVJRc2ZjYTN6c1p0OGxweXdLU1lybnMyU1BrcUxXRTVBK3lqOW1Wb2l1ZklmT0VCeU4v
NXM4Q2JzYjBYWnJESAo0RmlnT2g0TFBlQzNYWUdYYVVteU1UQ3RYTmt3MmlrZXJZQUs2WnFCcVZ4
ZS9sTlJMZ2UxSVZVanZuckV6SHRHCjBSTUhieEdSeDBPcFozYjRBdkRyZlZ4Sk55NTlpRGJXc2ps
NU52ZWJFbzMvclVPeUdIWkJKaFpESnlqWlZ5YXIKQ2JSRXNhcW5CcHBxMG9UblVBU3U3NGdQaWdt
YUV4MC9NTy9BT1ZTSnhod1IyNTdwV1hHLzFYSU5NeEdzd2pIcwpWL3V1K1Y2V0pJWHc0YUw5RThX
UFlINDBnZGYwRGs4Zk8wY1lUT0xXU1dMb1N6ZDRIWlZIL0VGMUV1YTNObzdBClR5aTR0czVvMXZ5
SnllcTJKSTNoWVZkWnREVmlYUyszbXpiOFRMVT0KPTY3eUMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000552890065ebf9c30--
