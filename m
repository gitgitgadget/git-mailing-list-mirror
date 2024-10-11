Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB1F1C689D
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 18:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728670739; cv=none; b=TJAcf2whMNeTdDYQLJG7nv52AeH+tNr4xhzzlOH8C9Oq0EKc7LFTF+L6CUxIxwH/9xy3rVx7UePMSt4k4WGDRPtZpOE/1MG/bk+O97xxetWBPeo/IDX252OX4il4D2t+SuWJzhcBk59kTVSmZeukBgfj9wwHxOOj+msntvVLWXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728670739; c=relaxed/simple;
	bh=UFIPkfEfQyumk3GBsO5FdsFQnX2WZNs5gVKbq8zxGGM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b0hbdrp89dz+JKmGLaKsOoYT0lWRMuZrmVkLxmkgP8I2C8hWnjCNbq+OT/+iFQqlGlq+LPOT3Wv3sLWp1teLI5LnQq7+V//k8HCnNcBD7ZCuGSG5qSBCBnvlEoyzlFAwgN1eaCfazYfV2umnSAQ9YEkLRfW1zy8TfM1iPlJAiJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hxcruxFA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l6gEqbdg; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hxcruxFA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l6gEqbdg"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id C22091380398;
	Fri, 11 Oct 2024 14:18:56 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Fri, 11 Oct 2024 14:18:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728670736; x=1728757136; bh=84vGQfVR7I
	HqCOfKqeo0RiNRlsCwD1eG16K0sFD0qeE=; b=hxcruxFAJ3wvTS9quvLG0ip6pu
	yQlFAZ85dL6D5qucBCyMAS506rdG/qFc8rnvyFbLNmtIjadUSchTwEsGrWpO/J4p
	4362E3AksGJGbB+V3VMpjZyaHA5eQenplFQK4PxyD50d2hYmUrA5DeC7sx+x9AIT
	f1vyMkXD7g6JvZytUNLSqkSl6lWlxwBBgmZPirnP93lFIBX68Pvq8JcKJJjMpeT5
	37xBGr69SlNIEexpSVxE5yuBn7J4iurOaqbJ9aI2ydthf3T5VJ+/Culh0oN8hvVI
	WH3gsEKZpHCM7jxXG2rdCdVEvT5GaiRPYKjLo75HvxoW6Md7AsLp8NldNUGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728670736; x=1728757136; bh=84vGQfVR7IHqCOfKqeo0RiNRlsCw
	D1eG16K0sFD0qeE=; b=l6gEqbdg2G1yzcp0TWWHmxJ6apB8ChLKAsvQ9HIEkb6k
	qrGgD9PlrZnHnxQQlrNxY7DgL+4eM9va9W4lT2RPUY7bYBdI6ibHIsGzC2cwgMIL
	C0C7uVm1OTOVPRqTS5an72EQIUZGL0SU+mNOYuvRlRynF+3XDAruasCCPT5O+kIj
	MG2MPU8+in8cWnrCSLOx4gJEuOygKKPAcaOonUFJY24Fu34TSDBuzi7jA/AnnGF6
	oZ7aTx0Je9zmQkbo3HzeTy8t42tqP8BvHtN2UwI91hNjpm7QeQBVtZbqQ63oy0H0
	tJqrpOz9VlCifQ5D5FJm3mxKCdBVdHCBdE/IvwjhLA==
X-ME-Sender: <xms:EGwJZ_WvivT2hV7SDrPYiy3b4yO2T3A_z233Ap8sOrb9Ne_dbB4CHw>
    <xme:EGwJZ3kl9axe35YPxXkS0i_KBq_dx3g5o9cyTBZf7pkozAwGklUGfVU-JEh9iu7_U
    BhJyY-K36zLZHbCRQ>
X-ME-Received: <xmr:EGwJZ7YC-FSYD-ELUll-10B2X7pxKHUFbcXHononGVLKsMfqCsfRutc8WpEwQ6l15Z7IMm3JJM3H5pMZe02IVc8sfJXYyir-JcnFpNc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefkedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfe
    evteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohephhgrnhihrghnghdrthhonhihsegshihtvggurghntggvrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegt
    rghlvhhinhifrghnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehjohhnrghthhgrnh
    htrghnmhihsehgohhoghhlvgdrtghomhdprhgtphhtthhopehsohhktggvvhhitgesghho
    ohhglhgvrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:EGwJZ6UXtJh49DhgYQ7F8tBRkx2xmALarb808OYK6VbE4TT_tPoFuw>
    <xmx:EGwJZ5kTTPCtmQnUtP4C5TTJJJAYOd6lEI-r2zeoID1dFeaXO7CDwQ>
    <xmx:EGwJZ3dq8unVtazK4R5aXTR0Eyxg3l3jwoAk_vZqh2b_8wwvWTTk_Q>
    <xmx:EGwJZzHQLzIdT-oNA7rQ2XKRfrS9i7ZP4R15ewqN1_hpwrpe4vaz7Q>
    <xmx:EGwJZ_X_xiEyA0op-uBWbGZLAPiM-qATIxYajD0jL10P6b5dHP_hLDyi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Oct 2024 14:18:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Han Young <hanyang.tony@bytedance.com>
Cc: git@vger.kernel.org,  calvinwan@google.com,  jonathantanmy@google.com,
  sokcevic@google.com,  phillip.wood123@gmail.com
Subject: Re: [PATCH v3 0/3] repack: pack everything into promisor packfile
 in partial repos
In-Reply-To: <20241011082404.88939-1-hanyang.tony@bytedance.com> (Han Young's
	message of "Fri, 11 Oct 2024 16:24:01 +0800")
References: <20240802073143.56731-1-hanyang.tony@bytedance.com>
	<20241011082404.88939-1-hanyang.tony@bytedance.com>
Date: Fri, 11 Oct 2024 11:18:54 -0700
Message-ID: <xmqqa5faec4x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Han Young <hanyang.tony@bytedance.com> writes:

> Changes since v2:
> - rebased to seen: 89afaf27d3 (Merge branch 'ak/typofixes' into seen, 2024-10-10)

Please NEVER do this.  'seen' is as unstable and fluid as you can get.

Instead, base it on something that is well known and (supposedly)
stable, like v2.47.0 (or an updated tip of 'master'), and then
test (1) the topic by itself, (2) the result of trial merge of the
topic into 'next', and optionally (3) the same for 'seen'.

Thanks.
