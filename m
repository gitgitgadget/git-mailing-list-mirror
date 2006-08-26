From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] dir: do all size checks before seeking back and fix file closing
Date: Sun, 27 Aug 2006 00:35:34 +0200
Organization: At home
Message-ID: <ecqibj$51v$1@sea.gmane.org>
References: <20060826141709.GC11601@diku.dk> <Pine.LNX.4.64.0608261509290.11811@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sun Aug 27 00:36:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GH6kx-0006gF-Pm
	for gcvg-git@gmane.org; Sun, 27 Aug 2006 00:36:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911AbWHZWfu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 26 Aug 2006 18:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbWHZWfu
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Aug 2006 18:35:50 -0400
Received: from main.gmane.org ([80.91.229.2]:55733 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750911AbWHZWfu (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Aug 2006 18:35:50 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GH6kg-0006de-9W
	for git@vger.kernel.org; Sun, 27 Aug 2006 00:35:42 +0200
Received: from host-81-190-21-215.torun.mm.pl ([81.190.21.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 27 Aug 2006 00:35:42 +0200
Received: from jnareb by host-81-190-21-215.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 27 Aug 2006 00:35:42 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-215.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26073>

Linus Torvalds wrote:

> Now, admittedly it's wrong because another bad habit Junio picked up=20
> (doing comparisons with constants in the wrong order), so please writ=
e it=20
> as
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0if (fd >=3D 0)
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0close(fd);
>=20
> instead.
>=20
> Junio: I realize that you claim that you learnt that syntax from an=20
> authorative source, but he was _wrong_. Doing the constant first is m=
ore=20
> likely to cause bugs, rather than less. Compilers will warn about the
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0if (x =3D 0)
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0..
>=20
> kind of bug, and putting the constant first just confuses humans.

Well, perhaps except checking if variable is in given range, e.g.

        if (0 <=3D x && x <=3D 5)
=20
> It's more important to _not_ confuse humans than it is to try to avoi=
d an=20
> uncommon error that compilers can and do warn about anyway.
=20

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
