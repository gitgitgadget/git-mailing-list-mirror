Received: from beetle.maple.relay.mailchannels.net (beetle.maple.relay.mailchannels.net [23.83.214.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E5D28F1
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 04:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.214.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745382466; cv=pass; b=ZAiFhNrxQKC/diEXYT0GRyybhvZeeTI2FkgKRbGXstaNGRd3c2+jwmwM4TP+wMlI38S4gpuH2AJvVRFZuOZ4y3SuUscl3XD+l+Ri6laz0oVBmDAecmceYZG/XRO9NjCi6PjKM90rxIZO+Ro+IAjPYz06rFLZ8czVV7+EgKE7kpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745382466; c=relaxed/simple;
	bh=pCi8nUGBUB8pzGP4OCbtyB1fH2931xr/wpxcw342cXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+4ymelzC8v5L4HT5dxdXCNKVWo4PfQ2zrM8kzzBDAWebH50rcFbYxZz8N6VS23TtDi/YCQxr0rlLM4pU0e1bZIupuknH9vYGAadr+3zCFZZG/44NxSindkshh54aKQuMU8DmCEvYMkNeO2M72NgykfXVBytR7coExNqN0V3J3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com; spf=pass smtp.mailfrom=cryptonector.com; dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b=XEAVpKfx; arc=pass smtp.client-ip=23.83.214.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b="XEAVpKfx"
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 000488C314B;
	Wed, 23 Apr 2025 01:02:23 +0000 (UTC)
Received: from pdx1-sub0-mail-a256.dreamhost.com (trex-8.trex.outbound.svc.cluster.local [100.105.167.182])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 841548C32D7;
	Wed, 23 Apr 2025 01:02:23 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1745370143; a=rsa-sha256;
	cv=none;
	b=3Evcz2P2j0j9bavEE2jQ2tieiBt4iwgZAAF0d479w8I/KaQFd0PxwOlmrEc6zgY5Ca7mEK
	V1hLGgTggNQfEc3rGF8d99oKIjZWSSLSFYWP5wpw7qLVnHi6TskPbAqNgSm1oCLlEFqKdv
	HoSOtzlYEamgolfVrMA2J2otkQj0t1auvBUMaa8UU8AYxhbNxgtuJ1x8fNzn+zsSSw6myu
	CtMHv8/kJ7gXtg8+p4qFdA78k3V52XP3yxebIHOuHQfpK4O8gbpxJdeyGddvHi5HSyzJx2
	0ZD3+/Wb6vz6BdzlymHXG6Qsos0Zv57oC9bHegm94rqFrOIrAh+Vri6xzcA7EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1745370143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Y9G8maULj//Q/GBXl2UH4vYIy3kOI+7TbSqIWeLNjoU=;
	b=3waoO0wrIeF84fqRjsShiXaUPsDJN5LFDlECKxlAKEnYH+Y08psmZHOsz0l5G4qxN6rZoy
	qmm3rEZGW4K3Bzb/Oo/PCPh+prLmnu0sp7usq6+em++BAPah67PULzg1ZUbMV5e0g4Z1yK
	ZbJPrh3cXHGwXzk90hOO/A2QG0fgtSPOuJV18sChpPR6nGufIYNyg5w2rskc7H6FVhZxmk
	Sor3U8S+C/5ZNp+/bGmJLiN2CKsIfQ7Ck/OPD8Jmp4+Emrl65ti7GZMyEenDJ45bJTmoqP
	3+pfx4VtIj8ZoaDVzdwhcAkS/8gik95h1JA7WfGntiNUCbYoAMtonIugk15LQQ==
ARC-Authentication-Results: i=1;
	rspamd-5b8599699-x7566;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=nico@cryptonector.com
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
X-MC-Relay: Bad
X-MailChannels-SenderId: dreamhost|x-authsender|nico@cryptonector.com
X-MailChannels-Auth-Id: dreamhost
X-Tangy-Abiding: 0a8803c132bb334d_1745370143820_1323830632
X-MC-Loop-Signature: 1745370143820:2972631792
X-MC-Ingress-Time: 1745370143820
Received: from pdx1-sub0-mail-a256.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.105.167.182 (trex/7.0.3);
	Wed, 23 Apr 2025 01:02:23 +0000
Received: from ubby (syn-075-081-095-064.res.spectrum.com [75.81.95.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by pdx1-sub0-mail-a256.dreamhost.com (Postfix) with ESMTPSA id 4Zj16Q3D47z5h;
	Tue, 22 Apr 2025 18:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cryptonector.com;
	s=dreamhost; t=1745370143;
	bh=Y9G8maULj//Q/GBXl2UH4vYIy3kOI+7TbSqIWeLNjoU=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=XEAVpKfxvhuRFkjzOZFIVEm0RUMCcHIHoxIPqkGAPinkNBlH5yMcWsdICM1g3S7zi
	 gi6uR6eab78ZHyeNcdCI8jcphntfk9SC53X5sk5l7ZErsNamp6zOlPjMOcs2erRV8n
	 ztfuNeaDmPlCQ1Dc/YFoWJsbFUyxqFQFlPPzJMA5LVKCq/i4EW5Wai0lObPNWKG+do
	 Md9AgtUzTxWGkGeE0C8QZoIBfzAOE+3+P6l2I55Ru67nXTqRCgckhlWkR+pZmCvJvR
	 xkCFMOLS+688apse4oy28FSdv+zTn58esGgXd/+ZOT6fNniaI6AZnAr0XhGNTHnlab
	 AZkTO9bSQoX5A==
Date: Tue, 22 Apr 2025 20:02:20 -0500
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
Message-ID: <aAg8HN6sgFu4mj1/@ubby>
References: <Z/VGYrrVZYQ13TLj@ubby>
 <20250409121924.GA148735@mit.edu>
 <Z/amMj/eg0RbXdkS@ubby>
 <CALnO6CC_Gvqhcxp4AknwM+YSsngv_0zngKb2XHXN4u0AvKEMMg@mail.gmail.com>
 <D9816I5AX1RG.AA4A7H2D8SJ7@buenzli.dev>
 <CALnO6CCjkxv40+5wZ_vwZTKv7Te8Xh--M1fY2wbuOfgJm5LZxw@mail.gmail.com>
 <D9DIPNY431IJ.23DG6UL5CIQJ@buenzli.dev>
 <xmqq8qnr3jji.fsf@gitster.g>
 <aAgdauFt/mdCY+GZ@ubby>
 <xmqqy0vr21vq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy0vr21vq.fsf@gitster.g>

On Tue, Apr 22, 2025 at 04:49:13PM -0700, Junio C Hamano wrote:
> Not having to worry about duplicates (as long as you trust Git well
> enough not to worry about object name collisions) is a powerful
> thing, though.  Unless there is a strong reason to stick to slightly
> [...]

Is that really true?  Yes, because if two different objects have the
same hash then the first one pushed to a repository will "win" and the
second's content will never appear, right?  I suppose that the server
could detect the collision at push time and reject the push to make sure
that there's no surprises for the pusher.

But Git requires objects and refs to be unique _and_ it indexes by them.
This is great.  It might be fine for change IDs too, or not.

But remember that proponents want change IDs to not quite be unique,
since the point is that they tie multiple different versions of a commit
series together for the purpose of code review.  In the end, when the
code review is completed and approved then the change ID might be unique
again, but then cherry-picking onto other branches for forward- or
back-porting might render them non-unique again.

If you accept change IDs, I highly recommend not requiring them to be
unique.

Nico
-- 
