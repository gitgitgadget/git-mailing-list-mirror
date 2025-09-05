Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8E92F7AC1
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 18:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757095358; cv=none; b=OQxGU5BujoRTTZ3t1CU1cz7Xt3JUdR6XGKmCCkYZtOrruu8m4MUJjwKsGCnCWGc62FhHARqX0ABg6gySEtpsC5PA2bVk++UiO6X3znDeUFXY1Ky7HFhcYR9UcRItAb7KpUF30tBzHHicvzRqU6nn9Pk1FN+DuFrLXyhX5S+c4Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757095358; c=relaxed/simple;
	bh=75UmaZTT+CbXvdk41yoBpCw04bd3EpsXBaCR9qvtR9w=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=N0ZECT5Xh0TlrAygIJkBZb2oqUBBydxBpplL6jkuFWqnpe8W2AJYAwfmjl3JiI8EqTH2ipb5cYSyQCCjYxGx2vsIuMVP5vuzln/uJpJNcb3YEboPyz6CnoQ9De7cAoFy2PNJg1s99iyXtVqkJpix06lAMS5AwY07+6o3oEUmgzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=WMhIgW7s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YCVghiF/; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="WMhIgW7s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YCVghiF/"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AD964140023C;
	Fri,  5 Sep 2025 14:02:34 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Fri, 05 Sep 2025 14:02:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757095354;
	 x=1757181754; bh=V40nbLjgvJWS1T2Na/hLdsH4PZYzy6gUsOUV05iAtL4=; b=
	WMhIgW7sTF1YMHXiEaQw2Y57ZpQZq2uKhysyVAqdEW3kiDROLDoXl2gQXKMzitUA
	KAC99w/wwnWdnzyABjJy+5Yy/whhmvEcqBprEBBCtBJ3HY6o8F2K4sC5JP6xrkxW
	+fy9cU3QXoIeGmigoYHuAEWr++Lw317ni8Cp2rz9R0E2jxt6c9IGF7ia/1AXmO3U
	SZK+HrNkVCS1Wr9Jr1/+uj3iEPes9xKqd82J1eOfoYr5okqXKMKFDt/sbSLCMDkA
	xabc1/FFOCD0HsZgGupVi5+Xn5sX/UyzFQhnCWJypP1wuj7pU/ZOsXFaS6wMGAar
	bl/cd54K6w7oUTaoO9KJZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757095354; x=1757181754; bh=V
	40nbLjgvJWS1T2Na/hLdsH4PZYzy6gUsOUV05iAtL4=; b=YCVghiF/jz0pgmyyy
	pDSIzbzFb0lZ0rPl5ljR4kcRMYamL/3jZ+sBidr1v1EyZiEnTYbYPuXo0HFagL7a
	dYILEEFn1HlHxAbwttO8ehPOy5ImkKwzIay/po/N52gxfmHs5SQUyWPOHxOMauYO
	VbTBslG08IURivCDoPeD4DwcMGvJUZ1e9jDFngXGI3n3gfMahvcmOTVk5T8VljBY
	cATcPXL3msDek5qOtufG1Q0QMZ/N3YATUmjbVPpQAzelxYW48IwtwnjjJSp5x0Hn
	Dw/SSPl+aJtw/H0tcCC4LNdQKMb4GbsjGRHnPNggM5hLwQgw2qD5svsq8fnIWaT8
	WJCvw==
X-ME-Sender: <xms:uiW7aKFRClQmiiNkEO_oa8kOsDyOhrSWTVT8kUSZ0EX3I9_0fFUi6J0>
    <xme:uiW7aLWDHTST786-TVQ-p83cUcxKt_zxpplqv2ul66hqfUNXhk8xKHp__Qr1GKesW
    VfF05YPBPMGdCkBmQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdelheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefoggffhffvkfgjfhfutgfgsehtjeertdertd
    dtnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhi
    shhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepvdeigedtgfetgefhffetteeludevheetfeekffehheefieehudekveel
    veffhfejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhn
    sggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehvihgrnh
    hnvgihsegujhgrmhhordhiohdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:uiW7aCJho3NHBQircIxwseQk-K8jyDcZIq-_nkZ2emHhq_XVrjjUVA>
    <xmx:uiW7aDFl8_bL4dV4UMXVHjXa3AFdZe8oY-7KN3py56A_7uWRXfU4XQ>
    <xmx:uiW7aEoHUDfrEDbFq21onTLR7rkLK_IMyARXUJ1qncNDS2XonV1lXg>
    <xmx:uiW7aERJbDMl-lPnE2eL1FjIevHapieQkPkZ09BlPymSSP_4M1iWDA>
    <xmx:uiW7aGatZezzc6XVvA37Czzn9ZbqHxfU5JrL88O-eY47jJQRv9EDCiip>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6F0F71EA0068; Fri,  5 Sep 2025 14:02:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AMQ6x0vXGc3g
Date: Fri, 05 Sep 2025 20:01:25 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: Vianney <vianney@djamo.io>, git@vger.kernel.org
Message-Id: <5cd75dec-abe7-4e73-8169-c89fe55e7c89@app.fastmail.com>
In-Reply-To: <c0352082-f8f4-45a5-91cd-652a91887b53@djamo.io>
References: <c0352082-f8f4-45a5-91cd-652a91887b53@djamo.io>
Subject: Re: Reporting usage of whatchanged
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Sep 5, 2025, at 19:54, Vianney wrote:
> Hello,
>
> I ran today `git whatchanged` and realized it's nominated for removal, 
> but it is possible to report usage by sending an email. I'm sending this 
> email to let you know that I still use the command.

You can use

    git log --raw --no-merged

It is functionally equivalent (see
previous discussions).

-- 
sent from mobile
