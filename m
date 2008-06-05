From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFC PATCH] git-add--interactive: manual hunk editing mode v2
Date: Thu, 5 Jun 2008 11:38:15 +0200
Message-ID: <200806051138.28889.trast@student.ethz.ch>
References: <200805232221.45406.trast@student.ethz.ch> <200806051105.02802.trast@student.ethz.ch> <20080605092016.GA16748@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1542710.ezQrccXCoe";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 05 11:39:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4Bvo-00033Z-Sb
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 11:38:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751757AbYFEJh7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 05:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753075AbYFEJh7
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 05:37:59 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:19815 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751721AbYFEJh6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 05:37:58 -0400
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 5 Jun 2008 11:37:57 +0200
Received: from vpn-global-dhcp3-023.ethz.ch ([129.132.210.23]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 5 Jun 2008 11:37:57 +0200
User-Agent: KMail/1.9.6 (enterprise 20070904.708012)
In-Reply-To: <20080605092016.GA16748@sigill.intra.peff.net>
X-OriginalArrivalTime: 05 Jun 2008 09:37:57.0146 (UTC) FILETIME=[D6184FA0:01C8C6EF]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83890>

--nextPart1542710.ezQrccXCoe
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Jeff King wrote:
> > [Let's just forget about the original patch at the top of the thread;
> > in retrospect, it _is_ clunky, and the UI didn't get any replies in
> > favour.]
>=20
> It seems like Junio isn't all that keen on the raw patch-editing
> interface. And even if we do like it, I think there is still room for a
> less error-prone but more restrictive feature that mere mortals can use.
> So maybe there is a better interface yet.

Maybe git gui could do a sort of "toggle the lines I click" interface.
But I don't know anything about Tk, or Tcl, or git gui :-(

> What about 'S' to do a "line split"; that is, take the current hunk, and
> anywhere there are adjacent changed lines, split them into their own
> hunks.
[...]
> and then we proceed as usual, staging or not each split hunk. It would
> be clunky to separate one or two lines from a huge chunk (since you
> would inadvertently split the huge chunk and have to stage each
> individually). But in many cases you can split into smaller hunks first
> with 's'.

Now I'm slightly confused.

Doing it that way would be almost like my original patch

  http://www.spinics.net/lists/git/msg66971.html

minus the numeric prefixes -- meaning that you have to say y/n to
_every_ line in the patch, at least until all remaining hunks are the
same and you can answer the rest with a/d.

Except that it wouldn't work anyway, because git-apply refuses hunks
that have no context (even if just on one end).  Unless given
=2D-unidiff-zero, but that apparently was one of the points of refusal
in the thread Dscho linked earlier:

  http://thread.gmane.org/gmane.comp.version-control.git/67854/focus=3D68127

Granted, we could insert extra context and/or make sure the mentioned
data loss can never happen (it's probably prevented by 'add -p's own
recounting before the final apply), but the first would make the UI
even more confusing and the second is potentially dangerous.

=2D Thomas

=2D-=20
Thomas Rast
trast@student.ethz.ch



--nextPart1542710.ezQrccXCoe
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)

iD8DBQBIR7QUqUud07tmzP0RAgjVAKCEdwkxYqMF/HttOt/tRfh8os7pCgCfdLBF
XcdTt0H1zYjIj4tOd5fxcl8=
=Qzde
-----END PGP SIGNATURE-----

--nextPart1542710.ezQrccXCoe--
