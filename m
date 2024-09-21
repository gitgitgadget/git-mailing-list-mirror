Received: from aib29agh126.zrh1.oracleemaildelivery.com (aib29agh126.zrh1.oracleemaildelivery.com [192.29.178.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D797DA6E
	for <git@vger.kernel.org>; Sat, 21 Sep 2024 22:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726957218; cv=none; b=u3onhrXDK2GXjQ/HxLuR2xcRYBGS4+o+D8cRHH6EcaoTNknKYVOsoeMrhga33S+cOBPzKDalMfvbXUo190WhzuZtciL69UQrqvNBZtRihXNpggZhnXWFiweEuc2Lt36yd+JdRLBH1vpBzdNIOYSb/hugIORD3j68lKCnGToYb0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726957218; c=relaxed/simple;
	bh=xmSlPiWSD2HWP7mMW6cNasGo9PkoHsXQ/9vG5fXTXD4=;
	h=MIME-version:Content-type:Date:Message-id:Subject:Cc:To:From:
	 References:In-reply-to; b=WqLX0NNYcd1+h6CG83VVV98PzentmR7e2n7kwCp0gZQgzkeiQPah5sB5L38FQs6zEuTci2cdftoFcs+a9IXTm2u9uZWsjqtcT4GiS8InXSDujpOqGQ3lO27pth9QG3eIxkqeNrvk3DI/JALBNx9Z1+UQOlfLF5MF4fyOUZUS/Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=bjaPS2dA; arc=none smtp.client-ip=192.29.178.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="bjaPS2dA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=xmSlPiWSD2HWP7mMW6cNasGo9PkoHsXQ/9vG5fXTXD4=;
 b=bjaPS2dAKm5zrlCDXwnsvZdki0ITBdvzzf4bvgBZVjhdfBYAoluIvrEfqCNyf33Ypvf2AYPMppTt
   RUdpBT0qJ0e0K1OS2smMNSP/s5TuDEzFNCD6QWkFw56R8L3D5IWN5RUZjK3ARMH6ucfACi28fugC
   VUdK8TZQKUbO82WD7evfjnSOz+gZx32kjRgUC6IHfShRQeZFT7HrH9mGqmBwU35PmWItF3YBYIgv
   7c1v8LtkMZXoS4KsFPeUnTAuLFTi1LTD9K9JRJV6JnTv5soPigwyLaqU9x7QjYZcR+6kpgzgos0v
   tQiQ+d98i2eqrK8ZM0PeOwXUMi/VdRS2TAy1PQ==
Received: by omta-ad1-fd3-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240709 64bit (built Jul  9
 2024))
 with ESMTPS id <0SK6006Y4OPKJ140@omta-ad1-fd3-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Sat, 21 Sep 2024 22:20:08 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Sun, 22 Sep 2024 00:19:43 +0200
Message-id: <D4CB89OCTXWW.2A4NL7RQP4IS@ferdinandy.com>
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
In-reply-to: <7fecc442-8d5e-4542-8ce8-907c35db870d@gmail.com>
Reporting-Meta:
 AAGDw/L2ChP+9pIoaX381dk8WADVhHOQg66iB1URQsRJ41k3af1Fa8xHl4OwpCov
 VM+NzW6qsKnoMQZorWqpeHo9RglvAUAcZAi0lksCH0zdVWxTnRU76sjJ0L+Jdxh6
 iI7FX6jvIVQxjodziuZxPF4xqFRssxaxjEMgsxLIHGnJp5tjF4c7MN0qt6VjflK/
 IfPKXF8DL+8cfGSeJv+aXuQBD4gj7zmSomQKDPvCPwTRZwVXXFCT3a+QO1Id3gr+
 57/eNQL6HzElD7JS1gDOS9ti3bAJh8T+ehaDNgpemakqqymYwnz8pkfm39x1+3/v
 Tp2/ImopFfPIbNcVgppzES94HKXmypxrSA4gAdUZqD4dKVzPRk5nq2B9/XYIVhNi
 zyJ3nqnMBtbdtz0fthDe/Q7d1VMOnAcBlzIwQEZcxrYjVCfFq1QCqs48qG+GdoJe
 +I5fLLDRyPMqCqBbA7IWJ1nP2M7Zb7+etAKCeJieKHQf89lJyaAClWs1


On Sat Sep 21, 2024 at 15:40, Phillip Wood <phillip.wood123@gmail.com> wrot=
e:
> On 19/09/2024 13:13, Bence Ferdinandy wrote:
> > Add a new REF_CREATE_ONLY flag for use by the files backend which will
> > only update the symref if it doesn't already exist. Add the possibility
> > to pass extra flags to refs_update_symref so that it can utilize this
> > new flag.
>
> I'm not sure we need a new flag to do this as it is already supported by
> the ref transaction api.

Thanks, I was not aware of ref_transaction_create. It also seems to return =
with
TRANSACTION_NAME_CONFLICT so we should be able to see from the error code i=
f
indeed the existence was the problem or something else went wrong.

Best,
Bence
