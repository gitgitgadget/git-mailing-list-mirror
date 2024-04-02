Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B983E47F
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 10:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712054345; cv=none; b=QR9jmO+bObAi5WVY748UiDwqo+P+Bv7FZd8xdARvlYFlIfp65gnY0X8Pppso3tdd58S9Qexz0mUNhVFi1BRjWlCa6I13bNHEwrStsyfcHUmFuTujMT+OadNTx9fJnysy1+waZXaH/o6cxxEJ4Nm46Gaq7KpXiZ7W1O3xq3kGwUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712054345; c=relaxed/simple;
	bh=ZZ5CegorOe39dRveCfZhgya0rwl8oTdQPa2iQbH/k+8=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=fg7FD+3LPTVRHWkjSVgCsgKht2MYN20zZIpvgXC1glGPu2UVmgNn8FW35UnMVYYtDheTabvVEo0nwncFlkGxFEpjK28NsBNPHi5tIdJXm+NF8kX2tHgqAiVxORxMt82A/E+K4DVcpa8nHgNHAeVU6S3owLFwwE3jh8/nxPsScsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=oO2qpy8q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KtZ88D2u; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="oO2qpy8q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KtZ88D2u"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 4260C13800AF;
	Tue,  2 Apr 2024 06:39:02 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Tue, 02 Apr 2024 06:39:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1712054342; x=
	1712140742; bh=Pds2SivP8oXOYNyZ8atLfBwXO4l1x7Qojj91Yvonmzw=; b=o
	O2qpy8qp3GbUj5dM5pIkyJQ3b2jRJAAjTVzAdU+mE/MH1AxBQRlBhWP321rDq2d0
	zHD3kFzgqCfPPgCdI7D/nXRpiVk9PUku7kOt45p2uWi7U/y79EOYCc6caHfAJDUf
	lnDpe8em0UqmUOoDrChKYDYXHggP6W/Xv7w+CknAo/YpimJx9rhm9ZY5KdtazgE4
	x+XLABLLDCv1fx5fcgTBBhH0gsc0KMcYmlpP5+4Rnrl2hPhCX66kLgfTno0riQva
	m2nN3SDUdqO3gOF/koFluGuNA7MFQj6LLgzbghG42mQaNpJIZsZ8BpXNuqI6/8FB
	sQNR/emJZio95PCWsth5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712054342; x=1712140742; bh=Pds2SivP8oXOYNyZ8atLfBwXO4l1
	x7Qojj91Yvonmzw=; b=KtZ88D2uMI06IB+3IZDJEEV/V8pp3WXoToKr/sUOYzzX
	5Vnyvwqp1HlWa4rKJeIj7m7/GchR4H6VuDspr3U8l4PxUMs5UAwrxLgxoQsbhFa+
	Yz4cs/TvWuxSP+hfLkjF3xXr/tghgvlrTKxiMsr0RVIAPZSVFUVyBOyoP5GT9025
	iPd2HiReRk/VAu/k89hCLvY/KTRZlo6FilEG9aZrpJrVzfXz4Uc0pc3iGlRCRR+T
	mdih3L+s3wCie2Zpn1BOUePRk38FpP7g+BE+EHbmUuCjsJBiJAgHTETQ5RTc6ljX
	OZZgrebT6paa5dzF2moVsvmlXT7VGPTMB/BqRSqGXw==
X-ME-Sender: <xms:ReALZqsq3VAGniMSJ5sa5CrXJOIXtXJvay5-scffqkaYWSwd_uuI5u4>
    <xme:ReALZvfoGgphnMEhQNDRQcVJbdSuGJd7OiE--uKJ_7eW_0STkrFFXLmD1cz52gKoa
    0pdHvc4Zdnm_Hvrkw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefvddgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfmfhr
    ihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkh
    hkrdhnrghmvgeqnecuggftrfgrthhtvghrnheptdektdejieffleetffehieehueffgfeh
    leeufedtjeekueffgfeihfegkeffffeunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:ReALZlxz12eOj-icfc7oaUpUivv3auLKif3xGcOT7wUUMluNBEJPZQ>
    <xmx:ReALZlMyFC6_QZLgxL3i25WSpTIf6fIgl30Bd6jXGNfHnS6e76-iWg>
    <xmx:ReALZq_Dl17uo47Rb3QfiJ15YKDEiXAJbLsSDgJjebQX272KwIwOxg>
    <xmx:ReALZtUnqEgRMKTMAgZK1KL6fWHvc-ePwOSrQc-NFh7g7m5-qAMb8A>
    <xmx:RuALZuZDGiJ0IXF3yNMnHq8rfxu2LX8a-DeG-YENp1z09M29eFt66_ML>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id AF62F15A0092; Tue,  2 Apr 2024 06:39:01 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-333-gbfea15422e-fm-20240327.001-gbfea1542
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b331feb8-6af3-4361-9822-31c7440e65f8@app.fastmail.com>
In-Reply-To: 
 <CAEYvasmb1TjwWpSbfSAogbOiB64sZQiHVoUhxvY+NoLmXnRuHA@mail.gmail.com>
References: 
 <CAEYvaskGHYrQgke=gf1sXYhrwbd+SeTpcjGF0fpxK3hQbyPFKg@mail.gmail.com>
 <CAPig+cQWW1sLXyTBvk6D+1h15sZCtQO1opfhtFfiHr_kX0y82g@mail.gmail.com>
 <CAEYvaskXRyxNTLNeRPPyawFrBVRgCbSnJiuF7D7cOGiaDq=V2Q@mail.gmail.com>
 <CAPig+cQdFi5zBkDQWTEWXCTt5h9gVFNJv7obf=tWCkOvsaEHEA@mail.gmail.com>
 <4041487e-d8d8-481c-b490-884e31f533a8@gmail.com>
 <CAEYvasmb1TjwWpSbfSAogbOiB64sZQiHVoUhxvY+NoLmXnRuHA@mail.gmail.com>
Date: Tue, 02 Apr 2024 12:38:16 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Tamir Duberstein" <tamird@fuseenergy.com>
Cc: "Eric Sunshine" <sunshine@sunshineco.com>, git@vger.kernel.org,
 "Phillip Wood" <phillip.wood@dunelm.org.uk>
Subject: Re: bug report: spurious "cannot delete branch '%s' used by worktree"
Content-Type: text/plain

On Tue, Apr 2, 2024, at 12:26, Tamir Duberstein wrote:
>
> % ls $(git rev-parse --git-path rebase-merge) $(git rev-parse
> --git-path rebase-apply)
> ls: .git/rebase-apply: No such file or directory
> ls: .git/rebase-merge: No such file or directory
>
> Yes, it's the only worktree.

Have you tried `git worktree repair`?

-- 
Kristoffer Haugsbakk

