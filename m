Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9E219885D
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 20:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720642394; cv=none; b=NEB+/w3Y18re51f56oQIKmRBMYTxdvhykrCF87O1WwO32rBq2RLv6Qy2Nc+OlT8NQwgzPepLrzwe5zvzyNsjPldJIYpeglETqAxJ6aKd2d1mBRTd2utqOggJ8KYqK3Vz954QAE2MCnJKvBVd7+70RHCwepeBSo98PTadpEacGRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720642394; c=relaxed/simple;
	bh=radT+FEzAdf5QrjZ7Fk0sDDC0qwzYbbdxnr/6vX816I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=POKRsjj/XIfGSrPjpQSe/DlaUVem0UhRJRi+if0GQPsrKt2ufo/E2rlfJl6ZZXqL9q1A9Cym9bXVE0I4f1HqhuO9RWrsy534peoh8txAIws4ZYRDPm7P+CDlRxA/t/tUO2a/EeBogaL5m//W8xuNzPTmPFck+dyguxUax3te/uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=TBL3K6aC; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TBL3K6aC"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8B25E36132;
	Wed, 10 Jul 2024 16:13:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=radT+FEzAdf5QrjZ7Fk0sDDC0qwzYbbdxnr/6v
	X816I=; b=TBL3K6aCJt+cCiux9qZ/n/9GUH4OuDwKVjIQ6NPETQu7SP0Ms4gpaI
	xHugcpNHtD2miqtWE1Io1yVrZz7hA00B+NGd6jKxe+w5lLH1uxSoFcVBZ0PR1g9X
	rBtxs292Z3f4YyaPsAwhsXbXfq6+U0ghyLHy0XJbVypjI5FJ4TKS8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 828FF36131;
	Wed, 10 Jul 2024 16:13:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DE7B23612F;
	Wed, 10 Jul 2024 16:13:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Emily Shaffer <nasamuffin@google.com>
Cc: git@vger.kernel.org,  "Randall S. Becker" <rsbecker@nexbridge.com>,
  Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] Documentation: add platform support policy
In-Reply-To: <CAJoAoZn6zB+e5x6FEvesu173dHhgWBt7ZQ51H8ebp31kQKFCgw@mail.gmail.com>
	(Emily Shaffer's message of "Wed, 10 Jul 2024 11:55:45 -0700")
References: <20240709225042.2005233-1-emilyshaffer@google.com>
	<xmqqfrsi9i8y.fsf@gitster.g>
	<CAJoAoZn6zB+e5x6FEvesu173dHhgWBt7ZQ51H8ebp31kQKFCgw@mail.gmail.com>
Date: Wed, 10 Jul 2024 13:13:09 -0700
Message-ID: <xmqq5xtdvwdm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D478A3E6-3EF8-11EF-B7AC-965B910A682E-77302942!pb-smtp2.pobox.com

Emily Shaffer <nasamuffin@google.com> writes:

>> > +Compatible on `master` and point releases
>> > +-----------------------------------------
>> > +
>> > +To guarantee that `master` and all point releases work for your platform the
>> > +first time:
>>
>> OK, as most of the changes go to `master` before getting merged down
>> to `maint` to become part of the next maintenance release, actively
>> protecting `master` from bugs is worthwhile.  What about changes
>> that do not come via the `master` branch?  Should they also join the
>> security list and have an early access to the cabal material?
>
> Good question, I actually am not sure of the answer. Does that make it
> too easy for anybody to claim they maintain some random platform and
> therefore they'd like to see all the RCE howtos weeks before they are
> fixed? I guess that we already have distro packagers in security
> list/cabal, so it may not be worse exposure than that.

Stopping at saying "You may want to ask to join the security list"
and then leave the vetting process out of the guidelines for the
contributor (i.e. out of this document) may strike a good balance.

We will obviously be careful about whom to add to the security list,
but that does not change where people hear about the list and apply
to join.

>> All of the above are actually applicable to any active contributors
>> on any platforms.
>> ...
>
> Hits close to home ;)
>
> Does this mean that this part of the document should go somewhere else
> and we should just use a pointer here? Is there a guide handy for "how
> to soft-fork Git"?

Once we have a contributor guidelines this is a good material to
migrate there, but that would probably wait after the dust from this
document settles.

> Maybe something like this is better?
>
> "Work closely with the developer fixing the issue; the turnaround to
> check that a proposed fix works for your platform should be fast
> enough that it doesn't hinder the developer working on that fix. If
> the turnaround is too slow, fixing the issue may miss the next release
> or the developer may lose interest in working on the fix at all."

I think that is a good approach to take.  "We will not promise to
wait for you if you are slow, and that is not limited to those who
are working on minority/niche platforms" is a good point to make.

>> > +* If you rely on Git avoiding a specific pattern that doesn't work well with
>> > +your platform (like a certain malloc pattern), if possible, add a coccicheck
>> > +rule to ensure that pattern is not used.
>>
>> Sorry, but I do not quite follow you here.
>>
>> In general, it is a bad idea to promise that we are willing to tie
>> our hands with coccicheck to satisfy needs by exotic platforms,
>> without first having a chance to see and evaluate such needs.
>>
>> "if possible, add" -> "sometimes it may turn out to be a good idea
>> to add", perhaps?
>
> Maybe it is better to ask them to discuss it with us on-list, and that
> the result of that discussion may be that they should add some such
> test? Or, do we want to firmly say, no coccicheck restrictions based
> on platform, give us a CI runner or bust? I don't feel super strongly
> either way - writing this section I was trying to come up with any way
> to get on-demand ~instant (<1hr) feedback to any contributor, and this
> seemed like one someone could do. That doesn't mean we have to let
> them, if we don't like this way.

Yes.  If you want to add additional constraints on how the codebase
does things, discuss it on list first and work with us to come up
with a way to without forcing too many unnecessary constraints on
other platforms.  It may result in keeping the generic codebase
pristine and free from #ifdef and having platform specific code
somewhere in compat/ but such details do not have to be spelled
out---they will be different case-by-case and we will hopefully
devise new and improved ways to deal with them.
