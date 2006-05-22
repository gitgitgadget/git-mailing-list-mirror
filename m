From: Donnie Berkholz <spyderous@gentoo.org>
Subject: Re: irc usage..
Date: Mon, 22 May 2006 12:09:26 -0700
Message-ID: <44720C66.6040304@gentoo.org>
References: <Pine.LNX.4.64.0605201016090.10823@g5.osdl.org>	 <446F95A2.6040909@gentoo.org>	 <Pine.LNX.4.64.0605201543260.3649@g5.osdl.org>	 <446FA262.7080900@gentoo.org>	 <Pine.LNX.4.64.0605211209080.3649@g5.osdl.org>	 <Pine.LNX.4.64.0605212053590.3697@g5.osdl.org>	 <44713BE4.9040505@gentoo.org>	 <Pine.LNX.4.64.0605212132570.3697@g5.osdl.org>	 <46a038f90605220042v369e9ff5o3dc7841472171d02@mail.gmail.com>	 <Pine.LNX.4.64.0605220203200.3697@g5.osdl.org> <46a038f90605220554y569c11b9p24027772bd2ee79a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigBF990DC237DA9EBD2D99C1E9"
Cc: Linus Torvalds <torvalds@osdl.org>,
	Yann Dirson <ydirson@altern.org>,
	Git Mailing List <git@vger.kernel.org>,
	Matthias Urlichs <smurf@smurf.noris.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 22 21:09:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiFmb-0005LY-Lw
	for gcvg-git@gmane.org; Mon, 22 May 2006 21:09:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbWEVTJg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 15:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751070AbWEVTJg
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 15:09:36 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:4236 "EHLO smtp.gentoo.org")
	by vger.kernel.org with ESMTP id S1750986AbWEVTJf (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 May 2006 15:09:35 -0400
Received: from localhost (localhost [127.0.0.1])
	by smtp.gentoo.org (Postfix) with ESMTP id 9E9AB643FC;
	Mon, 22 May 2006 19:09:34 +0000 (UTC)
Received: from smtp.gentoo.org ([127.0.0.1])
 by localhost (smtp.gentoo.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 01354-06; Mon, 22 May 2006 19:09:32 +0000 (UTC)
Received: from [192.168.1.105] (c-67-171-150-177.hsd1.or.comcast.net [67.171.150.177])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTP id 6776D64390;
	Mon, 22 May 2006 19:09:32 +0000 (UTC)
User-Agent: Thunderbird 1.5.0.2 (X11/20060513)
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90605220554y569c11b9p24027772bd2ee79a@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
X-Virus-Scanned: amavisd-new at gentoo.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20519>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBF990DC237DA9EBD2D99C1E9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Martin Langhoff wrote:
> On 5/22/06, Linus Torvalds <torvalds@osdl.org> wrote:
>> On Mon, 22 May 2006, Martin Langhoff wrote:
>> >
>> > Or a slow leak in Perl? The 5.8.8 release notes do talk about some
>> > leaks being fixed, but this 5.8.8 isn't making a difference.
>> >
>> > Working on it.
>>
>> Thanks. Looking at what I did convert, that horrid gentoo CVS tree is
>> interesting. The resulting (partial) git history has 93413 commits and=

>> 850,000+ objects total, all in a totally linear history.
>=20
> Ok, so there's 3 patches posted that should help narrow down the
> problem. There's a new -L <imit> so that Donnie can get his stuff done
> by running it in a while(true) loop. Not proud of it, but hey.
>=20
> And there are two patches that I suspect may fix the leak. After
> applying them, the cvsimport process grows up to ~13MB and then tapers
> off, at least as far as my patience has gotten me. It's late on this
> side of the globe so I'll look at the results tomorrow morning.

OK, I started a new run without -L, and I'm watching it in top right
now. The cvsimport seems to be doing alright, but the cvs server process
sucks about another megabyte of virtual every 4-5 seconds. This is a bit
concerning since I don't have any swap. Shortly after it hit 670M, I got
"Cannot allocate memory" again. I've got a gig of RAM, and around 300M
was resident in various processes at the time.

So it seems the problem is in cvs itself. I will try another run with -L
now.

Thanks,
Donnie


--------------enigBF990DC237DA9EBD2D99C1E9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEcgxnXVaO67S1rtsRAsUnAJ0aVorrR+Gux/rE9eE+V+4rbtn5MACbBz2p
rQs3iBdaT//ue3X3Jsuac5A=
=doSz
-----END PGP SIGNATURE-----

--------------enigBF990DC237DA9EBD2D99C1E9--
