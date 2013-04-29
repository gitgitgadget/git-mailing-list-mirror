From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] Highly inconsistent diff UI
Date: Mon, 29 Apr 2013 12:56:15 -0700
Message-ID: <7vehdti00w.fsf@alter.siamese.dyndns.org>
References: <CALkWK0n2ZZTgYxi3Fk2UxY8TXFAt1Xt3+11G98GKxbYdoMOT+Q@mail.gmail.com>
	<7va9ong9oa.fsf@alter.siamese.dyndns.org>
	<CALkWK0mVDT5ESnVJAWQ83gQnmxmGDoM_Y0nE4FGybcjcenA_KA@mail.gmail.com>
	<7v38ufer2x.fsf@alter.siamese.dyndns.org>
	<CALkWK0m5Q_e3q6Yg94-K+jU_SS7ovR2wnz-_Nr3cMz_YM=SMDQ@mail.gmail.com>
	<7vvc7baahc.fsf@alter.siamese.dyndns.org>
	<CALkWK0=NWSZsARu9w0DwpEmJHKnvpB8yoNfEa31LDQA=cV-90Q@mail.gmail.com>
	<CALkWK0ntZKaEzA0Jupj6poOMydqUumEGVVJ-uhBE12sPJ0ntjw@mail.gmail.com>
	<7vppxj6thv.fsf@alter.siamese.dyndns.org>
	<CALkWK0n9xqQr30QWEuhuM9c1xrAJ=SpYVBjkiRk+tP5E7DtBGw@mail.gmail.com>
	<7vhaipl2ks.fsf@alter.siamese.dyndns.org>
	<CALkWK0npQwFnFNpEzT5mgh5HvGUKf=Jz7v4Mn62BDBzb+qjY_A@mail.gmail.com>
	<7vmwshi3dv.fsf@alter.siamese.dyndns.org>
	<CALkWK0nNb1CSR6EHxtnvBd3VXVPNb_JDqk2Kfa5VA1RMG1u0Ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 21:56:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWuBU-0002oO-94
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 21:56:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760640Ab3D2T4T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 15:56:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46308 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758718Ab3D2T4S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 15:56:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7723D1AEA2;
	Mon, 29 Apr 2013 19:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uZkyJizw6aGCzhUI3ap/GmWGVzE=; b=H5s/1T
	tDoyzC4IlJSJzfc9vRDE3CKomoaBwstjHAVT+yHFJOem+jzm6cVoqUfVCCTcnuij
	3cT/nMsWtZ+sRyQ7KExuluzcC+2ASz2/vvoPFhVGiztGWiX9qFbnASMaDc2COy1D
	T5atJ5wBk24VNAsZGpuhKX3wTxTnk/TtFIh3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n+B6yInX5htbfViXgrOb54uQ7hjXvQFZ
	zjxv15uspobXhTkbQ2IPso9FbQqCwertOwhfmZMUiILEpILCu2vcp2gUjgoGSiB/
	Qd85E79C/JXM8BKDjPjlpwEmWUTOs94Lj06ll4Zzdk9WnwT5KMQNohgE5rf7/vFl
	TtcOIjwHP7U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6EAEE1AEA1;
	Mon, 29 Apr 2013 19:56:17 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A6CE01AE9F;
	Mon, 29 Apr 2013 19:56:16 +0000 (UTC)
In-Reply-To: <CALkWK0nNb1CSR6EHxtnvBd3VXVPNb_JDqk2Kfa5VA1RMG1u0Ng@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Tue, 30 Apr 2013 00:33:15 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DA6BA50A-B106-11E2-BA2D-8D009ADAE8A5-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222855>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> Wait.  What does "lists H G D A..C" even mean?  H, G and D I would
>> understand, but how does "log" ever "list" A..C???
>>
>> Now you really confused me.
>
> What you said was technically correct.  I was pointing out that the
> graph was misleading because it didn't show any commits between A and
> B/C.  A is ofcourse UNINTERESTING.
>
>> What does it mean "log" "In reality" shows A..B?  Didn't you just
>> say it either lists "H G D C" or "H G D B"?  Neither B nor C is what
>> you did since you forked?  Now, what did you do since you folked
>> (which is the question you are asking)?  You made commit D,
>> back-merged from upstream to record G, and then made another commit
>> H.  That "H G D", which is what you get from "log F..H", isn't it??
>
> Okay, so the question is ill-formed.  The technically correct version
> is "which commits are reachable from my branch since I forked off?",
> but I don't know if anyone will want to ask that question.

