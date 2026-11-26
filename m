Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795696223;
	b=Il53aakS3PRZX9cgldPGtjXcspkzkY8Ddva65PnU3YO0orBeXK2PhqUr6IIqCmmm2kG+
	 5ouo84ihsK2ZRznhyvMmvY9x8KhCBrETrXAZN7EE9wCucBOSJZ+Ji1WLuLeGbHBaTs+tp
	 8PcIOo2xrcD20JbDvoJK/RdK02Icv1/oRHzHot5hRxAoGChCY3jfICZzU707eBuq6uwua
	 2PfZNKc5SRKQ8VQCgQaNs9w606NA/VO/AaPjbdqUNdB1tTREJeDyI0XzBIFBeeLsrSeU8
	 /BUFIxN4P50uoKBzgsIt1L1/yCfkLWZO3DlZP6w96fIC3j18S+XKsD7WLhmMrbvFKsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795696223;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 Content-Transfer-Encoding:From:Mime-Version:Subject:Date:Message-Id:
	 References:Cc:In-Reply-To:To:X-Mailer;
	bh=39tD7XfRgIvPgkxWr1zMXQbS3exLoGbufa1cZhK3g3I=;
	b=bm1yqpHIebZ0W9G8vf3MWigVKN1XPlsU0IfNC+QaUt7y8ZoXdQFn5FJfCyrcaypxgJ+v
	 uoK5cyqLh0twMEtxmqojLD3juZtLhbsqeUu/sNlqHsLsLJt2eFZ0iBjGoZ3JBNPz0Anvn
	 9GO7HOK0NKZJs1/FSu+EQFMhIHvPsCDcsgcOkfAYyUsYMAImPzuQ6MeDB8HUa0jtNnRCA
	 ERXjQO/5JYLX0mT2RaKEa35AJDeccM2RGqUuSCS3Fd6hHTtXAaz6WSiwVGZ4SEhcv4+Bo
	 cvdbxFWrmIGJUlsG7Pi6bF6b10XPrCf1dufe88CwW5DbwWCZxXpeGAVNZEJ4glw716A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eZeI5S0c;
	arc=none smtp.remote-ip=209.85.128.177
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF82606A31C
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 12:30:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AAF82606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eZeI5S0c
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8b4dbdc9592so20920787b3.3
        for <git@vger.kernel.org>; Thu, 26 Nov 2026 04:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795696221; x=1796301021; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=39tD7XfRgIvPgkxWr1zMXQbS3exLoGbufa1cZhK3g3I=;
        b=eZeI5S0cdjrTFClLG2jdzxheRDr+SJxkxdXt1iHAN2ZAqnfuiWH6kAxLrKXbOKJacJ
         XAac8cWmdZ47kg/J8rslHfvqSZ1VvxXgrdiE9hqtURmvGs4TvT0uRWFi4lKcp4M+zn9x
         kKUXjmo1qRb/QvUGPpR2/JcLGage5Z6JnEU81yGsC8Ydatmn10hVjV+ujQmCdGis5RVQ
         kPVnlWTF0y7JsCUn3Is6fqo4shLHPIsxJkGk35IJzl+RQK9cMEcWax/CJDqve0KSza6n
         ZvC3c6Tp8qNQVZADZrZRgBnXFUsTeA+ZJvh5Pi7GASaCGz1wxyxtXmWt4ryx33cInTEr
         tlew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795696221; x=1796301021;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=39tD7XfRgIvPgkxWr1zMXQbS3exLoGbufa1cZhK3g3I=;
        b=kUVdzIh3Axntpn9X/FH3Rw7M8frm8K0xt8mqrbx1mGz/EMIasLwVHyVJnuI7COf+lt
         PHMRGPuRm721B8YyiWbBepRvLcP2ZQx1GZQjAJzn31YWdH8cqTeFSKv4+vEMNuRi5lWk
         BbaflnyNWCe8knGupWvDWf/2Ef+WGLKbDRDncl0dGY5V8yahUJeDnoVPLLIkykXA+ClZ
         wS41Y0RdCifoIMjFlsbqqeMrbANWJPQOUG79OHDzFEQ3Y3Y1mr4KldwYzKLOn0AeT7OS
         dFR5jMf//QuujR5TWkTvGbrcbr1nAclnW+08nzdYiJ44MIb5C/eRnH8WpSDspqxUpLxg
         ZIQA==
X-Gm-Message-State: APuU4Z8kvezfe66xuAIwuPjvXGOIOGkaqevXaBJqlqtIdaa6NA+iY8aV
	sdXy7NkMlKVSDs9zoxCOHzSB4LEH30kYB9mWqMkMYX7NglHJPBYJGWqUKLZIHQ==
