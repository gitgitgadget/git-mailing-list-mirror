From: Samuel Tardieu <sam@rfc1149.net>
Subject: Re: [BUG] fatal error during merge
Date: Thu, 13 Nov 2008 15:26:33 +0100
Organization: RFC 1149 (see http://www.rfc1149.net/)
Message-ID: <2008-11-13-15-26-33+trackit+sam@rfc1149.net>
References: <53328.bFoQE3daRhY=.1226568134.squirrel@webmail.hotelhot.dk> <2008-11-13-14-23-19+trackit+sam@rfc1149.net> <20081113140323.GA10267@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Anders Melchiorsen <mail@cup.kalibalik.dk>, git@vger.kernel.org
To: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Nov 13 15:27:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0dAY-0005Vt-AF
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 15:27:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752264AbYKMO0Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Nov 2008 09:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752141AbYKMO0X
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 09:26:23 -0500
Received: from zoidberg.rfc1149.net ([91.121.19.179]:57188 "EHLO
	zoidberg.rfc1149.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055AbYKMO0X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 09:26:23 -0500
Received: from localhost (localhost [127.0.0.1])
	by zoidberg.rfc1149.net (Postfix) with ESMTP id 5E21810F5A1;
	Thu, 13 Nov 2008 15:26:20 +0100 (CET)
X-Virus-Scanned: amavisd-new at rfc1149.net
Received: from zoidberg.rfc1149.net ([127.0.0.1])
	by localhost (zaphod.rfc1149.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ic1euBWfXEYp; Thu, 13 Nov 2008 15:26:19 +0100 (CET)
Received: from mail2.rfc1149.net (willow.rfc1149.net [IPv6:2001:6f8:37a:2::2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail2.rfc1149.net", Issuer "rfc1149.net" (verified OK))
	by zoidberg.rfc1149.net (Postfix) with ESMTPS id 239DB10F52A;
	Thu, 13 Nov 2008 15:26:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mail2.rfc1149.net (Postfix) with ESMTP id E15D5C40BC;
	Thu, 13 Nov 2008 15:26:33 +0100 (CET)
Received: from mail2.rfc1149.net ([127.0.0.1])
	by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iAUTqng6RQ5Y; Thu, 13 Nov 2008 15:26:33 +0100 (CET)
Received: by mail2.rfc1149.net (Postfix, from userid 1000)
	id B8C12C40BE; Thu, 13 Nov 2008 15:26:33 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081113140323.GA10267@neumann>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-WWW: http://www.rfc1149.net/sam
X-Jabber: <sam@rfc1149.net> (see http://www.jabber.org/)
X-OpenPGP-Fingerprint: 79C0 AE3C CEA8 F17B 0EF1  45A5 F133 2241 1B80 ADE6 (see http://www.gnupg.org/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100877>

* SZEDER G=E1bor <szeder@ira.uka.de> [2008-11-13 15:03:23 +0100]

| On Thu, Nov 13, 2008 at 02:23:19PM +0100, Samuel Tardieu wrote:
| > >>>>> "Anders" =3D=3D Anders Melchiorsen <mail@cup.kalibalik.dk> wr=
ites:
| >=20
| > Anders> I have tested the script with Git 1.6.0.2, but the real
| > Anders> scenario that made this appear seems to also fail with mast=
er
| > Anders> and next from git.git.
| >=20
| > I confirm that your test case also fails with the current "next".
|=20
| Yeah, and it can be bisected to commit 621ff675 (rev-parse: fix
| meaning of rev~ vs rev~0, 2008-03-14), which is from Linus, so put hi=
m
| on Cc.

I think your pinpointed a change of behaviour in "HEAD~", which is
probably not the problem at hand. To find the real bug, you should
update the test script so that it uses "HEAD~1" instead of "HEAD~".
