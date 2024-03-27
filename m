Received: from taslin.fdn.fr (taslin.fdn.fr [80.67.169.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A534F890
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 16:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.169.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711556478; cv=none; b=fOY51K4nh85SqgMAZAbDH0pFhX4qeMeYytU9XQJcpP12PCGQtTOkht41xt3IN73iN6us4UoHlOrK/I1+zRE1xSvxzbkNVRw2cb9FcmXo3DvcO2yVlaTVj/FWWhV8fZLEPHRaGSMj1+dy5IKYE4NRTfOdoNBNzF2skTK8fqKRMgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711556478; c=relaxed/simple;
	bh=yyNSiEoAIxzbX9NPCcgqIAHGNOrlQYg8hNCJTZIZUpk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=tfJJwmhSpiSUyT21FAryqIA5T1LKIG/RmiX0/NlQ373ZNI5kwHXshh77PstdYBmA6hzR8Y+BZdkybcMNLns9OSXUJtn6+h9Q4M2GsAZ6BDzSTRFVBX4T5IVKN2v8I+O6h3UcZYJ6hMqJrVQOl26KmIY7zrAnq6cBX20uxrMOOBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name; spf=pass smtp.mailfrom=max.gautier.name; dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b=VH5PBW+W; arc=none smtp.client-ip=80.67.169.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b="VH5PBW+W"
Received: from [IPv6:::1] (2a02-8440-3309-f888-694a-b4fa-82bb-551a.rev.sfr.net [IPv6:2a02:8440:3309:f888:694a:b4fa:82bb:551a])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by taslin.fdn.fr (Postfix) with ESMTPSA id A785F6039E;
	Wed, 27 Mar 2024 17:21:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=max.gautier.name;
	s=fdn; t=1711556473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yyNSiEoAIxzbX9NPCcgqIAHGNOrlQYg8hNCJTZIZUpk=;
	b=VH5PBW+Wr2okcIk5EllNiK8wCsUTFOVfHH/bfOu8BlGWfQ0tZPSN5MSl1Lpij0yjhdapcD
	AKpUeRJIFoHMVNYgxrblUlK5W0+yX7L4hao1YxD2rzGOqOz8X7byw2ar08bOlrL81pizCr
	YhrTMTXC++F+DfupXNFtkkWEBQcrP3LMUNlwfwjZGS7D6cHjtN5Zq74NEmKSZwUKKR0QqC
	PhLy2Vd4QYp1PRQxK8M20CvKWhJegXwaN9MPQ6/gv53PIeQMyzcsk1IuMiVLnvFC4utkpC
	YDdVhuE5uYHL0UoO9jBy0K4JPDLVmpvZIS0vLXQxgSSOU7We4F40sy+tr25HPw==
Date: Wed, 27 Mar 2024 17:21:12 +0100
From: Max Gautier <mg@max.gautier.name>
To: phillip.wood@dunelm.org.uk, Phillip Wood <phillip.wood123@gmail.com>
CC: git@vger.kernel.org, =?ISO-8859-1?Q?L=E9na=EFc_Huard?= <lenaic@lhuard.fr>,
 Derrick Stolee <stolee@gmail.com>, Patrick Steinhardt <ps@pks.im>,
 Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 0/6] maintenance: use packaged systemd units
User-Agent: K-9 Mail for Android
In-Reply-To: <398f3763-be1e-40f3-8b91-d0a62a530f64@gmail.com>
References: <20240322221327.12204-1-mg@max.gautier.name> <80580cc5-0285-43d2-ac51-71dce16f0028@gmail.com> <ZgE2pFt-pXurYnKU@framework> <03513931-7070-4430-bfae-aa039f73d74b@gmail.com> <ZgGAA7uwx3aqy0pH@framework> <398f3763-be1e-40f3-8b91-d0a62a530f64@gmail.com>
Message-ID: <9EAC734D-3614-4237-8F17-DDDF060201F3@max.gautier.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Le 25 mars 2024 17:39:47 GMT+01:00, Phillip Wood <phillip=2Ewood123@gmail=
=2Ecom> a =C3=A9crit=C2=A0:
>On 25/03/2024 13:45, Max Gautier wrote:
>> On Mon, Mar 25, 2024 at 10:06:29AM +0000, phillip=2Ewood123@gmail=2Ecom=
 wrote:
>>>=20
>>> It is possible to wait on a lock file but I'd be worried about buildin=
g up
>>> an endless queue of processes if the process holding the lock file cra=
shed
>>> leaving it in place without anyway to automatically remove it=2E
>>=20
>> Side question: we can't use flock(2) in git, or lockf(3) ? The latter i=
s
>> in POSIX=2E
>
>We need something cross-platform, I don't think there is any appetite to =
move away from our current lock file implementation=2E We can think about h=
ow to handle concurrent maintenance jobs once these patches are merged=2E
>
>Best Wishes
>
>Phillip
>
>

Ack, I'll leave that concern aside for now=2E


--=20
Max Gautier
