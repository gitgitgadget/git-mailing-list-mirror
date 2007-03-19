From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH] cvsserver: Don't lie about binary mode in asciidoc documentation
Date: Mon, 19 Mar 2007 13:31:52 +0100
Message-ID: <11743075123989-git-send-email-frank@lichtenheld.de>
Cc: Frank Lichtenheld <frank@lichtenheld.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 19 13:32:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTH29-0004fh-U0
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 13:32:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933149AbXCSMcG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 08:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933238AbXCSMcG
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 08:32:06 -0400
Received: from mail.lenk.info ([217.160.134.107]:54237 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933149AbXCSMcE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 08:32:04 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HTH2B-0004Kw-5k; Mon, 19 Mar 2007 13:32:20 +0100
Received: from p54b0e006.dip.t-dialin.net ([84.176.224.6] helo=goedel.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HTH1r-0006h9-VM; Mon, 19 Mar 2007 13:32:00 +0100
Received: from djpig by goedel.djpig.de with local (Exim 4.63)
	(envelope-from <frank@lichtenheld.de>)
	id 1HTH1k-0002gH-Jl; Mon, 19 Mar 2007 13:31:52 +0100
X-Mailer: git-send-email 1.5.0.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42609>

The git-cvsserver documentation claims that the server will set
-k modes if appropriate which is not really the case. On the other
hand the available gitcvs.allbinary variable is not documented at
all. Fix both these issues by rewording the related paragraph.

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 Documentation/git-cvsserver.txt |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

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
