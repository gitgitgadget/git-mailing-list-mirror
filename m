Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734A8C8EB
	for <git@vger.kernel.org>; Sun, 22 Mar 2026 16:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774197051; cv=none; b=h9ri9m0pDRvLdV8Bz1fGlLO8WBVFq79Hnjw3hW3P/rMja+kXj7efXb1rK2iDIDm25x10dCA6qDCEe7vNtFlH8wniW37KMHGRNEIP/iy8IYmOD8lvBiQ37CNPT23Y8oVQpar0yh1Mxn3HAq8Zxgrk2yfeYYS/c1C+wNfAH8BUfD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774197051; c=relaxed/simple;
	bh=vOzNWgyPipmqs/E5d5S8w0Zh3a4RPqopSo09imeg6wA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sSdTTqXyZ/mbzJR1k6d2sNc7+FzIgu6ysFqbuyKtHM1HWbsE+EiTAZ6MEfuU9atGatt9p3FYYTt8BFoHaRVluNo8XTFUYMLToSmMpDQm6kNK5VjJ0kdX6z1lTBIwSIJ/NX0/J5BH3x8pwkO+j4QCsgvJ+fko3t9hXdiyEIU1CQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=WcCE3iG4; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="WcCE3iG4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1774197044; x=1774801844; i=l.s.r@web.de;
	bh=8ZMHL0uBFZ7o4rvIhlAfJ2Cs/CFeBuPXNG7qJQt2J2s=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=WcCE3iG4y+AsRHQqe/Xyr3s/uWkc1PXmRDe5lYUtEX9roa2MbjK+vNCvovKpkPf2
	 Xm0TsAlg9HzsJCjvXHFU9LFp+geaDD1VRCBJL8vC78PWKaRGQBifwGLSbcCz7FLzz
	 dizzOxDXea7rCZruLaoaIVgmfLh0va9VjTmd4R1gtnKcKjYlDqMDdW6ba238eSgX+
	 ecGQlKf+xRGiVCpTsMiaGuW1/iH77djmRDbZa8eRoUxh2RWIie0MsYvzF/mHQLVyw
	 7jkpQFsZr9VhuiuyouwTbZgnY2IjmKoqgWiMLt41dxYda7fnoZiKOvCfyHu2KP5np
	 xT9o6fBTOHKu/C4Sjg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MAtsZ-1wFeEH2edd-00FzYp; Sun, 22
 Mar 2026 17:30:44 +0100
Message-ID: <6c108696-2d41-4fa1-9662-fbf6db97f767@web.de>
Date: Sun, 22 Mar 2026 17:30:44 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: What's cooking in git.git (Mar 2026, #08)
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
 Johannes Schindelin <johannes.schindelin@gmx.de>
References: <xmqq1phc9x98.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqq1phc9x98.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6cgDh79+D+XnE0RR5Zdu5A5ZM6/nXEsS0a1nGMXBpAPMbTxqxqJ
 ZOCFtSayoMWuk6GYBnuT1g9DqvAYS1oHftyvVV4fBkA8tuJks3NoQijs6BRkVdgdeeHDMWS
 EYCQMtlMqdkCgTxUtJ6UV3rH2T1y42RkArw5cEg4MjhlYyrcGPhkYlAVSGvXw7/FQBkwOiE
 Dy4AbEVF7gLjGxvIhT3fg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AZLUMGAmHLU=;0MIUc9OWO/Qnniz49TaHTYfbLpU
 +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

On 3/22/26 7:46 AM, Junio C Hamano wrote:
> * js/macos-homebrew-forgets-reg-enhanced (2026-03-20) 1 commit
>  - osx-clang: work around Homebrew's clang lacking REG_ENHANCED
>=20
>  The build on macOS with Clang is fixed to work around a Homebrew change
>  that exposed an issue with missing REG_ENHANCED.
>=20
>  Will merge to 'next'?
>  source: <d340af9e-334c-4e81-e58a-fc3dea73ebdd@gmx.de>
This seems to no longer be necessary -- the latest workflow run on
master succeeded (https://github.com/git/git/actions/runs/23392330338).
Did some kind soul fix the runners?

Ren=C3=A9

