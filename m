From: Roger Leigh <rleigh@codelibre.net>
Subject: git and mtime
Date: Wed, 19 Nov 2008 11:37:52 +0000
Message-ID: <20081119113752.GA13611@ravenclaw.codelibre.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 19 13:10:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2lsY-0003Bx-Eq
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 13:09:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752408AbYKSMIe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2008 07:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752407AbYKSMIe
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Nov 2008 07:08:34 -0500
Received: from nagini.codelibre.net ([80.68.93.164]:36332 "EHLO
	nagini.codelibre.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752394AbYKSMId (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2008 07:08:33 -0500
X-Greylist: delayed 682 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Nov 2008 07:08:32 EST
Received: by nagini.codelibre.net (Postfix, from userid 1000)
	id 7BD111880D; Wed, 19 Nov 2008 11:57:08 +0000 (GMT)
Content-Disposition: inline
X-GPG-Key: 0x25BFB848
X-Debian: testing/unstable
X-OS-Uptime: 11:10:44 up 6 min,  1 user,  load average: 0.28, 0.16, 0.09
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101328>


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi folks,

I'm using git to store some generated files, as well as their sources.
(This is in the context of Debian package development, where entire
upstream release tarballs are injected into an upstream branch, with
Debian releases merging the upstream branch, and adding the Debian
packaging files.)

The upstream release tarballs contains files such as
- yacc/lex code, and the corresponding generated sources
- Docbook/XML code, and corresponding HTML/PDF documentation

These are provided by upstream so that end users don't need these tools
installed (particularly docbook, since the toolchain is so flaky on
different systems).  However, the fact that git isn't storing the
mtime of the files confuses make, so it then tries to regenerate these
(already up-to-date) files, and fails in the process since the tools
aren't available.

Would it be possible for git to store the mtime of files in the tree?

This would make it possible to do this type of work in git, since it's
currently a bit random as to whether it works or not.  This only
started when I upgraded to an amd64 architecture from powerpc32,
I guess it's maybe using high-resolution timestamps.


Thanks,
Roger


P.S. The repo I'm working on here is at
     git://git.debian.org/git/collab-maint/gutenprint.git

--=20
  .''`.  Roger Leigh
 : :' :  Debian GNU/Linux             http://people.debian.org/~rleigh/
 `. `'   Printing on GNU/Linux?       http://gutenprint.sourceforge.net/
   `-    GPG Public Key: 0x25BFB848   Please GPG sign your mail.

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkj+pAACgkQVcFcaSW/uEjJkwCg2HDAmJ+cnWyuy4TtZKaWlinh
1QMAmgL6ZYLQ/a3ygOzBoIo9aLDj2YOZ
=8EZK
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
