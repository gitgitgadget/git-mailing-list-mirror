Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE293909A6
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 22:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772489225; cv=pass; b=VuWL1S81Lxtpb5zxEDN9waiDWC64/H2bbpdIYwnlKialcAduw/5SsmcR6ck4jWc5cUIQtKJRXloXN34l0uytg5TxfiOtJSeHGqcpsT+XrCsbgTOS2/yYUax+Rw8AEfDIs8J3xqBK3w7wnEnLkKVJO4FQmVFdy3POBlfqORMF/wU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772489225; c=relaxed/simple;
	bh=V9v8Z1sY/13639Y3+ANuvc1vIt3Wg0ijBqjxICkBOCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SfzGRbVlafkpFIlofpgddlK6XPmjBu6S3cJzP0kJA7bH5cW1fGlEG8quGli+aputhBJYhhZbcZVbOezZwjnvbkCuwhW3c7myOqiKIghvn6k0FNfmIkEdn4izoc1d1KYvem7SAKfoQgCNKSGzHonQjfgBOvN8o0s7+qyfuznTPjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJ+uW57j; arc=pass smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJ+uW57j"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-679efb9eb0dso4066399eaf.2
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 14:07:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772489223; cv=none;
        d=google.com; s=arc-20240605;
        b=kHsZb2JPoDWQ8LJISJafdQowCljoWQupayxb8i13R4FZpUnLIB0C9Uzv4ACGGtuy5f
         xs5lqWAc7d/C56Uigbg5k4t4JXWMVT/ryydyM2iphl8tZfjaZR51jLidKzxhwgS9DMKv
         HwbeKKRZ69BXG+W6uZdtLACInELE0M9TgrBTgCkhOUbhTlApRX7PMv3EDdjBzs9s6Bzq
         4uUeTBtnt9g+KwLuB9TSvL91ptoQe9x6K5T3Mg3saZS8LCF9b3nrSNRPeVTR/udmAdRB
         g3hvs5MSX+dIfD05N3RVN3RImgCdLlCRfdpdSLBy7GaYUN4TvVOCcVzriE7Itdz0pahQ
         p65A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uVOStCJP2fjqZwx2VbyBZ212LFqfPedNiVX/Cj+riTc=;
        fh=ys7jFLGFQ8bKEn+O1quCi/vIRLrqjZzNEcWyHAxSCPI=;
        b=KqG3VxWFmL2ATAgP5axyqRCAnMviGM1lD0gWxneLy8COar0bdED4oxuEK9XHdhUxgx
         qaNx0lggDHndU7CBwniEdd7xJPRCsvZa0wQPJwNgM2/qQxt3XCwRU1KRxKfXnp+Rz2T/
         elJdOb35enso2bCi13jlLk9Xb2M5zecOqW1FlbhYD0nhmWwgGtQLMRgoheZEYvdQLPBS
         epmFPdCjR42yiO3Qh+kltUjnyAWPSTtTsna1TOGhPleVCtMIMxpSpnWNl/VTGoVPA9WE
         1Nm8zh+1S4LpXQ/5S8TX2lDsn7ZNKc/IWCDZMfGPmAWvGSquGLPv0HBzcSNQIGum6tib
         eDug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772489223; x=1773094023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uVOStCJP2fjqZwx2VbyBZ212LFqfPedNiVX/Cj+riTc=;
        b=CJ+uW57j6icsHo1XhxoD3Tr/NQaqWkPGNEw6u+H0t5xT3bCg10Pf8RRvUOJulBn0AT
         4In0XutUd9wxl7zCVKaiNSu07mvG5AJ/tFBK9Uk7qeubsFOzkdXTfnerOe6AAh0wGYdk
         wDEv49jiWkDyC2tClciwlZvqG2ArGjo1OMGuE1dKeVgROeuvvfHMukmIiu7J9ccLlxuG
         PzCX9AfoyK6x0fzYcEZSSm3DkQEUE9sJJYmebBfUrfjcFzE2vT9rzAsxrpJ1pouqqZmx
         hFf+1OPn7howY+seqdszx87TYgstl46XggTHTUgVMykYN7VfZW2waWfLski5xn//7rBd
         pd0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772489223; x=1773094023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uVOStCJP2fjqZwx2VbyBZ212LFqfPedNiVX/Cj+riTc=;
        b=VlxI6Pa8S9dR5n4XaG5ZcSqcWtfrGvQp5qRFLVy9bMrq6OrSWPdUg2h4KbL9bZHFmE
         3kOfonwZP5MHoCxICbJL62kRnpj1o8QSdyOXpz+FM/oE9BvOyNmfq2TH1gp5Rr2RMyRX
         dluKu1ykxS1zdjcoKFXANvAVz+Ct/f12pkhbNpK79vo3fvhpr9uyvNCRZZmFFuR13QTX
         gfWaZ1lSz+UYVUpRuhjLjEP+H0+x1eLjOA9DfabNyPgsmyzCYzurAbYlGUHlNnjy0v0v
         4PM69/C1vYadXrPWbmLYTpEGRO6sv+C6fA5NWqWTx53zdQwhf9O9SP1x3IrsvLvdSxEw
         uEmg==
