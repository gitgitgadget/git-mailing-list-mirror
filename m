Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4061131E36
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 13:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707227749; cv=none; b=s61ePCS9wJZ6v/eMgXblLsxcFsgMmfQAGNKJgQZbr+APuP/f0QyXLf/t12MDJktb87eeLcZbH500FTob7ncZGAFEJQDvqTST01slO9RRQCUqZqQphlg/VsBXPINQ5FM7xgfP0sMEOeGLkVD97dE8b1mLjZ4YM0NQi8BJoqPTjSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707227749; c=relaxed/simple;
	bh=FFR/PHGGJFzPzTIJ/ZQ6/sNQHKbjRujj5+PFTFq8eS0=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=DdT/9fnvWDunjJ8/fwCQ3DKYeRdNkqpWgsPCOz9knFd4L0qa+W2bjsT33N0sWgCMoP7avmyhjEpo79vzId8H53KUxlfG/cUFp8AkZ4SyGBxBl2TBpgAhxIulhqacyAXeEqbG3JEtqAo56Lcr9Go2EFtsi+ER8yZ18es5tlz1bs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=Sxv0AFq1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xOYrPSt4; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="Sxv0AFq1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xOYrPSt4"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 8420C5C006A;
	Tue,  6 Feb 2024 08:55:45 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Tue, 06 Feb 2024 08:55:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1707227745; x=
	1707314145; bh=C7GweQFNB+47iBnURirQgT3fp8xZMeYhDrD0t32e4fA=; b=S
	xv0AFq11FbOuUihTdZ75UcZxk+oBZoHsWLD+eYgsOdMz9LXYr5WymQpJDPpEjrr8
	0Phy4VDAgDJnYeiaWHgomPNQLasVEEh+RzQqnMS8XRrHJRY3JZX23l6HnsRMHcNb
	AW5DYulu9v32ZikFXHW3AHRATVo8VBScfyfU8MbHJ87HQ9ItQ0Sb6JlgIttLp/rk
	Syh+ZGN/2/vcDStf+5wYbP/W1/op8ddFcp7ZNCO1QviSw+PAQsjoFRLZKuHrgDs5
	Al1H9qN+ZErRGSKjIloFLz+Y6Jm9zc7GSeiIqp9eSvyRB8zSoTh4oROLTPMjvcsh
	VnUvkexEo0MMWsO0lKrsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707227745; x=1707314145; bh=C7GweQFNB+47iBnURirQgT3fp8xZ
	MeYhDrD0t32e4fA=; b=xOYrPSt49R2CQXwFTul2Ow9Ijopj4S3TQIdFfoDzMAk1
	y6jWDpK8U8gVMQ+EF8QIIiA/qRU6oFfGQN0TDsBb/bWP0HUL2/0wfoZdUFQhovDR
	fOfvHhN6NBdlhDS8DCFs+cw1CbRoELUzdGrIxtPpDSaTC0so9Q79ZfYqfyA2y0dt
	pGTZXsich86+kgUc3JehDztv5jLv8LXMjUKcEJWWnWzEwwRqX0A+4bAkNfTBygju
	IFM3Al9dqB5qhm0aeyLyxYOk7GkYib83eonJTR3Nx/NJMTl5TOX7PNCgi4V72Tvq
	U2OpklAlexRguM8wBs4ScOSQlZbMvUh+UKeMqhADuQ==
X-ME-Sender: <xms:YTrCZW_QPcgWqO4lhWLLyow540FGqRBMNCNqQQMNJJW7P1OfnanYu2o>
    <xme:YTrCZWuV33tNs_4ZlTrxsvpzvyuMH8xJYM4aMxo11mfW-gu79nd9TYyroorkHtoLF
    2ZJLCEwwkXV1jKkpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtddtgddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfmrhhi
    shhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrghkkh
    drnhgrmhgvqeenucggtffrrghtthgvrhhnpedtkedtjeeiffelteffheeiheeufffgheel
    ueeftdejkeeufffgiefhgeekffffueenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:YTrCZcAYdR6JFosTvIKqHvmhB9Q0xPJNnlXXSEULCrAdWb4WawZdVw>
    <xmx:YTrCZed1-8F0FMIfQvHKmV_zzJezJli8mJcNhm1SF9tZtxcrbwN2uw>
    <xmx:YTrCZbOBNsNobzppG4T_H2XnHVdHi8Fnr59UCLrClcVUyEHfByNxyQ>
    <xmx:YTrCZUoV_2y689rlazdI10l8n4jFueUkl5sVG2zA3wbbcAA8spmelw>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 0EEFF15A0093; Tue,  6 Feb 2024 08:55:44 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <45dd15d9-cdb3-41da-a7dd-cc0da3c85112@app.fastmail.com>
In-Reply-To: <xmqqil32l0i6.fsf@gitster.g>
References: <20240205204932.16653-1-maarten.bosmans@vortech.nl>
 <20240205204932.16653-2-maarten.bosmans@vortech.nl>
 <xmqqil32l0i6.fsf@gitster.g>
Date: Tue, 06 Feb 2024 14:55:23 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, "Teng Long" <dyroneteng@gmail.com>,
 "Maarten Bosmans" <maarten.bosmans@vortech.nl>,
 "Maarten Bosmans" <mkbosmans@gmail.com>
Subject: Re: [PATCH 1/4] notes: print note blob to stdout directly
Content-Type: text/plain

On Tue, Feb 6, 2024, at 04:44, Junio C Hamano wrote:
> I actually was hoping, after seeing the use case description in the
> cover letter, that the series would be introducing a batch mode
> interface to allow callers to ask notes for many objects and have
> the command respond notes for these objects in a way that which
> piece of output corresponds to which object in the request, reducing
> the process overhead amortised over many objects.

That sounds great. I imagine that would be very useful.

-- 
Kristoffer Haugsbakk
