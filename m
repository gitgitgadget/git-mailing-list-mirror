From: Johan Herland <johan@herland.net>
Subject: Re: [1.8.0] Provide proper remote ref namespaces
Date: Mon, 07 Feb 2011 04:35:31 +0100
Message-ID: <201102070435.31674.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 07 04:35:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmHt7-0002xo-F9
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 04:35:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754501Ab1BGDff convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Feb 2011 22:35:35 -0500
Received: from smtp.getmail.no ([84.208.15.66]:62493 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754483Ab1BGDfe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Feb 2011 22:35:34 -0500
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LG8007UB9Z9N280@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Mon, 07 Feb 2011 04:35:33 +0100 (MET)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 8135D1EA56D6_D4F6885B	for <git@vger.kernel.org>; Mon,
 07 Feb 2011 03:35:33 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 9D0731EA296D_D4F6884F	for <git@vger.kernel.org>; Mon,
 07 Feb 2011 03:35:32 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LG8006O79Z78N20@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Mon, 07 Feb 2011 04:35:32 +0100 (MET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166225>

(resend without HTML part; I apologize for the inconvenience)

On Monday 07 February 2011, Dmitry Potapov wrote:
> On Sun, Feb 06, 2011 at 11:12:51PM +0100, Johan Herland wrote:
> There are two sorts of tags:
> - local tags, which are never intended to be shared with others but u=
sed
>   by users to mark some points in the working repository.
> - global tags, which are just _social_convention_ about what the curr=
ent
>   project considers as official versions. Without social convention, =
they
>   make no sense.

Agreed.

> > The core of this discussion is where we want to place Git in the sp=
ace
> > between "technically correct" and "socially conventional", where th=
e
> > former means owning up to the fact that each repo really is its own
> > namespace, and there's no way around that in a proper DVCS, and the
> > latter means building social convention into our tools, thereby mak=
ing
> > it harder to deal with the few unconventional cases (like my two
> > semi-related repos case).
>=20
> Tags like words are social convention, which are used for communicati=
on
> between people participated in a project. But accordingly to you, it
> seems somehow "technically correct" to invent their own words in Hump=
ty
> Dumpty's ways:
>=20
> 'When I use a word,' Humpty Dumpty said, in rather a scornful tone, '=
it
> means just what I choose it to mean =97 neither more nor less.'
>=20
> I am afraid you got the wrong idea about "proper DVCS", because DVCS
> does not imply that there is no social convention. It just means that
> there is no single authority that dictates everything. Like with word=
s,
> there is no single authority that assigns meaning to new words, but
> that does not mean that you cannot just say "When I use a word... "
> if you want to be understood by others.

I think there is a misunderstanding in my use of the phrase "technicall=
y=20
correct". I use it to merely state what is a theoretical truth: In a DV=
CS=20
world there is no single authority that dictates the meaning of a tag n=
ame.

I do not mean that "technically correct" is inherently _better_ than th=
e=20
alternative (maybe "theoretically true" is a better phrase). I certainl=
y do=20
NOT mean that the Humpty Dumpty approach is somehow more desirable than=
=20
following project conventions. To the contrary, I very much _support_ t=
he=20
idea of project-wide tags. I'm merely stating that the technical facts =
of a=20
DVCS makes it _theoretically_ impossible to enforce project-wide agreem=
ent=20
on tag names.

Of course, in _practice_ we use project-wide tags without problems all =
the=20
time. And they obviously form a _semantic_ namespace that spans the ent=
ire=20
project. I don't disagree with you here.

Where we disagree is whether Git should base its tag refs on the=20
_theoretically_true_ model, or on the _common_practice_ model. Of cours=
e,=20
the real solution lies somewhere in between the two extremes:

I propose that even though we base Git on the theoretical DVCS truths, =
we=20
try very hard to make it Just Work (tm) in the common case (especially=20
making sure that existing use cases are preserved as much as possible).

As I understand your view (I do apologize if I somehow misrepresent it)=
, you=20
want Git to assume that the common practice of one semantic namespace i=
s=20
followed. Furthermore, you also want to enforce that practice where=20
possible, while still improving the handling of the uncommon (but=20
theoretically inevitable) case (warning and presumably guiding the user=
 when=20
a tag conflict occurs).

> > AFAICS, my proposal does not harm the common case (unambiguous tags=
 are
> > still interpreted unambiguously, even if they may exist in multiple
> > namespaces), while it _does_ help the uncommon case (by allowing
> > ambiguous tags to co-exist in the same repo).
>=20
> It hurts the common case in a few ways:
> 1. It breaks existing user scripts

Yes, but that was sort of in the pretext of this thread ;)

Seriously, though, we should of course try to keep as many scripts as=20
possible working smoothly. For instance, existing remotes will not be=20
updated, so everything should keep working for them. It shall also be=20
possible to use old-style refspecs when creating new remotes, meaning t=
hat=20
whatever scripts depend on the old-style refspecs can be upgraded at=20
leisure. We could even add a config variable choosing between old-style=
=20
(default) and new-style refspecs.

With this in place, I believe the user script breakage will be minimal.=
 If=20
there is still significant breakage, we should reconsider the relevant =
part=20
of the proposal.

> 2. It complicates things for users (as Matthieu wrote above).

I guess this depends on your POV. Fundamentally, I do NOT want to chang=
e how=20
people refer to tags. I only want to provide them the possibility of do=
ing=20
so when ambiguity is present.

> 3. git fetch cannot report a tag clash if it happens

Yes it can: For each tag fetched from the remote, if resolving its shor=
thand=20
name ("v1.7.4") results in ambiguity (i.e. there exists a conflicting t=
ag=20
elsewhere in this repo), then warn the user about this conflict, and ex=
plain=20
how to refer to each tag candidate using the full ref name. Also explai=
n how=20
the user may resolve the ambiguity by creating a local tag=20
("refs/tags/v1.7.4") pointing to the preferred target.

> I believe that the right interface when the common case is simple, bu=
t
> an uncommon case is still possible to handle. I don't think that
> currently git meets this criterion, but making tag namespaces based o=
n
> the remote name strikes me as a really bad idea. Tags are attributes =
of
> a project and not particular remote.

Yes they are (in pratice), and no they aren't (in theory). See above.

> > My proposal tries very hard to present a single namespace
> > _semantically_ to the user in the common case (when tags are
> > unambiguous). I'd even go as far as proposing that "git tag -l" sho=
uld
> > by default list only a single shortened tag name in the cases where
> > there are multiple unambiguous alternatives.
>=20
> IMHO, it is very confusing, especially for people whose script was
> suddenly broken by those namespaces.

I believe script breakage can be minimized. See above.

> > Alternatively, I'd suggest a compromise (already mentioned elsewher=
e in
> > this thread) where we add a config variable tags.preferredRemote
> > (defaults to "origin") which allows you to directly select which
> > namespace you consider official. You could even implement this as
> > physically copying
> > refs/remotes/${tag.preferredRemote}/tags/* into refs/tags/*.
>=20
> It seems you do not understand the problem that I am trying to say al=
l
> way along: there is more than one repo from which I fetch tags, and
> because they are belong to the same project, they should be in the sa=
me
> namespace.
>=20
> So, IMHO, the proper solution should be ability to specify the desire=
d
> namespace for any remote repository, like this:
>=20
> remote.<name>.tagNameSpace =3D foo

Interesting. I'm not sure what "foo" means in this context. Would I use=
 it=20
like this?:

    remote.origin.tagNameSpace =3D refs/tags

(to place origin's tags in refs/tags/*)

If so, what's the difference between this option, and using this?:

    remote.origin.fetch =3D refs/tags/*:refs/tags/*

> So, those who want to have many namespaces should be able to that
> easily, but forcing multiple namespaces on those who have a single
> namespace semantically is simple wrong. Not to mention that it breaks
> existing scripts for no good reason.

In practice, this discussion boils down to whether we should use

    remote.origin.fetch =3D refs/tags/*:refs/remotes/origin/tags/*
or
    remote.origin.fetch =3D refs/tags/*:refs/tags/*

as the default refspec for tags. AFAICS, we both agree that whichever=20
refspec is chosen by default, it should be possible for the user to (fa=
irly=20
easily) override, and use the other refspec instead.

With that, my main concern about this part of the proposal is satisfied=
:=20
Putting remote tags in separate namespaces will be easy to accomplish (=
if=20
not the default behavior).


Thanks for the feedback,

=2E..Johan


PS: I'd be interested if you have a suggestion for how to deal with the=
=20
issue presented by Nicolas' elsewhere in this thread. Quoting:

The extraordinary misfeature of the tag namespace at the moment comes=20
from the fact that whenever you add a remote repo to fetch, and do fetc=
h=20
it, then your flat tag namespace gets polluted with all the tags the=20
remote might have.  If you decide to delete some of those remote=20
branches, the tags that came with it are still there and=20
indistinguishable from other tags making it a real pain to sort out.

--=20
Johan Herland, <johan@herland.net>
www.herland.net
