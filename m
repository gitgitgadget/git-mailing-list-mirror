From: Miklos Vajna <vmiklos@frugalware.org>
Subject: cvsimport: trying to convert freebsd cvs to git
Date: Sat, 22 Dec 2007 18:18:01 +0100
Message-ID: <20071222171801.GE15286@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T7mxYSe680VjQnyC"
Cc: Stefan Sperling <stsp@stsp.name>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 22 18:18:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J67zf-0006kj-8C
	for gcvg-git-2@gmane.org; Sat, 22 Dec 2007 18:18:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752134AbXLVRSG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2007 12:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752129AbXLVRSF
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Dec 2007 12:18:05 -0500
Received: from virgo.iok.hu ([193.202.89.103]:19870 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751919AbXLVRSE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2007 12:18:04 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 5DC8E1B2504;
	Sat, 22 Dec 2007 18:18:02 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 30E324465C;
	Sat, 22 Dec 2007 18:16:41 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id D09381190215; Sat, 22 Dec 2007 18:18:01 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69145>


--T7mxYSe680VjQnyC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

hi,

recently Stefan reported that he tried to convert the freebsd cvs' src
module to git and he failed. i tried to help him, but i failed, too.
here are my efforts:

he made the cvs available on a (relatively) fast rsync mirror at:

rsync://ftp.spline.de/FreeBSD-CVS

(so you don't have to use cvsup if it's a problem for you)

so after mirroring it, i had:

$ ls cvs
CVSROOT/  CVSROOT-ports/  CVSROOT-src/  ports/  src/

then i tried:

$ time git cvsimport -d `pwd`/cvs -C src.git src
Initialized empty Git repository in /home/vmiklos/git/freebsd/src.git/.git/
malformed revision
fatal: refs/heads/origin: not a valid SHA1
fatal: master: not a valid SHA1
warning: You appear to be on a branch yet to be born.
warning: Forcing checkout of HEAD.
fatal: just how do you expect me to merge 0 trees?
checkout failed: 256

real    15m11.529s
user    0m46.212s
sys     0m6.680s

my questions:

1) does cvsimport supports the case when the source if on the local
filesystem, and not in not on a cvs server?

first i wanted to make sure that cvsimport itself works properly here:

$ git cvsimport -d :pserver:anonymous@tcpflow.cvs.sourceforge.net:/cvsroot/tcpflow -C tcpflow tcpflow

and it converted this small repo fine

2) if it supports, then i think the real error message is 'malformed
revision'. what is the proper way to see where is that revision?

of course if cvsimport is not the right tool to incrementally convert
such a big repo, then i would be interested in other advices, too.

thanks,
- VMiklos

--T7mxYSe680VjQnyC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHbUbJe81tAgORUJYRAnDCAJ48cYSQQcv33H4DDLfXOF8eSjKDrACgo/JB
1/whk8ektNa0UhKnNXa3CZk=
=wq+C
-----END PGP SIGNATURE-----

--T7mxYSe680VjQnyC--
