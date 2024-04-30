Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F94199E96
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 20:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714507958; cv=none; b=msOPJrzt/PJa75FcNKAkABVEmV5NaXXOG58CXdgVoO9piYGuaWsEyK0/kxLKw2nyXadOJXg5+p7vDYfFMy3ks70bPZjtC+nuYOgGx4CV3JZg/F+uqEy8ZWnLOhxByOnmFUXnzj4y3yLZ+isJY2crnD+Vw06W9VmaqsdA69jLplQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714507958; c=relaxed/simple;
	bh=vu+1PEfefMriwDxttTT5yC1aOlUe4ZeKOTFzNsgDTWU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=csQZ11DBRcL00YH9WTVMblOsXw9gn9Z+PTe62Q3sYVJwPBgoCOjZnuxd4uYowhFLLpVP+Ank4WrVa1YgT/F7fERglPpOSIb6HuXQYDJ+tCNWENxbP4FQy1fLxY/ux71/WZy8JbyuqdlgwGzTQBhgzB/S6DQx9wRO4YHIl3curpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=i901qEkB; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="i901qEkB"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8613F2D5CF;
	Tue, 30 Apr 2024 16:12:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=vu+1PEfefMriwDxttTT5yC1aOlUe4ZeKOTFzNs
	gDTWU=; b=i901qEkBbhA86B7ZFL3TyHiJD9vI1UqU5ZG9b7V464dlRGwAUIMb9/
	9IJZwwLFOn9P93ODEAV9FAK+00fn6O0jI6pjRudhnZ6GAewETUrIkYPUypn7mD9y
	WIU6ZjUSNqJwEX10qgEgeW7qSV4s6lRR1pO4/bDGHtjIJy2QYcHRs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7BFAD2D5CE;
	Tue, 30 Apr 2024 16:12:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E1D0D2D5CD;
	Tue, 30 Apr 2024 16:12:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Karthik Nayak
 <karthik.188@gmail.com>,  Phillip Wood <phillip.wood123@gmail.com>,
  Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 01/10] Documentation/glossary: redefine pseudorefs as
 special refs
In-Reply-To: <2489bb558543d66592fb0f3eb4d4696ba8e31fea.1714479928.git.ps@pks.im>
	(Patrick Steinhardt's message of "Tue, 30 Apr 2024 14:26:23 +0200")
References: <cover.1714398019.git.ps@pks.im> <cover.1714479928.git.ps@pks.im>
	<2489bb558543d66592fb0f3eb4d4696ba8e31fea.1714479928.git.ps@pks.im>
Date: Tue, 30 Apr 2024 13:12:33 -0700
Message-ID: <xmqqttjiy5hq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FBB19632-072D-11EF-A3F2-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Let's address this mess and return the pseudoref terminology back to its
> original intent: a ref that sometimes behave like a ref, but which isn't
> really a ref because it gets written to the filesystem directly. Or in
> other words, let's redefine pseudorefs to match the current definition
> of special refs. As special refs and pseudorefs are now the same per
> definition, we can drop the "special refs" term again. It's not exposed
> to our users and thus they wouldn't ever encounter that term anyway.

Good intentions.

I do not agree with "the ones at the root should not be special" at
all, though.  We need to reject names like 'config' somehow, as long
as there are users who use files backend.
