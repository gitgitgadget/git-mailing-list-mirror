From: Ivo Alxneit <ivo.alxneit@psi.ch>
Subject: failing test with cogito
Date: Fri, 14 Oct 2005 15:32:47 +0200
Organization: Paul Scherrer Institut
Message-ID: <200510141532.59897.ivo.alxneit@psi.ch>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1165172.SZk16Qi4SI";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Oct 14 15:35:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQPgQ-0000jO-LT
	for gcvg-git@gmane.org; Fri, 14 Oct 2005 15:33:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbVJNNdF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Oct 2005 09:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750745AbVJNNdF
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Oct 2005 09:33:05 -0400
Received: from psi12.psi.ch ([129.129.190.112]:48399 "HELO psi12.psi.ch")
	by vger.kernel.org with SMTP id S1750744AbVJNNdE (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Oct 2005 09:33:04 -0400
Received: from 129.129.190.113 by psi12.psi.ch (InterScan E-Mail VirusWall NT); Fri, 14 Oct 2005 15:33:02 +0200
Received: from pc446.psi.ch ([129.129.206.100]) by psi13.psi.ch with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2657.72)
	id R12JH1KK; Fri, 14 Oct 2005 15:33:01 +0200
To: git <git@vger.kernel.org>
User-Agent: KMail/1.8.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10108>

--nextPart1165172.SZk16Qi4SI
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

hi

i use

cogito
commit 19e07806612d8cea5c8e343709d567fb796e2bb3
git
commit d06b689a933f6d2130f8afdf1ac0ddb83eeb59ab

and the following tests fail for cogito (all tests pass in git)

*** t9200-merge.sh ***
* FAIL 17: merging branch2 to branch1 (automatic)
        (cd branch1 && cg-merge </dev/null)
* FAIL 18: checking for correct merged content
        (cmp branch1/brm expect)
* FAIL 23: checking for correct conflict content
        (cmp brm-cleaned-up expect)

*** t9202-merge-on-dirty.sh ***
* FAIL 19: checking if we still have our local change
        (cd branch1 && cg-status -w | grep -q "^M foo" && cmp foo foo-)
* FAIL 36: merging branch2 to branch1 (automatic)
        (cd branch1 && cg-merge </dev/null)
* FAIL 37: checking if the working copy was touched by the merge
        (cd branch1 && ! cmp brm brm-)
* FAIL 38: checking if we still have our local change
        (cd branch1 && cg-status -w | grep -q "^M bar" && cmp bar bar-)
* FAIL 47: confirming that we have no uncommitted modifications
        (cd branch1 && [ -z "$(git-diff-index -r $(cg-object-id -t))" ])
* FAIL 50: checking if the merge caused a conflict
        (cd branch1 && grep "<<<" brm)

=2D-=20
Dr. Ivo Alxneit
Laboratory for Solar Technology   phone: +41 56 310 4092
Paul Scherrer Institute             fax: +41 56 310 2688
CH-5232 Villigen                   http://solar.web.psi.ch
Switzerland                   gnupg key: 0x515E30C7

--nextPart1165172.SZk16Qi4SI
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBDT7OLAd7CE1FeMMcRAiDPAJ9MqHHrhWlAu4P0TaeYW59YlMkyuwCg0xUB
zEtIx/LAE5LaSyOcVBl8Mao=
=J4m2
-----END PGP SIGNATURE-----

--nextPart1165172.SZk16Qi4SI--
