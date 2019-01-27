Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F4741F453
	for <e@80x24.org>; Sun, 27 Jan 2019 19:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbfA0Toh (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Jan 2019 14:44:37 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:44220 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbfA0Tog (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jan 2019 14:44:36 -0500
Received: by mail-pl1-f201.google.com with SMTP id b24so10233057pls.11
        for <git@vger.kernel.org>; Sun, 27 Jan 2019 11:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jHgC/objxk+ZaFKXZ0Ouk5mjEPMOghW/siqZWVSdiHM=;
        b=BivzZpnTZPYnU/gBAT7OBAwlvQx0nqdotSXjNj9fyoLOcndzhxxLdUjUrkndShIAFZ
         SpZeqn0EQJrdPK9UW7uHsrl/RQAh2cWsGKXUDz4tO3T2DQhBBeweYDfHWSnyDsLLG3TQ
         hmbVk7xHa9Jqv3HztvdIDHZBAZLr6XyJiwvDftMgQBEOp/z/dPgmgHKBwubifT0JA6V/
         /DqtrKH/DGXNIZBc7x0OkMSvloeU5hxd7jxETrROoqutNf/zrLz87J8v1mGIJIzHboDi
         k7Avp3LpUpUqAiXqywa55PBRAzB3xqcUYn0GGMk/qBSRjHgpp6HN15/OtGQJtXUQkVO+
         JI9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jHgC/objxk+ZaFKXZ0Ouk5mjEPMOghW/siqZWVSdiHM=;
        b=k8KG5bBEhT4K9leLy7Wamj/V2DMjlq9d9wGSxZIKgZhL64/CktiWUKge2AGHIHzzxv
         3tKrRXvA2sSa4isC7mR3M+W24g3xfsjQ5P5d6PJFetKpfvcVqwD5ALe9aNIJ8ynBHEtm
         P2bzUTiqU9+plKKpqOtXO4Ibz1QnCYLc+jDhYfXTMr6qFas0HKKkP+hnbqzrybUJ5g4q
         lWGlzL+QuKTtxHFYTHknMW1akOQC7kK1GqrlOrDOnuhlcp50BFq5d4dnJ2IsJNpOGSe3
         3iyhHHLrmVIZw3CAqlFIBVjkw08ViKc9X9W29zofiaQvz7nFY98B/zJRg2iehMCM1oK8
         QzCw==
X-Gm-Message-State: AJcUukfs08bP9FdaRdYMxEyVS3rQZ2BbcXEky0uuZWD2lSsam0s9ieaQ
        LUwiKDMC3TCrBN/HeXoClkgbYXo2POWLSCxxJQ2WtlWWs3Xhgfh+VL7Ykk6Ktn+/WvfPkFp3SSQ
        DuYqdBjPodnKazVZ3yLQjE3Ye5qWIdGMjBAaZqFOC60++XXIUaLkaH+r6Lw==
X-Google-Smtp-Source: ALg8bN5X4lvD2MFg6gotJip9SnyvSlAwkf02yyIBsTh4qQR8FWo+1xRshuNnCquZ2CalNf2jMstzunHoOmI=
X-Received: by 2002:a62:860c:: with SMTP id x12mr8405125pfd.39.1548618275728;
 Sun, 27 Jan 2019 11:44:35 -0800 (PST)
Date:   Sun, 27 Jan 2019 11:44:15 -0800
In-Reply-To: <20190127194415.171035-1-sxenos@google.com>
Message-Id: <20190127194415.171035-8-sxenos@google.com>
Mime-Version: 1.0
References: <20190127194415.171035-1-sxenos@google.com>
X-Mailer: git-send-email 2.20.1.495.gaa96b0ce6b-goog
Subject: [PATCH v3 8/8] evolve: Add the git change list command
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

