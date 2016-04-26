From: Xiaolong Ye <xiaolong.ye@intel.com>
Subject: [PATCH v6 1/4] patch-ids: make commit_patch_id() a public helper function
Date: Tue, 26 Apr 2016 15:51:21 +0800
Message-ID: <1461657084-9223-2-git-send-email-xiaolong.ye@intel.com>
References: <1461657084-9223-1-git-send-email-xiaolong.ye@intel.com>
Cc: fengguang.wu@intel.com, ying.huang@intel.com, philip.li@intel.com,
	julie.du@intel.com, Xiaolong Ye <xiaolong.ye@intel.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 09:52:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auxnZ-0007zh-JZ
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 09:52:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752483AbcDZHwh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 03:52:37 -0400
Received: from mga09.intel.com ([134.134.136.24]:45363 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752324AbcDZHwg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 03:52:36 -0400
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP; 26 Apr 2016 00:52:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,536,1455004800"; 
   d="scan'208";a="962812047"
Received: from yexl-desktop.sh.intel.com ([10.239.159.139])
  by orsmga002.jf.intel.com with ESMTP; 26 Apr 2016 00:52:34 -0700
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1461657084-9223-1-git-send-email-xiaolong.ye@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292593>

Make commit_patch_id() available to other builtins.

Signed-off-by: Xiaolong Ye <xiaolong.ye@intel.com>
---
 patch-ids.c | 2 +-
 patch-ids.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/patch-ids.c b/patch-ids.c
index b7b3e5a..a4d0016 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -4,7 +4,7 @@
 #include "sha1-lookup.h"
 #include "patch-ids.h"
 
-static int commit_patch_id(struct commit *commit, struct diff_options *options,
+int commit_patch_id(struct commit *commit, struct diff_options *options,
 		    unsigned char *sha1)
 {
 	if (commit->parents)
diff --git a/patch-ids.h b/patch-ids.h
index c8c7ca1..eeb56b3 100644
--- a/patch-ids.h
+++ b/patch-ids.h
@@ -13,6 +13,8 @@ struct patch_ids {
 	struct patch_id_bucket *patches;
 };
 
+int commit_patch_id(struct commit *commit, struct diff_options *options,
+		    unsigned char *sha1);
 int init_patch_ids(struct patch_ids *);
 int free_patch_ids(struct patch_ids *);
 struct patch_id *add_commit_patch_id(struct commit *, struct patch_ids *);
-- 
2.8.1.343.gda643e5
