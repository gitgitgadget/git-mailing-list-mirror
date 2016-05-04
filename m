From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 0/2] Add support for sending additional HTTP headers
Date: Wed, 04 May 2016 11:23:57 -0700
Message-ID: <xmqq4madisw2.fsf@gitster.mtv.corp.google.com>
References: <cover.1461837783.git.johannes.schindelin@gmx.de>
	<cover.1462342213.git.johannes.schindelin@gmx.de>
	<20160504062618.GA9849@sigill.intra.peff.net>
	<xmqq7ffajmvz.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1605041316160.9313@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 04 20:24:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay1Sx-00072y-1a
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 20:24:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753850AbcEDSYC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 14:24:02 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63814 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752124AbcEDSYA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 14:24:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6341E18173;
	Wed,  4 May 2016 14:23:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PU+VEv+q4wzls9lIeRkYfieIf3M=; b=BKO66D
	j2aGRYiiMPcoohinfUXrdcNkYpzjr2JdULRvriwdmhVqUxxxk/JJ3oT6If9Rl0kL
	tTb9bWM9F0oAUqwA+77sappavN351QEvyyZCAJHMJUjKnWZYT/Sdf8+5jyJ2Onih
	NFSZGpJZTXMHdwk5fEBgpPHgtCQM+D4YTrnXg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QfjRhKPYD+F+/9DNlJlxg9u1ZHm2LaCO
	b0KL9Lpa5HFotHco2AgeHCC+B5j+AfVWzf7Yj6BI8k+EQQEMQ8pxLA6rkpxbB92P
	c1xy7baxU8U+KJ9Bse8jR2HeFu0QMEVxmEBXzuwpBNjBri7EbMBmRHkTvk2LgZ5E
	s6JEbRHBXuc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5B8EE18172;
	Wed,  4 May 2016 14:23:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D5DA518171;
	Wed,  4 May 2016 14:23:58 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.20.1605041316160.9313@virtualbox> (Johannes
	Schindelin's message of "Wed, 4 May 2016 13:20:34 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5E709158-1225-11E6-BC23-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293560>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Wed, 4 May 2016, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> >>   submodule: pass on http.extraheader config settings
>> >
>> > IMHO this should come on top of jk/submodule-config-sanitize-fix (I was
>> > surprised at first that your test worked at all, but that is because it
>> > is using "clone", which is the one code path that works).
>> 
>> Yes.
>
> Okay.
>
>> > But I think we are waiting on going one of two paths:
>> >
>> >   1. drop sanitizing entirely
>> >
>> >   2. fix sanitizing and add more variables to it
>> >
>> > If we go the route of (2), then we'd want my fix topic and this patch.
>> > And if not, then we don't need any of it (just a patch dropping the
>> > filtering, which AFAIK nobody has written yet).
>> 
>> Doubly yes.  That is why I didn't pick up 2/2 in the previous round
>> and also jk/submodule-config-sanitize-fix is not in 'next' for the
>> same reason.
>
> Okay. It was not clear to me that the indentation was not the reason it
> was ignored.

It wasn't even ignored. I looked at it carefully, noticed that it
contradicts with what you said in a different message, and made a
concious decision to wait.

>> I agree with you that we have not yet reached concensus on which one
>> of the two we would want to take.  I was sort of surprised to see
>> 2/2 sent again, after seeing that Dscho sounded strongly in favor of
>> not filtering the passed configuration variables, which would make
>> the patch unnecessary.
>
> Hah, my opinion matters after all.

When your proposal ends up getting rejected, it is not because your
opinion does not matter.  In any case, for this one, the reason I
decided to wait until the "filter or not filter, and if filter, use
whitelist or blacklist" discussion settles does not depend whether I
happen to agreed with your preference (which is "not to filter").

That is, there is a difference between "I will not apply this ever,
because I know the outcome of the the other discussion already and
it will make this patch unnecessary", and "I cannot decide to apply
this yet, because this may be needed if the other discussion goes in
a certain way but this may turn out to be unnecessary if it goes in
another way."  And the topic branch having only the first one is
because this case was (and I think still is) the latter.
