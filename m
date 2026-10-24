Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792862781;
	b=VFtEypH1JSPe+ISK4Q/GnVQYcHahB0qSPxKaR/3e82w+POeritJe83sZ8qBGyiqb3G4z
	 fsado5ir7MsnUypdm8Vcrfy12tryR1ZITM7pTVoMcyLJaxt4UJseg6mobsTm1ABwCMMXR
	 Kh7AlIzQ6cJ9A8uxWDT64qy11vXsFaAWLLyrOZwpj880bWqdcnQ0y5R5GMWFGR0ZtIxSf
	 xG24TrZAsJSUqX8SgrhtMXyKyQ2/BnM41rd2RgIh5y8DucG7/xXqbYizPoerrn8IEJn0a
	 1oqgfz4XBOGHDrpnUzbo8gafWURZB3ZncBP3+QlKRak+0E22vAGJ1fjo9Ngt8UHNvLg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792862781;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Voqf05aEd1RpkJOsu3bheI2aJ+QLIsXm5kKz6RjiZuw=;
	b=R/TQf2x0H/ymEry50E0fwPsHlgBigyhAq2gBns980OpfOT5Kv3NxHNfQeXMGtOim8EdT
	 u8YTno716X5kVPYnhYMEdzN/Sc3lsE/PGjOAMk+ScyyKwG36v2d2ili1w0w1SA1dLjMEn
	 zFh6Jr6gpaGD1MvVr6xuq7jVi1pZY1H4HO4Z9+VTA6vR6taJ4I/c+ocPMRohqlpaEZBZP
	 uVVgtM4Q6Kimkc/+9tj/uBuyCbeYMA7NsSturgZV+XxtZHOL6+KkSfcEOClhvDn+bBC8v
	 UQyz801QXhxIQAo1gXGoDldtW6cWH3sddPP2hSiWPslBhzHP0atUq9VLKLxRhazTZ8A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=n6fMiXf1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.177
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E915606A31A
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 17:26:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E915606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=n6fMiXf1
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5351d76e1baso21867981cf.1
        for <git@vger.kernel.org>; Sat, 24 Oct 2026 10:26:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792862779; cv=none;
        d=google.com; s=arc-20260327;
        b=rx8mZVR0nnljP+fS1jK1n1Hi2l3JdOkkqDiwL0L0BbVTm98tts4qfZdYEdNkrIe3+c
         NSCfFh9Hv02/lqWy4JtIRv7onpG/wQvFMO+9dv7Bj0We2Kaw8jLNL5w9RnnhBN3iRmbf
         tA0TL8ZWW1sYx4ZILXoM7zBegikBkN4cPFcAkUc3VweSAcs8m328zasx05zqywI38fe9
         30L1wjq3jgPZlTYpCYk4R7A6J+CXB2zz0Y7zu+gnjhD+JvofWwbF3BV8zJG14XE36q4m
         dJbD5qjP2Pl7UBwKGHOlZs1EawPlhxyr/hImjrSim+ANG1oNvG3OtYMveaSFDpQfhUSu
         AfJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Voqf05aEd1RpkJOsu3bheI2aJ+QLIsXm5kKz6RjiZuw=;
        fh=DdEgUv54Rb+NSIn+eslj+iSnrL7I9PD5pUeD/xbHgF8=;
        b=SD0ECNVjOqfqZXf8jb3jRe/0CJ3gylCaP4nhfgEOYJUphaov/01J3Q6uJKorvBkGNe
         TtnshFpHacMORiMlOoaFrjBKeTyq4eA4hCsH9NJzDb1DncAPi9CsZLP+TNUTAXLwCVfG
         XX8e5v4/nNxDcVCe0WaT/faCG1qUlGv58kDbvM4sxWx24R3w94aTkRZojeSIRLJ5WJUm
         /3OvS84GEgMHavddkjDF9Th/tX+00tig5pEd260rI7298Sm4zD01QJ8tirk0B5cvj+Py
         85ifzv94xSRntsTNoqV4pDEIhYscWrSdcHSYxHo9ztLJ7vMcBeV7tTRqypCyRqHPJAHq
         ebMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792862779; x=1793467579; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Voqf05aEd1RpkJOsu3bheI2aJ+QLIsXm5kKz6RjiZuw=;
        b=n6fMiXf1CnzJzNRtc+k1kMMpt1zKEzrRAs2eb11gcvghXJMrSjbU7T1t4bkisNMqj7
         SNXBlvTkz66zgb51gW97vB3h88Sjft09K0ikDmAMKXBsxXnbEisu0sp22BgtkzgisTqV
         4f2H5jcPfsFpxojS4l6Z2VsKMtjTGPBxfNlfqNwzYcP1MXPYyPHlCoXhbQy4l6fuJ1lj
         sWoN58zfTj2e/VQXABF/saoy+ikfdOPnE3ipRxOSei692zD3B5gLZRtgD5rdUMgOymPz
         83tWgslQ3sHSR74h+EYkQgcnDTG5ejTG5s8llJ+CcIbyN8M4qruAUysMjaAy20UfkhZI
         GzqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792862779; x=1793467579;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Voqf05aEd1RpkJOsu3bheI2aJ+QLIsXm5kKz6RjiZuw=;
        b=CU9DAniBiic3B/qtL/mECCXYWqD2l5DVD/CKYYXGGfd56Bx24m3f/Sw6XGO+b5Fa3L
         8obLybU5SoXgf+tJ7IxCCrrKQcEU8+Mr1tATw2iPtby51O3S6r2fy3puV/fRblzcjS4g
         7ae/q8L815nZhFL31pmwS0k2zQnZeouudPmTT2C6SZGV1YUt5WLmEPfdDYz88EeTb+Nx
         3vTD7un10l6zCoaM3bNSTUAybsa69QDB+r8GmOxadls1lf1xEuRaKMAVQNCz2UPGvMFI
         hRL+I8/z3WWKcOdUPevEy4NGpcN9yPNn69E8mM/hW+sZirdjN5PU4ElcwR7AbFQBppn8
         yh6A==
