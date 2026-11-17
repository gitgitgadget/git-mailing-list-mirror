Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794882823;
	b=ybtclGBHz7RbbFdyBE2xPmzUuRjggrxO75xt5DBllqboG7RCQQHx2inrZ6JmL/FlZlDh
	 OZqvhcP6c7e2zSsbCDio52NoVU223Oxzh7NEogEMmxtCjc+UvmI7IsSOOrDUMUcY16hs+
	 ewMEJrRnLCft/iEms3DieWzgZs2WrAuKAISoV4dUL/TFixXTnPmcTM6tytx7gdsO6z428
	 28LTOVi4HYR83fml+4sbOAEMoZoHQKqSriy/UAQBCbBU33tPgHQ347rfQCHaVQP209Hgo
	 HURLbTEhrXoDCeYz77AoCrLSKnmYHvIeWZnw2rT6lUmHi2cde8QQsU1l2KQRPnWSrqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794882823;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Content-Transfer-Encoding:From:Mime-Version:Subject:Date:
	 Message-Id:References:Cc:In-Reply-To:To:X-Mailer;
	bh=uFKhcKuilKlL5XbisbubyYVIkJsDms3QYxO7KdHpHgk=;
	b=ovfph6MrK9sZfh3398CeXR18KrZk+66zVHdNZZvioRMujSvOItLF/IrmCDWNNJ27v2TK
	 PqkWG92B60I8dym/4/MK7BBd/vfWecQJyi3pbXYScLaktmIZV2QL710XnGREOAnHNcQF9
	 KLV2qYGhqNOjNm6kaCItw2R/6x2XGkolXJqibjFC3VR4sYdzBa+1pmZMB5NHoxvGso7j/
	 UKQhhk2MoNzks405MI7jeOoTCIrio5FzWVVOgRx6IHM+nQKZ9JBERtmWPCjxHfRfAChtB
	 UdTWiJfT+KP5PKAe4NuJarY2CCtWHGtDjaXWSJPAkliz3K/8N0IKriO3SB6lmW5CCSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mkJLocc9;
	arc=none smtp.remote-ip=209.85.128.181
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DCC606A338
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 02:33:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22DCC606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mkJLocc9
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-8b4d5e645d1so13572707b3.1
        for <git@vger.kernel.org>; Mon, 16 Nov 2026 18:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794882822; x=1795487622; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uFKhcKuilKlL5XbisbubyYVIkJsDms3QYxO7KdHpHgk=;
        b=mkJLocc9ib6Uy5jbMXf2vLcZ2FRm2kuTH2OjFXiCdcp6SFLrm4V7juNbS/Modla/vX
         F0TiclJApz6aBy4x52vMtYmCQ1rAl9BkXOUSCilUQ8KaKxN4LDWkbQUL171CDc6qhkun
         fv6AIFct8OnUfSnxi5Xbf9TF2MbeN3n2dcAXvRFPzOyKCOGRYBzgF4mf6WM+O5PEW9xj
         h0hg9DRiUVMWGdHom5nXgak2XqTwkbJ1SReoHhsL9q0em4BZ0VtPgPQo26M9cAmWUBuF
         1VfkEDnQoR664HP9dN5emkhXXzDAsdoQ/IwML5JcEDMnLFSxzCbDJ8Qzk3UkrUnQ9BDx
         BnHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794882822; x=1795487622;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uFKhcKuilKlL5XbisbubyYVIkJsDms3QYxO7KdHpHgk=;
        b=2hakXHq8+ukaKR+4655tr3vuWjxIpPHFH00CnkU9m0Ll2syGW0/oiq1lNUSVruJmBl
         qwpo+ADLNWLy6eRL2o+ImABaTgg5/qKqdJkQPTJMjFfGNDLyi37Qe3NU5shpiPrtmL8V
         GgFSeD/z3pKarEOuttk/0iot9GMveiDcq1V18eMbb+oO/O+amq4IQ27g29HkoMaFHUdo
         6tO0BIuXzcb7ywlVffbw0iS7jUmdNn3GyY/PfcJkXLd4tP6dcfePXxiXhqXVfQRkjlux
         +9CUYxHABM5Ui0iPgI2rlMr9WGRoZRdGtcVdkWWUfDUwcH3bIhhk5f8kLL42FEW837KR
         Z82w==
