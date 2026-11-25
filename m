Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795606793;
	b=k5A8vKN31BI4DlKal99C+aYah8OfsIvU9g0nn2GC+oIT/jUyV7KxHAC9rbjCnJL3F39i
	 GVeI2fNY4lKs/QEFNHOiwco+dZi5OKoyoI4vdT9GVGc0NGzcMXjo4wXaLiB4NTpeyneTY
	 MhTqWtrlnLbKB8aJcLeOcMRXDGBqH9+X8MIzAYxtE3rIK0sBKGu++aeqqK4eL7pLwCJzF
	 Wh6L5PKvHWuIVU1WYGssLIDyw9fBFcP7dKVCJfC1v+X0iS/qkMTMtZfvrxT5inXP1OBsI
	 84ESddnYLD1gi+XBGleiX6EfGRcTB0+Aqo6pSsWMZSeq2+/G9hB0nRLSHXjIIl95iBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795606793;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport;
	bh=XPcprDzuIaU/KDutMWmqi9eLoOhvjDdVYlsNuVOy7dg=;
	b=3ROJO9IUUQtqVvKdcRduEi2ekrTj86W9zipHa+LVFKwsGgkGfNzXNIsdMHgQLbUnVY+L
	 841UmZkrWzrl/gm9Z/tM2mT/L4olDLr31Jr6ZL1YPcuVgmss5neTd7cUJtcGOhVExNhOF
	 FmuS2s3+yvfn4402Svp9bswaIfS1cL8D1Z/D06QLBkX++SR/20Ir2Zq/3F/UtfCPs3PtY
	 BSfqUsshWfI/wKvea93lF2Vn7BL/Ets0zQiTmF0pzRr3qLJeR3APuQry9REpMwK5Tlu4Y
	 hFxyyHy19vYAEy0wsoaDb0ga25ybEnMGIpKCAFPVGv3Hkxl1xmhRHGQQSIz2wHalCCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=l.s.r@web.de header.a=rsa-sha256 header.s=s29768273 header.b=Gt0NAk+5;
	arc=none smtp.remote-ip=212.227.17.12
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EC3606A321
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 11:39:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0EC3606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.a=rsa-sha256 header.s=s29768273 header.b=Gt0NAk+5
DKIM2-Signature:  i=1; m=1; t=1795606790;
 mf=PGwucy5yQHdlYi5kZT4=;
 rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
 d=web.de;
 s=s29768273:rsa-sha256:BgG7XSHSMrCkROnG5YnpWsj1Dq2j
   w8K8EKDX5cRLucOTuBCz7HgQYFwJLE8PeSPwprkcAkZNG0XfXHu8i9q2xNKYN3pZFYZ4Ck/DWfT
   xAh/SHs+NDGIiu57kFUVvnvpov48bYbL4nDps4ja7FTmM7uXcPubMevk51kim03bwQzezuV8oCz
   NLPERv8FFdkCQhdW3qfeaq8WsgiP3b252WpG12841rG6YtuUp0JSHPfqcpB+mtwaR2zMvnW8pcW
   okn9vTkWyac8tnHZqa8C8+K8DQb8wYdqX/5ZbprZx9HudRv+jCvP1OBW/8u9Bgaxxj6mZ9dNv24
   1OXiwMaWHN2QbQ==;
Message-Instance:  m=1;
 h=sha256:
   z0Iupcb+lsdkR7/ClZ/XFmauBq/xR6IhfHvK/37uqbM=:
   XPcprDzuIaU/KDutMWmqi9eLoOhvjDdVYlsNuVOy7dg=,
  sha512:
   Iezq1ILRG2PkqPYHGg8ZK9QqmCVhKIML/WevpSG+aEZPxi/W5MwxAdDOFMLVfFaHImkeFqMlTl39KGmju8O7rQ==:
   b7iS+OxJKMSgD2S0aAGbkL1J9nVkwikPRX+oRcBFKlVEukYyKUjXclj+aQ1ov3jeZ1MFoXkuvQKO94u28rjoPA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1795606790; x=1796211590; i=l.s.r@web.de;
	bh=XPcprDzuIaU/KDutMWmqi9eLoOhvjDdVYlsNuVOy7dg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Gt0NAk+52Vr8etgMHNliJibtXPsNArphY+/nQYMrydZI2RnQGcyordDOplordBPf
	 u/J29I7jprIDhTDGui6Mbmp2vBzeHaCbQ+L0VLSVLcxqMX9IAIpLBAZhF3G9kRFyd
	 6cfnS0tSyJ1RQb8hTO0oD74w3Mgd/4XxeoHM36JoI6oMkzqy1+iNrplEweUihHHdr
	 RBYQRSM8C+ojrWMPGGf04yn290RZllKbIXK6tkof/DH+enTYwuzpTnulo3VHNNzIS
	 gX0T68MbiV3uoWyvnpU+RGmtgR/sPu11KejimceUSHnywMY1Z6yATNrFpcNVpNtqd
	 6BF0gySb56Jnl4+4Zw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MjBRn-1y8q1b1jOP-00aaD6; Wed, 25
 Nov 2026 12:39:50 +0100
Message-ID: <0565aa25-cbd5-415a-a8bc-ddf5f217eb6f@web.de>
Date: Wed, 25 Nov 2026 12:39:50 +0100
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] t1501: don't reassign EMPTY_BLOB and EMPTY_TREE
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Git List <git@vger.kernel.org>
References: <0e64c973-4ad1-4eaa-938e-f9d60418562a@web.de>
 <EFAA4505-5C65-4DF2-984C-C3DC07A44124@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <EFAA4505-5C65-4DF2-984C-C3DC07A44124@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:b6nnJcR3MJP3lLWUslEzf5XhcSMw9uDuzDbygEK0xMdCzYtJY0t
 c03qFflwHCRj25KzC3pLTnNDJ9m/yIMwVjIkl9M9HvO7xjv1M5LnDNYr4KBwV7xqmD64/pC
 M7ll9ePMiwhwzJbjXVZv1msBdViwZtE4pnVzbSSGkwt8dOebNZEh2941PNhBvAEwFvQhvTT
 WqN69Fc3KzRoOu/gqbMow==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xE+1bNw6i+U=;e/NuROGig+2TWV9cOGX4xmDdAFo
 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

On 11/24/26 1:51 PM, Ben Knoble wrote:
>=20
>> Le 24 nov. 2026 =C3=A0 04:16, Ren=C3=A9 Scharfe <l.s.r@web.de> a =C3=A9=
crit :
>>
>> =EF=BB=BFThe variables EMPTY_BLOB AND EMPTY_TREE are already set by tes=
t-lib.sh,
>> so just use them.
>=20
> Nit: downcase and?
Right, no need to shout the conjunction..

Ren=C3=A9

