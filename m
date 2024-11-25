Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160F5EACE
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 03:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732503825; cv=none; b=ekWO6Ljs1mRNdTwHWdoV1oUKOsUK5M2QserJmFSevmCEGmvhluMxaEXsPt1rODttNIntkkSZ//FcLO8/hS0vaCDSQT/cEefwWiwDUsTtPLg3QeLaxwUJDu+40oAor7RD0VoV/tANPZljkVggsfyFF0rOZ4fYDekwceZU/t86yeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732503825; c=relaxed/simple;
	bh=eEbZed1I795GKMwZKqkwdD9rCCBGq4HiCWva5ekuT5E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lqpHC6uWB5Gi3rAPTX4GGtZzZCghkbz8tAbRnl+209ynUyBGrEXI/KpqfnTeEiVhU6tvxfkTSSnLFXQbQnHICuj1uece/xKqkTxMw78ggX6P8yXzQlMJI2jU0j+ULx20MknEicc7N6NdOnifpm6pHeSEehwtpokFQTC0xxZv9JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=khKqoexq; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="khKqoexq"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3F6D6254016F;
	Sun, 24 Nov 2024 22:03:42 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Sun, 24 Nov 2024 22:03:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732503822; x=1732590222; bh=iTce58v13KdB9882h+NcTBuGT0HxbXjNdke
	IjBX3PjU=; b=khKqoexqawHN+t9jkxhQ1DljNPAEEgFvdOoxmmgOSJkseIhMXfz
	Rf9sPQb/CPboywPpdl99Z0kSvrvXo/VRIKWJ8gGXuM9oGPjVEjFJlapv988RA8L8
	GQSVdLqHJKeUXKk5fM2pJpbjLUPARWNgrcnWHMOSOHQHEIGaVVn72b52lLXnYRcx
	mg+wcYN1Do1ECRm3qsulLVYYH0uCsqUKyNaLHJhrc3sGM1CZ7wQz3rwPKJIPrTZk
	fIzRxrwfBSgSTpJFOzdsftxR/gqVdMwQkgyNUuMOsvDklCRbKpmeFOUxLFGEDc1e
	iDKp65bT714QYI74yCxa/oluVtjxKv358FA==
X-ME-Sender: <xms:DelDZ-IeoZ47ULoJ07GUb8XYG2gBxB7fPiKROPV2JxAyxS-rGBp_GA>
    <xme:DelDZ2JOpwhOh68WytJNXerCg9qO-ezTmPzBxdGry2VbAtYVPrMWIpplmvTq-Qmff
    Cn5NiIoluQJrRRdlg>
X-ME-Received: <xmr:DelDZ-vDYDVDbf9m_WJ4lZ5wVES_qwYFaWj-PJZKqH_2SRsHheDYlyXnbE2MPc8xfxGHd6AOgAmVItbDMEHhVWdAsTVgD2xn8uejJnU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeggdehfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvghntggvsehfvghrug
    hinhgrnhguhidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:DelDZzb5v1VrgK2uXXwlo0ErsJTmaLJMEyHkjJc_yjQdhGbC3q9hrA>
    <xmx:DelDZ1Zkr8oVp2cM9agknQekHwug9t8dY_qy2MQRJaeSpFph9XtOuA>
    <xmx:DelDZ_CYAXWsQnxaP9YoRdvc5OqspKhos1NJWfiSUOooC5Ct-A5aCA>
    <xmx:DelDZ7ZP89AM_MwkFeGNv0s99ooHNjgVZSdLxtWtP6N41XjyEwx4yg>
    <xmx:DulDZ5EsiiNWnNOrAZHSAJADR1ra1kI_oAHat_3V2102_LzjXzmm4dbc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Nov 2024 22:03:41 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Bence Ferdinandy" <bence@ferdinandy.com>
Cc: <git@vger.kernel.org>
Subject: Re: Extending whitespace checks
In-Reply-To: <D5UQHS9IV5N1.3IO1848Q1730B@ferdinandy.com> (Bence Ferdinandy's
	message of "Sun, 24 Nov 2024 22:41:23 +0100")
References: <xmqqbjy5bc6m.fsf@gitster.g>
	<D5UQHS9IV5N1.3IO1848Q1730B@ferdinandy.com>
Date: Mon, 25 Nov 2024 12:03:40 +0900
Message-ID: <xmqqserg6mlv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Bence Ferdinandy" <bence@ferdinandy.com> writes:

> This might be a tangent, but since enhancing whitespace checking was mentioned,

Since Git was mentioned, let me talk about something that is related
to Git, even though it is completely unrelated to the discussion you
are trying to start.  Which may distract and bury whatever you
wanted to discuss in the list traffic noise, but I do not care ;-)

Don't do that, please.


