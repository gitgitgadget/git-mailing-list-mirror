From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: Dropping core.worktree and GIT_WORK_TREE support
Date: Mon, 25 Aug 2008 14:52:05 +0200
Message-ID: <20080825125205.GB23800@genesis.frugalware.org>
References: <quack.20080824T0140.lth3aku956e@roar.cs.berkeley.edu> <7vprnyqo59.fsf@gitster.siamese.dyndns.org> <20080824220854.GA27299@coredump.intra.peff.net> <7vzln2j9y2.fsf@gitster.siamese.dyndns.org> <20080824231343.GC27619@coredump.intra.peff.net> <7vhc9aj82i.fsf@gitster.siamese.dyndns.org> <20080824235124.GA28248@coredump.intra.peff.net> <7v7ia6j5q9.fsf_-_@gitster.siamese.dyndns.org> <20080825020054.GP23800@genesis.frugalware.org> <7v1w0dkd5s.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PETIzWh8d1Msfd+P"
Cc: Jeff King <peff@peff.net>, Karl Chen <quarl@cs.berkeley.edu>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 25 14:57:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXbZL-0007HJ-9y
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 14:53:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753904AbYHYMwK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 08:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753825AbYHYMwJ
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 08:52:09 -0400
Received: from virgo.iok.hu ([193.202.89.103]:54185 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753813AbYHYMwI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 08:52:08 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id E4D731B2503;
	Mon, 25 Aug 2008 14:52:05 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id A35084465E;
	Mon, 25 Aug 2008 13:52:54 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 8EA3B1788129; Mon, 25 Aug 2008 14:52:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v1w0dkd5s.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93618>


--PETIzWh8d1Msfd+P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 24, 2008 at 08:05:03PM -0700, Junio C Hamano <gitster@pobox.com=
> wrote:
> > Does this include removing of --work-tree as well?
> >
> > The git backend of Pootle (http://translate.sourceforge.net/wiki/) uses
> > it.
>=20
> Interesting.  Does it use it because it can (meaning, --work-tree is
> supposed to work), or because --work-tree is the cleanest way to do what
> it wants to do (if the feature worked properly, that is, which is not the
> case)?

It's like:

The current working directory is like
/usr/lib/python2.5/site-packages/Pootle. The git repository is under
/some/other/path/outside/usr.

Then Pootle has two possibilities:

1) save the current directory, change to /some/other, execute git, and
change the directory back

2) use git --work-tree / --git-dir

I guess the second form is more elegant. Of course if it is decided that
this option will be removed then the old form can be still used, but I
think that would be a step back.

> > Also, here is a question:
> >
> > $ git --git-dir git/.git --work-tree git diff --stat|tail -n 1
> >  1443 files changed, 0 insertions(+), 299668 deletions(-)
> >
> > So, it's like it thinks every file is removed.
> >
> > But then:
> >
> > $ cd git
> > $ git diff --stat|wc -l
> > 0
> >
> > is this a bug, or a user error?
>=20
> I  think it is among the many other things that falls into "the two
> attempts still haven't resolved" category.

I'm unfamiliar with this part of the codebase, so in case somebody other
could look at it, that would be great, but I'm happy with write a
testcase for it. (Or in case nobody cares, I can try to fix it, but that
may take a bit more time.)

--PETIzWh8d1Msfd+P
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiyqvUACgkQe81tAgORUJaMtgCaA3BoCKzlSDpekrWzK1YU6TRR
J2kAn3sQXqX0BhasHtMQA4aW63raUUQc
=8mPp
-----END PGP SIGNATURE-----

--PETIzWh8d1Msfd+P--
