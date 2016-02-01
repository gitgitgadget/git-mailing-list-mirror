From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: [RFC] GPG-Signed pushes & commits: differentiating between no
 signature and an unknown key
Date: Mon, 1 Feb 2016 22:22:31 +0000
Message-ID: <robbat2-20160201T220940-187080200Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 01 23:22:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQMrl-0001fy-5s
	for gcvg-git-2@plane.gmane.org; Mon, 01 Feb 2016 23:22:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753499AbcBAWWd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2016 17:22:33 -0500
Received: from smtp.gentoo.org ([140.211.166.183]:44439 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752167AbcBAWWc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2016 17:22:32 -0500
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTPS id DCCC9340DBF
	for <git@vger.kernel.org>; Mon,  1 Feb 2016 22:22:31 +0000 (UTC)
Received: (qmail 1894 invoked by uid 10000); 1 Feb 2016 22:22:31 -0000
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285220>


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Format string %G? includes state 'N', which is described as "no
signature".

If you try to verify a commit or push for which you have no key (and you
don't automatically fetch from the keyservers [1]), then the format
string ALSO contains 'N', which is incorrect.

It should be possible to differentiate between a commit/push with NO
signature, and a commit/push signed with an unknown key.

In the case of verifying signed pushes before accepting them, this is
critical to providing a useful error message to the user. Presently, if
%G? evaluates to 'N', then none of the GIT_PUSH_CERT* env vars are set.

In the case of the signed push with the unknown key, they should remain
set.

[1] Eg, if you have an externally curated keyring and use trust-model
always.

--=20
Robin Hugh Johnson
Gentoo Linux: Developer, Infrastructure Lead, Foundation Trustee
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iKYEARECAGYFAlav2qZfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3Bl
bnBncC5maWZ0aGhvcnNlbWFuLm5ldDc1OTQwNEJFQkQ0MUY3MTIzODIzODZFRjNF
OTIyQzIyMzIzM0MyMkMACgkQPpIsIjIzwiyQKwCfTsWhBxZrGaqZN+B6hvbNwaP5
NVMAnjhPcdGdTCLMxY0PZbHX5YMv7lCu
=AMZ3
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
