Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3884154426
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 16:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738601151; cv=none; b=t2CKeUxbeKWmu58lxuukuDc6d4Jg4zcaPBsanpTZTOoCsUq9J+m52JQ3krN+85ZZ9YaYhbylRCVqCrW+2Kxowb6k1QgiIMdsDEoU/GZ4aiAOmTGbCZXoWRPwdAKJ95jKUJEaezul6tO5bGMJxmapH1VTgxF9CvK5rEaA4O//C2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738601151; c=relaxed/simple;
	bh=t91V/Pz6Wvguu2i1veRHaGdAkeuCADKxE6eyTwJW0nc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NkAcJmnzhMcETDqaAiZ+pTX+1QoWGX16/IkbEK+DTQPyhAzVLe0lmDj2EifXSm214KBHFRrmUTsnncbjg/gfem1r1fzDl8HvLkIS8mDf0cyPxd9RDKBXI6+jlbRm/0LK3h5C9eLrPok8uZyU6ILjK4egFoE0eCveV2e07k8Tpw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UjHpHX8+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f4GLDqC6; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UjHpHX8+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f4GLDqC6"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id D8BB91380211;
	Mon,  3 Feb 2025 11:45:48 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Mon, 03 Feb 2025 11:45:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738601148; x=1738687548; bh=dCtBN8G6Dv
	NnjrpB5CEQdS5RzW4tuczqrLjGmJizXRo=; b=UjHpHX8+4qTfElYVCi1RtQ6HqG
	RBScqdB/jTo7GbDNVSEpmcG2/SzThbiCNmelc1s9+ubuwEBkC5IsQa9H9QmYvBtV
	gaBG/sys0svW18i4/6VFya357f8b0TnnhC/GOE8mZNggcEwhAp8Rc2Wc2AgP3fIQ
	vGRKc57Evn2HuZmP7NloZTxcWfJYDVTCHbcfU8QA5ewMjgOmiHZ45qtj57OTZe3N
	ZQHMrgXHnnDYPFoUt309Scyp+PsKK0rQRj1iQByOyBgGzYsFHe/Xph916dz2mydt
	vwv4uEgIzyBAOjQ+/QKgNxfScodZwYeIQnunoHM0TCtv60ghqBrJqyL4kfzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738601148; x=1738687548; bh=dCtBN8G6DvNnjrpB5CEQdS5RzW4tuczqrLj
	GmJizXRo=; b=f4GLDqC6D5cag4gWvnbNXyrjLGlVqGzTKdk6NxypNlR/yb2zctQ
	O/Tg0aH5m/8aWxWDIN1s2ztmPFTCHrGaMoeIvnzv+y74dZ7V8WtPyJJPpNFLNlQ3
	fJDlQ9GFrpUNMP5YlvLtJfZ6D2ss5b68/kcCHA9B99Vszurq+kgkrdPMcApAigRn
	gzRDfmFnOR2720XHDkd2NlXU3KCxGHm1o4UrQIuzVFVpjyP6uctJ6Zi6/3VV3A9S
	plbbayPHPYyenl2mRwGBhdLnNa51xcb5HWr7eIpv9lv0+LL0QHnxRjqh/nzXPJ2J
	8+2C3dpjP7URSPBDARtN/LKngZafKR6QwoA==
X-ME-Sender: <xms:vPKgZ0IdfkLH_g4-d1YnPQWW1-_T0RULtHl2t78AeTVQGGaJwSvLcA>
    <xme:vPKgZ0LdyRobz8NYNMr-K4gVKIIEdD4zbmIbawqy8u3T75HkJyDt3XBTHaaCrIttz
    3YahlyR5Hi4N_tz9w>
X-ME-Received: <xmr:vPKgZ0vZ9PA87E7T2uLXK1mqNx13EtzLAygd4xkiJHpqaMWITsx1QgyjLMeIdO_j3PZfLwrwvfnodGPRvumbi_DlnSmYkp-ShYX->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrhihurdgthhgrnh
    guvghkrghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:vPKgZxZTgTOCZe3BKKi9NXNZ972zqvZHf4XIZrIy2RErcA_CYp7sYw>
    <xmx:vPKgZ7boQQcQGNJ9amsPla2b40LgK7WmCd_RVusFJpFmdzmRTgRcSg>
    <xmx:vPKgZ9A10iqYv3TfmKJwN1dUsTlr4v058IBz1Pv_etjzQrbpIwff1w>
    <xmx:vPKgZxZbN4azqQG7HElpc9Hj0qqPrvNGXlBW9rirn-1DRc_RlCZNbA>
    <xmx:vPKgZ3GFPfG-U8aJV0UROiqEQtrUZUW8N_5KiX5lI-kvtmmHnfbG1FJL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 11:45:48 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Ayush Chandekar <ayu.chandekar@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [GSOC] [Newbie] Test Script t6423 Microproject
In-Reply-To: <CAE7as+YC-u84ef=LRP-FB_0ApJbaP6Le6k6QrV58itiGMHsk1Q@mail.gmail.com>
	(Ayush Chandekar's message of "Sun, 2 Feb 2025 06:23:41 +0530")
References: <20250201004556.930220-1-ayu.chandekar@gmail.com>
	<xmqqjzaa4g6m.fsf@gitster.g>
	<CAE7as+YC-u84ef=LRP-FB_0ApJbaP6Le6k6QrV58itiGMHsk1Q@mail.gmail.com>
Date: Mon, 03 Feb 2025 08:45:47 -0800
Message-ID: <xmqqldun2czo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ayush Chandekar <ayu.chandekar@gmail.com> writes:

> Thank you so much for your response!
> I also deeply apologize for the lack of etiquette. I will submit another patch
> which is the same but follows the guidelines.

Nothing to apologize for, and I certainly did not see any lack of
netiquette.  Each community has its peculiar procedure, and the
microproject time is an opportunity for both sides, i.e. the
established members of the community and the newcomers, to meet in
the middle and learn to work together better.

Thanks.
