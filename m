From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: gitweb not friendly to firefox revived
Date: Sun, 1 Aug 2010 21:51:38 +0200
Message-ID: <20100801195138.GA1980@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kernel@pengutronix.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 01 21:51:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfeZX-0002hA-UY
	for gcvg-git-2@lo.gmane.org; Sun, 01 Aug 2010 21:51:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151Ab0HATvl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Aug 2010 15:51:41 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34469 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000Ab0HATvk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Aug 2010 15:51:40 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.71)
	(envelope-from <ukl@pengutronix.de>)
	id 1OfeZO-0002zt-EA; Sun, 01 Aug 2010 21:51:38 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1OfeZO-0000oD-D7; Sun, 01 Aug 2010 21:51:38 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152379>

Hello,

gitweb (at least) doesn't quote author names enough.

=46irefox barfs for me at looking at

	http://git.pengutronix.de/?p=3Dukl/linux-2.6.git;a=3Dshortlog;h=3Dv2.6=
=2E16.10

with an error:

	XML Parsing Error: not well-formed Location:
http://git.pengutronix.de/?p=3Dukl/linux-2.6.git;a=3Dshortlog;h=3Dv2.6.=
16.10
Line Number 112, Column 81:
<td class=3D"author"><a title=3D"Search for commits authored by YOSHIFU=
JI Hideaki / ?$B5HF#1QL@?(B" class=3D"list" href=3D"/?p=3Dukl/linux-2.6=
=2Egit;a=3Dsearch;h=3Dv2.6.16.10;s=3DYOSHIFUJI+Hideaki+/+%1B%24B5HF%231=
QL@%1B(B;st=3Dauthor"><span title=3D"YOSHIFUJI Hideaki / ?$B5HF#1QL@?(B=
">YOSHIFUJI Hideaki...  </span></a></td><td><a class=3D"list subject" t=
itle=3D"[PATCH] IPV6: XFRM: Fix decoding session with preceding extensi=
on header(s)." href=3D"/?p=3Dukl/linux-2.6.git;a=3Dcommit;h=3Dfa39df2ff=
7f6102f1f37d3cf1f68243534d56253">[PATCH] IPV6: XFRM: Fix decoding sessi=
on with preceding... </a></td>
-----------------------------------------------------------------------=
---------^

This is with git 1.7.1 and Iceweasel (aka. Firefox) 3.5.10.

Making

	title=3D>"Search for commits $performed by $author"

in line 1694 of Debian's /usr/lib/cgi-bin/gitweb.cgi from the git 1.7.1
package read

	title=3D>esc_html("Search for commits $performed by $author")

this problem goes away.  (Still my browser barfs when clicking at the n=
ame.)

I'm not sure if this is the right way to fix this and I'm too tired now
to do a complete patch, so I let this for someone else.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