X-Forwarded-Encrypted: i=1; AJvYcCXj6L9tc4wwb9diICqc93TElWBY2PH0bcJsTICbsGOVFQoXj5JglFAhgegbOQWuB5ovGgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKfC8mtGMAH0yn7sg6C1DXG5ojoiQtBt6V4sVV4QOvz4srPXam
	TPnZDKalFWDYIeVZKW49O6CgY2AaUAmP9IPf1sh/ux3bWdCHudnTvXK4uPFGJ1p6JTLP1Oj5IOZ
	jfDnyAKqfTOgQl7fdHstRlONrBHsl3Cc=
X-Gm-Gg: ATEYQzyzy18GQTmBxu7L2fTWMZzqPNCWiteCW3t8Q//Ex9JhQGWrHOdCy14qiv79lKD
	AfGgAmWiaq5JBu8ZETsahuySxHN4yFbq7lWHvgJTaNz/3RZsmW8fyKmWs/elOyU4a8OqFQxBApR
	YJHCKXZJDiexIlV175FQZIUeYdXBM1JpwbaAVHWxGZ/5efOUrcwMShY8nAX++fz6ScSBjr+2saW
	Xr37auCAONHmxTmk+pu+UJPSZnChqdpteRHZCZoPLZipSYeCves5Xhs6btgU/cbyQn6CA5oOBl1
	cd+itw==
X-Received: by 2002:a05:6820:1794:b0:678:f8f3:d6dd with SMTP id
 006d021491bc7-679fadc26abmr8372683eaf.8.1772489223540; Mon, 02 Mar 2026
 14:07:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114194815.1049888-1-nasser.grainawi@oss.qualcomm.com>
 <20260122152722.866341-1-nasser.grainawi@oss.qualcomm.com>
 <xmqq5x8to53y.fsf@gitster.g> <CA+P7+xoYA6zhwVeCV6d5yW4ZxOKNLam3r-ayEDHpYpFqWyLduw@mail.gmail.com>
 <xmqq7bs08p4r.fsf@gitster.g>
In-Reply-To: <xmqq7bs08p4r.fsf@gitster.g>
From: Jacob Keller <jacob.keller@gmail.com>
Date: Mon, 2 Mar 2026 14:06:52 -0800
X-Gm-Features: AaiRm51I_xczF812Brs_1vXSkpUktET6-AMJTTIfNvpcYICQLNXly-R_AahvnnQ
Message-ID: <CA+P7+xqtupp=E8+MOOEJ-nB84QnTXL7FD549LwEmfQiwoUNHzQ@mail.gmail.com>
Subject: Re: [PATCH v3] submodule: fetch missing objects from default remote
To: Junio C Hamano <gitster@pobox.com>
Cc: Nasser Grainawi <nasser.grainawi@oss.qualcomm.com>, git@vger.kernel.org, 
	"D. Ben Knoble" <ben.knoble@gmail.com>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 1:55=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Jacob Keller <jacob.keller@gmail.com> writes:
>
> > On Thu, Jan 22, 2026 at 10:49=E2=80=AFAM Junio C Hamano <gitster@pobox.=
com> wrote:
> >>
> >> Nasser Grainawi <nasser.grainawi@oss.qualcomm.com> writes:
> >> ...
> >> Thanks.  Jacob, this v3 is not exactly the same as v1 that you
> >> reviewed (and range-diff relative to v2 does not capture what got
> >> changed between the version you saw and this version), but I just
> >> checked that they are "essentially identical" except for the
> >> proposed log message.  Are you happy with having your Reviewed-by on
> >> this version?
> >>
> >
> > I re-reviewed the patch and everything looks fine to me:
> >
> > Reviewed-by: Jacob Keller <jacob.keller@gmail.com>
>
> We actually needed a pair of small fixups on top, but I presume that
> even with them your reviewed-by still stands?
>

I'll re-review the latest version.
