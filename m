From: martin f krafft <madduck@madduck.net>
Subject: Re: finding the right remote branch for a commit
Date: Thu, 12 Jul 2007 09:47:45 +0200
Message-ID: <20070712074745.GA28507@piper.oerlikon.madduck.net>
References: <20070710144907.GA324@piper.oerlikon.madduck.net> <Pine.LNX.4.64.0707112226170.4516@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 12 09:47:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8tP4-0003Et-RT
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 09:47:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755209AbXGLHru (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 03:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756898AbXGLHru
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 03:47:50 -0400
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:58768 "EHLO
	albatross.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755019AbXGLHrs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 03:47:48 -0400
Received: from localhost (albatross.madduck.net [127.0.0.1])
	by albatross.madduck.net (postfix) with ESMTP id 18362895D73
	for <git@vger.kernel.org>; Thu, 12 Jul 2007 09:47:47 +0200 (CEST)
Received: from albatross.madduck.net ([127.0.0.1])
	by localhost (albatross.madduck.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 17533-06 for <git@vger.kernel.org>;
	Thu, 12 Jul 2007 09:47:46 +0200 (CEST)
Received: from wall.oerlikon.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by albatross.madduck.net (postfix) with ESMTP id B3C60895D72
	for <git@vger.kernel.org>; Thu, 12 Jul 2007 09:47:46 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id BDE1A9F15D
	for <git@vger.kernel.org>; Thu, 12 Jul 2007 09:47:45 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 8C1F943FC; Thu, 12 Jul 2007 09:47:45 +0200 (CEST)
Mail-Followup-To: git discussion list <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707112226170.4516@racer.site>
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.21-2-amd64 x86_64
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
X-Spamtrap: madduck.bogus@madduck.net
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at madduck.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52253>


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Johannes Schindelin <Johannes.Schindelin@gmx.de> [2007.07.11.23=
26 +0200]:
> Okay, after discussing this for a bit on IRC, here is what I would
> do (I already said this on IRC, but the mailing list is really the
> better medium for this):

I agree. However, I find IRC to have its merits. For instance, all
of our discussion yesterday would have taken days over the list, but
on IRC I was able to interject when I did not understand something
or you could stop me when I was going down a garden path.

Of course, IRC isn't archived in the sense that lists are, which is
why I make an effort to send updates to the list, such as I did to
another thread yesterday: http://marc.info/?l=3Dgit&m=3D118418250002028&w=
=3D2

> I would actually rename .etc/ into gits/, because it is not
> a directory containing settings, but a directory containing
> repositories.

Yes and no. I already use ~/.etc/ to store my settings and symlink
into it, but I do like your idea too, actually. I have yet to go
and try it, and I shall report back then.

> Everytime I would work on, say, .vimrc, I would say
> "--git-dir=3D$HOME/gits/vim.git", or maybe even make an alias in
> $HOME/.gitconfig, which spares me that:

I wish there were a way to determine which repository a file belongs
to and then to automatically select the right repository. I guess
one can script that by iterating all repos and using git-ls-files,
possibly caching the result.

Anyway, I tried your approach and failed:

  $ mkdir repo
  $ GIT_DIR=3Drepo git init
  $ GIT_DIR=3Drepo git config core.bare false
  $ echo 1 >a; GIT_DIR=3Drepo git add a; GIT_DIR=3Drepo git commit -m.
  fatal: add must be run in a work tree
  nothing to commit (use "git add file1 file2" to include for commit)

I am probably doing something wrong, but what?

> Come to think of it, this is maybe what I would have done, but it appears=
=20
> to me that this is the _ideal_ use case for worktree:

Yes, it does. I am downloading the source now and intend to work
with the HEAD (is that the right term for what I used to call trunk
when I was doing SVN?) from now on (instead of the Debian package).

> - you have to say
>=20
>   $ git --work-tree=3D$HOME --bare init
>=20
>   which is a bit counterintuitive.  After all, it is _not_ a bare=20
>   repository.  The whole purpose of worktree, as far as I understand, is=
=20
>   to have a _detached_ repository, which would otherwise be called bare.

I said

  GIT_DIR=3Drepo git --work-tree `pwd` init

and that seems to do everything it should, it sets core.worktree to
=2E and core.bare to false.

> Those are serious bugs.  Matthias, any idea how to fix them?

That would be splendid. I am operating off HEAD now, so feel free to
prod me for any testing.

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
spamtraps: madduck.bogus@madduck.net
=20
"a scientist once wrote that all truth passes through three stages:
 first it is ridiculed, then violently opposed and eventually,
 accepted as self-evident."
                                                       -- schopenhauer

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature (GPG/PGP)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGldyhIgvIgzMMSnURAoL3AKDR+s99fnXb167yjSXMI8F8LMF2qgCeMI/7
qGLgCK8swfwvdf48KMaqroo=
=uY4F
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
