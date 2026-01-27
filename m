Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327BB1DE3A4
	for <git@vger.kernel.org>; Tue, 27 Jan 2026 18:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539737; cv=pass; b=NDGFo4sF1BM6ABKq1zVr9V5yLc5TiQ5PnRltr3Dy7Hg7E0QIVZc3alaa7ZSZC6jgbK3WYG5leh0p9qepv815mu3f/qv7Yc5nvnlq0xTEk6Ob17/ERa/TQiO2CfOeXiMGYKdQJFNpY/x2VPdpPKpsaH1WRQjEIPuFwHRGh4+F5ms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539737; c=relaxed/simple;
	bh=TNxTf/aJR2mH9Fw3w9FNg2rNIyUs3WXGvDYSTWE/Nik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pp3OI0wbn5HKbIS2YltqEdUrsz58xru4RGxCxFl4KuaE38X6XOmeAfsACpcdAWixz2XrBKeXSPQR03lircOUJZBo6et/vS3F0OZqU5K/psq86MDLS7k7gFkK5hE4EptLX1oFEEuMzyd+MYek8AGLOyALiw13xCIifw+bP/b1ZYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ay30CEWa; arc=pass smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ay30CEWa"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-34c5f0222b0so3139081a91.3
        for <git@vger.kernel.org>; Tue, 27 Jan 2026 10:48:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769539735; cv=none;
        d=google.com; s=arc-20240605;
        b=MdhMgo27NJHy+2lCdUVLWfKVGYdt52hJZtb6z0vW1L+NlSRyvD1UN9MXb22axF5G5u
         SAURGAsi2gDC5pXlELRE0wm2wOkUfUFtJBIHD9E3q6Obt/fvIc4zZFX8zthCtt0j038F
         kM/Qn5XloePk+5Fc1b7XLGjZbQKxGE0/v3YDcymPTXlr7hN7ZiHCZ+RpBrZoXcfAIEv4
         Apr+B+PnG+jGEpFlOATwiV+vRifUuJtC1QeRzcgzLLIPnXoLtyqSLQlqwqA+YpU9skKl
         CLDMxeZrgZ+Qnr1tWZ6GcjyMfDIYYsKfWhwCrQhCx2es+q7nlOynzx8XTAzTha1blHKx
         2DVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PjYaUIVCVal0PtCGILPkAFVyUw/DikePCdGNDKBtoNQ=;
        fh=V1wpeMKeTEzt0+4MhXfoj6A2o+fxunI3tL3164U2iNM=;
        b=TLcJQttTIT2xHN8ucEGLdDVjWMgdpSXSdNWPZ3TjYmGiulYZ8Zovxit96m1/1bxw+x
         2roc7zVmfGkYZ2dlBhdlgT7h8dW52GRzAMgLdhXJQmFsNhPpmCmwcKJql+RL3Qes76yy
         oHjKTyJrKyC3L44K32kThHTtq/GtzSbRxkP4PtfTchQDYNJla45OlxJnl5MZLx/4pakF
         bvZij6r/gg6TeOCmVqgTn4d+N4iqVZvoIYzU7w4u3upNEC4puxiQWtZj2Hxn2Mdl9BI/
         mTC71tAIEUk7lqo/3fJcwiHihdDPwPshfcaRNd7bzAt+k3C3E+hRCwxH1X8w+Yd1ygen
         8nig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769539735; x=1770144535; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PjYaUIVCVal0PtCGILPkAFVyUw/DikePCdGNDKBtoNQ=;
        b=ay30CEWa+V6xPdj+GdtRct782KeLyP+xnEE/gY7u/rMNgLSvAC2QYbeFwEMFQnQkuS
         iKbKDAyf9yAdmgGxRkU6EH9Kd+kbwcZvrwuTLXwLtAm1gdS1RxOYgSLj1WmXIRtJnnTw
         B+Z3BLTQ+EyXfAmK0dlWitO8+olZcJslcp13zJCP8ofGPBVrgnazCmFlnJaqdI5b09dE
         006tAf7kDPRe6yHv0DEzVLhhSqoRik8AU6NPIr/BTTEjyuICzVMunRn8LL7sFlqI1vip
         C3yNj4h+q4RT0W63RW/ZnuOkgqFJlIHNWK930n51ixyEfZOm/i986VQ4Wqv6GssmTf72
         8q6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769539735; x=1770144535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PjYaUIVCVal0PtCGILPkAFVyUw/DikePCdGNDKBtoNQ=;
        b=ABPCXxYnINEOIe5EWoA2ipfHagtW7xvBJAjEP7GlTx5iqX2dTbTAKiErvuI7LgEvQs
         2LtILdHoD+AI6jz2H7Iq6BT1t04lxU7BcUPREi+4XH6L5C4uaPA9Fc1aQ4IFU0rFKHC0
         wc+Wee7pyABpW879lKUqxnOwfnYGmRNZ/5FgJEWbVfzuoYpxOc1EaPF7MEaJjW+nPZ62
         etTJ6AHbRh08lYFWK62hgk+e7DxHVGB/KPMUpAlCEyEX7hmg0sUIjlqFo3X83pTl+XCu
         oNsqHn7ZkQNN5WK45o3wjIzFUQgvYa352vzXDKfU+0SepKRm+liZYChpPjLNRZb7u0ZY
         jKBg==
