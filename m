Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5261E77658
	for <git@vger.kernel.org>; Tue,  7 May 2024 22:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715119336; cv=none; b=raq/q0E2lgyo9vavw9J/eG4sdhnK2MJynyubak4nhUIX5KEJ6OZIg16VZwWJxgiduJLY4p4kelLB21Spp9a7yiZXUVGTa0FO4zLRtKCIQfkqEln5kOiN0PLoYDHesG85epJZs/vgoBsTt687x0zV9yN5O9q6OvyeTU54KHuc5Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715119336; c=relaxed/simple;
	bh=t1JOZnkBVbjvTJsYRRLMtbz0o76m/PWemsn6jXIRzJY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mna+Rc1egsYsGZ8jwrkmCtwT4HAfSYGGPsGW8i7oZO2gS31BSbQjoTOvEi62v9vgj7Z2RzQflQxROsNdi2NKxEw7bFCaPVwdqHxfHgjcKKH7JJ0mucmXKkqITgeNiDAIYIx09f/iA7JNaEJXNRrbZKB1rUrSLdLW2kOGsaJtuHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=oYWcgp3e; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oYWcgp3e"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C039F3483C;
	Tue,  7 May 2024 18:02:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=t1JOZnkBVbjvTJsYRRLMtbz0o76m/PWemsn6jX
	IRzJY=; b=oYWcgp3e3MmEZlw5aRyA74A1QOAq1nFt+gIx1deI6oVzTL3cNnu4iD
	RPvUCvUqAR5MXa5f3Vj8tYSr5qKwHAc4ivIqUPoQv7VUI7GPP8TKLpZttny4pxPw
	+h51qh4BPiEUNryi3rrO+qDjaeI+uzQ4JVQLhQu2OGJ2qkZtIsJvI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B9B6B3483B;
	Tue,  7 May 2024 18:02:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2F1F034838;
	Tue,  7 May 2024 18:02:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [RFC PATCH] docs: document upcoming breaking changes
In-Reply-To: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
	(Patrick Steinhardt's message of "Tue, 7 May 2024 10:27:18 +0200")
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
Date: Tue, 07 May 2024 15:02:09 -0700
Message-ID: <xmqqle4lnuvy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7458AFFA-0CBD-11EF-9820-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Over time, Git has grown quite a lot. With this evolution, many ideas
> that were sensible at the time they were introduced are not anymore and
> are thus considered to be deprecated. And while some deprecations may be
> noted in manpages, most of them are actually deprecated in the "hive
> mind" of the Git community, only.

There may be a new way that we hope is more suitable for folks who
are learning Git today that achieves the same goal as an old way.
It rarely means that the old way goes away, even when the new way is
more capable than the old way and the use case the new way covers is
a strict superset of the old way.

Such an introduction of a new way is *not* a breaking change.
Everything the first paragraph talks about is a "deprecation" that
does not break anything.  Documenting them is worthwhile, but it is
worth pointing out that it not what the title of the topic "upcoming
breaking changes" covers.

I think you should explicitly say that we deprecate but rarely
remove and old ways are kept for backward compatibility in that
introductory paragraph.  Then propose "But we may want to remove old
ways and deliberately break at a large version bump every 5 years".
That will lead your readers more smoothly to the next paragraph.

> Introduce a new document that lists upcoming breaking changes to address
> this issue. This document serves multiple purposes:
>
>   - It is a way to facilitate discussion around proposed deprecations.
>
>   - It allows users to learn about deprecations and speak up in case
>     they have good reasons why a certain feature should not be
>     deprecated.
>
>   - It states intent and documents where the Git project wants to go.

Another thing we may want to describe in such a document is what we
do not want to drop and why, even when a new way that is a superset
is available, which would give newbies with a natural "why don't we
force everybody including the old timers to adopt new ways" question
a reasonable answer.

> The document is _not_ intended to cast every single discussion into
> stone. It is supposed to be a living document that may change over time
> when there are good reasons for it to change.

I'll stop here, as arguing how an individual bullet item is not
appropriate (i.e., deprecating it is a bad idea) should be left for
later stages of the discussion, after we accumulated more ideas.

Thanks.


