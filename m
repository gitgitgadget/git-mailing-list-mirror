From: Luciano Rocha <luciano@eurotux.com>
Subject: Re: [PATCH] git-init: treat option `--bare'
Date: Thu, 29 May 2008 10:10:47 +0100
Message-ID: <20080529091047.GA21660@bit.office.eurotux.com>
References: <20080519175313.GA17305@bit.office.eurotux.com> <20080520194850.GB19226@bit.office.eurotux.com> <7vy761sgks.fsf@gitster.siamese.dyndns.org> <20080528185103.GA4431@bit.office.eurotux.com> <20080528185357.GB4431@bit.office.eurotux.com> <7vzlqaq67h.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 29 11:11:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1eAn-0003j4-7M
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 11:11:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753293AbYE2JK4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 05:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752930AbYE2JKz
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 05:10:55 -0400
Received: from os.eurotux.com ([216.75.63.6]:45095 "EHLO os.eurotux.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753007AbYE2JKy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 05:10:54 -0400
Received: (qmail 27819 invoked from network); 29 May 2008 09:10:52 -0000
Received: from unknown (HELO bit.office.eurotux.com) (luciano@82.102.23.9)
  by os.eurotux.com with AES256-SHA encrypted SMTP; 29 May 2008 09:10:52 -0000
Content-Disposition: inline
In-Reply-To: <7vzlqaq67h.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.14 (2007-03-31)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83185>


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2008 at 05:55:46PM -0700, Junio C Hamano wrote:
> Luciano Rocha <luciano@eurotux.com> writes:
>=20
> > Currently, passing the `--bare' option to git-init proper doesn't work,=
 and
> > gives no indication that `git --bare init' would work instead:
> >
> > $ git init --bare
> > usage: git-init [-q | --quiet] [--template=3D<template-directory>] [--s=
hared]
> >
> > Treat the `--bare' option internally in builtin-init-db.
> >
> > Also, fix the usage string, synchronising it with the synopsis in the
> > documentation.
> >
> > Signed-off-by: Luciano Rocha <strange@nsk.pt>
>=20
> It could be argued that this kind of "special casing to help common
> mistake situation" would in the long run hamper the new users in
> understanding what --bare means, because one who uses "git init --bare"
> will not realize that --bare is an option to "git" potty in general and
> can be given when invoking other git commands.  On the other hand, many
> commands do work sensibly inside a bare repository already, and "init" is
> truly special in that it cannot inspect the surroundings to guess if the
> user wants to create a bare repository or one with a work-tree because
> there isn't a repository yet.  In that sense, probably people not learning
> "git --bare" is not such a loss after all.
>=20
> In general, I am not particularly fond of this kind of special casing, but
> initializing a bare repository would be a common enough operation that I
> personally think it is probably Ok to take this as an exception.
>=20
> Opinions?  Breakages?
>=20

Personally, my first experience with bare repositories, was when I
decided to have local mirrors of several projects. As I weren't going to
do work over then, I considered copies without a checkout.  Reading the
documentation for git-clone, I found the '--bare' option, and found that
the commands that I mattered about worked transparently (log, diff,
archive).

Much later, when trying to create a public mirror of some of my
projects, I tried to create a bare copy. However, as I didn't have
access from the remote server to my working copy, I had to push my
changes to the remote server.

But 'git init --bare' didn't work, so I resorted to:
mirror$ git init
personal$ git push mirror:copy
mirror$ git clone --bare copy public

Only some time later, in a discussion with a friend, did I learn that
'git --bare init' worked (and thus this thread was started).

In my defence, the usage displayed when running just "git" hides the
'--bare' option, as my terminals usually have 24 lines.

And the transparently way that the other commands I cared about worked
inside a bare repository eliminated any need of mine to search for a way
to specify that I was working with a bare repository to all git commands.

All in all, you are right when you say that 'this kind of "special
casing" ... would in the long run hamper the new users ... [by not
realizing ] that --bare is an option to "git" potty in general', as is
attested by my ignorance of it. But as there is a valid reason for the
'--bare' option to git-clone, there is one for git-init.

But the '--bare' option for "git" must be at least mentioned in
the documentation for those two commands.

--=20
Luciano Rocha <luciano@eurotux.com>
Eurotux Inform=E1tica, S.A. <http://www.eurotux.com/>

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkg+cxcACgkQinSul6a7oB+qagCcC2VMss53O9WLU0r8NGFazBo3
Q9YAnj93c1jFmHUwFQYl/CQO9lIh0LR+
=LFwv
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
