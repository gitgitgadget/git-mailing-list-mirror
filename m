Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AD214EC7D
	for <git@vger.kernel.org>; Fri, 20 Sep 2024 19:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726861790; cv=none; b=P/7JBeGjuazrm8yerKQ0iNZZlKVBEL7F8F0YMZydQ+jCtWUPiIfehprUMc19hrDeNAb5Cd7Gx65+BtoKR7ikBewGBnj/7yqrZcW3fx2jEFzD60QPoGO0/5PLW/qlfwvrzDtp8PCBsTJ5KFaIpLA76l7GaduawnSDJAbGZ/Sl/f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726861790; c=relaxed/simple;
	bh=lzULtvJNviYSHBUrZsP0Uaa6eSRipEqOqj7S4yRHhjw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V0tJkLnmM3pbpEjDLIYUvUuJcc/ECgkvEsyBBRfhE/QWmODArm/Z0LQgOUnAh/bQMjU3CDDUJcY1gHeHxRfnS+ljyP9ri0HT5nl1j3rzAdzHqDYFOtyyRz5XX8SANwx7jLVs1AzABQNE6gXZQHWPMiE8LIctPZ/1S6WIz2Wrnt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=clCDnn2U; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="clCDnn2U"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0BD4D1E464;
	Fri, 20 Sep 2024 15:49:48 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=lzULtvJNviYSHBUrZsP0Uaa6eSRipEqOqj7S4y
	RHhjw=; b=clCDnn2Ub8AbTIhDQhrD+TzJVAh9M1/vGyjHJUDsgRjWYaCV17lspF
	x8m8FYHqlyKt8BaCpIxKGvBargJsxBsbDNZDstmCsDfXtlrLXWrT7pqjOLXLBYSM
	ZWKpt7/qf49n+E8nIlUm4c/UQUGMllrUdOZsmYpgFBatFD6K91Ehc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 01F481E463;
	Fri, 20 Sep 2024 15:49:48 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6E7851E462;
	Fri, 20 Sep 2024 15:49:47 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: [TOPIC 10/11] Project Tracking
In-Reply-To: <xmqqployf6z5.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	20 Sep 2024 12:41:34 -0700")
References: <Zu2DmS30E0kKug2a@nand.local> <Zu2FMQnLCKQ2skkM@nand.local>
	<xmqqployf6z5.fsf@gitster.g>
Date: Fri, 20 Sep 2024 12:49:46 -0700
Message-ID: <xmqqldzmf6lh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7DB0B11A-7789-11EF-912E-9B0F950A682E-77302942!pb-smtp2.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Yes, either forward or backward.  Having to keep a series that looks
> potentially worth doing for weeks on 'seen' without getting any
> movement is *VERY* painful.  Would it motivate more experienced
> contributors to review and express either support or refusal if I
> more frequently, say after 20 days since its latest round got queued
> on 'seen', a topic that does not seem to get enough support to be
> merged to 'next' and is not getting rerolled?

Missing verb was "discard".  Instead of keeping the stalled topic,
perhaps I should more actively discard them (people are allowed to
send in a fresh iteration if they care enough)?

Sorry for the noise.
