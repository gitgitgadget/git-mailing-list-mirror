From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: [PATCH 1/6] Fix some "printf format" warnings.
Date: Mon, 12 Mar 2007 15:03:49 +0100
Message-ID: <45F55DC5.8060702@fs.ei.tum.de>
References: <45E9BE46.1020801@ramsay1.demon.co.uk> <7v4pp29eok.fsf@assigned-by-dhcp.cox.net> <45EAFD21.6010002@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3B8F2E7624F9459F5371552E"
Cc: Junio C Hamano <junkio@cox.net>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Mon Mar 12 15:04:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQl8H-0005E3-Q4
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 15:04:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965854AbXCLOD7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 10:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965857AbXCLOD7
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 10:03:59 -0400
Received: from stella.fs.ei.tum.de ([129.187.54.7]:40412 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965854AbXCLOD6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 10:03:58 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id 3AA7028652;
	Mon, 12 Mar 2007 15:03:56 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id qQpKpsm36pHp; Mon, 12 Mar 2007 15:03:55 +0100 (CET)
Received: from [62.216.212.224] (ppp-62-216-212-224.dynamic.mnet-online.de [62.216.212.224])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id 82DA92864D;
	Mon, 12 Mar 2007 15:03:54 +0100 (CET)
User-Agent: Mail/News 1.5.0.4 (X11/20060619)
In-Reply-To: <45EAFD21.6010002@ramsay1.demon.co.uk>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42029>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3B8F2E7624F9459F5371552E
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Ramsay Jones wrote:
>>> -        printf("%s%06o %s %d\t",
>>> +        printf("%s%06lo %s %d\t",
>>>                 tag,
>>>                 ntohl(ce->ce_mode),=20
>> I think we should do this instead:
>>
>>     printf("%s%06o %s %d\t", tag, (unsigned) ntohl(ce->ce_mode), ...
> Oops, yes you are right.
> (cygwin typedef's uint32_t as unsigned long.)
>=20
> However, I would hate to add all those casts! Casts are not always
> evil, but should be avoided if possible. Having said that, I don't
> see another solution ...

shouldn't it be something like this?

printf("%s%06"PRIo32" %s %d\t", tag, ntohl(ce->ce_mode), ...)

that's the correct and allegedly portable way I guess.

cheers
  simon

--=20
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1  +++=
      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \


--------------enig3B8F2E7624F9459F5371552E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (DragonFly)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF9V3Ir5S+dk6z85oRAqxsAJ0cHiMxBP68QTG3PI5DRZlSx+9fHACff+zi
SkAvImTXrDSXBO+9Lz9Ey3Q=
=93Tj
-----END PGP SIGNATURE-----

--------------enig3B8F2E7624F9459F5371552E--
