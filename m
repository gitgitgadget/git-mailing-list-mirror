Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795512423;
	b=Z01Y/3p4ujIBxj8r/lFHfaV5kiwnoksj3XzsRMb4E89CqsDEF+A3oWinINd5kZDtuInx
	 JTldhze0vd/QbW1sRe40OGG9Lwen9PPbFl6AC6rR8JYQkerfKZq+4+p1pfQlyS7EL8ZhB
	 9PPkxyqBXNGzXfb8235jgPt6R9c4ViWrDFrQHbOFzQDJBB19bDudzR5zeV5xEIddzPrqT
	 wOzkCYwgVQ7Cg0/+gsmqU1v3RbxvvgbU/356DMwC7DHdLVrifikVqVFG7LSPEIoCfD0t7
	 /GiEv5ciIIX8/dy5scxVIYvEp92O2J+pPKA4bL5TuIX2Sh5MUjmgid7zYOYBBl4lcBA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795512423;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=LmMJurKIM72cJeLofgbnvExecNEppj8KTsXvN6Wlj0E=;
	b=Pq4vWxUaSYqyHIxr/3hnv8jhz+VEmL9qS/rpYDVWYjeFWFYYqt0kJ4aPreS4ODgx4rsE
	 pHcoI5N96c1IDhrWjJOjmcRhIJW0deVylAb0NL7VnZQ8UM3xF/GtckfJydCnRJDrPGvaP
	 VvYH7szvM5+fqav6bk9JWRmk2VjRswslSHO29KJWea/bd5WRpeYwNuLJDF/QifPn6C15f
	 2E4FHEgAEHYiMelqlvOS3DF6Ppe/zZ2IByWcZ5guaC46Ghi1inFHDUUWHvsKwlpoJruq8
	 cXPLHLOHJZ/hf3KiGvJB00Awdn054SXxiX06xN+fEuUWpg9JaaQjOaK5PWbDwdXKnvw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XJ+otSkZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DFD606A321
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 09:27:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12DFD606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XJ+otSkZ
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1b24f4b15c4so1757474c88.1
        for <git@vger.kernel.org>; Tue, 24 Nov 2026 01:27:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795512422; cv=none;
        d=google.com; s=arc-20260327;
        b=CNAlKuNfROi1SLqCRfJ8/PX+P0FewPnGWrrfAC2s5o9FUJiXFMjPqs7McvWLvw4mbS
         dVGFem0SBx8diXjSnqTNB9Z0dAM/4js32BeB7OrvU1hTR7bH4IMYWM+Hs7GMg8yPndTn
         w7NolG4j5dHjRl0N+Ui4+FPOKVJnO7ArXu4r8kqhjFXYJRDYCEHBHCBxPnM/dYEQVAYN
         CJvI19bzv4pPiMvgmnU0gQdGBYmHRb8y4qtdhwjJmo/95EtJ49rwBzUw2YPg/8UfHiDp
         Nkfs3liH9rlGuUBEj8B1p5R9fzbYkD3r742gaPU03VDBarIOOje3t9nK3yYPCb/bB1NC
         dZHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LmMJurKIM72cJeLofgbnvExecNEppj8KTsXvN6Wlj0E=;
        fh=ruKRHKsbJ0pB2ARoPtEt9q9HMfbpL8EMflzR5GgxdXg=;
        b=T5NB23hBtDQVINfVCM96pGFd+yuZ/g5nEsBP6wQMF3L/pUB15TL9T5y+uhE1tsXZRl
         lx4Psd/DtMgmDSlxO0JOD0le1IBnmbXMrcLbe2uRib4mtKD8HdXzrspmcmYs5b7uUtXO
         nv2ag2UX/FVl+6LXbPhYqCvkyKTrsV//t4GrC6FONFaPr6FkDB2EeAYgkWo5X0+IaTIz
         I3Kr1jBqQSDkZ4alemWO2zP/FpVA86KyCMSSK03gR3W4XJiAkGbqmsCGmHgv14pikk7V
         3WHLQepP5gVD42V8XbS9a1ulDbVQtASbD3q0yEzqi8hotg5NUm4g1Xk2Kc2AGuSTKRta
         ZCBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795512422; x=1796117222; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LmMJurKIM72cJeLofgbnvExecNEppj8KTsXvN6Wlj0E=;
        b=XJ+otSkZKHRo7gTM5xJjjPRHzKVCs8n4ZUBUbpFjTS567OHIdi7KccJvxiioIDSvCQ
         C3jZYWAvE/iN5ne2kjkOFUrui43r64g/Rw3XbCFWPw1gVmPcsZU1gdoB82AS+uzEulfA
         dtlyIDz2KufiUgzeycKoBvVlnyZb/cSZyuHB5oB9hpNmHOsWvMaI2ejU/RPNPJOa2/2P
         3pbV9zp+Nybv87XeOFmPv+Ic5wWqmKauNyx7S2dg1r7p1XZ8BtoSCtwpvJN4Bc1NlOaX
         77rxAfIOEzQvebXV+nX/bsyaXzftwJCmJ7U19gXUmJtU7vn2MLePSMkDwuaK9fxeOHUd
         SR5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795512422; x=1796117222;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LmMJurKIM72cJeLofgbnvExecNEppj8KTsXvN6Wlj0E=;
        b=Bzu0imyuc2LffDwImBTA+B0B3h/8f3RYOB71qfGTSMAo7I5Q1Si9mglFilFd0GWn+b
         Lffh0sdJh9ezIoalHjECDoFx3HNSI9rH2cVCZW8v+AMAHUMxPmRykeJ5ShwlWgnM+cCb
         RwpeVMcYm9jk7xjhZdwPOf63XZ2xD2I4c8AbCJU2n6UiCjYrUNYJkaAfWUWHdftNLq8d
         7N7RLNio2mEvVwrdREvDl5XjdsHXUFMGRhl51Zx8HXdRI9yvsuk2aTmS/9qttLoPTC+b
         34stmQSsRs+Vjjd2t+KzSyih9k29CTFgUrK/Y5okG5ddDqhXQQJMJMWvA7Yod8XNuavS
         gCMA==
