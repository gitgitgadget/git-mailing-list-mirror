Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B11131F45F
	for <e@80x24.org>; Tue,  7 May 2019 11:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfEGLKh (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 07:10:37 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34172 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfEGLKf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 07:10:35 -0400
Received: by mail-wm1-f68.google.com with SMTP id m20so7536531wmg.1
        for <git@vger.kernel.org>; Tue, 07 May 2019 04:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fi1MRes8xG2MpgWAWGY8AUAG26rheJ1uLYAwixIjeDY=;
        b=QHohVY6X1ChwmL+4Itd5pK/rYpG+1sZGYQEN7zojrwe5zaP/QnmMPOfKWTFMwm8eN2
         43t2bnCBGjQYgUaCd7J8TQswdoXRQ9SB8akP0KoXJ2ZFdipjicQD5m7gouu4VkngO1bn
         O8+mlv5+3p/CRMflMAenJ2ZuqAYhWtAsbsY8fQLKJAYNOlPY+gdlzO+dSJVU+NIyuLxG
         q02tHlnIs6VKavzcVN4SrLAHFs5B9vlRM/E6fx5Z3G2wwYvZpuzX4aIDEyS5+c722yfl
         YQyD7eJq3whEgsZGLsAwCNJdqfFlJbs/kJ1WOAEDs3B9m4YfszGToA7K7WbOlXJZFFf9
         1X8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fi1MRes8xG2MpgWAWGY8AUAG26rheJ1uLYAwixIjeDY=;
        b=AuRWz39akoNDfyH0HFplLqZyuVKB4vJNimNUoZcvXFR1mdhOUC2qk3g2WmHTpB6aaz
         +jgXlgvEGMIPkd+Sy4zRc2Ch+V6dQjnNxWpCgm1jGap9gzhxMTu0+WAx2LpVAJcWrGsP
         vC8mIQZ4gcUWvb/ze8D24jmSDBQ8MjP/zTrDfOrXfrZNyYFu7X8Zmge0cEW1TmFnfsNd
         +1Rd2n7kFMfcDi04fMvJ1t8guee0ucCxcxKVXGD4FuZB1L4qhw/PFyeJ5ZO9EFGKgn8F
         Rw1FdvdRlojKTxK2fi3/FyzI/2CAOgeBbAjhlgUw6irhEw0Qm4G6Ii+htrzXcRx/OelY
         x4OA==
X-Gm-Message-State: APjAAAUR8ufSB3ZmicOVphG3Q0MOn6LBo3DA73MrC9fYN+pHUlIVb9V2
        4M+eR7BcThztR6ip8xBcM7ZklLDf4XU=
X-Google-Smtp-Source: APXvYqxRx9Crd07hB2Uvwjvt1YC4mLYf1qa/kQeC3FLZvF0sq6kUo1NwCrUHJfxi5aIVcm5KZ4ZYUA==
X-Received: by 2002:a05:600c:3cb:: with SMTP id z11mr9332832wmd.140.1557227433464;
        Tue, 07 May 2019 04:10:33 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d14sm11246108wre.78.2019.05.07.04.10.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 07 May 2019 04:10:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 1/2] fsmonitor: demonstrate that it is not refreshed after discard_index()
Date:   Tue,  7 May 2019 13:10:20 +0200
Message-Id: <20190507111021.12840-2-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18
In-Reply-To: <pull.165.v2.git.gitgitgadget@gmail.com>
References: <pull.165.v2.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This one is tricky.

When `core.fsmonitor` is set, a `refresh_index()` will not perform a
full scan of files that might be modified, but will query the fsmonitor
and refresh only the ones that have been actually touched.

Due to implementation details, the fsmonitor is queried in
`refresh_cache_ent()`, but of course it only has to be queried once, so
we set a flag when we did that. But when the index was discarded, we did
not re-set that flag.

So far, this is only covered by our test suite when running with
GIT_TEST_FSMONITOR=$PWD/t7519/fsmonitor-all, and only due to the way the
built-in stash interacts with the recursive merge machinery.

Let's introduce a straight-forward regression test for this.

We simply extend the "read & discard index" loop in `test-tool
read-cache` to optionally refresh the index, report on a given file's
status, and then modify that file. Due to the bug described above, only
the first refresh will actually query the fsmonitor; subsequent loop
iterations will not.

This problem was reported by Ævar Arnfjörð Bjarmason.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/helper/test-read-cache.c  | 24 +++++++++++++++++++++++-
 t/t7519-status-fsmonitor.sh |  8 ++++++++
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/t/helper/test-read-cache.c b/t/helper/test-read-cache.c
index d674c88ba0..7e79b555de 100644
--- a/t/helper/test-read-cache.c
+++ b/t/helper/test-read-cache.c
@@ -1,14 +1,36 @@
 #include "test-tool.h"
 #include "cache.h"
+#include "config.h"
 
 int cmd__read_cache(int argc, const char **argv)
 {
-	int i, cnt = 1;
+	int i, cnt = 1, namelen;
+	const char *name = NULL;
+
+	if (argc > 1 && skip_prefix(argv[1], "--print-and-refresh=", &name)) {
+		namelen = strlen(name);
+		argc--;
+		argv++;
+	}
+
 	if (argc == 2)
 		cnt = strtol(argv[1], NULL, 0);
 	setup_git_directory();
+	git_config(git_default_config, NULL);
 	for (i = 0; i < cnt; i++) {
 		read_cache();
+		if (name) {
+			int pos;
+
+			refresh_index(&the_index, REFRESH_QUIET,
+				      NULL, NULL, NULL);
+			pos = index_name_pos(&the_index, name, namelen);
+			if (pos < 0)
+				die("%s not in index", name);
+			printf("%s is%s up to date\n", name,
+			       ce_uptodate(the_index.cache[pos]) ? "" : " not");
+			write_file(name, "%d\n", i);
+		}
 		discard_cache();
 	}
 	return 0;
diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index 3e0a61db23..afd8fa7532 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -346,4 +346,12 @@ test_expect_success UNTRACKED_CACHE 'ignore .git changes when invalidating UNTR'
 	test_cmp before after
 '
 
+test_expect_failure 'discard_index() also discards fsmonitor info' '
+	test_config core.fsmonitor "$TEST_DIRECTORY/t7519/fsmonitor-all" &&
+	test_might_fail git update-index --refresh &&
+	test-tool read-cache --print-and-refresh=tracked 2 >actual &&
+	printf "tracked is%s up to date\n" "" " not" >expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.21.0.593.g511ec345e18

