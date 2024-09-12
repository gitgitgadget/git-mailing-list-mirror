Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453AD1BFDEB
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 19:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726170078; cv=none; b=lXc44X/w7oCLSzTktpFIChMyIpsom1X/p0Wc+QGleViR9vwAbeMzVNHNBccipMrC90gU7BicSHGCYBDVsBPnLysvJwpQzcrtSgyS7cuojyorNWoG9XvuHq3N7mAdF9JERe4a803tY9iQklp9REE5K4nCGOcrMaQ6j7D8SnkSHTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726170078; c=relaxed/simple;
	bh=ejOKnjzeSKgA3W7JeZ7wYbHiIf8muFHkcElrlMSSaRw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UPSCjSq7eOntiNgP/QGQSmThYOhOBC4jS4ICP6/sO5JGA4qORubdSN2dBPLnzXxcPNC6Usg4nM5/iPW7wbUY2qXctvqRoW0T53e3vE/nnnVU1w8ubMbxkE2utnwfebhZIX0QECIJK1PfroPkDGkED78uEsjEJKkbTT2i42zOtYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ge9i+eDH; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ge9i+eDH"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8C2622F70F;
	Thu, 12 Sep 2024 15:41:09 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ejOKnjzeSKgA3W7JeZ7wYbHiIf8muFHkcElrlM
	SSaRw=; b=ge9i+eDHVmUvbLKHqwVZTLNCICYKv8/5Vq+xl1qMjDrjakO+IFcZE7
	radPuOgVR+tdyk8Y0GYXlmS5VWZtu88YOVGSZZV4bRhhRKgRXYpneW+9WS0Fm4DD
	kn+fpLMGdV6u0cN7bHUJgDpfwERXgJOvGQNOMH0EdSzo48+5K6vls=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 850B52F70E;
	Thu, 12 Sep 2024 15:41:09 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DDD222F70D;
	Thu, 12 Sep 2024 15:41:08 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/4] make linux32 ci job work with recent actions
In-Reply-To: <20240912094238.GA589050@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 12 Sep 2024 05:42:38 -0400")
References: <xmqqy140o2kb.fsf@gitster.g> <xmqqv7z14y9d.fsf@gitster.g>
	<20240912075631.GA11676@coredump.intra.peff.net>
	<20240912080011.GA556677@coredump.intra.peff.net>
	<20240912094238.GA589050@coredump.intra.peff.net>
Date: Thu, 12 Sep 2024 12:41:07 -0700
Message-ID: <xmqqfrq44q3w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F54E8A5E-713E-11EF-A554-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Jeff King <peff@peff.net> writes:

> OK, here's what I came up with. I built it on top of what you have
> queued in jc/ci-upload-artifact-and-linux32, but it could be applied
> separately (and it should merge OK).

Will queue.

Let's target to merge this down to 'maint'; sooner the better.

Thanks.

