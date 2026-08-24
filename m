Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A91C17993
	for <git@vger.kernel.org>; Mon, 24 Aug 2026 01:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787536194; cv=none; b=Q3fZDmW0yEBmPdT2Y4FFypaJWC0spkntWe2cQ/H8+N0IiwSbbzl/SFx1jY0RZKVwncDdUJL/vfcPq9L7Ug23/z0Z3Hyb9LnbdSumjCDyCvbr3mACu6/u5LguG3e7X70fy2NjCao6DHXRlv+eeNKsxLcYaXQ4Z+gSh4e/RnhgRCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787536194; c=relaxed/simple;
	bh=rzNEvEj2Ib3i5UJ8kmMMyJUl/oh7i7Vpv3+54SOK6KQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nT3vqPsQXAvrgKDcxAx4/1bmcjtaNeJaD+MiU53btR8zOU9Fud9+2C14d+wJfGRuIbDdfTn6cpmz4jsMJXdOCzfvF0pBaVH27CxtJFS0vGWydLVWKf9qibo2SQNAjukRJJJYR7O37mgsVbsYplnPJzBSrPtLI+G5F3ONQlC9Rig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LpYGi3Vu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eRqr/NN2; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LpYGi3Vu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eRqr/NN2"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A66F1140011C;
	Sun, 23 Aug 2026 21:49:51 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Sun, 23 Aug 2026 21:49:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787536191; x=1787622591; bh=AJHKR1kKOk
	fHNU+J9XCdZ2/kOrlVt80Q87RR4399tTM=; b=LpYGi3Vuux75Bee03SRI3ShwPo
	TKgQXrbdXQI9nZG1yXNVSd+eHE4NxplppMpd5ejZvI47r3ZMlGYplttwDjX9Luq0
	xYM93OT9YJWKKydrOViQ74o8D2rPlkcvnm3YYXq3TCzAYvdQ91Bo/n4WrjNsL3Dp
	5wEnFqoZeuKNCy85nFBRQj3nPh6BxatYacxXI7Q08WvBuQq0/U6VMGXmd5jfr8+I
	uU0zYDrYB3ZczMlK5v8ATaeZYSx55zmXMuh0rjRqVpahULYPf3vtrCly2zTpOKdp
	sCssgCPdStev44HAOeZkYwxtLrb2Pbtw/YkrwVdYooXaEL0CmGtvR/ZXGftw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787536191; x=1787622591; bh=AJHKR1kKOkfHNU+J9XCdZ2/kOrlVt80Q87R
	R4399tTM=; b=eRqr/NN25nwEK7oLI+NX+3suscbvmNoDABJ7894q9CyZVbJrLxX
	qe6HeFlUG+ZDyRSld1wUUSvEr5WwCJMI+wSWW3wWTOHfJ6jJlDkoVryQGpExCFQ8
	HU7um/govc2p9DWB6iFg2hdtQy3pnt6gvOGN0bkB9HlA43yBuaYOFA8qpaL9EmAe
	iEJr9y71sl3cAMm2P/ZMRwarmzOUHcKDxZqvQVCc/Z1qgmvo8rMBw9cmripTKv+L
	osVcLg0PXDSJil0SJSofjWcg4YkvdwK8fUeORsQA2mok5Nxia2PUoFeXHq8Wvbho
	pBzfI7vlBsO8kaBdEQZoTxnA7PLYe3Rm6JQ==
X-ME-Sender: <xms:P6OLaugiOe2cmA7npwr_6OVOLzVC6_xJGl_y7ukWYPZyBhCZcIKSOA>
    <xme:P6OLahRRXrO_zOjlKwGIL4GQdOGiDM4IKrD_gchbuy1pY9P2oNGg52YQb6ifJjDCu
    13cZjpWAXiz0eX7Zqmy2PeyzZwwhIP5HhrCGJnIe5514bFhtrRwE_c>
