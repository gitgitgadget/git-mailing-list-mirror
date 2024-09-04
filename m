Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0603281723
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 18:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725476193; cv=none; b=QHuoU6XcFoLCEt02WTbO53uiIXHxO22nCntI9qrhFODD8impUrHmSsbcWWh+l9YMPfyYkZOYJoVTawlRyeIlWsMH13FLXMBsV5U7IZ9CEClZPGq/tqEJW/TgZCEKw10XOtgtxBIgZaMNRqvsCLIg6P9WE+wq53Zcw7lju1+uo6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725476193; c=relaxed/simple;
	bh=F2jaBVL1KhPUxtGyv/ICo1V1ZimR2JYlAqmStbCuryg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E5foEUWBGRJE+88NxliGWtTcW6WzHevSCdGrdatAiq1pzbBw/CSvTQahCZai20t0pxxvlOMrLkN9cP18yO+NIjbxXtzYaw2SDmRcB80FCR581TbVI/dKzRACBWqLr+vJUKha5sYz7BEA9Bz2DuZdCRkIq74BgiAbX8phgG46b6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=emLVXQIZ; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="emLVXQIZ"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CB7931EFA8;
	Wed,  4 Sep 2024 14:56:30 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=F2jaBVL1KhPUxtGyv/ICo1V1ZimR2JYlAqmStb
	Curyg=; b=emLVXQIZz6eLj9A6fKv3oDPTU+yH20c9WOtAEbvC3GKhXK3BJBAUnY
	sEqnZjU75tlmtenQPPEgLJ3gOJWRbTe+hVEOWhfRx+Qz8xQ+5a6/1QndTEQ/Byv4
	vVzGOphJdcoB6AoRT6pD5daNRDhtWk+GSR15FIudT9rUQJLsnQARU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C27101EFA7;
	Wed,  4 Sep 2024 14:56:30 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 345B11EFA6;
	Wed,  4 Sep 2024 14:56:30 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/5] pack-objects: brown-paper-bag fixes for multi-pack
 reuse
In-Reply-To: <cover.1724793201.git.me@ttaylorr.com> (Taylor Blau's message of
	"Tue, 27 Aug 2024 17:13:24 -0400")
References: <cover.1724793201.git.me@ttaylorr.com>
Date: Wed, 04 Sep 2024 11:56:27 -0700
Message-ID: <xmqqv7zb8cys.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 65601958-6AEF-11EF-BC89-9B0F950A682E-77302942!pb-smtp2.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> This series fixes a couple of issues (some cosmetic, others less so) in
> multi-pack reuse noticed when rolling this out over a few real-world,
> internal repositories on GitHub's servers.

I cannot claim I got all the detail that went into steps 2 & 3
right, but I was irritated enough that the topic was left in the
"Needs review" state, so I gave a look at the tail end of the
series, and they were pleasant read.

Thanks.

