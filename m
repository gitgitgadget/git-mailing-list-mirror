Received: from aib29agh123.zrh1.oracleemaildelivery.com (aib29agh123.zrh1.oracleemaildelivery.com [192.29.178.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F76018643
	for <git@vger.kernel.org>; Sun, 29 Sep 2024 23:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727651054; cv=none; b=PjYmVYWzAEzrIik6fKg4ZdtBj+l/EzKTG6kaSzEidDuJ72YkdfZmiK1hcuCrOQSHfmT17W30Oxtpo/h7aNBuJLEfGXS6g4d7u864EDhoLdTRAfM6WZfeUSOqiercvGn9Bm/mzkqjB3j0IZZeBMJN5isTHEj3AhenU6IADrpbJGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727651054; c=relaxed/simple;
	bh=rto6b+vxBBqcp7aK1I6hVHlKN5t1WYUbmm91jUKz0RE=;
	h=MIME-version:Content-type:Date:Message-id:Subject:Cc:To:From:
	 References:In-reply-to; b=ekhK+Cj4PwUp1PZC2FJ40iRZv1Xssx7iz6s1xfavpJm3cTu4nm9nLKsTBbWYyfBgfOJC3jmdl5WoxVtb5uykIUk8sGdgM8ZEe6bzJZON347e70YJuNerjEO9+314Szrv/yANlu2wiGgNqhrFIbw3dKycpG1d2Usnoai+pKPjM8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=dzu0Ciat; arc=none smtp.client-ip=192.29.178.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="dzu0Ciat"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=rto6b+vxBBqcp7aK1I6hVHlKN5t1WYUbmm91jUKz0RE=;
 b=dzu0CiatffWtTLRaRJVzk+fSUnesOVYDxyfKspRgC9fQ5uzJg5xaFJt0RNUpCXfYMQ0n205njFNQ
   NeJbTiu8pjus4+pSt6D2+ChB8KKzuoDe3JYVVJzj1uNu/44bVrjINqkHqCpGUfkHfTSof6aFp5eO
   TNdOlpfOZuag9M0CEmlLw+Q+e/fpY/JapY0qrbi2z9lzYFh9ueRYx1hJ3Bmxq4ipguyZF+CoGL8x
   yr2rs1X9wHeiYNwzZOsN65f3mOilCulULF9PwSASD1aoSBwXrAfSlVi6eNtom0iHUiNf5p/t454M
   N3E5ar7RgL/o/uBuSCvpSKIgwoyZSNAZn+JNug==
Received: by omta-ad1-fd1-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SKL00IN1JUGWP50@omta-ad1-fd1-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Sun, 29 Sep 2024 22:59:04 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Mon, 30 Sep 2024 00:58:05 +0200
Message-id: <D4J51ZYZXBTV.60W3NPNVL78L@ferdinandy.com>
Subject: Re: [PATCH v3 1/2] update_symref: add REF_CREATE_ONLY option
Cc: "Junio C Hamano" <gitster@pobox.com>, "Taylor Blau" <me@ttaylorr.com>,
 "Patrick Steinhardt" <ps@pks.im>,
 =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: <phillip.wood@dunelm.org.uk>, <git@vger.kernel.org>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
References: <D43G2CGX2N7L.ZRETD4HLIH0E@ferdinandy.com>
 <20240919121335.298856-1-bence@ferdinandy.com>
 <20240919121335.298856-2-bence@ferdinandy.com>
 <7fecc442-8d5e-4542-8ce8-907c35db870d@gmail.com>
 <D4CB89OCTXWW.2A4NL7RQP4IS@ferdinandy.com>
In-reply-to: <D4CB89OCTXWW.2A4NL7RQP4IS@ferdinandy.com>
Reporting-Meta:
 AAERNvicCAjwYkkNtiSJoSy3R88FH5MnmHR53TZbKORqXOvfj5gKpm8S7OaATUD4
 OyUY9mo7imdiioPZCjDy2ZnDGRtge/7sIZmSFLGKs8ldm1gtgWgE3wiJU8Ujwo86
 zlSN/b1kH0iwPY5Y3knbHAVXQfuBmkBKgiKXlnMj4sluE5FEIYXKzQOrFk5ui3mi
 rOQYzU/P9ddVJjjq19AJwGjy47I60lFJXz4HWwrvYa5+u4ReBzdJXC93/FtBtyb/
 6stusVgWkzdFXx7cfTkgnhl3WaUhWP4VpEyDIAa+hLEYyodB5h5YaitRVz+5owi6
 wiIDfI0N6tWfI8vr+6O8MmUI6NOQwZ5JYaRxEHzSnC1bjKnC95N/Bg0fvWqGBMCh
 96qcDcKqG3NGL+bhuXoHG3j61U0A/aQRdJ0SsZKidouoN6cLaI5D0vcW8bevJlEl
 noMrkeJcPnYIMVS8iQy9b56m3qb7rXiGU7hMueQI2x0FkA5+0Axy4ec=


On Sun Sep 22, 2024 at 00:19, Bence Ferdinandy <bence@ferdinandy.com> wrote=
:
>
> On Sat Sep 21, 2024 at 15:40, Phillip Wood <phillip.wood123@gmail.com> wr=
ote:
>> On 19/09/2024 13:13, Bence Ferdinandy wrote:
>> > Add a new REF_CREATE_ONLY flag for use by the files backend which will
>> > only update the symref if it doesn't already exist. Add the possibilit=
y
>> > to pass extra flags to refs_update_symref so that it can utilize this
>> > new flag.
>>
>> I'm not sure we need a new flag to do this as it is already supported by
>> the ref transaction api.
>
> Thanks, I was not aware of ref_transaction_create. It also seems to retur=
n with
> TRANSACTION_NAME_CONFLICT so we should be able to see from the error code=
 if
> indeed the existence was the problem or something else went wrong.

Unfortunately, it seems that my reading of the code did not pass practice. =
When
using ref_transaction_create ref_transaction_commit will return with -2 if =
the
reference already exists, but it also returns with -2 for various other iss=
ues,
like if the lock file already exists. I could parse the error message to se=
e
what was the cause, but that doesn't feel like a robust solution. Since fet=
ch
should _not_ error out on this, I think the REF_CREATE_ONLY flag is warrant=
ed.
As it stands, it would serve a different purpose than ref_transaction_creat=
e,
i.e. a "silent" create-only.=20

I'll send a v4 tomorrow hopefully.

Best,
Bence
