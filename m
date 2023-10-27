Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C2DBE48
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 07:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quantbo.com header.i=@quantbo.com header.b="tGa9Hb2a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uC+NxOud"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC15E1B1
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 00:31:56 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id B5A5B5C00F9
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 03:31:53 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute1.internal (MEProxy); Fri, 27 Oct 2023 03:31:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantbo.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698391913; x=1698478313; bh=Lb
	JH/AbSeFTrVbl6TsFQ6zVpPw5IMd9jRAmKUKkcyZA=; b=tGa9Hb2aHmVyl7obuh
	h2MNf2mutU4BnFYoz1IjIKKcKh98u52396TR/vtqFyW/iGqsRnRyIt7kiKRkL4K9
	iUh6b0tuncitHLEUVr/esYUUNlbqKlo48xVusCsw8Ftou7yazZ8UzyWJihOYffiv
	lrbV6BiJuw8kN31ZDjO6f2TvUx2bKUGwakc1vPxkkt8FTfzOoHmmbm56+MjApwhz
	wTlVBwfzUqVf4G9+NrJFHgpyev3YaYNSQP+2anfcJyNKbfC5xHC+3zn9ebVE29dU
	7u4Ll7rFeomYH//phPcEplm9+k3cSwh3d7JrHQj/NQU7I2zEnmPvUwTB0LLE9Nx0
	gatg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698391913; x=1698478313; bh=LbJH/AbSeFTrV
	bl6TsFQ6zVpPw5IMd9jRAmKUKkcyZA=; b=uC+NxOudRsIXLLFsccBP56x7wjBuu
	Adsxa34zfcKSuQH86fITygXbZBKKdRsWUkWYRarpcZaYmI7kEwId6/hrDPwlRCgP
	7Ne39YfpVk4I8qAvH4VSNmCaXyxNqRbLe1vB6V3thCM9W6ukiMnF7KvEmeQLRHyO
	QGTpLuRVUuZNe8rn3PPZxPpIRMPtvUv2f78dBopysAJE9wPAiCnfo9vrWE/hn3nm
	8KVfJ3erVtMcTefMudF3lnm3agYiVi9RcrcDH9+889bwjqCBAXKWcuBNhOt2/1O0
	o0y782iMQA47LaG/KlKOyPffOBuJI2oHNOe8sKUig49jkujHaapmNihxQ==
X-ME-Sender: <xms:aWc7Zcu59L4wheeYnQnpV9fZ0CSjtXKXuI4wbIwGpIPy4K1HXCelAw>
    <xme:aWc7ZZeZOca5db2e9Fu_MMw1ONr2HtDJncVgB9zMvW5D6q00OwdNfgf1OzYy6sFNs
    O2GS2yLwbHP7g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleefgdduvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfffhffvufgtgfesthhqre
    dtreerjeenucfhrhhomheplfhohhhnuceojhhohhhnsehquhgrnhhtsghordgtohhmqeen
    ucggtffrrghtthgvrhhnpeduffeuueeitefhuefhleeileetieduffeltdektdetieeuff
    ethedvvdevudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehjohhhnhesqhhurghnthgsohdrtghomh
X-ME-Proxy: <xmx:aWc7ZXxnGKdR3DHchhXf-uDG8h-zaDhBESWkKun2agRvsXzkvqyfTQ>
    <xmx:aWc7ZfPjkEXLSvRsHfxokxzT4gROeijlsMecIGCd1pTZuw8xHXnZhg>
    <xmx:aWc7Zc8kxeU2zE2UpBNp1-STacCyFZ6bu5CFWMocF66-C_ZnbbjWpg>
    <xmx:aWc7ZfJymBg3BEgA3TXzOipG4ACjy12Ve4g4evzbB_rKPp2UgtUYAA>
Feedback-ID: icf09468c:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 69A9DC6008B; Fri, 27 Oct 2023 03:31:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1048-g9229b632c5-fm-20231019.001-g9229b632
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <cd248c66-fc71-4783-9195-02c8811744b8@app.fastmail.com>
Date: Fri, 27 Oct 2023 14:31:32 +0700
From: John <john@quantbo.com>
To: git@vger.kernel.org
Subject: GFW fails with ST3 on Windows 11
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

I have been using Sublime Text 3 as the editor on Git for Windows for ye=
ars, on Windows 10. I recently purchased a Windows 11 machine. On that m=
achine, when I give GFW the following command, I get the response shown:

$ git commit -a
[=E2=80=A6]
hint: Waiting for your editor to close the file=E2=80=A6 C:\Program File=
s\Sublime Text 3\sublime_text.exe: C:Program: command not found
error: There was a problem with the editor =E2=80=98C:\Program Files\Sub=
lime Text 3\sublime_text.exe=E2=80=99.
Please supply the message using either -m or -F option.

Does anyone know of a fix? To repeat, it=E2=80=99s only a problem on Win=
dows 11.
