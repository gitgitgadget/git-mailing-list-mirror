Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B5D1A2C35
	for <git@vger.kernel.org>; Thu,  9 May 2024 19:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715282443; cv=none; b=E+POX6K++AaVEssW7rMtwx+5ir76UG9F+7p0g7uP/GEsDm+nW1GEoCr5CZ0CN2UpOC4tAF7Zieo+lSJW6izWgC0qq7uaNH5DZl+d66sjy7pMKOSHmizSojIIItZdUndAE1VXNoajwmU9Jn94eW4nLVOG5hMqUcbWwgnvgHi6Kcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715282443; c=relaxed/simple;
	bh=GeSs9FPfay2ewBp/C5skfyQr0aBjGkr/zQAylNdYrF8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZWa68h5gHoC9G3vUlJqQebZqA73FL+7aRZD+ZMXPM667Nb1R8RtYl1nBsz2u6AeZ6H+fOuOv1N6d5TmejLaoXb2du+X7sl6AFI6MrtrQxijgthobMMcOXE8EXMq0DCurlh14IlfilxXzNAEIbsDyrSxvVlHBv0pqyqCIxTvqu7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ByQ0aH6Q; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ByQ0aH6Q"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 909662ABF6;
	Thu,  9 May 2024 15:20:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=GeSs9FPfay2ewBp/C5skfyQr0aBjGkr/zQAylN
	dYrF8=; b=ByQ0aH6QMcdC5x2ZOXU/c0xehTyUlcrtPYB+t9PVpC7T9OTuh4X6YC
	/fIHIGzT3tkXyJE1nQP6vtZ6gGG+tVkycK/kYKhCT0kdIez7EJRDVrFyBvh5uwVU
	At3YHm73iv4HULy1H8zm5RpkMwcJg2zMO0Y+XMZRnTj0pZSHxm7a8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 8889A2ABF5;
	Thu,  9 May 2024 15:20:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 247F32ABF4;
	Thu,  9 May 2024 15:20:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org,  me@ttaylorr.com,  ps@pks.im,  emrass@google.com,
  nasamuffin@google.com
Subject: Re: [PATCH v2] doc: describe the project's decision-making process
In-Reply-To: <xmqq34qqua9d.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	09 May 2024 11:10:22 -0700")
References: <b2ef74c1b0c7482fa880a1519fd6ea1032df7789.1713222673.git.steadmon@google.com>
	<4a829792bf16973799bf3b3db0dd8b49a1ef3815.1715212665.git.steadmon@google.com>
	<xmqq34qqua9d.fsf@gitster.g>
Date: Thu, 09 May 2024 12:20:36 -0700
Message-ID: <xmqqy18issfv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 37AAD146-0E39-11EF-B263-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> There probably are small things that are missing over there that can
> be found here, but given the large overlap, I have a feeling that
> these additions are better done over there, not here, and limit the
> scope of this document to decisions beyond the "General" patch
> series.  There already is SubmittingPatches::[[patch-flow]] section
> that may be a better place for the material we see here.

To see how well this approach can go, I plan to spend some time
today reorganizing SubmittingPatches and enhancing some descriptions
in it.  The plan is roughly

 * Add a preamble to explain "why" you would want to send, and we
   would want to receive, patches in a larger picture.

 * Move [[patch-flow]] section to the very beginning, with a bit of
   enhanced description on the review cycle, i.e. what patches,
   their review comments, and review responses are expected to
   contain and for what goal.

 * Possibly remove things from other sections that would become
   redundant by the enhancement above.


   
