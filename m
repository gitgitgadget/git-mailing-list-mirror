Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DC0383BD
	for <git@vger.kernel.org>; Thu,  9 May 2024 16:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715271035; cv=none; b=miBUMJlDl3YLl4xhy/RxzQtQvv2heU1APawlOb+3uYZFY8/Wpgep7WosOWE8rfcxxkTXBtfXv8rXvJwsmNtqX+f/zug0NaTikUln2Hjt+xv8vgqM9RsS0MmkelKBROLCsFH8SLR6QpmOTGF6NJ+a9Ub1244IkXUtgtpM0F+Y9Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715271035; c=relaxed/simple;
	bh=xKJ2QFyhqiWLi74Xd+X7f6knPK1lhkTGxr367Bayqc8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WdlNNQj19R9R1UzCGt72g6n79JSmJh5Dqu91jw3D+6Qmpz+k6syoweg2o803R2mX8kIzJNID7yVI/JqBTlYsEvrFnUY+qH3EsnRFHHut9xKeR+KUJEmwvtyw7mSGkLDbyTNkLrvPBn9ZNFwnFl7Rtbu44bDuHUQUJhMJPknGC5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=odJ+wW7Y; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="odJ+wW7Y"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BF4D0227F1;
	Thu,  9 May 2024 12:10:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=xKJ2QFyhqiWL
	i74Xd+X7f6knPK1lhkTGxr367Bayqc8=; b=odJ+wW7Y6pORulZeIPYkYDMY9FeR
	3Ze66G3z51p5lAQh4pLrf2cBFdc7XnZZ9k0oc996DMYajDkzjOzMFHtEcqjB/jfR
	HywhwvXh10O80ZruHZZvpuim/NRtKHMWeWPSBa5Ci5N+wXz7E9JuPfgsDcESdjGF
	zpIS4hEhTYYS75E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B742F227F0;
	Thu,  9 May 2024 12:10:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 18032227EF;
	Thu,  9 May 2024 12:10:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Peter Krefting <peter@softwolves.pp.se>
Cc: Helge Kreutzmann <debian@helgefjell.de>,  =?utf-8?Q?Jean-No=C3=ABl?=
 AVILA
 <avila.jn@gmail.com>,  git@vger.kernel.org
Subject: Re: i18n of git man pages
In-Reply-To: <d130d861-0071-33ef-5d40-9fd703ff97f6@softwolves.pp.se> (Peter
	Krefting's message of "Thu, 9 May 2024 15:39:41 +0100 (CET)")
References: <Zjuokc2H0zI1JCVH@meinfjell.helgefjelltest.de>
	<xmqqjzk4xlis.fsf@gitster.g>
	<ZjvHoykzIo34YJaT@meinfjell.helgefjelltest.de>
	<xmqqedacxdv1.fsf@gitster.g>
	<d130d861-0071-33ef-5d40-9fd703ff97f6@softwolves.pp.se>
Date: Thu, 09 May 2024 09:10:30 -0700
Message-ID: <xmqqr0ebuft5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 A9221CF0-0E1E-11EF-89AE-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Peter Krefting <peter@softwolves.pp.se> writes:

> Should it also be merged into the git.git repository as well, so that
> translation can be synced with the upstream version? The problem with
> an external project is that it is easy to forget about.

Carrying an extra tree that has been (and I suspect will continue to
be) managed in a separate workflow and by a separate group does
incur coordination cost.

> Looks like I had cloned the repo and intended to do a Swedish
> translation back in 2019, but never got around to. I guess the lack of
> visibility made me forget all about it.

It is exactly why you are seeing a proposed solution to raise the
visibility that is much lightweight and has less chance of doing
unnecessary harm than merging of the project into ours.  The help
the would-be translators need will be there.   To end-users, I do
not think it matters in today's world where the manpages come from.
The distro folks are there to absorb different ways translated
manual pages are done by different projects, and I can hardly
believe that our project is in any way unique.

I would like to hear from Jean-No=C3=ABl how the manpage translation
project wants to proceed.  I do not fundamentally object to taking
an approach similar to the one we use to manage the po/ part of our
project, where I can normally be unaware of what happens in that
directory and leave it to i18n coordinator, but I have a feeling
that even such a light-weight integration might affect their
workflows at the manpage translation project side, which may or may
not be acceptable on their end.  Also to go from the work product
they have to what our "make -C Documentation all" produces, it may
require more build dependencies (like a version of po4a with a patch
or two that are yet to be accepted by the upstream), plus updates to
Documentation/Makefile, on our side, which might turn out to be an
overly high cost relative to the benefits both projects gain.  These
unknowns need to be resolved before we consider heavier proposals.

Thanks.
