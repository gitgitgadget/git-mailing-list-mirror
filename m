Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EDDDF68
	for <git@vger.kernel.org>; Sat, 20 Jan 2024 10:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705747742; cv=none; b=EA73MMcO+b6Pz6EhKAuX757PpJUr2OlmqRyruYxiQxrlP1xUxGGQ5RHRUbxL9N4c32kFEKw6qtPP2g/Uqy/p68cy/84eG47X21H2bqhspkJ0dgq1WEc1tSfmfHugs1mzlOng340zHwUyQVOK0j6o25Q1GD7i6xYli0dCKroC55A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705747742; c=relaxed/simple;
	bh=OyJCtPN6P5Qlkun3spXq+OlkL7s7evkW6NC40V867WE=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=LU7YhBHHaHzyWeUXRDz4euVrw/PJ8jbYNLxzxA/bAePy6a1BV2lKVizHslis9OLaKMER2xVCeUGIfuzIiqEWHH8Z7nIOILPAG0hh80KSSujuAzKt6k1TDk5+iSFjqKpu9dMGDJRVv2m9PheI5RtH11jadHusWq1J7zT/tjy/oMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=WVTTDJAX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aQgXW41m; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="WVTTDJAX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aQgXW41m"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 4ECC35C00C9;
	Sat, 20 Jan 2024 05:48:59 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Sat, 20 Jan 2024 05:48:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1705747739; x=1705834139; bh=OyJCtPN6P5Qlkun3spXq+OlkL7s7evkW
	6NC40V867WE=; b=WVTTDJAXMNdkhtxlowA64ZQmw9ipZuPMSWJT3Hj4Y5KX8Tvb
	PnwhSU1fLCL/DbpUX9h/illT/WGOFLsiSLLLfrELjABSZlOzE3wlgILurPUVonMB
	FnwUhamkNqGbfonBlHDojHsuLV6L51wRgNzqAAOqebLDCqwSLXPd91rZhZdXBwmh
	qvvG6PLVouUu8byQ6LjBm77qQ+O7m7cMnl4KFRdyGnh9JWYAU7WTrr61gPTapHaD
	OAhGR/RYKj5U2XF8e10caZJuTDT7eqE4D9lx9KGZeqzcUrQcx+U4r5spmnug0u9V
	eqj/S4Xs/zyBZhlotJKUUJETHON34Lv2XUTTdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1705747739; x=
	1705834139; bh=OyJCtPN6P5Qlkun3spXq+OlkL7s7evkW6NC40V867WE=; b=a
	QgXW41m/tOL8o+gyO5PXKDqagUXGIamOkhdif4CpLh4sP20B9EZujE2aHldp4O6F
	4ioNIkK/1oXFAlkGMiH5biQ+fwqBFDXRLbQhItmBbGTU8SZkjGC4NzJtji9kn3QI
	c++2QY/gzvFTMQ3TOIU0AB9qJosocT8fh6SenrxiPYDgzpmVD6YhX6VQFAQmuuN+
	hPv4y2QXiljGcCDVSSK8tvavRJOvF+ID9vPHYiQ5maaH+cTz2EVd41+gtlL7cdC8
	zyH1iRFkO5DwuNyPaA3rcua0nRRN/dae5HKiPcJ9GGOj95VGT4GTaYl7d9WNLyJf
	SdKud35EKSwoYVPXLkGoQ==
X-ME-Sender: <xms:G6WrZVjfE_ER1yz8Pr1-z2kQ1vfpHGEdVSu1eiDUoJh9DzDE7Lg8P4k>
    <xme:G6WrZaBENf3YRDONxQmY1E3225DtbFdp7mw90zWAp7eMxYOIKEHVU6d3VoscnT3wh
    VUC-81VdSsL4BWsXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekvddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedvveehiedufeehffdvteeuveekhefh
    leeigfektdeifeduteeuheeufeetffefudenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:G6WrZVFQNqa6WLcSnn0E3vn4UuVUrBB5PEwHHl-FmJ5E0fNYi_XLiQ>
    <xmx:G6WrZaRk2B4P60FrrQenak-igCL2Q4RJbs-fnVNC13K_xjJSX43Qfw>
    <xmx:G6WrZSz2Aci1Vm6zptWHXRGP5HKI7iXDcAc1b_Nw-UbYbdvMhKNHHg>
    <xmx:G6WrZd8cTaXdToslgTPeRa6vlMfj84cml4pV8ft5pVJDu7TNw-EYJA>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 0DCD015A0092; Sat, 20 Jan 2024 05:48:58 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1374-gc37f3abe3d-fm-20240102.001-gc37f3abe
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <527ae359-32e7-4c49-b733-614f17876f14@app.fastmail.com>
In-Reply-To: <xmqqmst1hsd6.fsf@gitster.g>
References: <pull.1644.git.1705697955144.gitgitgadget@gmail.com>
 <20240119-flat-jellyfish-of-drizzle-b31abe@lemur>
 <xmqqmst1hsd6.fsf@gitster.g>
Date: Sat, 20 Jan 2024 11:48:38 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org,
 spectral <spectral@google.com>,
 "Konstantin Ryabitsev" <konstantin@linuxfoundation.org>
Subject: Re: [PATCH] MyFirstContribution: update mailing list sub steps
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024, at 23:26, Junio C Hamano wrote:
> Noticed-by: Kyle Lippincott <spectral@google.com>
> Helped-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Just curious. What=E2=80=99s the difference between `Reported-by` and
`Noticed-by`? `Reported-by` is documented in `SubmittingPatches` but not
the other one. Is perhaps `Reported-by` specifically meant for bug
reports?

Thanks

--=20
Kristoffer Haugsbakk

