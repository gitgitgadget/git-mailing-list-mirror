Received: from bee.aspen.relay.mailchannels.net (bee.aspen.relay.mailchannels.net [23.83.221.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BCA28F1
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 07:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.221.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745392135; cv=pass; b=NNqQiZzPnhJ51wyk90zddSprXmNbpRV9uz9fLvgP3HaDtDkIJPCT6oPISQ/ZGoeQLbT+l9P2IEWorReQEYjr30pVRTYRsQnl1wFk+osLLYcDnl+XcAIRLgwazKQ04HwjNqIhnGlWSYy//ydcdD/nwHsMgO9a6zWr44DYzTH75hs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745392135; c=relaxed/simple;
	bh=XzuWSz+k+l76kumFfe8oWZKqBwVzSSTDStJKnREtm+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ibGtKmzIQvisFVT+82/FxtMtXTGs6nAg83GN4SBVkrdmm8LmiHqTUygkWULEqQ4WqK0pS4A9TbQhlRmDPj4MqzbiU25brz1WjfcZiRzigwWHEUdQsUDqALuLiFj1QVGqZgpnodv97ddiAefB2FE5fDBCLklonnwL/4CN2tdHkn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com; spf=pass smtp.mailfrom=cryptonector.com; dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b=RGw1V611; arc=pass smtp.client-ip=23.83.221.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b="RGw1V611"
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 7D80844808;
	Wed, 23 Apr 2025 04:47:14 +0000 (UTC)
Received: from pdx1-sub0-mail-a251.dreamhost.com (100-113-55-196.trex-nlb.outbound.svc.cluster.local [100.113.55.196])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 07A5C44EB7;
	Wed, 23 Apr 2025 04:47:14 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1745383634; a=rsa-sha256;
	cv=none;
	b=3kKg+2Q5bIBbVE7LJA3ovBeRrfgJM8knKvyK64orB1o/cLF+XePS2p0KnGTJvY1pj1Tuvn
	j4+SffuHtJToX4OTL4TO3+zmOLCOOQL5ccJKgzPr7f02eYmSpONOcWOspncAyOh7AoDXS5
	O/A6U+lsKVIlWAhC+qhQoz2G9ETOTVhHtXdkGkUZ0M/CD1dsI2NT7+IbvsxehICSQJCWfF
	LInnq3b8yOBgrkBaU6oPmxQnsX3/d4Yv6ReoSi+Kc88kDc0Q7yT1bALuORjm3HH1K0s7hO
	atkO9vAkWvC2h7LfwHq4HVrUNdiLcb2ZuKJXZsCzbeqI5lwODZt6GrD/gEun9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1745383634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=R8x/WuU24RjnbJd/U63k7afw2ymXk9UKTMMD1r/UiBA=;
	b=jKKhqEaM8EFQMS/UAzv+YsnEigGBtIXhnPoR0kB7HhTnrMflfirklVdaOYAlUVZIcizgWI
	i5hdMP8EGZz/NTOv89wLQLdSNGtPK3XzkVyI0Ht0iOW9+J6darAtlhVHOrc9qMh4bav3pF
	4vafex2J9PlKzBsW9x9wKT2nvY4xil30OtDxDdA4Pti2UwVEbiKLtpSgy+qY44zq7eMy2C
	uc+HmAhsMmJIbl2z9s3pH7EBihFORw801wH8ePSj6gJumau/Gqkcs9HyIKXFQX2Dis4joj
	EtIvuV/Q5ay97hMlUGTBVQiMyvMFvsMMEDb51ZHM6NbSDG2rdR+oZBbrUBIQKg==
ARC-Authentication-Results: i=1;
	rspamd-5cfcf5665-kj6cg;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=nico@cryptonector.com
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
X-MC-Relay: Bad
X-MailChannels-SenderId: dreamhost|x-authsender|nico@cryptonector.com
X-MailChannels-Auth-Id: dreamhost
X-Well-Made-Gusty: 5461d76107e31352_1745383634292_4106831385
X-MC-Loop-Signature: 1745383634292:3443649520
X-MC-Ingress-Time: 1745383634292
Received: from pdx1-sub0-mail-a251.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.113.55.196 (trex/7.0.3);
	Wed, 23 Apr 2025 04:47:14 +0000
Received: from ubby (syn-075-081-095-064.res.spectrum.com [75.81.95.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by pdx1-sub0-mail-a251.dreamhost.com (Postfix) with ESMTPSA id 4Zj65r6fYSzBD;
	Tue, 22 Apr 2025 21:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cryptonector.com;
	s=dreamhost; t=1745383633;
	bh=R8x/WuU24RjnbJd/U63k7afw2ymXk9UKTMMD1r/UiBA=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=RGw1V611/jeU0xgjAA4PsyU7x0/RUSzYY6bXASfNZMFCnudIxzGFuereC4bQObQjo
	 t7L3cBM5PeI+FYeQFWB4tAEMYa6ciCbopxTSkkFGnpuF8B/QOIKxa2tmFkodQ42aCe
	 j+XZQAzGJzXIYhUoSGe/xp4Zgsf4fiJJ0vAzVoV2a1tyZSQI/FUhNGaoDxJih0VNWm
	 QdITrx9UK1jKD3acTCCunAqW5DXILKLPiPlcc7tjxCRGu6gLqNLY5TEfKdlKbaS0/O
	 sQTi+1VNY/TIYYsLWy0Up6pqex+12tBKSAKu1cLRJr4zZ2xKGm0hBKi4WrgJI5xG0L
	 WjlqFjMt0VyMQ==
Date: Tue, 22 Apr 2025 23:47:10 -0500
From: Nico Williams <nico@cryptonector.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Remo Senekowitsch <remo@buenzli.dev>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Martin von Zweigbergk <martinvonz@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Edwin Kempin <ekempin@google.com>,
	Scott Chacon <scott@gitbutler.com>,
	"philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Subject: Re: Semantics of change IDs (Re: Gerrit, GitButler, and Jujutsu
 projects collaborating on change-id commit footer)
Message-ID: <aAhwzs62VPZrWr7+@ubby>
References: <20250409121924.GA148735@mit.edu>
 <Z/amMj/eg0RbXdkS@ubby>
 <CALnO6CC_Gvqhcxp4AknwM+YSsngv_0zngKb2XHXN4u0AvKEMMg@mail.gmail.com>
 <D9816I5AX1RG.AA4A7H2D8SJ7@buenzli.dev>
 <CALnO6CCjkxv40+5wZ_vwZTKv7Te8Xh--M1fY2wbuOfgJm5LZxw@mail.gmail.com>
 <D9DIPNY431IJ.23DG6UL5CIQJ@buenzli.dev>
 <xmqq8qnr3jji.fsf@gitster.g>
 <aAgdauFt/mdCY+GZ@ubby>
 <xmqqy0vr21vq.fsf@gitster.g>
 <aAg8HN6sgFu4mj1/@ubby>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAg8HN6sgFu4mj1/@ubby>

On Tue, Apr 22, 2025 at 08:02:20PM -0500, Nico Williams wrote:
> But remember that proponents want change IDs to not quite be unique,
> since the point is that they tie multiple different versions of a commit
> series together for the purpose of code review.  In the end, when the
> code review is completed and approved then the change ID might be unique
> again, but then cherry-picking onto other branches for forward- or
> back-porting might render them non-unique again.

Ah, right, the thing about change IDs getting copied to new commits when
cherry-picking was my suggestion.  I stand by it, but it's not what
others are proposing.
