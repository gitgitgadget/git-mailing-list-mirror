Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794234433;
	b=gVEq70tpsgUNP7JW+PdsIwOFjl0JZpu1+vuBcjG5JXO3QbfD/haKl3zkBZP5r3HUo4hm
	 MrG8FsEzo3+rTMGu1RhemQ0EAWffhM89Rcvt3GFdoJQWxXE+wnK/lk69+k+YrVCbPtDWZ
	 2gua9HTUnfZxYz9VqvhZ/xBuQyJ7427zoNtbVoYdNdMIvE8By8EDgTH0CpElVzsWzV5LN
	 7z4+CxKj/pjWDCJdTYx4ZdkQOTmNQL1c4A1+xb+EoJVOC5rfBJvi6dU8EB9ZLX0V+ysRu
	 mfZSM7NiZRTOJTSBQbgPtmKg+nG+oEI+nKxKPezo0LoMMZWxDyxxYDRybUfq9l/eGhw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794234433;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Content-Type:Content-Transfer-Encoding;
	bh=SCbUUn0h2JspbNaOxybvrCMKuHt7k7RPy6F2uVROTLg=;
	b=In+Rhdw0pNiY5fhPmd1WABr+2O60G/Z+79uIH9MWLCIzvjb+H7QWqatfz059L3NQHZLE
	 vsv8GTfS3/wKoSKDsS4jAp+MV3SjOS+gbBqv+pWBCoVVEycWYWfOIIbLVUu6x2GSsuaaq
	 6JvPsiKjH1F0gf8rgTZgST+RoeedV1F4lt9+BGDWIQyGuJsI55yl7/aexXg8dCkzOkZZ7
	 94S6uFC0kpxZrWkbl7WOERCdA9OVcLF2KmCYVGvOeWgmqUnMgMxi3YcgsSZ/OyHrNVLY8
	 KjMqCcD96XDDAVDBGAeJ4GeDtYDx8l0Fye6Tn5znz+KO7FlXa01e/JC/0WvlNIV6m9g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FYDwVWJe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.42
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177FF606A325
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 14:27:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 177FF606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FYDwVWJe
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-85d363fb73cso465814a34.1
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 06:27:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794234432; cv=none;
        d=google.com; s=arc-20260327;
        b=DcvoNlToxag3YZ2WXwoRxrEr4nG03NFCJZ/PXMy7pL+AgouYfsdgXmP+HbYNAbwgpf
         T4vgNQHZULdepkPJ0xDvLnfoBv0FJowqDxzXd/llLxbNmgOd7EAHtuj5hBy5X9yqyBJR
         o6dnwJVpocV9d26Ys9JTtqDgdgh2u52cegSms1yXcv3U4d13waiRHw92nEJO65Ax/c5f
         8d5DbpYxNbHGbWIFO1qcxRtsu4v43wWagxhWMDnogVoN1s8eI1VeFRCs0kut7h9alWIo
         jpUgsdj1v6DED9MZ2oF/IsFPXto4kMfadgrp3GlrrlbMQqMy5WBOaG10jtTdMEE77Fr4
         eX5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SCbUUn0h2JspbNaOxybvrCMKuHt7k7RPy6F2uVROTLg=;
        fh=YeMfK1c2NBXa6r9LO4lVCoSa5qjj9QhIzQzIDo7F2cs=;
        b=mubbtUQJoiGT9wm4z/0rAaoio6I3wB6X21wDkGKtGgFrAF7LsuRmnya1NtwiaI4+X+
         k1HX+NvW01E3C7Udq6QbBH8YXW4qKnxaXwccS7ewKw3b3Ge1inoVMyZJ79xOzr6Li6PQ
         6+piaKjTKhFjYpJOEo5eS7vwejMHAq4bsoGpf3/su8D1fbnbk8vTuz4X4LWgcTGLcyu8
         FoLzvBcCGCwsgvOKVlOJedH4Xmjs92xXvEk17qE2EViUbTQym78vdWp5qeCjb+P+6RXQ
         vNPkL1ES2YjdI9JpTfF7tDRGkwvvXUXdUIz1nZnrVDpwpe3v5bYCkuSCi5vU4sIjMxxy
         ZHsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794234432; x=1794839232; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SCbUUn0h2JspbNaOxybvrCMKuHt7k7RPy6F2uVROTLg=;
        b=FYDwVWJeQq8MJoH7+6XZve/DNeqlMcKR7njCSBA/2q4+RyZ5APXcSDjKAUbeWxgjIe
         L4mkqeKOr8kc4ZvjxChsTieipfEKbSkrBvS/u3FPpuuH+fcMtkbEOlWsoyIOmkAZcatq
         dIcXK/w41lMvkYtknRKVpkfCARWOCuLIh+XRJRLEDOeQqz5EHba+wToVPnDTDTD/SMzE
         QsmN+PqlNZbejPaq2I+z1VHkUQ/XHWweYKBMO2rnx4OTZAXnfbqwvLPQDc+m2PZI5tfB
         +6zf8TYqsVTKuzGLOiHxSf+HYxqTpjZ39UA4MyJBRfyZQHNLunwPCjj585BY1ydeSQ0u
         v3gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794234432; x=1794839232;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SCbUUn0h2JspbNaOxybvrCMKuHt7k7RPy6F2uVROTLg=;
        b=KAu5YXZRWRwGlUN48QFM3peEAz2Zz2xzEsIwv+r8cmHBHh/4JW75YA0MqFeNnooANJ
         ESuKggZhM2dPNcotjD4D/IkSxSO3HhrT+q60N4ONy7r6UhDbFKMxB7RXsK7zN45QhYh4
         4m59CtwVj5nSaqaVH7YO5oqzhw9l6gaG8X30DucL34pkS8bOV6nCNeBy9Q8aJwlP2wHR
         pOGguc/kc6XfhzVpg/jWz8bKloMs6Pvqrwo05yfyGBWJQMqMkbUo/WgDI2LZgiRW2kTz
         0uzqgyWn8gQ5QWDnwGnOShsoCFgv5JrDJED9cgUCQ64Ar+qq+6jrx0i9v1S3EVnZEzB/
         JOiw==
