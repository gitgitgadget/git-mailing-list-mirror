Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1732E717C
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 15:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759852687; cv=none; b=IFMGOGeQ8b+NiiDenAGTV+GiLCTeFKwMQsOqLIveHyAdNWNL+yr3d8PPoidFKvMsHyLWranzajnd309FACUQUT+VixqjGCMK6QZp3AsLrsxXP163U75V1RbQLCR83i0mq1mGIeLIqNIBD1+raw45gLMQKGEaukle6rmoD43iRBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759852687; c=relaxed/simple;
	bh=UsbzLN5XQnFUUOR16Tlm0o1iL+RVibTFurLanPJra7c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nMTbBEwkxgKYsBTo4pr2MzbxXyr2TVMamB7sgDPlxAAE2p0gRlxnxmcLvAyDziwkvvZu+EXw6phcaujKbUhKWEvZq7C4yNqgicXKFYvDV+A9FikVesWimz+dKQT2vuNhYir3HghwcB9Vy3Sg3nn7vosAzY/6Fki1Rhr3ACllWLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cDJ2Bvv3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B9yyqZ1Q; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cDJ2Bvv3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B9yyqZ1Q"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2576A7A0248;
	Tue,  7 Oct 2025 11:58:03 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 07 Oct 2025 11:58:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759852683; x=1759939083; bh=DqRcyH3xbw
	wlY9kITB9jOVCGhV3PVCwj2WZyd+dnn1s=; b=cDJ2Bvv3cR27YczssZWtCdDiCW
	HUBagqONzqr9of6OiI5uD+oCUNi/mxS6Yt3rH/vFYa0tP/juYKGuEdPwgoYFC7pc
	KVuKTEPfLxQN7w4sHAuNaatTXoSmvJDxdOEz4O3d5YWQGJ1AGb/zTz5u+qahaF+Z
	2pj6bvtN/E4io482YZMXCv5+qgSkeaSJZh3gW6F6Z3mVEQ+cWHk5+NmCHSSeOh1X
	LgqrFTzgG6ZmwFvN1edquQ7s1zQM6PJyqmiX7i5OCDbAYFk4Y879x7Ei+UnA/PXE
	VEzNZc+koK/dO199KQPBzyxQMYnx72omFBcQN6ycKReV2anZ7qy/f43A/oig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759852683; x=1759939083; bh=DqRcyH3xbwwlY9kITB9jOVCGhV3PVCwj2WZ
	yd+dnn1s=; b=B9yyqZ1QJ9Y2evof+M8/v4OzCgaw2HOL8DR8W0WbtidWQrOkEvA
	HIvTs6giWCOufGp+xCZge8+rCAYeaSmUZ9T/aE7ub9tl/FKpfzZ4JNa6ZmDinc1l
	KwIT/YnJRXqwwv6FxxRBqSAzwq7zRdavOEspPM0UbKgIPTm4Xw+xwiLxNxVluqir
	SFwNlHS5zhjdE5yUG69/YjiH6O5aV4VY30uwvY/1BN97xUGg0eY+2Xvm+/T5WSLX
	mBM0Tqf8nVwa8QAz3W0vhxbdEW60bBL3SATYZlvW7TX2XUwekl807/F/l7kSC2Od
	/8DduQVbH/beBfL+0qjbJymx2YvaYVmCXsQ==
X-ME-Sender: <xms:ijjlaIlBVNxzEzFWxlXZFM2CWcyWoVRiK0OisVozQLNFLFMjThyrTQ>
    <xme:ijjlaDpoPniO30ySTyQucG-BiOVSostAjAc4G4MR-82qyluD0SoshM874Xs9qsV4r
    AP9eW33mA-YYD0AOSMPswIGK1e0MbJ9L9nykRbbUlQa-2lzwzjNsg>
X-ME-Received: <xmr:ijjlaCC2_21xhPloP7A7aMb8vt_KR9_eeQWVTu51j3h70m3_xM9rpw_UfKnggzFM7a5gLmabna5RFUQw6fuKcyB25BHvbJ9Z7sRb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddtkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegrughrihgrnhdrrhgrthhiuhestgholhhlrggsoh
    hrrgdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvmhhilhihshhhrg
    hffhgvrhesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprhgurghmrgiiihhosehgohho
    ghhlvgdrtghomhdprhgtphhtthhopegrrghrohhnsehstghhrhgrsgdrtghomhdprhgtph
    htthhopehjrhhnihgvuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhk
    shdrihhmpdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:ijjlaOGIr2vp6tg1KGzExR-ZbHDs7uNPnt3usiSE2arScpMWLi6NfQ>
    <xmx:ijjlaE0EriKBR6l85x8FWfGnLT3Q9Hp8lyBo7-ut5CzPc-zEGFAiuQ>
    <xmx:ijjlaHPU7wMgeE-qJo9TUH1JpyCjKC0drYoQPvKzGkjkYOsYiEPBbg>
    <xmx:ijjlaMbUmYP2csbec4yiSm5ArxlL_K4i3vKjgS-HdiERLmguQfFbaw>
    <xmx:ijjlaDj7Er51QBLNneenyW-nGlSWYPi8UvA1IDc7JcS_reJeOlcxFV4l>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Oct 2025 11:58:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org,  Emily Shaffer
 <emilyshaffer@google.com>,  Rodrigo Damazio Bovendorp
 <rdamazio@google.com>,  Aaron Schrab <aaron@schrab.com>,  Jonathan Nieder
 <jrnieder@gmail.com>,  Patrick Steinhardt <ps@pks.im>,  Josh Steadmon
 <steadmon@google.com>,  Ben Knoble <ben.knoble@gmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 5/5] submodule: error out if gitdir name is too long
In-Reply-To: <87jz173tih.fsf@collabora.com> (Adrian Ratiu's message of "Tue,
	07 Oct 2025 13:17:58 +0300")
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
	<20251006112518.3764240-1-adrian.ratiu@collabora.com>
	<20251006112518.3764240-6-adrian.ratiu@collabora.com>
	<xmqqy0poot7g.fsf@gitster.g> <87jz173tih.fsf@collabora.com>
Date: Tue, 07 Oct 2025 08:58:00 -0700
Message-ID: <xmqqqzveln5j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> IIRC the consensus was to avoid keeping such a mapping due to 
> complexity, risk of desynchronizing with the filesystem layout and 
> so on, so simple rules like the above, or even a simple hash_name 
> might be better (see below).

I do not quite see a merit in the above argument.

You have submodule.<name>.gitdir that you need to make sure your
"risk of desynchronizing" is managed anyway.  By making sure
name-to-directory always goes through the single mapping, you reduce
the complexity and concentrate the choice of the path to a single
place, i.e. where it is assigned by munging the name and registered
to the mapping.

> Someone suggested we use something like .git/modules/<hash>_<name> 
> when the extension is enabled, so we have a simple, unique and 
> recognizable pattern.
>
> What do you think of that?

If there are letters in <name> that you cannot use there (e.g.,
slash, or perhaps <name> is overly long), you have to munge the
<name> part in <hash>_<name> in order to fit the filesystem
constraints.  And prefixing random string "<hash>_" would be one way
to make sure two <name>s that happen to collide after munging can
still be differentiated.  So I have no problem with prefixing or
suffixing, but I do not think that syntax alone is sufficient to
solve other issues that come from the fact that some names are not
filesystem friendly and can collide with names of other submodules.

Thanks.
