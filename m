Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACFDA920
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 01:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732065786; cv=none; b=DRxZ0ZG13E9/0iasqlObOanpq8i+xZr6B9d6hgK0k1+vPJdZpoRXiFHssi13YIQAAg/TQCemcT38rLCZ/2tJZXzc1IOFct1wEBefUMy5GKFOJEc/NoRKKNwIzrGtC+fF2uHw5zWIkqytd7x3kWEAoaw+F+K8Or4u/wR/UCLjDo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732065786; c=relaxed/simple;
	bh=8QpcHDgGw5Z2PMyvuoHI9gixNdQ21LcL5H9Mp0PP9d0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kYxGACU+j9p/DukkSmGkPbd4uV6jgV08mjn6CgM+KISXK6/FfoseitVVoX9yzFko6eO5RCFDKuwFtIBX3Qg042kNLhd/aSgr7ccU4CURR6zr8ydfXorWr0DpmJ8ekX8VBJssMM81WW1DYuiiACPkn6sJEjmWWrKMa9IVc7bbM04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l0IQ5GyL; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l0IQ5GyL"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id D45E4114015A;
	Tue, 19 Nov 2024 20:23:03 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Tue, 19 Nov 2024 20:23:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1732065783; x=1732152183; bh=Qcnv5acv4t14APlfjACG15RUSCxoJG622+V
	orPKTpQE=; b=l0IQ5GyLxADO19RMX8Jl5zaAcT/hIJxBdfxDJOe4jv3wUD/s6Nm
	sJmmT+aQlMpF/uFXu8BEshilETN0+AscOmsjZuqy82+z9jRe1BDJxtbNgm8UQQDT
	IjBxt92j0X6HX1tWNTTlzwPI6ERa26o/z8uayHHosKKLJsbjQRvO0WQLSIITaksH
	w81EgMepYxF6dtXythdeTZ6p7QS29gGHuRogCYRXQCsH07IQjBJvY96UQRXZDLgh
	i1G0O8pfg7npaKskeQ7qu90wL89JECa62dLEKLVqR/FMYOFn1Z1JQ3w7rQn2AUYI
	QEk18R+0dNBFRF0G4N3sB2qeuRDEAHVPFRg==
X-ME-Sender: <xms:9zk9Z38UTTIoHoyKSyBylf6nysThgpWZ23kzxKsn84dRE-1mEtdfdA>
    <xme:9zk9ZzvwRfpDDkja7zAhOmrXm7xc5dnFuP1wgF5m9Ca2DZApJDJN3luhbiP1MzS3M
    HOm2TmJTd6o3hbFmQ>
X-ME-Received: <xmr:9zk9Z1CjYP0N6DIvf6jPaMy_0Bufo8fdXaNkQWaRyKAzUzhtpbnvuF09fNVJZhiHOByHO8JziFSzL2tXVMo9g1WcFmIWjzeHfkbL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeefgdefvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedv
    udegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifoh
    hougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuhhsmhgrnhgrkhhinhihvghm
    ihdvtddvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:9zk9ZzfVgufR02rahZhpF5kpdqcds7TsoYVELJFkzssVJiyEFYtA6A>
    <xmx:9zk9Z8P2O5sLt57wdxmwLnPghsKD62gR6Cxf3jxIeYjQN4J9_KkkCg>
    <xmx:9zk9Z1nf5Q4ZxshWEVvVsB7bXOCDm4dqyHtM0ijQt-nA-dtfbNpv3w>
    <xmx:9zk9Z2ugM2VkFjYZ_qbS6QYRm2-zVDeVbUK_OX5ohhHZwvoyv8gBPw>
    <xmx:9zk9Z4CXtPTZHA64nFODT-NAYuSJEAV7Jr-FMC0S2f-ozM9Mt9FOmwSB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Nov 2024 20:23:03 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>,  Usman Akinyemi via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2] diff: update conflict handling for whitespace to
 issue a warning
In-Reply-To: <dc092d9e-d95c-4635-b4f9-85cf1802e571@gmail.com> (Phillip Wood's
	message of "Tue, 19 Nov 2024 16:49:05 +0000")
References: <pull.1828.git.git.1731347396097.gitgitgadget@gmail.com>
	<pull.1828.v2.git.git.1731524467045.gitgitgadget@gmail.com>
	<xmqq4j4a8srw.fsf@gitster.g>
	<29c81cbc-3678-4b70-9e0e-c500186d159f@gmail.com>
	<xmqqbjyh5pa5.fsf@gitster.g>
	<dc092d9e-d95c-4635-b4f9-85cf1802e571@gmail.com>
Date: Wed, 20 Nov 2024 10:23:02 +0900
Message-ID: <xmqqmshuaebt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Arguably yes, but that's not the approach we take when the attributes
> file is too large, a line in the file is is too long or the file
> contains a negative filename pattern. For those cases we print a
> warning and continue. The recently merged e36f009e69b (merge: replace
> atoi() with strtol_i() for marker size validation, 2024-10-24)
> followed suit and warns rather than dies for an invalid marker
> size. It would be nice to be consistent in the way we treat invalid
> attributes.

Arguably yes, but being careful when adding a new check and changing
established behaviour, risking to break existing users, are different.

> Consistently dying and telling the user how to fix the
> problem would be a reasonable approach on the client side but I wonder
> if it could cause problems for forges running "git diff" and "git
> merge-tree" on a server though.

That's an interesting aspect.  I wonder what happens when somebody
pushes a project with a .gitattributes with such a conflicting
setting to GitHub or GitLab.

Would that bring the world to its end ;-)?

