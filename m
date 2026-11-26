Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795705579;
	b=IRe7SYE988NWARCDPIa8kE6ysBpDMkgnmNKPe20qeWg0X7BlvQ8c9Ps18kFXjhWNSACS
	 MiMdl7hVFKVY8l743OcJ8GXCb7VhTkHTEa2BWPwKdLoQIq7Zmyjfg//NRHoc+SLUhB6TC
	 U4uQPVrnDmYsbtJA6GQA0GieXXUSBNKj/jNd+w87kpR+M1/9ZCPJJo45CCmkvNfAFSEia
	 Py5HNTMwcuGm0W92y/wdweOSTwTl/Pt0RAyn3pElph5KoyKCzPuEieG68LnnexBeUewH6
	 bwUJQiE2Cy1WEIBV3PtTI24WdL9lezvWnjbK4fM+MqquXZJlRGn9bvU5oqC+hCXOTYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795705579;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Content-Transfer-Encoding:From:Mime-Version:Subject:Date:
	 Message-Id:References:Cc:In-Reply-To:To:X-Mailer;
	bh=E678Cqt6pOl2UozE/UtAPfFujhgLn8svHtNLo0eV/v8=;
	b=NDRqVTUnvTUDcfuH9aXdSsISXRr8f5gIC4fHVAjmvOTJ4ztJk2Ka6sjcF+EIX1ZsA2j3
	 pw0TDfFYq2XhOajE+wJ0ga1VH+BZdaFRvC3H+YfZC30OXHyLVdMHTUewytj5F2Doc9tll
	 pXpLHKYvFD8GFnXxw7Q2+Eqdz+JTbfzK56ofNQMgSnXpRFeCS1pOIMRvvB7OiZSNRUm5e
	 bbboqV8VMms0fmL46z1C7K62OxfkDmmZEo5BBwcR4Hm+Wv5pcSwd9ukKiz3X/ybZNI8vd
	 KHR6UtMacXb9PNWLwHmwbJq93hs9jMHJjG0OZ1MREdYbraWigzGUadp79DSuj2ugmPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c3aPM6Z3;
	arc=none smtp.remote-ip=209.85.219.45
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33184606A326
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 15:06:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33184606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c3aPM6Z3
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-92123971d1bso53873346d6.1
        for <git@vger.kernel.org>; Thu, 26 Nov 2026 07:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795705578; x=1796310378; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E678Cqt6pOl2UozE/UtAPfFujhgLn8svHtNLo0eV/v8=;
        b=c3aPM6Z3SD6jPbZtNm85nNnIV8SILJ5+fwMIybn54l+JpMqzMS750p4kuFWLXVwr80
         itNxDLMZWo77GKJK3xGN+i+ybrXEWG2OC5a1M+m1IAA3DTsMVpcHmFqHWECIlo76Fmow
         nRcKauwT4uwpF0ax4phbH6FgHWSfi+He/tB3ymIVfY0UZtYTy1AxImt6lFLyxw0dRdv/
         aQXvyh+BvsOXy6v68phFk36l9PIJgE3jZpKmoMVM1+af4xNqg5rvHOvA433jFqJbYTzv
         pJYVSaYVUIyeVzbePwN3+rCLMvEfv0dw5NpGpFwPXKuF+iyMQBDkVamMMdB0kQ/l8CWJ
         hX0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795705578; x=1796310378;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E678Cqt6pOl2UozE/UtAPfFujhgLn8svHtNLo0eV/v8=;
        b=qWsIm/iPKb59o14bqfU5TB5hVWi21TWCOJmQ5IrLvvANr30Og9gW7KhcqzchrYbj4R
         CyPoGGYVc6M5GTGfeqLckXT9EWgBcDnP1dfKawlKynIyacRx9/q3r95i1G7wL+Xn6m/P
         MC7Ua5OM2+25pIQOKwAuZWCMdnSbl/zfmC/QJV2QqCWe5bD1M94DxvGeTocL0+0I1Grp
         3habQRYd0Kp0eosrinj3W1DoR5kCIG6Z1BXJ2xDuBJDxj9CmWnv5esiKsZN5nka3QLQE
         sfUHsx9PqnIhdOEcY6JnESgJJD4xVC+VXHKUHO7QVfoc381jrpt2juH8pluHPCjSaRFk
         BrXw==
X-Forwarded-Encrypted: i=1; AL+hErGplixoWkOsv12jCNLUZKNPCj4eN+KGLi0XCf63UBm9bGtNBVP7swhNFcpaRFy85gZoPpI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9UTKiLFtprx89VlCawq6ct2+ddxXidkS2SafHRxBHmfgfGL1jx
	6Srar+/1KirMay5vvOYHPFFX3Jdd3ObZFBSTBdMnxd47Rac54+TKvG3QDaee4w==
