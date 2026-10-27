Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793076617;
	b=rP1DAplPZck5MOSl4YBZ63wl79dpxwzIrgOMiwx7WNwceAATkVioDxcaackWJt7ygWDH
	 pYV3PBOUfLAW8QjOQqbcMcaYXKCPDJV/hY1/8oW0chaeQnwfFdEWZ+Y/Goo+6stQWVV1e
	 uziG+NVgWNZ70/FPPfpu1hY7ThPTPf/Y7Dv2Yd7x/T9fAODV0CScyOwqmzbWzl7HrN1Q3
	 ynAukD73oJ6XOEUbvA6xT8VxsawLeM9SvQOuEqGx+1RSLGg/mgKdQoM6G/YDtNNg65SdY
	 /cOSeFqnFUgnWLS+M0FnL13ZW+Ipx6OgxRyj90+aUWQLrmbn52Ti2bIyObee3/qg+Lw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793076617;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Ansy0sMGesKJk+S30c81ssoxE65JyAuOjvY39bks+ZQ=;
	b=n2IORhq8O9ew1sWvNifsP+EmtmSVnQjumtrr2oW4uD8uNs1ysUbmYHOYWDO+S9fMdvTM
	 W/HfIvIMfNXkJEWmUCZUKcqAoL7ynln8CGXcjs74Ps5ciB+z1UiKITcI5SSCJ7hpVNBOr
	 nR4IwaQRctFh+Hqj+PzoPF56hO+7685JkgX2U/L775J4XhYwGHrfHLxA3b2S6Rw01IWWC
	 gLcbd1Q+dBHskfOuhQ8VZ0AANEWBSTCR0KiXe4HOM8V6qF/etKthuKhpP05kdWaLLUdGa
	 3NQomFrFLjdl+eu9JwI3C1ZGiIPcfTkkbEqy2TlZvk3PrdYujCiyH8FQbFbbso2KBVQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=tIn7dkon;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.174
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE61606A31A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 04:50:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAE61606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=tIn7dkon
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-93f1cf92c9eso455354285a.0
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 21:50:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793076616; cv=none;
        d=google.com; s=arc-20260327;
        b=ftPaiILVXnHfk9eMS8C0jZXRj8fLqpamlZxzCWhndaHzhiMvpNbJsW3rcSUa6tPFb0
         BItunOg+82n030vDf/KaqsNWD542V+t1QzGBUbkmrLVonXHg5SgTTtZkatVAAvxRDMAo
         JcsK7PTmAGDlZhibElLA83bUxOuhGCZcukcohJIXbtNzNj74XC8BDy/DIcYnjPhcEnCH
         8W5XSbHpSxcIkArwmc9BTzjGf5FmLXCPSZ/7nRPOZwd/U52ciLasgNcaL9DJLFNJhakU
         yS5dI2rK1XChLh7KEUiAZqKWc74uhEXDRKkQTuJiSfrNpqrFUTYGzEv8Ynwyoi3j1Zna
         YTAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ansy0sMGesKJk+S30c81ssoxE65JyAuOjvY39bks+ZQ=;
        fh=WR5+KhsNl6Tw28+6Rjj+9/34XGMZn3d8TfT3K05fK+E=;
        b=i0cXdzujSnLSkL2NaAVABRALlZq/VF8/w1WRVeXcaIvbeMBO/Pz6R+u92d5RmUhh2/
         fL9+lI4LkMMZJMywgoLlemP1RHEH5ctN2V6LafaovZ2vxxmGkV0nicNzhXu5xnZfQ077
         LwsLRPibDJMk+OD1mPgGxfYFWLOPqLifWDmppL4xuw+78If2cN4vJbZwqHsdM+oxFChG
         TZj3sI3xjjwUQL0sWYi5h2tCANa9A90hv0T6ITmSZPR8yFHSIGKJ+z3Kx7W2qE6NTy+o
         Gdi3PJ6aDXIUpLPyq7ySFN6QKVB9PLSeOIniRWK3b2ZAE78Xt3nvYQyAP5dC9VtxHOiM
         vE5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793076616; x=1793681416; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ansy0sMGesKJk+S30c81ssoxE65JyAuOjvY39bks+ZQ=;
        b=tIn7dkonsW5XVtcl+NC5MHJ8ilgHIWjfOnzdXSTSfHCebzV/iyDIcXOS0O8Zb/jlTW
         tRBtQ2RmZr1KITlxvmd9h2LrtPPi3MWliot/qPTmcpbu72RAi5GWVOwNQUuG1zWT0Hfo
         BnOMT8zWC5x/3xHxRLhJIWMMAdl4Jf7Va+sGm6TfGoBOm3DioZqAAtF8hIuLB1UjqNcB
         K6q95Z5JD4sRnhKJQyPfnz79lXfttf9SAIV0CjjRa4L1P7DL6O0taHivv1WGi6N4ACGA
         EqYJsMBeW55SGPsrfwqSwrdAo4nmSs5VPs83tF1s2do1O0NjC3HqO8vj2clhsvD+1k0R
         vs9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793076616; x=1793681416;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ansy0sMGesKJk+S30c81ssoxE65JyAuOjvY39bks+ZQ=;
        b=dV58cPdqcaQbU3Ol0Kf6ejAgkhw3ibDKmUN4HxpsF52lm4czpj+SPluVB9GI+ulAPC
         2fTyA1igd9QJu/MoaqiAQ+WBLNYSq7oN5TlC8TdNpPl6pcOWcbElSoZvkj8p04It7trD
         x2tXLS5E89XUJ3iMs2T3+ry51ErjikJj1RXvfw3T3WN0QaX24xhI3mD/iWQA9h1Z/s5g
         NqfWDh28L5fLWHIGRZ7dVCxekeCqlCJw8CWRJudrh4B8tab5rAX6NI2Jxj2mf8xM7+62
         4ODMbYfJx03Sk89SMC9RM+I+cOzSPnsOiOl0Zd+33KU7gJ6HrUB+tArL/UY6Ow68VD/e
         3pHA==
