Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921CF192B81
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 07:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733210895; cv=none; b=VAWYBJpRZ07IK6ZyQqvJScfgyqX9UKOGPMVLoJzVyZncwDcSsE3K0Fp5hj26I6S1O0wwmaSQRpZ0GPv9gF5FQBilmbUlnelhyuu4OFe+iZrafejB6pWWOswOpusPQe133+RoEGvtp5HPOS3BS90wCbBp/ym3WFvMXaaSKcgGIyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733210895; c=relaxed/simple;
	bh=56W/7ZQAX/fVR+iwQeows8DV3lJDwuO1NhBFZ3hpNG8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IwbI1fD+kmXTDLj0AGgIa2zDUipmQascM65OsIT2MhmZqWbgSoHokCXNnG7p5N5nEgxKID24XdCay2Uw7xeTQbo9rKovdnlSIHfNRETJ3C5v1UC7Yq1y0FIFAdBa0I8jX4WkDWk4gani8TYnmL0PUhZpsloUsnBN9VUz7XSxtyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B1eP05fq; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B1eP05fq"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 93CE41140137;
	Tue,  3 Dec 2024 02:28:12 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 03 Dec 2024 02:28:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733210892; x=1733297292; bh=kqWPa5R6O5tmzcffIeKK7d3kf31FKRqor5y
	iDrUvMTE=; b=B1eP05fq8J/F3RXs0KWu8ymmqzalzPdyYBbtLUOFN7mKzTu0RdI
	yM2cKl0xYggd9w5aIn+p2tUT6gZ8EqgPP9ZevGfNLSkW2c37L3EWCwi5Xvr8mt8H
	kMpP2+WJB0kvO/Zrr8psJmzMRRbNxOe339AYZNXJSbaXeu3991ZjkybKvgfuAwgO
	x5onc83WupqFJxxCVh5oo7SSBosuqOF+HuPfb0fkaopiDKU1GXl0qnje6aZJx5si
	trvYB0IP/rfrbxoa3tG/LjUKgvciUUC9wnZ1R2OrbVaA50g46aSZWvyfsEyPGQ2z
	i7iD4DjpT4xz13LS3tyXF+1z/WhaPcrHjaQ==
X-ME-Sender: <xms:DLNOZ29YXTg8c0yUZSLWsxuuSGr6cbM0VqwlQZnDFo6mL4mLbuWGgw>
    <xme:DLNOZ2t9fO3lKD1CTM4ZmuRC3msHfNWBsJnTTOsaUB_kmvh1jATmNuCcfCP-IcUZZ
    _vwxGTtYTJUUBtDUw>
X-ME-Received: <xmr:DLNOZ8Dgs1bpORbx3Pji23VvD03oQd6QBAwfYQIrGhLMsrV8IePFAoys8NZhFfuXh62RkajXRsL3r5v3D1c9lfBpor50ZIkS5Wg70aM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddriedugddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvghnsehkmhgrthhsuhhirdhmvgdprhgt
    phhtthhopehjohhnrghthhgrnhhtrghnmhihsehgohhoghhlvgdrtghomhdprhgtphhtth
    hopehmrghthhgvuhhsrdhtrghvsgesghhmrghilhdrtghomhdprhgtphhtthhopehpshes
    phhkshdrihhmpdhrtghpthhtohepmhgrrhhtihhnrdgrghhrvghnsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhlvghntggsiiesghhmrghilhdrtghomhdprhgtphhtthhopehv
    ugihvgesghhithhhuhgsrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrd
    gtohhm
X-ME-Proxy: <xmx:DLNOZ-edZnytqzheMd9SApihhjUsbWj74fq9ONmfzfePvl9KBpmzQg>
    <xmx:DLNOZ7OJxkiY-OtZOqEHuBD9XOSLsql2LiXsVf-SsOfJGe9OuQj6NA>
    <xmx:DLNOZ4kPKggxf9DUTVlTSVoV8K1_39y_VwSJhnXK5f8--a6MyouQog>
    <xmx:DLNOZ9tEx9Z1fwBnqQHqW-hlpsu5nkX_m9lOaScnY6yQ8zKcB_bzFA>
    <xmx:DLNOZ8Hu_hymYNWMxNpJKXqoR_M-xrjkIEkbJFbkS1ySvECEI_5ObNA6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Dec 2024 02:28:11 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Ken Matsui <ken@kmatsui.me>,  Jonathan Tan <jonathantanmy@google.com>,
  Matheus Tavares <matheus.tavb@gmail.com>,  Patrick Steinhardt
 <ps@pks.im>,  Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,  Glen
 Choo
 <glencbz@gmail.com>,  Victoria Dye <vdye@github.com>,  Elijah Newren
 <newren@gmail.com>
Subject: Re: [PATCH v3] config: support remote name in includeIf.hasconfig
 condition
In-Reply-To: <20241020173216.40852-2-ken@kmatsui.me> (Ken Matsui's message of
	"Sun, 20 Oct 2024 13:32:16 -0400")
References: <20241020160143.92382-2-ken@kmatsui.me>
	<20241020173216.40852-2-ken@kmatsui.me>
Date: Tue, 03 Dec 2024 16:28:10 +0900
Message-ID: <xmqq8qsxcjjp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ken Matsui <ken@kmatsui.me> writes:

> Changes in v3:
>
> * Updated the description based on Ramsay's review.
> * Added more tests.
>
> Changes in v2:
>
> * Updated the description based on Kristoffer's review.

This has never seen any serious review since its original iterations
were posted late October.  Anybody interested [*]?

Otherwise since it is approaching to be more than a month and a
half old, I am going to mark the topic to be discarded.

Thanks.


[Footnote]

 * I ask because apparently I am not interested at all.  At least
   not yet, with what I saw in the previous postings in this thread.

   My take on it is that the "if any remote has this URL" change
   earlier did make some sort of sense, but I do not see the utility
   of this change.  If we need to access both of these two remote
   repositories, "to access github, we need these definition, and to
   access k.org, we need those, so include them" do make sense, but
   because these include do *not* limit their effectiveness upon
   which remote each Git operation accesses (i.e. You cannot say
   "use this configuration setting while running 'git fetch origin'
   but use that other setting while running 'git push github'"), it
   does not make much sense to say "if 'origin' is X, then do this",
   at least to me.
