Received: from beige.aspen.relay.mailchannels.net (beige.aspen.relay.mailchannels.net [23.83.221.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940582701BB
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 00:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.221.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745369240; cv=pass; b=Jy2wWX5QpbcrReMX+z3Z8lDEdyhn8VA1dGhG+sGsKCkSapw6KQTcTOQemM3aG2r7m+dY9IsNymHA1UMx4rdN5ksWiPBmh6UQAs9QchT+fTY4GGOZSAYezhMqczBymo0RvVCqtkav/UY3hV5xXGrZYGAP507QqhMDFeTh93kVR5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745369240; c=relaxed/simple;
	bh=p4+gxJNcncDaZCOK2ZUrXV0nc0fbz7vCN2otEZgwg9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CmYLUh1pJ7xZplRJUqNZ7S4Tb3psYbG6Qop3lQvAPBXkWyO6d91x1jKUW3Zb4unlBfCjD38twgyY6RIm12ixpyML97HoX+HwGnRXLgXIVunlsLW1bRaEnsLxRz6X6vGAwT/QSkGtlQQNNVLMporiGm1pn10vB03M4ooeciwrI4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com; spf=pass smtp.mailfrom=cryptonector.com; dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b=aYb9VDr2; arc=pass smtp.client-ip=23.83.221.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b="aYb9VDr2"
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 1C05F261D5;
	Wed, 23 Apr 2025 00:32:04 +0000 (UTC)
Received: from pdx1-sub0-mail-a256.dreamhost.com (trex-3.trex.outbound.svc.cluster.local [100.110.51.24])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 9C13E261ED;
	Wed, 23 Apr 2025 00:32:03 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1745368323; a=rsa-sha256;
	cv=none;
	b=XgV7FGC3RZ39+wTu2tN+an3ApKb23AVVU07xikxOoINyHI7oSKUADCcc6qM7XhZWHNAdYq
	/txsa42pCLMWabmAOCSVoDcM29mdqLKpjm6wxtYkB+2XUczJCcMxSN4bM+G0v8rh58oqYo
	eEhitU8Np0+eZMfD55ypGia7Zow4R8f2OZ+XtnjQI7WFAyxr89ARDLBZaObIKzrhn1273D
	QAQWw4DxTdU8WUOQRAexN4BKQhNSIT34E6DinssD1VV7Ts0WOCksXsgkPEN5eYTU3F4tgT
	ZhRf7DPURt9/CLas4yQ9g8WaU0d6i0STkYTL9icXl+c20WH0MVmSXmGFZptZEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1745368323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=YGjFgCc287j1wfrGdvptvvPBEpGmiuNUt0GKMoeuYHA=;
	b=F8rwW28A757X6ZbCtVkOCQQEE2FEQ1VBXp0APT6qlu7pXiOFIEp1zNPZTPxQDFzkGxfKJm
	hFchyhtT7Hw5n8Ff0I0IcJHlIkl9DvKW25kszRaGftAV2bHwkG5V0Ktgm358wghtJsuyO0
	oOboy2W4c2S8wr6kC36XcwBtHyZU5z2KcB0t7MBgEOAAneQRgs25mbFJxmG/8eWkxZvLGJ
	jRcXTTz5J2U0GKF9g77wUOTQyc+1LDo9XdTtgw6r5TvfMTd+NZOp/pYoWTuoyxCNd01LXP
	oYNdtrkLHEtz9eFx4iLFl+g0ppFJ67cD0OHAIPpn5eRfUeVp/+F6pf6UHcAtuA==
ARC-Authentication-Results: i=1;
	rspamd-5cfcf5665-skzlj;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=nico@cryptonector.com
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
X-MC-Relay: Bad
X-MailChannels-SenderId: dreamhost|x-authsender|nico@cryptonector.com
X-MailChannels-Auth-Id: dreamhost
X-Name-Imminent: 2f0c593267050f91_1745368323908_4065909088
X-MC-Loop-Signature: 1745368323908:2873854041
X-MC-Ingress-Time: 1745368323907
Received: from pdx1-sub0-mail-a256.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.110.51.24 (trex/7.0.3);
	Wed, 23 Apr 2025 00:32:03 +0000
Received: from ubby (syn-075-081-095-064.res.spectrum.com [75.81.95.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by pdx1-sub0-mail-a256.dreamhost.com (Postfix) with ESMTPSA id 4Zj0RQ43Mjz5h;
	Tue, 22 Apr 2025 17:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cryptonector.com;
	s=dreamhost; t=1745368323;
	bh=YGjFgCc287j1wfrGdvptvvPBEpGmiuNUt0GKMoeuYHA=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=aYb9VDr2cF9EwFWvJAOXZ0Js/oBuLO4Ic3Bmvp6ccpshewUfQIK6XCvXFmyPMTRgG
	 27tJIDb6XtNoZLYCJVpw0kBwhUSqu1oajc8LKSYjq1WpioqIrmNs331Hu+RIPWk0BT
	 nUzO1WMyLfMIpTvGJdkXZblU/daBKHLJ2nGnK27/OGYG3yq5ULLp+2BkOHAI/hut0l
	 irGkAR/hVLy1qUTxKcEWoVZT8cQtBJrHLvL4OwZOWSrq8Uj2UHO8abJf0ODfUoBAzO
	 49/maYF+0qrq7Wi14QoF0PuzWb/JYg1SQdbNPz/ZocM/jCnKcN3lAMevlwX/u/tUR7
	 +TPnL4pFHwyTA==
Date: Tue, 22 Apr 2025 19:32:00 -0500
From: Nico Williams <nico@cryptonector.com>
To: Remo Senekowitsch <remo@buenzli.dev>
Cc: Junio C Hamano <gitster@pobox.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Martin von Zweigbergk <martinvonz@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Edwin Kempin <ekempin@google.com>,
	Scott Chacon <scott@gitbutler.com>,
	"philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Subject: Re: Semantics of change IDs (Re: Gerrit, GitButler, and Jujutsu
 projects collaborating on change-id commit footer)
Message-ID: <aAg1ALkWaRQswZtK@ubby>
References: <Z/VGYrrVZYQ13TLj@ubby>
 <20250409121924.GA148735@mit.edu>
 <Z/amMj/eg0RbXdkS@ubby>
 <CALnO6CC_Gvqhcxp4AknwM+YSsngv_0zngKb2XHXN4u0AvKEMMg@mail.gmail.com>
 <D9816I5AX1RG.AA4A7H2D8SJ7@buenzli.dev>
 <CALnO6CCjkxv40+5wZ_vwZTKv7Te8Xh--M1fY2wbuOfgJm5LZxw@mail.gmail.com>
 <D9DIPNY431IJ.23DG6UL5CIQJ@buenzli.dev>
 <xmqq8qnr3jji.fsf@gitster.g>
 <aAgdauFt/mdCY+GZ@ubby>
 <D9DKHI316ER9.PNEG774QLFL8@buenzli.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D9DKHI316ER9.PNEG774QLFL8@buenzli.dev>

On Wed, Apr 23, 2025 at 01:47:29AM +0200, Remo Senekowitsch wrote:
> On Wed Apr 23, 2025 at 12:51 AM CEST, Nico Williams wrote:
> > Using ticket IDs as change IDs implies a globally unique ID assigner,
> > and should work well enough where things like bugzilla are used.
> 
> This email thread contains recurring ideas of stuffing unrelated
> metadata into the change-id header (patch-id, ticket-id). I think we
> should be careful not to do that.

We, the users, have been doing this for decades by convention (i.e.,
starting commit subject lines with ticket IDs and putting all other
related ticket IDs in the rest of the commit comment.  Why would that be
wrong _now_?

> The purpose of the proposed change-id is to identify and track how a
> change evolves over time. We have talked about how those semantics may
> or may not be clear enough, and that's a good thing to discuss.

And ticket IDs happen to be very good at being this sort of change ID.

Sun did this starting in the early 90s.  They used a rebase workflow at
least since 1992.  Folks still do this in Illumos.  I'm certain that the
rump Solaris engineering at Oracle still does this.  That's more than
three decades of that.

Nico
-- 
