From: "W. Trevor King" <wking@drexel.edu>
Subject: Re: [PATCH v3] Isolate If-Modified-Since handling in gitweb
Date: Wed, 21 Mar 2012 15:55:20 -0400
Message-ID: <20120321195520.GB32535@odin.tremily.us>
References: <20120321140429.GA28721@odin.tremily.us>
 <201203211755.07121.jnareb@gmail.com> <20120321173824.GA31490@odin.tremily.us>
 <7vmx7921yz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=pvezYHf7grwyp3Bc
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 21 21:56:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SASZY-0001Jz-3U
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 21:55:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341Ab2CUUzw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Mar 2012 16:55:52 -0400
Received: from vms173007pub.verizon.net ([206.46.173.7]:41083 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956Ab2CUUzu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2012 16:55:50 -0400
X-Greylist: delayed 3611 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Mar 2012 16:55:50 EDT
Received: from odin.tremily.us ([unknown] [72.68.85.198])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0M1900FMY3C9K180@vms173007.mailsrvcs.net> for
 git@vger.kernel.org; Wed, 21 Mar 2012 14:55:22 -0500 (CDT)
Received: by odin.tremily.us (Postfix, from userid 1000)	id EC77C4289A3; Wed,
 21 Mar 2012 15:55:20 -0400 (EDT)
Content-disposition: inline
In-reply-to: <7vmx7921yz.fsf@alter.siamese.dyndns.org>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193617>


--pvezYHf7grwyp3Bc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 21, 2012 at 12:22:44PM -0700, Junio C Hamano wrote:
> "W. Trevor King" <wking@drexel.edu> writes:
> >> I think it would be better to add initial tests with refactoring, and
> >> snapshot specific tests with snapshot support, e.g.:
> >>=20
> >>   1/2: gitweb: Refactor If-Modified-Since handling and add tests
> >>   2/2: gitweb: Add If-Modified-Since support for snapshots
> >
> > But the new tests would be for the new functionality (i.e. snapshot
> > support), so they wouldn't belong in the general refactoring commit.
>=20
> Then you are planning to split it in a wrong way.
>=20
> ... add tests for codepaths that use i-m-s to make sure your
> refactoring did not break them...

Ah, I was assuming that some current tests might be checking the
current behavior, and that my new tests would be testing my new
snapshot behavior.  If the old i-m-s handling also needs tests, that
should happen before any of my previously proposed patches:

1: tests for i-m-s and git_feed
2: refactor i-m-s handling
3: tests for i-m-s and git_snapshot (which fail until 4)
4: add i-m-s to git_snapshot

How does that sound?

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--pvezYHf7grwyp3Bc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQEcBAEBAgAGBQJPajInAAoJEPe7CdOcrcTZxrEIALtpGDCnlCnJrtf8HgIeHGbq
zKmhOyvFyUbL24xyjsdC5lkZ+Fz/rYdivB/3JvJpMF6ifJoECCOGMY5oorhsFk2U
kP0oHfLE/sQrZar96Qom8D1sA0ehHwlbtZefsskRiNzECnqKdL9rAQ6TMJMD7v9C
EwRxN/3Oh51VgP+j4rA+tUfjk2RKx+sUAWsJ16x9380hOnJjmzTlOxtXM8d8AjYh
Z+KvoAyAmc83+9Bo6o8Z+WydbE+HTMGPuZt9niVXgZ6vtAtX55r+mhygtBQIR8xk
EQ4QUaGXwB9a1t5Etxai3eulfKWQsGRlmVz+wzXdcCjJzhCoF1WJDOU5yaIfuMs=
=4dGB
-----END PGP SIGNATURE-----

--pvezYHf7grwyp3Bc--
