Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792440088;
	b=TdVVeDl7A8AexspFbw+Kv9r+M5wGch62u9yxWT9fP+V0izjvIzsxcAMyK8QzeqGLo2kz
	 F0F9WqWjs6coyYPeGR3IZjj6WJ5Rehn6+pgspS6tIE9xHbSjC5Qf8PEW7BAyx+iCodU91
	 GbiiSap7nrvCfHS+tl89Bdy67OxrvCStExTtY7bAnaiO2c9tVJbUQkxC35MlpufvRL6oF
	 A7K4i7KnZI+dUioM0BTn54c9lg3wQml0R+8vqYJtWa5/oNcjT3SzP91jzY0+TWM+B6pwD
	 9MhXtK1vJB/rtoceZWWqJRx8oAcsJ19rurBq8Q0lmWHqpBP0LhaIg/u4cMzJzUvDngQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792440088;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 Content-Transfer-Encoding:From:Mime-Version:Subject:Date:Message-Id:
	 References:Cc:In-Reply-To:To:X-Mailer;
	bh=i6l4muAYkPPKjqS+VsLG56eWMRTTTZraDhKlp7f6b9s=;
	b=n1NzDMPg4j+YrCPSC6Cg4SZ/XvScn7H67grxef/MkAO3SXqzfZlO8mooSrQJJRIJLiKX
	 vmhQuopSlNXfCkhSrmSUdCM40XqJHV/jCrWXLD8fMp9q6/guGTMLG1QVYGsswS1HJIiaV
	 Ofv/LDvNGTON/5H/NWnDPAoL5zZ0WWM/3W7vRLBr5kbEGRaQM37YNzGvQOFxoE4FSmYFz
	 OtqhqWJgRo6fgd+2AfdwgVOojYT65RvGXwqtHGmows/eH27p29XoTmlaJKJHhIYLD1KQl
	 fb9HDMAz5hCzBc4VYeqTHNMkGjt43cOY2YvSeVAUDAz3lP7SmrIemR4DaQX1fzFA8dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=q2ypVecc;
	arc=none smtp.remote-ip=209.85.128.169
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1CD606A31B
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 20:01:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB1CD606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=q2ypVecc
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8871ada1a26so15307707b3.1
        for <git@vger.kernel.org>; Mon, 19 Oct 2026 13:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792440087; x=1793044887; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i6l4muAYkPPKjqS+VsLG56eWMRTTTZraDhKlp7f6b9s=;
        b=q2ypVeccmI3G21DOm8lk49MW0TXlVWbIBGxIQVD+SejhIf6OrLhR+x7/jolq4ZKS1R
         jzvsNLTp9ixBmonWrjAry9wR8RXrq99IeUAHucU6pbulrf+cvjuLuVQTdPB6lelYjBfv
         ynNKek71cndLUY/2I5LNol5vv4rbKz4DdyfnEl7j02PKXs3zId/WIgiRCLm97Ee+HY5A
         0guiSazEN+aXzTpdhliWRS2dszUxH0zv6EsIIWMn0w6Kk6fhW9z8dZsGrZWc8oIahh5a
         fYVtyCbI3I+pV6flUYa0uNtOwoQuVTrE5WEILxbtBBm7j3YZlLrikCIzd9048Jg3olCc
         cMnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792440087; x=1793044887;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i6l4muAYkPPKjqS+VsLG56eWMRTTTZraDhKlp7f6b9s=;
        b=07LLNnDY2jzfGWb4JzVvGYkHb/QWy6gFKJzdbU3VOz9S9PSQD+34sNuBxxSVGHMhrq
         Z262A/QCX3ypEEIvgVhSNmyprwLxKJX1DRNrt+0We8NuKV4ehtmd7NGaavv0RqvfgwEc
         qGevcTxGUV2SOcVCWbTupud+NMhhTul9tcI3mkhrvM75F0TTbyYUFIeR6gghR4YkNjhr
         1z6rlRTUKd5DeaBE1BD24PmFTIp1XMvi48EB1C20DeD7cKwdeNk+iZMIRERtmVkbpPSO
         61p79s7NT8fpXT90ao9+jG1GL95IoCOh0tzbW25b5ngNagXQM0QUAyfKCqBqXcSrxlSN
         7DGw==
