Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795587898;
	b=RBZoZaKu9z427884nkIPfWDf/At2GZ20po/fm10qZIydbUEJgSubeF+CsnGql+AU7Gkl
	 bxdbsaAmIYaVc81GORXTtX9HIgGzipwsUBt5HDtm9qXsvTeBy8mapp7tY1LO2Nn8xdrp3
	 5kj9rY3s0mycv54Qd30QA8h6qS4PyKvnmbG1bW36/OXpYfBEI59yRzynxmPf+Gpc4jaux
	 U5mKGSn34OoSWEUyj9Y2RTY3rramU7K0ZCXZFsQzsX4L/u+Ay75GpUd+b8V/+FHTJ5pWK
	 pSR8R1tlc628tox77d9M+xr7LZmkBFA1akTusdEi4PZFdACdENC+2xhyunGH4b6V3tg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795587898;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=GhQGoJm3JdkMnXqZXFeWjWCzqkzRk3xnpVrD6bpxISM=;
	b=MfO0BI92Ti2SoDlS71d5JHWBMZ7kQoLVSu8A0j9rrdnd/ONGX3QElQAsDRpS3WYkgDhX
	 CWLe20uditSiK0HYfRBaz5+ON4dq1lnNS5YM3TWz5+YtN7tPsaWhTM1bFNpLIym7SBnXX
	 z+ssuSUU2CVCuKO9I26ynsF+jZKoXt1uT5m3VXYGT2Ncbtlx8H482rBA3CQqbwvCzK3mk
	 ULfBLoyDqCAQj8tscBMV1NBTr9YOrRs03em+JJfzhyOsjA6+PNI+QFULAUnZcgrQqQVa9
	 +XxgO3WFYd2Bh2TR1M/+FsfGAgweL+46h3Nm/Axy770GQCY3S2foTdOsMEh+BjnJ/0w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wkhCjgzt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A3C606A31E
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 06:24:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78A3C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wkhCjgzt
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-67dc7eb1442so5981905d50.0
        for <git@vger.kernel.org>; Tue, 24 Nov 2026 22:24:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795587897; cv=none;
        d=google.com; s=arc-20260327;
        b=BJM1TxPKqkN4JsdJuq3L/TNjY+nKrbF661CrqfwKJH0pmjfUXmm0Ku7/AfVJbvzFM5
         DIIqT0IME/SnBj0Sl6mHH9GXEgRXGeC8mruTX75jtiR17arB06qKpsvRT6aM4dD6G81L
         pDwLGO1mJd/hT80OCkLNwURB1tlNdml/UUi7Ewg+mqyDWGtIjddJ9pkJMUV4lSvvVpeg
         Ld3y9su2tPq0wMKkIEAqGsRtllK8KlREXCCpg1YkbAAX/PKeWs/7EgSTFAwU2VHW35Vj
         230D+1fGuVp1/BTHwt2VMmlZfEkL1vLqUzvILPPjaoXb+bhIUKeQ8f2B4mg+Ga0L5WDy
         3AUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GhQGoJm3JdkMnXqZXFeWjWCzqkzRk3xnpVrD6bpxISM=;
        fh=zEQd+5l/OBjEyzF6GIR9zxz6BTrbCyvCTKJbHzWgHEc=;
        b=FX0nAI2ghAmSyYjV16o5wvymtbE6bL9bTGZGBYNEbDuRT9YDUPXenltAYLk9e2FL5L
         +CyEKcvwqv4RoAbz2pesfOf3mHcNM9XtfK2liH+otgt6h2yy75Do5MX3Hik6SQwN8rCB
         /lTaBXhvrW5gs1CkcpOl5Wn920q0v0h/0tN5Db+b+sWEumcXS4c5lU3mpWi7RI+s6OmB
         OsDLBLqhWMZlvwIWzF+Xcwc5zgqJHH37ci7awBsR3VBNFLWZlxT4xMSsn4QDAYfuPr/Z
         IO8OxY0aqaegO7bzsEXJziF2hHt3YG7qFRLHubAWXI/bbKeMp4S6U0WdZHoQZHPTdWyP
         YzYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795587897; x=1796192697; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GhQGoJm3JdkMnXqZXFeWjWCzqkzRk3xnpVrD6bpxISM=;
        b=wkhCjgztvHUbVfkmR2L6j1TU/bTMd6RzxLQjvPghx1Bg1wteKTGwDLL/kLEss6nuiY
         cYlOhsdPWcjYeywABN3HszkrZcAMB7EDGX5cbyPzggebCsEJhafBtoBEJqK3wO/rgnBs
         AYt/hNxvaGivEWWfWMvla7ogm0CBmxuNlm+dRchTdBS6t08MCDRIFqw1O3W3TcwZ8mWf
         cVF/Fu5dG/JvSLJBew989ay5c6kqLv/drpfkTvdVmdLAbI5u9NXL6OHr1Ikl9HxLj+lZ
         pxHtWi298RbpXE98YZLmQUyJtKXr6ZLGXrWI5SeeHzinCtvcdvzXKIrrRqDHILaEhhR6
         8Z9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795587897; x=1796192697;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GhQGoJm3JdkMnXqZXFeWjWCzqkzRk3xnpVrD6bpxISM=;
        b=h0JHnROIIfLfaP4VArWCGkYlVXre7vYumOEpJzcFHI78AjcKV0wT6HcgGK09G+pzzK
         xSFVLLuM+MO7GsfzT2LjUFoLABgmnsew9R1Mu396Mbp0LNqMrOUMDcyaKIhl8iJ1jJ72
         LuPC9lLXlGHIgeaC5MpJEBf+O0z2bvXHxpi6OJIQ+fG0R59epg5c2ieJfmiKdIuNj8Dh
         06sx2fIgUqkS0rz9uAOttadeP8iYPpRQTc04L4WQpdZ2oRXKske4bmwTo05WRwGMs3xN
         7Ht1wtakjcPYpZc65CzpkF4hQ6DB0zbPoaYmX6JYK/cEf7aDoWnxUMnDCnQjUX4m24Gh
         43Yw==
