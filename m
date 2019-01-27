Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 165B51F453
	for <e@80x24.org>; Sun, 27 Jan 2019 19:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfA0Tlw (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Jan 2019 14:41:52 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:51304 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfA0Tlu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jan 2019 14:41:50 -0500
Received: by mail-pl1-f202.google.com with SMTP id 12so10233642plb.18
        for <git@vger.kernel.org>; Sun, 27 Jan 2019 11:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jHgC/objxk+ZaFKXZ0Ouk5mjEPMOghW/siqZWVSdiHM=;
        b=ULK8AlbYPr4KyTzKERbGhFH1jno2Ob9mk7qAFCj5TuwTnISQNPnHvCEXb0qtUkzHWn
         brY8pH/oy0MJBgcIZ8iMTkvrPTuarGD03obP7yl4FwHQM6FtZUuWp8XG7JmNyPj6RZ9y
         p8ZBSutgudnjkwZKeCSzvcAiGyIQdb2+BhsMuP9X7PiU4/UB83eRy1yaZPyAPisAVIp8
         +BJKY1006XS5FMxENob0UgJk4DiRe7wMK/ZztTSCXityrfXMD2vACL+5fCCMZ2DpONzR
         ColWhwe6pqrJyVK1r5tKajA1hSnjiLKcV2WZMCf0TWKyCuAdX0e8W3/fHyxeCSWpB745
         Zp1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jHgC/objxk+ZaFKXZ0Ouk5mjEPMOghW/siqZWVSdiHM=;
        b=OPWGYFoFN5W71vA6hPQMMXKuhego6XtjgmO7uqowqBVJYfr6eMA3e4VDVy2NLi+8vY
         xfyP1O7KUHojwPOysgi1RdFiRMoL3PNEdOIga4AS+fs3MzeqzM2/R8sm7Sefo5A2L+/S
         xHWDXZKJWinLiY0ztX6OJcNtCxTj+XV9t9ovW5zQYELUqBsg7IlSGU5cePOREsSiSTEg
         4M7OCwxxGvjzxFIFYotJBE8ZRAZgRzqVkLrlJcILxnNau7sVo2FQaqyzivIzyi9qdPwM
         zb0Ee4zjaGvLI2uP8zL0Mw8+nBEMbB9+4we4mwVWPhOTI0zglBX4E2pcUoHpBUmPP9Dv
         40sQ==
X-Gm-Message-State: AJcUukdF+pZAEap3M5WUvv+PQQLXO4fnBYwrC9wniDEzjkYMBq+3wedr
        kswrTLb6VruqPKzj43ynVzGUXtk4jG/s7aQcwKhqIg9lOxM6V4BBPTQ8DkS5bTn8mGNEoX0udE2
        f7gYhlqG1598ckzem7d4YdUTX/YUCoMSoygbPs/sxG1CGG60iBlO+JaEQMQ==
X-Google-Smtp-Source: ALg8bN6CLyXbhaquO2q9D8TzdbzBhLGm5U+eBDCD8IvU3C8wsT73UgLeS93EngDrZks78zBWi+8WkuND9MU=
X-Received: by 2002:a17:902:8e88:: with SMTP id bg8mr6963308plb.110.1548618110216;
 Sun, 27 Jan 2019 11:41:50 -0800 (PST)
Date:   Sun, 27 Jan 2019 11:41:28 -0800
In-Reply-To: <20190127194128.161250-1-sxenos@google.com>
Message-Id: <20190127194128.161250-8-sxenos@google.com>
Mime-Version: 1.0
References: <20190127194128.161250-1-sxenos@google.com>
X-Mailer: git-send-email 2.20.1.495.gaa96b0ce6b-goog
Subject: [PATCH v2 8/8] evolve: Add the git change list command
From:   sxenos@google.com
To:     git@vger.kernel.org
Cc:     Stefan Xenos <sxenos@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Xenos <sxenos@google.com>

This command lists the ongoing changes from the refs/metas
namespace.

Signed-off-by: Stefan Xenos <sxenos@google.com>
---
 builtin/change.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/builtin/change.c b/builtin/change.c
index ff7eb3b113..b63fe98665 100644
--- a/builtin/change.c
+++ b/builtin/change.c
@@ -5,15 +5,66 @@
 #include "config.h"
 
 static const char * const builtin_change_usage[] = {
+	N_("git change list [<pattern>...]"),
 	N_("git change update [--force] [--replace <treeish>...] [--origin <treesih>...] [--content <newtreeish>]"),
 	NULL
 };
 
+static const char * const builtin_list_usage[] = {
+	N_("git change list [<pattern>...]"),
+	NULL
+};
+
 static const char * const builtin_update_usage[] = {
 	N_("git change update [--force] [--replace <treeish>...] [--origin <treesih>...] [--content <newtreeish>]"),
 	NULL
 };
 
+static int change_list(int argc, const char **argv, const char* prefix)
+{
+	struct option options[] = {
+		OPT_END()
+	};
+	struct ref_filter filter;
+	// TODO: Sorting temporarily disabled. See comments, below.
+	//struct ref_sorting *sorting = ref_default_sorting();
+	struct ref_format format = REF_FORMAT_INIT;
+	struct ref_array array;
+	int i;
+
+	argc = parse_options(argc, argv, prefix, options, builtin_list_usage, 0);
+
+	setup_ref_filter_porcelain_msg();
+
+	memset(&filter, 0, sizeof(filter));
+	memset(&array, 0, sizeof(array));
+
+	filter.kind = FILTER_REFS_CHANGES;
+	filter.name_patterns = argv;
+
+	filter_refs(&array, &filter, FILTER_REFS_CHANGES);
+
+	// TODO: This causes a crash. It sets one of the atom_value handlers to
+	// something invalid, which causes a crash later when we call
+	// show_ref_array_item. Figure out why this happens and put back the sorting.
+	//ref_array_sort(sorting, &array);
+
+	if (!format.format) {
+		format.format = "%(refname:lstrip=1)";
+	}
+
+	if (verify_ref_format(&format))
+		die(_("unable to parse format string"));
+
+	for (i = 0; i < array.nr; i++) {
+		show_ref_array_item(array.items[i], &format);
+	}
+
+	ref_array_clear(&array);
+
+	return 0;
+}
+
 struct update_state {
 	int options;
 	const char* change;
@@ -164,6 +215,8 @@ int cmd_change(int argc, const char **argv, const char *prefix)
 
 	if (argc < 1)
 		usage_with_options(builtin_change_usage, options);
+	else if (!strcmp(argv[0], "list"))
+		result = change_list(argc, argv, prefix);
 	else if (!strcmp(argv[0], "update"))
 		result = change_update(argc, argv, prefix);
 	else {
-- 
2.20.1.495.gaa96b0ce6b-goog

