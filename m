From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [RFC] git integrated bugtracking
Date: Sun, 3 Jun 2007 20:49:57 +0200
Message-ID: <20070603184957.GE30347@artemis>
References: <20070603114843.GA14336@artemis> <878xb19ot5.fsf@graviton.dyn.troilus.org> <20070603133109.GD14336@artemis> <200706031548.30111.johan@herland.net> <20070603151921.GB30347@artemis> <vpq1wgtnith.fsf@bauges.imag.fr> <20070603160736.GC30347@artemis> <Pine.LNX.4.64.0706031031520.6705@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="3XA6nns4nE4KvaS/";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Poole <mdpoole@troilus.org>
To: david@lang.hm
X-From: git-owner@vger.kernel.org Sun Jun 03 20:50:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Huv9c-0006E8-KS
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 20:50:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752393AbXFCSuB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 14:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752420AbXFCSuA
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 14:50:00 -0400
Received: from smtp7-g19.free.fr ([212.27.42.64]:34937 "EHLO smtp7-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752393AbXFCSt7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 14:49:59 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	by smtp7-g19.free.fr (Postfix) with ESMTP id B4B0818DE0;
	Sun,  3 Jun 2007 20:49:57 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 92D08804; Sun,  3 Jun 2007 20:49:57 +0200 (CEST)
Mail-Followup-To: david@lang.hm, Johan Herland <johan@herland.net>,
	git@vger.kernel.org, Michael Poole <mdpoole@troilus.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0706031031520.6705@asgard.lang.hm>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49022>


--3XA6nns4nE4KvaS/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 03, 2007 at 10:35:48AM -0700, david@lang.hm wrote:
> On Sun, 3 Jun 2007, Pierre Habouzit wrote:
>=20
> >On Sun, Jun 03, 2007 at 05:44:58PM +0200, Matthieu Moy wrote:
> >>Pierre Habouzit <madcoder@debian.org> writes:
> >>
> >>>  Yeah, now that I read that thread, well yeah, I think notes are a=20
> >>>hell
> >>>of a good concept for my ideas. I mean, a bug report would be=20
> >>>basically
> >>>a collection of notes:
> >>>  * the bug has been found at this commit ;
> >>>  * the bug has been not-found at this commit ;
> >>>  * this commit is a fix for that bug ;
> >>
> >>That's my feeling too. "Commiting" bug information in the tree is only
> >>half of a good idea. You want to be able to say, after the fact, "This
> >>commit had bug XYZ". OTOH, the idea (followed by bugs everywhere) that
> >>merging a branch would automatically close bugs fixed by this branch
> >>is a really cool thing.
> >
> > That would work with notes, as while merging you'll get the notes of
> >the commit in your branch, *and* the note about the fixing patch. So
> >there is no loss of "concept" here. In fact that was the thing that I
> >looked for. Notes are good. They just may not be enough to write an
> >in-git bugtracking tool, as a bug needs the "notes collection" concepts,
> >and maybe a few other.
>=20
> how would you identify bugs in such a way that they will match up when=20
> you merge different trees?

  well, because they will be sha1's, a git object. And when it's a
duplicate, well, let's face it, not bugtracker helps *automatically*
tracking duplicates. The merge work is up to the QA people. Yeah,
bugtracker won't do all the tracking. In a way, that's good, that means
there is still place for humans in that world :)

> if you can manage to do this it sounds like a great idea. but I'm not=20
> seeing a good way to do it at the moment. the answer may be a combination=
=20
> of a number of factors.
>=20
> 1. bug number doesn't work well in a distributed environment

  Sure, SCM revisions either. But git solved that once, I don't see why
the solution found at that time would be less of a solution now :)

> 2. something based on indentifying the cause of the bug (commit id + file=
=20
> + line????) will only work after you know the real cause of the bug

  It does not work in a real world, where real user don't grok code.

> 3. description is worthless, too many ways to describe things that have=
=20
> the same underlying cause

  Sure, though it could help finding dupes. BUt in my experience what
helps most, is fine grained categorizing, because you end up with few
bugs for a given component, and "same" bugs end up actually being near
in the UI or query tool. Of course it let space for bugs that get
actually miscategorized. But hell, my experience is also that many bugs
are discovered as beeing fixed years after the fix anyway.

  I don't plan fixing all that stuff, it can't really be. I just would
like to create a tool that isn't as painful for the programmer as
bugzilla (or rt or ...) is, while it would still be as pleasant and easy
to stick a web UI for the users over it, hence not making the user
experience less pleasant.

  My experience with bugtracking is that the most efficient way to deal
it is to let the programmer in charge of the responsible module deal
with those bugs. What programmer aren't willing to do is the triaging,
and pulling the bugs off a distant database/UI/.. off something that
isn't in their usual workflow.
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--3XA6nns4nE4KvaS/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGYw1VvGr7W6HudhwRAip7AJ43++bIO/FTol5Ek9dR4wjwIS+uFwCaAl8h
cpge7UJcnRv1GaKAHxE4aEk=
=1YRe
-----END PGP SIGNATURE-----

--3XA6nns4nE4KvaS/--
