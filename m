Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.61.206.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795027145;
	b=5XhDFV94oAthMSzK82n+yoj+lpou3X/reXNSANUXGoE5CuqExQj3kZqmsvVXaIU6c4dr
	 NxvrLu8qBah2bNLtuzsI0OoHBSAGXbv9A9ljC0CXhUVlrvCyPqlhDgrKoYaKeIBBsjTR7
	 AT+h5hbk+Ku+YLUNAUTRGyIBecHOk8qREPe7Xj7MxTm46P1FmVCoS5dXSN/ksn7G4XilG
	 KqRbNDFruW82zRo/OZ6B0Y5cHI4vDTqwPb2HI4vmH9EE9D+Lg4W2DE6D56x5drj9IM+OK
	 xI1n+xvEv8U5tmnaHdIbV/HfPmiX3zGwBYmquQit72CwUfmgdt16dTCEYeK5vph8l2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795027145;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type;
	bh=SuqUY0jCfVMy1vRKb1HRIjeZUigNMlKVFlp1P8+gGIc=;
	b=eQB4kF4OXMMZce7+I6LrZTtNUCGDAqJS33BeHXfAuGgyYGpl3kl262iPxVDT0XtoD/Nq
	 4MR/77C/FkeRfyLqEAX0zfDpzW6wmAmdtK2yN8iqrZNiqCqA4xBW0KmreTrcn+Lty2b9d
	 289lXJwK8tvTSHjv7ANhiVtpkNZpmiRTflFHH7McChL00pKmCK+tznzmMGgjtdOgfu8FR
	 T0bpS5GqqFjSG1Vdzb72ZebC2Vw/Zn1ed29h5ycM8iguBgxnDD+u9D4DMmZo5QIyDxIeI
	 5ofLR0WO3xxj7x6+XwYSwaqSQbBlOTd1/2E8XQjujnG7wuh8HEN5It3RxzWMPO0BrAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gouders.net;
	spf=pass smtp.mailfrom=gouders.net;
	dkim=pass header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=k2MHaTqJ;
	arc=none smtp.remote-ip=202.61.206.94
Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424A4606A325
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 18:39:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 424A4606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=k2MHaTqJ
Received: from localhost (ip-109-41-49-52.web.vodafone.de [109.41.49.52])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.2/8.17.1.9) with ESMTPSA id 6AIIcsZR1920942
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 18 Nov 2026 19:38:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gouders.net; s=gnet;
	t=1795027134; bh=SuqUY0jCfVMy1vRKb1HRIjeZUigNMlKVFlp1P8+gGIc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=k2MHaTqJZIXNN5AX8sTjsYgFjJmN5RsOS0OxdM91xmuwmxeSQT/FiPirXCr3gD7Ia
	 mJb0s6AGGE1yuZng40tsFsVNUZrpvF+RwdyqqGTF6DRv5Yx5/k2+xxde0u28dWBUHT
	 7KNjg6NCyi4sNsuJJBrCnO7IvbuPLAk/7aoOtjsQ=
From: Dirk Gouders <dirk@gouders.net>
To: Andy Koppe <andy.koppe@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] utf8: add display_mode_esc_sequence_len_counted()
In-Reply-To: <CAHWeT-Yh8yTnG7rLjvO+XBtU=bZHJ3WWoQQsPfvJO013P2GSPA@mail.gmail.com>
References: <xmqqmrr7fllq.fsf@gitster.g> <xmqqqzgjcjes.fsf@gitster.g>
	<CAHWeT-Zt=1MjD=fbOiAiQtb28Q4DAR_wF12iymXmeXzGyyLgbQ@mail.gmail.com>
	<xmqq33szavmy.fsf@gitster.g>
	<CAHWeT-ZcOqm9PXzM5W18+ktJ4gBdPNyx+g_2ZCaW25ufKH4g5A@mail.gmail.com>
	<ghwlqak2j9.fsf@gouders.net>
	<CAHWeT-Yh8yTnG7rLjvO+XBtU=bZHJ3WWoQQsPfvJO013P2GSPA@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Wed, 18 Nov 2026 19:38:53 +0100
Message-ID: <ghik1uassi.fsf@gouders.net>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Nov 18 2026, Andy Koppe wrote:

>> Dirk Gouders <wrote:

>> And as far as I know, we would need an FSM to identify valid sequences
>> if we are going to allow colons.

> No. The parameter field can be any mix of digits, colons and
> semicolons.  Semicolons separate parameters, colons separate
> subparameters, and individual (sub)parameters can be empty, which is
> equivalent to zero. If the field consists of nothing but colons,
> that's one parameter with multiple empty subparameters.

My statement was a bit misleading, because
display_mode_esc_sequence_len() already is an FSM
accepting the language "\033\[[0-9;]+m".  My concern was that I doubt
that simply adding ":" to the alphabet and as valid input to the state
"parameter"  (without introducing one or more new states) would still
let it accept only valid SGR sequences.

It seems I can learn something: is "\033[:;m" a valid SGR sequence?

But, such a discussion is difficult without defining what language you
want to accept.  I guess the two links were meant as a definition and I
have to confess I didn't yet read them.

Regards,

Dirk
