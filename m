From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 05/10] t4018: convert java pattern test to the new infrastructure
Date: Fri, 21 Mar 2014 22:07:17 +0100
Message-ID: <ebffda22f824ddf3d3fbe420872d43c3d667f799.1395433874.git.j6t@kdbg.org>
References: <53282741.5010609@web.de> <cover.1395433874.git.j6t@kdbg.org>
Cc: Brandon Casey <drafnel@gmail.com>, git@vger.kernel.org,
	Thomas Rast <tr@thomasrast.ch>, l.s.r@web.de,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 21 22:09:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WR6gW-0003PF-Nq
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 22:09:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbaCUVI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 17:08:57 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:49470 "EHLO lbmfmo03.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750807AbaCUVIz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 17:08:55 -0400
Received: from bsmtp.bon.at (unknown [192.168.181.101])
	by lbmfmo03.bon.at (Postfix) with ESMTP id 425F7CEA73
	for <git@vger.kernel.org>; Fri, 21 Mar 2014 22:08:54 +0100 (CET)
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 70252CDF84;
	Fri, 21 Mar 2014 22:08:41 +0100 (CET)
Received: from dx.sixt.local (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id CE54119F6A4;
	Fri, 21 Mar 2014 22:08:40 +0100 (CET)
X-Mailer: git-send-email 1.8.5.2.244.g9fb3fb1
In-Reply-To: <cover.1395433874.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244743>

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t4018-diff-funcname.sh           | 4 ----
 t/t4018/java-class-member-function | 8 ++++++++
 2 files changed, 8 insertions(+), 4 deletions(-)
 create mode 100644 t/t4018/java-class-member-function

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index c94a5f4..008325f 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -79,10 +79,6 @@ test_expect_success 'set up .gitattributes declaring drivers to test' '
 	EOF
 '
 
-test_expect_success 'preset java pattern' '
-	test_expect_funcname "public static void main("
-'
-
 test_expect_success 'custom pattern' '
 	test_config diff.java.funcname "!static
 !String
diff --git a/t/t4018/java-class-member-function b/t/t4018/java-class-member-function
new file mode 100644
index 0000000..298bc7a
--- /dev/null
+++ b/t/t4018/java-class-member-function
@@ -0,0 +1,8 @@
+public class Beer
+{
+	int special;
+	public static void main(String RIGHT[])
+	{
+		System.out.print("ChangeMe");
+	}
+}
-- 
1.8.5.2.244.g9fb3fb1
