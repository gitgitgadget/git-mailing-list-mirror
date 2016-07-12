Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E96BD1FE4E
	for <e@80x24.org>; Tue, 12 Jul 2016 17:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753874AbcGLREz (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 13:04:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63516 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750998AbcGLREy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2016 13:04:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B5AF02908C;
	Tue, 12 Jul 2016 13:04:52 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1kn3o7wafwOlvqcjtBByAof+aZ8=; b=CHScA3
	UfY+X+DsuwHLTkFNW5wAH4GdVpy4QxUv9fSgedkEjWm0fwHOIxXa/6rxFr6RiyZ/
	nZtLtP+JD2HcUt+vbC5X1/WPJf69NBL52klwjNs5F5VuI3LPNjVeownsGj7L7STe
	wmx7bJigLsBnfQX+xhjdJwbiUPWtk4EQDyGpM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u/oZ7pnK5pd/Ge+43uLbO/9roj1s0PS9
	6yetKySGoPNQtsgs58EJoM8EK54Zm6HQ/cY60D+O4Udb5uXjd8uk6yJuYMeRT4q/
	n/iJ+AxbAYlHrC6kEifJVYIrryPQXYvkm8NMx4+tsD0p/ANNhrEgBFm8d7cL2IW9
	x1v1/k3wpbU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AD7722908B;
	Tue, 12 Jul 2016 13:04:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3676C2908A;
	Tue, 12 Jul 2016 13:04:52 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Marc Branchaud <marcnarc@xiplink.com>
Cc:	Philip Oakley <philipoakley@iee.org>,
	GitList <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 4/8] doc: give headings for the two and three dot notations
References: <20160630202509.4472-1-philipoakley@iee.org>
	<20160711202518.532-1-philipoakley@iee.org>
	<20160711202518.532-5-philipoakley@iee.org>
	<5784F43E.3080400@xiplink.com>
Date:	Tue, 12 Jul 2016 10:04:50 -0700
In-Reply-To: <5784F43E.3080400@xiplink.com> (Marc Branchaud's message of "Tue,
	12 Jul 2016 09:44:30 -0400")
Message-ID: <xmqqwpkq6b4d.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BFB77B3A-4852-11E6-8CB9-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Marc Branchaud <marcnarc@xiplink.com> writes:

>> +The '{caret}' (caret) notation
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>   To exclude commits reachable from a commit, a prefix '{caret}'
>>   notation is used.  E.g. '{caret}r1 r2' means commits reachable
>>   from 'r2' but exclude the ones reachable from 'r1'.
>
> All of these headings render poorly in the manpage, at least for me
> (Ubuntu 16.04).  Only the first word appears in bold; the '-quoted
> text is not bold but underlined, and the rest of the header is plain.
>
>
> Also, I think calling this "The ^ notation" is confusing, because
> there's already an earlier paragraph on the "<rev>^" syntax.
>
> Maybe we don't need a header here?  I only suggest that because I'm
> having trouble coming up with a nice alternative.  "Commit Exclusion"?

Thanks for pointing out the potential confusion between ^X (exclude
reachable), and X^ (the first parent).  Commit exclusion is probably
a good heading.

>> -This set operation appears so often that there is a shorthand
>> +The '..' (two-dot) range notation
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Perhaps "Range notation", to mirror the capitalization of "Symmetric
> Difference" in the next header?
>> ...
>> +The '...' (three dot) Symmetric Difference notation

This uses a strange capitalization rule.  s/notation/Notation/
perhaps?  The same comment for "Additional Shothand notation" below.

>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>   A similar notation 'r1\...r2' is called symmetric difference
>>   of 'r1' and 'r2' and is defined as
>>   'r1 r2 --not $(git merge-base --all r1 r2)'.
>>   It is the set of commits that are reachable from either one of
>>   'r1' (Left side) or 'r2' (Right side) but not from both.
>>
>> -In these two shorthands, you can omit one end and let it default to HEAD.
>> +In these two shorthand notations, you can omit one end and let it default to HEAD.
>>   For example, 'origin..' is a shorthand for 'origin..HEAD' and asks "What
>>   did I do since I forked from the origin branch?"  Similarly, '..origin'
>>   is a shorthand for 'HEAD..origin' and asks "What did the origin do since
>>   I forked from them?"  Note that '..' would mean 'HEAD..HEAD' which is an
>>   empty range that is both reachable and unreachable from HEAD.
>
> Unfortunately the new headings make it appear that this paragraph is
> exclusively part of the '...' notation section.  Folks reading the
> ..' section are likely to skip it.
>
> I like the examples, though.  I think it would be worthwhile to remove
> this paragraph and fold it explicitly into the '..' and '...' notation
> sections.

An alternative would be to have

    - Dotted range notations
      - Two-dot notation
      - Three-dot notation

which would help make it stand out that defaulting is common
characteristics between .. and ... notations.  But I can imagine
that your "with slight duplication" variant below would work well,
too.

> So add something like this to the '..' section (only the first
> sentence here is new):
>
> 	Either r1 or r2 can be omitted, in which case HEAD is used as
> 	the default.  For example, 'origin..' is a shorthand for
> 	'origin..HEAD' and asks "What did I do since I forked from the
> 	origin branch?"  Similarly, '..origin' is a shorthand for
> 	'HEAD..origin' and asks "What did the origin do since I forked
> 	from them?"  Note that '..' would mean 'HEAD..HEAD' which is an
> 	empty range that is both reachable and unreachable from HEAD.
>
> And also, add the same first sentence and a different example to the
> ...' section.  Something like this:
>
> 	Either r1 or r2 can be omitted, in which case HEAD is used as
> 	the default.  For example, 'origin...' is a shorthand for
> 	'origin...HEAD' and asks "What have I and origin both done
> 	since I forked from the origin branch?"  Note that 'origin...'
> 	and '...origin' ask the same question.

>> +Additional '{caret}' Shorthand notations
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>   Two other shorthands for naming a set that is formed by a commit
>> -and its parent commits exist.  The 'r1{caret}@' notation means all
>> -parents of 'r1'.  'r1{caret}!' includes commit 'r1' but excludes
>> -all of its parents.
>> +and its parent commits exist.
>
> I think descriptions of <rev>^@ and <rev>^! should live under the main
> description of <rev>^.  That part already describes the numeric
> suffix, so describing a couple of special suffixes there seems like a
> natural fit.

I actually think this is a good place to have them described.
<rev>^<number> is about specifying a single commit.  These two are
not that (you can say HEAD^2^@ but you cannot say HEAD^@^2, for
example).

