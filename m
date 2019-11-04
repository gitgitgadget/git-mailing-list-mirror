Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D65A1F454
	for <e@80x24.org>; Mon,  4 Nov 2019 23:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729969AbfKDXl3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 18:41:29 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55950 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729953AbfKDXl3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 18:41:29 -0500
Received: by mail-wm1-f67.google.com with SMTP id m17so9402466wmi.5
        for <git@vger.kernel.org>; Mon, 04 Nov 2019 15:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UDl/QTSc5wivqAu3cifu0MtvONpNgx/V7Cslq7IZ+Zw=;
        b=R4ogTdp/at2wB50CBV0N2QhKAkiVeXGj7QLZVkFr4D/7WAQe29JL+4uph8kOpw8D8W
         WvOoKmcDIFboXnl9JT31b+/hhi/OEe4dbwZmM0P9WlH1tB/lzPKKoFRrXSXecya14FjJ
         bpDr3ls3VMyDjhCUAClwpiEhuSoDTZWHEOGyr+up5/sXsRKK83SqBosSa/dhVXETn+gl
         OU7iCPdQWuAb75enp8w+e7neisfaaByFaXJMrPHtN5+g/dyot0OJWMm6w8GYbl1ZmQ9k
         juxicziOD+HJIetiQiwjWW7ec0gIo2MWmkAciqMsu9mk2x89cj0jsgVfUmUgtOjr72LA
         BaDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UDl/QTSc5wivqAu3cifu0MtvONpNgx/V7Cslq7IZ+Zw=;
        b=inPTblBzBFWWggg3ijF0x6VhvJ9n6qPrwYt89/ys/0QIm+NBeZiTli87Cpg351boTq
         6b8RvaVEADgM/6IpF7daWj9H5SjIyFQGvSSD+amPDcHWZ1XshXzl+RRnwyRp8dvolX/S
         6YbqTd8PcZ/WPDWcB/h6IpKgbLX7e5wy5rtnvplqiNBBpsL4SHsLgrmDYTolG1yvpxPW
         OtJpWxh5XbSRXcH9LIu3KYBVnhaeFQhjYKa5mRN29Ng55WE0Wq7uPp46gAPTGxVFh74e
         NnpGo1yyyoXgdT2lrEeD6RjDPE7CLkGFzMCMEcL0NfZ0oo7vIJOjAph+eqeii29EO37o
         ihIA==
X-Gm-Message-State: APjAAAUnLwrO1cYnozbKO4TexnHjc+uyMf92Syq5J8h3Kd8w0DzTMMyP
        duSxkbG4N9A8LhKJfoAmWJ4wR5kk
X-Google-Smtp-Source: APXvYqzE2+xCPUpMGhyPXRdkROmRK1whF2TlLJPiUjVSknGMt0SHmTNRYsARkRXx7mTuvXxw9zQXWQ==
X-Received: by 2002:a7b:ca51:: with SMTP id m17mr1293942wml.110.1572910887357;
        Mon, 04 Nov 2019 15:41:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q14sm24866422wre.27.2019.11.04.15.41.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 15:41:27 -0800 (PST)
Message-Id: <f76ba554ed25fb9877a223ef6481834f1831c8ca.1572910885.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.446.git.1572910885.gitgitgadget@gmail.com>
References: <pull.446.git.1572910885.gitgitgadget@gmail.com>
From:   "Utsav Shah via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 04 Nov 2019 23:41:25 +0000
Subject: [PATCH 1/1] unpack-trees: skip stat on fsmonitor-valid files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Utsav Shah <ukshah2@illinois.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Utsav Shah <utsav@dropbox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Utsav Shah <utsav@dropbox.com>

The index might be aware that a file hasn't modified via fsmonitor, but
unpack-trees did not pay attention to it and checked via ie_match_stat
which can be inefficient on certain filesystems. This significantly slows
down commands that run oneway_merge, like checkout and reset --hard.

This patch makes oneway_merge check whether a file is considered
unchanged through fsmonitor and skips ie_match_stat on it. unpack-trees
also now correctly copies over fsmonitor validity state from the source
index. Finally, for correctness, we force a refresh of fsmonitor state in
tweak_fsmonitor.

After this change, commands like stash (that use reset --hard
internally) go from 8s or more to ~2s on a 250k file repository on a
mac.

Signed-off-by: Utsav Shah <utsav@dropbox.com>
---
 fsmonitor.c                       | 20 +++++++++++---------
 t/t7113-post-index-change-hook.sh |  3 ---
 t/t7519-status-fsmonitor.sh       |  9 +++++++--
 unpack-trees.c                    |  6 +++++-
 4 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index 1f4aa1b150..4362bc6ee9 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -55,9 +55,10 @@ int read_fsmonitor_extension(struct index_state *istate, const void *data,
 	}
 	istate->fsmonitor_dirty = fsmonitor_dirty;
 
-	if (istate->fsmonitor_dirty->bit_size > istate->cache_nr)
-		BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %u)",
-		    (uintmax_t)istate->fsmonitor_dirty->bit_size, istate->cache_nr);
+	if (!istate->split_index && istate->fsmonitor_dirty->bit_size > istate->cache_nr)
+		BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %"PRIuMAX")",
+		    (uintmax_t)istate->fsmonitor_dirty->bit_size, (uintmax_t)istate->cache_nr);
+
 
 	trace_printf_key(&trace_fsmonitor, "read fsmonitor extension successful");
 	return 0;
