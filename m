Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794306562;
	b=XUi2OPS/dSKnZ1d30gd7bPDKAFnqwXDuQUzBqYWif+hzWQkA+Yyhdub+TYMAviSj2uXk
	 6iXxjndgwGELXt5gECqsyWsN+OgSzUXbQN25fmPDkt7cRzu2uX8TiBBmk2uAn3ge1dJi8
	 OuBbQTFdvvSrdu3m83G17uzvJ2zoneAYZSiVQns12Ck7oOqcknI7/H7YGCQcDszX4LEjY
	 zmUixBA4A5h8F3bJYgQZgzbpYEC5roOyZawh9VQCD8geD8yquO47vp945WbXFJYhvheAA
	 khY5HVji+vzm73H54wGk368cQP3Sh6ySC9xdUsXaBk/tD9kixRySdQAJJJCV/9oj5bA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794306562;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport:Content-Transfer-Encoding;
	bh=feDdgHdlkdjw4xmQ/9Nd0LQSS7xMMB9CnBG6syHtbnU=;
	b=IHBfH5a44uX7LrXsKTnkYxMGUmoLpRORvlgVAGm8S1eQAchbtRgY/T/rw552Xiz4nDuI
	 f2Wcd/5DoQZuwYvxdteg8miOHIu4eaThDYyHfOW6FBmxhTmT80p5fc2Nm4bZj5SXSGAQk
	 8ktkwWFkJPmIZ0gZGU/RR8Eq6y6NCJUHGyOU/RIuWWv5btu84WGd2JGQTMJauLZwH81pF
	 mWvLvQ0E9fCIGQUCks/dsn98/ykb7C6lHri20KrqykPrAm8b8E+c+ToxpNZmFQlNyR9oc
	 8mbWIeK0MCFmIL4UnLJg370mFBiHPz0vWSarsneU2m8hmTYivUcl0ZlYlc3uJtpy60A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=tboegi@web.de header.a=rsa-sha256 header.s=s29768273 header.b=WacVTdpy;
	arc=none smtp.remote-ip=212.227.15.3
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E477B606A325
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 10:29:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E477B606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=web.de header.i=tboegi@web.de header.a=rsa-sha256 header.s=s29768273 header.b=WacVTdpy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1794306549; x=1794911349; i=tboegi@web.de;
	bh=feDdgHdlkdjw4xmQ/9Nd0LQSS7xMMB9CnBG6syHtbnU=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=WacVTdpy5KS6HCZtLSZu4g0+uVv4s4gukqVD0a4mcdq0cVdz23tTx2d+gau+o6g2
	 GryHeOoEFlnrFvS9I3ye/qVGr+c6GRZ33XfGk7cprsftZyd4jk/BmDUvvyukvVR8B
	 5KR+t8S/+se963PpaSccLNeNANRcLHaUToxVnueOKoVgDD08fUeblOD1i9tO7ivXD
	 UiPdjWmoBQQNrchqySBj7/3zcxexMPW48bG4mFtuTygV6yacvN0kYY4rchKBr/BSs
	 7m4arD6g20zKIRCgFKPRPLHWi/NiLavCNF1dEB/+3vMQ3mjWa+rDuVA4NnE2aVVpN
	 dOtrEa4p1cv+7HGmrA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N7xaR-1wMCKl3Hut-0144Ch; Tue, 10
 Nov 2026 11:29:08 +0100
Date: Tue, 10 Nov 2026 11:29:07 +0100
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 5/7] t0027: cache expected output files
Message-ID: <20261110102907.GA30426@tb-raspi4>
References: <20261109-pks-gitlab-ci-speedups-v2-0-508832602d0b@pks.im>
 <20261109-pks-gitlab-ci-speedups-v2-5-508832602d0b@pks.im>
 <20261109144651.GA14738@tb-raspi4>
 <avK_XnoZ7Asakg25@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avK_XnoZ7Asakg25@pks.im>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:Ljn43nbvUiKjfPLlC4JWLKTIryTz9lftMOoljImwXMK+DbYUvC3
 i7qWXWmemM4bXyrF9yfkGMkwTBhDH+TlH14X3LyVIZHYKr/0O1PWSonNiWaGk+qPfWSngu3
 T0StlmNKeQcQzYc0xZZN/RLlLGzFGuq0OuwytZYCU06aF+nb9AgmBk1pAHpTlzprF8lJus1
 AITIWaXeFVn+F2u2tBDrg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VPC0XHxwd4k=;dT8vPpJnCIB3crTdcTUIrZxzwFd
 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
Content-Transfer-Encoding: quoted-printable


>=20
> Thanks! I benchmarked this and it doesn't seem to make much of a
> difference. So I'd propose to stick with the simple change for now, if
> that's alright with you.

Good to hear that the benchmark was done.
OK to stick your patch "as is"
