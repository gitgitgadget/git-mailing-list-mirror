Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4D52581
	for <git@vger.kernel.org>; Tue, 30 Sep 2025 19:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759262268; cv=none; b=K3GhWPAHPmsXa7l1h14qERYf3SPjvsaPLTM4oMcuZXwxRH0s2zDIHKo8G/jopJmohyMMZ4qu6OCwH4y9XOMo5RbQ+5g8LT4P923hpKHylbbwEwRISRBdap0uMFfQAA9VAYBfiQMYHQLvAbXCqnUlu7lLgVPJysGSaCuEpmPa5g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759262268; c=relaxed/simple;
	bh=M+yhC/frMxwuWG0h3lsyiqGNoMEjHYBy4SEWX49zt88=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=jd7yYPhmGfaMofCrLng40rJVRg1WpJFV1fjvWl6r/oRFQQ13yTC0PN1yimZXmG+ROdpjI5948ibEpcOR00C+JKncxuAA9eiICxa16DCTxk/Yd37iFcRSHFbiKj/VF9Oz94bTz82NGCoPq6Rt+7xbb6EDNikiONBvH2B09/QAsgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=LPm4gAt5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J8GkBIFs; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="LPm4gAt5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J8GkBIFs"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1BCFD1400078;
	Tue, 30 Sep 2025 15:57:45 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Tue, 30 Sep 2025 15:57:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759262265;
	 x=1759348665; bh=E1VNGuvdSwEMcDMDe/7vM7gu3IAD2TK8+0opcVAAPXc=; b=
	LPm4gAt5A8w0OEVAT2TQPIIR3gK414AlMhcFXRnbzKSoFoaWOEtotq1ak29IZTwC
	oBlxuyU6mF/gT3eH73UD1hblXnaOpTOwnWls2EkRjfmXJ8N/J6pbOeu3dlowZaf7
	B/4s7zGtv6JjMCchy4SPqABQrAwOAxAoFzccTmDCowbiN0JzVAMdXHew6T2YG4Fl
	ZDoDHuczaX2ubfSOZah3IJ55IBmJSMilvmqnB4XQFFWswu+1gQ6Vmvmv6viMnhUg
	F5v75hVNNKj4q/7BUN8Nc8vMTh8WXaWNVmMTHG+FoJCZmn9ge+MHg9/HsSGyW0ks
	PGwVQs3WDeZ2c3u9tK1GdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1759262265; x=1759348665; bh=E
	1VNGuvdSwEMcDMDe/7vM7gu3IAD2TK8+0opcVAAPXc=; b=J8GkBIFscBoZ5DmsJ
	4TrBEwfWkkKYfZCeWGBop30s3Pcbn3ceuXUstIPgcsnJBIPf8GFXXjZrHUWgBlpZ
	4q0++ZmCVtUC/Remdb6eE9i9BG11LELzytzsracub1I6TNVyRDGHM6oB7aT2GPtR
	63ZB065UgGyb7KJ3v9iukxqGQimg4w7/EZ5Dmg4F3sV56yz+4NGQO2+wiIgytG8Z
	AZPeDAq7MH1oSYc98yY1aIeMXrcZPNZj1I9Fb/H0ZdiOHzloGOov+TMFC6YJcjMu
	I+gpsqGvJM5MY7uxFSLdwUt2I6DExhw4djhUm9xMV4py/bxdHB4COlBuukgPfEFn
	OMPAA==
X-ME-Sender: <xms:ODbcaGsJHjdAMrba-4YX7mmzVWAkA8DpOW0qrsHBSVU23zXL1sXLar4>
    <xme:ODbcaGT4csgwd-rwVKDpbXks6-LgJUMxniIdjz_Oxh3yQX14w7we6E4WTONkn9Elp
    15QADvOg_wWh6Xw2nwqHFetSebTNt6du1LHBOLyLRxelG1b5Wcsq0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekudehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhsthho
    fhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssggrkh
    hksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepvdeigedtgfetgefh
    ffetteeludevheetfeekffehheefieehudekveelveffhfejnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhg
    shgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehsthhhrghrughinhhgsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ODbcaFaheZrreqQDzKc8In_I5jtDbq9zxHpKLrKIkCDMmUipgi-00g>
    <xmx:ODbcaKU-34PSuRd3O2nBzEW5FedItHLIKYIsBdXLVTiV2S4xWmOzUQ>
    <xmx:ODbcaPhnOHiAPctac3kfRXhFjoXM_iB9zrsGImQkKhrYC7KcRd2H2w>
    <xmx:ODbcaAUApWOb2yv5jCUwsUmknKAH1e0M9FWNiibZMacR-BLzEUb63w>
    <xmx:OTbcaLCdqUh7XYpkqFFg5nZO6z-1o-JVarzYHNTHzlxR0r62LMB2jxO_>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BCF2D1EA0068; Tue, 30 Sep 2025 15:57:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Amls6-OXYtxN
Date: Tue, 30 Sep 2025 21:57:23 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Stephen Harding" <stharding@gmail.com>, git@vger.kernel.org
Message-Id: <43693ac1-e289-4e80-b74b-39e134ffb476@app.fastmail.com>
In-Reply-To: 
 <CAKu9fqx-fkOmKLby0mWU8D-T9vL1oY49kVLN2zWwhyfTUKSPsw@mail.gmail.com>
References: 
 <CAKu9fqx-fkOmKLby0mWU8D-T9vL1oY49kVLN2zWwhyfTUKSPsw@mail.gmail.com>
Subject: Re: I still use this!
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Sep 30, 2025, at 20:49, Stephen Harding wrote:
> I just encountered this:
>
> 'git whatchanged' is nominated for removal.
> If you still use this command, please add an extra
> option, '--i-still-use-this', on the command line
> and let us know you still use it by sending an e-mail
> to <git@vger.kernel.org>.  Thanks.
> fatal: refusing to run without --i-still-use-this
>
>
> I use oh-my-zsh and I rely on the git aliases. I used this today:
>
> which gwch
> gwch: aliased to git whatchanged -p --abbrev-commit --pretty=medium

It's being removed because git log supplanted
it over 12 years ago. Both commands use the
same machinery, just with different defaults.

You should be able to replace that with git log
in front instead, maybe with a --no-merges as well.

Cheers
