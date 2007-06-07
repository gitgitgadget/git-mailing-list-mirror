From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH v2] Remove useless uses of cat, and replace with filename
 arguments or redirection
Date: Wed, 06 Jun 2007 19:23:49 -0700
Message-ID: <46676C35.60406@freedesktop.org>
References: <466639D0.1040306@freedesktop.org> <7vsl94sego.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA00F996FDF20351240887245"
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Jun 07 04:24:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hw7fV-0001wb-GJ
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 04:24:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759462AbXFGCYG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 22:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759696AbXFGCYG
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 22:24:06 -0400
Received: from mail5.sea5.speakeasy.net ([69.17.117.7]:41375 "EHLO
	mail5.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759462AbXFGCYF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 22:24:05 -0400
Received: (qmail 16974 invoked from network); 7 Jun 2007 02:24:03 -0000
Received: from host-226-33.pubnet.pdx.edu (HELO [131.252.226.33]) (josh@[131.252.226.33])
          (envelope-sender <josh@freedesktop.org>)
          by mail5.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <junkio@cox.net>; 7 Jun 2007 02:24:03 -0000
User-Agent: Icedove 1.5.0.10 (X11/20070329)
In-Reply-To: <7vsl94sego.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49342>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA00F996FDF20351240887245
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Junio C Hamano wrote:
> Josh Triplett <josh@freedesktop.org> writes:
>> Replace all uses of cat that do nothing other than read a single file.=
  In the
>> case of git-quilt-import, this occurs once per patch.
>>
>> Signed-off-by: Josh Triplett <josh@freedesktop.org>
>> ---
>>
>> This revised version fixes a bug caught by Stephen Rothwell: the outpu=
t of wc
>> -l changes when it has a filename on the command line.  The same bug o=
ccurred
>> in one other place as well.
>=20
> Hmph...
>=20
>> diff --git a/git-filter-branch.sh b/git-filter-branch.sh
>> index 0c8a7df..346cf3f 100644
>> --- a/git-filter-branch.sh
>> +++ b/git-filter-branch.sh
>> @@ -333,7 +333,7 @@ for commit in $unchanged; do
>>  done
>> =20
>>  git-rev-list --reverse --topo-order $srcbranch --not $unchanged >../r=
evs
>> -commits=3D$(cat ../revs | wc -l | tr -d " ")
>> +commits=3D$(wc -l ../revs | tr -d -c 0-9)
>=20
> ... and left unfixed ;-)?

No, just fixed differently. :) Note the change to the tr invocation: dele=
te
everything other than digits.

- Josh Triplett



--------------enigA00F996FDF20351240887245
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGZ2xBGJuZRtD+evsRAkaXAKCmFAga96/A8/E0s0mb0+RLbAzyCgCcCHF7
ARDeZPChqqrF/IAp7qeyKpQ=
=fxA6
-----END PGP SIGNATURE-----

--------------enigA00F996FDF20351240887245--
