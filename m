Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BD1A20248
	for <e@80x24.org>; Sat, 16 Mar 2019 09:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfCPJtJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Mar 2019 05:49:09 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41210 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfCPJtJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Mar 2019 05:49:09 -0400
Received: by mail-ed1-f68.google.com with SMTP id a25so2381319edc.8
        for <git@vger.kernel.org>; Sat, 16 Mar 2019 02:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:mime-version
         :content-transfer-encoding:fcc:content-transfer-encoding:to:cc;
        bh=qwR0KLqxg7h1WadVbWudj5IsygqBpmHAmss4CehjvS8=;
        b=XKPDwVtz13DfvR7tIlQVh3IGe9jG/e8A/PkaSUw3upId1aVl+9OtcFMPvQRx+BZSBs
         xLvpNCP14V98qMoCbELwX5FMITL4XV9qSCwKRhQDmPvEt73Sced7qQnndG/u2L0u19x7
         /Vwdm4L9EYgdWFp+j696sgOnC5VSJOuanQk3mNCStgKTvsoYLNk94qGxAu/Sb8Wav3Ah
         LBYicfF/x0gu+/XsIyJuI1WnVS6rxglJvlf+28QQzmtIFOoqVQqhAh0zXHUd3Uk2uwmp
         DDdw4I57hwun1klS+TvkzqUUWmrdlsT2MUeGCbJqlPpNZUFREUVzhncIklzkrjQ9PCje
         45nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:mime-version:content-transfer-encoding:fcc
         :content-transfer-encoding:to:cc;
        bh=qwR0KLqxg7h1WadVbWudj5IsygqBpmHAmss4CehjvS8=;
        b=kvBdxx8cjj6Ntkpiv3UnXXhe/vzVQ7nBof1VsQT6q2iMcYyKDRqtU7GaAEHyH4MavZ
         7K++pQsrddyHRoBKmysYhcXh9Agu3ItNWNFO0GZSujfn+fpyZTNXwblPogLV8THxy8mO
         QUl7g71G+gJx9qkveRzI+AFi2aIMBgjeo/SJv1GtT35U1GxBzgmRYx8288HPh0lfCxpN
         ZwJWhdNFydAKBCk/dHUeUX8tMUL5Wlh44F38a6KfUzdZz+LQd+xtxyp6IYukJdB8/BEs
         oCzV5mYkcRbW1HlNKTTaetZ1UDGA2o2ajnQrlOUcVNXGcp7Cr14tb3+czfFdWuGUVXLj
         U1VA==
X-Gm-Message-State: APjAAAVrfc9ayFt30DjXCx+b7TmvrkADbl/n8YITBq2AhxN5Fnidp+VI
        mx3zYGI29adXKQ+toiRTXrbR4anF
X-Google-Smtp-Source: APXvYqx2+5jxegrN6gsm45E1oJGC86yhBh6jUCOPLghZLmGQd7XnM4R3teUPJcdPEnOXp2d/I8caLA==
X-Received: by 2002:a50:9863:: with SMTP id h32mr5978471edb.291.1552729747135;
        Sat, 16 Mar 2019 02:49:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l26sm945383eja.29.2019.03.16.02.49.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Mar 2019 02:49:06 -0700 (PDT)
Date:   Sat, 16 Mar 2019 02:49:06 -0700 (PDT)
X-Google-Original-Date: Sat, 16 Mar 2019 09:49:04 GMT
Message-Id: <f451752656ea5d1e9898e5fa0b2d41de6550781b.1552729745.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.165.git.gitgitgadget@gmail.com>
References: <pull.165.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/2] fsmonitor: demonstrate that it is not refreshed after
 discard_index()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     git@vger.kernel.org
Cc:     Ben Peart <benpeart@microsoft.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
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
 t/t7519-status-fsmonitor.sh | 10 ++++++++++
 2 files changed, 33 insertions(+), 1 deletion(-)

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
index 3e0a61db23..918bc323ab 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -346,4 +346,14 @@ test_expect_success UNTRACKED_CACHE 'ignore .git changes when invalidating UNTR'
 	test_cmp before after
 '
 
+test_expect_failure 'discard_index() also discards fsmonitor info' '
+	test_when_finished \
+		"git config core.monitor .git/hooks/fsmonitor-test" &&
+	test_config core.fsmonitor "$TEST_DIRECTORY/t7519/fsmonitor-all" &&
+	test_might_fail git update-index --refresh &&
+	test-tool read-cache --print-and-refresh=tracked 2 >actual &&
+	printf "tracked is%s up to date\n" "" " not" >expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget

