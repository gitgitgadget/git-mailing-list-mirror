From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Large-scale configuration backup with GIT?
Date: Sun, 2 Sep 2007 22:17:24 +0200
Message-ID: <20070902201724.GB10567@lug-owl.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3uo+9/B/ebqu+fSQ"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 02 22:17:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRvsy-0006Zg-2U
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 22:17:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750874AbXIBUR0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 16:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbXIBUR0
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 16:17:26 -0400
Received: from lug-owl.de ([195.71.106.12]:44581 "EHLO lug-owl.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750719AbXIBURZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 16:17:25 -0400
Received: by lug-owl.de (Postfix, from userid 1001)
	id 5694AF0079; Sun,  2 Sep 2007 22:17:24 +0200 (CEST)
Content-Disposition: inline
X-Operating-System: Linux mail 2.6.18-5-686 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57385>


--3uo+9/B/ebqu+fSQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I'm just thinking about storing our whole company's configuration into
GIT, because I'm all too used to it. That is, there are configuration
dumps of n*10000 routers and switches, as well as "regular"
configuration files on server machines (mostly Linux and Solaris.)
While probably all of the server machines could run GIT natively, we
already have some scripts to dump all router's/switch's configuration
to a Solaris system, so we could it import/commit from there. There
might be a small number of Windows machines, but I guess these will be
done by exporting the interesting stuff to Linux/Solaris machines...

I initially thought about running a git-init-db on each machine's root
directory and adding all interesting files, but that might hurt GIT's
usage for single software projects on those machines, no?
Additionally, a lot of configuration files will be common, or at least
very similar. A lot of repos would probably result in worse
compression when starting with packs.

Another idea would be to regularly copy all interesting files into a
staging directory (with the same directory structure as the root
filesystem) and git-init-db'ing this staging directory, to not have a
machine-wide .git/ in the root directory.

In both cases, I'd be left with a good number of GIT repos, which
should probably be bound together with the GIT subproject functions.
However, one really interesting thing would be to be able to get the
diff of two machine's configuration files. (Think of machines that
*should* be all identical!)  For this, it probably would be easier to
not put each machine into its own GIT repo, but to use a single one
with a zillion branches, one for each machine.

Did anybody already try to do something like that and can help me with
some real-life experience on that topic?

MfG, JBG

--=20
      Jan-Benedict Glaw      jbglaw@lug-owl.de              +49-172-7608481
Signature of:                http://catb.org/~esr/faqs/smart-questions.html
the second  :

--3uo+9/B/ebqu+fSQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD4DBQFG2xpUHb1edYOZ4bsRAohfAJ0VCRU/kkyVIVs7UrR1YDQ+JASsEACXfW2D
EelqgHeu7ZBYBtYuYSml0g==
=DsFs
-----END PGP SIGNATURE-----

--3uo+9/B/ebqu+fSQ--
