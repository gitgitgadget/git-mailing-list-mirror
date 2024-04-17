Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44846394
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 06:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713336203; cv=none; b=R62cTDVhiT2y7JoAvWd1Nqb1syb56cDZH+vuhVvzPmReXIl0wI5c8KIGSAaJIgSporxOWG26ei8Z9bWaOOD8tOpSZ1ePGp/+0Il7JgAvKhn6tfXElB8f31CJcEY3gjlr+YRIQBUDj8UyGy3rVYMd/jNCwvMkBR6Ae+2Auq5Cvh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713336203; c=relaxed/simple;
	bh=QWYpS4dy+7w26dEKI5EK/ye/TPCpra58yGY+ZTGucbo=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=HEI/VZUPgHq9Ir0eSOWOEUYUMFM9GMU4Ss33WPI9o7GVNBc3EQgSakmHLpbvu8J9V4boUXw8Loq+XB+XQiZ+rEB8LWzVkbTXPr3Pl163AkRKjNL/bcF2UHNkrtrV9LcfpG3foQCOVDhgVBTRIYbzqAkLOgUBts6VpozmTFq7nzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=tVnudNt9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F8r0orWj; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="tVnudNt9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F8r0orWj"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 57B3A13800EA;
	Wed, 17 Apr 2024 02:43:21 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Wed, 17 Apr 2024 02:43:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1713336201; x=1713422601; bh=HHji1hpXwvkRDc3xb6ehOl9874droTqX
	8frnzx/2R6I=; b=tVnudNt9Q1RNZ+UEHnloxdNefNfIjgZETAGeOnxsd6ClR9Le
	RUX97zDO4RF3wghes8W26dGb4My80Onsm7bT9NtQzPkcttDfi9qXc5bOoVJUAHnT
	gvpTjv2MwLod6ClaMjJf1Kf/LyBmLI2GQ1k3lCh7pMDuIzSJn+5EHbOmhHiz40OJ
	SkHLRRxPXhh4YUv6U4W+vW+JalDKAv9nzCiCKoFVqYW2IFbrK7wi4WJr/2HpIGA2
	lTUxozt8lYbN0iOd3EPU5HLrxjwOWTlIv0UuzDzxyr6W1aguLgj+uWmNdoFOMoVD
	XbudFi1zzuYeopBY/4t/xu922jtQ77Nsh8ypXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1713336201; x=
	1713422601; bh=HHji1hpXwvkRDc3xb6ehOl9874droTqX8frnzx/2R6I=; b=F
	8r0orWjIG/wGpfbUFL1xpzLZGra+GyDDrtkb2Q1090K6gF3+/DKOgfJBur1qd7t2
	2FXfZsOSLMya8miUiXGpTE38ZFh8aUPvpCL4PyBq/UzUQgbD24I2+jzptzRsYoAe
	hF+BKbq6q36SGd/AVmBd6LQroyDhtNWZ9hweB3JMqqTiSjZjj5JqIzKGrJB3rCCP
	EmsXcB1tRlheyY4OBBIMJ36GLibusM1xVqA1tnGz9TtL3HFuaZa5/uU4EbsMVfeg
	O+zrrHgexrASA8IRx3+WygVnUDlVD7OCrkZDmv6iZFzlhQE2T1cdVvo9uD2XB5Yi
	jVkPdpdaAUW/kMZBLnmbg==
X-ME-Sender: <xms:iW8fZpYgM8_Dn6P5nzyEm6CZxkpAwFjTPXuzxLwJ2OLIx6b7cwdlo5c>
    <xme:iW8fZgbASY5PFzoOSkRQ4lF73lA9EKwNh2yE-LK67nsWZS_j3NOCmjvE2YuUwCt-_
    r-Lrl8qSywtOw_dag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejjedgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedvveehiedufeehffdvteeuveekhefh
    leeigfektdeifeduteeuheeufeetffefudenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:iW8fZr9-1AhoBsNdZ2TzB27PplukF0PKJEF9wUHRs3yqMKX11R4E9w>
    <xmx:iW8fZnr9UGsBFOImcSGzvpYYtOvqsqzzceQIOCEuUsrdAz9M6-OasA>
    <xmx:iW8fZkpN8yni4wMcH-plZbdyPQcu0hTRKC4XY9Ibnd1wixtXefr-4w>
    <xmx:iW8fZtQAJ2EKQqHHWEQICuiQwQAGmfA7Ut95qZEfHnxx9ReNvZP7Sg>
    <xmx:iW8fZhB-2KZK6x-uuWWK7xbXs5lY6u-j75vb-d6uoO_bP0wEiShgp5f5>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 1419715A0092; Wed, 17 Apr 2024 02:43:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-379-gabd37849b7-fm-20240408.001-gabd37849
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f054eb17-2eea-40f5-b201-92432aa0ad9c@app.fastmail.com>
In-Reply-To: <4aa0754ee62d78ca9300eb709df561b3@manjaro.org>
References: <cover.1713324598.git.dsimic@manjaro.org>
 <1d9c6ce3df714211889453c245485d46b43edff6.1713324598.git.dsimic@manjaro.org>
 <556d4baa-14f9-485a-8db3-0c9a966351a7@app.fastmail.com>
 <4aa0754ee62d78ca9300eb709df561b3@manjaro.org>
Date: Wed, 17 Apr 2024 08:43:00 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Dragan Simic" <dsimic@manjaro.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/4] format-patch: new --resend option for adding "RESEND" to patch
 subjects
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024, at 08:36, Dragan Simic wrote:
> It also doesn't use imperative mood.

The sentence describes what the option does (usage). It doesn=E2=80=99t =
explain
what the commit message does. In context:

    Teach format-patch about --resend

    --resend adds "RESEND" to the subject prefix (producing "PATCH
    RESEND" by default).

--=20
Kristoffer Haugsbakk


