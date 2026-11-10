Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794330601;
	b=5pOFNG19LpLxTHKZ37sk6y1f7cSze88qgju6FUh3+dk9UfSExxeGKE/MSJ+yOMMz6Q2k
	 RxLxzV+WLJ2QpFZzVW7OzON6yhM3AvOn2+sEbxvj3spQ5Ji1F6dsYXkZ1ri51pHpBiWP9
	 oWSn80R3zEmDk0ohca8740AiJHXtcVTw65TCeQQWIgyUpHuezdPbebio1Dnop9UBYop0k
	 EhtIVlDkZl4jwmOWEr0gCzNPnINwNM9KcauBCQFPndGZEI1HNoY0xUyymoasRUb2iAXFI
	 YBq5cGenpjSCxZ7KoC2cQbxy4MpHPFNL3ph6erPgv7MUd5KmLZVETsFjmT1ExdItdUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794330601;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Content-Transfer-Encoding:From:Mime-Version:Subject:Date:
	 Message-Id:References:Cc:In-Reply-To:To:X-Mailer;
	bh=0geUzDbXrfieI4E7kJQwKOPEYLs3RMspydtzSzj5w3g=;
	b=DWUcUXGR6Dgpjko/EP9SvjQ2Qq2jImABKqtGRrfxbnNqfC6pHDOy1U5AnOA487nr/yL6
	 CV/4YbpOsNbhMG/GEkN/92lxQ68rv9oAsFYB6LkPSWFG2DH62S6sJNxuzuXuQOtlAxIqd
	 vkFbIZ6sd5E0hSu5MApDDto8jyEaSkC4n14qAjYvuOtxBYjl6ZZWDqdXR771PoAogWLfX
	 bR1TgrtjcnEEZ6iqWnqstPmxHD3Cxr99B/bX4ZlvavKBv8t6ndBIB6+rTR5P0ITFaAP9G
	 986+MLGu1PeM2xA212ZVqSwIoB4Ba4MXr7Zt8/nnkXiZ9OJpQqM/SVl2yc9U1+2kkeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=verGdbb6;
	arc=none smtp.remote-ip=209.85.128.170
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E468F606A31C
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 17:10:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E468F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=verGdbb6
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8b32b2e691aso22067497b3.0
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 09:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794330600; x=1794935400; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0geUzDbXrfieI4E7kJQwKOPEYLs3RMspydtzSzj5w3g=;
        b=verGdbb6/GOrqvuQPuXiLNs+JFxZvPnu6eQBp9jvoBtN0Lj0R1LoFrOGCCUvkxG8kK
         BeZMDjCO+ayaLGD94WRK24ZXoZueP99dV05VciXdLDdfz90+ELiS0dyQrowcdCKUIwQa
         mNviU34yKxtKfEAF/u+yTX0wTldHXw/SMLc8053kIXWlFypHHQvlQzHBdCzXyyGsyqOy
         7kwzGuv4DCeFveS+DHspH3n5boK3hcT7MUU2k0joq8eqOcqC5Ym7NIUu47QadvX1F7Vl
         EkSFnv65AGwMwwHmBbYnNwc6PWcm2pHWGQArnS9ULgTmSY5UHXvKTaQXWLJeIYaCksxT
         4AGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794330600; x=1794935400;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0geUzDbXrfieI4E7kJQwKOPEYLs3RMspydtzSzj5w3g=;
        b=TMGNrXhwl2GbuvzXuXRdOJeezvh6aCXuWppPc+IKWnX3wgguJ25IyWY3syrAwKfK/m
         yykHORPE4G8yy963KPTDPwoxUE/r/3nedUA/EXXjCbtkbDtAZ3Gc0hkkidlFos+AXMPj
         HitD1Aeoe9FK28ch3aGpY35Yq3VcRoFSEU6QEyOunnhrdl1Wv9dvIVvygK7gW8/JhVAi
         7Cl6pZl5ZL0sHmLD6nM5eQM3Q96GQ8NC9Uk0oO4lvkOwMxB7/z7NUPHxAgCq+9TE2xR9
         7rwEEaoqltWXgmpsqvGE0VEYiN/vXuIiD4UZSwCfWj4zZx10DbgcekzbVpKEHButp+NE
         AUEQ==
X-Forwarded-Encrypted: i=1; AL+hErERCjcBP9sni3FBfrq7T6sWPd2ZDzdWWsfIrVPQHv4f0HJcuj9Vdyh6IrQ95MAU4b5nW1c=@vger.kernel.org
X-Gm-Message-State: APuU4Z9CiKWMgI26waLKS54a2Kyl8pDU0ToE6ZrLzTugvwp0sOMSm2Rn
	6FNYgNlfdrRLL2HBbo7tH/iW1oAWev/UfwQHMJ85gR6tuVbe2PT4Fa1Z
