From: "martin f. krafft" <madduck@madduck.net>
Subject: [PATCH] Install man3 manpages to $PREFIX/share/man/man3 even for site installs
Date: Mon, 20 Aug 2007 09:23:15 +0200
Message-ID: <11875945952624-git-send-email-madduck@madduck.net>
References: <11875945951398-git-send-email-madduck@madduck.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 20 09:23:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IN1c6-0005sh-EV
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 09:23:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515AbXHTHXU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 03:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbXHTHXT
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 03:23:19 -0400
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:51537 "EHLO
	albatross.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450AbXHTHXS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 03:23:18 -0400
Received: from localhost (albatross.madduck.net [127.0.0.1])
	by albatross.madduck.net (postfix) with ESMTP id 675DE8966EE
	for <git@vger.kernel.org>; Mon, 20 Aug 2007 09:23:17 +0200 (CEST)
Received: from albatross.madduck.net ([127.0.0.1])
	by localhost (albatross.madduck.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 27389-10 for <git@vger.kernel.org>;
	Mon, 20 Aug 2007 09:23:17 +0200 (CEST)
Received: from wall.oerlikon.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by albatross.madduck.net (postfix) with ESMTP id 0D64E8966DF
	for <git@vger.kernel.org>; Mon, 20 Aug 2007 09:23:16 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id D712D9F180
	for <git@vger.kernel.org>; Mon, 20 Aug 2007 09:23:15 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 927CF43F6; Mon, 20 Aug 2007 09:23:15 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.rc5.40.g2f82
In-Reply-To: <11875945951398-git-send-email-madduck@madduck.net>
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at madduck.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56183>

MakeMaker supports three installation modes: perl, site, and vendor. The first
and third install manpages to $PREFIX/share/man, only site installs to
$PREFIX/man. For consistency with the rest of git, which does not make the
distinction and writes all manpages to $PREFIX/share/man, this change makes
sure that perl does too, even when it's installed in site mode.

Signed-off-by: martin f. krafft <madduck@madduck.net>
---
 perl/Makefile.PL |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/perl/Makefile.PL b/perl/Makefile.PL
index 4375161..6aecd89 100644
--- a/perl/Makefile.PL
+++ b/perl/Makefile.PL
@@ -29,5 +29,6 @@ WriteMakefile(
 	VERSION_FROM    => 'Git.pm',
 	PM		=> \%pm,
 	MAKEFILE	=> 'perl.mak',
+	INSTALLSITEMAN3DIR => '$(SITEPREFIX)/share/man/man3',
 	%extra
 );
-- 
1.5.3.rc5.40.g2f82
