From: Matthijs Kooijman <matthijs@stdin.nl>
Subject: Re: Versioning configuration files on a server: fatal: Unable to
	create '//etc/.git/index.lock': No such file or directory
Date: Thu, 18 Nov 2010 18:17:52 +0100
Message-ID: <20101118171751.GG22067@login.drsnuggles.stderr.nl>
References: <AANLkTi=UPWTeZP9uF+FGtsSs7wH3AmwdeLtsPJQnKvez@mail.gmail.com> <20101117112042.GX22067@login.drsnuggles.stderr.nl> <20101118155211.GE22067@login.drsnuggles.stderr.nl> <AANLkTi=mf_1HaJ0qZJ4nG1=zti9CJdTZHAfhLayR4FRS@mail.gmail.com> <AANLkTin6vir9UT9c4-9ArNvFHNdHiDiXMtXKRUMoExho@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pOWThA+BJwTvKdTr"
Cc: Albert Strasheim <fullung@gmail.com>, git@vger.kernel.org,
	Clemens Buchacher <drizzd@aon.at>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 18 18:18:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJ87T-0007L4-EY
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 18:17:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932530Ab0KRRRz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Nov 2010 12:17:55 -0500
Received: from drsnuggles.stderr.nl ([94.142.244.14]:47400 "EHLO
	drsnuggles.stderr.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932519Ab0KRRRy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Nov 2010 12:17:54 -0500
Received: from login.drsnuggles.stderr.nl ([10.42.0.9] ident=mail)
	by mail.drsnuggles.stderr.nl with smtp (Exim 4.69)
	(envelope-from <matthijs@stdin.nl>)
	id 1PJ87M-0008GC-7n; Thu, 18 Nov 2010 18:17:53 +0100
Received: (nullmailer pid 31753 invoked by uid 1000);
	Thu, 18 Nov 2010 17:17:52 -0000
Mail-Followup-To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Albert Strasheim <fullung@gmail.com>, git@vger.kernel.org,
	Clemens Buchacher <drizzd@aon.at>
Content-Disposition: inline
In-Reply-To: <AANLkTin6vir9UT9c4-9ArNvFHNdHiDiXMtXKRUMoExho@mail.gmail.com>
X-PGP-Fingerprint: 7F6A 9F44 2820 18E2 18DE  24AA CF49 D0E6 8A2F AFBC
X-PGP-Key: http://www.stderr.nl/static/files/gpg_pubkey.asc
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Score: -2.6 (--)
X-Spam-Report: Spamchecked on "mail.drsnuggles.stderr.nl"
	pts  rule name              description
	---- ---------------------- -------------------------------------------
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	0.0 AWL                    AWL: From: address is in the auto white-list
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161687>


--pOWThA+BJwTvKdTr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Nguyen,

> I think 490544b (get_cwd_relative(): do not misinterpret suffix as
> subdirectory - 2010-05-22) causes it. Haven't fully understood what's
> going on in that function though :P
Seems you're right. I just reverted this commit and the problem seems to
go away.

In case you're investigation, here's the relevant call to
get_cwd_relative in this case is:

Breakpoint 3, get_relative_cwd (buffer=0x756e20 "", size=4096, dir=0x764040 "/") at dir.c:944

Not sure what the return value is, that one got optimized out.

Gr.

Matthijs

--pOWThA+BJwTvKdTr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkzlX78ACgkQz0nQ5oovr7w1WQCgm+9kYVonY4cOEQx4zg1HPfga
2CkAn1As4OcySyBSc4ciGw0MPJWIcTnH
=9rbH
-----END PGP SIGNATURE-----

--pOWThA+BJwTvKdTr--
