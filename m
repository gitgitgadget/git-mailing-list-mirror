Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0364781AA8
	for <git@vger.kernel.org>; Sun,  8 Feb 2026 01:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770513703; cv=none; b=BIolcFOU/h8409VLPBFpb/28quK2P/8i5EWJ2zUMp/mEY822hk7XGH3R7SvJbfQKlCJ3UpqvbtaCcvv0zKtWMxKjYJFR/CJeuVZlIOOv/JbyFpRARH2p+tnoO+O/6xup88A7xANV2c/prM03HZkh7w7TH3uxUD2HWbQlDgvBsxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770513703; c=relaxed/simple;
	bh=bV1NVIiiXbbFD4szEnyLPth2MyIy4gLew8bVhipIbqY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n0bNdnECtN1zV+x/eVIvDIZTShd+Aj7DNrRI7sGyy+GycksFNL0AbgICyVDVsna5KqIP0BKGfcz05Tdv+cfrKFTBzalHPnlbYcitwEtNTQ2IQU2QLV0zLZxMXK5F0Wt15oPHlN1QmERPEPtn5VEh5jcK9WIsQbGuxcmN/TEPBwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RKnzErI+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nf4Hrauv; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RKnzErI+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nf4Hrauv"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0B3F31400017;
	Sat,  7 Feb 2026 20:21:42 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Sat, 07 Feb 2026 20:21:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770513702; x=1770600102; bh=hgtgzpgeB6
	rS9w1ByYEJnTx9E4TyPLxoTsodMWkbEcI=; b=RKnzErI+e8XIbvuhIXiafcdQqh
	qua7RQxlZodC+l8eDCE49KxPYPf7ziUUq+FZQ9lmovIzYyjlirBay+tsOpnNsqgK
	jYeFXp74fTYCXys7xMMZuTNwulipBDTObo1SbgEVAifcGT8bnTsySoc6dHHv1ETY
	4Jb++FZDZBhRzfqWVoHqLZW/2KgN5aIR2LQn4y24EUsSr/nn3GmcQPvwc7JAXo8U
	k+CzfTOUF+h6uiIw2QkpOFLxSWiRYEvZvn+ZvH6boz/1FkoLwZBvN7Va5ks4vgI6
	HnCkWnaqPXs+xWj2YPh6TfbzIGUDH+dtqjSe2wjxpzR85S4T73WMFOBAu+Ig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770513702; x=1770600102; bh=hgtgzpgeB6rS9w1ByYEJnTx9E4TyPLxoTso
	dMWkbEcI=; b=nf4HrauvPUTVXdGNG/ZRibCKlw+PHXX+iprNY5nC2GWrBMFxVUd
	TxVJptdxUTuw2EAppGfEvTWjIAh7qem400rcOpEIMflmKGbNSGzSDjA+oHKBarRh
	3jGSqRSqnwgsaSGQYygRtWrgJRDWwIHUH70UR2YBEihMlKSBLOcUL2XWFaSKmtKo
	ICQJmf1ZZkphk3SHSbNLNFjI3QgnsJt+LlBgpnPquaLaXY0UCeb0r0JA0xPhnFXl
	NbSZ9N8p8wcjVnJm7dcH9pEiZ8JUNz4Qn7rDQLn5hVH/1x69sGXNw1PE3gBDtQDC
	wCqSP9xGAmDOpi3dpyCYypRK/fLOuyKH2qw==
X-ME-Sender: <xms:JeWHaT5pDndYEKdQE1K8Bde8mPM6ZX2bLYaf83WyIzlxp9xA4P9yuQ>
    <xme:JeWHafxpBYit2Ynr-L2TDt5M2dvMrkTy_B5tVYwanmCur0N-BW6HGm0GKblEbLxKW
    rIXBCOanWJZB0etKVy8-_E7gz0jSY47mL3wpiajCea-sS2Tswdo>
X-ME-Received: <xmr:JeWHaSwb6aZAVsbqGrAWTtMTPN23_hLQLevyTgFV5-bvRvfeiJox0HtzlK7gauOSZpgMu9WoSujw-giqIVSgOubQLvGZTmTe0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduledviedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshhhrvgih
    rghnshhhphgrlhhifigrlhgtmhhsmhhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddu
    keeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfe
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:JeWHafxD2zlTeDHp4kv_YnZzKWgzw3JLJj1e-7HYS-F9LxH2gce0NA>
    <xmx:JeWHaUYX1gqoZ4nlub6r0cXP1LBqDahC0Ja-Kj27nvB8VtdY8CdRxA>
    <xmx:JeWHaYUmlSInWLhY3Ka5X2uV2GPuS7TSXPHsTvISJViRPsk1f33YDQ>
    <xmx:JeWHaags8uj70e1HgRSzjHUq_kU19QJgn8Kl8eJMs4aVgFApeyf6Dg>
    <xmx:JuWHaTD5u2Tj_BLTkvHrAARe7wvsM6l74nK-8swkmH3lsHnDgIGvyCtL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Feb 2026 20:21:41 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Cc: git@vger.kernel.org,  karthik.188@gmail.com,  phillip.wood123@gmail.com
Subject: Re: [PATCH v3 1/3] wt-status: pass struct repository through
 function parameters
In-Reply-To: <20260207100322.1786368-2-shreyanshpaliwalcmsmn@gmail.com>
	(Shreyansh Paliwal's message of "Sat, 7 Feb 2026 15:30:46 +0530")
References: <20260205101524.125452-1-shreyanshpaliwalcmsmn@gmail.com>
	<20260207100322.1786368-1-shreyanshpaliwalcmsmn@gmail.com>
	<20260207100322.1786368-2-shreyanshpaliwalcmsmn@gmail.com>
Date: Sat, 07 Feb 2026 17:21:40 -0800
Message-ID: <xmqqtsvs9gij.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:

> -int wt_status_check_rebase(const struct worktree *wt,
> -			   struct wt_status_state *state)
> +int wt_status_check_rebase(struct repository *r,
> +	 			const struct worktree *wt,
> +			    struct wt_status_state *state)

Funny indentation.

Besides, should we adding a yet another repository parameter to the
function?  The worktree wt knows what repository it belongs to.

> -int wt_status_check_bisect(const struct worktree *wt,
> +int wt_status_check_bisect(struct repository *r, 
> +			   struct worktree *wt,
>  			   struct wt_status_state *state)

Same comment about "r" vs "wt->repo" applies here.
