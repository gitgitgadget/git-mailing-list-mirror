Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4BD2746B
	for <git@vger.kernel.org>; Fri, 19 Jul 2024 18:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721412265; cv=none; b=FGb0lHEYt+xRivQOcCQXJZApcpSIGKUV4O7cOiET9EvNZPXS3I1mL3Y2hFRVOT32IMcyQiDZ/yFVRXTK+vPGxMF9N9NR2G7vyOB5zCovdeKaCAKdQbISSEHLN1klXj3+qlkMkVbSxL6RX2dMC+wN0vnz5cuk//9/EAcmDdj1sp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721412265; c=relaxed/simple;
	bh=ePqW0lZZR2fw9KESxMClaelrZpjuSouUkL7y/lBOHJo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fv2pJx7q5oYYiHvxhaE/223tphgDs/WUfQ0PfwvkZ9nozvMTjlfDxE4IXmI1qQY94abFC8By2YvotaZTXVdUslw57LIAgQhTkp5eN4tX6vlDcx/aa02EIWnEeJKE6gFJRhAT6gfknHPHijDm91Y0gGJgIza81KP69ICBdauTKkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=bWkb6ot5; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bWkb6ot5"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3A07018931;
	Fri, 19 Jul 2024 14:04:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ePqW0lZZR2fw9KESxMClaelrZpjuSouUkL7y/l
	BOHJo=; b=bWkb6ot5DWZRUYGNFwghq7m/ZQpNeZGS4xbQNjyE0gGHO0+6QPT+HH
	XVy7/6mZQywl/HqeotD5C/+9GDC6SlZ7JPQTZ0JQDBWWGgshFHkUZNi40iqv15RL
	77S+pShjBQcyHJJ2StDGWeTzIJz+aviWY/lxzYlMiid/0lh3hU5y4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 31BB718930;
	Fri, 19 Jul 2024 14:04:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 968281892F;
	Fri, 19 Jul 2024 14:04:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Cory Kramer <corykramer@google.com>
Cc: git@vger.kernel.org,
    =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: Documentation Bug
In-Reply-To: <CAJ7O7F7Zxd-FUbdJh-zxr1FOrUmZQuwx4CHLbQ-ppbkSN79Z-Q@mail.gmail.com>
	(Cory Kramer's message of "Fri, 19 Jul 2024 12:09:22 -0400")
References: <CAJ7O7F7Zxd-FUbdJh-zxr1FOrUmZQuwx4CHLbQ-ppbkSN79Z-Q@mail.gmail.com>
Date: Fri, 19 Jul 2024 11:04:15 -0700
Message-ID: <xmqqle1xjm1s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5030CE1C-45F9-11EF-A14A-34EEED2EC81B-77302942!pb-smtp1.pobox.com

Cory Kramer <corykramer@google.com> writes:

> In the docs for git-clone the brackets become mismatched for any
> options that have a [no-] counterpart.
> https://git-scm.com/docs/git-clone

Interesting.  The preformatted pages that were directly generated
from the sources at https://git.github.io/htmldocs/git-clone.html
has no such breakage.

Cory, thanks for reporting.

I think 76880f05 (doc: git-clone: apply new documentation formatting
guidelines, 2024-03-29) is where the alleged "breakage" came from.

Comparing it with pages that weren't updated by the topic that ends
at 58dd7e4b (Merge branch 'ja/doc-markup-updates', 2024-04-09), like

    https://git-scm.com/docs/git-clone
    https://git-scm.com/docs/git-add

I notice that the latter is rendered with "--[no-]ignore-removal"
correctly shown.

Two possible action items are

 - Compare the preformatted pages at https://git.github.io/htmldocs/
   between git-clone and git-add and re-evaluate if the earlier
   ja/doc-markup-updates topic did to the SYNOPSIS is really what we
   want (the difference is harder to assess by looking at the pages
   at https://git-scm.com/docs/).

 - Update the machinery that formats our documentation sources and
   renders at https://git-scm.com/docs/ to grok the mark-up used by
   ja/doc-markup-updates topic (currently in use for clone, init,
   and nothing else).

Do anybody remember what transmongering produces the copy shown at
git-scm.com from the source?  Is it computed from the preformatted
pages, or from the source?
