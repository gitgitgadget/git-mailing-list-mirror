From: Todd Zullinger <tmz@pobox.com>
Subject: Re: git doc build failure on OS X 10.5.6 (Leopard) during xmlto
 phase
Date: Thu, 12 Mar 2009 13:09:32 -0400
Message-ID: <20090312170931.GB19175@inocybe.teonanacatl.org>
References: <5e68abd90903110721o414283a4te188b58e0e4df8ad@mail.gmail.com>
 <76718490903110812t5e1723ebi28a84da680422d8a@mail.gmail.com>
 <76718490903110839m17041c7bxd7912eb09496c81a@mail.gmail.com>
 <76718490903110849x2ef48a89j3f17706390991eda@mail.gmail.com>
 <49B7E670.7060606@drmicha.warpmail.net> <gp95vf$gp1$1@ger.gmane.org>
 <49B8EF3E.2070208@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="hQiwHBbRI9kgIhsi"
Cc: Alejandro Riveira <ariveira@gmail.com>, git@vger.kernel.org,
	Jay Soffian <jaysoffian@gmail.com>,
	Tom Holaday <tlholaday@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Mar 12 18:16:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhoR5-00038H-M7
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 18:11:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755624AbZCLRJn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 13:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754171AbZCLRJm
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 13:09:42 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42825 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754074AbZCLRJl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 13:09:41 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3827EA1989;
	Thu, 12 Mar 2009 13:09:39 -0400 (EDT)
Received: from inocybe.teonanacatl.org (unknown [71.173.205.56]) (using TLSv1
 with cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B9077A1988; Thu,
 12 Mar 2009 13:09:33 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <49B8EF3E.2070208@drmicha.warpmail.net>
X-Listening-To: Pigface - Methylated
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Pobox-Relay-ID: 921B5220-0F28-11DE-8B36-CFA5EBB1AA3C-09356542!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113093>


--hQiwHBbRI9kgIhsi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Michael J Gruber wrote:
> Following up on this:
> On Fedora 10, I have asciidoc 8.2.5 and docbook 1.7.4 xsl's. For
> proper man and html doc, I have to set DOCBOOK_XSL_172=3DYes but leave
> ASCIIDOC8 unset! I always forget, though (just like the packagers).

Check the fedora git packages in rawhide, we don't set ASCIIDOC8. :)

I experimented with that and found it did not improve things.  We are
only setting DOCBOOK_XSL_172.  Without that, we get the '.ft C'
droppings.  With it, we get non-ascii characters in various places
(where bold should be used to make the (1) notations stand out, for
example).  This was filed as:

https://bugzilla.redhat.com/show_bug.cgi?id=3D485161

I didn't add DOCBOOK_XSL_172 to the F-10 packages yet, because I know
that it fixes one problem and causes another.  Either way, we'd be
shipping packages with known brokeness.  I chose to stick with keeping
the currently broken '.ft C' behavior.  Pick your poison. ;)

One of the fedora/red hat folks that works on the xmlto and docbook
packages was going to take a look, as I very much don't understand the
documentation stack.  :/

Anyone who does is very welcome to help find the culprit(s) and help
get fixes to the proper places.

--=20
Todd        OpenPGP -> KeyID: 0xBEAF0CE3 | URL: www.pobox.com/~tmz/pgp
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
The worth of a state, in the long run, is the worth of the individuals
composing it.
    -- John Stuart Mill


--hQiwHBbRI9kgIhsi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQFDBAEBAgAtBQJJuUHLJhhodHRwOi8vd3d3LnBvYm94LmNvbS9+dG16L3BncC90
bXouYXNjAAoJEEMlk4u+rwzjWRsH/3JOHkmJvz9QRKyPGbsMNTPyJoR5gU9joCDM
oMlCkWzpuQrsDOZpLkkYmfZQ0SJDn9svjJdPf7QX4BxPtYuA9tup8+IAmJhOk+jO
8gIJGA7WzFR6y2io0mQib1OPQLhRU7dzhniq1ZPRRUvXRERlMsAO2n3GWguQtTp2
BFZ4x0vY7GIdgkc+TVWdoAeyt5aQxmcBMvY7xoyX8uTyzYOwVTSofmC0FRKjGd4K
iT/BzrgHl0/lnKR/vSr/0l2/ZbYgZNXxbw7xbJi4LKp8DpJNu3ecMmQH0gLceGCt
aO8jX0qsj6FDX01fyiMglTJMokXna7RgSTika4PRVoj7eTta5pA=
=j7Za
-----END PGP SIGNATURE-----

--hQiwHBbRI9kgIhsi--
