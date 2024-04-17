Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0763513C838
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 11:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713353504; cv=none; b=dAmIjUk2cpZ+MdrmDFleXPhkOnNVTKkQdsMaaKJ7jfipqa4ZCGsTYEYsybMepoLv+y1P/gk/JSOoSAjnIuSH3wOAU64zsNX+SmBOImou+Gg3KeWB+AqvVlpN92dQUjvd3+UTLM5CFRzmKE8gl0dkhHEFLxSV6V7VRMtfr6AlCFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713353504; c=relaxed/simple;
	bh=5V4xYChaEkLcCJCPxbS2lg3a5lURbq1RXJv6LebfWuU=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=K/F31YRD3wP62hWZP4h0ur6esgXi7JrHs1tgoeOIH0aJRyKolC5aiJHTk0CZnubcXOOBsq6ROFXi0ggUmcWz2jrW+6f1j3a1s8X66Kapi7txCbLYkv529TK8qXvth5yQCn6YNWk2f9aPX0LuzGMrPClpkvoda4tbyf7I0l5DmCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=Na3AyvQx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Cm6VzQ8o; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="Na3AyvQx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cm6VzQ8o"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 0E410138010B;
	Wed, 17 Apr 2024 07:31:41 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Wed, 17 Apr 2024 07:31:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1713353501; x=1713439901; bh=WQjFnW+btVJAn7T6Oq3dxp5nDnvZ5MuT
	cBOftHu1Evo=; b=Na3AyvQxe7Bqb5T03UAeQpaeVyi6G/tNRTb3Lw4+cLPL2azz
	lrWEcOMhCsBAfbOh9HUGgPTp1a1IVITjPyweDwcs4ebsQ21ZHwim5GOzafqXgDMN
	HCNYhDPVg8WKMRHetmWUBHGvnTUU0dar5Q7B6iPe/CPcaiTuLfBrKPOEH4zQpaOX
	NT9k9vMxaJI0//zW2YSfbPIncT6JGG1ABouzjXeqQv8JEkxdyQ3WQXUFyJRuphaO
	2NH3W9S6qBsepIAd5IqfoE7tH9QdDGPqLXV8hWwuC1MNWnKyAAMJ9gveh23A2qrC
	DeFDvlFkweb3CF9Uwhos5tepu0vogcI8PzKBVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1713353501; x=
	1713439901; bh=WQjFnW+btVJAn7T6Oq3dxp5nDnvZ5MuTcBOftHu1Evo=; b=C
	m6VzQ8osI7B43O4hEYJRigP6K/M3sGFWANq6P/yA16JQGM8eewj73Vl0jVV6JlCH
	WMLxoYIS3IPnDgOJ0EbNb/KCX2sglV0tu1z516zJzBB6KmHH9Yk+V8A4B27XHAqd
	L0BgRz8iLhqtWlWmPxKm/Pp15AYBaaZM80LhajgVyihWeGYDwNSERxN9zKKqN6l1
	wcGeDJgu65vWLOVlV3q69t6DENVQA5pu388bQdY23BPm3D6kx3aAfYAZoE1uYJSO
	1+hkvAQQEBiuKje7aZN8JKnjlhksJLcOf42CAf/tIpJ3RooxmCzs3UV18mPRYSGZ
	e1OOCQVGLsqx/B29z5NlA==
X-ME-Sender: <xms:HLMfZigDXr2tMksUODAhC1HENNTACEvjwJNI3wclqBhjnTuXvZuAIys>
    <xme:HLMfZjBks_iRpQ8-n1SGSIZoVP9-Vu60nzjkzwkyaPgNyQQNX_LRq55lzbkEBUA6D
    CJmUmZJ0TjbRoxYHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejkedggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedtkeduvedthfelueevheffhedvveei
    ueeiheehudehveegueetteduuddtfeelueenucffohhmrghinhepkhgvrhhnvghlrdhorh
    hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptgho
    uggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:HLMfZqEgBQQG7RjN03PJ3j90jnUmKH7b1uoirU7WiNiJLU0N9QmL2A>
    <xmx:HLMfZrT2zkhUeLKmes92T2cBtZ0zlAB9YcEBqefgJ0cmJIooCJeqyw>
    <xmx:HLMfZvyG-LNHzet5JZGRR_6yE96XCOP6QRhGxnyaeZA9jpZPrkCTWg>
    <xmx:HLMfZp59TmN-YOEA6fkXGUwrzPl2SetYZru-s9kWGarFmxdocnjNQw>
    <xmx:HbMfZv-4obyQrM_-0TOuVGL143dknAVi3lFxXm5pMcaKQnXS2HuIWxt5>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 4D46315A0092; Wed, 17 Apr 2024 07:31:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-379-gabd37849b7-fm-20240408.001-gabd37849
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d60e5ddd-643d-41f2-849d-6ab660df734c@app.fastmail.com>
In-Reply-To: <1f31004bd8445e1e4717817638d5509a@manjaro.org>
References: <cover.1713324598.git.dsimic@manjaro.org>
 <1d9c6ce3df714211889453c245485d46b43edff6.1713324598.git.dsimic@manjaro.org>
 <154b085c-3e92-4eb6-b6a6-97aa02f8f07d@gmail.com>
 <1f31004bd8445e1e4717817638d5509a@manjaro.org>
Date: Wed, 17 Apr 2024 13:31:19 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Dragan Simic" <dsimic@manjaro.org>
Cc: git@vger.kernel.org, "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 "Eric Sunshine" <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/4] format-patch: new --resend option for adding "RESEND" to patch
 subjects
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024, at 12:52, Dragan Simic wrote:
> Hello Phillip,
>
> On 2024-04-17 12:02, Phillip Wood wrote:
>> On 17/04/2024 04:32, Dragan Simic wrote:
>>> Add --resend as the new command-line option for "git format-patch"
>>> that adds
>>> "RESEND" as a (sub)suffix to the patch subject prefix, eventually
>>> producing
>>> "[PATCH RESEND]" as the default patch subject prefix.
>>>
>>> "[PATCH RESEND]" is a patch subject prefix commonly used on mailing
>>> lists
>>> for patches resent to a mailing list after they had attracted no
>>> attention
>>> for some time, usually for a couple of weeks.  As such, this subject
>>> prefix
>>> deserves adding --resend as a new shorthand option to "git
>>> format-patch".
>>
>> Playing devil's advocate for a minute, is this really common enough to
>> justify a new option when the user can use "--subject-prefix=3D'PATCH
>> RESEND'" instead?
>
> Based on my experience, "[PATCH RESEND]" is roughly as commonly
> used as "[PATCH RFC]".  In other words, it obviously isn't used
> as much as the good, old plain "[PATCH]", but it is used.

The format-patch generated string is `RFC PATCH`.

The number of emails with `PATCH RESEND` for this list:[1]

```
$ git log --oneline --fixed-strings --grep=3D'[PATCH RESEND' | wc -l
28
```

For RFC:

```
$ git log --oneline --fixed-strings --grep=3D'[RFC PATCH' | wc -l
1181
```

=E2=80=A0 1: According to http://lore.kernel.org/git/1

--=20
Kristoffer Haugsbakk

