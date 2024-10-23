Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA68B13AA2B
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 20:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729716693; cv=none; b=pC18DFexAoOjUIR3o9PYgJttczeu44Nw+mL1fzRoPqbygPCiHAxowr8AxQULklpvZaBgxpyvT9ewDTh3qhBFXnGIu+qcPjgqvPlaF9ZhbYila7bEaDuIvtMhCZW72Hhi6GODWNkfS3b0W6lWLrbNNO5IUzZEvdQ3GGMO0Fo9jYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729716693; c=relaxed/simple;
	bh=494g0TiMslNJAYqzAmhiZdNP7V5knDhGv5IJjKcrtRo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=txRLBEBYDRSI7jsjOZ80Z5fNpCeyeINnvfuyplacVFx0cTpTK1qv7gys6NlCHmafIpZHZFdxd+z19cexuKRuT/bTA5Yo9e7p/Xw7pWeMM01PZa+UUHtFKFLSsYeYjWrKusYaqc0pwQXcOvy0Rtb9i69WggljaIUflLVOQceWo1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=SoTIgHEo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YjAXQXZv; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="SoTIgHEo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YjAXQXZv"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DBE931140162;
	Wed, 23 Oct 2024 16:51:29 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Wed, 23 Oct 2024 16:51:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1729716689; x=1729803089; bh=494g0TiMslNJAYqzAmhiZdNP7V5knDhG
	v5IJjKcrtRo=; b=SoTIgHEo/JW2GH+NHV75nkzr3kpU0Az9IznYIgfa1EP7Dbsf
	oiFN1Z3P2Hcnsy0dJ2jAOfLQUw2zl+SfjMOCE2S7O0BANI8BzM74g5V9XP3RU4C/
	cWoeb2zxJssuMZapnxlV4Tp6xQ1E7nGzYEjVoCvNpK3w5lPObel7eq4lFniwlwQ5
	k9D9w1pXyJ65tHUJiUWb2qKpFVlnFj/caFSZ7I4n+bY2dHpOhFeKr+xPz+oD4cVF
	RgZtMfEwf8/q9hj0Y/liJB1NjMiIqTBVwyZ8ZXx8cf0JQ8RemF412VLvc86qLvpK
	2oU7R0QBGnqvIBwx84nbdRaJx6TypsTCzY9bEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729716689; x=
	1729803089; bh=494g0TiMslNJAYqzAmhiZdNP7V5knDhGv5IJjKcrtRo=; b=Y
	jAXQXZvxNv4Rry7VisJ8mshwgYCDwxqMucWIfcIZ8O+bi1FT5ptJOkHhCCagUuvU
	dROCb/k+h/8IpQ/pszRHj6o7J8REDGFwaB8q4N0HLBz+tga8b4o/HdYUwTV1spyh
	gnlt+drwPpYEJGPJ9b7crXDZoqqMHUSa1xaRk3i8csTMdDjHkmhpTtwadsq1o/nw
	n5wh0RnQ4y+57ubJj7bYAegxNXUIu3bh/0qcivt2rTUwimAFm6bAVFCVb5KPF0g8
	pa3KRa4r74PcnjB/mrttdYQAJCKZws9g+JKmJ8C8Q1Y73M5a1ZtGc3qoesP1NvvP
	PvxfDSq4CV1wFioNpAPZw==
X-ME-Sender: <xms:0WEZZwWSwOHaGA8YgQl0ZVW_atPd7olzMx4Hye6bPYPAb861c-cqB0w>
    <xme:0WEZZ0nGwFysKYu1ESOoiCFvGDfuUFAT6VNKSPFjIVWCJ2h71tbXfk7qpHDO4iyQp
    DchidKSgfeoQ94uFQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeijedgudehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghoug
    gvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeetkeefudeh
    hfelfefgueeivdelledvjeegudejgfehjedttdevlefgleekieevveenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhs
    sggrkhhkrdhnrghmvgdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhl
    rdgtohhmpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:0WEZZ0Zb5sBOShAKNUJS1rlGsZnYz8zffnRe3yNN9wU0qqFOvE89Aw>
    <xmx:0WEZZ_UsgTVU-TPkLGIOEt3VgRtjOEkAUoD3m54baf3OJ2jXxrigaA>
    <xmx:0WEZZ6kGhPqwYX-zA_68wndEzaJhx9kzFlDjR6oUckkt1S2h0HfPmg>
    <xmx:0WEZZ0dI5Xp972t-HLA7t2SFMeEbmEykA60Gw-QfbUKCNB2hyzqSvQ>
    <xmx:0WEZZ8jPXbDyUL6KT5hFglL8jv_BnmpNeJYXI_oeK-8AZ4r0ZUJswK5m>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 87004780068; Wed, 23 Oct 2024 16:51:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 23 Oct 2024 22:51:09 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Taylor Blau" <me@ttaylorr.com>,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, "Derrick Stolee" <stolee@gmail.com>
Message-Id: <a6fe12ca-1736-4d34-aa8a-d0cca0fa5516@app.fastmail.com>
In-Reply-To: <ZxlgDqZuBbwqXMch@nand.local>
References: 
 <5267b9a9c8cc5cc66979117dc4c1e4d7329e2a03.1729704370.git.code@khaugsbakk.name>
 <ZxlgDqZuBbwqXMch@nand.local>
Subject: Re: [PATCH] sequencer: comment checked-out branch properly
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Oct 23, 2024, at 22:43, Taylor Blau wrote:
> Perhaps you may want to rebuild your topic on that one?

Sure thing, and thanks!