X-Forwarded-Encrypted: i=1; AL+hErF2BhbCGmlCjzqy5FLDPTTZzq7Z/U2R3DuElylgiuo3p0w+3ljCrZt31+VZ8FutpZfVrvY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8OMC51uzJjr/sCDt4Sx2r16rIujUIB/HVT1aE0A0wOkWc6lKjl
	MjGiUfKs7z3CaxCwUw9NN75Mt8s1iV9sGrPdMuvMA6FJaMNjOZxlhK9gYsZynXl6JobICa+f7s2
	s+Y7anVBNwDVISu2NGT6EjkH/AAAmnw0=
X-Gm-Gg: AZFdTZeX+VBOrwgEBdySxdRu94UbFcNlBHU9854u1hJoq/idXuHHyN41CjeKC8NpzTB
	CpqFQyb9D64oBkcB+dIohLiTQTQwMvekTH6E4hPMSmfG7/sgapshCKAgGFBNf5E4KC5fJRNCZ6C
	ZbbYfIcxdddIx/WiMBXZ17Upli7/utcj45BPuJzpiytGL06UnyCyXp/d30h5FBCn3wkMvY/Cas5
	pZQVTqww5+MeTnXt4FAfp5SuKYT8YTY3aIe1PJcSrFWFiQOu/uK0ac7RpaKWrFTX0zsJ4fts0bI
	jb0HCVkKRj7UwnBvg0czqpNrb5CgtZFbGj3LkIkHLF8xfXM2o47AJE+qjQQYo1pGEksWGlMb6xH
	XfDxQXLJ9kbzgrVe+9XqFm/qhX2G1yUCBrLmmJ1nxaNuQAxXo3IFxjjRpFBkOfx0JcglPZCMN82
	GP0jdqrYxZWFySEGoBnRnfHmyU/yFjc0MGUovvNUX3Om/vtAzE/HRBt/NL7F7HM+FrUyCpFI+Cl
	MECu09Lg/YvT0oWu1HgWYqc
X-Received: by 2002:a05:7022:f90b:b0:1b2:6d4d:9d8a with SMTP id
 a92af1059eb24-1b56f36d5fbmr6503743c88.2.1795512422089; Tue, 24 Nov 2026
 01:27:02 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104172434.691381-1-yopatatchou@gmail.com>
 <20261105225223.1163975-1-yopatatchou@gmail.com> <xmqq8q36q3il.fsf@gitster.g>
 <CAP8UFD0zMp-e3Fp5SjXuHiu25718=vf+qetzwpRZmBPMJ8Vb0Q@mail.gmail.com> <xmqqy0awa4gi.fsf@gitster.g>
In-Reply-To: <xmqqy0awa4gi.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 24 Nov 2026 10:26:50 +0100
X-Gm-Features: Aa3M54p2H50p0LzK6Xpv6-hDoZMJP-6RQX2AxHxSta1JEpj4Q_CFxwsJgM5kpBg
Message-ID: <CAP8UFD1KzGsnHXeQoW87Tu7UWhy4SW_Q4tkE-Sbf3XPfrx9XuA@mail.gmail.com>
Subject: Re: [Outreachy][PATCH v2] promisor-remote: honor promisor.fetchOrder
 when trying remotes
To: Junio C Hamano <gitster@pobox.com>
Cc: Yopa Nelly <yopatatchou@gmail.com>, git@vger.kernel.org, tangajoris@gmail.com, 
	kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 8:58=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > First in https://git.github.io/General-Microproject-Information/ we
> > have a "Don=E2=80=99t work on a proposed project right away" section, b=
ut
> > unfortunately this patch is addressing the main issue of a project we
> > are proposing.
> >
> > In general I think that there should be a design doc or a long
> > discussion before we start implementing something, because the problem
> > could be complex.
>
> Thanks for clarification.  Perhaps you would want three tier set of
> projects next year?  Microprojects to help you get your toes into
> the community, middle sized projects to let you demonstrate how
> capable you are to help you get chosen as an intern, and the real
> projects?

Yeah, that would be very nice. The difficult part is to prepare lists
of such projects.

I have worked on an AI based solution that automatically creates
GitLab issues based on mailing list discussions. It could also
classify and tag issues into using labels like "microproject", "middle
size project", etc. I hope we can make it available soon.
