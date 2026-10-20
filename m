Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792533978;
	b=HUPtG3i/KgZEUEpbeqmDYR5YZ3XF70L8SPdRDTXOstzFT68E06g5Y6mj07sHRA5kyqlN
	 gdTMTlXLR9qafnTd1N4jPdw7LtaI0/H/I+KMGwjDF1ufPjwAQG1PHvGmF+wUdwUs+Kpi3
	 I4cd3AyViaYUc4THSp1fE+6xquCEe+MN5HoZ+a61XQPXDMnzRfKJFDle/78G9SQ1xuco7
	 lWVdBOBz1SYn4uLCTvm5wVsObZKokx/OGguaNcnhBgeg1tqxaTjA2ZoGhsou3IkjhtAZz
	 RufPBcmtrUCnypvE7+AyHK07I+4LI7ZaQCpNRhYOWQKQ9OHvwc8L+A66IkHvmpCax2A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792533978;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Content-Type:
	 Content-Transfer-Encoding;
	bh=hh0OR0Uxk5IYgRQuFXxlW+doFlLs8+4jjdEeQ28pOdg=;
	b=LRN02S5G9BopBLsfTCvKjLQ603NfS63Ikpb5SRla5k/jPuU8+/n8Zi15GgsaEssoQ+CX
	 5WhCnle1RstqwkHxTOVa7hc7g/p0Xz2dq9s8GEMo6Lz7t7j5+jNirWTaK33EvB3G/kpLk
	 hhwOXFMYNdqR33uG84YRK54y3LiKmOnzMl2lw/Wsk93rNZJV+960Vnc0cNxpmNjiuwtMe
	 kwGevbeTRhtpxZ9ENH+UptN57Pcn3ztkUy7hGYOc9J26DJsX4ZndsSZIofBTjnWazNZTK
	 pyJYDya+wk/KhQih79w0hZlCHfdSRMu8wiexBFh/lsReg8QlUb5Ho8UdLpupYVeaGZA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=f8NepJ4d;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.177
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB40606A31B
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 22:06:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BB40606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=f8NepJ4d
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-93cb1c0e851so8085785a.0
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 15:06:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792533977; cv=none;
        d=google.com; s=arc-20260327;
        b=AYm9JsbSuCn9O5TlkK4+LQwVRtkr+hNNtAWyVhesNiVB3DHSNFvvrZRj7ap9A/vpRw
         iEyyMVnrCIosPSNqqVY9RX1nAXxnslVdzDCqswk1PuU3gWa8psBk75PSk47xnyYsOH7c
         M6dhMKk2mgLrpfmB2ktV2kZm7x2hQFM2Kwmzw5t0eAmvordubvnvJ0VWpQrTR9Le2L3u
         3uZrcuFUkPgvEKr5IvlUJYSuaMZF0rM0R3EKkGMZ0O+S+ANqzGcR/WVkvo8Es0nhO47k
         1XaZPLhdDQKThD5EgG7NiweGsK0PVF55znSJ0XtbRMulos20bc4bvc6kqeUIUxElOWqF
         4m9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=hh0OR0Uxk5IYgRQuFXxlW+doFlLs8+4jjdEeQ28pOdg=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=r7fqorqYyFE3dE0lUGn3xTMQamSWK8eFoEb3q2FwMAQx2b1Sr7QeQVxHt/H0FgYjp7
         pc0wx6yF2TMc+IUYK95kos1S/ZOuhulBBDrRtSgNt/hfJpBppdpuimY3Hgh8ujVBDiWM
         /j05qJAbZlDp6eO1u6jQ6D0ECmR/H1E1EqK+4yqhlQRskfsSsjgqeqYee9k6sY2+gLSo
         IBLiod4b4hQEClp7mhIXmAjUnu8qrJHoZONsS5pcbX3uzOM4wNpRBaBYuib9/3CyzMFf
         24MhgEsBGQp5QyBBGzXpPvTpD3AjC59eV+1tV7CJ0FpR2wvd0eup1ktgl00EUYPq+uhj
         Eihw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792533977; x=1793138777; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hh0OR0Uxk5IYgRQuFXxlW+doFlLs8+4jjdEeQ28pOdg=;
        b=f8NepJ4dpnRlqj9r8pB2gKe6tPYDyHInFPiG5mFVybSesD3qx/2i/JomNlapww+VKY
         GRE2m4x0CFsc+vHWmrPNEInz6lU9b8ZrTBPqYhoGO0TwGxIqREmpYPd0d1jQAoR8WlP+
         BnVkL3asoNd9q7AuCl3d+/UyKjmdIjVdgBlSetZ+Vq+sV9/D/AQfCqTTlG14Jnj/9Dm0
         9rJatZJUF/WNi9uyjtcIPkA/yY+/dCtvak/MOgEnMgodgCF7/LL6swKeKI7XYMS2FYNC
         Zze1s0xFJcL9yc/HIuJ34rQGEfrZGpeqxDz7zDORKH5H4unngsUpUyb6jf50V+fyDYek
         zb8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792533977; x=1793138777;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hh0OR0Uxk5IYgRQuFXxlW+doFlLs8+4jjdEeQ28pOdg=;
        b=JINmxPiIPsoQvdLO1oOWpbYhCok/QIRJ8FA952Mt38LhJK6QHh6tt1+zcgEEh0rXkS
         qEE6RrNj6La4If3Pv7vzehfAaxXWj0iLDLgv3fSQKOLX+iyphhWiKMhFA5JPl+o0kCe7
         b+aDNyc5IKdCXCr0xpgK2Jh9k1K/Rhj3Abhzdlrv5Ris8bPwRVbNl039qxFs8cT3/eRn
         aDYTi0ck0JEp2bm9BDvUfbTaX2t+yicFDHCK4t54PTrO5q1AzR0ZoLGzkJtKWTG6NPV3
         WA6JADb7VLuA88DpqseljoLsifRcAYUBmIzsf0SpFEw77VuhwER5e/mRc9GSchLTFoHc
         DPhA==
