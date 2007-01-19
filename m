From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: git ls-files -o under .git/ prints all repository files
Date: Fri, 19 Jan 2007 09:07:02 +0100
Message-ID: <45B07C26.4000008@fs.ei.tum.de>
References: <87r6trsu7n.wl@mail2.atmark-techno.com>	 <7vwt3jjywc.fsf@assigned-by-dhcp.cox.net>	 <45B07875.9030506@fs.ei.tum.de> <81b0412b0701182357l3a6d44fel58da50c7895fb6b4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig66C67C23C1FCD58E1544D400"
Cc: Junio C Hamano <junkio@cox.net>,
	Yasushi SHOJI <yashi@atmark-techno.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 19 09:07:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7omH-0005SJ-La
	for gcvg-git@gmane.org; Fri, 19 Jan 2007 09:07:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964930AbXASIHK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 03:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964933AbXASIHJ
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 03:07:09 -0500
Received: from stella.fs.ei.tum.de ([129.187.54.7]:59138 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964930AbXASIHI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 03:07:08 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id 4359D28178;
	Fri, 19 Jan 2007 09:07:06 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id mB2wSxJjuqQU; Fri, 19 Jan 2007 09:07:06 +0100 (CET)
Received: from [192.168.10.124] (ppp-62-216-208-62.dynamic.mnet-online.de [62.216.208.62])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id B4B4B28156;
	Fri, 19 Jan 2007 09:07:05 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; DragonFly pc32; en-US; rv:1.8.0.8) Gecko/20061212 Thunderbird/1.5.0.8 Mnenhy/0.7.4.666
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0701182357l3a6d44fel58da50c7895fb6b4@mail.gmail.com>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37161>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig66C67C23C1FCD58E1544D400
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Alex Riesen wrote:
>> I guess you are not serious.  I wonder, why does git-ls-files ever
>> list files under .git?  I'd just say:  fail if you want to list $GIT_D=
IR.
>=20
> Not list. Clean. What's wrong with listing them?

i would claim .git to be off limits and unrelated to the working dir (fil=
e-wise).  if you want to list files there, do a find . or so.  After all =
you wouldn't expect cd /usr && git-ls-files -o work there unless you have=
 a /.git or /usr/.git, right?

>>  Maybe other tools should do so as well.
>>
>> % cd .hg && hg status -A .
>> abort: path contains illegal component: .hg
>>
>> I think this is a sensible thing to do.
>=20
> No, it isn't. It is not unlikely to have repo in repo
> (and some people already have them).
> Mercurial is wrong here.

what do you mean with repo-in-repo?  something like .git/.git?  My sugges=
tion does not break this:

% mkdir foo && cd foo && git init
% cd .git && git init
% git ls-files -o
HEAD
config
description
hooks/applypatch-msg
hooks/commit-msg
hooks/post-commit
hooks/post-update
hooks/pre-applypatch
hooks/pre-commit
hooks/pre-rebase
hooks/update
info/exclude
% git ls-files -o ..
fatal: '..' is outside repository

Here the repo root is "foo/.git" and not "foo".

So my suggestion still stands:  .git is off limits.

cheers
  simon

--=20
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1  +++=
      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \


--------------enig66C67C23C1FCD58E1544D400
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (DragonFly)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFsHwpr5S+dk6z85oRAkJXAJsHNNbXdvaLV/ZjAj2W4RGEuJ5nOwCgqobX
sdjQhlybI5ipxkF0LWN//Ro=
=q3BQ
-----END PGP SIGNATURE-----

--------------enig66C67C23C1FCD58E1544D400--
