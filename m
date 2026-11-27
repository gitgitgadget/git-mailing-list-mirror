Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795780124;
	b=nR/5I45e4W21cAPj50gw/MX9cGQnhKcYM83XyswzxPRt9oNdERRh1PnArSMoz9HK7dZj
	 iGQ6Jz4OPrB1LEoV1v+9P8gmXraEvf78tHURZ6yfiI8IUWBkzv3eIBgWcLsoR8JMB8p7+
	 XoetTxrifQ+mSOWvRYkAi0tyHEsDICI8RabPkaG0gRJVZwJr43p2uGoVr0gxGbAz/1NA7
	 WB76aVq1dWwLN88jdkW9FZecks6KacFIXtLRujDQgPJ7W31d9cieg51lDBkTvaYL1hW0D
	 Mc917hhwWwni1azoCQNpoW23n3vU5FLRJlmTHcSPZCxApSk6gytqsYiJUT7US/AXTIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795780124;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Provags-ID:X-Spam-Flag:UI-OutboundReport:
	 Content-Transfer-Encoding;
	bh=wotq4v2/JJSPBXYt+JHZSA9ioccg32wN27Sy7lfYIB4=;
	b=nzypvtbcYSqueNgwsQETrhJ4Qhb19gQj+9uigMMo8b8g+qa8aUy4dI2HPav5jsL5pqXu
	 EucBPd1uNB81feSWty695EdbX2N1bJj6dJNzEInp5dSiA2VGLkq+B8WhNmaqSxuLI83HS
	 iLEprCik/GjJm6BBhGleMJ71zDc40ZIMdMwi7Gee2teti9rLrak1+P5iiCCKJpj1OI4yG
	 wu6PDeu3oqKdt4q5Au5CwNXnnqzIls4c+393rk+0Hews5Hd5DJjJ/BZ/oADkx6Lcfaraj
	 9SmU5uBcn679HbhW5Z5majR001AgAbcXCbsdImRZHMBdBcRY3XqE/WmmMFbblyKdGEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=I7pQwlsb;
	arc=none smtp.remote-ip=212.227.17.20
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86643606A32C
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 11:48:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86643606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=I7pQwlsb
DKIM2-Signature:  i=1; m=1; t=1795780118;
 mf=PG9zd2FsZC5idWRkZW5oYWdlbkBnbXguZGU+;
 rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
 d=gmx.de;
 s=s31663417:rsa-sha256:Ii8DuwDfHF3kw5Bpp0LbXiy3QQv8
   uYRsUNFfKUHzrSGgxU97Sm7oxe3j1u9xbgTy2QMSd9vL5L33GtOGzGM0rjE94lxE/iSke3k3Dew
   0SDHz3Bi+0yCoj1AnEGOL3ct/2X67pFGcZJQVVm0m58RwzU2C/J169SoWJgg71pmudXKblYrLgB
   Adhi9H673tIZb0ebaABRdAE2MtfiHU+HPbzonTCiqf6arbrUTDXsWOwxTWfl2DK7zQTjwBntHaI
   mr4wW+AoZjeCxArw7iY+wiNdEnrbR+vqQnKLMZtTnjI9dJV6ATudkcoo7KxIdPt4z0sovGlpdzA
   Y3irs2GUhMc7zA==;
Message-Instance:  m=1;
 h=sha256:
   +5yd4G1vas4JJlkjyEp9TDHUKRUV9iI2RTeZ2YbXwPs=:
   wotq4v2/JJSPBXYt+JHZSA9ioccg32wN27Sy7lfYIB4=,
  sha512:
   8wrOg9mIAiloJbebv7UaIaAjSjnskyFA/01l23FGz38kncLZq5lka9KR5AQvbydoY7JjNHvVuKu8L8+wq3IhLw==:
   bbOa7wQP668yWoNsJGMh31lUcIfgXhtEgBtcJgII10aVATrHOIzTHdkU8y+YwqAnkXEJFi0dEvh482CzouFw3A==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1795780118; x=1796384918;
	i=oswald.buddenhagen@gmx.de;
	bh=wotq4v2/JJSPBXYt+JHZSA9ioccg32wN27Sy7lfYIB4=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=I7pQwlsbZMp/iY0HSf7/JIubgx31w/NYzraZlfnO3XWISt40u0tJ3tUuwF4bEU/k
	 CJUoawkc4Ew8T/6L2syHUGQgumLZFflyfCCh0aloT4Cw0xfl0bCNF3rZu9HKtx8N4
	 tAfdNZpYXjGa/KlijuuPShk+3LbpP0frDSnGaKhzgfb//Om4LbUh1gMetVvFHqTqP
	 Cjaj4Xa97IsLY6U3xfr2IWBYA2NoVPV4WFSy01QBwHL+nPR60CLi7XdulAr4FmSJ7
	 2y1Zs0G+7BIvnBGCoZGWwtcAvJMYngxJVm9XpKyWo35IAdgJ/9Gf4Cg/tlX6Bbkdb
	 sq349MzY8xV0juzgfA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MF3DM-1xhso21TFg-009UTF; Fri, 27
 Nov 2026 12:48:38 +0100
Received: by ugly.fritz.box (MasqMail 1.0.0, from userid 1000)
	id 1xWuRR-vzC-00; Fri, 27 Nov 2026 12:48:37 +0100
Date: Fri, 27 Nov 2026 12:48:37 +0100
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Hamdan <hamdankhubaib959@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [RFC] git task: grouping commits into named units of work
Message-ID: <awluFTzayEBTFUVr@ugly.lan>
References: <0AB3AB52-1F14-4C72-ABE8-46B635F463CE@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <0AB3AB52-1F14-4C72-ABE8-46B635F463CE@gmail.com>
X-Provags-ID: V03:K1:Tg6jqPQXh5GHLJjOGmgoP8Xn5/2ugbC7Qo1K8ZPAD5LS5cN3wvJ
 FpQodojJ3Pk5o0a1r/9fQA7QHUvzGRj47RHqG+xeMMigvRIGNFThmX8nz4eZDFDEL1Cg6fs
 fYVr2pGUp1pF69XGEV4rbUlM3giyicM2vdBNmaLD1/01+35OwOyCS7XZYILqT4uMK+/hTgg
 5aKEV1g1MY+W9RxXUqL3Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ljHUdGkEKe4=;wa6GH42PM7YxBdgd+VN1mh+vsm3
 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
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 27, 2026 at 05:14:44AM +0530, Hamdan wrote:
>What I'm proposing is a native Task primitive that gives you the=20
>grouping without the branching:
>
https://wiki.qt.io/Git-gpush-scripts

other such scripts exist. that wiki page should give you enough=20
relevant keywords to find them.
