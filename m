From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: [PATCH 3/3] prevent HEAD reflog to be interpreted as current
 branch reflog
Date: Fri, 02 Feb 2007 17:35:26 +0100
Message-ID: <45C3684E.7090402@fs.ei.tum.de>
References: <Pine.LNX.4.64.0702011231300.3021@xanadu.home> <200702021302.10567.andyparkins@gmail.com> <Pine.LNX.4.64.0702020955540.3021@xanadu.home> <200702021611.06029.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6C12478D8801ED1F63E00CCA"
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 02 17:36:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HD1OE-0007Ll-Ki
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 17:35:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945967AbXBBQfh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 11:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945980AbXBBQfh
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 11:35:37 -0500
Received: from stella.fs.ei.tum.de ([129.187.54.7]:46664 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945967AbXBBQfc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 11:35:32 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id 0C7F22828F;
	Fri,  2 Feb 2007 17:35:31 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id dtD3tmAzr1aD; Fri,  2 Feb 2007 17:35:30 +0100 (CET)
Received: from [192.168.10.124] (ppp-62-216-203-79.dynamic.mnet-online.de [62.216.203.79])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id 7B27928285;
	Fri,  2 Feb 2007 17:35:30 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; DragonFly pc32; en-US; rv:1.8.0.8) Gecko/20061212 Thunderbird/1.5.0.8 Mnenhy/0.7.4.666
In-Reply-To: <200702021611.06029.andyparkins@gmail.com>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38513>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6C12478D8801ED1F63E00CCA
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Andy Parkins wrote:
> Just because the virtual branch is stored in HEAD, I think it is=20
> dangerous to thing of HEAD as being the thing that is logged - it is th=
is=20
> virtual branch that should be logged because that branch is always ther=
e and=20
> can be tracked through time as a discrete entity.  If you track HEAD it=
self,=20
> then sometimes it will hold the same as a branch reflog, sometimes it w=
ill=20
> hold unique data.

hopefully, yes!  Having to know "uhm, that time I was detached, oh, no, t=
hat was a ref" is the variable.  The reflog we are talking about, no matt=
er how it might be called or how its symbol is should track where my inde=
x wanders.  which is called HEAD, I think (sorry, I'm quite new to git).

So, to make it clear, when I do this:

git checkout master
git checkout build
git checkout master~1
git checkout dbcca21
git checkout master
hack && git commit -a

then i expect the "reflog to be named" to follow *exactly these steps:

master, build, master~1, dbcca21..., master, newmaster

and _not_ just

master~1m, dbcca21...

cheers
  simon

--=20
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1  +++=
      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \


--------------enig6C12478D8801ED1F63E00CCA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (DragonFly)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFw2hRr5S+dk6z85oRAkagAJ99m94j/1wAGmQhaZZpXwJMRkv/0ACfZi4X
stu2PaV+WP1wSFNmCBMjZhQ=
=gmzH
-----END PGP SIGNATURE-----

--------------enig6C12478D8801ED1F63E00CCA--
