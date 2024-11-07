Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C6C1EF0A2
	for <git@vger.kernel.org>; Thu,  7 Nov 2024 12:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730981500; cv=none; b=FTmvOWfueTsiGr6QPbTRnoCldz5MuU4j7vD3vJRhMoTe5xMWxxjl+jcOLJR+qleOY4NhPQVHSgarUx+skRlEm9yxghY8s9+/hpOPInoW/uTtZLRMCvvhrrapSWsr7im06J7qoWC2KQiI+jGYrN5b9HTh94WTT2hQiNi1bEgVcLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730981500; c=relaxed/simple;
	bh=23IT4lFlzv+Bs2FmWWgbkQAoytQxMJm1rzdB3jakh9E=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=oH0D4AqUqLlX8SbXIz/L6zAg5T03vOSvvwnrBT55vJQxAOu132MGgNv5WmC1xZOJk6U16FsR9Nzkn7i1ySzxXMtg7CgW/fjIsJzc2xr/w6BtLcMLYUcbdVWAkmqRpBOfFymHkRHux1DFyWKv31sNAo3ixA6CKrh2pw/hCDcZON8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=sAhuEtj/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PiQ6Xz4H; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="sAhuEtj/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PiQ6Xz4H"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DFDA925400D7;
	Thu,  7 Nov 2024 07:11:36 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Thu, 07 Nov 2024 07:11:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1730981496; x=1731067896; bh=Q7B4tITpieD9SOFrzxBIa2/+M2E42/qE
	wmR6TQaLLEM=; b=sAhuEtj/8y3Cf1mIgJB1/Prb+3mTu0sm2XMSCVV3YGGDMTPo
	y9roszJVSPGMA+p8RJ/PZoYI3JetUdFY2/24jM/OmZW9Ihy1MrtPH8DGYyUjeK/B
	Wm3imyhJ01NVUIkbRqZkrgOWfSVIHuJsGxCifStlGHsNaGcnKMMyg6PZWFCyPfTn
	A6Fn6twFWCgnYHwDbapY4LkyBepCurecuFxupXPnylc/JykQRtUY2WF7MOiiBMZl
	n5TN/2G8qfA7gfrtfkzZQYTPa/o+bYvQFZgb/d5XwQ1kaLgnFaZsAZ97ibAeJDkM
	XLMoYybvEYXPb3LtU67a3H78ptapFjxuVIxonQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730981496; x=
	1731067896; bh=Q7B4tITpieD9SOFrzxBIa2/+M2E42/qEwmR6TQaLLEM=; b=P
	iQ6Xz4HR9XzzyXvp+j4wSCVgwq/TqabtWhcMv7OR37PqVp7RmtbvlSQ4UDB9LmR/
	IuFdS1RWS785WTDfa6avL+UH3DDGx2NGrZfTjxg7RcmzmI0oP8ehD5+7cnPft9Y3
	6c9bkI4oIvaGNOczX38Omo4/a6CC2JIc719F/ZcfmMGx4FyrWdvO6SRgEPiH1Yd7
	GX4hapd/qCypi0N76UbIKhdOa/8JpY2vSSmTlXabl/nhp/pVe0gQWcp7P8vFc/ot
	B65jz/yIblHkFQPqv0CD0Us/QFwStgrNVOmAr+Lc2gJCSEj4zuXIbaa/kojUI2fZ
	dHJMK+AfdeoIRQz201Acw==
X-ME-Sender: <xms:eK4sZ8niDbDWsmgNYWivvo48DrW1p1e9bjM1mMV73PUMrF5IqYqmppw>
    <xme:eK4sZ71B7BZ4edEyotc04HU4J4AH6hLuuMEeKHyVtMs7kgVPnilH_TJZlKmCwBDE9
    ULCECPQs3pj_USDDw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdeggdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeen
    ucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvse
    hkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeefteeghfegfeev
    leeguddvkeetheeiveffudejlefgudffffejleffffeludekjeenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggr
    khhkrdhnrghmvgdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgt
    ohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehmvgesthhtrgihlh
    horhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:eK4sZ6ojRH1L4waCIS5XOqTEl4x9HtnPN15R21DN65GUitonaTrewQ>
    <xmx:eK4sZ4lXqR9Zy5gCBEDAnPTCSyIiPn3fJCkDWO-o0NthutbS3-sh6g>
    <xmx:eK4sZ60fT1yTNrkxjwtzVQZDqxBtMDDBkfq8IGetV6jFWtrHq-4WWw>
    <xmx:eK4sZ_uGiB74o0aZnAKa59NqZD8cRA4ArTZPz-ZPaiYu7lQddHnmQQ>
    <xmx:eK4sZ_ywXgis6CKmXA9WEd1GxRQkUlIYOf1aYzjujOPTWZA2L6nHRizH>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5710E780068; Thu,  7 Nov 2024 07:11:36 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 07 Nov 2024 13:11:15 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org
Cc: "Patrick Steinhardt" <ps@pks.im>, "Taylor Blau" <me@ttaylorr.com>
Message-Id: <4e68a04f-fb5e-49f9-8ba2-661027d8165d@app.fastmail.com>
In-Reply-To: 
 <ab7d4c8d89c075de05bf04f1f9dc195145455964.1729439476.git.code@khaugsbakk.name>
References: 
 <ab7d4c8d89c075de05bf04f1f9dc195145455964.1729439476.git.code@khaugsbakk.name>
Subject: Re: [PATCH] t1400: fix --no-create-reflog test and description
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I didn=E2=80=99t get the impression that this is expecting a reroll.  Bu=
t I
haven=E2=80=99t seen it mentioned or applied to `seen`/`next`?