OK, I missed what you wanted to say with A..C, which only had B in
the concrete depiction.  Omitting all other merge bases and picking
only one (say C) at random will include not just B but all the other
commits that are not what you did since you forked before C.  Which
I think makes the example even less interesting, and you seem to
agree to that.

Thanks for clarification.  I was really getting worried if I was
missing something fundamental in what you were saying.

> I'm trying to look for one more command that will find A~B useful, so
> we can remove the A...B wart from diff; inventing it just to replace
> the wart isn't reason enough.  Do you disagree with the approach?

Have you ever seen me saying "it sounds like a good idea" to a
solution that is looking for a problem? ;-)

"diff A...B" works already, and stopping to refer to "diff A..B"
(the documentation patch you sent out) hopefully will make it less
confusing.  I do not see a huge upside in replacing it with yet
another notation people need to learn (and possibly make them
unlearn a working notation). The downside of it feels far worse.

> What are your thoughts on overloading it for rebase?  git rebase
> master~ to rebase onto the merge-base of master and HEAD?

Not very interested [*0*], but I haven't thought things through.

In order to express only what we can currently express (i.e. not
extending for a DAG with a single bottom and multiple refs at tops),
I think it is sufficient to allow "rebase [--onto=$there] origin.."
[*1*]; we can infer what ref is being rebased from the range we get
from the command line by asking rev_cmdline, and it may be more
natural to people who grew up with "git log origin..".

That approach would express the DAG with the usual revision range
specifier on the command line, limited to those range notations that
have a single bottom and a single top.  That range defines the DAG
that will be replayed, and its single top defines what ref is
updated as the result.

When --onto is not specified, we could choose to use two- vs three-
dot notations to select what "onto" to use by default [*2*].  For
example, "rebase origin.." could be a way to replay your work on top
of their work you fetched, while "rebase -i origin..." could be a
way to identify your work since you forked from them, and tweak then
without changing the base, i.e. the fork point (the latter of which
would match what you would get from "diff A...B" naturally).

If we later want to add "a DAG with a single bottom and multiple
refs at tops", it could be spelled as "rebase --multi --onto=$there
^origin rr/rebase-doc rr/triangle" or something [*3*].

But footnote *2* turns out to be the most important point in this
message. Earlier I said I haven't thought things through, but I
think I have now.


[Footnote]

*0* "git rebase master~" would rebase your current history on top of
one commit before master, but you could choose to use some line
noise character other than tilde.

*1* This is similar to the way we taught "origin.." and "-3 HEAD" to
"format-patch" that originally only took "origin".

*2* Having said that, I do not particularly like the approach to
exploit the difference between two- and three-dot forms and use it
in choosing which commit to use as the default "onto".

It might be more useful to have the distinction between "rebase -i"
and "rebase" make that decision. 

Replaying on top of the merge base would not be useful unless we are
doing "rebase -i" (it would be a no-op by definition). From that
point of view, "rebase origin" (or "rebase origin.." or "rebase
origin..."), because it is replaying your work on top of others, may
use --onto=origin by default. On the other hand, "rebase -i origin"
(or "rebase -i origin.." or "rebase -i origin..."), because you use
the command in order to tweak your work, and you mention 'origin'
merely to let Git know where your fork point is, may replay on the
original fork point it discovers with merge-base.

Or something like that.  The above makes me think that focusing on
the revision range notation is not terribly productive when
exploring how to make "rebase" easier to use to end users.

*3* "--multi" is merely an example to make it easy to tell the
command line from the traditional form that has an extra "switch to
this branch before starting anything" argument.
