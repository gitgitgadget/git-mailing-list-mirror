From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [RFC] git integrated bugtracking
Date: Sun, 10 Jun 2007 10:37:54 +0200
Message-ID: <20070610083754.GC4084@efreet.light.src>
References: <20070603114843.GA14336@artemis> <20070609121244.GA2951@artemis> <46a038f90706092359i43a6e834rc096e53a28fbee51@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="S1BNGpv0yoYahz37"
Cc: git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 10 10:38:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxIwA-0004Pd-1A
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 10:38:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762831AbXFJIiK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 04:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762821AbXFJIiJ
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 04:38:09 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:42322 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762780AbXFJIiF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 04:38:05 -0400
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 12478573FE;
	Sun, 10 Jun 2007 10:37:57 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1HxIvq-00009w-Tk; Sun, 10 Jun 2007 10:37:54 +0200
Content-Disposition: inline
In-Reply-To: <46a038f90706092359i43a6e834rc096e53a28fbee51@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49679>


--S1BNGpv0yoYahz37
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 10, 2007 at 18:59:13 +1200, Martin Langhoff wrote:
> On 6/10/07, Pierre Habouzit <madcoder@debian.org> wrote:
> >  FWIW I've begun to work on this (for real). I've called the tool
> >"grit". You can follow the developpement on:
> >
> >  * gitweb: http://git.madism.org/?p=3Dgrit.git;a=3Dsummary
> >  * git:    git://git.madism.org/grit.git/
>=20
> Call me a fool, but writing a <new> bugtracker looks like a
> boil-the-oceans scheme.

I don't know about any *distributed* bug tracker, which is the point here.

We have several distributed version control tools, but no other distributed
tools for the other tasks in configuration management.

> Adding git & gitweb support to traq, bugzilla, mantis, gforge, etc is
> what is going to make the difference.

It would certainly be useful. But the problem with these bug trackers is,
that they don't go all that well with how many hackers work. And the less
they fit with distributed workflow.

 - The web interface is usually not a good match for the problem. Email
   interface is better in many respects, but it still does not cut it.
 - You can't really use the ability of version control to work disconnected,
   when you don't also have the bug information.
 - Distributed version control is designed to decrease the workload of the
   central maintainer(s) while keeping him in control. But with centralized
   bug tracking he still has a lot of work with that that the mob can't help
   him with. It helps if the bug tracker can close bugs based on something =
in
   commit-log, but you also need to see what it is that will be closed, whi=
ch
   requires integrating the bug tracker into the version control.

The other thing is, that a good bug tracker also needs to be integrated with
the *mailing list*. The major part of bug tracking is discussing those bugs
and discussions usually take place on mailing-lists (and on irc --
integrating that as well would be nice too).

I've actually already seen some attempts at something like this project. The
first one was for GNU Arch. Instead of using a bug-tracker, there was
a branch where each bug had it's mbox with all the relevant data. This mbox
was moved between directories depending on it's state. AFAIR there was no
tool to maintain it, just a description of the workflow.
(Tom Lord called it "the game". See eg.
http://www.dasbistro.com/~sam/mail/tom-lords-game)

The other attempt is obviously the Bugs Everywhere thing.

A related thing is Bazaar's "Bundle Buggy". It tracks patch submission rath=
er
than bugs, but it is roughly what I meant by the "mailing list integration"
above. It "reads" the mailing list, watching for anything labeled [PATCH] or
[BUNDLE] with patch or bundle (bundle is bazaar's extended patch) attached.
It also watches for replies with review (review outcome is stated with "-1"
(veto), "-0", "+0" and "+1" (ok)) and with further patches/bundles (updated
versions of the patch).

> [...]=20
>
> And definitely, if you use git as an alibi to write a new bugtracker,
> don't use the "works only with git" as a feature. It should work with
> as many SCMs as possible.

If it uses git as it's database, which it probably will, it will definitely
require git. Now it should be possible to have the code in different version
control, but it would be integration with things like git format-patch, that
will really make it cool stuff -- and that won't work with other version
control out of the box.

> OTOH, that's just me, I'm lazy and like to work on already-successful
> projects that are 99% there for my needs (and where I can add that
> 1%).

Yes. But for many people current bug tracking tools do NOT work 99%.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--S1BNGpv0yoYahz37
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGa7hiRel1vVwhjGURAgweAKCSpQGpEC2bSHWeHpnCS72NdOr1wQCgjU2V
Jqwolpi0A6fYXEA3EFXEZC4=
=0aV+
-----END PGP SIGNATURE-----

--S1BNGpv0yoYahz37--
