From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v8 2/4] tag: fix --sort tests to use cat<<-\EOF format
Date: Tue, 15 Jul 2014 14:29:12 -0700
Message-ID: <1405459754-4220-3-git-send-email-jacob.e.keller@intel.com>
References: <1405459754-4220-1-git-send-email-jacob.e.keller@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 15 23:29:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7AI2-0001kn-B5
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jul 2014 23:29:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754774AbaGOV3Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 17:29:25 -0400
Received: from mga02.intel.com ([134.134.136.20]:55381 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752252AbaGOV3U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 17:29:20 -0400
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP; 15 Jul 2014 14:29:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,668,1400050800"; 
   d="scan'208";a="573664232"
Received: from jekeller-desk1.jf.intel.com (HELO jekeller-desk1.amr.corp.intel.com) ([134.134.173.156])
  by orsmga002.jf.intel.com with ESMTP; 15 Jul 2014 14:29:20 -0700
X-Mailer: git-send-email 2.0.1.475.g9b8d714
In-Reply-To: <1405459754-4220-1-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253603>

The --sort tests should use the better format for >expect to maintain
indenting and ensure that no substitution is occurring. This makes
parsing and understanding the tests a bit easier.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 t/t7004-tag.sh | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index e4ab0f5b6419..66010b0e7066 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1385,41 +1385,41 @@ test_expect_success 'lexical sort' '
 	git tag foo1.6 &&
 	git tag foo1.10 &&
 	git tag -l --sort=refname "foo*" >actual &&
-	cat >expect <<EOF &&
-foo1.10
-foo1.3
-foo1.6
-EOF
+	cat >expect <<-\EOF &&
+	foo1.10
+	foo1.3
+	foo1.6
+	EOF
 	test_cmp expect actual
 '
 
 test_expect_success 'version sort' '
 	git tag -l --sort=version:refname "foo*" >actual &&
-	cat >expect <<EOF &&
-foo1.3
-foo1.6
-foo1.10
-EOF
+	cat >expect <<-\EOF &&
+	foo1.3
+	foo1.6
+	foo1.10
+	EOF
 	test_cmp expect actual
 '
 
 test_expect_success 'reverse version sort' '
 	git tag -l --sort=-version:refname "foo*" >actual &&
-	cat >expect <<EOF &&
-foo1.10
-foo1.6
-foo1.3
-EOF
+	cat >expect <<-\EOF &&
+	foo1.10
+	foo1.6
+	foo1.3
+	EOF
 	test_cmp expect actual
 '
 
 test_expect_success 'reverse lexical sort' '
 	git tag -l --sort=-refname "foo*" >actual &&
-	cat >expect <<EOF &&
-foo1.6
-foo1.3
-foo1.10
-EOF
+	cat >expect <<-\EOF &&
+	foo1.6
+	foo1.3
+	foo1.10
+	EOF
 	test_cmp expect actual
 '
 
-- 
2.0.1.475.g9b8d714
