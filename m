From: Samuel Tardieu <sam@rfc1149.net>
Subject: [(v2) PATCH 2/2] tag: Add more tests about mixing incompatible modes
	and options
Date: Wed, 05 Nov 2008 00:20:36 +0100
Message-ID: <20081104232036.19090.6085.stgit@arrakis.enst.fr>
References: <20081104232031.19090.47633.stgit@arrakis.enst.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 05 00:21:53 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxVDa-0004el-UM
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 00:21:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754233AbYKDXUi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 18:20:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754315AbYKDXUi
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 18:20:38 -0500
Received: from revol1.enst.fr ([137.194.2.7]:52039 "EHLO smtp2.enst.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753570AbYKDXUi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 18:20:38 -0500
Received: from localhost (localhost.enst.fr [127.0.0.1])
	by smtp2.enst.fr (Postfix) with ESMTP id 6695384459;
	Wed,  5 Nov 2008 00:20:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at enst.fr
Received: from arrakis.enst.fr (arrakis.enst.fr [137.194.161.143])
	by smtp2.enst.fr (Postfix) with ESMTP id 35F6884415;
	Wed,  5 Nov 2008 00:20:36 +0100 (CET)
Received: from arrakis.enst.fr (localhost [127.0.0.1])
	by arrakis.enst.fr (Postfix) with ESMTP id 319E3203DF;
	Wed,  5 Nov 2008 00:20:36 +0100 (CET)
In-Reply-To: <20081104232031.19090.47633.stgit@arrakis.enst.fr>
User-Agent: StGIT/unknown-version
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100118>

Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
---
 t/t7004-tag.sh |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index f0edbf1..f377fea 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1090,4 +1090,15 @@ test_expect_success 'filename for the message is relative to cwd' '
 	git cat-file tag tag-from-subdir-2 | grep "in sub directory"
 '
 
+# mixing modes and options:
+
+test_expect_success 'mixing incompatibles modes and options is forbidden' '
+	test_must_fail git tag -a
+	test_must_fail git tag -l -v
+	test_must_fail git tag -n 100
+	test_must_fail git tag -l -m msg
+	test_must_fail git tag -l -F some file
+	test_must_fail git tag -v -s
+'
+
 test_done