X-Gm-Gg: AZFdTZcP1AR6R0w2QUBKENAV41KrVvPzoa9u4xGnuUMsHpDoyzdWQaHtDaTE2RRYtVE
	e9WX33jUexvxIX7AiWOUEjlgUbXDJJNUfGQvJEqNiTAzIMFHwqVodmcYHbWqqu0TDEdBKgjrOHX
	XmHvj/WwPkGjt1ZLv5QNT2qDeh/6VGQf/M6BDnF5wJ5evd4vxr3ztlVZ+CdXtLCGUBQ9gcmAQuq
	5H4UbzLCqdXyOlYPHiEv2ZbI4pmdSKA7hh8OJpokBAMwnAOX4A8j/ziaX0X4zkJ9v2rXQaG6ALx
	f8IIw8jsDwlR2fvY3liGZ2HeHjbMzCrvmFIvIARFjY3SFoTDoPdPU8cGrO8cjOHhJoiBO4jBKNw
	KUnN4sa0CobxmEEwDUPv54jjenKqI6MJLPqOq+3iaf4udHkMgvNIbyO8V25yIXcpMeAPIKXRYyI
	7Vej8ZsT/UoIXvIoYER5yGFQlBFoVwX/ySjxhsXJ5XS/usJiq4BZ/fA6NxDb9b/mpY/yVRMHRBj
	Fvqav+EBsoCOGkRM756XTWT895qCJnpZxaYOIH/O+Gh+sa34f1F1fdvMr1cP8CWBrbtpYD9Imjx
	vJ5bNb+v45aI+lr0W8df0O4DKF2k+GT2W+dO5gWR7hWDNdv8kQiJm/XqKZktPVD19Tc7XvwAzWH
	NrqZhdaojFWrfHVUbacTQlaAYPEuS/98vJ+nvAJkBvZXm1/Kv3iGieCrPHTNWUSX9ofJSLK6QBr
	R/i+4=
X-Received: by 2002:a05:6214:61c4:10b0:91c:50af:f6ad with SMTP id 6a1803df08f44-92134b3e3d0mr316301676d6.50.1795705578006;
        Thu, 26 Nov 2026 07:06:18 -0800 (PST)
Received: from smtpclient.apple ([2600:1004:b09c:4310:19f8:eb58:faf7:1062])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9217c38f19csm42713016d6.26.2026.11.26.07.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 07:06:17 -0800 (PST)
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
Date: Thu, 26 Nov 2026 10:06:02 -0500
Message-Id: <C4F71C1C-8A3C-4B1C-B024-233245433612@gmail.com>
References: <607d6273-14ba-4005-b038-3778ad2812fe@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>,
 nahidhasan141400@gmail.com
In-Reply-To: <607d6273-14ba-4005-b038-3778ad2812fe@gmail.com>
To: phillip.wood@dunelm.org.uk
X-Mailer: iPhone Mail (23D8133)


> Le 26 nov. 2026 =C3=A0 09:56, Phillip Wood <phillip.wood123@gmail.com> a =C3=
=A9crit :
>=20
> =EF=BB=BFOn 26/11/2026 12:30, Ben Knoble wrote:
>>>> Le 25 nov. 2026 =C3=A0 13:54, Harald Nordgren via GitGitGadget <gitgitg=
adget@gmail.com> a =C3=A9crit :
>>>=20
>>> =EF=BB=BFFrom: Harald Nordgren <haraldnordgren@gmail.com>
>>>=20
>>> Quote the value when it needs it, and put the command on a line of
>>> its own the way other hints show commands, so it can be copied
>>> without the surrounding quotes:
>>>=20
>>>    hint: did you mean:
>>>    hint:
>>>    hint:   git config set status.comparebranches '@{upstream} @{push}'
>> I wanted to bring both folks together to figure out: should we shell quot=
e
>> assuming a POSIX-like shell, and do the current patches
>> work or not on Windows?
>>=20
>> In other words, would we need to do something different to
>> behave sensibly in other shells (fish?), or is that not a target worth
>> worrying about (GfW comes with a Bash environment)?
>=20
> Ideally sq_quote_buf_pretty() would take the current shell into account so=
 that it generated different output for powershell, cmd.exe, etc. Currently t=
he output is suitable for POSIX shells and csh (though this particular patch=
 does some post-processing that removes support for csh). As a fish user I a=
gree it would be nice to support that as well. Fish recognizes \\ and \' as e=
scapes within single quotes, so we could support it in addition to POSIX she=
lls and csh by always backslash escaping backslashes as we already do for si=
ngle quotes and exclamation marks. A prettier option would be to only backsl=
ash escape backslashes that are followed by a backslash or single quote.

Agreed this does not need to hold up either patch, if the fixes
can be implemented centrally later ! Thanks.

>> One other thing: it might be nice to centralize some kind of
>> automatic quoting for suggested commands.
>=20
> sq_quote_buf_pretty() is intended for that use case, so we already have a c=
entral location for that logic.

But advice-emitters have to remember to call it, right? I was more hoping
for suggested command-specific thing that never forgot to
shell-quote, but maybe that doesn=E2=80=99t work as well without carefully
marking what needs it. So, ok, makes sense :)=
