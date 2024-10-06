Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C02115444E
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 09:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728205850; cv=none; b=g/ZoA+FzKDIAd+1sS5lP9Ya2ocf4zGyM9ao8IY6D+U5JIbfaS6KRtUMzqaEI449r4NEDdOv8caGHAQ/6FhnLrnYYfBA2neNnYPldhjUxSUGmE2LCpMAzC/Ewi6cC/KiE3Kl0kHxKT2A1S1yyhjJYVkCJamytgG2RzlnQYBbwIF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728205850; c=relaxed/simple;
	bh=sBmoZicDw8xBy/xPW1+bWw0YcOznEmsQRQo7OZCTy/0=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=lg4Ok6HqNFvw+zw2smL2v17rZgEMAH4IuaIEFTZVOw3v6WLESinK0+jEjwTnR2hA2An3pumWimJn5nGm1JJr9Usns8mgjPVidTiSNYsIimFJ0Ah9lGvoFoQCZAys2gwKjG13a+++glukI2E86lmkokiDO3R2vuKHQgXVPyRxRKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=andreas.luettgens@gmx.de header.b=npanBC3G; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=andreas.luettgens@gmx.de header.b="npanBC3G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1728205844; x=1728810644;
	i=andreas.luettgens@gmx.de;
	bh=sBmoZicDw8xBy/xPW1+bWw0YcOznEmsQRQo7OZCTy/0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=npanBC3GXHk2IyoDSdWQBKYEt/Yngkb3dh8YsgT7Z6co/xzr17w9jgLxcO/PRryy
	 LExJaIyIENzQ4KD5CudUv4/HYTUOPaP2cgGLcQpiiBqapm59IW7AM0I8rTEGlJaY7
	 X+lRMO/6ynKrQtZv4BEEXV4R1OCgpIE4RnO3XdoSmEGjYz2hKPDKoZYDodg+jftDS
	 oq4onrG2KkCTkpq096YzotSn9KJpS1YZTv2P9IhtvnUG4PDLQQf2TDotRfCqW1enP
	 5idO9ykiuLfXZMifa94nM3iO4bYWmJ4uo8ZBeATPcWrs4Tt2msAeJhysRHhuInpI3
	 3FITLnSHIVfzbVwXrw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.226] ([95.222.26.223]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N2Dx8-1tzpaE2YUo-017e12 for
 <git@vger.kernel.org>; Sun, 06 Oct 2024 11:10:44 +0200
Message-ID: <a8320049-9d71-40a8-8e53-aab20f496bcf@gmx.de>
Date: Sun, 6 Oct 2024 11:10:34 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: git@vger.kernel.org
Content-Language: en-US
From: =?UTF-8?Q?Andreas_L=C3=BCttgens?= <andreas.luettgens@gmx.de>
Subject: wishlist += command completion for deleted but tracked files
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:d3MJMMCnwC+uhn24gWFuQ4EerFCXvoyF9EWqlLwg+UfXYbKL0IK
 ZPhqz+2AwWe+SrjYZCI5pv4G76hxvsfBydFmITfhmlDfsULJQo3m8FGZI5McDXfirwxkYeC
 HWG35M1Yiikfbub0W3j33gjivLxpDv3MblfeJLrA80uTDmWRfa/FrWlwyhUtdZrDHg9wd55
 TP/OHtan8EFgT6tZusmZg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nyLFlSy2cTo=;eC9Iz1lnIwwrd8zfRd+5Pz3evQe
 Sdtm7IjpwhKrx85lyzJ0TahLFRutfcMpYFnQnIFE87FP5C9dwct6aK0TEFbAWb8ajy2SZHLtg
 ftf5kGuRcqjm4MUjyCiP7FvirgvamitXa1H2L32bRU34w6BziFntvxBmosxqSiW54OLvY4cUx
 AxKUtoVvDj9DDtcwZ9IG30ycWXvkPhFrObwgiJFGNQx5SWAFFS50n3pEZy7iT0QLQDqHRgTOL
 qUqU0SgonR4x8z3zX6y6HhXvmJjQ4ztJealPd9rupstPyITCtJTOFb5OsgjOugfBQsAGgtTxs
 Qau2ClmI8TtdXknoOT7od9lynwstpC8BkPRImLN6mSm1AtJHWnqM4dIot628ijt292WvBCwwx
 fcM0KpHneELyXItxSTtcMm6IK0cpxl2Z4AEDoLlol/WBXpOIX3DeUFCoWK9SU4DU5OlKoBeTi
 /VCZ1wLDUwmO7L2fWBetU+BSN2wbSDrLn4uU61iiy2u1dyAmTjaPC5/9x5xc70PGMKxpOX5Jm
 Akhzcu1mRl3ky/BHtFYTHMnqPjjRHq3YC4EaBgP/fE8TKA6/cpWR+pD7SDwOjY9lqlyutP+7N
 NcCvrM2l6JQbjN9mFJpxaPKwXg0mHoXWy4o3Iu3ignNqRtsyF0pJf37OLFGTrEwgHxZEo7ZLc
 6UIHGYRtLAbAnZQUbQQllUD7KxyX07dvt297QLQZeLTi5x35enbWYm/k4jLn4Rp56rokTmS5l
 0El2l1j39HxgykC8Cd9Cw5gLP8LS5SYG4mS3cFYK15nneIW20LD3X+SLBhK7zGTZCEUIlfd/0
 aoHnjSxZAbClVNj105rmjBYg==

Hi,

in my work i had the following situation:

deleted a file that was already version controlled, git status is:

On branch master
Changes not staged for commit:
 =C2=A0 (use "git add/rm <file>..." to update what will be committed)
 =C2=A0 (use "git restore <file>..." to discard changes in working directo=
ry)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 deleted:=C2=A0=C2=A0=C2=A0 IQF=
E.cc
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 modified:=C2=A0=C2=A0 ctirgl.c=
c
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 modified:=C2=A0=C2=A0 joaogl.m

Would very much like to type:

"git checkout IQ" (and TAB) to complete to the already known filename
"IQFE.cc"

This would be especially helpful for longer file names.

Thank you,

kind regards,

Andreas

