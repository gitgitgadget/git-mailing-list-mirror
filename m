From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH 1/2] t4027: test diff for submodule with empty directory
Date: Wed, 30 Apr 2008 00:07:19 +0800
Message-ID: <1209485240-9003-2-git-send-email-pkufranky@gmail.com>
References: <46dff0320804290831u7ef1a78ag2988d5d12f782bdb@mail.gmail.com>
 <1209485240-9003-1-git-send-email-pkufranky@gmail.com>
Cc: git@vger.kernel.org, Ping Yin <pkufranky@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Apr 29 18:08:25 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqsNO-0005bR-5b
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 18:08:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765404AbYD2QH1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 12:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764977AbYD2QH1
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 12:07:27 -0400
Received: from mail.qikoo.org ([60.28.205.235]:51645 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1764708AbYD2QH0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 12:07:26 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id E97ED470AB; Wed, 30 Apr 2008 00:07:20 +0800 (CST)
X-Mailer: git-send-email 1.5.5.1.96.gef4a.dirty
In-Reply-To: <1209485240-9003-1-git-send-email-pkufranky@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80695>

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
1.5.5.1.96.gef4a.dirty
