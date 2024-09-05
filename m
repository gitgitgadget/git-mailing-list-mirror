Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FE479DC
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 18:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725560714; cv=none; b=RBMwuC+fRBkZbat0n24QcaCZN3yAB2aUJEnQ0td1enaJDfsbP4wQtj8gs5qM7aH8Lr9uVbRAPVpqHZ/zoIZOZdyiT6VNi4B3TuCMMOqdKeNNCMvMdUxD8w5lZsjOOweb7Cj22YviVdMqO/ruNPjyM4P2beLP4pnwFgbjlAJoBc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725560714; c=relaxed/simple;
	bh=/xst5zXTgVJO0ZdIopy3NN/0rC81N9Kufxla2pa2Bak=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OYr16X6pNYkpLyDbtcjUXF/FkW4mlOnctKFMqm3wx48YH/7I74DIS+o0h8mjgFqz56dngPPFWn29xMq1yF5hUeUv2a7IxAqnUU37n7+Mt+z6vSiJ/bHaBLweuFCIHHsEdp9Qom3/IDRn9ncG78w8r8s2CuWP7xH00kZhEDOOJMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=mH1Z+Ta5; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mH1Z+Ta5"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 574342DCD7;
	Thu,  5 Sep 2024 14:25:12 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=/xst5zXTgVJO0ZdIopy3NN/0rC81N9Kufxla2p
	a2Bak=; b=mH1Z+Ta5AdeDMMtevY3oXoBPK7/dbyZtJ/vg1ChAtI7aF/oisILQtY
	xUhV9TH6t66+AeMfUUbydfI4yroRKOd7/Z/cSKCwCxxHvCnihtONr5yXRgS70RQE
	Wqke4s5KEXUieVQzVF+ynXRGIGZpPEDTINi6xWzbBkAh/P5rTrlm4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4D5502DCD6;
	Thu,  5 Sep 2024 14:25:12 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A2D7C2DCD5;
	Thu,  5 Sep 2024 14:25:11 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  johannes.schindelin@gmx.de,  Derrick Stolee
 <stolee@gmail.com>
Subject: Re: [PATCH] scalar: add --no-tags option
In-Reply-To: <pull.1780.git.1725545614416.gitgitgadget@gmail.com> (Derrick
	Stolee via GitGitGadget's message of "Thu, 05 Sep 2024 14:13:34
	+0000")
References: <pull.1780.git.1725545614416.gitgitgadget@gmail.com>
Date: Thu, 05 Sep 2024 11:25:10 -0700
Message-ID: <xmqqwmjq0xh5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3016A2BA-6BB4-11EF-BB04-9B0F950A682E-77302942!pb-smtp2.pobox.com

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Subject: Re: [PATCH] scalar: add --no-tags option

Micronit.  Shouldn't we make it clear that this is about the clone
subcommand?  E.g.

    Subject: scalar: add --no-tags option to "scalar clone"

or something?
