Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DDA2E173E
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 17:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765389400; cv=none; b=HIqGjNHVTzUmXBnyqkhsjmiVLMAe67xX3sDUpSgV4ou8CyymeytthaGegWux08R620IIGPbJbCNF9Jnizj3pg/hZqde2M5HVMPW9MXEXp3WgvWXuGbjMZkD+EQQGbO4k0uWBslqgwoNPAeYgAQ8okFIj0JhD5b/qt1Osd1XJ8H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765389400; c=relaxed/simple;
	bh=Wyp+/Gf5lvOWXgCnDy/7V0Q6tauetsNrLkL0SC9r++M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NZhuvjBoLDQK8PGg76qdYGY435KZ1ZtC01mreYBUs/+chjAlKJjzWgYOR0YxMeTSPKZ0PoKUvNHh4ap2NyiS/7zPOl+WSaLu386SxCgKKLrMfxy0KgFoUTxjiy8SpZtXME13PIFymMM3UTT9uQU1ywb585vk8wcjEPm8r7gyh2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=aWe0yEV7; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="aWe0yEV7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1765389394; x=1765994194; i=l.s.r@web.de;
	bh=QZoTWKI+o0PI9bjP0/A8dNhyKeHR/OedlkZaAWwLG3A=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=aWe0yEV7gxPviI3GksIExXobyaRv/AeIcQsX1irVoo4KgaeSXG9nWqtRV5ezLsFs
	 8gNTdT0lRVCwIBwBqnlfBIT5CXqABeeQGtxDJJIcGaqBo3kaMhtRMfcaQq7+cRWgn
	 dNpJWJOW8r3OdNEV3dbXSN6qTUftXHmEzdenLMGXdZmPtlSoTt7EjUGb3DsmkVJl/
	 c1nfFo08JHB+qAX8iFyzpZiz4581zk5tOe3OYNQ5OcgKO50g7WTFlMVGLK7qosK/E
	 GRSQgpT1m+fj6qKixglWeGekGSfLEwYUrw+uMQSmT/FaQVktZ9GCqHo56mpAklo3h
	 eCaOFA2Bo5tCXGx9qQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.27.139]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M7ept-1vNbfL24Cr-00B7AO; Wed, 10
 Dec 2025 18:56:34 +0100
Message-ID: <3d756e59-ccbc-4f7e-8724-293a57c02028@web.de>
Date: Wed, 10 Dec 2025 18:56:34 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] config.mak.uname: use iconv from Homebrew on macOS
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc: Git List <git@vger.kernel.org>, Koji Nakamaru <koji.nakamaru@gree.net>
References: <53690064-1c98-40e9-8b9a-7ba6bee63703@web.de>
 <16efc726-34be-44f5-aa92-4e82b663ab3d@web.de>
 <20251210164256.GA30949@tb-raspi4>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20251210164256.GA30949@tb-raspi4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:x78vSBwZvz9GB/JUxMAI0MHKeDQ1KUXsu/lheys+4k1qNJMeOLK
 p3nzfLN764MfQwQHIHXtrhkXn3i+Y4kAC04CQI/7gLyAk10fN/tSDyNmZlgvwMmpFIAVa4D
 U9FHXJCnEuOauXXgyr8r/yhShZTBrqyNRbs46feFCESpzZ1RSJGhPjotNkNaR6diWr/Kv9o
 ZQ4XagsEBZIGUVY6NQv+A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AnPFnuKnBXw=;iw2FKnKsWbrOtbH6tOF4ccNvZ6o
 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
 PvsIwIuI23Yr8kIAo=

On 12/10/25 5:42 PM, Torsten B=C3=B6gershausen wrote:
>=20
> (Probaly a stupid question:) Does libiconv from homebrew provide UTF-8-M=
AC ?

It has.  Curiously it also has the alias UTF8-MAC, while it doesn't have
UTF8 (but of course it has UTF-8).

> And does t3910 pass ?

Yes, except for:

not ok 23 - handle existing decomposed filenames # TODO known breakage

> I just realized that I am building against libiconv from mac ports,
> since years.
> Digging into the Makefile shows that we have a switch:
> NO_DARWIN_PORTS
> (and another one for FINK)
> Does it make sense to have a switch here as well ?
Carlo brought this up in the other thread as well, will reply there.

Ren=C3=A9

