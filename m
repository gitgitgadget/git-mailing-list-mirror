From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] pull/fetch rename
Date: Tue, 20 Oct 2009 14:46:30 -0700
Message-ID: <7vpr8hlow9.fsf@alter.siamese.dyndns.org>
References: <200910201947.50423.trast@student.ethz.ch>
 <200910201359.30880.wjl@icecavern.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	=?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: "Wesley J. Landaker" <wjl@icecavern.net>
X-From: git-owner@vger.kernel.org Tue Oct 20 23:46:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0MXY-0000XH-EX
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 23:46:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752014AbZJTVqi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 17:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751640AbZJTVqi
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 17:46:38 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38277 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026AbZJTVqh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 17:46:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D934E7F10B;
	Tue, 20 Oct 2009 17:46:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vLlWSVE3GCgpMXPFWlENOy3XVeM=; b=uGwxCO
	crTW1DhSFUrRWHyA9QvIHnDf3JPG7loUuBexI9t2NPr3NSYEiqsccMawPBPB4izP
	7LQu2yw7cN0lleR+c9476ilYkT3IIvrmWkk8Dov+GobI+Tp18jsdf3QGNqwCenZE
	5JF5XO8TZrryNPeqklJzCe/41Qa0CML+GoD5E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gNUAa8MnD23yxuvjvAlHpwS4Hj6wo2cz
	N/XoLqiYkyN3um3+Tolt0ImT8PO3mDL7JiDqrl4YvZSzyvBcKzwT9py+U6Uo/43o
	OlzTCodA57SKzZtEIQJ7zOSdpmDLdPBCoC0oc7lyL55ukgyJgSxGARk9jFIsPumh
	t2QeldSzu9E=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9FD6F7F106;
	Tue, 20 Oct 2009 17:46:37 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 003667F105; Tue, 20 Oct 2009
 17:46:31 -0400 (EDT)
In-Reply-To: <200910201359.30880.wjl@icecavern.net> (Wesley J. Landaker's
 message of "Tue\, 20 Oct 2009 13\:59\:30 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0B272CE6-BDC2-11DE-AC99-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130854>

"Wesley J. Landaker" <wjl@icecavern.net> writes:

> On Tuesday 20 October 2009 11:47:45 Thomas Rast wrote:
>> Especially on IRC, we see many people who are some combination of
>> misunderstanding, misusing or overusing git-pull.  I figure this is
>> the result of several factors, notably
>> 
>> a) pull/push are not symmetric,
>> 
>> b) guides/tutorials recommend pull for situations where they
>>    shouldn't,
>> 
>> c) people blindly fire commands at git.
>
> This may be minor, but also:
>
> d) in mercurial, pull/push are symmetric, but fetch means pull+merge
>
>> As you probably guessed by now, here is an idea for a very aggressive
>> transition plan to address (a) in four phases:
>
> I would love to see this change, not because I get confused about pull/fetch 
> (it honestly only took a few days to get used to), but because having 
> push/pull be symmetric just is so much more conceptually pure / easier 
> explain to co-workers / separation between orthogonal operations / 
> satisfying to my inner perfectionist / etc.

Is making "pull" a symmetric opposite of "push" the ultimate goal?

Or is making (or rather "keeping") "pull" useful more important?

It is not even an attitude that values philosophy over utility.

Fundamentally, pull and push cannot be symmetric because nobody is sitting
in front of the repository you are pushing into (that is what a "push" is;
you push from outside the repository---otherwise you would be "pull"ing
from inside it in the other direction), but you know you are sitting in
the repository, ready to resolve potential conflicts, when you say "pull".

Your elaborate scheme to make "pull" into "fetch" and to force everybody
to set a configuration variable to make it "pull" again sounds like a
mindless mental masturbation to me.  People who leave "pull.merge = no"
will always have to say "pull --merge" or "pull --rebase", so you cannot
even argue you are not forcing but giving them a choice.

And you are doing this for what gain?  The only thing I can think of is
"People who deliberately set 'pull.merge = yes' can no longer blame us for
pull not being the opposite of push."  I do not consider it as a gain.

I do not buy "People who set 'pull.merge = yes' now understand why pull
touches their work tree, because they did it themselves" either.  People
blindly copy other people's configuration from random web pages without
understanding.  Besides, the next thing they will ask is "Why is there
pull.merge but no push.merge?  Wasn't push an opposite of pull?" and you
are back to square one.

I would be much more sympathetic if the suggested approach were to make
"push" more symmetric to "pull", or at least attempt to allow it to be, by
giving it an option to update the associated work tree when it can [*1*].

But I do not know what to say when people say "push cannot update the work
tree, so let's make pull not to update the work tree by default---it will
make it much less useful so we will fix that regression with yet another
configuration option".  It's not even funny.


[Footnote]

*1* Obviously you cannot do this most of the time _if_ the work tree has
an interactive user sitting in front of it, but in a repository that never
allows a non-ff push, with a work tree that is never updated except by
such a push, can reasonably be maintained to give an illusion of push
being an opposite of pull by fast forwarding the work tree when the push
updates HEAD.