X-Gm-Gg: AZFdTZfdfoLihCpOcoBZCQePbaDzoGajBiB37Qi2h01Fj/jw+XGJMw9+xOy1RxoIX0a
	vXsAC+iZj3CFDwR38mP/ygsqzR6e0z4kVv13hh3y+F0ck4chipKo5e8FCfkJUbJv+Ffa9E3VRHr
	1HWzSsHaqPCzlxJg4BHEokchsOuEgRJRbiC8m+nHtWOUK0/9h1uTs/+k78mKsomO+D/LaR31efC
	415RPJOmEESWOUMOwzvX6PDF32DlVN2BxRmsp83rQL3feb+iFAu31GdqP9RAtOKWn5EECfaFxr1
	bAQzwgeh165rddH7DzV/TWQhdv3lfb1W6fqEYIKXsO4h6StKMsGEFHb/LXmpiiKHrH8HDmqqbUm
	x+pRMEVi2W8340ZtBIfGCk7Bi1DsV8b87pN3+iroZ5wrEtnf79cM1woDQDWGsrzA0h/LlSoaQKA
	v+GaDdPVieIyM4drQtJMG8mzVHagiP6FoywQQWuB4u1IkXp/IZnv8M90ysZxpglZfzfwdOqUHue
	E/ICoGHptCCzxl8V1kdrmmCqGVQVrJ5hqNVFBz/jbAwxi/5SWR0qvFrnGmwh6AhJfYFQ5vqD4Wi
	qYWuQcCXiBiZ+ZghexT+B7BYNOKMSBFRWdcuaQxsxF3rgVeTcHR7GP5EnkSG8xul1E8l7OFjFa3
	Bv210954UFHTFjZGhd2tGjP8RYjFRxqruQKO5UF8N0iiMM3vjU6mMDqCbVrHpx7e9dazygmVhw5
	HW
X-Received: by 2002:a05:690c:b9a:b0:8b4:d6ad:5638 with SMTP id 00721157ae682-8b520455e24mr74709637b3.13.1795696221396;
        Thu, 26 Nov 2026 04:30:21 -0800 (PST)
Received: from smtpclient.apple ([2605:a601:9d46:600:96e:3ec4:60c7:eb95])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b52028c7f5sm85238157b3.12.2026.11.26.04.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 04:30:20 -0800 (PST)
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
Subject: Re: [PATCH] config: make the suggested "set" command safe to paste
Date: Thu, 26 Nov 2026 07:30:09 -0500
Message-Id: <02A50A47-A048-417E-9D1E-0C12D8FB1476@gmail.com>
References: <pull.2457.git.git.1795632875345.gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>,
 nahidhasan141400@gmail.com
In-Reply-To: <pull.2457.git.git.1795632875345.gitgitgadget@gmail.com>
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
X-Mailer: iPhone Mail (23D8133)

+Cc Nasid, who sent a similar =C2=AB suggested command should=20
shell quote =C2=BB patch. (Pasting links on mobile breaks plain-text mode,
apologies for the vague reference.)

> Le 25 nov. 2026 =C3=A0 13:54, Harald Nordgren via GitGitGadget <gitgitgadg=
et@gmail.com> a =C3=A9crit :
>=20
> =EF=BB=BFFrom: Harald Nordgren <haraldnordgren@gmail.com>
>=20
> When "git config" is given "<key>=3D<value>" as a single argument and
> the value contains spaces, the suggested command does not work when
> pasted back into a shell:
>=20
>    $ git config status.comparebranches=3D"@{upstream} @{push}"
>    error: missing value to set to the variable 'status.comparebranches=3D@=
{upstream} @{push}'
>    hint: did you mean "git config set status.comparebranches @{upstream} @=
{push}"?
>=20
> The shell splits the value into two arguments and the command fails
> with "wrong number of arguments".
>=20
> Quote the value when it needs it, and put the command on a line of
> its own the way other hints show commands, so it can be copied
> without the surrounding quotes:
>=20
>    hint: did you mean:
>    hint:
>    hint:   git config set status.comparebranches '@{upstream} @{push}'

I wanted to bring both folks together to figure out: should we shell quote
assuming a POSIX-like shell, and do the current patches
work or not on Windows?

In other words, would we need to do something different to
behave sensibly in other shells (fish?), or is that not a target worth
worrying about (GfW comes with a Bash environment)?

One other thing: it might be nice to centralize some kind of=20
automatic quoting for suggested commands.=