X-ME-Received: <xmr:P6OLaoVZtB1nVkkgMTjYz30V5KvaAZHAb46S9JXosYggvSistFthPDbw5Ed-tpvdagCzu6lFJDzpil7CYTYH-QFOKx88_GXLug>
X-ME-Proxy-Cause: dmFkZTEE3u2Z70B5+bMX1FKouWpn22IiphMqB/WRT7YOWaWULa/Nym9Wd2XD9i6VubEKFf
    3/+yDEnFjw+bPEqFLuD+DwtsfDInR2nl5w7REmWDMxjxJi6fGZ4ZSINbhaLA4iIdzTzPak
    oi+mHvg3iY6Fgw1ciw1RM011L27WZiBgxUpZzqXvG6T1jmzwRg/NsT7toqdWq2HctTEpa4
    0EPQ/AdTe+XxNY31aOwGDWNlITU3ov1IfNoDk3IeV7v0YmGRXxK5/oPmiUcPClH0J2OGQA
    eqCzmmb4hY3MoUVLYKNa5p6JhSVz613HihRtXXVTT57bwlZctY5ELmTJMGDn3gzMSm9Ikk
    ztEDPOe3p8TfU+aEYMRIXd3sJ48xWBbxvyNFHhqhC2aPR+Slbo3pwmRmR/zYYY4GFAYoNk
    1I3nG3xspqI5u+cj0U7+21MC8ocIBa+wjJZo1oE/PfBUCEe4bCY98zQeK/o6faAUPANXRD
    X/A/2gJ7hPZlZTR6Nyoa0Ipv5QOzQvQ3VM7MnQ+5lXvrd/rcSdMW2QS5g+SzT7teqFZXaQ
    hBUjJuEb56n8oKsqeT9Bj9Bm/yTV10q1fuHQ7Jq3jY3xX8myKeDqWb/FLt3RTC9zpt+6XV
    FOYMlYc/4clqYVxh+Y70Vr45dQbIGDZ3OGGUVzv27OGz6JMADb3t0auosxqg
X-ME-Proxy: <xmx:P6OLatQJgxnv07nbatATrD-qwcAf7YrHPs5mCBEgBezL9L000_fQug>
    <xmx:P6OLaql7xMaosTOhZyqpv5l_5mUHvGxpXay4cm4Zh-WNAePcqVQe_Q>
    <xmx:P6OLar7c2wiaNTUqrptt2Uz8EdzeR-7TQeWLWWO32-xkniG0wSUHoA>
    <xmx:P6OLaogM8gTNr963_KZWTw8z_CdDui92LAwLeTcwWjrndG_cpw4Hag>
    <xmx:P6OLaqConF0UFJnV5omrN9YD7zgN_N298CBOw5xdabIvxh7PpBiTRubc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Aug 2026 21:49:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Weijie Yuan <wy@wyuan.org>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  Alexey Samsonov via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Alexey
 Samsonov <vonosmas@gmail.com>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/3] treewide: migrate from legacy utime.h to utimensat
In-Reply-To: <aosVkqwcsmAWrDr6@wyuan.org> (Weijie Yuan's message of "Sun, 23
	Aug 2026 23:45:22 +0800")
References: <pull.2209.git.1787322203.gitgitgadget@gmail.com>
	<aonIVn-ZQoMKWCAd@fruit.crustytoothpaste.net>
	<xmqqzeyeujde.fsf@gitster.g> <aor07LvsXOy1p7vh@wyuan.org>
	<xmqq5x10vowf.fsf@gitster.g> <aosVkqwcsmAWrDr6@wyuan.org>
Date: Sun, 23 Aug 2026 18:49:49 -0700
Message-ID: <xmqqfr04thhe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Weijie Yuan <wy@wyuan.org> writes:

>> We know Johannes well enough to trust that his patches were sent
>> with sufficient due diligence.  So...?
>
> <xmqqzeyeujde.fsf@gitster.g>:
>> If work submitted under a DCO later turns out to be based on
>> something we cannot legally use, the submitter may of course be in
>> trouble, but we would also need to bear the cost of ripping it out;
>> the later we discover the problem, the more substantial the effort
>> necessary to deal with the fallout will be.
>
> What I meant is that you said we should be wary of content that might
> carry legal risks,...

I am not sure what your point is.  Is there any part in "we trust
Dscho well enough to trust that he sent them with sufficient due
diligence" that was hard for you to understand?