X-Forwarded-Encrypted: i=1; AJvYcCVqMdPoQ2nNCAXp+ibgUbvd0C8/ppEyrL4+rP2C5YvfT2DX0q64ufYDEoMsx4kBmYW1mcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlLYpn8jvQsmgcrCsdHdnJNDM82T1RIrGJSiBh++z5xxQYEJIw
	jsW+A1xFpIPkdaI5nP0hw/gyxv7bDWQhQdad7FXIlILfUOKlP0mDPCSWYXWQkqy33KUyLxc8+it
	CIe4UT2ce4FkG/fnEAe01KHnhV4swmHY=
X-Gm-Gg: AZuq6aJWqgX6rd98QY1Ad062+2x910v9jD25nRONmazfnrt+tOwAhqPIe07zLv2+ybB
	zhUIA8n8KfosqbUrYgaiviW/+m+GSjd1DTS7sOE/fOV4x8ih2rQePStMMdV603cRA7j4BxTPhS+
	ebIVV+WaRD8SEs/jKqoFPSks9OKMZ+f2hB6Yd0iQrQn47dLgm6Jjh8u8o638cVX4iTxi2tjFGel
	sGrWMU8W39Oyh2w+BTRJYPj9chr32K+/+6g+sHCS754zpWWEX0573ExzediFIGfWdMRc/czd694
	3pf+r8QO4nR/kkqXoGKZUZzZtRLV8yPbAen8hF+2OUc+9bMunxA1ehcZ1g==
X-Received: by 2002:a17:90b:560f:b0:34c:fe7e:84fe with SMTP id
 98e67ed59e1d1-353feda72d7mr2327073a91.28.1769539735454; Tue, 27 Jan 2026
 10:48:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <01a7acfaf87494419b3766da57d4c05cf99c79bb.1768873599.git.ben.knoble+github@gmail.com>
 <xmqqldht2fgd.fsf@gitster.g> <CALnO6CCaVdJQ2xSPfvxQzVCfPsjbWHhMFUiLoiPQtVn9MeKFOw@mail.gmail.com>
 <xmqq5x8w2t3o.fsf@gitster.g> <xmqq3440x8da.fsf@gitster.g> <xmqqy0lrx4l2.fsf@gitster.g>
 <adfdcc47-470a-4424-9268-31699decee16@free.fr> <xmqq8qdrvsnj.fsf@gitster.g> <CALnO6CDGan9k7pfrHcNG09hVLCrvGrJv5=G2O3Wgp4AT2i6reg@mail.gmail.com>
In-Reply-To: <CALnO6CDGan9k7pfrHcNG09hVLCrvGrJv5=G2O3Wgp4AT2i6reg@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Date: Tue, 27 Jan 2026 13:48:44 -0500
X-Gm-Features: AZwV_Qi78cfGKQ9pe64d6a7e60qNbcmlJOLVOd5gGpPv5Ppso8dfaZyDdoF9BbI
Message-ID: <CALnO6CC9HZw96EHVpLyaekSUe744zTwHzN0ZH2UhW42sxUDU3A@mail.gmail.com>
Subject: Re: [PATCH] replay: drop rev-list formatting options from manual
To: Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>, git@vger.kernel.org, 
	Christian Couder <chriscool@tuxfamily.org>, Kristoffer Haugsbakk <code@khaugsbakk.name>, 
	Elijah Newren <newren@gmail.com>, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Sergey Organov <sorganov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 3:03=E2=80=AFPM D. Ben Knoble
<ben.knoble+github@gmail.com> wrote:
>
> On Wed, Jan 21, 2026 at 11:26=E2=80=AFAM Junio C Hamano <gitster@pobox.co=
m> wrote:
> >
> > Jean-No=C3=ABl Avila <jn.avila@free.fr> writes:
> >
> > >> The original comes from f81a574f (doc: test linkgit macros for
> > >> well-formedness, 2025-08-11); its author Cc'ed for better ideas.
> > >>
> > >
> > > The initial motive for this script was to catch malformed linkgit
> > > occurrences that were present in the docs: stray git-foo[1], without
> > > the linkgit macro and misnamed gitlink:git-foo[1]. Not knowing what
> > > would come next, the regex was coined very broad, with the assumed ri=
sk
> > > of raising false positives.
> > >
> > > The issue here is in handling the ifdef macros which are block macros
> > > and are more easily detected as such. I would reject preemtively line=
s
> > > with '^ifn?def::' instead.
> >
> > Yup, that is much cleaner.  Thanks!
>
> Thanks all. I always forget the documentation lint target. I'll try to
> send a v3 this weekend, but travelling, so responses may be delayed.

Looks like this was queued and merged. Thanks both!
