From: Martin Waitz <tali@admingilde.org>
Subject: common URL for repository and gitweb
Date: Thu, 11 May 2006 01:00:46 +0200
Message-ID: <20060510230046.GC3228@admingilde.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8NvZYKFJsRX2Djef"
X-From: git-owner@vger.kernel.org Thu May 11 01:01:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fdxfo-00071I-Po
	for gcvg-git@gmane.org; Thu, 11 May 2006 01:00:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965060AbWEJXAt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 May 2006 19:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965062AbWEJXAt
	(ORCPT <rfc822;git-outgoing>); Wed, 10 May 2006 19:00:49 -0400
Received: from admingilde.org ([213.95.32.146]:45466 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S965060AbWEJXAs (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 May 2006 19:00:48 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1Fdxfi-0005gu-U3
	for git@vger.kernel.org; Thu, 11 May 2006 01:00:46 +0200
To: git@vger.kernel.org
Content-Disposition: inline
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19896>


--8NvZYKFJsRX2Djef
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

I hacked a little bit in gitweb so that it can get the project path
form the URI without using a ?p=3D parameter.  That is, you can now
use "http://.../cgi-bin/gitweb.cgi/path/to/project/" to show
the summary of your project.

Together with a apache configuration like below, you can give your
gitweb pages the same URL as your repositories:

	<VirtualHost www:80>
		ServerName git.hostname.org
		DocumentRoot /pub/git
		RewriteEngine on
		RewriteRule ^/(.*\.git/(.*\.html)?)?$ /usr/lib/cgi-bin/gitweb.cgi%{REQUES=
T_URI}  [L]
	</VirtualHost>

This will rewrite all URLs that go to gitweb to use the CGI, while
leaving URLs for the repository intact.

You can see an example at http://git.admingilde.org/.
The gitweb version used for that is available here, too.

As an added bonus, gitweb can now serve the "html" branch of a
repository directly using "text/html", so you can show your
documentation without needing to update a checked out version
of this branch.
For example have a look at the GIT manpages at
http://git.admingilde.org/tali/git.git/git.html

--=20
Martin Waitz

--8NvZYKFJsRX2Djef
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEYnCej/Eaxd/oD7IRAmeyAJ4/+zguP4YnvkpqCZxrvIe0hQDcbwCfcJPY
Zr2Atd6fZfGlhv4bYZhTFuw=
=jgDa
-----END PGP SIGNATURE-----

--8NvZYKFJsRX2Djef--
