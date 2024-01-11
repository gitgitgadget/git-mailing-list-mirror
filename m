Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AB753E16
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 19:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tlf+6B69"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0271D1DC580;
	Thu, 11 Jan 2024 14:37:39 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Lkv2ub/fzMrk2GLubY/Lykj02XfiaMwkwBd0N1
	uftls=; b=tlf+6B69NxpWiLmYXWRrqkFPrh+1Huhknxh3gY68UxflHE01/r57u1
	Xg6gJ1iG3oVvmBVfmEWnzPDzJ4G6wu+K5ICYqr4m7T3FrnZX6ghG9sJs7p0JPpGq
	Kctl7PYBc7YczR8UqDZvBcEO4AI/tyyexDcAMMc/Lu2b1Sqt0JF5I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EE0D61DC57F;
	Thu, 11 Jan 2024 14:37:38 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5827D1DC57D;
	Thu, 11 Jan 2024 14:37:38 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Michael Lohmann <mi.al.lohmann@gmail.com>,  git@vger.kernel.org,  Wanja
 Henze <wanja.hentze@bevuta.com>
Subject: Re: [PATCH] builtin/revert.c: refactor using an enum for cmd-action
In-Reply-To: <1ed0e249-dab9-4cf3-9b76-c8797b97c9c5@gmail.com> (Phillip Wood's
	message of "Thu, 11 Jan 2024 16:57:26 +0000")
References: <20240111080417.59346-1-mi.al.lohmann@gmail.com>
	<1ed0e249-dab9-4cf3-9b76-c8797b97c9c5@gmail.com>
Date: Thu, 11 Jan 2024 11:37:37 -0800
Message-ID: <xmqq5xzzhda6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E09A9694-B0B8-11EE-984E-25B3960A682E-77302942!pb-smtp2.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> I think ACTION_NONE was intended to covey that the user did not pass
> one of the OPT_CMDMODE() options like "--continue" as there isn't a
> "--start" option. I don't have a strong opinion between "_NONE" and
> "_START".

I agree with you why NONE is called as such.  If "revert" does not
take "--start" (I do not remember offhand), I would think it would
be better to follow suit.

