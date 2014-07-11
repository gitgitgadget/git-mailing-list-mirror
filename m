From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH 2/3] tag: fix --sort tests to use cat<<-\EOF format
Date: Fri, 11 Jul 2014 14:38:43 -0700
Message-ID: <1405114724-23829-2-git-send-email-jacob.e.keller@intel.com>
References: <1405114724-23829-1-git-send-email-jacob.e.keller@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 11 23:39:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5iX8-0004kg-Rh
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 23:39:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752378AbaGKVjG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 17:39:06 -0400
Received: from mga01.intel.com ([192.55.52.88]:63326 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751856AbaGKVjE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 17:39:04 -0400
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP; 11 Jul 2014 14:38:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,645,1400050800"; 
   d="scan'208";a="560695201"
Received: from jekeller-desk1.jf.intel.com (HELO jekeller-desk1.amr.corp.intel.com) ([134.134.173.156])
  by fmsmga001.fm.intel.com with ESMTP; 11 Jul 2014 14:38:48 -0700
X-Mailer: git-send-email 2.0.1.475.g9b8d714
In-Reply-To: <1405114724-23829-1-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253328>

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
