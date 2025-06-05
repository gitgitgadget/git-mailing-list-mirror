Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE584A1A
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 10:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749120502; cv=none; b=aLO46l0Bz2VK9+u/OTqZ6Wc4RgM94Jw67Zn6hYoBNaz3KFyy4xVpYP0I7apw9P94Qvek9EOE/cPW9GG3jtQ1pCT43/bDKIapvyjmhbvb9zuFh7WI6mTllKpM+XtKgyznmG3EGgnaG65WmrXaXncBrd9bRxdl7Iwzf0HuwVPQK4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749120502; c=relaxed/simple;
	bh=80Of3sLhmYFoACFDYjSMqET/XxGoyghc3h/b6v9Dkn8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=b+Xps8lGoHqfZWZOgVVNdTHTtANav5kZ/lvy+LnijPUkv79DPv7WbjrX1mk9xuB5ujI1eksB7NIrZIC0Ge6db1Ou3oRG4EOi+oaARnjBh01SJMUtNWDLOoBHHeE4sF3Rc6QTsJBXJK6osinbo/GVo+S7K54YuhuoMNoYlwQ1RnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=poiBPY+C; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="poiBPY+C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1749120495; x=1749725295;
	i=johannes.schindelin@gmx.de;
	bh=+veWu0flXefNaUXBXLWf1vnfTSrj+p5V8ookcUl6hUQ=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=poiBPY+CwAu8PtxUBBAwyEXivoShCkwysbdvKVNSo91n9cQQfacIaJTN7V23EYSa
	 f3fqURP29mEPID9SM7y9vJDkx1jyYzO/EojjMNPngW6NXqEiJlgAxjgpuQHHO5nFv
	 KuOcO/0Dpca3oBQAf+xcV4lphmmvCbayhfCCC1kkpxMjqK+/izaFF6QyRVgP5qGGh
	 e3fM3uKcF6PVSZAgufiiEdTReozRSn3BGWawIn/cRMpuu4K/DuPd7n/t2hWNlmzq3
	 EVYyG3PDULAT9MKXPF0JUoVS6esba+k3LLnUsz11p3Grn2mdQq9NXFKbMwhNqBSBU
	 7b6UsCJChD2+xV8oZw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.214.53]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MxUnz-1ul70o05Jh-00vvOB; Thu, 05
 Jun 2025 12:48:15 +0200
Date: Thu, 5 Jun 2025 12:48:12 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
cc: Josh Soref <gitgitgadget@gmail.com>, git@vger.kernel.org, 
    Jeff King <peff@peff.net>
Subject: Re: [PATCH] curl: pass `long` values where expected
In-Reply-To: <b6e10e5d-45e4-45dd-83f9-d889eacd3034@app.fastmail.com>
Message-ID: <e7475f63-35a4-16b2-71c3-45c9ff58fbd5@gmx.de>
References: <pull.1931.git.1749112304079.gitgitgadget@gmail.com> <b6e10e5d-45e4-45dd-83f9-d889eacd3034@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1336320826-1749120494=:25140"
X-Provags-ID: V03:K1:Hh/pS4AyztAJaW82BedhSqcXTX0JTTPxPw1qzWKcP8ukOaIdxcY
 4jEYH+rqKiJtmQZ//Nyw6aCSyNG4Q8brD8CKSKc4cNgacfBbrR/iv+paiDoKMdyzy4VTP/J
 dbaBJXRLn/zk9RkadMvcVrpfGWSfbn64nMxe/4qOYfXGWseVz3R863YzO+a8zkPTXiJFa1Y
 qYol5kTrVLm3YsZPKk//w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DBLXAaL8qm0=;rg8TNti/8+aXx07cvfUf0ONPzbh
 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
 FFCxoip+nCUfkWEjx43ExdW535/DJ9zFzka1xw==

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1336320826-1749120494=:25140
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Kristoffer,

On Thu, 5 Jun 2025, Kristoffer Haugsbakk wrote:

> On Thu, Jun 5, 2025, at 10:31, Johannes Schindelin via GitGitGadget wrot=
e:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > As of Homebrew's update to cURL v8.14.0, there are new compile errors =
to
> > be observed in the `osx-gcc` job of Git's CI builds:
>=20
> This overlaps with King=E2=80=99s https://lore.kernel.org/git/2025060420=
5505.GA1510724@coredump.intra.peff.net/

Thank you for the heads-up! When I had to start fixing those builds, I had
a quick look but did not find any report on the Git mailing list. But I
see gaps, and I will comment on Jeff's patch.

Thanks!
Johannes

--8323328-1336320826-1749120494=:25140--
