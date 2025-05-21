Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406721E2848
	for <git@vger.kernel.org>; Wed, 21 May 2025 15:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747839645; cv=none; b=VBBlBBPIMMmjl6lQ9F468e0SEq77O30zqaHgcUSuE3TUB0sDz7xDwuuR6rPVroJuYXftusFqUbNYtCF2hhQKXrz9HQRSw7tLfvU6nJtKf9XUUi9gMV+7DuDr8VDN6ASeEz5Oqbw1qi0LnsTqm0WSkVCeIZUkLvpP3qP0iYhPLYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747839645; c=relaxed/simple;
	bh=kYFu2Kua+WhRZyawO44r/LROsFwxMDEl8zsYHrwBoHM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ca5wiaquBJzD3Jk7f4ly66jvm6B/WuNUhCKnucIlGOAHhWlt2Q5yi9VRKYKmtwsIqSMwwsx7kNqYB26rWVgNkzVO8pWT12+sYVEDxSphne7KAO0wKlbbrKrv5mwWEOdM886XElrTSX09VsVA9d9lj6nt2Znin62Oku4lZ3taMqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RfyLW7Jh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Aad+HAPR; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RfyLW7Jh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Aad+HAPR"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 301EC2540167;
	Wed, 21 May 2025 11:00:40 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Wed, 21 May 2025 11:00:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747839640; x=1747926040; bh=kYFu2Kua+W
	hRZyawO44r/LROsFwxMDEl8zsYHrwBoHM=; b=RfyLW7Jhds4GqkFHyk1OfzMwll
	Fjc+Dm4V8qB3f9moTx91MaQJ7tIfE4TSXufovrwUFy3QQpqFs9gUutgeW7tD4f6X
	cS4rWI7VH1AU3fNZr73J661EW5/JR2tB1gF8k3p/UNzca5Ar7H67bz9noiesLLWN
	VyvY1IO/Cqx2isZB/IxXosbRnFXyTsKVgAxIyp3VvFMczXfEv2yFyepYKiSYH9e0
	plbG6ZQFXM77rNvxYuiqwAv0E1eO16LNleXIs9lKb0BPegXo3D0rrW26h64kCVgX
	ZDG/+Wfx2seMtrmRB9KDw6z+cmRLRbyDq6F/Im+aWmgRI9/JjpeW5tKKhcdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747839640; x=1747926040; bh=kYFu2Kua+WhRZyawO44r/LROsFwxMDEl8zs
	YHrwBoHM=; b=Aad+HAPRGBBfWWIFu2CwJHUpfjc1ueEGT4zoIH/Ols+JGnSHJXS
	JWT8IfxeSOxpZPDEPhxckf1Iy48YakamVwQJI2zwyLdEW6ayyRXT1HO4LmJYhqL8
	8MywnCJId1WOff8shyqSjrxOJqwSpie/G0Wzqc6BfFeSUJ1VKkKcb5EhYHB74yrO
	6w3lOwqNc6TahpZ7qdWrOrqnW+SaNh0E/aFHYhaRDHUMxdPZlJJ92WxYoiXi9mgC
	urAxd9o5YU2u3BWQft+yX9W8dkK9W3OUCOKAQtj9N1A/1kqvaYF62FdWJvyc2Kr0
	+udn1Wy4hPtsFyV9oL+j6OMSQDEA5nXzSkQ==
X-ME-Sender: <xms:l-otaF3EiHoege2oS0p4FV66K6bo4OvVU6NEDImpWjEJcZrYc_YSNQ>
    <xme:l-otaMFFWQBEeu2uVubafKweQDi_4SGqcoJzd6YMQAwCcLLlQ3LeYJO799G0xt4JK
    Ingv5htJ83s0kHVCQ>
X-ME-Received: <xmr:l-otaF5x-v3Ijfp-oJCsLUrSi5JI-D89Zu5aNSjDfx6HRSUMKaSvufEAdYu9CZXbljg7_sHEJ5MvPLP2QVoVxfFSWBOQLUoQRYkJXKc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdeffeelucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffffk
    fgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceogh
    hithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeeh
    ueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosgho
    gidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgt
    phhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtoheptghhrhhishgtoh
    holhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:l-otaC0lCHEf52Yl24P8fWUz6A7Bz5EabufIfUAgddz0xnAvRNArqw>
    <xmx:l-otaIEGnvk6m8nn6NCNpnB3oXS-3gcB5Phm7XAGCJzu46NjEekBuw>
    <xmx:l-otaD9H85-z9pbyugn2Ob2prYWb7N541idQsFXrsIwl9sBKELabrw>
    <xmx:l-otaFmBSW_DMBz8MZ8bmyG7phCm0Ue3Z5uh8ovZ43xdhwJchJz2OQ>
    <xmx:mOotaDzx4nCKd5FJbO79mbeQKKYxRg6Bi79P45zXY34oKuMd_eluoh7O>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 May 2025 11:00:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,  Patrick
 Steinhardt <ps@pks.im>,  Taylor Blau <me@ttaylorr.com>,  Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 1/5] promisor-remote: refactor to get rid of 'struct
 strvec'
In-Reply-To: <CAP8UFD25fF6OdYmP54JFyY4Znpij=MR1ifdWk+cjca5Hes739A@mail.gmail.com>
	(Christian Couder's message of "Wed, 21 May 2025 08:33:52 +0200")
References: <20250429145243.992252-1-christian.couder@gmail.com>
	<20250519141259.3061550-1-christian.couder@gmail.com>
	<20250519141259.3061550-2-christian.couder@gmail.com>
	<CAOLa=ZRnL_PLVpQrmHPMXtJd9e965B5iz8widkk5GNSDvh21Pg@mail.gmail.com>
	<CAP8UFD2XtyPD7b=sE+t9d-kyXDt4hYMqVotwz7hJZEO+5TfXGg@mail.gmail.com>
	<xmqqr00ji63l.fsf@gitster.g>
	<CAP8UFD25fF6OdYmP54JFyY4Znpij=MR1ifdWk+cjca5Hes739A@mail.gmail.com>
Date: Wed, 21 May 2025 08:00:37 -0700
Message-ID: <xmqqldqqc8kq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> I don't think it would bring a lot of benefits. Using an strmap or a
> sorted string list might make things faster if there are a lot of
> promisor remotes configured on the clients, but I don't think we are
> at a point where such an optimisation is worth it.

What I was getting at using common collection types instead of
rolling your own linked list was not primarily about performance.
They are more battle-tested and much easier to readers who are
familiar with these existing types.
