Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2652C11E8
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 06:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773988821; cv=none; b=FwzMbmZQ/rxI76Pjg8FVPfbdKgPYHPZ/VoaC65/kftF46bMoLiiQ17AGkyw19cO/CSqpizAlM0TQ0Ga0mtOjFnGFGs/ZD5y4jTfrTuaeoi2zVIunqshyX5hvCugeS9UtOaYhwlf1I4K2kyVINi9E3qH6CSTlZhATfqyceH2aQnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773988821; c=relaxed/simple;
	bh=ytvRrwnoMqV7svP/rln3AyLspLzUv4E2SomXZ3l+J+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jkn0iJs+sR6mgBCS2aGG1y/HHzjAnwSVw4JG6yx54MNZgdTdh88EA4bDyj9Dmz+W3JjpC765nSzkcZkMZGf6bHWFmnfSH2QxAzDe5leZHVzfc6d9IIBn6beC2fm6fFXMxHAThg8FyMfcgD5wmjPYjOTyH1Gw6mTKxlW2iGvQu/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SLJKUeaM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bkFO+Mpd; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SLJKUeaM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bkFO+Mpd"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CFF5B140005E;
	Fri, 20 Mar 2026 02:40:19 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 20 Mar 2026 02:40:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773988819; x=1774075219; bh=/NHMrTmx/7
	jIi128lJjUSh/BCs4UsYRLB4V4Sof557M=; b=SLJKUeaM3m95BDKUfUHG5ZB35V
	+Ke+kZ0sKvfFJuXqpwrUP0WPq/wWMwL5mHLBMZYta5XYBy1QmD1VAZMKNHvVzaOs
	k229lJ8banyJ4fU+8yVriTvqv2XvrpowVkHafxJJpycHKb9xmAJbbL0fmBd2BaSS
	0g3vq6ke6s/ptAPrANrnratUGSKxAKgLJa6ydEiZWg78sGHSNrrEtmerAk+/rxzx
	VHhR/rasuE2q+lC8EJ2ythZEv5yzQPBa06Lxi9r0ca5nS6KnINt8/1ss6Y++kY6Z
	9gvxtfi4edTRh8ewLAnhECeIt0GeXV+VHMziwfup8YH6HprcAZT/Dkzb0hGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773988819; x=1774075219; bh=/NHMrTmx/7jIi128lJjUSh/BCs4UsYRLB4V
	4Sof557M=; b=bkFO+MpdHS/zSNOMRtpw37Z/ZDJQBEFSj1z8t8vlFrlq6TJtBNa
	Y65ZkQFud5LJbFeKfMIUlQGfl+7YzCu0pCqqCg7yyNfeaFtcW61lET/45aVTInnE
	F6+U0HtQmnadKgcu5ckeJv9gRA06E0tfFNW0sTqcgCrKM9WcDjRNe9AkTH1oA3zp
	qoH9sTgou2BpsdBYsjK4kLbG3504WaACwMbzud3Dk+gSuqE3vC31hmdrJmXi7KUB
	gm1ODz8IyMHOxUHvgUkHKBaBU+lvxRg19o07OHQstMLNiLHLz0QERAO1CNHFaTbO
	GD7vyEx69hXYiTXDjpcgrm0CW6/6nQDar1Q==
X-ME-Sender: <xms:0-u8aSAhTydHDazlYYH-oSjfIB2mpzb3__kQujIvrqGjaaM4X21S5Q>
    <xme:0-u8aSh6h_aRl58FA4uE2ltkPswMFQVamPTzsySjut605mksn9Feago3XlASQrkua
    pziiNdqW_jW-XrxkSudXOC-96lnS77GjX-fUO0qvldHy4XKYawGVw>
X-ME-Received: <xmr:0-u8aTPplzDAKoVvj-b-1LHeDC9-uF-IimhzHn73tweXEKVCgf5Dc-zdR-Ub1ARW1ToJ55XlBBPA-LmU-2HFhe0m_H_N92WcF94YxoOTTWMb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdeludelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:0-u8ab5lEIkU8LHNPolECZ2DxanxwiQ9GTAcjokwWCbb6HmPVudr4g>
    <xmx:0-u8aZ2DUpAuhJNMybFVGXh3QFwT9BdDAa7FbRJBIDHvUe6NK8lOgA>
    <xmx:0-u8aUYDta2dqpEuAS_MwibYkV-Tcv1-GMY7TmujMaDfxhfPPCdgNA>
    <xmx:0-u8aZD7HyujTR1PfmKMFqKO4x57PfifZvmlFFUGHA16AzaTE0v0ew>
    <xmx:0-u8aVY_a47Y3jY8yUdk15G4kAbtRBS_NQyFjRFXBiey-t1tS-6piKgB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 02:40:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 59166432 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Mar 2026 06:40:18 +0000 (UTC)
Date: Fri, 20 Mar 2026 07:40:16 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 02/14] oidtree: extend iteration to allow for arbitrary
 return codes
Message-ID: <abzr0EaDfn2Dpo03@pks.im>
References: <20260319-b4-pks-odb-source-abbrev-v1-0-5ddebad292b0@pks.im>
 <20260319-b4-pks-odb-source-abbrev-v1-2-5ddebad292b0@pks.im>
 <xmqqa4w3n5se.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa4w3n5se.fsf@gitster.g>

On Thu, Mar 19, 2026 at 09:27:29AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > diff --git a/cbtree.h b/cbtree.h
> > index 43193abdda..4f644d6e45 100644
> > --- a/cbtree.h
> > +++ b/cbtree.h
> > @@ -30,11 +30,6 @@ struct cb_tree {
> >  	struct cb_node *root;
> >  };
> >  
> > -enum cb_next {
> > -	CB_CONTINUE = 0,
> > -	CB_BREAK = 1
> > -};
> > -
> >  #define CBTREE_INIT { 0 }
> >  
> >  static inline void cb_init(struct cb_tree *t)
> > @@ -46,9 +41,9 @@ static inline void cb_init(struct cb_tree *t)
> >  struct cb_node *cb_lookup(struct cb_tree *, const uint8_t *k, size_t klen);
> >  struct cb_node *cb_insert(struct cb_tree *, struct cb_node *, size_t klen);
> >  
> 
> This change does make sense,...
> 
> > -typedef enum cb_next (*cb_iter)(struct cb_node *, void *arg);
> > +typedef int (*cb_iter)(struct cb_node *, void *arg);
> 
> ... but it probably now warrants a bit of comment as readers cannot
> guess from the values in cb_next enum that is gone.
> 
>    cb_each() keeps iterating while this function returns 0; a non-zero
>    value returned from the iterator callback is relayed back to the
>    caller of cb_each() after immediately stopping iteration.
> 
> > -void cb_each(struct cb_tree *, const uint8_t *kpfx, size_t klen,
> > -		cb_iter, void *arg);
> > +int cb_each(struct cb_tree *, const uint8_t *kpfx, size_t klen,
> > +	    cb_iter, void *arg);
> 
> or something like that, perhaps.

Makes sense, will do.

Patrick
