Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794410811;
	b=pQvx1f2Fomx5fyJJPiCqh4tlI8JuqmqrCVBPf7TebLRhdJbYYwUk+CzCTSkSGSU7KDoh
	 WXhLUyTph84CTTeAE+t6YugiTJLQfWMNh/NIfhI1lNR6HLNOFAA16BiLRFZyQS8DWqlJV
	 1d4o16+8sGP7CTSqBDGyoMLc+hsuwNhnoZ9iNwON4p1KZfMPeOIYjTq1a97oJ2YQuS/TR
	 wyw5/Ji+CSi6c2+60S+ZvKLcTG1nHnzzDY00wRTnLZMcAYcNQj9OPQOr/Ggmn4Fi8SQ70
	 ZHIzWURFVycEqe8YIoLRf3OeGOh2MbzfC2ERPcS8UU52ijbij6Hu0GSMGkqHBLu3XBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794410811;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Content-Transfer-Encoding:From:Mime-Version:Subject:Date:
	 Message-Id:References:Cc:In-Reply-To:To:X-Mailer;
	bh=Eepvju3D5WqOkG2ensFBotpoxN4lao5L1rtgNqtraDQ=;
	b=opbcWpbcD7ic5TM9HzsO50RM4SANj1hRwQyxyV47SRiqWn7lrWlJuZDVhvmd+IUSz57Q
	 BVTsMCx+OeKQfRZMyfAgTCMW5BWvJem8jF/a3y/kFTVEYYlg8SwLcRf9t1BSHmYEeXYmu
	 CXsy9cDeC6qcrCQtNewINH0g4OfNf+MthDoI+xQsIRKUXR5U5BWcLZYfLyQJEGC4I8kM+
	 Ke6Ik+hPCXTroeBTSBFsn5RD3IgiUvGUxmUHJk7hcFcwIrZcRZEJCCYV+gPtFqMGBMM7A
	 rISQLekIzX8ivzRKFazen7yFWkmuG8PbpUg6eRF20qvD/HB1IUkBZ5zgSMsYT5dr5wQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GzimKo3n;
	arc=none smtp.remote-ip=209.85.221.178
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022AD606A32E
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 15:26:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 022AD606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GzimKo3n
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5e9528732b4so1942968e0c.0
        for <git@vger.kernel.org>; Wed, 11 Nov 2026 07:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794410810; x=1795015610; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Eepvju3D5WqOkG2ensFBotpoxN4lao5L1rtgNqtraDQ=;
        b=GzimKo3nYsm1WM3QJGoeitC8dGc0PYKQGRg8j4VtU9+ZyxSSjWQTJbysEymp/yRvTR
         aN4gvOYOiJ+NCPT8yIp3nB57U6SGhARkLKtUj1idfBp0Ma5VKaObDChZ68x8ySZI2W7T
         nXsBQnb8QEKBZYMOdEu6IolflHWF2DuSGISet6/qZWUpyTqTyJAHXJlxZQJxwZod3R5i
         9D+eADiJFbsipjuuNO6iQy6g57jPaDPmSlr5f07VCAFpRsE3t5ZG0SL5U8qo4wYImkOU
         mlxeFCsh7h4CLjDhzO46WX9hbtCydpL9DqTXUxkxTNJ7YWg3t7G0wvGJVAcl1jdjrSeG
         YoDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794410810; x=1795015610;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Eepvju3D5WqOkG2ensFBotpoxN4lao5L1rtgNqtraDQ=;
        b=blK5NC6uu3BDnIqTwjINwNesG7JrtcLbiOcbZpMUe8l7mnGt9Je9wEGgefeO39LHDD
         0u5iDo34Q+vcf8QP7I9yLRktd8buAtelqTa3zey2XWmObqFOqIT3+sgcQzvGcNiydiRj
         tFkcvbpYgnMBObjj7s36dtuxyuFNuJSZ2ifaBj4CWlZPeRTBLAHROl2VC/aPsczsRMls
         kH/PeDJvfFOQZxrrpBn1Zc+Pueowg5UBVTYvdz+On7WG5pteNkWsXXdv/1+YQVb8X5S3
         /Ge9ZFV2T4de08+LPMDyFHe0TJ758kOhmzRy69vPAdRoIWssoCW4CsQ3qHfvvdFEN7hK
         5PQA==
X-Forwarded-Encrypted: i=1; AL+hErEv9csEqX8si8dvbnQWcAVbfiYAOn4+xX51MjXzk19IXFJ+I6ClQTzpzCYfRvYUWgGtMy0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+BwkoneAc26vKQGf3BiZEj+LxHKmYphkutFmTYvNFWXfiWD+QT
	kc0EypU2lIs8qsbsrCuCZeDzniz0AoeGUF7V3Mdmi+yMdNWixHrM2U6O
