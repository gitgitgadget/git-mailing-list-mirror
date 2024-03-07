Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2B91CD16
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 07:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709798392; cv=none; b=ktmG7RX9o+LUF2n6fdm3LDid40ceqw31JOjBlyXIofVdG2snTkB1AI/GEt/mLw5WDvEvLXfbGXKm7Pk8yTyQJ+XlhENf2RPjiYFsJOC6kMuTuk2PB0mqIUcZ5jQxCv/H9AmzF88amqg19TevcWlsTiyCpImt0CK1JvY6Cew/dDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709798392; c=relaxed/simple;
	bh=hKgD3y/A1t8YjbrtQWr0v66EgX/utuNuN8DFtW/puTI=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Zmiqy0tjjET1fMC2eOh3vDlXxKMv9Xu+8Ien5OhynP2czyNFAJWcfCtn/U8yIeelUzfufLSpoucyOQM8tMwYqneguQIyK/A+htzfR4LxWIbZguRY4+aeWxtRvxBoOtIf9UPImu1ohupXrn8odgXpPDK7YQ0B7dkJtc6F080nD6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=B+u2eDAL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Tc52cwrF; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="B+u2eDAL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Tc52cwrF"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id BB45613800F9;
	Thu,  7 Mar 2024 02:59:48 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Thu, 07 Mar 2024 02:59:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1709798388; x=1709884788; bh=UpPV7PCkgbBWdIAUiUpYD/N2T+jtDeaZ
	iRtEGXuU3LQ=; b=B+u2eDALnTiR2VlFpJMYxQDOdVd4BWJFiQH+7I+HzDyXmEnw
	bsm89laPcl3b2YJqwv92ZJlGRE5uWZPfSoR7load85Fh+d+bIMqmO2Acm6TEtYVi
	5cm9jVyYGIaQSilBdong1fUeV69fxtz2b2Lz9viICnZORtYi2tQJXben2w3TvsrW
	HvmBPak5c0OHRZGNfI1LzlrS2hticucncLO+QBJwgIQGiQvdwWN1chIBYuQ0ze7P
	vqaKjzhSk6RGUe9gYYv9XXFLsSbCYXjLMstfIk9sxM8ydcfPR1x0Kz+vLQO/HVKA
	OL0LjMCL9ptIw+VinCUBecfmieVqT/tNobhyrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709798388; x=
	1709884788; bh=UpPV7PCkgbBWdIAUiUpYD/N2T+jtDeaZiRtEGXuU3LQ=; b=T
	c52cwrF83k/0Ib/RIvngvqHeTHZCJ2tkRraEqggn0WfS+rJM1rmxo4yCbHRmKw/W
	RJkl8fpsHSpPQHDdZrYI2i0CQ1BKSdN+jAWFjqJYc2rdipq0cBLRVrWu5ymH/7Wh
	fz3Vz4zJwQCL21mhT0/tLWjKthe93PkVdUdyTW1IuRJfhX1+Pk3BSGg99MRQazBp
	aqtM9At9xVqoYm4nzp8YKTXWaZN/tEYzNu4pA0wetWNFyGeAQcT4srrgD4c8Lw+X
	W2wxrMM9gea++1TeDyJDWUVsaoBAWJu/SilJoEJeag45dR8a4Loe9EueAabE75KU
	wiReAvR12O0b5HsnO6a0w==
X-ME-Sender: <xms:9HPpZciD3Tl8wWvEz1S-QNjeBc0u9XJ4U1sqXFlNVYSN4fEJtM7A8h0>
    <xme:9HPpZVDoDNxnV3HY6ggAX-cuu4qWQuWhrZPTDdxKrvEo-VrHB5IokW6_houMMGtkh
    DfrhzS3ZYJUSPuysQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledriedvgdduuddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedvveehiedufeehffdvteeuveekhefh
    leeigfektdeifeduteeuheeufeetffefudenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:9HPpZUEiV8vMl3DFmG2wtX-pSXhRm6eDPzFOZJjGadEfQQ7YJOQvOA>
    <xmx:9HPpZdRnrxPJl6ASd3fcb2bScmcqVIl9VtImmPHBkYX_gMA662LwIg>
    <xmx:9HPpZZxxq8TcSO8LJiTeC_zdAcvQuTSLnwk7PVT9Yb8-mTu3VpHoHA>
    <xmx:9HPpZcqQ5lg1x5rH2qzEjberlzR2e1P8y9a93qlv6AVXQVkalENZaQ>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 2BFD315A0092; Thu,  7 Mar 2024 02:59:48 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-251-g8332da0bf6-fm-20240305.001-g8332da0b
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <25aa1b8d-79f6-4b33-be22-735a867367c0@app.fastmail.com>
In-Reply-To: <354f9fed-567f-42c8-9da9-148a5e223022@haller-berlin.de>
References: <adb7f680-5bfa-6fa5-6d8a-61323fee7f53@haller-berlin.de>
 <354f9fed-567f-42c8-9da9-148a5e223022@haller-berlin.de>
Date: Thu, 07 Mar 2024 08:59:27 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Stefan Haller" <lists@haller-berlin.de>
Cc: "Derrick Stolee" <derrickstolee@github.com>,
 "Elijah Newren" <newren@gmail.com>,
 "Phillip Wood" <phillip.wood123@gmail.com>,
 "Christian Couder" <christian.couder@gmail.com>, git@vger.kernel.org
Subject: Re: Should --update-refs exclude refs pointing to the current HEAD?
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024, at 08:40, Stefan Haller wrote:
> Coming back to this after almost a year, I can say that I'm still
> running into this problem relatively frequently, and it is annoying
> every single time. Excluding refs pointing at the current head from
> being updated, as proposed above, would be a big usability improvement
> for me.

Sounds like a ref-stash command is in order=E2=80=A6

    # I want a new branch
    git checkout -b new
    # But I don=E2=80=99t want it to be affected by the next rebase
    git ref-stash push
    git rebase [...]
    # Now I=E2=80=99m done: put the ref back where it was
    git ref-stash pop

--=20
Kristoffer Haugsbakk
