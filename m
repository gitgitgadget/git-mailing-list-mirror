From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: A local shared clone is now much slower
Date: Mon, 8 Jul 2013 13:03:55 +1000
Message-ID: <20130708130355.647fffb6e5b6a453bfa0fa6e@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Mon__8_Jul_2013_13_03_55_+1000_FPgru/_sR2RV_y7e"
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Linus <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 08 05:04:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uw1kN-00032D-7w
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 05:04:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753407Ab3GHDEK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 23:04:10 -0400
Received: from haggis.pcug.org.au ([203.10.76.10]:57027 "EHLO
	members.tip.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753390Ab3GHDEJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 23:04:09 -0400
Received: from canb.auug.org.au (ibmaus65.lnk.telstra.net [165.228.126.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by members.tip.net.au (Postfix) with ESMTPSA id 9C15416406C;
	Mon,  8 Jul 2013 13:04:01 +1000 (EST)
X-Mailer: Sylpheed 3.4.0beta4 (GTK+ 2.24.19; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229822>

--Signature=_Mon__8_Jul_2013_13_03_55_+1000_FPgru/_sR2RV_y7e
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi guys,

So commit 0433ad128c59 ("clone: run check_everything_connected") (which
turned up with v1.8.3) added a large traversal to clone which (as the
comment said) makes a clone much slower.  It is especially noticeable on
"git clone -s -l -n" which I use every day and used to be almost
instant.  Is there any thought to making it fast again, please?

The above clone is very useful for working with different branches in one
tree without touching every file in the main branch you are working
with (and consequent issues with rebuilding at least).  As linux-next
maintainer, you can imagine that I do this a bit.

I am sure one of Linus' points about branches was that being able to make
a fast local clone of a tree to use more than one branch was a feature.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Mon__8_Jul_2013_13_03_55_+1000_FPgru/_sR2RV_y7e
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJR2iwfAAoJEECxmPOUX5FEqGkP/1GNHxASElBnm/otL1vWx0dU
cf2oOaZWXGBJcXn2IWTUYA1nsTJ/TdtdH3vz2UH+0RXxZjyzQAMTd/giGPAborW8
haz+yoDido/PQfQDV6ZioNX7hlH1hen8HC+kwV3KDOge875yiq/ko+O6Xwpn4ufD
7NSmcrclNHAccCyIxYYIy9iqc4gZxDohZghXd6AHvNl+tTFBwDXAQIoQ/UpZ5xFC
/ZG7UlUkcIBknu/t/o+cuqu2cl47OE0sr5mC9CFBu3aWkyuv1vVM/y7T1K9PXTkL
AIXKxPGI9uTDAYk6oeoH2Z7ynLqEpQKbgnPH0NsEmEWvWE4knBAg8O1Em1yc8E0T
NIS13uO5tIzPmKCw2556UgCuyP7yheZwS+u8FuJ2crzILFH6KTxKdoJIlY5LIWmo
uOFy7kn94bGWezJzQ96p3Pxl0dE2OSnystouXnv5Z8hXl4G6TKOPbPgqJlFzG3hd
LjiTXqZVYM8UI++HHCcA0vTMhuJdsgg3++maHUTeSUFj8/TXRqvZgp/R8lRYrRiX
mnEW9oZlo8slXFj4OyXmwEYSgKAMFLa67CKdz8Xl8NZCFOFr5T+qauSMc6OYGzTZ
D+0Zh/HcdWV5UhB1AIm6YcEOFfTHklhIAbYA9NYgAlG4AvHGPAM47RDFJ8oFUCod
4MuToYQxb7ePjoDab25s
=vfza
-----END PGP SIGNATURE-----

--Signature=_Mon__8_Jul_2013_13_03_55_+1000_FPgru/_sR2RV_y7e--