X-Gm-Gg: AYBFou3WjNXKFU1XfKYF+RtFwF5vBtGzXgPIYGNWbKBMXrECVHsyshHjx2ApYbcQQwP
	OMMKNRqj+DsAGvmrrz0blT7BRS5hBrPn/rMHbxUp+QWlbKpn0tP0+1lzi9v3bEF772NQ8F5vsMT
	X111Pqk1DUZ414aLLCZcAmp3DyAgFS5l2jdzqOnZxxtup3QH5WSOBUas6Y+lcrGtjwCXnCUyTfg
	QeFULqxvk4u0y5tsJal+9a9YRO7Hfboea0xKcp8SVWNilhhEBKNgEnfYYUKHeQ1YGzxinr5BbCX
	4ozJuTDs4hYtU/XNlq71ETeZd1gnqN4bM+g3rRP58sdIaDOyWOEnqkiDzC1UbGsKNOiI74V6xVk
	t/7k3D2Y8IXklPKPW3Vb/nPjR/0lVQ4YhvvuLqoBH/hE8KsG7SB0bQaP2GfimC/3RpAd0wcuFEF
	xelps2xFC9U7A+cwvOz7PPmnDYlq4ZUQCPKcMAW6AZzg4O/df0sIZzLbsduL3/JrVom4ncSAf0R
	YBVVzZspkDYMg5y1EqKL7FKaEQmQ8WMK8XTMzStPGQTbh3Po3o8Uo2egZjFSbfyq1S361tVHdVi
	O92ZyIDhhdS2VH/5lMqOJ+UrNw81jtsugVsS1aYWWWOrEvJwvjEthJvvftzuQmcqVcx42EAbKdn
	/PMbQMX2Z3kyN31NLiEB5t/Qke24zLpncRNmvn/vikpdwVXD9LJ426dVzWcNbrq3aa/HlJlK5vt
	T9Dx0=
X-Received: by 2002:a05:6122:512:b0:5ea:e052:2ef0 with SMTP id 71dfb90a1353d-5ee1c3ff521mr979531e0c.9.1794410809807;
        Wed, 11 Nov 2026 07:26:49 -0800 (PST)
Received: from smtpclient.apple ([2600:1004:b092:7eb8:5dfc:125f:18b7:8759])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee0c5ab918sm3885981e0c.7.2026.11.11.07.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 07:26:47 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 08/15] merge: handle NULL value for branch.<name>.mergeOptions
Date: Wed, 11 Nov 2026 10:26:35 -0500
Message-Id: <C8BC29A0-8AA2-47C6-9246-19AFAB54D074@gmail.com>
References: <b298dd66-49b8-4019-aecd-e6dfffa2f89c@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
 Thomas Bachem via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
 Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
 Derrick Stolee <stolee@gmail.com>, Patrick Steinhardt <ps@pks.im>,
 Colin Hinton <colinlewishinton@gmail.com>, Matt Hunter <m@lfurio.us>,
 Johannes Schindelin <johannes.schindelin@gmx.de>,
 Usman Akinyemi <usmanakinyemi202@gmail.com>,
 Miklos Vajna <vmiklos@collabora.com>,
 Thomas Bachem <mail@thomasbachem.com>
In-Reply-To: <b298dd66-49b8-4019-aecd-e6dfffa2f89c@gmail.com>
To: Phillip Wood <phillip.wood123@gmail.com>
X-Mailer: iPhone Mail (23D8133)


> Le 11 nov. 2026 =C3=A0 09:47, Phillip Wood <phillip.wood123@gmail.com> a =C3=
=A9crit :
>=20
> =EF=BB=BFOn 10/11/2026 16:53, Junio C Hamano wrote:
>> Sorry but I do not understand this comment.
>>    [branch "main"] mergeOptions =3D
>> is an explicit "there is no extra options when we make a merge".
>>    [branch "main"] mergeOptions
>> is an attempt to set a configuration variable to boolean "true".
>=20
> Oh, I'd forgotten we treat a missing value as "true" even for config setti=
ngs that expect a non-boolen value.
>=20
>> I am not sure if it helps users to pretend as if the latter were
>>    [branch "main"] mergeOptions =3D
>> if that is what you are hinting.  It would confuse them when they
>> see a true boolean variable
>>    [branch "main"] rebase
>> and wonder why
>>    [branch "main"] rebase =3D
>> does not behave the same way, no?
>=20
> To me confusing thing is that we don't treat those two the same way - I'd f=
ind it much easier to reason about if empty and missing values were always t=
reated the same and booleans required an explicit value,

Ditto.

> but it is too late to change that now.

Just thinking aloud, a =E2=80=9C[config] strict =3D true=E2=80=9D directive c=
ould affect
parsing the rest of the directives after it (including included files)?
I=E2=80=99d also want a way to affect .git/config without editing them all, b=
ut=E2=80=A6

Anyway, not something to derail this topic with, but something to muse
on for a future feature?=
