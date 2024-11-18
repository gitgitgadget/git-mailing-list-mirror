Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F377338B
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 00:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731890448; cv=none; b=qAJdRApCMGCTAESssINw3EbUCTgzAGSyR8wrFqpCNYZbnXN6ybOpM3UlhRe4jkLefm1Oj7mp5eLf8juouC4TgwaU5Jlxv8P4zZwPKo7TKe/uVuh7sstuKmsxQ552G8U78rdKeObuVJC2+xt1OZV0AbaE1j8VOA+Tp8zey2aGSBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731890448; c=relaxed/simple;
	bh=0d4B3/NDYMjNd3NlQJAmlfvUdZo4OvH9bjy2wTo/sqs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hftNk62kQl9EsTLLAmx97zETorZsOGXmeUroNqShQqLFg0RYXRrIubBAkp2pXXvpywX8e5ZqsrKEVdtTho/HiLbc/ccOJoeKe0n1jiAP7ZozwsEqWT0Oh1S+KcAC+4GM+R9GXyA2MUufYRLlqmw3k9j7R2ZHonfPo20uwAd5Iy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OOwku/mm; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OOwku/mm"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 003A92540106;
	Sun, 17 Nov 2024 19:40:45 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Sun, 17 Nov 2024 19:40:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731890445; x=1731976845; bh=JE/K3wWRb181Aic/rrUeRxebLWY+8YuK3eU
	cpFSmi6Y=; b=OOwku/mmcYQOSdzxROyOYmEB7KfoBvvevLkg5UKlJZBCZ9GTeoT
	/9GLQaxUMblZ2LXJXA7hX27YQRaEqYgZu4wHIWEzr3L8azTXjbY5IlI4TBXmwKx9
	WT6Tq8+iQldjt8FfyQAmslJVdrZlfGtihL8BDu/jZlv0GjjiNa4Z+PlFIK9DJVy6
	SZ1FhKchZH5SQ2ZZiRmo2SaYwreD/dQrDg3kqk23QygoN6NI1iBNgdX/WlSrU/1z
	j5BZKVYB9A6FRWhgZGstXdFCQmpUxtzVYH8eCkRMMz/scatepyco6AZbco/pIyKp
	BNig7s4bJQTKm3RR9nVh8DerXqlETVr7w+Q==
X-ME-Sender: <xms:DY06Z4STONJLlMoeEpGN4-G96Yy5m0f6vZ1vsQnQJfhVztg_0Qqr7g>
    <xme:DY06Z1yDRRQj4aJBenUh_wyuzZLN2sh-QvmA43DWX8Ddcwy3kgopz-NlWJbwCNIHd
    FgMC6-qX3yaNzdfSw>
X-ME-Received: <xmr:DY06Z13uze34giO-KjMLnZNZmdfGgxEb5KmbsbV-evyXtvlEiRDJMHuycw1C6PKmNQSZfdLfYuBhX18wl45rfQ_o-dX7k6kdqBgd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdelgddviecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefujg
    hffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhho
    uceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepieekue
    efhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieelffdunecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesph
    hosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehffhhjlh
    grsghosehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhgu
    vghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:DY06Z8B3de1Iz-ELmwmARnx-CZEnnveQVjf4J_ba48hgQTB7FJ0PzQ>
    <xmx:DY06ZxhB3sV6sFxo3ESgUmaQQjXj5NgrSNb7HiFTfvUk4AWRceYU3A>
    <xmx:DY06Z4rjI0H4kArEbMNCSkXcC5VH1v2J1IjodrslBpH8wp3G-CCHZA>
    <xmx:DY06Z0hvi9yi-_YrTggdVTxgaAVdtdZoQ36BIXWimwrqO9hJf7yrRw>
    <xmx:DY06Z5icxqhvsPhqUouBuKqxltFjrtS__Tj_BESg8CHwiwVV22GyC6vB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 17 Nov 2024 19:40:45 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  ffjlabo@gmail.com,  christian.couder@gmail.com
Subject: Re: [PATCH] Documentation/glossary: describe "trailer"
In-Reply-To: <ba35ba3ec212860a3151cfad582a384a50c55e6a.1731871683.git.code@khaugsbakk.name>
	(kristofferhaugsbakk@fastmail.com's message of "Sun, 17 Nov 2024
	20:33:49 +0100")
References: <xmqqa5e2ahqf.fsf@gitster.g>
	<ba35ba3ec212860a3151cfad582a384a50c55e6a.1731871683.git.code@khaugsbakk.name>
Date: Mon, 18 Nov 2024 09:40:44 +0900
Message-ID: <xmqqcyitxtkj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kristofferhaugsbakk@fastmail.com writes:

> diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
> index 42afe048691..575c18f776e 100644
> --- a/Documentation/glossary-content.txt
> +++ b/Documentation/glossary-content.txt
> @@ -696,6 +696,11 @@ the `refs/tags/` hierarchy is used to represent local tags..
>  	that each contain very well defined concepts or small incremental yet
>  	related changes.
>  
> +[[def_trailer]]trailer::
> +	Key-value metadata.  Trailers are optionally found at the end of
> +	a commit message.  Might be called "footers" or "tags" in other
> +	communities.  See linkgit:git-interpret-trailers[1].

Sounds sensible.
