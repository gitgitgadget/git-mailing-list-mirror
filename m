From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] gitk: use mktemp -d to avoid predictable temporary
 directories
Date: Sun, 15 Jun 2014 16:32:27 +0000
Message-ID: <20140615163227.GE368384@vauxhall.crustytoothpaste.net>
References: <1402695828-91537-1-git-send-email-davvid@gmail.com>
 <87k38ir4p0.fsf@red.patthoyts.tk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/QKKmeG/X/bPShih"
Cc: David Aguilar <davvid@gmail.com>,
	Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sun Jun 15 18:32:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwDMK-0004DO-96
	for gcvg-git-2@plane.gmane.org; Sun, 15 Jun 2014 18:32:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486AbaFOQcf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2014 12:32:35 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:48343 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751258AbaFOQce (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Jun 2014 12:32:34 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:410d:6806:9865:2e4b])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 3C4B52808E;
	Sun, 15 Jun 2014 16:32:31 +0000 (UTC)
Mail-Followup-To: Pat Thoyts <patthoyts@users.sourceforge.net>,
	David Aguilar <davvid@gmail.com>, Paul Mackerras <paulus@samba.org>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <87k38ir4p0.fsf@red.patthoyts.tk>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.15-rc5-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 () BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251680>


--/QKKmeG/X/bPShih
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 15, 2014 at 08:51:23AM +0100, Pat Thoyts wrote:
> David Aguilar <davvid@gmail.com> writes:
> >--- a/gitk
> >+++ b/gitk
> >@@ -3502,7 +3502,8 @@ proc gitknewtmpdir {} {
> > 	} else {
> > 	    set tmpdir $gitdir
> > 	}
> >-	set gitktmpdir [file join $tmpdir [format ".gitk-tmp.%s" [pid]]]
> >+	set gitktmpformat [file join $tmpdir ".gitk-tmp.XXXXXX"]
> >+	set gitktmpdir [exec mktemp -d $gitktmpformat]
> > 	if {[catch {file mkdir $gitktmpdir} err]} {
> > 	    error_popup "[mc "Error creating temporary directory %s:" $gitktmp=
dir] $err"
> > 	    unset gitktmpdir
>=20
> This is a problem on Windows where we will not have mktemp. In Tcl 8.6
> the file command acquired a "file tempfile" command to help with this
> kind of issue (https://www.tcl.tk/man/tcl8.6/TclCmd/file.htm#M39) but
> for older versions we should probably stick with the existing pattern at
> least on Windows.

The existing pattern is a security bug on Unix systems. MITRE (CWE-377)
tells me that it is a vulnerability on Windows as well, so you'd
probably want to come up with a better solution than the existing
pattern.

You also probably want to request a CVE for this, which the Red Hat and
Debian security teams can do for you if you like.  Distributions will
likely want to issue security advisories for this.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--/QKKmeG/X/bPShih
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTncqaAAoJEL9TXYEfUvaLs4AP/jLUtf5MVLHg/gPASO3KSH1V
ONqE8m9wcoq57ZvSeqrxpdHk6zJdIr4+WrahhOF0qSvsaizm+jAf8WbUnmzPdpX6
HNQoGpRw81uO3pZFHy5dscLy9vIa4MtmVHSF/dfis4t+SOmvmMKaY1virdVTC0w/
s63rMdW972TfMhfvJUYOOO5SOF6bPCZQ/oKItUKOB/naaEaB0aOkPvZNQmE2IFd9
yVZtDtLXiCNsKDTI3OJoZJpKrC1khQVBQUwcFqaW6cawBbRdoiPK6q5hOX1yeDlt
CTgGWdbdA1ijOwefofI+QlCubj6HPAXtBzEbw16lqOTlKTPTfWFrSZtiHcV7rJIw
CS2o53sjDlqmc16gdeOKDVG4kweWjjE8DJn2DBeZ7b8FPDXLg92JmhljCq9iUkth
Pkbz2WPk7BOg1y+OrrEctLo0moA+bslBvsjzS1HvPYcchvbb51ZD4uO6YBJFgKfN
5ttGxcF3yXIx0l7dUMPquZeB58wf0rjKjVvfkhBSB64csTHfcnYiVHw7eDMfJhlR
9br4hoVbBo7IAEQJyawUxB7WJsCXjvp1ttSH6vyO7QkSbV9l9yZXq3Lrn3aZk1j5
JIK0qLtmk+R2XkgRirsPR5CsGE/bdzholxa6W5qiB/LVvTJDKxmee5Ref/aXNhJh
TNuEvmao4YWtn95/Bk8I
=aZ2U
-----END PGP SIGNATURE-----

--/QKKmeG/X/bPShih--
