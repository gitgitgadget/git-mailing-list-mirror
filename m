Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794245297;
	b=jdI/aGOEfFPWDnJr7cOwPoRwU+afZp9ogZ0d+1ic/5sxewn9MtbMQVYOxkJ0oasCzr/o
	 VQu1SDqNITc+HBIM4vtV1/kBVPhDftWeWExVYO5xeJEJcYXW3i7QdZdzMtSZR0U3/u3fT
	 qzOTgB3HDaUN1qsQoJM5EzaN56mK7Tu27ytWEIEz2F1UhxDAqdYK0WlMCne4kXxykRJ0O
	 I1NztrzJOYK4DA7edRGk4JbsvQ6ytr9VvP7Loob9vja0NMxlvFFBECeWozpqNYkT9QM/6
	 VA1mP+Af6TYL432E55vl6cdcmRdGwrDkS/mCY7DDAretH3U+gbSF0rn/Z4+m1wrgLiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794245297;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Content-Transfer-Encoding:From:Mime-Version:Subject:Date:
	 Message-Id:References:Cc:In-Reply-To:To:X-Mailer;
	bh=ECM8nk4vuhwfFXwsqzBHMqnGJexG6nxIChMeVEgFQCE=;
	b=Y2qlIMd0wdlgPKrRksm1dsieOUfvQuhNpz6M3VqLlUf9vma6gFV46um37E0S/htKxBK1
	 NaALF0jzEqdV5ZXwoF2X2N0MN7YQfpqc1a/RjqL+MMvnnlnklFm0r0Odi+2LacdqmZkIj
	 J3mJUHiFpWgODEUaqCb/6KqgzsTUkjudpdSqtNhXTaM3yQglAprY/nRSDUS4ljV6r70US
	 fFyb4hXQDtC7IpViR/h213geg7njO+24u5OC4eUx4rnIx8ez/Kfni9pH4pPOAUL9Gszu5
	 M/IcpCLvEJS6WCA2yLnmYnZ3qkesMOPNDplhjFOGY6U/qsNSaHMYOAw3T0YJIiGaSMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N+BAx3NX;
	arc=none smtp.remote-ip=209.85.128.173
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC6B606A31C
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 17:28:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCC6B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N+BAx3NX
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8b30cbfa628so14159287b3.0
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 09:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794245296; x=1794850096; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ECM8nk4vuhwfFXwsqzBHMqnGJexG6nxIChMeVEgFQCE=;
        b=N+BAx3NXuCbOf1IQlP/u2IRrn21JPoI2p5IOu/KDSi9vqOHI0CuNoEn4CgrgfYjuu/
         gLwogWQu7bbKq9qc0bKOEsmrj6UU8R/OO4buTNkktTcEAymhAst8s0ydq57ZUFLE0DBl
         qoa4rab5103QJ0ymvC90gmk0Dg+n2tO3OGHYQk4PxNmypypQgq8AIzHg53AWce6064/F
         KU+e4Jh0cPZms/q+72jwazz99op4wl1ATTA9QVgMA6a/4Y2wCjiyHR2TJRD3v6v4FTNd
         cPOuSRZ6lyiSrm11NLmYUtZTXgSKZ/o9u/QcI7babLTk9EG1BukxWHsPWyYct2KX/Xvi
         rwqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794245296; x=1794850096;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ECM8nk4vuhwfFXwsqzBHMqnGJexG6nxIChMeVEgFQCE=;
        b=2CegbgfJQdTPyCB1FtrNfcout7OIpKci2QeiEtF/qX4t4OQLiBmMcVjycmQrWtPYW2
         wlkYoQGWa3Y//Sy+U7La7X8C8Jj5INVbEgoZvkgflyu1choZvNVWWXzv5lA9ah+TdmPZ
         RtFn5tip0YrKllrT4TrZbfflGDfKs0xkocOm0vI84D4iWJq6Fczn9PfBmaHGAXmYQNfR
         aJzhvt+BxQta+o1cEv5wLpqTj9Uh98JesxmaMl9WcHZUVO7UEJ9wVzSBDm47T90VFRpa
         1ni8sS7wj3vk5wFv6GIUgHBDZtNFltsg9cxxDlBUsPwVVKudlxb0NUKdCRD+hq8gyZS3
         +ziQ==
X-Forwarded-Encrypted: i=1; AL+hErHQo/Ovyy3y8prZf8iglMvLBQ8jCrt3LZrg3sRPeYuujTiKiGpYfKGniieH9APPpJ+EsxQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9t7CSWfZSUELK3HssDw858oprNQGOw24Nx8eM3BnUag0rPdP1r
	Nd/yVqrm9ec47rdavB0bGnBP2tri6PVWdSBTa2VAU3T7KoHN5SUuazFu
