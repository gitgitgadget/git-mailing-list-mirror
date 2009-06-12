From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] send-email: Refuse to send cover-letter template subject
Date: Fri, 12 Jun 2009 13:48:16 +0200
Message-ID: <200906121348.19103.trast@student.ethz.ch>
References: <7fedc4b76fed03e4db6a2bb7453609c9cd02928a.1244496564.git.trast@student.ethz.ch> <7v4ouqwa42.fsf@alter.siamese.dyndns.org> <200906091019.11000.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1410208.3Bn6Avl3D5";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 13:48:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MF5FJ-0007SS-8f
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 13:48:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753294AbZFLLsX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2009 07:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751000AbZFLLsW
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 07:48:22 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:47085 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750783AbZFLLsV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 07:48:21 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 12 Jun 2009 13:48:22 +0200
Received: from thomas.localnet ([129.132.153.233]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 12 Jun 2009 13:48:22 +0200
User-Agent: KMail/1.11.90 (Linux/2.6.27.23-0.1-default; KDE/4.2.90; x86_64; ; )
In-Reply-To: <200906091019.11000.trast@student.ethz.ch>
X-OriginalArrivalTime: 12 Jun 2009 11:48:22.0521 (UTC) FILETIME=[B00CC690:01C9EB53]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121409>

--nextPart1410208.3Bn6Avl3D5
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Thomas Rast wrote:
> Junio C Hamano wrote:
> > Thomas Rast <trast@student.ethz.ch> writes:
> >=20
> > > Every so often, someone sends out an unedited cover-letter template.
> > > Add a simple check to send-email that refuses to send if the subject
> > > contains "*** SUBJECT HERE ***", with an option --force to override.
> >=20
> > Good ;-).  More valuable to detect would be an empty "blurb" section
> > (i.e. not "unedited *** BLURB HERE ***" string, but literally, there is
> > nothing said in the message other than the shortstat).
>=20
> Wouldn't that be AI complete?  As in, whatever regex (or similar) you
> might cook up could probably be matched by *someone's* style of patch
> descriptions, and then it suddenly becomes rather hard to tell them
> apart.

=46or a contrived example, compare

=2D- 8< --
Thomas Rast (1):
  Documentation: teach stash/pop workflow instead of stash/apply
=2D- >8 --

and

=2D- 8< --
Patch (1):
  Some explanation of what patch number 1 does
=2D- >8 --

Except for the " (1):", the whole contents of the shortstat are
given by the patches.  So I don't think it's possible to tell them
apart without figuring out what the shortlog would have said for the
actual patches, and comparing that to the contents.  I'd rather not
parse the patches for author info and subject.

What do you want me to do about the patch?  Should I extend it so that
it traps both "*** BLURB HERE ***" and "*** SUBJECT HERE ***"?

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart1410208.3Bn6Avl3D5
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkoyQIMACgkQqUud07tmzP2XKgCgl+AZ2emd1iNzDjUCRN/ioy67
ru8Ani4dgOr1NPxxpjH70WWUl+AsIgwD
=lykP
-----END PGP SIGNATURE-----

--nextPart1410208.3Bn6Avl3D5--