X-Forwarded-Encrypted: i=1; AL+hErGTKyfD0sBWzFOBxAoI8RHiznWtjwpbk1nH+52LpWrZZ5MHO54A08uJ4Eu0pzNp3zAdyfg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8MKGXFZe3zarXlB3IwvLtsZ6p1PP7GrZ7XqwWYxb7BYCTQh4dz
	ThyQPCv3UnvaVTDBPBTK8cyNa5g4ycaW6/7TvURBfL/J+ZRjUDk5VHxi
X-Gm-Gg: AZFdTZcwkfUvonBpUxVIw8qE1toDT0BZxRbtDxGihM43XJ7aRm+hTmzyPg7Ep56LNpI
	pqp7Qrc74QQMa+/el3bzU+8waTfC3KuJ4PJfVpkr4ad4AvOkyE6xGXJzLf1xCkzEcbeuVwaDb0X
	QMCCa5FUEhBAn49lXuiNtFiVc4FdXED5D6GG9LcqRzJ5Q30Ut/+o8ZWbbFAW8C28qBbY5rdU2FU
	456nTiL+oAS2iUZwKcjqSt+tCC6DLgOSCiCqHkgYUmRRZqgTxv1nqxU5kmwVt57wOpzKjcOxPQZ
	1IKJ0z1bXjogbaARWo3+OjbAQmLzXl0zY4K0nY/VBYiA9md+9ANs54KTWkKy1QDXyVFvwSCcDSJ
	V60U6dQ2CBBaeM2fNJa3ZGitDhV86+grfyyHZOVoS30rdrZ+TEQMosCTI48CCVHIEyAaY7HUw0X
	IsIAdqb3qkUibjauubpvN/Bu6pMOsvdVqPt/VgFYykWkz5kJEykQ3cVG+yZLCR+/rnkhKXg3itx
	4Bc6M+HyRO0aJjwaPUeqQtLvSqmljK4SNBtnsF3RGQRSe/proEXdIPQ35Od4h5ppXGRxt5Ngyl3
	vVP9lrHoko6MYlEl0Uym79AVFEhoRPj9sFzbqDTvbK/54aqXyEh2+iUAcv+qWEGmLZMb018VFue
	+HH3clDZzQkmk5nPAghdyye61ewRHMw7ATh9ZyZSdsGONuVlxeGU9N/UGsMHJbSUJ5MLm/Q4r16
	EQPg==
X-Received: by 2002:a05:690c:3482:b0:8b4:c8e6:b512 with SMTP id 00721157ae682-8b4c8e6b8b8mr29328167b3.60.1794882821862;
        Mon, 16 Nov 2026 18:33:41 -0800 (PST)
Received: from smtpclient.apple ([2605:a601:9d46:600:99d8:b9e1:b1fc:333d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4ec0709besm14058397b3.30.2026.11.16.18.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 18:33:41 -0800 (PST)
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
Subject: Re: [RFC PATCH 0/2] Support --verbose in git history
Date: Mon, 16 Nov 2026 21:33:30 -0500
Message-Id: <AC0A5AE7-B385-444B-B341-2738992D8C77@gmail.com>
References: <734e2ca8-e01a-4204-9cd3-a09a8d097f64@vdwaa.nl>
Cc: Karthik Nayak <karthik.188@gmail.com>,
 Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
 Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>,
 Harald Nordgren <haraldnordgren@gmail.com>,
 =?utf-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <734e2ca8-e01a-4204-9cd3-a09a8d097f64@vdwaa.nl>
To: Jelle van der Waa <jelle@vdwaa.nl>
X-Mailer: iPhone Mail (23D8133)


> Le 16 nov. 2026 =C3=A0 14:23, Jelle van der Waa <jelle@vdwaa.nl> a =C3=A9c=
rit :


> I'll spin up a new patch which will drop the --verbose option and make "ve=
rbose" follow commit.verbose and make it the default for git history.

Even with a config setting, we=E2=80=99d still want a CLI option to behave
deterministically for interactive use (or for scripts), no?=
