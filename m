Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A86D2A1A4
	for <git@vger.kernel.org>; Sat, 14 Jun 2025 16:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749919551; cv=none; b=AsjBN+zei0U9SiA38FwQGu1psJdbkBT2mmint8wSBfyhDZOSGbAPBMLrmLJJF1duDybukSFc9eLr1/aLIsaFLarXFawsaTBWGMSyiMR0+fb+Ft3IyVjfUwD3zAMvu+3gSr/uFdIIDNu8Te2O/fhmBEmtGtCiPMBOZqi5VGHY2yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749919551; c=relaxed/simple;
	bh=yY4wGV7eruJ1BRDKsjXjX50rphtg41P/a1FZRX9uM3U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UXbft9TAsQtTlDMvk+DcO17YM7gg5OZbjuvvBIrdl9o7l+T6wY2P/r7+tEFW91MJ6+LlVk6gle4D44luFsIsYyNTN7O1y2QQ/bFHoiOw3aSN5GMykplmLTCASlpe0n9BzckhEONOrAAxxotjPG3AXODWGqbXuW8PJI7agKMuU/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qIzrwsoJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a8mSvusC; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qIzrwsoJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a8mSvusC"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 230301380138;
	Sat, 14 Jun 2025 12:45:48 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Sat, 14 Jun 2025 12:45:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749919548; x=1750005948; bh=Jc/MaMPrZs
	XXrcdfaUpIYW0Jdd3RMqWoO+7UcbXPaRs=; b=qIzrwsoJzxRl3m/yPWMCiu4ReD
	xPt8Dt40iCaGSkfQAUOU2+r9/VJrqOl2fRR65SOx/htQZPrPuRt2tj78tyNt7AzU
	ioH5QPPg1DOvlwmZUAJvTEESTSFOt4px1tfmnjQIs2e4Ycnv2vhHUW98M3XiaPRq
	nPjCr9r5Vg81DCSJIgNhn0XOiAR0XzykgAXnV3L28mKbxiX5/9XlrqeA5hqrQzAM
	R+cX2RmM4JBB3JI5CpkF1uR1HYhwYrKOdH7omg5ROEd45l3wxsC4vO3QO2i48zA6
	c8mgekpok9AKKh1br9KwRssLXGABQZnFWOWeoCzKVP7xQf+jIQktsca8ABWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749919548; x=1750005948; bh=Jc/MaMPrZsXXrcdfaUpIYW0Jdd3RMqWoO+7
	UcbXPaRs=; b=a8mSvusCX5GLoYOf9HxrU+hMs/RqWYxx8c/vMHHqWnlX5WzIbl1
	ZU2OFGku9ZUOmYYdSgukhML8GGQCZlKD/hUmhgiKxzfyZMxfXuNPl58ypQXAqzkx
	UD8xMS2K3XbPZ2kZ233ZuqfuWvbirNZXuKHR2weRCXG85CW93+IEzFz5h7loIj/2
	0XT5y7lK49bqh3DTKrUWmj4dU8w8/7ggSm+Q1N5h68H0EYKzl4m5pHYn9mMzYSOT
	0tdyeuAEgtPk7LP7wP9r30yKwxaL55d6jYBpwQ9gBjAKdZgFxk7Q8bEdSna/iyM5
	OP28oMIojpuY0Fzvxr77NrBPpC5R4g8Mj5Q==
X-ME-Sender: <xms:O6dNaHcBth9W7NTgTpWRGxszEw-0Z8-K4RDbo-MILqJ_-2gJp2JaVg>
    <xme:O6dNaNOledkBZ4i214I7caT8fbuUqSDM22kv7fZLXf-U9-IjalM2S_ftREEoyXOcO
    d3Q5qr5i3LsN5R4Tg>
X-ME-Received: <xmr:O6dNaAiFq7OxWUozeBmbVDVY-UVGZlNNXpe_RIIAGYyTgXsdTcTZU8J9k_KLAeu4CCNkEvMg7cN383Te4uvV4ePe75X8RsdCgrZH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvudefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehguhhokeegieesph
    hurhguuhgvrdgvughupdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghk
    khesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegrlhgvgihguhhouddtvdefsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:O6dNaI9A0HHkN_WzQ2dAxM0g_hRPUmven2l3QULEXZqZaoSicnXgFw>
    <xmx:O6dNaDu7w1ETQ9nDy2LcaADBU6SwelxVj4SifZ4nYqqQdTjNY4KGNg>
    <xmx:O6dNaHFW2O98dIBmYc51yBPiNdX49OqxgcYLQuFmWVd7Eh0SQRczrw>
    <xmx:O6dNaKPlj5001OxZwwcpqBF4kWLuyT_Z30sevlGOKcsje3lobklk3Q>
    <xmx:PKdNaFRxFMO0oK6OmUGcbMy13BUJPviIAzGkcGheM8GsGWckCT-8n8mt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Jun 2025 12:45:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jinyao Guo <guo846@purdue.edu>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Josh Soref
 <gitgitgadget@gmail.com>,  "git@vger.kernel.org" <git@vger.kernel.org>,
  Alex <alexguo1023@gmail.com>
Subject: Re: [PATCH] Fix memory leak in function handle_content_type
In-Reply-To: <SA1PR22MB399911638F342E1AA20F014AE477A@SA1PR22MB3999.namprd22.prod.outlook.com>
	(Jinyao Guo's message of "Fri, 13 Jun 2025 19:26:45 +0000")
References: <pull.1997.git.git.1749833577767.gitgitgadget@gmail.com>
	<44066126-ece9-4c77-b38a-292b6f748955@app.fastmail.com>
	<SA1PR22MB3999874B7FD9FFF7D90C9F89E477A@SA1PR22MB3999.namprd22.prod.outlook.com>
	<xmqq7c1f8nr2.fsf@gitster.g>
	<SA1PR22MB399911638F342E1AA20F014AE477A@SA1PR22MB3999.namprd22.prod.outlook.com>
Date: Sat, 14 Jun 2025 09:45:46 -0700
Message-ID: <xmqq1prm6zlx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jinyao Guo <guo846@purdue.edu> writes:

> @@ -266,6 +266,9 @@ static void handle_content_type(struct mailinfo *mi, struct strbuf *line)
>  			error("Too many boundaries to handle");
>  			mi->input_error = -1;
>  			mi->content_top = &mi->content[MAX_BOUNDARIES] - 1;
> +			strbuf_release(boundary);
> +			free(boundary);
> +			boundary = NULL;
>  			return;
>  		}
>  		*(mi->content_top) = boundary;

"boundary" is a on-stack local variable.  There is no need to assign
NULL to it immediately before you return.  In the post-context of
this hunk, we free it but leave the variable pointing at a random
place after that before returning.



