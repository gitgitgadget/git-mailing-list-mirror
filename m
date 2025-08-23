Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5675C393DD8
	for <git@vger.kernel.org>; Sat, 23 Aug 2025 21:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755985659; cv=none; b=ITw66QxnOuAMeEnRF8XDfj7zEZ1yE7VcLGZVxms78vFJYAU3TLwTD1HiZ1SCkEWpOxrNGWuBN5Rd/s9rmNuIylKeZ1U/Yei7Ei4c0wLV2X3P3pSlODjSgED2aK9cBBx6tOwUxSC+p+QVRJ2k5f2MqWYgdFcniGfBQa00s4irh34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755985659; c=relaxed/simple;
	bh=zPO+H3uUlzHBmdalSfIo5eXIT8drmeuWPxtPU8AeBSY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NugYH627Uu/DAwPKgYAFFOUgvEzUA+WBE7uhqlzNT4XlyfkWaZqu3eDdjHWLvyGHUGQjKit9kyEMCVZ2Ux0MEqIgnGXgwVZz3tFa7J1rrztZ2bTRjZa4I+WZH9XMJFcBljdufIjvBBWxMiru8YAf8BZtfs9irL1IeMLPcglsNhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RahiA1Wy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VTLpkPxb; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RahiA1Wy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VTLpkPxb"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 627647A0065;
	Sat, 23 Aug 2025 17:47:36 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Sat, 23 Aug 2025 17:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755985656; x=1756072056; bh=36YoYwAhYf
	YXXA6jgZdwhHkkdbFNRL8s/EVfC2EU4bo=; b=RahiA1WyWR05Ors/GLlnmASAg9
	GmU9Xz+c/RDhCmOz5JNu5KipF9l8xpHXGaaHVg9oNkIDZ9TroOZZulVz6nfC5y0e
	CcUDQawK3lMw+J3CXlEpVIbAHf2Fz6/jjqujxzbNDAF9ry/rfsnZ+Enhomo73ZRS
	m47ezaaBTaSem7d5SSV9M1LS0rj8siDYg+IIA+fsYDLR49Qb6lUuIwVACWCpSHDJ
	TgyhPmc0Gf/Aa/1VYMLvlwJbwtYSxcvOVV4DACARpJvcKCQyTkmfhw5ppqXtzDHt
	9QcYEESs9JHXR5iBvmgws306EoItOHnAWLnG0lgixKFePuKNOk8mHt/o2JHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755985656; x=1756072056; bh=36YoYwAhYfYXXA6jgZdwhHkkdbFNRL8s/EV
	fC2EU4bo=; b=VTLpkPxbZfUvDdH5C8bzlR0hQcmC084X3g1wVGrs5sGMCqKVfIv
	6UTn03dyuh2TbxqN5TBoMg2Zb4cUkbTx0/xR0OcwnojGrWeWRcoBF6x5uao5JVRd
	qfoTWwohPof/6tNUPV2BPRwT+xDKEiHA+h1lHKknJmLS3GNvQcID3mbzGPoHRY7b
	t8yNEWL/JxPg7HULwvcBwNJO6NVzGlHWgPoyVLA8Y5mz5xGWojDhdqxVY3E+bHrR
	UBxXF2m94ZmHrBrgJni1rLT5iXuBd9z0pdi0GYr2wNPaz72DMS68YYuswqRUGkMh
	7nO1Pn0T16uTE1v9+GBigIPR5ETgYVG5McA==
X-ME-Sender: <xms:-DaqaGPSxE3G7gwlMOiOALdvVbkEPQ4-kMYGjSXLOEUSbSWdaA9Z5A>
    <xme:-DaqaNbg2QcIk99LpfItEQwZLYQvb2U0s1Fvy1qchlnb9yJWRrDP2zyYjlTf5DE6T
    tVlTr0eQoFwGBTzTQ>
X-ME-Received: <xmr:-DaqaNtu-tSYW5pxjVBVp8mN1Jkyoz9Lfz-QC5dU-ozV68w6_NeFpyrdVa9bnPMKrv_oUrT_umynVMc0raS4F8_dHbK_-fcoioFX1Ec>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieejjeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtoheptg
    grrhgvnhgrshesghhmrghilhdrtghomhdprhgtphhtthhopehnihgtohesfhhluhignhhi
    tgdrnhgvthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:-DaqaHPEkzBq_ACxUdXEJoSKyNfjwxyylEk-T9NX7LI9HdhH0uxmTA>
    <xmx:-DaqaM4VntTqp2GZJkTexpC-T_SrzgtyKEO-9H7k51wwgnXsDeb1qQ>
    <xmx:-DaqaFTT1lrct6SLYLmAWlcyL9FUZCjv2XLANai8FPkjNkh5gotH-w>
    <xmx:-DaqaBB3k1d3bDAayb2ihPxZCxL7fBBhMfActo6nsqEmWNvH-5OgSw>
    <xmx:-DaqaD23z0l0MCFHwsTX7jAuapbNvv9N0vmgGc7sz4Cz8rV9yFt3Sj9S>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 23 Aug 2025 17:47:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
  Nicolas Pitre
 <nico@fluxnic.net>,  Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= via
 GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 0/2] progress: replace setitimer() with alarm()
In-Reply-To: <xmqq4itxvi3z.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
	23 Aug 2025 14:33:04 -0700")
References: <pull.1960.git.1755955377.gitgitgadget@gmail.com>
	<86bf04c7-6315-46ef-8297-42efc3ed322d@kdbg.org>
	<xmqq4itxvi3z.fsf@gitster.g>
Date: Sat, 23 Aug 2025 14:47:34 -0700
Message-ID: <xmqqzfbpu2vd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Operating system folks may have worked hard to minimize the cost of
> system calls to gettimeofday() in order to help applications that do
> so, but I somehow feel even dirtier to hear proposal to do so to
> replace a signal that we set and forget, to be reminded once every
> second.

I actually think this is probably fine.  It is not like we are
spinning only to wait.  Every iteration we are doing useful work,
and modern gettimeofday() implementations would be fine with this
use case.
