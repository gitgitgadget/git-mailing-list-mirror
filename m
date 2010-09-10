From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] t/t4018: avoid two unnecessary sub-shell invocations
Date: Fri, 10 Sep 2010 11:13:38 -0500
Message-ID: <rl_Fe3GvwRHMfzdMCqwnBhdCJhaaE21fdWY64ux0ATvXGt5hFA80h-4iMktgWtjAQ_54uD09KJc@cipher.nrlssc.navy.mil>
References: <20100909195904.GE1146@sigill.intra.peff.net>
Cc: gitster@pobox.com, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: peff@peff.net
X-From: git-owner@vger.kernel.org Fri Sep 10 18:16:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ou6HB-0003Oq-7d
	for gcvg-git-2@lo.gmane.org; Fri, 10 Sep 2010 18:16:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755462Ab0IJQQZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Sep 2010 12:16:25 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:40720 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755409Ab0IJQQY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Sep 2010 12:16:24 -0400
Received: by mail.nrlssc.navy.mil id o8AGDpge016358; Fri, 10 Sep 2010 11:13:51 -0500
In-Reply-To: <20100909195904.GE1146@sigill.intra.peff.net>
X-OriginalArrivalTime: 10 Sep 2010 16:13:51.0460 (UTC) FILETIME=[28643A40:01CB5103]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155938>

From: Brandon Casey <drafnel@gmail.com>


Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


Thanks again Jeff for your, as always, very valuable review.


 t/t4018-diff-funcname.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 620cd02..c8e1937 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -37,13 +37,13 @@ for p in $builtin_patterns
 do
 	test_expect_success "builtin $p pattern compiles" '
 		echo "*.java diff=$p" > .gitattributes &&
-		! ( git diff --no-index Beer.java Beer-correct.java 2>&1 |
-			grep "fatal" > /dev/null )
+		! { git diff --no-index Beer.java Beer-correct.java 2>&1 |
+			grep "fatal" > /dev/null; }
 	'
 	test_expect_success "builtin $p wordRegex pattern compiles" '
-		! ( git diff --no-index --word-diff \
+		! { git diff --no-index --word-diff \
 			Beer.java Beer-correct.java 2>&1 |
-			grep "fatal" > /dev/null )
+			grep "fatal" > /dev/null; }
 	'
 done
 
-- 
1.7.2.1
