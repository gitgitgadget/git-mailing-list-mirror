Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C78380C04
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 23:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727222003; cv=none; b=T5o5loNJdYrxBDzq3DqcY9M3jxzCD07QevsfiJMhlL3e/l3WxxuzbzExrDpfxuPJQNAjPkGYmOd8Tzkw0YqpDsO10g4eh0J7JTuKe5yRzN1dUuirDqOTKzY2igKkvMMdOGacO5+RTQ1I68JJPRAe9ghPOrMHpsgKxUyaM5zYXN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727222003; c=relaxed/simple;
	bh=dysLVl+G73yrh9W0jsg+BczGd11TiPysKTpC58a2Wpw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Xf8RhKVwmruD8P7ZcODsLWXnXMke1M+G6eBU3aQyL0s5kxrhadAitNCkQ6gbLM6hVc0sFX+Y89OtLkEvKmZnyRVgVcwH9LdLbx6ZRQ5ceyZ6C3He3Jk31WRJgO5FHJe/IaEW4jKddsbVC+NKEm+hywbH/qtLraEqO1M4fYL99RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=RA1U7tkx; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RA1U7tkx"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 76CB61C3F5;
	Tue, 24 Sep 2024 19:53:19 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=dysLVl+G73yrh9W0jsg+BczGd11TiPysKTpC58
	a2Wpw=; b=RA1U7tkxoe4g4TTa8h8w4BrJqQ5A18QzUdff0F20hBsUcXbxYN6aj2
	VI9+UIGOIgpH1AN1TlKoWkfLw5y0MCGBdB57/nn/P5Eygro8XACN8BaD5//kcSAF
	+T/G3gsv454uPJtXlW8qFyQ8shiiLOiDfDDW+6dkn55/B1RlbrgFg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6D5E71C3F4;
	Tue, 24 Sep 2024 19:53:19 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B51A01C3F2;
	Tue, 24 Sep 2024 19:53:18 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org,  Matt Burke <spraints@gmail.com>,  Victoria Dye
 <vdye@github.com>,  Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
  Kaartic Sivaraam
 <kaartic.sivaraam@gmail.com>,  Todd Zullinger <tmz@pobox.com>,  Johannes
 Sixt <j6t@kdbg.org>,  Toon Claes <toon@iotcl.com>,  Taylor Blau
 <me@ttaylorr.com>
Subject: Re: git-scm.com is now a static website
In-Reply-To: <c3e372f6-3035-9e6b-f464-f1feceacaa4b@gmx.de> (Johannes
	Schindelin's message of "Wed, 25 Sep 2024 00:07:05 +0200 (CEST)")
References: <c3e372f6-3035-9e6b-f464-f1feceacaa4b@gmx.de>
Date: Tue, 24 Sep 2024 16:53:17 -0700
Message-ID: <xmqq7cb0r4lu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2C599CB0-7AD0-11EF-BA62-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> almost 400 weeks after Matt Burke started the process with
> https://github.com/spraints/git-scm.com/commit/60af4ed3bc60 of migrating
> Git's home page away from being a Rails app to being a static website that
> is hosted on GitHub pages instead, today marks the day when Git's home
> page at https://git-scm.com/ has finally moved. Or actually: yesterday
> (because I took so long writing this email that I ended up sending it
> after midnight).
>
> This was truly a team effort, and I would like to celebrate everyone who
> contributed:

Thanks, everyone.  It is great to see such a long-lived effort come
to successful completion.
