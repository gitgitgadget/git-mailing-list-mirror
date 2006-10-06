From: Dennis Stosberg <dennis@stosberg.net>
Subject: [PATCH] Remove bashism from t3210-pack-refs.sh
Date: Fri, 06 Oct 2006 11:10:54 +0200
Message-ID: <20061006091054.15209.35068.stgit@leonov.stosberg.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Fri Oct 06 11:11:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVljg-0002RO-1g
	for gcvg-git@gmane.org; Fri, 06 Oct 2006 11:11:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbWJFJK5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Oct 2006 05:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932110AbWJFJK5
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Oct 2006 05:10:57 -0400
Received: from kleekamp.stosberg.net ([85.116.201.130]:50307 "EHLO
	kleekamp.stosberg.net") by vger.kernel.org with ESMTP
	id S932106AbWJFJK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Oct 2006 05:10:56 -0400
Received: from leonov.stosberg.net (localhost [127.0.0.1])
	by kleekamp.stosberg.net (Postfix) with ESMTP id 8D43D108A0E
	for <git@vger.kernel.org>; Fri,  6 Oct 2006 11:10:54 +0200 (CEST)
To: git@vger.kernel.org
User-Agent: StGIT/0.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28393>

This bashism makes the test fail if /bin/sh is not bash.

Signed-off-by: Dennis Stosberg <dennis@stosberg.net>
---

 t/t3210-pack-refs.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
index f31e79c..ca5bd49 100755
--- a/t/t3210-pack-refs.sh
+++ b/t/t3210-pack-refs.sh
@@ -23,7 +23,7 @@ SHA1=
 test_expect_success \
     'see if git show-ref works as expected' \
     'git-branch a &&
-     SHA1=$(< .git/refs/heads/a) &&
+     SHA1=`cat .git/refs/heads/a` &&
      echo "$SHA1 refs/heads/a" >expect &&
      git-show-ref a >result &&
      diff expect result'
