Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7913A255F0B
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 02:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711335077; cv=none; b=f3MGsi8hJGIEzUSVAR5Q+M5/qzTUQBRdXFEvAB7v9faYFijhsfjhZvEGsxdrobTLodOTkMPVDZ41hYJuU2StwH///SHZ+FqJvsHTgtWDP41FUdfx7ZlY1Knx090K/UQ6Hu3fex71NfdDZQrCKUnMnQrxTzJkz3V7snsSEKCesYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711335077; c=relaxed/simple;
	bh=huvTQ15+czLkHdV02ll+VDA1gZ42Vg3CLXLk0aE9NuQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T6RNs0kSGywlDoQUlArN3vzomOySkaE8rOdUQhtjbf2nkv7q3oHQVvT1ElM2H1xR1HBWltfK8EEhwY4GxZd9FZ1Sx9ExwvOlKNsY9l+QW2RBXCnVUzf1Vn5SPffvUEWRQbpBiRN0SK67eOcCys7Hkwj2qzDIm9iVf8rJzMD5Dm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=HzXEleZ4; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HzXEleZ4"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B928821153;
	Sun, 24 Mar 2024 22:51:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=huvTQ15+czLkHdV02ll+VDA1gZ42Vg3CLXLk0a
	E9NuQ=; b=HzXEleZ4UVoAPeZhDZ86ZjtwcGGZtvOdkH3Yh1Yh5phky3eZppSSQG
	eoNZi7TgaI6cbOylHZ3kkkhKXtwJOSe6zwm9i+HVR0158o483bceH1UnaP7QCX+6
	ywiLWFXj4AV4BxzQWlnP1K5LZVg9EqIHHNA2kEhP1Ej+AEay+KVVA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B291421152;
	Sun, 24 Mar 2024 22:51:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3E53D21151;
	Sun, 24 Mar 2024 22:51:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Linus Arver <linusa@google.com>
Subject: Re: [PATCH] RFC: add MAINTAINERS file
In-Reply-To: <xmqqsf0gvjrg.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
	23 Mar 2024 12:19:15 -0700")
References: <pull.1694.git.git.1711164460562.gitgitgadget@gmail.com>
	<xmqqsf0gvjrg.fsf@gitster.g>
Date: Sun, 24 Mar 2024 19:51:03 -0700
Message-ID: <xmqq8r27nhwo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 86137EE2-EA52-11EE-91E8-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> I am more worried about how the file is used and maintained.  Some
> things to think about while in the "spurred discussion" I can think
> of are:
> ...
>  - Is the project big enough to require this (especially for the
>    purpose of (1)), or would
>
>    $ git shortlog -n --no-merges --since=24.months -- path-to-file
>
>    be sufficient and more importantly the value that it will keep
>    current automatically outweigh the benefit of having this file
>    that can go stale?  To answer this question, we'd need to know
>    the turnover rates of past project contributors, of course.  If
>    it is too high, having such a list may help for (1) and (3)
>    above.
>
>  - How binding is it for a contributor to be on this list as an area
>    expert?  Will there be concrete "expected response time"?  It can
>    be different for each area expert, of course.  I'd expect better
>    from those who work on Git as a major part of their job and
>    contributes some part of their work product back to the upstream,
>    than from folks who do Git as a hobby.  Is each contributer
>    expected to volunteer to be on this list, with self declared
>    service level target?
>
>  - With many good reviewer candidates being employed in companies
>    and doing Git as part of their job, how would we handle folks
>    getting transferred out of the Git ecosystem?  Unlike in a
>    corporate environment, nominating successors who have no track
>    record in the community by the current area expert would not work
>    at all.  The successors themselves have to earn respect by
>    demonstrating their own competence, which would take time.
>
> There may be many others.

So here are some more from the top of my head.

 - Corollary to "nominating successors from the group at your
   company may not work well", it may be hard to self-nominate
   yourself as an area expert if you are not confident that others
   consider you to be one.

 - How authoritative should these "maintainers" be?  Do they have
   the final say to even override a concensus in a discussion if
   needed, when clueless discussion participants are drawing a
   conclusion that would hurt the codebase in the longer term?

 - For whom do we partition the areas?  "For revision walking using
   connectivity bitmaps, experts are ..." sounds (at least to me)
   like a plausible and reasonable way to define an expertise area,
   but the description of the area may be understood only by those
   who are reasonably familiar with the way how "git log" internally
   works, for example.  Is it OK to assume that the reader has some
   basic understanding of how the system works in order to use the
   maintainer list effectively?

 - The above worry may be reduced if we partition the area primarily
   along the file boundaries.  If a set of functions that are not
   logically related to feature X but has to be in the same
   compilation unit for some reason live in the file whose primary
   purpose is to house implementation of the feature X, it may give
   us an interesting project to figure out how to separate them out
   and give them "correct" place, and the end result, even though it
   is a side effect, would be a more modular and readable code.

 - If we adopt the file format from the kernel project, can we
   leverage their tooling as well to query the maintainers file?  I
   thought they have a tool that reads your patch into and figures
   out what area is being touched to spit out a good set of Cc
   candidates?

 - Can contrib/contacts/git-contacts be taught about this new source
   of information, and if so how?

 - Once we start breaking down the system into expertise areas, are
   there areas without any existng experts already?  If you send
   patches to the list right now in the following areas, I do not
   think you'll find capable reviewers whose acks weigh well enough
   [*]: gitk, git-gui, contrib/completion, git-p4, gitweb, git-svn.

    * Please raise a hand and say "No, you know I am very familiar
      with that area; you just simply forgot about me because we
      have not seen any patches in the area recently".

 - When there are no active area experts, what would the default
   action be?  We would risk degrading the quality of such
   "neglected" part of the system if we adopt "anything gets
   accepted blindly" approach, so I would really want to avoid it.

 - When an area with incumbent experts sees interest from some
   developers, it is the best for these new people to demonstrate
   their own competence and earn community's trust to eventually
   become the area experts themselves, but that may not be so easy
   in practice due to chicken-and-egg problem.
