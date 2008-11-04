From: Samuel Tardieu <sam@rfc1149.net>
Subject: [PATCH 3/3] tag: Add more tests about mixing incompatible modes and
	options
Date: Tue, 04 Nov 2008 13:42:17 +0100
Message-ID: <20081104124217.18273.40967.stgit@arrakis.enst.fr>
References: <20081104124207.18273.31679.stgit@arrakis.enst.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 04 13:43:43 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxLFw-0000wg-OP
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 13:43:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753361AbYKDMmY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 07:42:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752864AbYKDMmW
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 07:42:22 -0500
Received: from revol1.enst.fr ([137.194.2.7]:53248 "EHLO smtp2.enst.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753368AbYKDMmT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 07:42:19 -0500
Received: from localhost (localhost.enst.fr [127.0.0.1])
	by smtp2.enst.fr (Postfix) with ESMTP id AC33284426;
	Tue,  4 Nov 2008 13:42:17 +0100 (CET)
X-Virus-Scanned: amavisd-new at enst.fr
Received: from arrakis.enst.fr (arrakis.enst.fr [137.194.161.143])
	by smtp2.enst.fr (Postfix) with ESMTP id 7A72B8441A;
	Tue,  4 Nov 2008 13:42:17 +0100 (CET)
Received: from arrakis.enst.fr (localhost [127.0.0.1])
	by arrakis.enst.fr (Postfix) with ESMTP id 75EA4203DF;
	Tue,  4 Nov 2008 13:42:17 +0100 (CET)
In-Reply-To: <20081104124207.18273.31679.stgit@arrakis.enst.fr>
User-Agent: StGIT/unknown-version
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100070>

Signed-Off-By: Samuel Tardieu <sam@rfc1149.net>
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
