Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EC9523E
	for <git@vger.kernel.org>; Tue, 26 Dec 2023 22:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Dw9X8PgX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vognnN4b"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id E6AAB3200C20
	for <git@vger.kernel.org>; Tue, 26 Dec 2023 17:26:30 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 26 Dec 2023 17:26:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1703629590; x=1703715990; bh=zufuhB7Esp
	ZzctSbXgdPSAOv+gkY1ZX6Tl4alBTxXXU=; b=Dw9X8PgXIw0UcJ1ePVxuXcJUGt
	hVTW1C9XQ7zMwPwcBmBzEmFFJqGaAFwoCrGh6+n8V3V24VvFXv9CanmC0i5TpmBj
	NhuZ9Xv6TP13py0MDsjNQ/lnuLtYXSULepplvpxzLGqTJCBoMiwOMgyDFwaSM7Fr
	9VsTNPqCd/q5VtI3XOhIPgfaZUJCIDdIevhnWTRQi2GGMT1QDrZnAJjV2NLXLlEy
	Av0Uzjw/UEGBC+c+znbvMvh6wr49SXhP7p30+yEepFouOAJ2+XbM3FQq4BqDbn/5
	m7dLq0kBZJjvXXao4rwR3qpM8CChB+3W8hQIOrL5gwJHlSVo56PBXI3xYRiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703629590; x=1703715990; bh=zufuhB7EspZzctSbXgdPSAOv+gkY
	1ZX6Tl4alBTxXXU=; b=vognnN4bqMzdL22kKi2EOML/L7/MkLfzOTwFzxBCeNJl
	ier3vrqe9REuF+7bbeqvkep3OPl4RePONZO1+FvFKJM4WphbehP6Zuc4yIO5OymM
	mnSxOhG8trpBCVWAtYkySquTPoxNvkEQiDRDtsRuEocS9c+pKc4RASiw0mvElhOk
	M1bZ98o9jQb0bsBkVmqX6SIgZPJqquPh0SdIL7+Rtd4Oi7f6n+vMCc8iu0dOzfxM
	+0CcB8b0oM+GjVpVSBoDEX/rDFQzN/XSyCsbSvj+NRC+zy/QzgPBH6KeDvmDrkHh
	8Va3vPfrPwwwcT0GwIokkL1Sp9LeLvt7YBop6fRumQ==
X-ME-Sender: <xms:FlOLZTJrzxesVmXXGaADlqSG8nuO9bmX3GQqtmsh3MxWZxCoxARiJg>
    <xme:FlOLZXKsrfNAR73wriKV1BBoELGPrPUNjG3YzgHuUI3boEnwTFeaNbaZ2ZlhYa0LN
    goJjC4BLBOlqWvI3g>
X-ME-Received: <xmr:FlOLZbswWZZedYgi0N2juiyQNQhUWZ-g-hGpggJV1ih3A05PzRnIlP-6ObBNqt1C0xKJWYIhllTGXIvFPdeNuqw-1JBRHaE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddvjedgudeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepkfffgggfvffhufgtgfesthejre
    dttdefjeenucfhrhhomhepofgrrhgtucevrghsrghnohhvrgcuoehmhhgtrghsrghnohhv
    rgelleelsehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepgeeiiedthe
    ffuedtveeiffffjeeikeduudeiffejueeifeekveethfetvdeugedunecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhhhtggrshgrnhhovhgrle
    elleesfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:FlOLZcYtCYH9jd3LscOUgp46HYogvo67PQXBloxgej1o3fdt5nHPhQ>
    <xmx:FlOLZaYl1FL-wAUk4qpoXk2dXvXnAfucZovTcO_mn1K0p0AInlmUuQ>
    <xmx:FlOLZQDIFQg3fue4Nz2JYGnnaLkZhepubY-222GMHbT4iu7h_FQuMQ>
    <xmx:FlOLZY07vHEpyzaEE92tZJTa1YOsq3KBGYQu0nrmpPNQQewarssEaQ>
Feedback-ID: i86f043b9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 26 Dec 2023 17:26:29 -0500 (EST)
Message-ID: <c50811ed-a1e0-aee7-ee56-bafc2d52d86e@fastmail.com>
Date: Tue, 26 Dec 2023 15:26:29 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
To: git@vger.kernel.org
Content-Language: en-US
From: Marc Casanova <mhcasanova999@fastmail.com>
Subject: Accessing Git
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I have a Git server installed on an Ubuntu container in a Proxmox 
hypervisor. That part was easy.

I want to access that server from my Windows computers on the same local 
network. How do I accomplish that?

