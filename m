From: Tanguy Ortolo <tanguy+debian@ortolo.eu>
Subject: Re: git-mergetool: wrap tools with 3 files only to use the BASE
 file instead of MERGED
Date: Wed, 10 Aug 2011 19:24:59 +0200
Message-ID: <20110810172458.GA18167@ortolo.eu>
References: <20110810160356.GA32126@ortolo.eu>
 <20110810161211.GC4076@elie.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+g7M9IMkV8truYOl"
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Charles Bailey <charles@hashpling.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 10 19:34:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrCfS-0006R6-J9
	for gcvg-git-2@lo.gmane.org; Wed, 10 Aug 2011 19:34:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753060Ab1HJReE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Aug 2011 13:34:04 -0400
Received: from dick.ortolo.eu ([78.232.240.21]:35533 "EHLO dick.ortolo.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752361Ab1HJReD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2011 13:34:03 -0400
X-Greylist: delayed 540 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Aug 2011 13:34:03 EDT
Received: by dick.ortolo.eu (Postfix, from userid 1000)
	id 649FE27E45; Wed, 10 Aug 2011 19:24:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ortolo.eu; s=default;
	t=1312997099; bh=Z4v7Yvp3PVaL3VVVfd40wNFGA0jrKoD5/Do/+mr47Ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=qcqvyjVk5fK/yFKNRqw89QghybBNyx4LyWnZLkF3RtXE0FSRhoGhq7jRoR4/cBXbG
	 9ugcqhXP59QpUjeft+j/4mKS336lZoDCq116sqyWc6cbr3+2FaxWKWVKYNgpOyVIVT
	 iDMoNoZzcHwD4dT+jU1Hbo6/Y3VL48MrozhW+02o=
Content-Disposition: inline
In-Reply-To: <20110810161211.GC4076@elie.gateway.2wire.net>
X-Number-Alpha: Douuuze
X-Number-Arabic: 12
X-Number-Roman: XII
X-Demagogie-Level: Pas trop =?utf-8?B?ZMOpY2V2YW50?=
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179074>


--+g7M9IMkV8truYOl
Content-Type: multipart/mixed; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Jonathan Nieder, 2011-08-10 11:12 UTC-0500:
> I think you forgot to include the example.

Yes, sorry. Here it is.

-- 
Tanguy Ortolo

--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename=meld-mergetool

#! /bin/sh

BASE="$1"
LOCAL="$2"
REMOTE="$3"
MERGED="$4"

MTIME_BEFORE="$(stat --format='%Y' "$BASE")"
meld "$LOCAL" "$BASE" "$REMOTE"
MTIME_AFTER="$(stat --format="%Y" "$BASE")"

if [ "$MTIME_BEFORE" != "$MTIME_AFTER" ]
then
    # The base file was modified, which means the user saved it
    cp "$BASE" "$MERGED"
else
    # The user did not save the file: merge failed
    exit 1
fi

--pf9I7BMVVzbSWLtt--

--+g7M9IMkV8truYOl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBCgAGBQJOQr7oAAoJEOryzVHFAGgZjtEP/2/4IPPKzCwdsIhG4H1x9cty
WOUgCRiuNMGT7hZIcDuw1scJehc14j7RuVwbTAAMPyFtbp3fAcJBsx3XMv8XF929
kpAYjrFp5jisvTxLvXwv8ytegfwXjI2m3cYw0xJ2+yDKv/EjwRNzk6GJ/bQHEiSH
WoFrYUsaPXtAzYxnoRbdopZ4IlXkms0/1dS3b90y5XqvmHWWT6FlX03KWpck0YEB
MTFUfpjcbBz9gE3db3ssi+1cgKqBWubJVblvawsfGMQdVc++EiBCEgvrfbZYcT6A
Bbzjyw1tUioYZbAwlYikWbzcv7s12u0bXVql+NnAmPHGIxQlQ1mCiJwoDzZW3Idm
HdixNcObnVJUrR1QDZ22ZqrWo0J+QaKPDPMG2lhjmkwSSv0c4+I4ShsAKD3i95vB
1NFAeXWKXONcTZCcfriT7WZmxySC90l6gbLOtwoylkqBJUHKXFWlbPdrRrIvNWuE
ILH+sjdsC2Pbm1g23hH6SwztunnkYwp2dM0FATTPWlF5UBlsoxaeklpBkBQ2hXDH
K/pp0Ue/zmsS0iRcH6wprLdeFZXWMzhFW/cZld0tv+HpwosDgWOAKC3aS0Sc/hyi
uG3sB8LwRt27t6LNTFIGg35zRtQ2xmV3t1T8emKpEsq2qZo6CkF4LXR8COF8qro1
im70WYdeAGJLu5FRi86I
=KEzW
-----END PGP SIGNATURE-----

--+g7M9IMkV8truYOl--