X-Forwarded-Encrypted: i=1; AKwUvByIN6ZADAJDSPSZuBgd3IGwAHfhRbSgX9Y0LApps4qsAluf1D1c6tE3TljSDvrJoz6KF4w=@vger.kernel.org
X-Gm-Message-State: AFq9FYLOA9Uz1Cx8pkCrCiPTTcwWnAflkHDYrgtg8IdQy1MAbGsMOhGy
	VoMP3ACk2yv8uxfHHy1e4l6r/2SxlI72vzkgp2v1YYJ/Enkanp1yk1sEppdoYf6I1DUqQq3xfNV
	WUztCc9peG97xyAZUrca/4jzA2ZxSycs=
X-Gm-Gg: AYBFou2CNf+ETHGb9+g1A1IGNJU1frC+5WhcJ8mDg+ImlX9InGSHjap6CVJgOudWwuX
	/qOP6P5qlt5SohZyIHUuDtUrzllcaM2Jr3dxgbMzYqARn3F6R6Id3HxiMOkkO3f03tVccDKMkSc
	CHNR1VSqLKezQs474cA4ECdrn/GA6JF6pKZRFBTPOywu23TIQ0X8FpbHd24jPD0/QVcS7+UiuCS
	3QHG5XkvDr6sWiZGDmiGS0EBWL5LutIW5WkYhQrncdYWbRHm53RhcvNfSyUXNcml5Q3GWqctWhK
	VMMDE3owL3TFl3vBU6JJTncA4S/VR6dkLQQ2x8jAAwHnX2cS2AVNMBCz/UEaCGFAFsaE93gD0fh
	Tc8bNq/gzAwpvcWJiwjiik2N6gPE8updmFiAVihmDzwhMwyhpVOcGuQxB6iZuB74kmUBy13Q4bz
	RX3VDRRHOU9Gmqrap2SysvB175QsO0ar4pm+923ib4b613E3DRQb0TWmsF
X-Received: by 2002:a05:6214:29ca:b0:91b:7656:ffea with SMTP id
 6a1803df08f44-91c48e42d9emr148716486d6.35.1793076615625; Mon, 26 Oct 2026
 21:50:15 -0700 (PDT)
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
 <pull.2276.v5.git.1792956031588.gitgitgadget@gmail.com> <xmqqpkwwqs6i.fsf@gitster.g>
In-Reply-To: <xmqqpkwwqs6i.fsf@gitster.g>
From: Srujith Poojary <poojarysrujith@gmail.com>
Date: Tue, 27 Oct 2026 10:20:03 +0530
X-Gm-Features: AclHuK-pjVf6nu9HknHxYPrR6o0tzWSDgK9h2yL4hfVJUC5diPvg7yEmR2FOoe4
Message-ID: <CABh_KWiSgGWGwFepGh0YYAvusC3Lc8W-8fhw+-dmR6MT+GA9NQ@mail.gmail.com>
Subject: Re: [PATCH v5] diff-delta: use safe integer arithmetic
To: Junio C Hamano <gitster@pobox.com>
Cc: Srujith A Poojary via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood123@gmail.com>, Usman Akinyemi <usmanakinyemi202@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 11:07=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Srujith A Poojary <poojarysrujith@gmail.com>
> >
> > In create_delta_index(), buffer sizes for allocating the delta index
> > are calculated using arithmetic operations on entries and hsize:
> >
> >   memsize =3D sizeof(*hash) * hsize + sizeof(*entry) * entries
> >
> > To prevent potential size_t wrap-around when computing allocation sizes
> > on 32-bit systems, replace manual arithmetic with overflow-checked
> > helpers (st_mult, st_add, st_add3).
> >
> > For the unpacked index allocation:
> > - sizeof(struct unpacked_index_entry) is 12 bytes on 32-bit systems,
> >   which may be padded to 16 bytes depending on compiler alignment rules=
.
> > - sizeof(struct index_entry *) is 4 bytes.
> > - entries is capped by (0xffffffu / RABIN_WINDOW) where RABIN_WINDOW is=
 16,
> >   limiting entries to 1,048,575.
> > - hsize is the smallest power of 2 greater than or equal to entries,
> >   capped at 1,048,576.
> >
> > While entries is bounded in current code, using st_mult() and st_add()
> > guarantees that any unexpected growth in struct sizes or bounds changes
> > will safely die() on size_t overflow instead of wrapping around.
>
> Much more useful for future developers to learn what led to the
> conclusion.
>
> > For the packed index allocation:
> > - Passing (hsize + 1) as an argument to st_add3() is safe from overflow
> >   because hsize is capped at 1,048,576 early in the function.
>
> hsize+1 is *not* an argument to st_add3(), though.  It is given to
> st_mult().

Hi Junio,

Thank you! I have updated the commit message to correctly note that
(hsize + 1) is given to st_mult(), which is evaluated inside
st_add3().

Best regards,
Srujith
