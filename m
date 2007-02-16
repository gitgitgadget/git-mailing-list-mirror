From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: [PATCH] Add git-bundle - pack objects and references for disconnected
 transfer
Date: Fri, 16 Feb 2007 12:57:20 +0100
Message-ID: <45D59C20.6050708@fs.ei.tum.de>
References: <7vodnuc0me.fsf@assigned-by-dhcp.cox.net> <11716079843500-git-send-email-mdl123@verizon.net> <20070216065421.GG28894@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig920ED7DD649353B8A7C96C67"
Cc: Mark Levedahl <mdl123@verizon.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Feb 16 12:57:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HI1iW-0001ZF-66
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 12:57:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbXBPL53 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Feb 2007 06:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbXBPL53
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 06:57:29 -0500
Received: from stella.fs.ei.tum.de ([129.187.54.7]:52941 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129AbXBPL51 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Feb 2007 06:57:27 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id 3B4C8281A5;
	Fri, 16 Feb 2007 12:57:25 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id WSj1hkmojJIb; Fri, 16 Feb 2007 12:57:24 +0100 (CET)
Received: from [62.216.209.99] (ppp-62-216-209-99.dynamic.mnet-online.de [62.216.209.99])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id 43DEE2819E;
	Fri, 16 Feb 2007 12:57:24 +0100 (CET)
User-Agent: Mail/News 1.5.0.4 (X11/20060619)
In-Reply-To: <20070216065421.GG28894@spearce.org>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39909>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig920ED7DD649353B8A7C96C67
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Shawn O. Pearce wrote:
> Mark Levedahl <mdl123@verizon.net> wrote:
>> +# create the tar file, clean up
>> +tar cf "$bfile" --absolute-names --transform=3D"s,$tmp-,," \
>> +    --verbose --show-transformed-names \
>> +    "$references" "$pack"
>=20
> I'm not sure this will work on FreeBSD.  Both 5.1 and 6.1 use tar
> that does not know about --absolute-names, --transform, --verbose,
> or --show-transformed-names.

for portability, pax is the official choice :)  and it can even do path n=
ame modifications with -s.  but why again are we using tar there?  this d=
ata could easiliy be put in one mixed text/binary file, starting out with=


#!/bin/sh
echo "This is a git bundle.  Use git-unbundle to process me." >&1
exit
### DATA ###

or so

cheers
  simon

--=20
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1  +++=
      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \


--------------enig920ED7DD649353B8A7C96C67
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (DragonFly)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF1Zwjr5S+dk6z85oRAg/2AJ4q5KXE8Cp6M4d8KWrtiIXiW2q+egCffT9p
Q8VlvlOix629B4xGVla9G7U=
=5VAq
-----END PGP SIGNATURE-----

--------------enig920ED7DD649353B8A7C96C67--