X-Gm-Gg: AYBFou0+YKpQ2u6F9DI0H0RsbUx/Im4ip0eC2THIEIkOOWCaCg6NJuSJIQEt9pIbgcq
	osQr2Sgo7vUhY7YLj96UPx9Qx3vawubGQ5cT6wOcJ4l2YKd+Ji5maU18+5jtIBGJMia7Pk0Gpho
	cBGLPPyqolDb7twKbaI1V+exCrvlXyVT+JIaP6jXuGjWdEvcqP7THf3RPk/hMKv64k0cO0wCMgz
	NLm9nV9swXxOI5oHDuspCaD2WXlGV+92BvH5TJowlzUZ2sR0czjW9T9NhrW22ZBT7uYgHu5uX3s
	Ha5Gdp4EKvWQBmYx5BMwBrRmyno16xIr4CgsHHyo4vU8gCys/qhnoaCkCIiUXZETARBOiN8U+2S
	TdS/ce7dP7w+yA3AI02DA37wNAr5d4dh/EVw0BdXMEKyrY2/4Ibxb7ek1bWQA1oZoBfRQdnxDwX
	6cgZTTHO0oPG6L6XWGgJiMVrYCUZNVpDTmerbeIbyrGL/08X0wTTsYDbcT5Z5NdjAe+MiHTUoDw
	IUT1CLllk3a8cwFiIXRo8HZ7H0pI5Kc036owObDJ+N/aT+tfcfGLE4uGf7+crFYLWQ2DbezHwfv
	AoB6a+VAYVKUdmlrMOx4kHX8aA8Ed0P5zk+EQuqlbSntRL9eEpoFFvZ36awczo0fbvPORfb5JX+
	c/LJX39+kASwPVGlm6ibo/wLxqZbLq/UR/3g26TZEc4iODx4Q0eYgRJo5SEJFNJcCqH54vfKPwR
	NLP8MBoT4l82kSIg8jSK9Hzg==
X-Received: by 2002:a05:690c:4dc5:20b0:8b3:10df:54a3 with SMTP id 00721157ae682-8b392b7d446mr233297b3.65.1794245295723;
        Mon, 09 Nov 2026 09:28:15 -0800 (PST)
Received: from smtpclient.apple ([2605:a601:9d46:600:9561:fcd2:77ae:f7cc])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b36bb87cbbsm40911337b3.20.2026.11.09.09.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 09:28:02 -0800 (PST)
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
Subject: Re: [PATCH v4 2/4] doc: for-each-ref: say how to read %(worktreepath) safely
Date: Mon, 9 Nov 2026 12:27:49 -0500
Message-Id: <4B1D5AB6-7E40-4633-B804-752257DD0B67@gmail.com>
References: <3b97401f-5579-456e-ba62-c7a0fdb88d23@gmail.com>
Cc: Jasper Mayone <me@jaspermayone.com>, git@vger.kernel.org,
 gitster@pobox.com, sunshine@sunshineco.com, kristofferhaugsbakk@fastmail.com,
 haraldnordgren@gmail.com
In-Reply-To: <3b97401f-5579-456e-ba62-c7a0fdb88d23@gmail.com>
To: phillip.wood@dunelm.org.uk
X-Mailer: iPhone Mail (23D8133)


> Le 9 nov. 2026 =C3=A0 10:10, Phillip Wood <phillip.wood123@gmail.com> a =C3=
=A9crit :
>=20
> =EF=BB=BFHi Ben
>=20
>> On 09/11/2026 12:36, D. Ben Knoble wrote:
>>> On Mon, Nov 2, 2026 at 1:29=E2=80=AFPM Jasper Mayone <me@jaspermayone.co=
m> wrote:
>>>=20
>>> The path that %(worktreepath) gives can contain a newline, which
>>> breaks a script that reads one record per line. Say how to avoid
>>> that: use a quoting option, or end the atom with %00 and look for the
>>> NUL before the LF that ends the record.
>>>=20
>>> Also say that only one worktree is shown when a branch is checked out
>>> in more than one worktree.
>> I was under the impression a branch could not be checked out in
>> multiple worktrees due to possible races from each worktree performing
>> updates; or at least, that the porcelain would refuse to create such
>> worktrees.
>> Has that limitation been lifted recently?
>=20
> No, it is not encouraged, but it is possible to checkout the same branch i=
n more than one worktree with "git worktree add --force", or "git checkout -=
-ignore-other-worktrees". Those options have existed for some time. It's als=
o possible to bypass the checks by using "git symbolic-ref".
>=20
> Thanks
>=20
> Phillip
>=20

Faulty memory, then, thanks.=
