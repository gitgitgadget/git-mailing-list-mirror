Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793040564;
	b=Rqv7JfKhNEgHbQBr3++e+uvDaJE3tXWQlSq0LmTrvf4X8yg+8WSakEmhqJigMsTRVdEA
	 QKOeaGmQHEWVOjBamnyBsswmsmLKF/XIX1DwnTPgIIFR83TAr+5Cu3q66pAQOUF5xJfH2
	 maETHnEvR/M2ap2ejZeR5BAPXzKkqiqsqei5lXXil+0GfBvbZzN4vbUIz+65E2tGS2n/G
	 20M+iSxo5/+cAGfR0gpCsCt3gimxuyxxsl3VdhiDV7iu0fAY++OsEFPtNCb5bpSOuiqih
	 DCHYAW82QyAPNsnRN9/3r0cxE7JRiE/KZURckaEyO8ZtH+/SippYs1Q+TuPQrIDotKQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793040564;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=fTEcGxKj+rT6/eocxiavxh/OUoiptzVcUE85r1Ts8YQ=;
	b=0rp/SsbI1TGjhjb5QSITUn4TDSOqRuoBDSP1Y8bFXMKZUie6lMEHSpRfPMjDb+DrlzBI
	 qassHP8d/QhZgujggLvebI4XoSDgp9mGfPSf8n97rL4sO/3zjNXXIPnJJWvOUitczIjSP
	 Sl7h8a6STse+hSgiXdY1MJun2v6/MgX/z8/QW5XHKPLCYnkQ4ikSNIBu7FQ/3TfB44oJo
	 osvuwW3uJEKYSykdkJ0Q6yPw7FzHji/78xq4vk5yA+HPIu+DVL8cHt9t6Ae7YOhsutSvj
	 4hn/6CT2PpiqtjQwX9eNTYD3DdO8OmWctbEgJqWcLXmf449jWQwSuMGOKJW7zBglGPQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jrLfIdqz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.49
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFDF606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 18:49:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1AFDF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jrLfIdqz
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-917a64f28d0so2224136d6.0
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 11:49:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793040563; cv=none;
        d=google.com; s=arc-20260327;
        b=O7IXNDBz/4ho9Ya0HMlcOr8iNzfuQyfdEuF3If/jlKsbeG7byamNvxtgQaPJG46q+1
         QSjlD7Wu9LbVP4o3qZZnuV1xZgjgrSMhTN9oCYxDL52pudgaVnIZ6hBoqrPSI3tw1mvi
         VDWU3/mIe14+rlDE2eToFzw0pv9zuIyIxZx0o5NaAm17CxcM9xbZbE4AVTyLVlynjYwP
         T7DyG6zpAb84s6hMeQFm4VXuWhFfLJC3e7xZ4XfAX62QfOgvw02xd07u64c2SNseGP6j
         SfSQ+iRhbKjJA4cdXlyFSSOC0f95WCk7WlDyf6EFC7mdv3xIVdc8pFVmllkBa3uP205b
         1xGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fTEcGxKj+rT6/eocxiavxh/OUoiptzVcUE85r1Ts8YQ=;
        fh=JhiuiuAMwJKzPrxKexo06m7esc08wcAsD5xIPo26gQo=;
        b=L9JeA2mWXO67ww3Tfz4rkVNU4tTtHKI/SL2BVjtaoMFom8WFPEB0KAu2QxRvPdiamw
         1yhWm0ZrijNjLIyVLsq/4KhwgeevVYJZRdYCUH+EEmMr9lTdwZYHfvO22hpugInt9o4s
         wU8AdReAkx/6kJHnHNKjog4DaL5xl9TF+/qUuFZ2fb8Qvee9eqbVLecqX83k2L5V14DK
         3uCUonYPaNG9y7CwqgB04VXr61Hr6a6xuHy9f/T11ngVPNwpbLvRb7ztAQbp+4m1GTqE
         6D9peMjXTV4pdSLNa4HtdpxLBxTqKCt0tP0+1g+WTG+f5xT12teKHUDntIXBP41COvvV
         N6iQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793040563; x=1793645363; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fTEcGxKj+rT6/eocxiavxh/OUoiptzVcUE85r1Ts8YQ=;
        b=jrLfIdqzsd0hgNFbhW7HPjt6/SLach3qSHy3fnOKEXzWbckXVWYTAvKXfMCvZO0np2
         CFjUaOgphpzF+TCceNKrCvZrvgXx2ED9N9z9RTulv4TNATjHG91iSOC9tOwAsCEcIB7d
         J79uPw8qCsfDJPy75ToAjSx8R6GX1uMB7X+tphRNPufV3ouWX/9PnZ25F4+ctKcPHJ9P
         x3bTc8NjSwFPv6CedYnOJmxuwz+SmAYqpr0g2gsc0EfWLrbTPyyUPsxz2jNX+vj5mxW4
         s7LdgL0p7+w1wQm5hTKOZNmtXY/dRX1mWJXKTKumSLoANp3tkh55R7GYWMQPCnGck41K
         8Krw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793040563; x=1793645363;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fTEcGxKj+rT6/eocxiavxh/OUoiptzVcUE85r1Ts8YQ=;
        b=XtU5kggNtSrsZVyHCNQPkB60oF8N8zBXL0nj0PkWMYWivh37v76GvJeFU3FZlUm2S8
         NX9UvgojXdvU8mzz80elc1F4OtyNFMLBe2v4vv6VzQhhKM5LmMS/3LGjImqENMavQA62
         K/TIrRnwY00aNZE8gh7KUnbgjiPxNRsqFCONVQDxOwiRUPi5w70XWcJuP656WVLrZPWX
         osg1QrmlmFwozXA8pYdrozkMbioNfhJWb4Rq+EdXRW6C4F51VWcIdew+fMh5pgeqOAgH
         x89byyxVPbuTKSi9KMH90hJ8RRiugu47/ojgIweGHhic1rfr9bdHE8smvfawp6Ee9dVs
         SfpQ==
