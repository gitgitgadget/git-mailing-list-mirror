Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5E6520248
	for <e@80x24.org>; Fri, 29 Mar 2019 21:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730142AbfC2Vji (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 17:39:38 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:51745 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729771AbfC2Vjh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 17:39:37 -0400
Received: by mail-pf1-f201.google.com with SMTP id v76so1293451pfa.18
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 14:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VNvrZLGhpPFyTCT+DiuVy3sDxvyT+oiA9jHkUVu/Rdo=;
        b=ntPoFWcPSC2YSpqlVuArueyby4+Q7r2AUZqImVbXnZwoO8WQFjoGT+FJ/hXJYDgt2f
         iGHXxCoyemdyPqCQoJ8wK6HmGCOhOXTCxCe2dTCgqFWVv9czpYzBWcQjO3MyORz+AYrG
         9mlAZdqptrWkbqIUkTqs1Z5Tlq699MMlz6JMlqlEMi8fHNzGkBiS9aVY29e+PtCmGBF2
         U2L+HlbRX5/ZBJLSf+vHs9yxq3sBItBlG+uttiniPz+3CSCLZf2JMuL2RNf+3eZcbj/9
         PqLMS4T0keX8jCE8BHj1SuSog3B8lJkJ0pVZF2OquuijDznrYriRWU+n0PEdo+wC4pYf
         3Bbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VNvrZLGhpPFyTCT+DiuVy3sDxvyT+oiA9jHkUVu/Rdo=;
        b=rgSE648OL2UyZl8+txZU8yZzEICoudcl54OYZghKJtUiPfKi+B+F0SosJDIcqK983P
         d22dr7FRqEOcNm1GEkxPXvyGuzbz1/c8FhdBSCZtEaczHFDnvavKSFPm4ik3pExwaRVk
         QPiXHb4UnlyqXXilQAZwFFKra1Ss94NCJ15o3QgkXCuc462K+RhJPfNpjLT6s67IgUfO
         tFCZ/6YSQRSnAj2e4vg9rxrYR69ffGu+UbJMsRuW7rlBj3urHj3hyWU7tg/WDcHmMGu7
         tQllo28Emgzc4YuoCC9YuTcGCfMc3UvY4XebTdqr7jYCWDvq6f/0Gk5nQRklSBM0OmHs
         PwNw==
X-Gm-Message-State: APjAAAULfNx8UCFJb1lLTc5nxNt1WSwwonghSSE/8/bg44/aLT6KRzbC
        yZ2oeBDRUGEHLOXIud+qGEmtAZQlR2bRP6MqwprLC5Z1gEYgwWrQ17+ChtegzWyGnIEHM3UyLIK
        Yb8L5pjmpjn7GddIHBWlAxMwMIsfGMdYV3Umk2n8ozaaEIOXZoDeYO2xKnAtgWNJJcIUPO5XAJ2
        gt
X-Google-Smtp-Source: APXvYqxZZ0jILPXI5X0oiPhHwdfL8VwHvIejtzlSk6YbXIBqiiE55IQyDybnBqa8ODTl2VmlkSVXMIdG8HgBY/H5xj27
X-Received: by 2002:a17:902:6687:: with SMTP id e7mr1304309plk.149.1553895576697;
 Fri, 29 Mar 2019 14:39:36 -0700 (PDT)
Date:   Fri, 29 Mar 2019 14:39:28 -0700
In-Reply-To: <cover.1553895166.git.jonathantanmy@google.com>
Message-Id: <44de02e584f449481e6fb00cf35d74adf0192e9d.1553895166.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20190326220906.111879-1-jonathantanmy@google.com> <cover.1553895166.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.21.0.197.gd478713db0
Subject: [PATCH v2 2/2] diff: batch fetching of missing blobs
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        Johannes.Schindelin@gmx.de, szeder.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When running a command like "git show" or "git diff" in a partial clone,
batch all missing blobs to be fetched as one request.

This is similar to c0c578b33c ("unpack-trees: batch fetching of missing
blobs", 2017-12-08), but for another command.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 diff.c                        |  32 +++++++++++
 t/t4067-diff-partial-clone.sh | 103 ++++++++++++++++++++++++++++++++++
 2 files changed, 135 insertions(+)
 create mode 100755 t/t4067-diff-partial-clone.sh

diff --git a/diff.c b/diff.c
index ec5c095199..1eccefb4ef 100644
--- a/diff.c
+++ b/diff.c
@@ -25,6 +25,7 @@
 #include "packfile.h"
 #include "parse-options.h"
 #include "help.h"
+#include "fetch-object.h"
 
 #ifdef NO_FAST_WORKING_DIRECTORY
 #define FAST_WORKING_DIRECTORY 0
@@ -6366,8 +6367,39 @@ void diffcore_fix_diff_index(void)
 	QSORT(q->queue, q->nr, diffnamecmp);
 }
 
+static void add_if_missing(struct oid_array *to_fetch,
+			   const struct diff_filespec *filespec)
+{
+	if (filespec && filespec->oid_valid &&
+	    oid_object_info_extended(the_repository, &filespec->oid, NULL,
+				     OBJECT_INFO_FOR_PREFETCH))
+		oid_array_append(to_fetch, &filespec->oid);
+}
+
 void diffcore_std(struct diff_options *options)
 {
+	if (repository_format_partial_clone) {
+		/*
+		 * Prefetch the diff pairs that are about to be flushed.
+		 */
+		int i;
+		struct diff_queue_struct *q = &diff_queued_diff;
+		struct oid_array to_fetch = OID_ARRAY_INIT;
+
+		for (i = 0; i < q->nr; i++) {
+			struct diff_filepair *p = q->queue[i];
+			add_if_missing(&to_fetch, p->one);
+			add_if_missing(&to_fetch, p->two);
+		}
+		if (to_fetch.nr)
+			/*
+			 * NEEDSWORK: Consider deduplicating the OIDs sent.
+			 */
+			fetch_objects(repository_format_partial_clone,
+				      to_fetch.oid, to_fetch.nr);
+		oid_array_clear(&to_fetch);
+	}
+
 	/* NOTE please keep the following in sync with diff_tree_combined() */
 	if (options->skip_stat_unmatch)
 		diffcore_skip_stat_unmatch(options);
diff --git a/t/t4067-diff-partial-clone.sh b/t/t4067-diff-partial-clone.sh
new file mode 100755
index 0000000000..349851be7d
--- /dev/null
+++ b/t/t4067-diff-partial-clone.sh
@@ -0,0 +1,103 @@
+#!/bin/sh
+
+test_description='behavior of diff when reading objects in a partial clone'
+
+. ./test-lib.sh
+
+test_expect_success 'git show batches blobs' '
+	test_when_finished "rm -rf server client trace" &&
+	
+	test_create_repo server &&
+	echo a >server/a &&
+	echo b >server/b &&
+	git -C server add a b &&
+	git -C server commit -m x &&
+
+	test_config -C server uploadpack.allowfilter 1 &&
+	test_config -C server uploadpack.allowanysha1inwant 1 &&
+	git clone --bare --filter=blob:limit=0 "file://$(pwd)/server" client &&
+
+	# Ensure that there is exactly 1 negotiation by checking that there is
+	# only 1 "done" line sent. ("done" marks the end of negotiation.)
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client show HEAD &&
+	grep "git> done" trace >done_lines &&
+	test_line_count = 1 done_lines
+'
+
+test_expect_success 'diff batches blobs' '
+	test_when_finished "rm -rf server client trace" &&
+
+	test_create_repo server &&
+	echo a >server/a &&
+	echo b >server/b &&
+	git -C server add a b &&
+	git -C server commit -m x &&
+	echo c >server/c &&
+	echo d >server/d &&
+	git -C server add c d &&
+	git -C server commit -m x &&
+
+	test_config -C server uploadpack.allowfilter 1 &&
+	test_config -C server uploadpack.allowanysha1inwant 1 &&
+	git clone --bare --filter=blob:limit=0 "file://$(pwd)/server" client &&
+
+	# Ensure that there is exactly 1 negotiation by checking that there is
+	# only 1 "done" line sent. ("done" marks the end of negotiation.)
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client diff HEAD^ HEAD &&
+	grep "git> done" trace >done_lines &&
+	test_line_count = 1 done_lines
+'
+
+test_expect_success 'diff skips same-OID blobs' '
+	test_when_finished "rm -rf server client trace" &&
+
+	test_create_repo server &&
+	echo a >server/a &&
+	echo b >server/b &&
+	git -C server add a b &&
+	git -C server commit -m x &&
+	echo another-a >server/a &&
+	git -C server add a &&
+	git -C server commit -m x &&
+
+	test_config -C server uploadpack.allowfilter 1 &&
+	test_config -C server uploadpack.allowanysha1inwant 1 &&
+	git clone --bare --filter=blob:limit=0 "file://$(pwd)/server" client &&
+
+	echo a | git hash-object --stdin >hash-old-a &&
+	echo another-a | git hash-object --stdin >hash-new-a &&
+	echo b | git hash-object --stdin >hash-b &&
+
+	# Ensure that only a and another-a are fetched.
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client diff HEAD^ HEAD &&
+	grep "want $(cat hash-old-a)" trace &&
+	grep "want $(cat hash-new-a)" trace &&
+	! grep "want $(cat hash-b)" trace
+'
+
+test_expect_success 'diff with rename detection batches blobs' '
+	test_when_finished "rm -rf server client trace" &&
+
+	test_create_repo server &&
+	echo a >server/a &&
+	printf "b\nb\nb\nb\nb\n" >server/b &&
+	git -C server add a b &&
+	git -C server commit -m x &&
+	rm server/b &&
+	printf "b\nb\nb\nb\nbX\n" >server/c &&
+	git -C server add c &&
+	git -C server commit -a -m x &&
+
+	test_config -C server uploadpack.allowfilter 1 &&
+	test_config -C server uploadpack.allowanysha1inwant 1 &&
+	git clone --bare --filter=blob:limit=0 "file://$(pwd)/server" client &&
+
+	# Ensure that there is exactly 1 negotiation by checking that there is
+	# only 1 "done" line sent. ("done" marks the end of negotiation.)
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client diff -M HEAD^ HEAD >out &&
+	grep "similarity index" out &&
+	grep "git> done" trace >done_lines &&
+	test_line_count = 1 done_lines
+'
+
+test_done
-- 
2.21.0.197.gd478713db0

