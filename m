Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0295F8F7D
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 12:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760617057; cv=none; b=TT0A/ZfLh25xaTJIM5tjymmM8vtNzYw4s6XDMNcwg3YkEDwxBtTj4Nq3f5R8GO2DEFpqPER0EqKGRVXr3VHg5K7okA2j6j9+ppIkiMGQXEVN7C4yPNnZqUAtbx/zooc38XaNzqVZfavEZDulZ63TC/4LdJDWah0sfKnEqLaqXaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760617057; c=relaxed/simple;
	bh=H0I6XcavI1H9Ra5GHmxYUG5WIBUjqjgSyb+H7TZ5ppQ=;
	h=MIME-Version:Date:From:To:Message-Id:Subject:Content-Type; b=ewL1Opn7ecuxR72b1toljqhk4JJCxQ5Ectb1r2NjwQJtbBVHao+m3o9ppIOXUlDtragRl4G/dPiDXYCp6AIeDHi6ui//3DtU55gsuExemCWSUBpO3fDQ+aH3hR+8QT5uGncSoH4QI8nEFq48kFhIhGltZksShoMrefzpnoCaNRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cipht.net; spf=pass smtp.mailfrom=cipht.net; dkim=pass (2048-bit key) header.d=cipht.net header.i=@cipht.net header.b=aZ1BUlgL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eevJS0r0; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cipht.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cipht.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cipht.net header.i=@cipht.net header.b="aZ1BUlgL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eevJS0r0"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 04753EC0265
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 08:17:34 -0400 (EDT)
Received: from phl-imap-18 ([10.202.2.89])
  by phl-compute-05.internal (MEProxy); Thu, 16 Oct 2025 08:17:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cipht.net; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1760617054; x=1760703454; bh=tsz9+oiohM
	y1+icukCuLEcTJzKiMSTqgl3XnVHe6tHM=; b=aZ1BUlgL64CAnY6Ltpc8XVB2tk
	NzsCW6F8OyDIowfJw1K99/jUHCzelgADKviqi9fqYtlp0cmxTLKnPpmI8mGSf7uR
	x6PK50zhxVK9hsGqKNunCTSScIlgnNQskcp5zsp0r7e2IYdWX82KiojnCcvCIJ80
	rRWwccGh2fl4ByFIzsqOin5Yer/mnFxWCfuHzFowmEd+TYQOX4kMYnk15ia71AjM
	BKOmuVi/b1hY/gD8rmH/DwGIgTeuPeypb7H/93gzQd+s9v2aZKxQFPB/J2vJiUd3
	eUmDvvMJyA/liE6kiIenq5MZ9bJvoPkKVFyBfqBEvD7Z+VDAIPQNK9Ru1ocw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760617054; x=1760703454; bh=tsz9+oiohMy1+icukCuLEcTJzKiMSTqgl3X
	nVHe6tHM=; b=eevJS0r0oYdukoGHnzFBSBprOs9Bv5BiLxLTBQz0uWNVdin595h
	G9slIviREdDIOLmFEE1UvoecZPJTAPT3WsahYZst+7B/qBjT/nBHcwLDYC3Sd8oh
	bBQuJ04FMHWuc6RG1h4/NTEXHA9hH6A/Ga+syMACIb2aWF1m0LSF/Cp/Ckgy0c6S
	HXjggVMmpFmd9w9jmjz+aKLR9odzbXycL67pe4mNbS+STmK+nPBOSzIwl51g6TW1
	ueW5E56T0H4NDQpytVHsX/xiSFyA0BUJEPxvD02KyHBqYC2j4k4AwiW2bnNs7LX3
	bGC3XOuZXw0+ZFa5FcrEwCBBwlwZhfeKopA==
X-ME-Sender: <xms:XeLwaGvGEilY3ZWAuwBN3ONfJSgyLvciFlpNwPrY4tkA5k2069YSHQ>
    <xme:XeLwaGRxdevs_Y025imUdqPukOmRtU7-D4YQCjHDdE83SSnFlZk2Vnpz4osJL6kRe
    DyG97gT1Xhg7rIKy2A1BC-erpEip9NTbPeXCSgqSwk6UJdf8_av_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdeivdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvkffutgfgsehtjeertdertd
    dtnecuhfhrohhmpedflfhulhhirghnucfuqhhuihhrvghsfdcuoehjuhhlihgrnhestghi
    phhhthdrnhgvtheqnecuggftrfgrthhtvghrnhepudeigedvtedtueelfefggeegffeihf
    ettddtvefhfeffueeutdfhvdfguddtgfdvnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepjhhulhhirghnsegtihhphhhtrdhnvghtpdhnsggprh
    gtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:XeLwaBeq-EHcRiKTJqp7e0BReyohZQZFxdoZug9sa6wJpqsieqWiNQ>
    <xmx:XeLwaPKWWqdGuwGKR1BlHEUQ95gP_SrSL-CKgauDcIq76K4KnYis2g>
    <xmx:XeLwaHambElGH5rhYfxhhoyDhWToxA_1ImIA5R0Zjbp3x6qqxqKvuQ>
    <xmx:XeLwaCvRQ2vZEqKRu6gDpFd0GFplSbA6QmtyckVP8gq6zV-2SZy9xQ>
    <xmx:XeLwaEuZM290yyezD2tMsI6Mvi8aI1CNuHvFpw5pBxypKTOJeWJpS0h_>
Feedback-ID: icfd1466b:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9AD0715C0053; Thu, 16 Oct 2025 08:17:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 16 Oct 2025 09:46:02 -0230
From: "Julian Squires" <julian@cipht.net>
To: git@vger.kernel.org
Message-Id: <184a164d-aafa-4ace-a858-8814aac058a5@app.fastmail.com>
Subject: git whatchanged
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I still use git whatchanged.  I know there are reasonable invocations of git log that replace it, but it is part of my muscle memory.  I guess when it's finally removed, I'll have to setup an alias.  Normally I wouldn't send an email about this, but you specifically asked.
