From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: git-rm -n leaves .git/index.lock if not allowed to finish
Date: Fri, 19 Dec 2008 01:25:24 +0100
Message-ID: <20081219002524.GB21154@genesis.frugalware.org>
References: <87prjptfo7.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gj572EiMnwbLXET9"
Cc: git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Fri Dec 19 01:26:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDTCZ-0001Yy-85
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 01:26:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078AbYLSAZ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 19:25:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752018AbYLSAZ1
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 19:25:27 -0500
Received: from virgo.iok.hu ([212.40.97.103]:35522 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751952AbYLSAZ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 19:25:27 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 9787C580AC;
	Fri, 19 Dec 2008 01:25:25 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 6E6684465E;
	Fri, 19 Dec 2008 01:25:25 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id C2B7D11B862F; Fri, 19 Dec 2008 01:25:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <87prjptfo7.fsf@jidanni.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103517>


--gj572EiMnwbLXET9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2008 at 04:02:48AM +0800, jidanni@jidanni.org wrote:
> Bug: if git-rm -n is not allowed to write all it wants to write, it
> will leave a .git/index.lock file:
> # git-rm -n -r . 2>&1|sed q
> error: '.etckeeper' has changes staged in the index
> # git-rm -n -r . 2>&1|sed q
> fatal: unable to create '.git/index.lock': File exists

Can't reproduce:

diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index b7d46e5..1581691 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -251,4 +251,12 @@ test_expect_success 'refresh index before checking if =
it is up-to-date' '
=20
 '
=20
+test_expect_success 'test from jidanni' '
+
+	git reset --hard &&
+	git rm -n -r . 2>&1|sed q &&
+	git rm -n -r . 2>&1|sed q
+
+'
+
 test_done

passes here just fine. Yes, there are multiple files in the repo.

--gj572EiMnwbLXET9
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklK6fQACgkQe81tAgORUJaFuQCfad/y5tnuolmBiY4s9D2oHxpY
bSEAnAvBGytvOxC9rUs8yW2ELGJvUosh
=yAYR
-----END PGP SIGNATURE-----

--gj572EiMnwbLXET9--
