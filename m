From: Miklos Vajna <vmiklos@frugalware.org>
Subject: git fast-export problem with tags
Date: Sat, 22 Nov 2008 03:29:13 +0100
Message-ID: <20081122022913.GC4746@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Nov 22 03:30:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3iGX-0006sx-6j
	for gcvg-git-2@gmane.org; Sat, 22 Nov 2008 03:30:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754019AbYKVC3R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2008 21:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753392AbYKVC3R
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Nov 2008 21:29:17 -0500
Received: from virgo.iok.hu ([193.202.89.103]:55402 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752688AbYKVC3Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2008 21:29:16 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id DDDC45808C;
	Sat, 22 Nov 2008 03:29:14 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 01B0C44698;
	Sat, 22 Nov 2008 03:29:16 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 500BE119019E; Sat, 22 Nov 2008 03:29:14 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101550>


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Johannes,

It seems in some cases the tag messages of annotated tags are not
exported. Here is a reproducer:

git init
echo a > file
git add file
git commit -m i
git tag -a -m "one dot zero" 1.0

Now the output of 'git fast-export --all' does not contain the "one dot
zero" message.

But if you go a bit futher and make master point to a commit different
to the tag:

echo b > file
git add file
git commit -m b

then the output of 'git fast-export --all' clearly has it.

Is this a bug or have I missed something? ;-)

Thanks.

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkknbnkACgkQe81tAgORUJaHyACdEekYjWnw9+JHsQTMCyxHkg9I
ND4AniIixtRZP8nsbVmeCoB2jbjwBPWW
=g755
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