X-Forwarded-Encrypted: i=1; AKwUvBye/B1f1GGB6R6dqnNfESIj/zkeA1IeSLOEAuFewlmBzGC6y/g8nVqGi6CoWJryP5q4Zuc=@vger.kernel.org
X-Gm-Message-State: AFq9FYK/x9ZyhhAovyVr6a3R93BKjm04Cl3qH5h+DBGGw8iuBNnj8u+e
	W5j+vNo84e3ZlesBkIb3Wf/cGuzEgzAfGl1uUDAWSdhyi/i6sTepn7LY0lyIN2mMuQ9xI2z7Jfh
	TVW6RJRzBkr6Y1ScU3xadonlpVfRcKQ8=
X-Gm-Gg: AYBFou2ezZ6wY7PqxhWT+juTEvIpr9Qcae+Rgt7UWMS1tOAHLnT3dajyPqYrfkTX4+S
	DVS7o+F7Qt93F1dHbYaWh/Tx4ddnOGdcJWs9cV3yxmiysI9pKCfLFwbfXHl2FUuGx/rbCTamng9
	aBvWyFMS/R9fTbLkDbJqWOMSZBvwQHzAtQqotcwD94Oxi/HYFWd947UTll8ja0vGdsEBMLGqMWj
	LpnOlQpTkiF74EFsapHvldKrgxMiaDGnqczLor75o4hjEHYgnjgUzkvgEvxDB2KmWScVmhxrKCr
	kGlmv35O3XyDGmpcvUVGsyQ/s6mrK7Hvv6rl0VQbjCDl9r4yIfMeb4ABY9JxtNuHV0yc78sr9tN
	YZ4yNTQuzfwuBRO0/L3ggJ70XieuLfpA6aH92ozHP77P4pjCgqav4YljmHOx4xbqJj74c8heRzG
	6rfiUqm00nseQc0fIcs3cuCHv4xHB60fuDOuwKZ5YKnw1o+rsR+uEO16rI
X-Received: by 2002:ad4:5ce7:0:b0:91c:6cca:8268 with SMTP id
 6a1803df08f44-91c6d483961mr10515336d6.33.1793040563046; Mon, 26 Oct 2026
 11:49:23 -0700 (PDT)
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
Date: Tue, 27 Oct 2026 00:17:40 +0530
X-Gm-Features: AclHuK-7ExuQ8hk7vpMvTnp4acb6eLBFYa2h85JkGEPIph76Z8qnSyERrXH4noc
Message-ID: <CABh_KWiE3g1Gh3B2VmFKNNASFpCXkmxGsZDvp+ESymz4eqSKww@mail.gmail.com>
Subject: Re: [PATCH v5] diff-delta: use safe integer arithmetic
To: Junio C Hamano <gitster@pobox.com>
Cc: Srujith A Poojary via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood123@gmail.com>
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

Thank you! Noted on (hsize + 1) being given to st_mult() inside
st_add3(). Glad the expanded breakdown is helpful for future
reference.

Best regards,
Srujith