X-Forwarded-Encrypted: i=1; AKwUvBxdKcuhb3RG4cfxNxDZ9z5RsP+H2QLADhh0OFv+AWFoBOcG0fcuRJGE7f6HXOJo4qtqk+M=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ5kO18RJtcduMDSj6DFrfasWMyKBLsxuQdkbrpg0iBxlyMtuwC
	2Q8uQnTs+SWcFmAdYBib1M4T5XedaKmeRhG6h/uA0ScAjiXzQ37e3FGutepZXZWdTYgwFXd8WJg
	tJ4q8FvIAMDzaFjJg/DqgTrfc5fs2YyU=
X-Gm-Gg: AYBFou0yv/CkL5XKYpLcmgZ1/qPTXwm+duUhxUg6613+XOOuaK2zhcu9LZyU3PC2wFg
	o/O5NW+9HJKYW56ym/FuZrf24AlglH5yFAY7lKB0RL0ANoiG7ygMWGch/I3JAb3iDVvmoIQSbCe
	Ig3UtCAeZylTJuKGuDALGSa04CHpfgCfeVrBH0c8IyYEKwbI35RnjpnfrWfSeUP5okPlL6bkEyl
	bai0jVhV8yEltB+DTkKIy32nK7iIv4ALweOnhOA9o5/8EVtBRCaYKS0sJcB1lgRT/lwxwsJrG0j
	m/Gz3mQaCUW7AczTSTpUSn6mJRn+0Uhsg/Ksy28vsmhzTSLuE0FWgEcWIvryZt2QTUVf3vdfyFE
	p2hxOiI4vKoRoT1i2f1jA7G4ahXySR8CuOXGR2nWYbnV2QB0SaPVEbDIyhN8ogoZjd1q6HYXg3V
	GRmE6DGEPdbCLW+3hnQuiEZKh+fVELTHd+qak6+iGvp8Lmu7+u1j2IgULs4KoB6HXv9YcFv8uP3
	h4dvA==
X-Received: by 2002:ac8:5d44:0:b0:535:a5f7:d594 with SMTP id
 d75a77b69052e-5383b6a23c4mr33559541cf.35.1792862779513; Sat, 24 Oct 2026
 10:26:19 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2276.git.1792727808109.gitgitgadget@gmail.com>
 <pull.2276.v3.git.1792813697888.gitgitgadget@gmail.com> <xmqqfqxv13d6.fsf@gitster.g>
