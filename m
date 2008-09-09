From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH 5/6] t9101: use "git hash-object" without dash
Date: Wed, 10 Sep 2008 06:25:28 +0900
Message-ID: <20080910062528.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 09 23:28:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdAkj-0007Te-8r
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 23:28:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754159AbYIIV0g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 17:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754080AbYIIV0f
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 17:26:35 -0400
Received: from karen.lavabit.com ([72.249.41.33]:33448 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753962AbYIIV0f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 17:26:35 -0400
Received: from e.earth.lavabit.com (e.earth.lavabit.com [192.168.111.14])
	by karen.lavabit.com (Postfix) with ESMTP id A8611C89D8;
	Tue,  9 Sep 2008 16:26:25 -0500 (CDT)
Received: from 9677.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id ASAST2IPG4NY; Tue, 09 Sep 2008 16:26:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=H26Ezjn9UKAGDQvXis3DHnkzPxLSgj07WGUPDt3wF4g/FeT8giO/BmvjWd9IqZzGz3hurRlI0ZJ4JQq31npu+MDC8WvDf+SLT2I5yYBIDauRTUPLVBfDPP025raNMlS6KwLsyeluFtjDJXIcj2uBENt0uMJrhTbmwQ9Xg3Ml/dY=;
  h=From:To:Cc:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:Message-Id:Signed-off-by;
Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95440>

---
 t/t9101-git-svn-props.sh |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/t/t9101-git-svn-props.sh b/t/t9101-git-svn-props.sh
index 7732dea..1e31d6e 100755
--- a/t/t9101-git-svn-props.sh
+++ b/t/t9101-git-svn-props.sh
@@ -26,27 +26,27 @@ cd import
 EOF
 
 	printf "Hello\r\nWorld\r\n" > crlf
-	a_crlf=`git-hash-object -w crlf`
+	a_crlf=`git hash-object -w crlf`
 	printf "Hello\rWorld\r" > cr
-	a_cr=`git-hash-object -w cr`
+	a_cr=`git hash-object -w cr`
 	printf "Hello\nWorld\n" > lf
-	a_lf=`git-hash-object -w lf`
+	a_lf=`git hash-object -w lf`
 
 	printf "Hello\r\nWorld" > ne_crlf
-	a_ne_crlf=`git-hash-object -w ne_crlf`
+	a_ne_crlf=`git hash-object -w ne_crlf`
 	printf "Hello\nWorld" > ne_lf
-	a_ne_lf=`git-hash-object -w ne_lf`
+	a_ne_lf=`git hash-object -w ne_lf`
 	printf "Hello\rWorld" > ne_cr
-	a_ne_cr=`git-hash-object -w ne_cr`
+	a_ne_cr=`git hash-object -w ne_cr`
 
 	touch empty
-	a_empty=`git-hash-object -w empty`
+	a_empty=`git hash-object -w empty`
 	printf "\n" > empty_lf
-	a_empty_lf=`git-hash-object -w empty_lf`
+	a_empty_lf=`git hash-object -w empty_lf`
 	printf "\r" > empty_cr
-	a_empty_cr=`git-hash-object -w empty_cr`
+	a_empty_cr=`git hash-object -w empty_cr`
 	printf "\r\n" > empty_crlf
-	a_empty_crlf=`git-hash-object -w empty_crlf`
+	a_empty_crlf=`git hash-object -w empty_crlf`
 
 	svn import --no-auto-props -m 'import for git svn' . "$svnrepo" >/dev/null
 cd ..
@@ -103,8 +103,8 @@ done
 cd test_wc
 	printf '$Id$\rHello\rWorld\r' > cr
 	printf '$Id$\rHello\rWorld' > ne_cr
-	a_cr=`printf '$Id$\r\nHello\r\nWorld\r\n' | git-hash-object --stdin`
-	a_ne_cr=`printf '$Id$\r\nHello\r\nWorld' | git-hash-object --stdin`
+	a_cr=`printf '$Id$\r\nHello\r\nWorld\r\n' | git hash-object --stdin`
+	a_ne_cr=`printf '$Id$\r\nHello\r\nWorld' | git hash-object --stdin`
 	test_expect_success 'Set CRLF on cr files' \
 	'svn propset svn:eol-style CRLF cr &&
 	 svn propset svn:eol-style CRLF ne_cr &&
@@ -115,8 +115,8 @@ cd ..
 test_expect_success 'fetch and pull latest from svn' \
 	'git svn fetch && git pull . ${remotes_git_svn}'
 
-b_cr="`git-hash-object cr`"
-b_ne_cr="`git-hash-object ne_cr`"
+b_cr="`git hash-object cr`"
+b_ne_cr="`git hash-object ne_cr`"
 
 test_expect_success 'CRLF + $Id$' "test '$a_cr' = '$b_cr'"
 test_expect_success 'CRLF + $Id$ (no newline)' "test '$a_ne_cr' = '$b_ne_cr'"
-- 
1.6.0.1.420.g77d9


-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
