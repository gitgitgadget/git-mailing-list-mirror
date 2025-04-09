Received: from silver.cherry.relay.mailchannels.net (silver.cherry.relay.mailchannels.net [23.83.223.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EFA1C5D63
	for <git@vger.kernel.org>; Wed,  9 Apr 2025 19:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744226004; cv=pass; b=rw4NYjuSCf3DGnLRVrY4MojBIw8XQk8Xqjzy3qegwrVLwfUtFo1/EbTO/OPAgsKzLlM1Y4DVmL+5wDF9v1Qml/skWW6/tVCpUsfjG8N+y+VooLvIVgV+qbc/vyUuQZ8E+v+Qe+8N4cMNJxM1XKOXMcQDLqPEx4Ruumd14Wm7GC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744226004; c=relaxed/simple;
	bh=RmCUbxqLRhraTeiZ367iP+1HwPxx0HqabC0hqCN9shg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XztmqpEM2Ec0RXAUk27jCUK4tm7k/DxGu66Ra0pN8k62UEBG0TLoG56pROL/73F8FLCnNeso688AKFB9ppnavipjIjyX7gzGNicBsc5GE1SdYkOHui2axptMYaVu0zPuGcO/rMZD4qiNhV8MO0p7M8VYLq9dU344Rfws4rt1PJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com; spf=pass smtp.mailfrom=cryptonector.com; dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b=loisl9om; arc=pass smtp.client-ip=23.83.223.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b="loisl9om"
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id D81447830CF;
	Wed,  9 Apr 2025 19:13:21 +0000 (UTC)
Received: from pdx1-sub0-mail-a228.dreamhost.com (100-99-49-173.trex-nlb.outbound.svc.cluster.local [100.99.49.173])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 78358783711;
	Wed,  9 Apr 2025 19:13:21 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1744226001; a=rsa-sha256;
	cv=none;
	b=Bn+2irFzqDC7p1HQ33YH7ZF89LEh8OP0pWG4RhC3vMszvMsia+OcGV+1aOZXHo8MzZyFjB
	UDlTOm+TB9axwjh8yf+/r0Pkw1n+GHXAXeN96ljT/82VANFElDr6X0F0RFTDC/De1P12Eo
	BduKSCDqSa+Exa28iX+fSh5iQ9fmeiokN4BEIEDpxJOxu8x5MNp3U072xojL3AyR70x9uK
	bqVxCBGv1TRQ+uVPkHgFQqYFkKGoEI5TmwQNkiH9JS57id9WezN0lNieIBufaVMDqjh2ps
	OM4AnYpn+vttiGjyUqLxLZwkf8Rko9BrvmidMvK10DJV0YFUDbIepb+ZD5RqvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1744226001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=XOz5WWzmAlZLAP4GrvGYNjV9yTTrVZ+lzKO/YPiz2Wk=;
	b=gxqD6WNsNnbuINHSGy1wSsxd+9tMlGyTWdjuh1t546+7Xtf4fWr6giDJ9ovNmsi9pQmzL4
	EAEXCC40traek1SOOleSPC3YWleWuuCSGqT4JS2bXW6EpeJ7vVBwEmm4pnNA7Wpn4Ry9Pr
	c738RQ5RJFOTMDBf/9A+MZvmPJgva5jvHEVtnWGRi9RqWMJ0NuNT0ouZycNt3vc1ZZlXrW
	FsiLXzxEtb8mxslmh4y26Hj+xJAHKglC9JrXvliYRPlNx0pCMPYDAv/mfBHkejBzfYhb4d
	Zyd6FBOM4I3JBAwXy0f0NvaTQT0dFE4ZZibi98hTayDu0LzxYgC001CFuD1lNw==
ARC-Authentication-Results: i=1;
	rspamd-6c89d5bdcb-pffrk;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=nico@cryptonector.com
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|nico@cryptonector.com
X-MailChannels-Auth-Id: dreamhost
X-Power-Descriptive: 49a2dead5558970b_1744226001763_3272045203
X-MC-Loop-Signature: 1744226001763:3214762336
X-MC-Ingress-Time: 1744226001763
Received: from pdx1-sub0-mail-a228.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.49.173 (trex/7.0.3);
	Wed, 09 Apr 2025 19:13:21 +0000
Received: from ubby (syn-075-081-095-064.res.spectrum.com [75.81.95.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by pdx1-sub0-mail-a228.dreamhost.com (Postfix) with ESMTPSA id 4ZXszh39kMz8v;
	Wed,  9 Apr 2025 12:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cryptonector.com;
	s=dreamhost; t=1744226001;
	bh=XOz5WWzmAlZLAP4GrvGYNjV9yTTrVZ+lzKO/YPiz2Wk=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=loisl9omPSu1DrxODEast3biU4cccBrY32BFdQ19jQZSpVobVpUV9UfvcB/Hdjxwe
	 +TZGBBDN57ClZCl71o2IChXa8NnBPsHYMw8+xhAqKtOe749+Ubh5wH/U02NmfOWklu
	 za9pXQEtZqWQNJOSV7uGaSZyPJEBDs1hUjCmD1jZN4kGrTkdLjgfSACKla8FJy3itG
	 30prALzNswzFiu8mT4hOuxAzf75+ffzV5FV80f50M3kRAo4VgT7llFY4T0hzogYRFv
	 xd1+G62+qWoBl3cWuDW7HxEVjaXDNDqxPgISnpTs2jANrNvfu+BAPJXkEn8emE9Agn
	 D5D7GljZ8z4Nw==
Date: Wed, 9 Apr 2025 14:13:18 -0500
From: Nico Williams <nico@cryptonector.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Theodore Ts'o <tytso@mit.edu>,
	Martin von Zweigbergk <martinvonz@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Edwin Kempin <ekempin@google.com>,
	Scott Chacon <scott@gitbutler.com>, remo@buenzli.dev,
	"philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Subject: Re: Gerrit, GitButler, and Jujutsu projects collaborating on
 change-id commit footer
Message-ID: <Z/bGzvDfsIcclBW+@ubby>
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
 <xmqq4iyzn0vn.fsf@gitster.g>
 <Z/RFQY433muaCW44@ubby>
 <20250408125521.GA17892@mit.edu>
 <Z/VGYrrVZYQ13TLj@ubby>
 <20250409121924.GA148735@mit.edu>
 <xmqqlds9trwv.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqlds9trwv.fsf@gitster.g>

On Wed, Apr 09, 2025 at 05:56:16AM -0700, Junio C Hamano wrote:
> It is not "simpler is more manageable".
> 
> The early days' design decision, which still lives to this day, was
> a bit stronger than that.  As can be read from [*1*] (which by the
> way I consider one of the most important message regarding the
> design in early days of Git), the design started from "recording
> renames is pointless".
> 
> *1* https://lore.kernel.org/git/Pine.LNX.4.58.0504150753440.7211@ppc970.osdl.org/

Allow me to withdraw my use of similarity heuristics for renames as an
argument against similarity heuristics over change IDs.  I still think
that explicit change IDs would be better than using only commit
similarity heuristics.

Nico
-- 