X-Gm-Message-State: AFq9FYIv70g5sm03BB7iSrKlHGqC10f2SPSD5/CQHff9ojlhFkwNy7YC
	QTrnP8+qqJWGsWuP+OK8yAAEKRQb5bd+x+1IxNMV47BRG09AnpoBMZJF0H6HvsG1WTSF6Li6Qjy
	ls2dt5ddSWMoBg1dq/H+DWGnvqmNMaVB/WEWdQZb35pb/
X-Gm-Gg: AYBFou0rFg+B1URcKMPipuPL9bmOCNC9xnNTa7cJA9YdvBZsO3eQcbkKgLPJSQBm/jQ
	aejnsMp2TblN6HIiXytgxc9hjFH2RY1NVMMsGMTz68NxKvfi3Zf2YuML0bWAIa6hZbU8El4g3R8
	fgH9FusxvfhJWqncopQPzuB9m8HhkTxdrRT8jfJcqWySdPUcAlhG0IKLW8D1zb+wXztLBB+pgfE
	xKw6n/yQgOrwB/3LabTHHRHavUnZs1TtC5i0QVU4CkGUINLo7RttcV7c+Yul36cLENNK58wK5nX
	dFoRVgcDQrPFGbegfmUQumL1+x7OURAX2kKEzSDchzHHMqXOhPElfQDY0UYAHTEVbG0XCIbXCWP
	0OysfbKwP+CG5A0/l1dURl1HckHcMyHS0KpLQ7Nuu1OMrZXgSixBMAOJQ1l/7SN0ya+zT7WAZR7
	tRB3sBnEz6la/7ypYYkLYFQBeSdSZ8kP+EEta2dMbcnqlz1QsiE8l+frclAVDrQOy1n0UhDv8=
X-Received: by 2002:a05:620a:4542:b0:93e:f0b9:505a with SMTP id
 af79cd13be357-93f57faf951mr111394085a.58.1792533977445; Tue, 20 Oct 2026
 15:06:17 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Wasswa Edson <edsonwasswa54@gmail.com>
Date: Wed, 21 Oct 2026 01:06:06 +0300
X-Gm-Features: AclHuK8ABtyfa_yZxNhNRVegtY0S8kb5niXNB6rilnwMcOifiQlmaxTvghtTxm8
Message-ID: <CA+ew3JvT6miEzLBVoBeR7eQMYHWzF=9Y7MFZBBnF2gXkf5Tsow@mail.gmail.com>
Subject: [Outreachy] Promisor remote fetch ordering: clarifying the current behavior
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I=E2=80=99ve been going through the existing implementation and documentati=
on
for the Implement promisor remote fetch ordering project to understand
how things currently work before deciding what to contribute.
From what I=E2=80=99ve found, Documentation/technical/partial-clone.adoc
already describes the ordering of configured promisor remotes, while
Documentation/gitprotocol-v2.adoc explains that server-accepted
remotes are tried first. The corresponding logic is also present in
promisor-remote.c.
This made me wonder whether the main goal is to introduce a new way of
controlling the order, rather than document the current behavior. I=E2=80=
=99d
like to avoid submitting a change that simply repeats what is already
documented or implemented.
Could you help me understand the specific limitation this project is
intended to address, or point me toward the part of the implementation
where a contribution would be most useful?
I=E2=80=99d appreciate the guidance. I=E2=80=99m keen to understand the pro=
blem
properly and make a contribution that genuinely improves Git.
Best regards,
Edson
