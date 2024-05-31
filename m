Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD506153BDE
	for <git@vger.kernel.org>; Fri, 31 May 2024 08:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717145017; cv=none; b=PjHvW6m1VIOzQDtiYm/S45MR1aUEKWZxRBXOALzNEIm6z0Mbk2OOli+MumQ66fQiDS+n2/8S/eTVBAy5uOvCwjn6tAN6hnC52uqiLb616kuZe8PMf9PLR4lY1n5qMFn7QPX1gR1pgo1Q98c7XWECRe60SEjXtgogvG6GCIBPt84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717145017; c=relaxed/simple;
	bh=c8JFZAxdPa5azBd0eVbF6CqQiU63yestGMnEecXMFx4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CjR4TDXfAPzFRIqUmrTJYfdGhj8UfY6SkZu28etP66HybOsAdTyreTH6Lheg1Vm0pzK0fBxAILfACWawoD8sI7nOvtiVRF8F9OV7X0a9q3WVUz/k7eIuvVLQsVvqJ5PwCYO2DnS2LrhunEIkuyaNkxYeQeGBU6v4T/EqCmEC1P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=AUtQPBbS; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AUtQPBbS"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 3BDE039039;
	Fri, 31 May 2024 04:43:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=c8JFZAxdPa5azBd0eVbF6CqQiU63yestGMnEec
	XMFx4=; b=AUtQPBbS/JMHh/KzBQtlX7QX8MJIv15AXYXmcvDnlnZhmDIssa+FDv
	VRd0IUdQw/bJlwW04j5VBMFHCtiw3vF3wBDgaRFLdRzwjjZJB+VxKqQy78tUsacp
	m8QitXhWYL5c3rq8IpLHgfusyxdnzp7KrZnBmRtaIEUrCQ1COrwmQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 338C339038;
	Fri, 31 May 2024 04:43:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 14CF939037;
	Fri, 31 May 2024 04:43:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Phillip Wood <phillip.wood123@gmail.com>,  Justin Tobler
 <jltobler@gmail.com>,  Dragan Simic <dsimic@manjaro.org>,  Karthik Nayak
 <karthik.188@gmail.com>
Subject: Re: [PATCH v4 0/4] docs: document upcoming breaking changes
In-Reply-To: <cover.1717141598.git.ps@pks.im> (Patrick Steinhardt's message of
	"Fri, 31 May 2024 09:56:27 +0200")
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
	<cover.1717141598.git.ps@pks.im>
Date: Fri, 31 May 2024 01:43:30 -0700
Message-ID: <xmqqr0dijrrh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DC3F1464-1F29-11EF-95C1-ACC938F0AE34-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> You may have noticed that I dropped the "Upcoming" prefix from
> "UpcomingBreakingChanges.md". This is supposed to reflect the fact that
> we also have a section that point out features that we are _not_
> deprecating. Those aren't upcoming, so I thought a rename makes sense.

I do not mind missing upcoming, but why markdown?  The mark-up we as
the project chose is AsciiDoc and unless there is a compelling reason
to use something else, we should stick to it.

Yes, README.md is not AsciiDoc but that is primarily because what
GitHub does on the project page.
