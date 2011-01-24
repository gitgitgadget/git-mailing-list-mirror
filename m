From: Jochen Schmitt <Jochen@herr-schmitt.de>
Subject: [PATCH] Fix wrong xhtml option to highlight
Date: Mon, 24 Jan 2011 20:44:58 +0100
Message-ID: <1295898298-9794-1-git-send-email-Jochen@herr-schmitt.de>
Cc: Jochen Schmitt <Jochen@herr-schmitt.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 24 20:45:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PhSLi-0008Mu-Cq
	for gcvg-git-2@lo.gmane.org; Mon, 24 Jan 2011 20:45:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374Ab1AXTpF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jan 2011 14:45:05 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:63237 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216Ab1AXTpE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jan 2011 14:45:04 -0500
Received: from zeus.inet.herr-schmitt.de (p4FDD06D6.dip0.t-ipconnect.de [79.221.6.214])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0LeQLR-1PzlRo3UtB-00pnD5; Mon, 24 Jan 2011 20:45:02 +0100
Received: from zeus.inet.herr-schmitt.de (localhost [127.0.0.1])
	by zeus.inet.herr-schmitt.de (8.14.4/8.14.4) with ESMTP id p0OJj3NK009937
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 24 Jan 2011 20:45:04 +0100
Received: (from s4504kr@localhost)
	by zeus.inet.herr-schmitt.de (8.14.4/8.14.4/Submit) id p0OJj3Ma009936;
	Mon, 24 Jan 2011 20:45:03 +0100
X-Mailer: git-send-email 1.7.3.4
X-Provags-ID: V02:K0:lBP1IbyzVHdr5JMsNETecj2IzqtV1bG7DvORa/LvgmH
 Kr0v07sSORzNPzBHLnGzOdKuXtT+luc0l0DukUQgrrDpzKw6C9
 IuXok7CxmyQp9uu9FikgKBqRFd9q4mVvEvS3ahVYJUXNX1fjKq
 t4oeGf2LPhqg77DEySkPvgBQvBRNwZfrHkm9BfYPkdqstSXTwV
 OPQrrGPvbCVnyDdkYsJRhSIfc046GI4IzeVugExJN0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165453>

---
Hallo,

because I'm the maintainer of the highlight package in the
Fedora Project I was notified, that highlight doesn't works
properly with gitweb in BZ #672293.

So I have create the following simple patch to solve the 
reported issue.

Best Regards

Jochen Schmitt

 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1025c2f..b662420 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3468,7 +3468,7 @@ sub run_highlighter {
 	close $fd;
 	open $fd, quote_command(git_cmd(), "cat-file", "blob", $hash)." | ".
 	          quote_command($highlight_bin).
-	          " --xhtml --fragment --syntax $syntax |"
+	          " -xhtml --fragment --syntax $syntax |"
 		or die_error(500, "Couldn't open file or run syntax highlighter");
 	return $fd;
 }
-- 
1.7.3.4
