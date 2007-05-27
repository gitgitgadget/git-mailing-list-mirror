From: Johan Herland <johan@herland.net>
Subject: [PATCH] Add -Wdeclaration-after-statement to CFLAGS to help enforce
 the instructions in SubmittingPatches
Date: Sun, 27 May 2007 16:39:35 +0200
Message-ID: <200705271639.35267.johan@herland.net>
References: <20070520154227.GG5412@admingilde.org>
 <7vabvyfw7n.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0705211347540.6410@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>,
	Martin Waitz <tali@admingilde.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 27 16:39:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsJuL-0002Bk-T8
	for gcvg-git@gmane.org; Sun, 27 May 2007 16:39:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752373AbXE0Ojk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 27 May 2007 10:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752836AbXE0Ojk
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 10:39:40 -0400
Received: from smtp.getmail.no ([84.208.20.33]:53166 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752373AbXE0Ojj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 May 2007 10:39:39 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JIP00809FE1JP00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 27 May 2007 16:39:37 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JIP00G0TFDZR360@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 27 May 2007 16:39:35 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JIP00JT5FDZXLC0@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Sun, 27 May 2007 16:39:35 +0200 (CEST)
In-reply-to: <Pine.LNX.4.64.0705211347540.6410@racer.site>
Content-disposition: inline
User-Agent: KMail/1.9.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48556>

Signed-off-by: Johan Herland <johan@herland.net>
---
On Monday 21 May 2007, Johannes Schindelin wrote:
>=20
> We do not appreciate C99 initializers, declarations after statements,
> or "0" instead of "NULL".
>
> [...]
>=20
> +Also, variables have to be declared at the beginning of the block
> +(you can check this with gcc, using the -Wdeclaration-after-statemen=
t
> +option).

Why not automatically enforce it by putting -Wdeclaration-after-stateme=
nt
in the Makefile?

It should probably be protected by some GCC if-ery, but then again, so =
should this:

CC =3D gcc


Have fun!

=2E..Johan


=A0Makefile | =A0 =A02 +-
=A01 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 29243c6..4e91516 100644
--- a/Makefile
+++ b/Makefile
@@ -135,7 +135,7 @@ uname_P :=3D $(shell sh -c 'uname -p 2>/dev/null ||=
 echo not')
=A0
=A0# CFLAGS and LDFLAGS are for the users to override from the command =
line.
=A0
-CFLAGS =3D -g -O2 -Wall
+CFLAGS =3D -g -O2 -Wall -Wdeclaration-after-statement
=A0LDFLAGS =3D
=A0ALL_CFLAGS =3D $(CFLAGS)
=A0ALL_LDFLAGS =3D $(LDFLAGS)
--=20
1.5.2.101.gee49f