@@ -83,9 +84,9 @@ void write_fsmonitor_extension(struct strbuf *sb, struct index_state *istate)
 	uint32_t ewah_size = 0;
 	int fixup = 0;
 
-	if (istate->fsmonitor_dirty->bit_size > istate->cache_nr)
-		BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %u)",
-		    (uintmax_t)istate->fsmonitor_dirty->bit_size, istate->cache_nr);
+	if (!istate->split_index && istate->fsmonitor_dirty->bit_size > istate->cache_nr)
+		BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %"PRIuMAX")",
+		    (uintmax_t)istate->fsmonitor_dirty->bit_size, (uintmax_t)istate->cache_nr);
 
 	put_be32(&hdr_version, INDEX_EXTENSION_VERSION);
 	strbuf_add(sb, &hdr_version, sizeof(uint32_t));
@@ -189,6 +190,9 @@ void refresh_fsmonitor(struct index_state *istate)
 		}
 		if (bol < query_result.len)
 			fsmonitor_refresh_callback(istate, buf + bol);
+
+		if (istate->untracked)
+			istate->untracked->use_fsmonitor = 1;
 	} else {
 		/* Mark all entries invalid */
 		for (i = 0; i < istate->cache_nr; i++)
@@ -257,9 +261,7 @@ void tweak_fsmonitor(struct index_state *istate)
 				    (uintmax_t)istate->fsmonitor_dirty->bit_size, istate->cache_nr);
 			ewah_each_bit(istate->fsmonitor_dirty, fsmonitor_ewah_callback, istate);
 
-			/* Now mark the untracked cache for fsmonitor usage */
-			if (istate->untracked)
-				istate->untracked->use_fsmonitor = 1;
+			refresh_fsmonitor(istate);
 		}
 
 		ewah_free(istate->fsmonitor_dirty);
diff --git a/t/t7113-post-index-change-hook.sh b/t/t7113-post-index-change-hook.sh
index f011ad7eec..5ca2279d0d 100755
--- a/t/t7113-post-index-change-hook.sh
+++ b/t/t7113-post-index-change-hook.sh
@@ -50,9 +50,6 @@ test_expect_success 'test status, add, commit, others trigger hook without flags
 	git checkout -- dir1/file1.txt &&
 	test_path_is_file testsuccess && rm -f testsuccess &&
 	test_path_is_missing testfailure &&
-	git update-index &&
-	test_path_is_missing testsuccess &&
-	test_path_is_missing testfailure &&
 	git reset --soft &&
 	test_path_is_missing testsuccess &&
 	test_path_is_missing testfailure
diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index d8df990972..9cac3d3d8e 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -106,6 +106,8 @@ EOF
 
 # test that "update-index --fsmonitor-valid" sets the fsmonitor valid bit
 test_expect_success 'update-index --fsmonitor-valid" sets the fsmonitor valid bit' '
+	write_script .git/hooks/fsmonitor-test<<-\EOF &&
+	EOF
 	git update-index --fsmonitor &&
 	git update-index --fsmonitor-valid dir1/modified &&
 	git update-index --fsmonitor-valid dir2/modified &&
@@ -164,6 +166,8 @@ EOF
 
 # test that newly added files are marked valid
 test_expect_success 'newly added files are marked valid' '
+	write_script .git/hooks/fsmonitor-test<<-\EOF &&
+	EOF
 	git add new &&
 	git add dir1/new &&
 	git add dir2/new &&
@@ -218,11 +222,12 @@ test_expect_success '*only* files returned by the integration script get flagged
 # Ensure commands that call refresh_index() to move the index back in time
 # properly invalidate the fsmonitor cache
 test_expect_success 'refresh_index() invalidates fsmonitor cache' '
-	write_script .git/hooks/fsmonitor-test<<-\EOF &&
-	EOF
 	clean_repo &&
+	write_integration_script &&
 	dirty_repo &&
 	git add . &&
+	write_script .git/hooks/fsmonitor-test<<-\EOF &&
+	EOF
 	git commit -m "to reset" &&
 	git reset HEAD~1 &&
 	git status >actual &&
diff --git a/unpack-trees.c b/unpack-trees.c
index 33ea7810d8..fc5ceb932c 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1504,6 +1504,9 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	o->merge_size = len;
 	mark_all_ce_unused(o->src_index);
 
+	if (o->src_index->fsmonitor_last_update)
+		o->result.fsmonitor_last_update = o->src_index->fsmonitor_last_update;
+
 	/*
 	 * Sparse checkout loop #1: set NEW_SKIP_WORKTREE on existing entries
 	 */
@@ -2384,7 +2387,8 @@ int oneway_merge(const struct cache_entry * const *src,
 
 	if (old && same(old, a)) {
 		int update = 0;
-		if (o->reset && o->update && !ce_uptodate(old) && !ce_skip_worktree(old)) {
+		if (o->reset && o->update && !ce_uptodate(old) && !ce_skip_worktree(old) &&
+			!(old->ce_flags & CE_FSMONITOR_VALID)) {
 			struct stat st;
 			if (lstat(old->name, &st) ||
 			    ie_match_stat(o->src_index, old, &st, CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE))
-- 
gitgitgadget
