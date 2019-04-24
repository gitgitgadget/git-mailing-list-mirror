Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D91E01F453
	for <e@80x24.org>; Wed, 24 Apr 2019 21:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730562AbfDXVWd (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 17:22:33 -0400
Received: from mga14.intel.com ([192.55.52.115]:33353 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbfDXVWd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 17:22:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Apr 2019 14:22:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,390,1549958400"; 
   d="scan'208";a="340507216"
Received: from vverma7-desk1.lm.intel.com ([10.232.112.185])
  by fmsmga006.fm.intel.com with ESMTP; 24 Apr 2019 14:22:33 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH] Documentation/merge-options: clarify --squash behavior
Date:   Wed, 24 Apr 2019 15:22:12 -0600
Message-Id: <20190424212212.10039-1-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a note to the --squash option for git-merge to clarify its behavior
with respect to --commit. When --squash is supplied, 'option_commit' is
silently dropped. This can be surprising to a user who tries to override
the no-commit behavior of squash using --commit explicitly.

Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---

There may be an argument to make --commit 'just work' with squash, but
that might involve changing option_commit from OPT_BOOL to something
that can distinguish between the default, what's requested on the
command line, or the --no- version.

 Documentation/merge-options.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 92a7d936c1..0fd97720d8 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -95,6 +95,9 @@ merge.
 +
 With --no-squash perform the merge and commit the result. This
 option can be used to override --squash.
++
+With --squash, a --commit option does not make sense, and will be ignored
+(HEAD will not be moved in spite of --commit).
 
 -s <strategy>::
 --strategy=<strategy>::
-- 
2.20.1

