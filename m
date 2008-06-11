From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: Consolidate SHA1 object file close
Date: Thu, 12 Jun 2008 00:25:34 +0200
Message-ID: <20080611222534.GC16439@artemis.madism.org>
References: <alpine.LFD.1.10.0806101842460.3101@woody.linux-foundation.org> <20080611074309.GB28629@artemis.madism.org> <alpine.LFD.1.10.0806110755190.3101@woody.linux-foundation.org> <20080611154020.GE28629@artemis.madism.org> <alpine.LFD.1.10.0806110952290.3101@woody.linux-foundation.org> <alpine.LFD.1.10.0806101842460.3101@woody.linux-foundation.org> <20080611074309.GB28629@artemis.madism.org> <alpine.LFD.1.10.0806110755190.3101@woody.linux-foundation.org> <20080611154020.GE28629@artemis.madism.org> <alpine.LFD.1.10.0806111030580.3101@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="f+W+jCU1fRNres8c";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Denis Bueno <dbueno@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jun 12 00:26:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6Ym1-0003e2-JD
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 00:26:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752991AbYFKWZj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 18:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753010AbYFKWZj
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 18:25:39 -0400
Received: from pan.madism.org ([88.191.52.104]:34105 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752991AbYFKWZi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 18:25:38 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 467182BA63;
	Thu, 12 Jun 2008 00:25:36 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 5CC08CFC9; Thu, 12 Jun 2008 00:25:34 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Denis Bueno <dbueno@gmail.com>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0806111037530.3101@woody.linux-foundation.org> <alpine.LFD.1.10.0806110952290.3101@woody.linux-foundation.org> <alpine.LFD.1.10.0806111030580.3101@woody.linux-foundation.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84673>


--f+W+jCU1fRNres8c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2008 at 05:34:53PM +0000, Linus Torvalds wrote:
>=20
>=20
> > > >   Quite often, when people commit, they have corrupt repositories. =
The
> > > > symptom is a `cannot read <sha1>` error message (or many at times).
>=20
> Btw, do you have exact error messages?

  Well, like said I don't have had the problem myself, and it's hard to
reproduce, people have it like once a week average, for people that
perform around 50 to 100 commits a week.

> That plain "cannot read <sha1>" sounds unlikely. It exists in archive-tar=
,=20
> archive-zip and builtin-tag (and in two of the tests), but not in any=20
> commit paths that I can tell.

  Well that was what I recalled, I'll pass the word that I want a copy
of the message so that people don't trash their history when it happens.

On Wed, Jun 11, 2008 at 05:25:28PM +0000, Linus Torvalds wrote:
> Do you have people using special flags for your NFS mounts? And do you=20
> know if there is some pattern to the client kernel versions when the=20
> problem happens?

  not that I'm aware of. One machine with issues has this:
192.168.2.2:/home on /home type nfs (rw,noatime,bg,intr,hard,tcp,rsize=3D65=
536,wsize=3D65536,addr=3D192.168.2.2)

  IOW nothing fancy that I can see.

On Wed, Jun 11, 2008 at 05:46:00PM +0000, Linus Torvalds wrote:
> On Wed, 11 Jun 2008, Linus Torvalds wrote:
> >=20
> > Do you have people using special flags for your NFS mounts? And do you=
=20
> > know if there is some pattern to the client kernel versions when the=20
> > problem happens?
>=20
> Oh, before I even go there - let's get the _really_ obvious case out of=
=20
> the way first.
>=20
> If you are using a shared git object repository (why are you doing that,=
=20
> btw?), are people perhaps doing things like "git gc --auto" etc at the=20
> same time? Perhaps even unknowingly, thanks to autogc?

  No, we're not using a shared git object repository, each developper
has a git checkout in his /home (on NFS) but works for real in a workdir
that lives on his local hard drive (to get faster compilation times,
because NFS really sucks at speed for compilation). Though, people
working on plain NFS have had the same problems.

  I also had the same reaction as you do, and I've seen such problems
occur, and the operation that we were doing was just "git commit -as" or
something very similar. No nothing in progress in any other terminal at
the same time.

> So if one client is doing some kind of gc and creates a new pack-file and=
=20
> then removes old loose objects, and another client has already looked up=
=20
> and opened that loose object (but not finished reading it), then when the=
=20
> file gets removed, you will literally lose the data on the other client=
=20
> and get a short read!

  I don't think that is what happens.

> And nothing we can do can ever fix this very fundamental issue of NFS. NF=
S=20
> simply isn't an even remotely POSIX filesystem, even though it's set up t=
o=20
> mostly _look_ like one when accessed from a single client.
>=20
> In general, I would discourage people ever sharing object directories=20
> among multiple users except in a server kind of environment (eg=20
> kernel.org).=20

  It's not shared repositories, really, it's just for conveniency so
that the object store is on NFS (and backuped like all that is on the
NFS server) but the checkouts on local hard drives, so that all
operations to the checkout are local. And when people commit, it goes
into the NFS and all is perfectly fine. Those repositories are *ONLY*
used by one physical user exclusively.


  I'll try to do some commits on NFS repeatedly tonight and trigger the
issue, I'll keep you posted.


--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--f+W+jCU1fRNres8c
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkhQUN4ACgkQvGr7W6HudhyirQCfaBYKD1GmUyW+vn0bc0v+6FyY
+NIAnAzXiAJklLqwO98TzS5Zj2ZWdYd7
=X9li
-----END PGP SIGNATURE-----

--f+W+jCU1fRNres8c--
