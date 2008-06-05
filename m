From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [biseced bug] make info fails with master
Date: Fri, 6 Jun 2008 01:40:16 +0200
Message-ID: <20080605234016.GO29404@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TS2lcZuyPwZjLAUw"
Cc: David Kastrup <dak@gnu.org>, "John J. Franey" <jjfraney@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 06 01:41:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4P4y-0007VI-EU
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 01:41:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753918AbYFEXkT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 19:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753890AbYFEXkT
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 19:40:19 -0400
Received: from virgo.iok.hu ([193.202.89.103]:38150 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753822AbYFEXkS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 19:40:18 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 330EC1B24FF;
	Fri,  6 Jun 2008 01:40:17 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 0A6A34469F;
	Fri,  6 Jun 2008 01:22:38 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 877571190ACA; Fri,  6 Jun 2008 01:40:16 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84002>


--TS2lcZuyPwZjLAUw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

make info seem to fails here recently.

The error message is:

makeinfo --no-split gitman.texi
gitman.texi:17311: warning: @strong{Note...} produces a spurious cross-reference in Info; reword to avoid that.
/home/vmiklos/git/git/Documentation//gitman.texi:17377: Cross reference to nonexistent node `[REMOTES]' (perhaps incorrect sectioning?).
/home/vmiklos/git/git/Documentation//gitman.texi:11439: Cross reference to nonexistent node `[REMOTES]' (perhaps incorrect sectioning?).
makeinfo: Removing output file `/home/vmiklos/git/git/Documentation/gitman.info' due to errors; use --force to preserve.
make[1]: *** [gitman.info] Error 1
make[1]: Leaving directory `/home/vmiklos/git/git/Documentation'
make: *** [info] Error 2

Here is what i did:

$ cat ~/bin/gittest
#!/bin/sh

make info DOCBOOK2X_TEXI=docbook2texi
exit $?

$ git bisect start
$ git bisect bad master
$ git bisect good v1.5.6-rc0
$ git bisect run ~/bin/gittest

It says:

5812473335161e3d8e5a1e085c5894a247472bdb is first bad commit

The commit obviously touches this part of the documentation but I don't see
where the bug is.

I'm not sure, maybe this is a bug in the toolchain?

Thanks.

--TS2lcZuyPwZjLAUw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhIeWAACgkQe81tAgORUJYGywCfcyzMVhVzqJwrHlPm/Q5E3aOM
rBsAn2wgZyASahv+bb7bnInEi8C/243e
=pO5N
-----END PGP SIGNATURE-----

--TS2lcZuyPwZjLAUw--
