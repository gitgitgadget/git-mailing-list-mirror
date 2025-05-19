Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A542F63B9
	for <git@vger.kernel.org>; Mon, 19 May 2025 07:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747639649; cv=none; b=Bw7LFdtIjQsjs+0iT0eECHEuI4t7khnCvvi2UAjcjysFb8bn917bDuGAkd3fhngiZOjdDHp7Vb7AFiJWZcHqOW3c/K28qDkDi02B9Lrd6D5ZtveYt0XPw1KG2CqYrBjxWYGBmKwtUsKqpgCb19t8HVkj8o5NZXUY0xOrq/30a0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747639649; c=relaxed/simple;
	bh=mh91WlndSamZJy2Ro7ibcv3Q1XirUxlcx9l8ccJxOuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eVjuo9E44u7DcrOSZvACDr5Ib2BvUQ2Iyq5Xe5JGX+o+TVfyv0gqXMlhv5ZI2KlTftX+b0mvVFcOUUWNAlNRNsC7oQdG4qycN97NOqM4/MYPjIQOvFpKRmIi97J/daeFub8HQ/bDqon2uRo1ibXixjPgfw9YIo6MkZ3lNfxOXtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=1O6x26dv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kP8dXkg8; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="1O6x26dv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kP8dXkg8"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AEAB6254011B;
	Mon, 19 May 2025 03:27:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 19 May 2025 03:27:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1747639646;
	 x=1747726046; bh=zRAhXE6TeV3awngxOwFZ/7aXxiKE6NxMVHrCD+ZYkas=; b=
	1O6x26dvi2hQmplq77OhVA05TE4e0NfhmyMcG65yBvH042m7DA+GFRoZyzYd4cDl
	neNAr/tSgmYca4kVv/xYcHgHYt3eIGcVPxAnGJyZnWHQvTapR3zbxkh0bYpCPl82
	uV4X2++Tk9q0J15KtYxaEXPHbrJwhCmHznoD29WvOHJVyXnRRj2anfBxkjwMoO0F
	q2oDRaC3EuH/yjZKsFbQ0WDYwfmwps4oqQDkdwk8FdNQbjPlq5drtaisbidqZahZ
	ADLBDA/99RlTgEy+am5CFlN0+MEM9XAgs7LOkG/RW2Gp2GDxFfXBEdxGXq+gwelN
	Oh7A+O6uxdvqokyZNdz7bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747639646; x=
	1747726046; bh=zRAhXE6TeV3awngxOwFZ/7aXxiKE6NxMVHrCD+ZYkas=; b=k
	P8dXkg8pvdM84SQu7THHpaiD7IjVNqi7Z0ZPn1HxVYFOcXuESopqKFeHXQf78K/e
	hMIY/a1CtTJxdDCWZD3gBNHgV5p60booS/ITlNnT23ln4GNG/BYD5Ex03w0h4qsL
	uqDgYCpg1gACR1VkpNT+TufAySwrkDNwH9380jE9IryDr7FglCn0bD3HF6oRxh0i
	zdj2I/AAcYGJMpB1qAm39H6r0ZPapUm0O5lLIjTPAegcn0g8L+41fJALT2fz70wq
	zB6DK7NJWEbq/aSD+9u3cH296vnVEh61oCzOGjFxIK64he+/mpRO5hGgYHoGSPZc
	g4QxUDR1MsbUy6aOUudyA==
X-ME-Sender: <xms:Xd0qaM94onDpg9RXrK3QqgTJWVjb7d2fmysJz5S_QBqJ1i_045_E7w>
    <xme:Xd0qaEuGgRYfWk1Ljj4U8MRynkhCYcKfeu2KYWoR9Smx39U8HFU6gDfImrpkti-Ia
    26EshulIPZoC6tg_g>
X-ME-Received: <xmr:Xd0qaCDoUcKdve1wD_vjSY6uACIXMN92ueS9C8jkI8xAZa_0X0QQNEfA0DHHGVMe2mOtl5AtLcxdVcJY6-U1_hpWnb91MHKUo7uo9xNeGCpD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvddtjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeetheffvddtleettdetueeukedugeettedutdeg
    ueeukeetheefueevvdeitddtveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhs
    rdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohephedtvddt
    vdegfeeftddtheeisehsmhgrihhlrdhnjhhurdgvughurdgtnhdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Xd0qaMcB0FXk8SigY0X2IIo2cLjD4VpWNF-JYv33-FkOat8jBGgW7A>
    <xmx:Xd0qaBNQ4dzMwN5ZmmnbGFV6wYp6fuyZOskyxNzVb_se-dWnDQmt0A>
    <xmx:Xd0qaGnGSkbuKE7zAPKaiEPydduql5A8xpdRLPSy8DlSmm97j7UWkg>
    <xmx:Xd0qaDtigoVphiIdn_s0v4tOo5wS1z_vpMTyxean9e6J-SPW9p6dWA>
    <xmx:Xt0qaMad7AcZKh6PMObUnaQKpWNg58rUbldCldg7_E2Tq9Twtg-hH3lr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 May 2025 03:27:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c86e9e6b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 19 May 2025 07:27:22 +0000 (UTC)
Date: Mon, 19 May 2025 09:27:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: lidongyan <502024330056@smail.nju.edu.cn>
Cc: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH] pack-bitmap: add loading corrupt bitmap_index test
Message-ID: <aCrdWbcOtbYsw8t6@pks.im>
References: <pull.1967.git.git.1747491983066.gitgitgadget@gmail.com>
 <aCrJcK6ml4r4S-mF@pks.im>
 <80BCF957-002B-4532-8E3D-8CAB45AC0349@smail.nju.edu.cn>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <80BCF957-002B-4532-8E3D-8CAB45AC0349@smail.nju.edu.cn>

On Mon, May 19, 2025 at 02:44:22PM +0800, lidongyan wrote:
> 2025年5月19日 14:02，Patrick Steinhardt <ps@pks.im> 写道：
> > Okay. We _can_ do that now, but the patch doesn't explain why we
> > _should_.
> 
> The main purpose of this patch is to provide a test case to check whether
>  a memory leak occurs when loading a corrupt index file as requested here
> https://lore.kernel.org/git/20250514180325.GB2196784@coredump.intra.peff.net.
> A potential memory leak is mentioned in this patch here https://lore.kernel.org/git/pull.1962.git.git.1747052530271.gitgitgadget@gmail.com/.

Wouldn't it make sense to include this in a v2 of that patch series
then? That makes it way easier for the reviewer to draw the connection
and allows you to draft commit messages in a way that they refer to one
another.

Patrick
