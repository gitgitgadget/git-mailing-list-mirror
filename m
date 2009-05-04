From: Francis Galiegue <fge@one2team.com>
Subject: Re: [PATCH 6/6] Remove bareword filehandles in git-send-email.perl
Date: Mon, 4 May 2009 08:53:44 +0200
Organization: One2team
Message-ID: <200905040853.45186.fge@one2team.com>
References: <1241010743-7020-1-git-send-email-wfp5p@virginia.edu> <200905032334.03286.fge@one2team.com> <20090504081254.64e289fd@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Bill Pemberton <wfp5p@virginia.edu>,
	git@vger.kernel.org, gitster@pobox.com
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Mon May 04 08:53:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0s3m-0004vu-W7
	for gcvg-git-2@gmane.org; Mon, 04 May 2009 08:53:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752710AbZEDGxs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 May 2009 02:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752550AbZEDGxs
	(ORCPT <rfc822;git-outgoing>); Mon, 4 May 2009 02:53:48 -0400
Received: from ns35774.ovh.net ([213.251.185.197]:43805 "EHLO ns35774.ovh.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752484AbZEDGxr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 May 2009 02:53:47 -0400
Received: from smtp.olympe.o2t (138.193.65-86.rev.gaoland.net [86.65.193.138])
	by ns35774.ovh.net (Postfix) with ESMTP id 38A8092C009;
	Mon,  4 May 2009 08:53:42 +0200 (CEST)
Received: from erwin.olympe.o2t (erwin.olympe.o2t [192.168.1.21])
	by smtp.olympe.o2t (Postfix) with ESMTP id 8104F2F2C3;
	Mon,  4 May 2009 08:53:45 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20090504081254.64e289fd@pc09.procura.nl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118214>

Le lundi 04 mai 2009, vous avez =C3=A9crit :
[...]
> >=20
> > And why not go the full way and using IO::File?
>=20
> Because that would be travelling back in time.
> The most efficient and preferred way is three-arg lexical:
>=20
>     open my $fh, "<", $filename or die "$filename: $!";
>     while (<$fh>) {
>         # ...
>         }
>     close $fh or die "$filename: $!";
>=20

I don't see how using IO::File is going back in time at all. It's a sta=
ndard=20
perl module, even in 5.10.

>=20
> > my $fh =3D new IO::File;
> >=20
> > $fh->open("/the/file", O_RDONLY|...)
>=20
> Why use a module for something that is neatly buit in?
>=20

Because it reads better? YMMV, of course. I prefer using IO::File becau=
se perl=20
has too many keywords for its own good :p

--=20
=46rancis Galiegue
ONE2TEAM
Ing=C3=A9nieur syst=C3=A8me
Mob : +33 (0) 683 877 875
Tel : +33 (0) 178 945 552
fge@one2team.com
40 avenue Raymond Poincar=C3=A9
75116 Paris
