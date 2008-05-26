From: Luciano Rocha <luciano@eurotux.com>
Subject: rev-parse doesn't take pwd into consideration
Date: Mon, 26 May 2008 20:58:12 +0100
Message-ID: <20080526195812.GA23396@bit.office.eurotux.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 26 21:59:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0iqd-0005DS-LW
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 21:59:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754174AbYEZT6T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2008 15:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754452AbYEZT6T
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 15:58:19 -0400
Received: from os.eurotux.com ([216.75.63.6]:44798 "EHLO os.eurotux.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753714AbYEZT6T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 15:58:19 -0400
Received: (qmail 24462 invoked from network); 26 May 2008 19:58:17 -0000
Received: from adsl.eurotux.com (HELO bit.office.eurotux.com) (luciano@213.205.93.24)
  by os.eurotux.com with AES256-SHA encrypted SMTP; 26 May 2008 19:58:17 -0000
Content-Disposition: inline
User-Agent: Mutt/1.5.14 (2007-03-31)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82950>


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hello,

I was frustrated for some minutes trying to get the HEAD version of a
file, as is in the documentation. Using git's source as an example:
git/Documentation$ git show HEAD:docbook.xsl
fatal: ambiguous argument 'HEAD:docbook.xsl': unknown revision or path
not in the working tree.
Use '--' to separate paths from revisions

<hmmm>

$ git show HEAD -- docbook.xsl
<nil>
$

Seeing in the documentation that the parsing was made by git-rev-parse,
I tried running git-rev-parse directly, ending with the same error.

I tried with the full path, just in case, but it didn't work also
($PWD/docbook.xsl).

Until finally I tried the absolute path as git is concerned, and it
worked.

It works anywhere:
git$ git show HEAD:Documentation/docbook.xsl
<contents>
git/Documentation$ git show HEAD:Documentation/docbook.xsl
<contents>
=2E..

Is it difficult to make rev-parse accept relative path specifications?

--=20
Luciano Rocha <luciano@eurotux.com>
Eurotux Inform=E1tica, S.A. <http://www.eurotux.com/>

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkg7FlQACgkQinSul6a7oB8ZAQCffh3Bz1grKhlko87BsRIYis9O
mjoAoJT8Wi3skXNMYTKavPDAr8lTU3MV
=P/8c
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