X-Forwarded-Encrypted: i=1; AL+hErH1UhmKXdHlRLEZ1dOge29hLZCSTfxbs6Qg9dLkfB824Yo7IH/N+3ObOobSv9fA97RDTOM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/r7G8xjFiyJHiuoGZh57uQWcdo4Zlktoy7UvsuwGww9HlBdD30
	oZFqwDncu/zo9ZPys4IPzWkG8MMJNVxsNbqzUwMNfy8RIIq74MRrY/Z7Mw/BY2McmJv5o4nl5My
	UOKpTlyAwmZb5I20sbFEIvCxl/iKSnL8=
X-Gm-Gg: AYBFou2pai81UZ4UYzMF+Pz4OMzTzFV/3r9z33yxZKEzsRzVhSbvnZUfQdcPju1uRhp
	OLQCTQ/Q45XPbk/ojeID1UUFDROOTR9qvSd+7N7+BRnJ7CkHONrE3Sw6wTDk+4JLIA/XBa95HuL
	VkT9TZYWVoH6fTPujAmdvX0a4TfTctEgj7HMPkjmUPj/HMRKDTltWCoetvdgNIuX/W8G8FVNIhe
	srv09flkSw+6xxMvFD+r8uSNKtr5PMfB+FepMERhrYBQtVITYVkxajMoSe6zwLO8M3ivksWYacQ
	lODJjcP/N0MAsZpmQkQPIoDObjjOEIwnHQIZf5GFZ8SriZ/64THRnu3skA3ItLKRBzyKFxm81JF
	9RTANbwbGU91XrdEgrlYh+lzD3U5Uz/DW/uGIu/RohDLB1OGcCM+8zWMzq1AZYpFlNKY/yXtj+D
	stgxf/vA==
X-Received: by 2002:a05:6830:44a3:b0:844:d1b5:df47 with SMTP id
 46e09a7af769-85f50805808mr3220632a34.19.1794234431852; Mon, 09 Nov 2026
 06:27:11 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2298.git.1793966368860.gitgitgadget@gmail.com>
 <au3hVGPuDyGVwOw8@pks.im> <xmqq7bipiwgt.fsf@gitster.g>
In-Reply-To: <xmqq7bipiwgt.fsf@gitster.g>
From: Joie Joie <soniqjjj@gmail.com>
Date: Mon, 9 Nov 2026 15:26:22 +0100
X-Gm-Features: AclHuK_rpJA2gdej_QqeWbtD-xEac0dPvqhYbcAgEuQCYmb9ZUpTWPSVlp87gO0
Message-ID: <CAH=d44fX-LN10TU0ZsuJ_RcxE=6QnKsHrLS4dJorAj3T55TZzA@mail.gmail.com>
Subject: Re: [PATCH] repo: zero-initialize configuration values
To: Junio C Hamano <gitster@pobox.com>, Usman Akinyemi <usmanakinyemi202@gmail.com>, 
	christian.couder@gmail.com, git@vger.kernel.org, 
	kristofferhaugsbakk@fastmail.com, Tanga Joris <tangajoris@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, Junio.

I hadn't considered using a compound literal here. I was following the
existing initialization approach, but your suggestion makes sense,
especially given the update to the CodingGuidelines.

I'll look into changing the initialization to use a compound literal
while preserving the existing defaults and behavior.

On Fri, Nov 6, 2026 at 8:36=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Patrick Steinhardt <ps@pks.im> writes:
>
> > In any case, the patch is obviously correct and is a good improvement i=
n
> > my opinion. So this looks good to me, thanks.
>
> It however does not look good to me.  I would prefer to see
>
>         struct foo foo =3D {0};
>
> if everything is zero initialized, or if there are some members
> initialized to specific values, C99 designated initializers to be
> used:
>
>         struct foo foo =3D {
>                 /* Comment on this stuff */
>                 .object_creation_mode =3D OBJECT_CREATION_MODE,
>
>                 /* Comment on this other stuff */
>                 .branch_track =3D BRANCH_TRACK_REMOTE,
>         };
>
> Now this is overwriting the passed in structure members, so how we
> write the initialization is not the whole story.
>
> Since we have avoided assuming the universal availability of the
> more recent "compound literals" syntax, which is:
>
>         *cfg =3D (struct foo) {
>                 ... an initialization with designated initializers ...
>         };
>
> we seem to (ab)use struct assignment, e.g.,
>
>         static struct foo foo_template =3D {
>                 ... an initialization with designated initializers ...
>         };
>
>         *cfg =3D foo_template;
>
> in a few places as a fallback in the existing code (DI is C99,
> struct assignment is C89, so it has been a safer assumption than
> assuming compound literals).
>
> But I do recall we made this update to our CodingGuidelines document.
>
>    . since late 2024 with v2.48.0-rc0~20, we have been using compound
>      literals, e.g., (struct foo){ .member =3D value };
>
> So perhaps it is time to switch this to assign a compound literal?
