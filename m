From: Joey Hess <id@joeyh.name>
Subject: bug: git submodule add fails when .git is a symlink
Date: Tue, 1 Mar 2016 16:42:18 -0400
Message-ID: <20160301204218.GA4083@kitenet.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 01 21:49:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aarEJ-0004I2-OX
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 21:49:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751671AbcCAUtL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 15:49:11 -0500
Received: from kitenet.net ([66.228.36.95]:60434 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751017AbcCAUtK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 15:49:10 -0500
X-Greylist: delayed 404 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Mar 2016 15:49:10 EST
X-Question: 42
Authentication-Results: kitenet.net;
	dkim=pass (1024-bit key; unprotected) header.d=joeyh.name header.i=@joeyh.name header.b=IgKVFk7C;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
	t=1456864938; bh=Wrx3MYqy+KRK2Db3bNDzhF8ymTfBxlVca6LyVPlZRNY=;
	h=Date:From:To:Subject:From;
	b=IgKVFk7CQxKptOKjrbcZ4l4y0ihDroU9899UXaroXFIucNm04Kf+6FXPD2Ko4tvBq
	 eQlmpEgI0Wn9QNFNni0V7PcjCjwUxu1nswWHaCSYxWwjMF3VBH+YLY7vmtXijAYDLl
	 L+ejIlR4pfQwdJ1YMBa1tCVVWnvf7EF4bEQgzoOU=
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Status: No, score=-94.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_PBL,RCVD_IN_SORBS_DUL,
	RDNS_NONE,SPF_SOFTFAIL,USER_IN_WHITELIST autolearn=no autolearn_force=no
	version=3.4.1
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on kite.kitenet.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288064>


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

        git init gitdir
        mkdir worktree
        cd worktree
        ln -s ../gitdir/.git .git
        git submodule add /any/git/repo sub

        fatal: Could not chdir to '../../../sub': No such file or directory

Fairly sure this is a bug..

--=20
see shy jo

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBVtX+qskQ2SIlEuPHAQK0xA/+PglkfsQJ9pDha/zHUTb2qCgTpOpgVOhH
CV4bMZxhfhuWdOKds1swY30byrfdleHyViBFUBcG93Hrt2aYAoMFbeXN7rJqXuuu
5nwD1b3xR7L/HlpuMBU8/sv5Uz8MufT6Zt4Ue8sfXtqSNz39xvopaAMRBmD/5TZZ
cRIioAXCvYClHfuw53hJW/+Q9rtP7hGxil8eNgd2pCL81NnwN5B4O59sh31sliJU
QGnO/f1QyGa14RQyzdbHWsX85K/v09BPZ7jG85LJl58Wx/0YcSo/HfJ/3RVez2PZ
jxjzj3cAB1QPlwqdSLZukTV8wfrgkAnP2l0UGFJfcgJOsDA664nwb/PkfUoxj68A
TpBVgbZlJlrJWOrPBPGq93n4HYlEXTHe1a6XQ48zqF0bqaw8woUx41SuCHoglbHM
5ZjZTTtP0ln5IQh2v48I5W0rYkEmXeewd4Pp4KTR29ZWYaR6xgBsvF9YxP/zUghI
eTsIr4v0aLJwYi9mUmh+jU2JWImBWJz8xfAqiIeyMNJ89joxT4QkPLS2vhbxJkYU
WBxqhMqFq036zMfW6OuWl4UVyeJUVXYjxr94PH0RJwvHBXFgjK8zb0uL9V9mH468
erqMjhhmsP4xUKyBsi6VmPrmc3saEbLXWG8OcqDVRDFrjLTDve8/cHwAuh/C+ZeE
84zeafbmFQ0=
=6duX
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
