From: Jeff King <peff@peff.net>
Subject: [PATCH 07/16] t4020: don't use grep -a
Date: Wed, 12 Mar 2008 17:37:37 -0400
Message-ID: <20080312213737.GH26286@coredump.intra.peff.net>
References: <cover.1205356737.git.peff@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Whit Armstrong <armstrong.whit@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 22:38:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZYeR-00014Q-3g
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 22:38:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752717AbYCLVhk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 17:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752682AbYCLVhk
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 17:37:40 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3433 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752670AbYCLVhk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 17:37:40 -0400
Received: (qmail 3260 invoked by uid 111); 12 Mar 2008 21:37:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 12 Mar 2008 17:37:38 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Mar 2008 17:37:37 -0400
Content-Disposition: inline
In-Reply-To: <cover.1205356737.git.peff@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76998>

Solaris /usr/bin/grep doesn't understand "-a". In this case
we can just include the expected output with the test, which
is a better test anyway.

Signed-off-by: Jeff King <peff@peff.net>
---
Ooh, we get to use binary patches.

 t/t4020-diff-external.sh |    3 ++-
 t/t4020/diff.NUL         |  Bin 0 -> 116 bytes
 2 files changed, 2 insertions(+), 1 deletions(-)
 create mode 100644 t/t4020/diff.NUL

diff --git a/t/t4020-diff-external.sh b/t/t4020-diff-external.sh
index bf8f778..637b4e1 100755
--- a/t/t4020-diff-external.sh
+++ b/t/t4020-diff-external.sh
@@ -103,7 +103,8 @@ echo NULZbetweenZwords | perl -pe 'y/Z/\000/' > file
 
 test_expect_success 'force diff with "diff"' '
 	echo >.gitattributes "file diff" &&
-	git diff | grep -a second
+	git diff >actual &&
+	test_cmp ../t4020/diff.NUL actual
 '
 
 test_done
diff --git a/t/t4020/diff.NUL b/t/t4020/diff.NUL
new file mode 100644
index 0000000000000000000000000000000000000000..db2f89090c1c4de05e4f82ea39ea118fccfd48dd
GIT binary patch
literal 116
zcmXxbF$#k~5Jq9^ImPtD=#EH8x;=oT%K;qs->?u?P{ABu2(fz2_fpB3Ro`XjsmtX9
z_Ft&fgfAo5!x7pxTMzd;TL`ydAXWW)5|QhPk=0m?V<g=$FEx=oUt{Cg51=;3vZjqr
Do_`?W

literal 0
HcmV?d00001

-- 
1.5.4.4.543.g30fdd.dirty
