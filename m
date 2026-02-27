Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8EF364036
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 18:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772215722; cv=none; b=hIVaHULtPnJChopndaYN3ibSDPOhsY4ApxakkroCFQ8yuE8hFY/Sub58IgTBbm+wA3fwFYSyGVUDNqY4FgpWMKyxSrp8hETr2puhB4GicMI+PU8psBcnbnCWNQNbd6tMz0SyAXVtgEJ/g6El7KxFmKVKszHgaG9t4RDu2hF3f94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772215722; c=relaxed/simple;
	bh=svLPqoEMkPicD/oIBug++22Q5WqxojkUPLk+JG8IvNQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fEpte7ohEGrt4Lwm+hL1FcvihDwXZcvzl77YglSbuF+Lm00/CiwYM7bHk5uqXClY0U7WIxAByyPT4yA0yv5D8HP6RLEQhS+2iZ8ihbw6UKEAo0TR2KHXsj4irOE+Q9NqHGESdbOw6NuIMWn9oiKwWcikzRWS3UsSvl4hIRUWE9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=1A8FMrrQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wRicpn3O; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="1A8FMrrQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wRicpn3O"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 18C867A0089;
	Fri, 27 Feb 2026 13:08:41 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 27 Feb 2026 13:08:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772215720; x=1772302120; bh=JJ1n8ecFxr
	btgbUy3mw8RC/TgGgF0bF8VSfyr8JubE4=; b=1A8FMrrQlcJnRMOtoWAUtp7GZJ
	hbFOVuYiYLJSnY0IMTfi617QmILrRaQrm9l5/lV+Nv6Df0oxXgQj91toVJHMzqip
	CIjvalVpS3uhGv8tM1zQ12eDFIUNNbudPagCT9VYcAEl7LJ9+tZP/FYnPFG6NDyl
	HbkhfdXp5mjIqQ/VtPRJWPT35dvg6kWYNpYb/sgDYPGhOwlfbt2FumAjyBXeNJK0
	LnYA6MzSx5qDv56wQyJAlqGWFN2UsnnTLO4kT2dqen3DYTwLcKdc18bZXNbDx2Tf
	XvFzXdXyYx09LXav7djvd1I/gB/RPzjf1Gyh7eccgqAvJ/+QkmFkFW3EAwpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772215720; x=1772302120; bh=JJ1n8ecFxrbtgbUy3mw8RC/TgGgF0bF8VSf
	yr8JubE4=; b=wRicpn3OkwFj20bhqpgHXtWxRdBQx8NwXoRnebXcmJYpailfnMH
	+WrmADpHG5l7N1COl1G/wt1QVBpRnGSiDj5IN4Yw7f9lW3cdW3X/WJP1Rq/QqipV
	Rl6OvkgFPmc/SgBAaLXGyX0q/URs4nyGcZtSsc97iprwxKMatXihCYLKy/D10ZaE
	1KDQz9ByFal6PPiEb/ab23BYv83OFqCr67eVTf03byOfZ7BLWLAE+M11Ih+fv7jT
	e0OUf1Q1LHDpDh4N+JoTfsZp0TwI9hE/7hM4fZXDBxiyjFfv7UT3VH4OqSHGc7u4
	uHZWwcwHmChcEIjI241GhnRKnry2JxApiMA==
X-ME-Sender: <xms:qN2haWl-spDSOAsXOBzuKgvhRNKdOvDJWpsPZu9CbHHgOcrfuooDHA>
    <xme:qN2haVQgMEJT9ko61hi63weJxqB0n8Sh1ofMuGRP4v-PV6p6wsC2jDyLi_H70kdCA
    Rw9NWUkSF5I6gj-KutCnVDr3fBUeKb3k3gSTSSSE8OkxsJeaNN106M>
X-ME-Received: <xmr:qN2haSBEd0UXCK1fa4GWexJ_Q2qW-j4OlLOyGKIFNFexl3NFpGQ1Aysg8pMj20IHPcMDjVph_H3oSl9Ppbsv4GkNmpuXiqd7qg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeelieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlohhrvghn
    iihordhpvghgohhrrghrihdvtddtvdesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:qN2haURFRzE0uYBp_iKH5cbTsdNOjq3yhAEnlDYRxGwyfzYAD-Wjaw>
    <xmx:qN2haYoRpUACdz1_Zp-Ssh5gvXG1Xng6Re7zXinCW0Hyb3X6lNZeyw>
    <xmx:qN2haez007UusVPxEetQN4RDJuueVhguWzIi0aVny3IkWRXGBq_S3A>
    <xmx:qN2haVJarrhw8waH261NCxxJvQk_U3d7bmGU2emNHy90josP576wZg>
    <xmx:qN2haZT71Sikz7g2vZ2MKnNW_bu9DUEGWo_salWQewEsfWJ8Hxva8Y6M>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Feb 2026 13:08:40 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [GSoC PATCH v2 2/2] t4052: add test for diffstat width when
 prefix contains UTF-8 chars
In-Reply-To: <984fa10d728aad049d0430472e85f1ed0e5ea4de.1772136203.git.lorenzo.pegorari2002@gmail.com>
	(LorenzoPegorari's message of "Fri, 27 Feb 2026 17:08:12 +0100")
References: <cover.1771894207.git.lorenzo.pegorari2002@gmail.com>
	<cover.1772136203.git.lorenzo.pegorari2002@gmail.com>
	<984fa10d728aad049d0430472e85f1ed0e5ea4de.1772136203.git.lorenzo.pegorari2002@gmail.com>
Date: Fri, 27 Feb 2026 10:08:39 -0800
Message-ID: <xmqq1pi6rrdk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

LorenzoPegorari <lorenzo.pegorari2002@gmail.com> writes:

> Add test checking the calculation of the diffstat display width when the
> `line_prefix`, which is text that goes before the diffstat, contains
> UTF-8 characters.

This does not want to say UTF-8 for two reasons.  US-ASCII is a
subset of UTF-8, and more importantly, most of the problems
miscounting the display width of the line-prefix part comes from the
fact that ANSI color escapes are 0-width but consumes strlen() bytes.

Curiously ...

> +# git-log will print only 1 commit containing a single branch graph and a diffstat.
> +# The diffstat will be only one file, with a placeholder FILENAME, that, with
> +# enough terminal display width, will contain the following line:
> +#     "<RED>|<RESET>  ${FILENAME} | 0"
> +# where "<RED>" and "<RESET>" are ANSI escape codes to color the text.

... this does say "ANSI escape codes to color the text", which is
exactly what we want to say ;-)

