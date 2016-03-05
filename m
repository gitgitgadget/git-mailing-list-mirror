From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Making git apply always work relative to current directory
Date: Sat, 5 Mar 2016 18:11:25 +0000
Message-ID: <20160305181125.GA48536@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 05 19:11:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acGg9-0006s9-Lb
	for gcvg-git-2@plane.gmane.org; Sat, 05 Mar 2016 19:11:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbcCESLg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Mar 2016 13:11:36 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49716 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750709AbcCESLe (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Mar 2016 13:11:34 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:f2de:f1ff:feb8:36fd])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 1AA63282A1
	for <git@vger.kernel.org>; Sat,  5 Mar 2016 18:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1457201491;
	bh=gxrrfgW+7sgRpHL93cXoynyBE+Dkh5pw5P8BrRstfmk=;
	h=Date:From:To:Subject:From;
	b=sPNow/ZyecpNlsq/Kst9JxZvHkGGDykbUy3JEWbMPAIh03ohAFy2PSdXdq9iCGTlT
	 w/kqujfcstiZNmj3A+iyW9kwPj2Oj8LWxclqQfM6OTpyiUO56zw83je6zDgjoiHSYm
	 a1J0ylHecwadgOcwrNVjlRzzjFHFMK5ldsKB3NdBsuZCaZ8WsEuqZP6Rrd0T6hA8bM
	 KVFugF2wn+1+yyjmqWtvLXON7mqjB3/Oady6F2JmNDyJABEylhcfQ4Q/xwWXfw1hwB
	 iibPlwB0FD3JmH+L3OIyBLPps3j4gs1yuOeXIQUxEK7iVSeYY1qjxHzgFUxde0RRFW
	 2Fvjhb7UIivm8wNoYd2y17pad9YAsjxWNDaDZ3DlxSvaP+wHxy3J/OM3vYFPdj7w1f
	 3JZeHDelcY5x/sYdTR1Dedq31w+UA6NtjeVN9pxRo1ShhkeBqb9QgyghvE8yjfPvv7
	 WxI7zNqdIv7akqyMZVV2OM4B8EhmNj7yQ7nGMEmsEH58CV87/US
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
Content-Disposition: inline
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.4.0-1-amd64)
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Score: -0.262 BAYES_00,RDNS_NONE,T_DKIM_INVALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288316>


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I have a piece of software which must run out of a given directory.  In
development, this is a git repository, and in production it is not.  I
also have an ignored subdirectory where I would like to use git apply to
apply patches (in both environments).

If I run git apply --no-index --verbose <patch>, it succeeds in both
cases, but when I'm in the git repository, it *silently does nothing*.
I have to provide a --directory argument in order for it to function
underneath the repository, but of course that doesn't work when the
directory isn't within a repository.  --unsafe-paths did not seem to
make a difference.  I'm using Git 2.7.2.

Is there a way to tell git apply that it should apply relative to the
current working directory, no matter what?  I'm happy to send a patch to
either the documentation or git apply if necessary.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.11 (GNU/Linux)

iQIcBAEBCgAGBQJW2yFNAAoJEL9TXYEfUvaL0UQP/iuxwYdwiYC/eQFf5KqDezPm
V9g7XM1rgG/p8QqTpWZVYzRBLZrm7sW4M0sOIrK4feOhPI2P7jLA2kR2yfmTl5Dz
ZemLKXVXUMYAW3X9yVWM/G2ViYTD9btadB4r9ZIDuf5yBRx6pUql1IAZBRhrfORP
EqGrFXA7mJQAahpIADSMIjuVoQA2V/4x37uS2QmxmJKTmg8/8B//cZQ+C20HIoqp
DqQ8KlBoYUtxpDnJ1MNIxtx0XJv7hVaNUTzMGKjWHFq+FgXEnC5euu+7B/peBNMJ
lOoJfhKqFALUdPG4ftSjky/APykaLffjLq9yxRvpbf9WXdVFfVDPe4AvXvPJ7Ct/
PEV0HeJ72/mF/S+ee8ONhLzT39MyB3CKkWVBH89RY7DQuRmnUDlM7H1jnyRkpsJ3
zS0x5PUMZl0vvIfq7fKXij/RwaBNL9LEzMGx5UpezOjQjlkpLmEr8NSsyaMetGcx
grUiYgwOCpKk7BE5c9NCqCuQKya/VqZp8o+X1VRL86bHopRHFLIXJ5KpYOYvMwOo
A2jOPad5jT98qZDa2TCRyURFS4bn8IiqFA07Rc1IjVRsOXiQG5VLqNbI/hDF+WrP
4/9hW4lNhd+/eda4yZr2Lv0HSrASt0xCTm4ydWpSc5+S842nW94AJ/g4S0FjhGFJ
Rj+RbTKLTIzGYYy0d6vO
=svJy
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
