From: Junio C Hamano <gitster@pobox.com>
Subject: Re: An idea for "git bisect" and a GSoC enquiry
Date: Fri, 28 Feb 2014 10:31:53 -0800
Message-ID: <xmqqtxbjum06.fsf@gitster.dls.corp.google.com>
References: <CAL0uuq0=Zo0X8mYRD6q-Q+QAcZhfmxOwKiRegDrRm3O_i0Q+EA@mail.gmail.com>
	<530F1F11.7060403@alum.mit.edu>
	<CAL0uuq0msXWZDDWzpetfBG0cgGQLKrtwhNp-DqbD6Q3aytaCdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Christian Couder <christian.couder@gmail.com>
To: Jacopo Notarstefano <jacopo.notarstefano@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 28 19:32:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJSEC-0005YR-5i
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 19:32:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751527AbaB1ScD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 13:32:03 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63120 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751410AbaB1ScB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 13:32:01 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C7F1C6F058;
	Fri, 28 Feb 2014 13:31:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vdZ4pAWRQ+RHW6fQXq5F9m3q/vI=; b=ic9dga
	Fi4JOoN7A3S9wAj4vPjEx8dE1t1i9Z3pFYNtwHvvHOlaWr6mh8y1H4yz006kKxkc
	UtMPp7vDCz0XgFBlXyUeSXPdlD6S69NO6JOUCySsqkfbZ0qAATCH7pydtoQ1smyr
	qRQ592o/xoxJugpWx2eCrsXFQmLIES2WVx0U0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jI2YS0m3Pi/uBuA/lgsPjYGcFa5tRviP
	Gh+I78qdY9MSxNdyXH8DAB9pbbUR1T0/SOh94Qvzlg35M/5JigrTO76ZEzqYA55b
	uWHnlwUC4moin7VU9H8AVPr3I50Soe4+gqj5m1eVjk0ii0NGqgk0gKtziO/sUJml
	lixSyQd+sss=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ACCC86F057;
	Fri, 28 Feb 2014 13:31:58 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3F9256F022;
	Fri, 28 Feb 2014 13:31:56 -0500 (EST)
In-Reply-To: <CAL0uuq0msXWZDDWzpetfBG0cgGQLKrtwhNp-DqbD6Q3aytaCdQ@mail.gmail.com>
	(Jacopo Notarstefano's message of "Fri, 28 Feb 2014 10:03:15 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9A29B384-A0A6-11E3-B011-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243001>

Jacopo Notarstefano <jacopo.notarstefano@gmail.com> writes:

> On Thu, Feb 27, 2014 at 12:18 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> I don't understand the benefit of adding a new command "mark" rather
>> than continuing to use "good", "bad", plus new commands "unfixed" and
>> "fixed".  Does this solve any problems?
>>
>
> As Matthieu Moy remarked in a previous email, the main reason is
> extensibility: I prefer having a single command to assign new
> descriptive labels instead of having to patch git-bisect.sh to create
> new labels like fixed, unfixed, fast, slow...
>
>> What happens if the user mixes, say, "good" and "fixed" in a single
>> bisect session?
>
> I don't think that's an issue. If the user uses the label "fixed"
> instead of "bad" she will have a hard time remembering to use it every
> time she needs it,...

I am not sure I understand what you are trying to say.  Are you
saying that we should stick to good/bad and allow the users use
nothing else, because allowing "fixed" will be confusing?

> and maybe the output of "git bisect" will look very
> confusing, but what can git do? This is a semantic user input error,
> not a syntax one.

For a young tool or a feature, catering to perfect human perfectly
is a good first goal---if it does not work well even for error-free
human input, it would be worthless.  However, its second goal after
achieving that first goal ought to be to help imperfect humans.

I can very well imagine somebody start hunting for an earlier bugfix
(perhaps trying to find it to backport to an older maintenance
track), start saying "fixed", "broken", "broken", ..., continue
after leaving for lunch for a while, and then try to mark the next
version he tests as "bad" because it has a bug.

It technically may be an user error, in the sense that in such a
"where is the fix?" session, you want to mark a "still-has-bug" one
as "broken" and mark a "no-longer-has-bug" one as "fixed" (just like
"still-broken" as "bad" and "no-longer-broken" as "good" in regular
bisection).  But at that point, the tool *knows* that the user
earlier used "fixed" (or "broken") to mark some commits *already*.

Why do you think there is nothing it can do to help the user?  Upon
seeing "bad", the tool should at least be able to say "Excuse me,
but you earlier said 'fixed' for one of the commits, so your
vocabulary now is limited to 'fixed' and 'broken'".  I think it also
should be able to add "Did you mean to say 'broken'?", or even "I'd
assume that you meant 'broken' and will continue."

I have always wondered if we can introduce a value neutral synonyms
to good and bad.  For a bisect session, we care only about two
states: "still-X" and "no-longer-X" where X may be 'working' for the
normal bug-hunting bisection and 'broken' for the fix-hunting one.

	$ git bisect still-working v1.6.0
        $ git bisect no-longer-working v1.8.0

would be a way to find a bug that was introduced during v1.6.0..v1.8.0,
while

        $ git bisect still-broken v1.6.0
        $ git bisect no-longer-broken v1.8.0

would be a way to find a fix in the same range.  The lowest-level
bisection machinery could just _ignore_ anything after still/no-longer
and do its thing, while the end-user facing layer could enforce,
once one commit is marked as still-X (or no-longer-X), that nothing
other than the same X is used, and issue an error message, perhaps
like this:

	$ git bisect still-broken v1.6.0
        $ git bisect still-working v1.8.0
        error: You earlier marked v1.6.0 as "still-broken" and
        error: are hunting for the first commit that can be marked
        error: as "no-longer-broken".  Say either "still-broken" or
        error: "no-longer-broken", not "still-working".

and that can be done without having to understand that "broken" is
the opposite of "working" (of course if we understood that, we could
even offer to guess that the user meant "no-longer-broken" by
"still-working", but we do not want to go there).
