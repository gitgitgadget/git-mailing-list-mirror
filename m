From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What is missing from Git v2.0
Date: Tue, 22 Apr 2014 11:33:10 -0700
Message-ID: <xmqqk3ah5i55.fsf@gitster.dls.corp.google.com>
References: <CAMP44s17h4Tjg+VaMF0atLep8t-0HVp4UDr1WE2wYnEuZ07eaQ@mail.gmail.com>
	<53557071.5040500@gmail.com>
	<xmqqtx9m8obr.fsf@gitster.dls.corp.google.com>
	<CAHGBnuMty-86jfUto=L3muhgEVwVE70FQQY2FJ1bn7AUjfEtLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 20:33:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcfVS-0005pH-AF
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 20:33:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752248AbaDVSdQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 14:33:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36814 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750897AbaDVSdP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 14:33:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F3FB7FAAE;
	Tue, 22 Apr 2014 14:33:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=d/sbpopM704IZjCpJryt3AYrCXo=; b=BWRIb6
	aylP35v47WKZtott4DulJpkplwy/78oSUcMMMUwbH5F7vByriF24TNXCyV4hCMBJ
	t8awJLEC227hntHkKsSznUL7FyYwhOw3r8TV7OAKyFPVBFDk0ru3seDtgY5dcEHA
	qmRauWTWJSdI460H+dKRQPgS8sCkpaY4gmAeE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=abhP3D64P0perR4MfNpYX8NI9X3jX+Fu
	eY1FI2Jbbw9ys8MJa4dBc7Mla2AzTOwItomTqK7axJPGFS8ywyYP7AOEVWKqU8iE
	KY1rWJ3C4nUv5Tt1vKLg9N6oRO33iEL8nfchcbYhoRklzRSEr2DpqRRynGxR7YGp
	mnXGxOOv7WA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 44DB57FAAD;
	Tue, 22 Apr 2014 14:33:14 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B48AF7FAA8;
	Tue, 22 Apr 2014 14:33:11 -0400 (EDT)
In-Reply-To: <CAHGBnuMty-86jfUto=L3muhgEVwVE70FQQY2FJ1bn7AUjfEtLQ@mail.gmail.com>
	(Sebastian Schuberth's message of "Tue, 22 Apr 2014 09:19:40 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8F0E0610-CA4C-11E3-B746-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246761>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> On Mon, Apr 21, 2014 at 9:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>>> If we don't standardize this now people will come up with their own
>>> definitions [1] [2] (and many others if you just search GitHub) which
>>> are again likely to differ (slightly), hindering interoperability.
>>
>> I am afraid that that ship has sailed long time ago, though.
>
> That's most likely true, but it does not get better by postponing this
> even more.

As I already said:

    I think it might be OK to implement them as the lowest priority
    fallback alias, so that '[alias] co = "user's definition"'
    anywhere in the various configuration locations will override
    it.  I am a bit hesitant about adding start-up overhead, though.
    Also I am not sure if people can agree with (1) a broadly wide
    selection of aliases and (2) the actual definitions for them (I
    am OK with "co === checkout" myself, but I'd rather not to even
    think about my Git wasting cycles parsing extra configuration
    items to support "br === branch" at all, for example).

I am not fundamentally opposed.  I just do not think it would add
much value to new people at this point, and it will actively hurt
if we shoved barely cooked one in 2.0.

A few thinking points that are necessary to be worked out, even
before we start imagining a plan to introduce them, off the top of
my head, are these:

 * Should we add many random aliases, or should we limit ourselves
   only to a narrow set that everybody can agree on?

 * What is the additional cognitive load do we feel comfortable
   burdening with the new users?

 * What is the exact mechanism to give these built-in aliases?

Imagine that somebody says "[alias] ci = commit" and a handful of
vocal people on this list agree that it is a good idea.  Many random
websites start mentioning "git ci -a" in their beginner examples.

Users are led to think "ci" is a command just like "commit" and does
the same thing.  Some of them want to always commit everything
before moving to their next task, and want to alias it further, e.g.
"[alias] ci = ci -a"---which would not work.  At that point, the
users need to learn the distinction between native subcommands
(e.g. "commit"), built-in fallback aliases (e.g. "ci") and aliases
of their own in their ~/.gitconfig, and need to learn that only the
first kind and not the second kind cannot be used to define their
own alias (and the users need to learn "commit" at that time as
well).

That could be solved by making "ci" not a built-in fallback alias,
but a new subcommand (then there is no "'foo' in 'git foo' could be
a command or a built-in alias and they behave differently" issue),
and additionally somehow allowing a native subcommand overriden by
end-user alias, but I do not think anybody designed how such an
override would work so far.

So even if we agree that it would be a good idea to have some
default fallback aliases, the set of such aliases we ship must be
limited to a set that everybody can agree on, both in the sense that
"adding alias XX is good" and also in the sense that "alias XX must
be defined as YY".

As you allueded to, the Git userbase is a lot larger than it used to
be back in 2006, one alias, e.g. "[alias] br = branch", that is
reported as either useless or needed to be further tweaked by a
person on this list would mean that we would be either spending
unnecessary start-up cycles (for "useless" case) or adding cognitive
load of having to differente between "branch" and "br" (for "needs
further tweak" case) for thousands of users who would be better off
if we didn't have that specific alias.

So while I understand the desire to have a bit more handholding and
am not fundamentally opposed to the desire, I am not optimistic that
an attempt to implement these "aliases" would result in a very
useful addition to the system, even if done after careful thought.

In any case, this definitely is not a 2.0 material.  I agree that it
would be good to start discussing it early (rather than later) if we
ever want to do such a change.