X-Gm-Gg: AYBFou2IM3n6NReQ6XMHh4XWwaJWp0137nLMgHHwBqwY/uHJ7An0aot/JwplSINyykU
	RBSIJ4C+qkfsyAfKh4c6uW2x75QeUl/zLs8FMsuwOxlriOcfPLn14NFmXzgpY4RTOGPAVIu01CF
	PYDcn850xHG6/sXao6KFZ7qom6A7cC4Djls7yx8/Xc+sFLmQ9YhcTfY7fiCUe6pLYvVex/kFfaj
	TpiFpsAuPMTGRp9MPnulhuy4bfrsG+GleIHeA2hj4YTUtgJ46nuYQkdoq1MD2+5dAxh11PGym9R
	+QcNIZgCWnMsTuyGKsk/8mM0l0AkKUBn698/BDahouNZq7NCGq0bVUmvXr9g66Ksp2CspNYEc/8
	cf297l4RLL7kCzNYkB9l/gyUJ6zRieuO8AnyDgXk2tvXkbdJgbVQb303PwZZX7WvVdhAroRZeqD
	QNDhZyJ7wBv0HMbaT/kXCjfulFDC4fVeIPP3Mjnghx8ek0Q7436P+2sGr1zxIpVAXQjrMcOjTJ9
	qCjeW+lavjlNMfoRiihV1eGOtYPwb2jlquKzWtEheHACxKplA20hXsEF7vlXuvh0Hmw3KIPAiaJ
	STcV0xzZeYk0TovDcQpSIEdOIVB0wOsfFok1TAq9hu68KsXl9r3EJtxqXJ6gmLjPsV7jNMvZFf2
	7+hTyJgeZEbLlKVjLFetLefUU5rBTCF7Ms2sfdOXSVhYDFmKuVhHlyMsBxsPIeDzYrDJ0BLIMFy
	FIuqs=
X-Received: by 2002:a05:690e:810:20b0:679:90f4:3223 with SMTP id 956f58d0204a3-67c56e4c082mr1243282d50.9.1794330599787;
        Tue, 10 Nov 2026 09:09:59 -0800 (PST)
Received: from smtpclient.apple ([2605:a601:9d46:600:f493:878f:a4da:aca])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67c58a0f312sm2295560d50.19.2026.11.10.09.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 09:09:58 -0800 (PST)
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
Subject: Re: [PATCH v4 1/4] worktree remove: refuse a worktree in the middle of an operation
Date: Tue, 10 Nov 2026 12:09:47 -0500
Message-Id: <8EF87D68-6BCB-4C40-B0CE-2BB9B90293B1@gmail.com>
References: <8667d7b4-ffb4-4285-be67-10a85730c359@gmail.com>
Cc: Jasper Mayone <me@jaspermayone.com>, git@vger.kernel.org,
 gitster@pobox.com, sunshine@sunshineco.com, kristofferhaugsbakk@fastmail.com,
 haraldnordgren@gmail.com
In-Reply-To: <8667d7b4-ffb4-4285-be67-10a85730c359@gmail.com>
To: phillip.wood@dunelm.org.uk
X-Mailer: iPhone Mail (23D8133)


>=20
> Le 10 nov. 2026 =C3=A0 11:47, Phillip Wood <phillip.wood123@gmail.com> a =C3=
=A9crit :
>=20
> =EF=BB=BFHi Jasper
>=20
>> On 02/11/2026 18:29, Jasper Mayone wrote:
>> diff --git a/Documentation/git-worktree.adoc b/Documentation/git-worktree=
.adoc
>> index e6e77252ab..4a7dc47dd8 100644
>> --- a/Documentation/git-worktree.adoc
>> +++ b/Documentation/git-worktree.adoc
>> @@ -141,10 +141,16 @@ the new working tree location.
>>    `remove`::
>>  -Remove a worktree. Only clean worktrees (no untracked files and no
>> -modification in tracked files) can be removed. Unclean worktrees or ones=

>> -with submodules can be removed with `--force`. The main worktree cannot b=
e
>> -removed.
>> +Remove a worktree. The main worktree cannot be removed. Without
>> +`--force`, a worktree is not removed when:
>> ++
>> +--
>> +* it has untracked files or modifications in tracked files,
>> +* it has submodules, or
>=20
> This is a list so each item should be a self contained sentence, we should=
 drop the comma above and ", or" here.
>=20
>> +* it is in the middle of a rebase, a `git am` session, a bisect, a
>> +  cherry-pick or a revert, because removing it loses the state of that
>> +  operation.

Well, each item is a clause/phrase=E2=80=A6 I actually think the =E2=80=9Cor=
=E2=80=9D fits better than
rewriting the list introduction and items to be complete sentences.

I think that construction is ok as-is.=20=
