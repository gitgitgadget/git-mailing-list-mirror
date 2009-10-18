From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached
 HEAD was
Date: Sun, 18 Oct 2009 15:47:13 -0700
Message-ID: <7vws2snwum.fsf@alter.siamese.dyndns.org>
References: <20091014230934.GC29664@coredump.intra.peff.net>
 <885649360910150036o72c3bd97ofad85d5316dc5b35@mail.gmail.com>
 <alpine.LNX.2.00.0910151523020.32515@iabervon.org>
 <alpine.LNX.2.00.0910161311460.28491@reaper.quantumfyre.co.uk>
 <20091016143041.GA11821@atjola.homenet>
 <alpine.LNX.2.00.0910161821230.30589@reaper.quantumfyre.co.uk>
 <20091017075551.GA5474@atjola.homenet>
 <7vws2ue8yc.fsf@alter.siamese.dyndns.org>
 <20091017084025.GC5474@atjola.homenet>
 <7vaazqcry5.fsf@alter.siamese.dyndns.org>
 <20091017194153.GA30003@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Daniel Barkalow <barkalow@iabervon.org>,
	James Pickens <jepicken@gmail.com>, Jeff King <peff@peff.net>,
	Nicolas Pitre <nico@fluxnic.net>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 19 00:47:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzeXY-0007tZ-IT
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 00:47:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755408AbZJRWrf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Oct 2009 18:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755405AbZJRWrf
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Oct 2009 18:47:35 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46403 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754259AbZJRWrb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Oct 2009 18:47:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B76327C9CC;
	Sun, 18 Oct 2009 18:47:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=r53nBhUjbupo//jquTj8mjFik
	Uw=; b=v/eea2LfrP5wqdXIz1pZIIa868LskQEavkGoLNkq+QXdxC0e/X9hGrAPE
	A7/mm3w0ReAzvGuQCYdScn3KmaEqRnAS7Pso0sFEowqZzqpcn08xUxque6l/3mdA
	V8ogUTg83YBcnEP02fgUECRlMl6N1E+dKHPTdk4b+iQKnF+rvo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=iKoWT+sLT1XHfeeFP3J
	nVaXWRX/Yn0YYf6znfxhDxm/D9scTf9c9/T6d3srXQkI8RHS0wLbRrohmrxdfDHl
	v9ob4EqreneDiU+6uDGhAFtjj9NJ7cr4w3QtBc5ZLCaM4l0tY56XoT3ezZrdNhVr
	QWvxp6mxZ3oNtqwUjJa/i3Gc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 48ED87C9C9;
	Sun, 18 Oct 2009 18:47:27 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 84CFA7C9C8; Sun, 18 Oct 2009
 18:47:15 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 35ABFE6E-BC38-11DE-9C1F-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130616>

Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de> writes:

> On 2009.10.17 02:04:02 -0700, Junio C Hamano wrote:
>> The "save" part of the work-save-then-merge sequence should be made =
very
>> visible to help people get used to the "not up, but work-save-then-m=
erge"
>> mental model.  I do not think it would help people in the long run t=
o make
>> the "save" step less visible by wrapping the sequence into an unreli=
able
>> "up" script, especially because the script would sometimes work but =
other
>> times *has to* force users to know that what is happening behind the=
 scene
>> is work-save-then-merge in order to resolve and recover from conflic=
ts
>> anyway.
>
> Hm, which cases would that be? I basically see three cases:
>
>  1) No uncommitted changes =3D> No problem
>  2) Uncommitted changes merge cleanly =3D> No problem
>  3) Uncommitted changes causes conflicts =3D>
>    - User can resolve
>    - User can start over (git update --retry)
>    - User can give up (git update --abort)

By "--abort", if you meant to discard the local change, that is only
suitable for people who would say "what I was doing was minor anyway, a=
nd
I'll redo them based on the updated upstream", and may not be so useful=
, I
think.  The user may want to pretend that he did not even start "update=
"
(i.e. not pulled while he was still working on something) at this point=
,
and if you meant by "give up" (aka --abort) to "reset --hard @{1} &&
unstash", I think it makes quite a lot of sense.  Then the user has an
option to fork a topic at that point:

    git update --abort
    git checkout -b topic
    work on more with committing
    git checkout master
    git update

But then this starts to look more like an enhanced failure recovery mod=
e
for "git pull" command.

In addition, I think that you would internally implement the "save" ste=
p
with "stash" (which would be a sane thing to do), but then you would ne=
ed
to worry about the case where the user was in the middle of a merge (or
"revert", "cherry-pick", "checkout -m") that did not complete.  "git pu=
ll"
fails upfront, says why and tells users what to do.  "git update" shoul=
d
do the same.

> I do see problems with a "stash around merge" thing ("stash" around
> rebase seems easier, as that could just create a commit and reset lat=
er,
> but I'm not exactly sure that such smartness is a good idea). As soon=
 as
> the merge has conflicts, you need to know that you have to unstash af=
ter
> committing the merge, but what I have in mind is fast-forward only (o=
r
> possibly reset, when upstream was rewritten).  Primarily for users th=
at
> don't commit at all, but just look at things [*1*].

Ok.  If you have a clean way to guarantee that "update" users won't
commit, I think the above would sort of make sense and my earlier worri=
es
about (1) a user who wish he did not fetch and (2) a user who was doing
something more complex and had conflicts already would go away.

If the sole target audience is "minor changes only, never committing"
people, then I would even rescind my earlier suggestion on --abort; it
should mean "remove the minor changes and get pristine copy of the
upstream---the user will redo the minor changes to adjust to the update=
d
upstream from scratch", to keep the end user experience simpler and
clearer.

I am undecided if it is a good thing to divide the userbase into two
classes, "update" people and "work-commit-fetch-merge-resolve" people.

> [*1*] One could also say: Users that don't give a damn about git, but
> just need it to get the code and maybe have some minor, uncommitted
> modifications on top. I'm _not_ thinking about users that actually
> commit and do stuff. Those should use merge/rebase/pull, and get a
> complaint from "git update" if the update is not a fast-forward one,
> telling them what to use instead.
