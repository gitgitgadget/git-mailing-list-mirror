From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: [PATCH] Add git-bundle - pack objects and references for disconnected
 transfer
Date: Fri, 16 Feb 2007 14:25:20 +0100
Message-ID: <45D5B0C0.3040303@fs.ei.tum.de>
References: <7238711.2657861171629916957.JavaMail.root@vms064.mailsrvcs.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigBCCA45C98298B1D4639E8B34"
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Mark Levedahl <mdl123@verizon.net>
X-From: git-owner@vger.kernel.org Fri Feb 16 14:25:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HI35l-0001jh-Su
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 14:25:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbXBPNZ2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Feb 2007 08:25:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932310AbXBPNZ1
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 08:25:27 -0500
Received: from stella.fs.ei.tum.de ([129.187.54.7]:45167 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932212AbXBPNZ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Feb 2007 08:25:27 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id 446A0281A5;
	Fri, 16 Feb 2007 14:25:25 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id UqXYYsIDKfuN; Fri, 16 Feb 2007 14:25:24 +0100 (CET)
Received: from [62.216.209.99] (ppp-62-216-209-99.dynamic.mnet-online.de [62.216.209.99])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id 7A5742819E;
	Fri, 16 Feb 2007 14:25:24 +0100 (CET)
User-Agent: Mail/News 1.5.0.4 (X11/20060619)
In-Reply-To: <7238711.2657861171629916957.JavaMail.root@vms064.mailsrvcs.net>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39912>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBCCA45C98298B1D4639E8B34
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Mark Levedahl wrote:
>> #!/bin/sh
>> echo "This is a git bundle.  Use git-unbundle to process me." >&1
>> exit
>> ### DATA ###
>>
>> or so
>>
>> cheers
>>  simon
>=20
> ... I *tried* that, and it fails under Cygwin. Apparently cygwin's
> bash (or something) mangles data in the pipe (99% certain it will
> turn out to be a latent crlf issue)...

you can try something like:

sed -e '1,/^##DATA##$/d' "$bundle" | git-index-pack --stdin

and see if it works better.  no need to stream the bundle completely, it =
can be read several times.

cheers
  simon

--=20
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1  +++=
      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \


--------------enigBCCA45C98298B1D4639E8B34
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (DragonFly)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF1bDDr5S+dk6z85oRAkHYAJ455DRClvpKQJm3Y0ImasQwyKMjYQCeJVeH
IJcq20I7XCXWC/tXpAmFGZU=
=zTRC
-----END PGP SIGNATURE-----

--------------enigBCCA45C98298B1D4639E8B34--
