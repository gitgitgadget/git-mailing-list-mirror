Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A802753FC
	for <git@vger.kernel.org>; Sat, 15 Feb 2025 13:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739627937; cv=none; b=WrWuhugWVaNkULvFkBqPzXFsKji/IGkl0Nfx20thswnKoqUzNu5t4ndtRxF8+sHpoV/lRtcpIcgnlnVKb2TJ5N7l3xi2PVbFiHSYNjLDKjVeBVfCJYbLWoXknKy61qIbUrAxo3DqN+n5+jJsIja8vYFmd8MXH5I+qRNW27yEHQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739627937; c=relaxed/simple;
	bh=c6TR/Fs1+/I59ud2HKn+L61VuKH4xuENPZzuR5k0W5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cnKnoScIXKJ5lPbyhz72u6Qo7HbAFnofpBaQ7F5/ZDn8+FDE/7jSFoT/RRtSve/RFNK/HhrfAosqaDXF7V42AvPci9rzAjbCTpETXwtQcOuAFLbMQRvn7ci8vcHLd2xzO5tZoyzsEGUyZNJ8u9Mj94uGrDo9+/sdHwNnCcp9gdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=tv7mXE8O; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="tv7mXE8O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1739627886; x=1740232686; i=l.s.r@web.de;
	bh=nE+J3kuRCfeMms/Qd8FAGyavYRM+zMz0wqvrTPunG5E=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=tv7mXE8OlpYSRCSPWYwN/xfSniq33SrB6k8z6wLZ56qMN1kByfCzXRD81AcxO03F
	 z1IjWpzhKtTQFiUwfbjcSJcYccKl+MtQ2jKn5do5FpaUWQF4j9zA5ldnzBE8RIEgJ
	 sK9XFLqLCfqpRDUpTHdpr0fWn2wJpV405VuHq5lYBULK9viJGRcVM8lb/3lLmw5W8
	 IeN6VJOcT9CR7qbCiPbtl0+AVhUSlIqsiGKIhnW0rTpcQ/JETTWZwNAJlVCjzII79
	 iXdRmq2Zd83S+fVrph5pg7ZLL2nI0pubE21Mpn0nRV8qlO6ybLMzoh6YUVTfVzxGV
	 B1MbMIN2wDZKv0CJiA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.154.101]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MiMAO-1t7CFE25Ac-00heNY; Sat, 15
 Feb 2025 14:58:06 +0100
Message-ID: <574a777e-8dc2-4bad-8248-8dee97215d40@web.de>
Date: Sat, 15 Feb 2025 14:58:06 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: free(): invalid pointer, error: git died of signal 6 and error:
 git died of signal 11
To: Christoph Anton Mitterer <calestyo@scientia.org>, git@vger.kernel.org
References: <1480fc360e9afd4e2d381e1506624df058355ae6.camel@scientia.org>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <1480fc360e9afd4e2d381e1506624df058355ae6.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Y0LZFag9atO52bjZStEBg6MT5XFA3SOkde7uhFLjd752raZVxgL
 0Vf2FzdFC1MkT/v5bBJYnFlXBPY7neG2G4zXS81agDv4YnuEkj8OQ/m+B/qX4C+aofyR/9Q
 29C8aiOt4DWJWsOORALKOwos8pgb0txTRDSWJpZjkQVLW3fqy/QvEUUNeEvLjXbOBiMKSjK
 8ZEXiVIz/UM3brw++V6nA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mlAn1uc2zn0=;zbJZeKjZyrs7+8ICm95LYzqYJIj
 WgFqsitYalZp55u+ONC0yPfLA4ViMliCZS8GV3BtmBo/uZwj2iZ9JNR1sPbXutn2DZxErJL9Q
 SnARaTdgCuDYmgD9I4GZb0TuQlTVnHjBi8zBg4mOIlDHGli3Kt/z6Kx67Fve8bFvzkpXBB8Ar
 7S91zqnp8Lz7Y5iUBGH18XGuEvDpIYairwHYMFsNm/2s1DJlsfaJLUjt1iMM1rkM9HCMEKlRG
 HWIwIbumL2Jqt2D6yWYg9dyVXbxFu+PGEHgECU2/qvcQTsTkG/3GvROQdl4foCKukcaqPysPw
 gDy4iS7bqXNJImjPZNxNbgGD72ZSjl3VL2KTOsiBIyyBUQawZbOCpMS+5rw5W1CLg8UwyR5M3
 tgwOlg6WG0u7LKI9G2QiNOlvicKmWKL73Z9WLGKsMNaozfM8R1lOpH+7hba5gQBO7ziP9EulK
 OrGsBfIFvcCr+fqAfj9K8m4HxAzhVjWZnscvQCieXP4MfbsqYAdlnRSPy+k651ATu+fiXU915
 UEet7iOFC8pbxwylq0+30+48HdGk5dAeqjdcsPyjU7W5jVW7Qz70V42mb5MfaNyPyQNc2lQn0
 MZu6GRo592YVtdFsJxO8T+b6EhNQrQ/j/Ia8vrxthxXHwe3Dp5Ylby2OIuOeuNFh1/UPuLhXN
 yBBtCWGLs7qbhoTmYuTL52apFv11ItvG6u4O/65h9QA6NkGV3fjmdTzsvGvj2gIwR25L4gWXh
 r6XwqxMGZqboXIY5CA+Ubbpx4Ks6MxCL/ef+v5eYFY6Ln2MQ4yR+jdTJPnZWvHWeTDGhLDdYT
 eaQlJGdiTl6H5FPYt7A2uZXvqtRaWds5PzV4DlbeD1rwDRq714HeqzXESjxoLSUpYhirXWb4r
 eWnH76nqlDx2VyQIe5+sKdmdLui7tH/wmS1okvwD+itdpEh8B851mWSsNrxUfbM25uaXNYp26
 BDSM/GWooHnl/pQh31jOFUBEq2cn3RE8TsW0sH3CIGIAeQXuJIPadD6HOH7um71MrswLiN9CI
 hIFSiJGS2DrFzsPnwfgOZ7zBNRwYDzzlFv6kJ9+XH5jHpX7lM5OamvjXmIslonnD4+r+EALYV
 wOQerD0HWz0uti3ZcQyN4fwgmAi1qad04eVtoKbVJwsu6Ky+H6coF/jFf+twi/WonksA+IEh+
 TuEOf7a2CAgSxN8CiY7LMulsRXQCeU649U1Pi3d20WKX6QSQgK3jC7Yzl7dAirMrbqHwHZFyI
 Gf7Pler+1PJuzQl+qStJO++qDDUFcTIRoHQTihcg9shN/Ra1f4XIjbKtbrvSVhhZjkhHRYO5n
 cfAvNYRYdEvygxk13D4Dsgn+pyM247XD0pWd38juLRr2N1XDK54Uesq+680oa6RG3nCjwk0nJ
 advwLHfpdnRrGZ8HQfu6zK20C5LCkX/5V8nAuMnQN0dL4u73G+xbTuKza0

Am 15.02.25 um 03:09 schrieb Christoph Anton Mitterer:
> Hey.
>
> I see some weird segfaults on a fresh repo.
> It has just one commit with license files, then branch from master in
> which I have a staged an initial skeleton program.
>
> From there when I do a
>   git dt
> (which is an alias `dt =3D difftool --dir-diff`) I get most of the time:
>
> $ git dt
> error: git died of signal 11

This is a know bug fixed by 98e4015593 (builtin/difftool: intialize some
hashmap variables, 2024-11-12), included in v2.48.0.

Ren=C3=A9

