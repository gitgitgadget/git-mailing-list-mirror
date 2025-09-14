Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5F511CBA
	for <git@vger.kernel.org>; Sun, 14 Sep 2025 11:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757851120; cv=none; b=uGr0fwxc9IcrVY+MfvlRb55/5wu67NLUpZ8rZgsn1m/LO11Wm1qqS/Ht+IXnwJMp/FK6yqoWZ0N4WYcpoEV4Jom0LmMcKA9V9862QL3EKPJeuaTM5uYh3XiN+/FWDm4QNNhExSq13qG3LPHYw8gCmymk3OglUarSURZoQ18sRWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757851120; c=relaxed/simple;
	bh=6Mg85UTMN/H9k3KoH7wCeqsUvsRDzBJwwCT7iOBiHAc=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=rcnD0TgqVTjpaddRu1/LdgdSnaGH5u+FG9EGtpcM0iBJi5zCyryVJb19aOjWmKme9ztIwZ7KMX1SRBUoOygJ2MhfmUpVe+mduXihxUCu25nSyiVbjMUI9S/4TtBnm3qP8wZWOdrOSuVfPHykHOp3vzl+E839JyWug9Y0Vi9UbX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Bx1EMrjH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O5sC5Jqf; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Bx1EMrjH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O5sC5Jqf"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2218C140009B;
	Sun, 14 Sep 2025 07:58:38 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Sun, 14 Sep 2025 07:58:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757851118;
	 x=1757937518; bh=6Mg85UTMN/H9k3KoH7wCeqsUvsRDzBJwwCT7iOBiHAc=; b=
	Bx1EMrjHmRuk8Lvtqv4KUs2EwudYRyyqeB1JBhQHHrH00nghFX9CvmrzW6KhlnqD
	xPmLzQDB/JJ9+QknJ4YkwcWUe9ZocdjeRMnzmLqYPdrQP/5n/XIQii3d/wKLDcIQ
	/lYwvg6PNCHk8yNWHHTNGmWfPBSiMjQTu+REXT5GjziEIgpBP4pEELO9mELEa5Ne
	eG/ckmNpoqErpY4hIz+LJTnSW/qXXiRRgEZXhMqvJafB3fBH/J45QBXioQMKMjXf
	xQPD7iNECPeRLOwY+g0nEHF3F4Mx9EGA1goUbCzwfjkFoJPDYyizBjJComBSB6zZ
	eL8fLGmNahGz4IxNGBTSQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757851118; x=1757937518; bh=6
	Mg85UTMN/H9k3KoH7wCeqsUvsRDzBJwwCT7iOBiHAc=; b=O5sC5JqfJXH94xbs6
	3H+CdQM3T7qgoabxAWJLcbSS6892qvthVMT0loWFWR7/1Q5qhLBugXsyMFh5vdYH
	xldZUprc/LcS4CWJh50ViClPF0wpZstCIbiLRpMqX4gjgr+52a4jE6QpBLQ/8rfb
	Mvi7ArdLDZNaqhwX3Y777qNWhohvYOTKhfhHmYe59MUrSPEyn2YldOWAaOTtNXZt
	OKrhew5SZ+q/5XZIYU9yiTvHqnS8QnBQpIwYvvHhV1NXs+VulVIFjTUTZ+7spe59
	tCmTmShvbT6gEHL4DyeqHIPxjf0jojHE5lytJVeySzgBNmaHgzKFCo759IrH/BnW
	oketw==
X-ME-Sender: <xms:7a3GaP4Sz1zGo1XQL_v-t0rw_Jd91XTAMt48BUhtGtzQTLfwvTr59QU>
    <xme:7a3GaE5mWZ0YpIkxw8ymvcChCU1n-6970o_IFNS_XZYP8z8_F4aQxXoxksnATKCJm
    281zolcnMuW_ZjNVA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefgeejhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepofggfffhvffkjghfufgtgfesthhqredtre
    dtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhr
    ihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtf
    frrghtthgvrhhnpedtgfffteetudelhfefkeehtefggeefjeevieekfeefieekkefhveei
    ledtkefgueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdp
    nhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuhhshh
    grrhgvrhhoshgvshesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:7a3GaL8zP7U3TVcvY1vO9N3hFUi8f2G3NqllBUFnHHkR_cRWD4q0oQ>
    <xmx:7a3GaAogQTTyk_n0P7EQ_XqFXzAw8mAZyq9HZQ8NKJf4IpGGhBhEcw>
    <xmx:7a3GaK-LU5XB6CT7Vh70ZbtRSX3Lwgqszp8rjT8nzeDu1fREJUDUxg>
    <xmx:7a3GaEVm-gbHmMfEo_w-EbH5nKyjSAol4L_9Ud1u5jSeT78y0oO2Qw>
    <xmx:7q3GaIl_eI_MMeikM8GeHzU9w8w2QkyLV9lo3cFO5mNEVphAALX4DlEg>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C648A1EA0068; Sun, 14 Sep 2025 07:58:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aq6Grg-h5Bdk
Date: Sun, 14 Sep 2025 13:58:17 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: 'usharerose' <ushareroses@gmail.com>, git@vger.kernel.org
Message-Id: <62774477-81d2-4959-aa5f-fe0dca023a2a@app.fastmail.com>
In-Reply-To: 
 <CAJKmQvf-sLxowLJLitvqDmyL1BXXDK+anDE2jaBSEabApMNVoQ@mail.gmail.com>
References: 
 <CAJKmQvf-sLxowLJLitvqDmyL1BXXDK+anDE2jaBSEabApMNVoQ@mail.gmail.com>
Subject: Re: [DISCUSS] validation on git config user.email
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025, at 06:13, usharerose wrote:
> I'm a Git user and curious about a specific aspect of Git's design
> regarding the 'user.email' configuration.
>
> Git allows any kind of values without restriction when setting
> 'user.email' via 'git config' (e.g., `git config user.email
> "not-a-valid-email-address"`).
>
> I'm interested in understanding the design philosophy or historical
> reasons behind this 'lack' of validation.
>
> I've glanced through the documentations, archived emails, or forum
> topics, but couldn't find a definitive or official statement.

What=E2=80=99s the positive case for email validation?
