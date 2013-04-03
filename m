From: Martin von Gagern <Martin.vGagern@gmx.net>
Subject: [PATCH] Documentation: Strip texinfo anchors to avoid duplicates
Date: Wed,  3 Apr 2013 21:54:33 +0200
Message-ID: <1365018873-22503-1-git-send-email-Martin.vGagern@gmx.net>
Cc: gitster@pobox.com, Martin von Gagern <Martin.vGagern@gmx.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 03 21:55:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNTmW-0001Sl-U2
	for gcvg-git-2@plane.gmane.org; Wed, 03 Apr 2013 21:55:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257Ab3DCTzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Apr 2013 15:55:08 -0400
Received: from mout.gmx.net ([212.227.15.15]:65057 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932245Ab3DCTzH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Apr 2013 15:55:07 -0400
Received: from mailout-de.gmx.net ([10.1.76.31]) by mrigmx.server.lan
 (mrigmx001) with ESMTP (Nemesis) id 0LiZpS-1UtEgg1STU-00cfGp for
 <git@vger.kernel.org>; Wed, 03 Apr 2013 21:55:06 +0200
Received: (qmail invoked by alias); 03 Apr 2013 19:55:06 -0000
Received: from 178-27-35-12-dynip.superkabel.de (EHLO mail.gagern.sytes.net) [178.27.35.12]
  by mail.gmx.net (mp031) with SMTP; 03 Apr 2013 21:55:06 +0200
X-Authenticated: #858129
X-Provags-ID: V01U2FsdGVkX1/S944kQS/SE9Lx22qc86fDOw5iroBXo+Ljih0je+
	itoxATopSUyDZ9
X-Mailer: git-send-email 1.8.1.5
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219962>

This keeps texinfo 5.x happy. See https://bugs.gentoo.org/464210.

Signed-off-by: Martin von Gagern <Martin.vGagern@gmx.net>
---
 Documentation/cat-texi.perl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/cat-texi.perl b/Documentation/cat-texi.perl
index dbc133c..b52660d 100755
--- a/Documentation/cat-texi.perl
+++ b/Documentation/cat-texi.perl
@@ -12,6 +12,7 @@ while (<STDIN>) {
 		push @menu, $1;
 	}
 	s/\(\@pxref{\[(URLS|REMOTES)\]}\)//;
+	s/\@anchor\{[^{}]*\}//g;
 	print TMP;
 }
 close TMP;
-- 
1.8.1.5