In-Reply-To: <xmqqfqxv13d6.fsf@gitster.g>
From: Srujith Poojary <poojarysrujith@gmail.com>
Date: Sat, 24 Oct 2026 22:56:08 +0530
X-Gm-Features: AclHuK_A_rw5PL0iNHqPOIQ9loIPD5ADMRqNop8zwS547Nj04mdHNhi9B4tfE6Y
Message-ID: <CABh_KWhDcPM6rJROmVd7_oGZ7i3tmX5da-DZX=KJmvSyCxNH_A@mail.gmail.com>
Subject: Re: [PATCH v3] diff-delta: use safe integer arithmetic
To: Junio C Hamano <gitster@pobox.com>
Cc: Srujith A Poojary via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood123@gmail.com>, Usman Akinyemi <usmanakinyemi202@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 24, 2026 at 9:45=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Srujith A Poojary <poojarysrujith@gmail.com>
> >
> > Replace manual multiplication and addition in create_delta_index()
> > with safe integer helpers (st_mult, st_add, st_add3) to prevent potenti=
al
> > overflows when computing memory allocation sizes.
> >
> > On 32-bit platforms, struct alignment padding could cause the total
> > allocation size calculation to exceed 2^32, making safe integer arithme=
tic
> > necessary.
>
> I wonder if "X could cause Y" above skips a bit too many steps.  I
> was expecting more along the lines of ...
>
>     We will need to allocate N instances of A and M instances of B, N
>     and M are capped to X and Y respectively by this code
>
>         ... code snippet ...
>
>     and size of an instance of A is 8 and size of B could be either W or
>     Z.  When size of B is W, then the total allocation would be ...
>
> And that analysis applies only on the first allocation.  I didn't
> even look at the packed side of the allocation size, expecting that
> you would know how to analyze after seeing my example on the other
> allocation.
>
> > Note that hsize + 1 inside st_add3() is safe from overflow
> > because hsize is capped at 2^26 early in the function.
>
> It is misleading to say hsize+1 is inside st_add3(), though.
>
>
> > diff --git a/diff-delta.c b/diff-delta.c
> > index 7cbedeb507..efebce3aca 100644
> > --- a/diff-delta.c
> > +++ b/diff-delta.c
> > @@ -162,8 +162,8 @@ struct delta_index * create_delta_index(const void =
*buf, size_t bufsize)
> >       hmask =3D hsize - 1;
> >
> >       /* allocate lookup index */
> > -     memsize =3D sizeof(*hash) * hsize +
> > -               sizeof(*entry) * entries;
> > +     memsize =3D st_add(st_mult(sizeof(*hash), hsize),
> > +                      st_mult(sizeof(*entry), entries));
> >       mem =3D malloc(memsize);
> >       if (!mem)
> >               return NULL;
> > @@ -258,9 +258,9 @@ struct delta_index * create_delta_index(const void =
*buf, size_t bufsize)
> >        * Now create the packed index in array form
> >        * rather than linked lists.
> >        */
> > -     memsize =3D sizeof(*index)
> > -             + sizeof(*packed_hash) * (hsize+1)
> > -             + sizeof(*packed_entry) * entries;
> > +     memsize =3D st_add3(sizeof(*index),
> > +                       st_mult(sizeof(*packed_hash), hsize + 1),
> > +                       st_mult(sizeof(*packed_entry), entries));
> >       mem =3D malloc(memsize);
> >       if (!mem) {
> >               free(hash);
> >
> > base-commit: 47fdf2208c5b94c8cc01c106b8f7c85efb91c926

Hi Junio,

Thank you for the detailed correction.

I have expanded the commit message to include the step-by-step
breakdown for both the unpacked and packed index allocations,
detailing the caps on hsize (2^26) and entries (2^28) alongside struct
padding on 32-bit systems. I also corrected the phrasing regarding
(hsize + 1) being passed as an argument to st_add3().

I have updated the patch series accordingly.

Best regards,
Srujith
