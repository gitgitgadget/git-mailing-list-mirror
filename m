Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DEA2F7AAC
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 01:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767578088; cv=none; b=jJF4MsFa6U1/81XbZGldqiGGfe+VxyowxaBrANa1HBeZqHfff34xYjoboZv4Qn1TBLvvHSmQbMTQFi66aVdyTY6+nGq/XLkkank0wQVxXsOD+FMOcRtV1gVG+gCdDUbNxTx6Smo6231xU/rfA7/7MqIAC3tIiVL0HlbbNZocJps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767578088; c=relaxed/simple;
	bh=l4PN1eKQ/b9IEl6+I/5jkRXffgpz4+doeau1n7gTG9Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g2WiZXCsk0v9TPdbGRHNzcLgHQiJikqLX9/cvvV3ifkroTF35FZ6XZNspJsNodvy2TzJ5ubd1lliuVCG442s3EmReuLr9ry8/LhvVRiSV9iov0mDmnmzp+rK+JTmS2JUrI3W2YdU1RCcXnQkFmWIKuMSQ+zUhOoiJ3/D2evDzQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WuKvr753; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=llDYLSfw; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WuKvr753";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="llDYLSfw"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8C6737A008A;
	Sun,  4 Jan 2026 20:54:43 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Sun, 04 Jan 2026 20:54:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1767578083;
	 x=1767664483; bh=xSDEIeDiMncN+ouNU4sY487ch8NElu6M+UTgrqE8q80=; b=
	WuKvr753HIUG+i/cOt2aLFQUD9/2imuah0c4KvyE5X97cGxcCE8SA7nisSez43Yi
	KKby8vW3m8JMq4QPgAnssH8ISuHdJH7CmeFU6Zh02SB9OIGzrAyYlZIJ5XOlw+lm
	AAh47yTAQvbke/1/H3IUisAIJtOE32NnMXRjUqD1AqurWjGoIg04qui+VJA+vKa6
	4ihXsUrZTQ9VXd0jnPNIAufln1F+ennil+3ztf0HM9oR8zSzXuciGw91WpuND5Su
	4xBCaKrTqs/2ACTYEf/CJDPnXJMGvE9lo69Q/nefqUtrv4CRISbN9NDHlET1WhRo
	eOLJktb6pn5mepr6gMOxbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767578083; x=
	1767664483; bh=xSDEIeDiMncN+ouNU4sY487ch8NElu6M+UTgrqE8q80=; b=l
	lDYLSfwPa0Rs0JvgEZJG0OSYwz3YLYzJ2ayqQdTubOxIfrz7vpYqTBW6J/hV6yH0
	/Sl+K05Jj7EKXugUsRgp+Dhjuj+kXcA0EHOd57XTl9dWIi4TbiMtS5erjlG6pKL8
	e4mNmhNwLUOqQTVbeTqys+Fpu50IUtoSc6/NQeXG1TxptJmEaaws2N94tyBzBAhP
	Kldy2uHWaA5wcnEO3ACj0yxs/m4GoHSas8fk/MrHdo/XQ2S6hPtDFAuoJgJFNRJn
	Qd21g4Ot9pUjv/MQpRsBAu+9hjmuVGMr/5fGnnW7Mn08RenG7EvdHogBHEFLYYOf
	x3ptjlSiJAJmWtE0ax5/g==
X-ME-Sender: <xms:4xlbaXpER98KSBLO1Z2SqlPYZnM5K_Hymu4vP8-9rjdtrhw7mK94mA>
    <xme:4xlbaZZHIO4ZmKo5OXxQ0TnUjoXjJtGdJcwfiUEXQ-ppNJyivEZhEou_mh_-RFXUi
    hf8ha6Y9TOtyN3fPO4FvH-frBZee9KHtSubXa1ISQ02joPBsROErQ>
X-ME-Received: <xmr:4xlbaXS6uOAhN_cNf527vdgItLNfLw5msU4HHlRE7lebdsrHWFp7aKQhTLYps6yOXsfUSI50VhRcJvEKubW--bZpJL_V32UcgV7_UeQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeliedtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgfgsehtkeertd
    dtreejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevle
    fgkeefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehm
    ihgthhgrvghlrdhlhihordhniidprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:4xlbaY4crSubHwDULtEka7g09MAFMKM006TBG6PR4RwXyG4tJipoeg>
    <xmx:4xlbaUzGFwV9OGgrwbkGNGdropwClj05PP5q_5H-JsuEzgeGyNFFpQ>
    <xmx:4xlbafR2hqBLPptbKXacWzYGyAHMNPiU4lMuJWg55OMmdy_mroqxSA>
    <xmx:4xlbabXr-db78rlwt4Q-H0vtbk_2k9U81hglzdv3fPP-UW91j_UCCA>
    <xmx:4xlbaUoy1TK_Dh3Ey_E3MuBikyh2hmEQbxTyiGJbGQfWu3cEw6eV1h7C>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Jan 2026 20:54:42 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Michael Lyons <git@michael.lyo.nz>
Cc: git@vger.kernel.org
Subject: Re: Documentation options: Code or not?
In-Reply-To: <2076768.usQuhbGJ8B@debian-mbp> (Michael Lyons's message of "Sun,
	04 Jan 2026 13:04:09 -0500")
References: <2076768.usQuhbGJ8B@debian-mbp>
Date: Mon, 05 Jan 2026 10:54:41 +0900
Message-ID: <xmqqikdgn7ry.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Michael Lyons <git@michael.lyo.nz> writes:

> I started a quick commit to drop the backticks from rerere-options, but then 

The current trend is to mark-up even the individual items in the
description list correctly, so if you were to help improve
consistency, you need to go the other direction.  Look for messages
in the list archive by Jean-Noël Avila, who is the primary person
driving this effort, for examples.  Or picking one of the resulting
commits randomly, see f7316a66 (doc: convert git push to synopsis
style, 2025-11-19).
