From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH (resend)] cvsserver: Don't lie about binary mode in asciidoc documentation
Date: Sat, 31 Mar 2007 15:32:13 +0200
Message-ID: <11753479333854-git-send-email-frank@lichtenheld.de>
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Mar 31 15:32:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXdh9-0005GN-AD
	for gcvg-git@gmane.org; Sat, 31 Mar 2007 15:32:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753014AbXCaNcg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 31 Mar 2007 09:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753023AbXCaNcg
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Mar 2007 09:32:36 -0400
Received: from mail.lenk.info ([217.160.134.107]:51908 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753014AbXCaNcg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Mar 2007 09:32:36 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HXdhQ-0004Vn-BJ; Sat, 31 Mar 2007 15:32:56 +0200
Received: from p3ee3dbc9.dip.t-dialin.net ([62.227.219.201] helo=goedel.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HXdh3-0004e9-S3; Sat, 31 Mar 2007 15:32:34 +0200
Received: from djpig by goedel.djpig.de with local (Exim 4.63)
	(envelope-from <frank@lichtenheld.de>)
	id 1HXdgk-0003Bj-4v; Sat, 31 Mar 2007 15:32:14 +0200
X-Mailer: git-send-email 1.5.0.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43555>

The git-cvsserver documentation claims that the server will set
-k modes if appropriate which is not really the case. On the other
hand the available gitcvs.allbinary variable is not documented at
all. Fix both these issues by rewording the related paragraph.

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 Documentation/git-cvsserver.txt |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

I send this before but it seems to have been lost in the noise.
Also CCed Andy Parkins this time who introduced the gitcvs.allbinary
variable.

I think this should be suitable for 1.5.1.

diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index 1c6f6a7..85d0950 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -134,9 +134,11 @@ checkout, diff, status, update, log, add, remove, commit.
 Legacy monitoring operations are not supported (edit, watch and related).
 Exports and tagging (tags and branches) are not supported at this stage.
 
-The server will set the -k mode to binary when relevant. In proper GIT
-tradition, the contents of the files are always respected.
-No keyword expansion or newline munging is supported.
+The server should set the -k mode to binary when relevant, however,
+this is not really implemented yet. For now, you can force the server
+to set `-kb` for all files by setting the `gitcvs.allbinary` config
+variable. In proper GIT tradition, the contents of the files are
+always respected. No keyword expansion or newline munging is supported.
 
 Dependencies
 ------------
-- 
1.5.0.3
