From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Improving merge messages for 1.7.10 and making "pull" easier
Date: Fri, 24 Feb 2012 11:39:39 -0800
Message-ID: <7vy5rsyq9w.fsf@alter.siamese.dyndns.org>
References: <CACBZZX5UVq9k7jvSy3m+yMVj7_JbfLp8ugFWf2gGFdMz_8GPEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 24 20:39:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S10zd-0003CI-3b
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 20:39:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757554Ab2BXTjn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Feb 2012 14:39:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47197 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755141Ab2BXTjm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Feb 2012 14:39:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 939337C88;
	Fri, 24 Feb 2012 14:39:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=aMSEYK++nbsE
	qFzQ27f8uy9wTT8=; b=Wa4/V2aFqVQTIcZZ/oAK1C6VunCtvep2k0KY8KDKv3fU
	M7PUfOZF/dxixsR/LC19eExjpjKwmvHLfLO6AlC9XHIR4FYRQwggz6DlNuw6Pvv2
	eMLLb2kkyNuFQ86tPxcmlOuNKbS/SI9qXS0wpjNucdC3TKd4hoNT2bdgNDH7hBE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=BNvXZf
	i4b8Ex7HauXgigDuq9i3r9MjcLu6Z4KrMFFWEWzFIiSZH+AREtGNTlW0YOeDJhNE
	naz2sdsyctPIaClIgVrFhBc4hco5tiQtY8r4bBIcGRUAEOddXZZOh11hhs1s9Va/
	uKbRPY71lvhKQDhTIa6+Ma0vUgQAdEjJ6m6lA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A7BA7C87;
	Fri, 24 Feb 2012 14:39:41 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E41EC7C86; Fri, 24 Feb 2012
 14:39:40 -0500 (EST)
In-Reply-To: <CACBZZX5UVq9k7jvSy3m+yMVj7_JbfLp8ugFWf2gGFdMz_8GPEA@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 24 Feb
 2012 10:59:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4B47F9D0-5F1F-11E1-A619-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191449>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Firstly (and as a more general thing) I think we should add a mention
> of "git merge --abort" to the message, just saving an empty file is
> not sufficient to fully clear the merge state:

Makes sense, but the new message does not quite parse.

>> "Lines starting with '#' will be ignored, and an empty message follo=
wed\n"
>> "by 'git merge --abort' the merge.\n");

Perhaps s/the merge/aborts &/ or something.

> Additionally, perhaps it would be a good idea to:
>
>  * Detect if the user didn't run this explicitly but implicitly from =
a
>    "git pull". We could pass some env var along or another option
>    (e.g. --internal-from-porcelain=3Dpull) and add this:
>
>        You've merged implicitly via a "git pull", if you're just
>        updating some local work in progress to keep up with upstream
>        you may want to use "git pull --rebase" instead (or set the
>        pull.rebase configuration variable) to rebase instead of merge=
=2E

Won't this message be given to _all_ users of "git pull", even to the o=
nes
who already have decided correctly that "pull" is the right thing in th=
eir
situation?  With a new advice.* settings to squelch it, perhaps.

>  * Explicitly check if we're merging an updated upstream into the
>    work-in-progress topic,...

It might be a worthy goal, but how would we detect it?  A few examples
that we shouldn't give an unhelpful advice with a false positive are
merges into:

 - The 'master' branch used by people who use Git as an improved CVS, w=
hen
   they do an equivalent of 'cvs update'.  Merging the updated 'master'
   from the central repository into their 'master' that contains their
   work that may or may not be ready to be pushed back is how their
   project works.  It is a norm for them to make such a merge, even tho=
ugh
   more experienced people may prefer to see the history of their proje=
ct
   kept cleaner by suggesting their project participants to use their o=
wn
   topic branches.

 - Integration branches like my 'next', when it gets a merge from
   'master'. This is "merging an updated upstream" but is done in order=
 to
   keep the promise that 'next' would contain everything in 'master'.

And what alternative would we offer?  If we were to suggest "rebase", w=
e
would also need to consider the topic of the other a-couple-of-days-old
thread to detect which part of history is no longer subject to rewrite.

> I work with a lot of inexperienced git users and a lot of them are
> going to be very confused by this change. I still think it's a good
> change to make, but we could do a lot more to mitigate the inevitable
> confusion.

What exact change are you talking about with "this change"?  Earlier yo=
u
had a chance to edit the merge log only when it needed your help resolv=
ing
(hence you did a separate "git commit" to record it) but you had to "gi=
t
commit --amend" (or start with "git merge --no-commit") to edit the mer=
ge
log if it did not need any help resolving conflicts, but now you do not
have to.  Is that the change you have in mind?

I would like to know how that would lead to an "inevitable confusion".
Admittedly, the original without any "# Please do X" comment, the user =
may
wonder what is being asked of him when he sees the editor for the first
time, but I thought Thomas's patch took care of that issue.

> One thing that would help these users in particular would be to have
> some easy to use replacement for their frequent use of "git
> pull".

After this part, I think you shifted into a different topic.

I have mixed feelings about "rebase your unpublished work and keep it
always a descendant of the upstream" workflow you seem to be advocating=
=2E
It _might_ deserve a bit more visibility, but I do not think rewording
this message done during "merge" is the place to do so.

> They don't often commit their work (because of git inexperience) so
> rebasing will error out because the tree is unclean.

That is a *good* thing, isn't it?  There lies the perfect opportunity f=
or
them to train their fingers to commit first and then rebase.
