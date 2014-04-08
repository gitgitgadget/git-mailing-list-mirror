From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v10 11/12] Documentation: add documentation for 'git interpret-trailers'
Date: Tue, 08 Apr 2014 09:52:49 -0700
Message-ID: <xmqq7g6zlq5a.fsf@gitster.dls.corp.google.com>
References: <20140406163214.15116.91484.chriscool@tuxfamily.org>
	<20140406170204.15116.15559.chriscool@tuxfamily.org>
	<5343A589.10503@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Apr 08 18:53:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXZGm-0001IM-KB
	for gcvg-git-2@plane.gmane.org; Tue, 08 Apr 2014 18:53:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757295AbaDHQw7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2014 12:52:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46725 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756659AbaDHQw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2014 12:52:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 470F37AF3B;
	Tue,  8 Apr 2014 12:52:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ah4V63KGg0OSxg/gHIPGxzmmwzc=; b=m/O4P+
	tdSbeNyAl5U1hAusNtKhpCEFyWWFUoRMOl+3NlKqystI5c3EJe/QMkuVyqBM9OsE
	A/W0yCKm+VUS3kSaxJ4cEN8QYw+E8vJIorLgawrxi9Ut93K48DsZriRzKUa1rBhV
	dJHQgMFm5Ijm9htQNs9ycek/zSIssJWstBFz0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PjViC1QdX6BhPCT5JaLTrD0i/OSiX5Ez
	uTQ7dausLmyz4uDWSRfqbV/ieGshw0xNN8y6JTUCnP4XLgEOzjJEfodmnPQ4ex4e
	cC0hlUDOx9CtdXGoyBq+sQutU7/9upeVorUy7ewr5UTxzta/q6YvwggaUC31VrXL
	85Cg8COrFRk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F5427AF3A;
	Tue,  8 Apr 2014 12:52:52 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0E0A37AF38;
	Tue,  8 Apr 2014 12:52:51 -0400 (EDT)
In-Reply-To: <5343A589.10503@alum.mit.edu> (Michael Haggerty's message of
	"Tue, 08 Apr 2014 09:30:17 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 38B35B44-BF3E-11E3-9A59-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245931>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Sorry for reappearing in this thread after such a long absence.  I
> wanted to see what is coming up (I think this interpret-trailers command
> will be handy!) so I read this documentation patch carefully, and added
> some questions and suggestions below.

Thanks for reading the patch carefully.  It helps to have fresh set
of eyes that are not contaminated by the preconception formed by
previous discussions, especially when reviewing the documentation
whose primary target audiences are those who do not care about these
previous back-and-forth.

>> +trailer.<token>.where::
>> +	This can be either `after`, which is the default, or
>> +	`before`. If it is `before`, then a trailer with the specified
>> +	token, will appear before, instead of after, other trailers
>> +	with the same token, or otherwise at the beginning, instead of
>> +	at the end, of all the trailers.
>
> Brainstorming: some other options that might make sense here someday:
> ...
>> +trailer.<token>.ifexist::
>> +	This option makes it possible to choose what action will be
>> +	performed when there is already at least one trailer with the
>> +	same token in the message.
>> ++
>> +The valid values for this option are: `addIfDifferent` (this is the
>> +default), `addIfDifferentNeighbor`, `add`, `overwrite` or `doNothing`.
>
> Are these option values case sensitive?

It is interesting and somewhat sad that it all has to come back
together inter-twined.  From the very beginning, I was opposed to
having logical complexity that requires multi-words in both variable
names (e.g. "if-exist") and values (e.g. "add-if-different"), and
after $gmane/241929 where I let the devil's advocate "how about
making the variable simpler without logical operation and put all
the conditional on the value side?" suggestion shot down, I somehow
was hoping that the value part got a lot simpler not to require
multi-words, which would have meant that we would not have to worry
about "Is it addIfDifferent? add-if-different? or Add_If_Different?"
at all.  Sadly that is not what we have ended up with.

So, with that realization...

> If so, it might be a little bit
> confusing because the same camel-case is often used in documentation for
> configuration *keys*, which are not case sensitive [1], and users might
> have gotten used to thinking of strings that look like this to be
> non-case-sensitive.

... very true.  Having to have these enum values as so complex to
require multi-words is probably the root cause of the confusion, and
we might probably be better off if we did not have to, but it would
be helpful to allow various different spellings (i.e. make them case
insensitive to allow random camel spellings, and also accept things
like "add-if-different" as well) if we absolutely have to have these
complex values.

But you had a lot of good questions and suggestions for possible
future enhancements that we would need to take into account while
designing the overall scheme to later allow them to fit into.  Maybe
a value that is a single-token that consists of just a few words
(e.g. "addIfDifferent") may not be the best way to go after all.

I dunno.

> What if there are multiple existing trailers with the same token?  Are
> they all overwritten?
> ...
> What if the key appears multiple times in existing trailers?

All good questions, I would think.
