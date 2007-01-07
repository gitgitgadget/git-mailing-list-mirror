From: Sean <seanlkml@sympatico.ca>
Subject: Re: OT: character encodings (was: Linux 2.6.20-rc4)
Date: Sun, 7 Jan 2007 15:15:14 -0500
Message-ID: <20070107151514.be9430b1.seanlkml@sympatico.ca>
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org>
	<Pine.LNX.4.61.0701071152570.4365@yvahk01.tjqt.qr>
	<20070107114439.GC21613@flint.arm.linux.org.uk>
	<45A0F060.9090207@imap.cc>
	<1168182838.14763.24.camel@shinybook.infradead.org>
	<20070107153833.GA21133@flint.arm.linux.org.uk>
	<20070107182151.7cc544f3@localhost.localdomain>
	<20070107191730.GD21133@flint.arm.linux.org.uk>
	<20070107200553.GA15101@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alan <alan@lxorguk.ukuu.org.uk>,
	David Woodhouse <dwmw2@infradead.org>,
	Tilman Schmidt <tilman@imap.cc>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 07 21:15:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3eQN-0007qf-Ji
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 21:15:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965121AbXAGUPU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 7 Jan 2007 15:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965141AbXAGUPU
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 15:15:20 -0500
Received: from bayc1-pasmtp02.bayc1.hotmail.com ([65.54.191.162]:62322 "EHLO
	BAYC1-PASMTP02.CEZ.ICE" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965116AbXAGUPR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 15:15:17 -0500
X-Originating-IP: [69.156.137.239]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.137.239]) by BAYC1-PASMTP02.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 7 Jan 2007 12:15:15 -0800
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1H3dU7-0002H1-Po; Sun, 07 Jan 2007 14:15:11 -0500
To: Dave Jones <davej@redhat.com>
In-Reply-To: <20070107200553.GA15101@redhat.com>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 07 Jan 2007 20:15:16.0307 (UTC) FILETIME=[8BABFA30:01C73298]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36194>

On Sun, 7 Jan 2007 15:05:53 -0500
Dave Jones <davej@redhat.com> wrote:

Including the Git list...

> On Sun, Jan 07, 2007 at 07:17:30PM +0000, Russell King wrote:
>=20
>  > commit 24ebead82bbf9785909d4cf205e2df5e9ff7da32
>  > tree 921f686860e918a01c3d3fb6cd106ba82bf4ace6
>  > parent 264166e604a7e14c278e31cadd1afb06a7d51a11
>  > author Rafa=C2=B3 Bilski <rafalbilski@interia.pl> 1167691774 +0100
>  > committer Dave Jones <davej@redhat.com> 1167799119 -0500
>  >=20
>  > and looking at that "author" closer with od:
>  >=20
>  > 0000140 74 68 6f 72 20 52 61 66 61 b3 20 42 69 6c 73 6b
>  >           t   h   o   r       R   a   f   a   =C2=B3       B   i  =
 l   s   k
>  >=20
>  > clearly not UTF-8.  I doubt whether any of the commits I do on my
>  > en_GB ISO-8859-1 systems end up being UTF-8 encoded.
>=20
> This has been bugging me for a while.
> Viewing the mail I applied in mutt shows his name correctly as Rafa=C5=
=82
> Applying it with git-applymbox and viewing the log on master.kernel.o=
rg
> with git log shows Rafa<B3>   And then later when put into email
> it turns into Rafa=C2=B3
>=20
>  > But the point is there is charset damage which has happened _long_=
 before
>  > Linus' action.  There is no character set defined for the contents=
 of git
>  > repositories, and as such the output of the git tools can not be
>  > interpreted as any one single character set.
>=20
> If there's something I should be doing when I commit that I'm not,
> I'll be happy to change my scripts.  My $LANG is set to en_US.UTF-8
> which should DTRT to the best of my knowledge, but clearly, that isn'=
t
> the case.
