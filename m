From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH 1/4] t4027: test diff for submodule with empty directory
Date: Fri,  2 May 2008 21:35:33 +0800
Message-ID: <1209735336-4690-2-git-send-email-pkufranky@gmail.com>
References: <46dff0320804300856w941d948rbcc1cee06f1b41a9@mail.gmail.com>
 <1209735336-4690-1-git-send-email-pkufranky@gmail.com>
Cc: gitster@pobox.com, Ping Yin <pkufranky@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 02 15:37:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrvRc-0003lU-Jx
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 15:37:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935131AbYEBNfr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 09:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935075AbYEBNfq
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 09:35:46 -0400
Received: from mail.qikoo.org ([60.28.205.235]:57906 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S935131AbYEBNfn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 09:35:43 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 9ED52470AB; Fri,  2 May 2008 21:35:36 +0800 (CST)
X-Mailer: git-send-email 1.5.5.1.116.ge4b9c.dirty
In-Reply-To: <1209735336-4690-1-git-send-email-pkufranky@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80992>

Signed-off-by: Ping Yin <pkufranky@gmail.com>
---
 t/t4027-diff-submodule.sh |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/t/t4027-diff-submodule.sh b/t/t4027-diff-submodule.sh
index 1fd3fb7..ba6679c 100755
--- a/t/t4027-diff-submodule.sh
+++ b/t/t4027-diff-submodule.sh
@@ -50,4 +50,11 @@ test_expect_success 'git diff-files --raw' '
 	test_cmp expect actual.files
 '
 
+test_expect_success 'git diff (empty submodule dir)' '
+	: >empty &&
+	rm -rf sub/* sub/.git &&
+	git diff > actual.empty &&
+	test_cmp empty actual.empty
+'
+
 test_done
-- 
1.5.5.1.116.ge4b9c.dirty
