Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A8479F9
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 04:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kFDRaqvb"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9B59E1D3B16;
	Mon, 15 Jan 2024 23:56:22 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=/do+DIpQ3kZQqRqf/AkcXITkQUsXtn0XRDIeEP
	SmVKI=; b=kFDRaqvbrk3mlHazSCk2NRpnI6gUzWhDOTFZRCZlhKi4tT5zSegw1z
	yvXmVI/FRzpCbdxEVPlulaYwd52/+e5aVKsXsWqSx2Rc3I9IlzOtKb/GzMxFtozJ
	m30vxsvnnrkKcxwoRiv+DIsf7WUDU3zJDojk5kFQs8OWDQI8rmHmY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 938B61D3B15;
	Mon, 15 Jan 2024 23:56:22 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0CC2A1D3B14;
	Mon, 15 Jan 2024 23:56:21 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,  Git List
 <git@vger.kernel.org>,  Taylor
 Blau <me@ttaylorr.com>,  Dragan Simic <dsimic@manjaro.org>
Subject: Re: [PATCH] advice: allow disabling the automatic hint in
 advise_if_enabled()
In-Reply-To: <20240113073828.GB657764@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 13 Jan 2024 02:38:28 -0500")
References: <7c68392c-af2f-4999-ae64-63221bf7833a@gmail.com>
	<c870a0b6-9fa8-4d00-a5a6-661ca175805f@gmail.com>
	<xmqqsf326vpn.fsf@gitster.g>
	<20240113073828.GB657764@coredump.intra.peff.net>
Date: Mon, 15 Jan 2024 20:56:20 -0800
Message-ID: <xmqqttnd511n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 97EFD1AE-B42B-11EE-AEA8-25B3960A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

> For a tri-state we often use "-1" for "not specified". That has the nice
> side effect in this case that "if (level)" shows the advice (that works
> because "unspecified" and "explicitly true" both show the advice. And
> then "if (level < 0)" is used for just the hint. But maybe that is too
> clever/fragile.
>
> Of course that means that all of the initializers have to use "-1"
> explicitly. So zero-initialization is sometimes nice, too.

;-)  100% agreed.