X-Gm-Message-State: APuU4Z8Bft7fJlfjy2+ZYghdE/dwPXlxe7q9WuB69fCdfy93ePFq8jbL
	Rw2W0DPeTidAED2Z1DEJ1eKbA7VXZosl3GEGUKTRBv918K7aOK535Mbd8z8G+eDhVqNVlyKAU7U
	T/yh/LRQL0f4+MyT4yTJYSvx6f2h8Cd4=
X-Gm-Gg: AZFdTZfmaTgrtrUVxVvhB/MjKAY6HNer8jkj46Q5vH8MFL3m0w205XAhPqGbRhGBxCa
	GfT1YHTI+0HUmzZ3fDlov9mfCwD5pFuDwDOwgJixOibxAvwqLzI1AzMsn5qxopPE0Rgw4RZPPzm
	ErFvPrZGk+OFvvuubUcoz5OxPptyU+jUkOtNUkaSz1uK++7PlA3kvRai9hSsn8oE460istxbGjO
	FjJCe047zTGap/ENLnUOgI9beNkP/bu2fpGsk2XHj/ZoeQ9a6poKANGekW0sjMLSCEuKKH3kvB1
	3Gs9b+WaPpSNJUXGb7scnknwJ2w51xD/XE9Y4zy3fV3KT5ISwp1IEIMlYTyF4zdgUAtAB9wFby5
	0LpYiiE0nKx5KxKPzUAcxtl6T6uuxc/iAbHaAMIT2x88aTSTz65PHnW8bxyys+EZiCJpg9CTn2O
	oDbOSA03aTUNaml6XepNuXOQ5E5uN6N8b8jrzjK0+eNzXBScptl1t2y170BvCgt1raz9rzeHVT2
	oESbcvjKWeBEm/RNgTKUi+7N/ry2R5tLH32hjlWNVI6U2UmSFQinIcaksiZkg==
X-Received: by 2002:a05:690e:a4a:b0:67d:c309:5416 with SMTP id
 956f58d0204a3-67df44c2325mr8638094d50.105.1795587897386; Tue, 24 Nov 2026
 22:24:57 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105203344.48513-1-okhuomonajayi54@gmail.com>
 <20261124172146.18330-1-okhuomonajayi54@gmail.com> <xmqqld6hkfn9.fsf@gitster.g>
In-Reply-To: <xmqqld6hkfn9.fsf@gitster.g>
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Date: Wed, 25 Nov 2026 07:24:46 +0100
X-Gm-Features: Aa3M54pE6iUK-kwIejBL9E0BdJsmI10zeZWK-v-5hqPuECfaQGjvUV0YpM_aKRs
Message-ID: <CAFpMFfDcEmo_t_zqMykizu7ANSv=hDDTEDVOFBp3vdr1g-JQ8g@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] notes: start passing the repository through notes.[ch]
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, ps@pks.im, 
	usmanakinyemi202@gmail.com, siddharthasthana31@gmail.com, 
	kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 11:50 PM Junio C Hamano <gitster@pobox.com> wrote:
> Whatever it is, this claims to be a "v2", but in the same discussion
> thread, there already is a two-patch series labelled "v2" from November
> 3rd. [...] The next one should probably be called "v5", as this is what
> should have been "v4", probably?

You're right, sorry for the confusion. The Nov 3 notes-utils series was
the v2, and this topic that started on Nov 5 should have continued the
count. I'll send the next iteration as v5 so b4 and the thread stay
consistent.

Okhuomon

On Tue, Nov 24, 2026 at 11:50=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Okhuomon Ajayi <okhuomonajayi54@gmail.com> writes:
>
> > This is a preparatory series.
>
> Whatever it is, this claims to be a "v2", but in the same discussion
> thread, there already is a two-patch series labelled "v2" from November
> 3rd.  The original sin was the initial iteration of 6-patch series from
> November 5th that did not identify itself as "v3", and calling this one
> "v2" again is making things worse.  This is breaking automation, e.g.,
> "b4 am" gets very confused.  I could use the "--no-parent" option, but
> I shouldn't have to.
>
> The next one should probably be called "v5", as this is what should have
> been "v4", probably?
>
> Thanks.