X-Gm-Message-State: AFq9FYIA+Xt8giet2/5aPer+uJqt6TkmrtB1n74Qh5nXsmsqAyOlQP0U
	lbgGmeimpmZgFor0KR2VlZEipR7FKGx6vLJARvi7CnnLDU6rnIjfMwoWZ2gKE5IJ
X-Gm-Gg: AYBFou3CdR9HDsBj2DR8w8g3TJqlS1u0CJeyvmIsmtu92uyvVvZTRs5LflhTQ3nmdqq
	3WwtdMj4zovafOJlRQdJ3MaJoKn1uKaRYg1uPj9HugUjZRLcnYj1I6JoxsnUBQ2ce/WZZL62Wab
	IiDf71c/P3UX390DaLl4z7Yf6QbffsUHCnro1mOFncpNK722CZ62uUArjCda3ZDPT5Fihqzqo/3
	K6Ps07pur6f0VyVVZw7JrRioNzMOsnAa2P72Cy4ZtsX1EcjKinkUAhuK/+5M+pWkybUsswcA00A
	IVudCIZzjYOXCjOPDSYf6sQMsPFIseINooOJMLQXFlVQUvZe1xyLr7p0xQgUgq/l4hHad52tEWC
	tmJbYyMvbSGpEXWqz4nYpq4fuT1AI1Taxb7D52mkIalinGTwEyuzVx1s+KcLN3il5usXXeNrwEK
	8MqPTQR7JfQ5OQkYs0Wk46QVMbzQrVLX4DbsURuoYJIb51NFEjftATKxDYcrJ0uxj7m6/JmU9M3
	T4BPJlA/5NXKE/VRvURxGfoX4BrKyADLtIPg/j6/9qLBN6uGLu7t7NBDC59XM+Q1+pK9n6q48b+
	DksQjtV98OopB3KI8qXAhutgJm1RqwbvOHwcLwq2QX65Vb0=
X-Received: by 2002:a05:690c:e3ce:b0:8a8:9149:e4da with SMTP id 00721157ae682-8b0f22125a6mr28165317b3.108.1792440086438;
        Mon, 19 Oct 2026 13:01:26 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:9092:700:a9b4:ceb5:f03c:386b])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b11b866782sm4343957b3.32.2026.10.19.13.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 13:01:26 -0700 (PDT)
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
Subject: Re: [PATCH 5/5] completion: drop "stash save" completion altogether
Date: Mon, 19 Oct 2026 16:01:15 -0400
Message-Id: <35E6B235-6370-4F94-A0B1-4B6A941D8C47@gmail.com>
References: <atHZ0gV5Pz80l3ho@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
 =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>
In-Reply-To: <atHZ0gV5Pz80l3ho@pks.im>
To: Patrick Steinhardt <ps@pks.im>
X-Mailer: iPhone Mail (23D8133)


> Le 16 oct. 2026 =C3=A0 04:01, Patrick Steinhardt <ps@pks.im> a =C3=A9crit :=

>=20
> =EF=BB=BFOn Mon, Oct 12, 2026 at 01:48:31PM -0400, D. Ben Knoble wrote:
>> It's been deprecated since fd2ebf14db (stash: mark "git stash save"
>> deprecated in the man page, 2017-10-22) and the previous commit removed
>> further documentation suggesting to use it.
>>=20
>> Since we recommend push instead, stop completing for "save" and remove a
>> special case in completion code.
>=20
> This is the only part I'm a bit torn on. I think it's reasonable to not
> autocomplete the "save" command, but if the user manually types it,
> should we really stop autocompleting its options altogether?
>=20
> Maybe the answer is "yes". After all, as you mentioned in the preceding
> commit, the command is deprecated since 2017 already! And after almost
> 10 years I think it's fair to start giving users more nudges into the
> direction of using "push" instead.
>=20
> One note though: the command _will_ be completed in the case where you
> have GIT_COMPLETION_SHOW_ALL set

I should definitely mention SHOW_ALL; I=E2=80=99m not actually sure=20
what happens for =C2=AB git stash save --<TAB> =C2=BB with this patch,
so I=E2=80=99ll double-check. I actually wonder if it will complete options.=


Would that satisfy you if so ?=
