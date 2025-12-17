Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B667019D8A8
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 05:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765947895; cv=none; b=lawb2DafXwByqdgrXRztXLTsTW4EHOgeKTSRdLok5uR054nlCUFdqi/w2GPqKSi3Ett7BZv2/XaS8j8C3xZf81dV3+NMdzrf7Kq9t+o4xFLmtDfApZ+8GeIvyOWih2wv2BKh8iHWtbm94xzTpnQfNWBvmCReNw/ADUBpq1VrLjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765947895; c=relaxed/simple;
	bh=ZaJQtBb5q34JZLsgRWyjffW41IFUaehn74HXh2bBWfk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HrSiTYGhbz6RI6OOcrMwiiQiHuxPY60CVO6T/PkzbcTpQPMscGK0MAMnDpeszTX/Qc5mZ1bKEeBcOqQQ+vKg13FbEI8QpJitj6cyEB7GGbHlpmLJy2oanGHOxnRT4ZL6E+kNJtLvemGean7WGOainU+XU4y3hCon3rN3113TGlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ck5Ora+0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lkv/yy88; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ck5Ora+0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lkv/yy88"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BA9F01400242;
	Wed, 17 Dec 2025 00:04:51 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 17 Dec 2025 00:04:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1765947891; x=1766034291; bh=ZaJQtBb5q3
	4JZLsgRWyjffW41IFUaehn74HXh2bBWfk=; b=Ck5Ora+0RSxVG0BaArLZk19G+8
	DfhCokM+cWjPct6Gi6+SAB9mx8ZYnuG3lD2MVRQ0SjQIWD0Ln/J+RlFcyU/63/SX
	PYB/ZjkWb+6J6Z9M115B2tpFCGra+TCiJqchxenQTQagdChjdJ1Xlrh7pvOHNnnO
	cKPMkn1OWZZ3FA7EX/WD2F6SbFiq8Ec5MsOJwt648GJr1yGjwqUeOVwKko8XwLXG
	fDKOiysm7i/JtMJ8oLX97S1VYb0qtJHAjCAQY/1/MAl087iP0wC67VTPFUoTHokO
	lm4hdYxDdsxbzyXdvSJTteRbN+/vXmolOlaknXGNIcm13jlIBSHaBe2VZ0Zw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765947891; x=1766034291; bh=ZaJQtBb5q34JZLsgRWyjffW41IFUaehn74H
	Xh2bBWfk=; b=lkv/yy88WYcRooSQHhq1uDoA5zMZ/fgzA1cyhCg7GalWznwHc0D
	qyO4j2iCctxWJ9tWHlNbYVO+O1Lwq0nViAbKqtsEA6u7IoAB8EcWebmJ/rePprOB
	DKuld5TTclVGfpN4aZ74Oho2TrRP81i6SGRIfi0GTbekiUw6HNip/nJ3p3YpL1bB
	gRqMhIFt1a/ItMA/mmoUpuLycWH1HR3Mtx0jVz126ehq7CyMtGnqFRrT4yOU1yjk
	P3MenFNUc3R3L8lHjCh/RcQtLdtElIHX9YDRY7xgE2q5HiJGNDxVaziGyKTz69h5
	QSXP1oY3mFDJRCN1mVGKupOTa8L9oBXvmqg==
X-ME-Sender: <xms:8zlCaeSe3Im9BXJL2pkNPm_HPX13AOkQMkZhLdSYH54Eea5_rUqttQ>
    <xme:8zlCaQVmrJOXUomqWqgQVeg5-UXWrnZDs9VnKYRLUSVDnM9tBs1F61U7mD8IZOwtl
    2VBayac8Z12H_FeOZggXdmI-dEZC4V0_zyAxHNsbdd3_Gm9oWj-KmA>
X-ME-Received: <xmr:8zlCaQQnUpqZwjzQDKSZ8I4v22XxB277BaWEqYxIgQKqSCyGrDVcNrYHww5BUI4KrWyjg-GuM2EM6GYO892bPl29NxqLzPvlDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegudeijecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopedutddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepnhgrshgrmhhufhhfihhnsehgohhoghhlvgdrtghomh
    dprhgtphhtthhopegrughrihgrnhdrrhgrthhiuhestgholhhlrggsohhrrgdrtghomhdp
    rhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehruggrmhgriihiohesghhoohhglhgvrdgtohhm
    pdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprhgtphhtthhope
    gsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhp
    rdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvg
    hrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:8zlCaQ02LSSNE1Lk3yi-7kRsp8bfthCZLxbU44bYRwAz55q5X_8TJw>
    <xmx:8zlCaYeJ6XtP50S8rD9t9FlCuUvBHIi4ibnfloLhdGKtARzSz1UOaQ>
    <xmx:8zlCaQNQdUdaXX94bKVZaUMGnkyznh1PqU8kFfKDpcKM6cFxEDXonw>
    <xmx:8zlCaUUsWsPvyE0WHH3L8MT31GFbt_JyK03k3UgmWfVhafC2EFAYsQ>
    <xmx:8zlCaWVWH8MMy9LTXRk85EFj_KhtREu6_eIwPC3vOD3XTS6NURD5n2fS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Dec 2025 00:04:51 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Emily Shaffer <nasamuffin@google.com>
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>,
  Patrick Steinhardt <ps@pks.im>,
  git@vger.kernel.org,
  Rodrigo Damazio Bovendorp <rdamazio@google.com>,
  Josh Steadmon <steadmon@google.com>,
  Ben Knoble <ben.knoble@gmail.com>,
  Phillip Wood <phillip.wood123@gmail.com>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: What's cooking in git.git (Dec 2025, #03)
In-Reply-To: <CAJoAoZk8AYmJHkFc58LGqn9yengsAd+5iTN-WuFtzBnews7EyA@mail.gmail.com>
	(Emily Shaffer's message of "Tue, 16 Dec 2025 09:49:29 -0800")
References: <xmqq4ipwc7y2.fsf@gitster.g>
	<87ldj6x1ys.fsf@gentoo.mail-host-address-is-not-set>
	<xmqq1pkv5gpv.fsf@gitster.g> <aUEUrXFaAfgzSs12@pks.im>
	<87v7i6g13j.fsf@collabora.com>
	<CAJoAoZk8AYmJHkFc58LGqn9yengsAd+5iTN-WuFtzBnews7EyA@mail.gmail.com>
Date: Wed, 17 Dec 2025 14:04:50 +0900
Message-ID: <xmqqa4zh3dhp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Emily Shaffer <nasamuffin@google.com> writes:

> FWIW, I also expect Josh Steadmon to find time to take a look at this
> series soon, but he has been busy with personal side of things for the
> last few days. It's not that there's disinterest from our side, more
> that there is a lot going on :)

Thanks, and thanks Josh for further inputs.
