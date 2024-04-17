Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B90D13C681
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 11:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713353911; cv=none; b=HEhUce6Pl8iypHwL6SGcW3EZxX3phZhUG6WbtNbQ79IsddWz+5XIdrEaDui3i8n3fJ40JfpNsWYa4rxyTt6EDPwe1wygvYcazxDSigDx52B4naY2H/GT+bfVS8S9SPf65wdiEwQWcAecSikmzN0XUGI+PyvPsyWauJyuFDq64WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713353911; c=relaxed/simple;
	bh=iqzS9nKfAf0r1wthtDbiitgTNMWK3Wts36lQlq50tQU=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=gjPiQFK0w2kx8h/GlJK0Z5GpXmKz/VklUrcBbhU7fLD7JAZ3hvRqoQjXgya2BzaM48cfag63IRcBZBp8HL49Wq/gK0W8ST4hKpCGFlrXdlsgrYYIkmMSw7g1CdUKT2dmM/kbQoCI+bleWgSsYNedAATEGHxfoxTZkss82ouj7CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=V5Xu1v7L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MI1zFyuK; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="V5Xu1v7L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MI1zFyuK"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 2637D138023E;
	Wed, 17 Apr 2024 07:38:29 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Wed, 17 Apr 2024 07:38:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1713353909; x=1713440309; bh=iqzS9nKfAf0r1wthtDbiitgTNMWK3Wts
	36lQlq50tQU=; b=V5Xu1v7LiNpCzQi5LUQ68cIvbsQADW23f1H1WMhjujM5ZkS7
	3IBxxknLStNQWrHbP4tTLiJyp7OIYghAmBB0wl5CuPmiUxrP7tmeWpWIaqRYGkjS
	U0orLUctivayVnznvdRsLrzPD8rMrd9ncz/avjIF0PoQiU2n6Vz4+eLHKlwiky3B
	6RgUhPGPiRm3Hs6PTwrstxSENf+qf7pfNBW0oXE0IWvNprzvlmgOJ3kIYi1lgK4t
	gE9IdEl5xiaGMMrrXQNEVXY2yCD0P/oyQD/Rp2WQaS/R9g5VJKWK+s8dvVSr9RYu
	wwwYEZUJEcGmXJM/ZfkwojUGV7MpeMm7IAYVNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1713353909; x=
	1713440309; bh=iqzS9nKfAf0r1wthtDbiitgTNMWK3Wts36lQlq50tQU=; b=M
	I1zFyuK5QR6FSIZpehd98ntUN0CL5ct1c+0ruMlMJVJ+SDIUUUyCFqr2t3E+tGVX
	vrQxiJz1yvQq4HRaUcPLis4seIk6EKrgp680DC7484f4x5qoUKaHsRYGehUSlx7f
	xz4awzSsh3nYm84J3q6Vm4K2FK1H/ByqOCK4lw/cIIAGDKQMDYdFgPn4zzwEAgc2
	HlLI3A1Crl4FrUl/QrmzU7CKZqfLnE9mRPvHjxBZ3lfCY5nbxcxveMRKCWRpsekb
	0xIVUCmkfYkd16hojD+FX+zX950HsNNz5lq+tEyVuQaNR92JVGIpoSalqFjvV4So
	6YtvYLPwZl0F9/rkolf5w==
X-ME-Sender: <xms:tLQfZh1m2M7QV4aVAaGgmBa-7Z9kLUHjqzGACXb3HXrlyHvac0lyiZo>
    <xme:tLQfZoGkkw6HEqMzJJwAyCpA8H8JaRwv0sWUTukG_Sul61vof_7987JYpwMgbJdVQ
    CjpbU8BuTmgRyFKbw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejkedggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedvveehiedufeehffdvteeuveekhefh
    leeigfektdeifeduteeuheeufeetffefudenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:tLQfZh5J9VYsaG3_XV9tuKjtbFDV6lUJpM08WNxH7X67iMNO2MzOtw>
    <xmx:tLQfZu2BrBa4Acfk9SJ_Xnv1AAwSGVUg73uEax3XBHQ2KZdPRcMy2g>
    <xmx:tLQfZkEE7ix5RGH4GLJQuBFl7pNX2-nJLXwGMvFs9hqQ7WQCtgHYuA>
    <xmx:tLQfZv_R_MMx3dLduP7Vqim3UPtqKJMXmIxtlCFOcEVntiwjyy45dw>
    <xmx:tbQfZpT4glibXZS7Y7QlE5D6Rot2sXhC_5BDBtvKTmlQx_TcxDpDzS4F>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id C4C6315A0092; Wed, 17 Apr 2024 07:38:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-379-gabd37849b7-fm-20240408.001-gabd37849
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <675e2dec-a80e-4b5d-84ab-75ec5604a1be@app.fastmail.com>
In-Reply-To: <9a6a9cb1d9dd07bbbbc47616c510779a@manjaro.org>
References: <cover.1713324598.git.dsimic@manjaro.org>
 <c975f961779b4a7b10c0743b4b8b3ad8c89cb617.1713324598.git.dsimic@manjaro.org>
 <e4aa5235-c6ad-45c7-930e-de991cc375f2@app.fastmail.com>
 <CAPig+cSGZr4zE=Dp7Z58CN0kmkpXdc8SOopXmB9=ry4gwNkq=w@mail.gmail.com>
 <9a6a9cb1d9dd07bbbbc47616c510779a@manjaro.org>
Date: Wed, 17 Apr 2024 13:38:08 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Dragan Simic" <dsimic@manjaro.org>
Cc: git@vger.kernel.org, "Eric Sunshine" <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/4] format-patch: fix a bug in option exclusivity and add a test
 to t4014
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024, at 09:11, Dragan Simic wrote:
>> I had the same question but left it unwritten since I noticed that
>> this new test is modelled after the test immediately following it in
>> the script, and the existing test also redirects to "patch"
>> unnecessarily. So, if it's done this way for consistency with existing
>> tests, I don't mind letting it slide.
>
> Yes, I also wasn't super happy with this new test, as I already noted
> in one of my replies, but improving this and the other similar tests
> is most probably something best left for a follow-up series.

I don=E2=80=99t see the point in writing the test in mimic-neighbors way=
 only to
improve it shortly after.

If the test can be written in a better way then the other tests can be
improved later. Or now. I think I=E2=80=99ve seen other discussions were=
 a less
good pattern wasn=E2=80=99t accepted in new tests even though they were =
used in
existing ones. The reviewer then pointed out that the other tests should
be updated later.

That=E2=80=99s just my opinion and recollection.

--=20
Kristoffer Haugsbakk

