Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50227E0E8
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 23:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733268251; cv=none; b=HiwtossVAZsFdUa5+yDzeMhMBeHKEsdm2bhuIPdL8d67xntEpqR8Y1bRqd65c2Xjc574Aer6OBEY4bggsTt9gY91Q1EITkDayLjKzrOV4HaoyX9V6ZTMqQhHGzT38qeBh3zz/I2J2xZ4SHMNz3LIlPzwI9hrLgnHBob/A35atSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733268251; c=relaxed/simple;
	bh=EVsG2RXXSYH0ObGIo/Ao+BV4H+t4yaWsqcUJl5Pghpk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M9RCmol+7ovsznqTsfgm8p91zacFatMPH8pqMRiOg6O7u9reNKEHmirsFu3/yBkVF2YJSA6WIDR4ws2h1xNAMkP1AbcLhFKe0sBN9u6pO45xDJ0r+RG9iJaXf+MobuFjO3BrTMiiCcr/LgJj0TOzskRVaviGOcJoo0AaXGOS1Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rb9WpJB2; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rb9WpJB2"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8A62C25400D6;
	Tue,  3 Dec 2024 18:24:08 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Tue, 03 Dec 2024 18:24:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733268248; x=1733354648; bh=8XikRzh1K0hsc/C5mWW+PnUgkzNQqgVDKhh
	lG9BCTl4=; b=rb9WpJB2Vjvmr/TFfgUv7Y3f/OASX0l/oBfk4dKbUMnpgGWV9Uw
	Ku57IFEiZa3NUena0iCXHo6CT1/K+zJ3w9ORR+t9Aae7K8BADEZI71mc4OcpoQD9
	dnH4xMFMuKsBg3ghCkFu3QpE0IbAEW5BCFtG25ODKCU4Fj5uMHjIBQXhv/MaCqUG
	Ab7FDCfiza85ZutFtQ97jhML4P3yGZs9vErP67XdW0ntvVeiGaIb4np2fFvBvFTa
	2aSHdQhUbSPylGoWRjA/Q6YI0IjdwRvZm9gXLidHqDXxubIlKJYyyUa9oOCE/UQC
	tHeVWcvzYzgAwGaH2RfY13xT39vZAZlT6Dw==
X-ME-Sender: <xms:F5NPZzWl7K_fNhENlqbSINWk3ddITm3q-AfqLWWMGiBlYxH5XsxHAg>
    <xme:F5NPZ7kRAg9uhr2YgEAGBsUrYa-wBKJGjD7i5tKDBoVhyMbAH2x6oHeH5EoP3KHYD
    3Qxoi_M-cBViZnbDg>
X-ME-Received: <xmr:F5NPZ_YZuvvlseXjXEHrbswLdfBWM9fCci2eqjiRDb1HqTI1jSUkHr1jwvyusdJgjgrssvg0eFfHldDsPqVhy6mIApDZxXnYpcnEsC8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieeggddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrh
    hhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehtohhonhes
    ihhothgtlhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepkh
    grrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:F5NPZ-V9O-lnC34Qh8P352E7d8eVMfS2hSuTBy2Lq_ndXDnVzt7nzw>
    <xmx:F5NPZ9kc0KJcrz1BVcRF3XLbzXGdr1VGxi4M7UKKIGyWuWNQJ5RfSw>
    <xmx:F5NPZ7faeZOrVb56qZoDy2VW6zeBYkyu3aISDZvnIs3YFrK3IZp4Yg>
    <xmx:F5NPZ3EbtApJvNugvA-T1hTbkStiqrliGUxI8ypggxkGc58bgujlWQ>
    <xmx:GJNPZ7bB0esouIrOufnTE1krABcd4jdVBy1kKq0GOkkpx1NCjs7HsYLb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Dec 2024 18:24:07 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
    Toon Claes <toon@iotcl.com>,
    Patrick Steinhardt <ps@pks.im>
Cc: "Karthik Nayak" <karthik.188@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v10 00/10] packfile: avoid using the 'the_repository'
 global variable
In-Reply-To: <14f1ff64-bdd6-4233-9358-d56eb64a2d57@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Tue, 03 Dec 2024 17:46:41 +0100")
References: <cover.1729504640.git.karthik.188@gmail.com>
	<cover.1733236936.git.karthik.188@gmail.com>
	<14f1ff64-bdd6-4233-9358-d56eb64a2d57@app.fastmail.com>
Date: Wed, 04 Dec 2024 08:24:05 +0900
Message-ID: <xmqqplm89wq2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> Nice, thank you.

Yeah, together with a few responses from Toon and Patrick, this
topic seems to be very well done by now.  Let me mark it for 'next'.

Thanks, all.
