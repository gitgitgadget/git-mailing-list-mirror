Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45D461F453
	for <e@80x24.org>; Mon, 21 Jan 2019 22:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbfAUWcm (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Jan 2019 17:32:42 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:36761 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727710AbfAUWcl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jan 2019 17:32:41 -0500
Received: by mail-pf1-f202.google.com with SMTP id p9so16839895pfj.3
        for <git@vger.kernel.org>; Mon, 21 Jan 2019 14:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xABvFOVw5vsmWlpYKKg0Rj79uNZp/zFy7PE9X4wpDQw=;
        b=T50pYrgetNYTcJNXQL77+6hwzD0o1yXA4TPY8w8YDtXI1iKzW2Cq9se6VqoRyDYHMt
         486uSVm+p0uHaw3r020QaWQg5jsSnSCOMDVCuVe4ooGxLSO8OinR+nmSVF2cJIYNYide
         Us/r83pqi6SeVMwxPN4Kb/7htCIcy3aaKrbFnDd5Ejw8ThZzYkMbXX00J+0d2osBX4qN
         PFzu5IFOAYdE0385mTSnx7iEbN3rFuoqoBtxGppOoYIlcVrJt+lMuWXHfS8AlMkLUxU9
         uQZKED9vQ75OLwiWwV8B4+j9R92+v9v9Q7JoYqfJzxMNJy2q2q4mPtwyvCRNzyHyAoyw
         gGRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xABvFOVw5vsmWlpYKKg0Rj79uNZp/zFy7PE9X4wpDQw=;
        b=CXOSaFqEbqFZCdCNVJYYEcLrQ0FD+SU6aFMFUfYyv9is3IykVNCsuIQ9Z1GQylMogO
         qfyl25qYPvx61ezJJsaffm1nfo7CzfaHFFEvY1UpY623Gm6PDYdZmrZ4RDUsqk101+QL
         BTI82TXW1z3c3h1Bq/u77VJtIuzrhTbxAA80tLhx621Fkbnpt0oxNfAOOrdj2wvKoMTW
         iEQIT5zMleH6mhOUYje3DZjVkq8kLBMmHZLFCZx+WXpJAAdf7kLkLzCJ1Ro1I0fFRX6+
         HdXN32uUTKQC+3AD4FOg5HhNYiRZsEPHPRlUWHdY5d93xmVRZRpOfxrG131KfQ2fp6E6
         60NQ==
X-Gm-Message-State: AJcUukcCytmqQQRNa+an50YXRPKSo0SODg58Kr3fZvvDQbZcvv1mTRQp
        TmoEcOdVQE4N9nXuKk+GTxgioSdAJ4OeZXuOUZEYvdF7sXni4XnpzIlX2vVJyJPujD7tf3kGRm0
        klhjpn6hw370DYy6uav0JmYU94IuOaB/3I6nkBhLWztPpJxeo50lIU9RB+g==
X-Google-Smtp-Source: ALg8bN7umsvOZfNrNkk2EiGQHrUP7Mc/Jdarwn7BvAZCkcwgR/XM/9wwNuFc+4b2S0U6mIdvElhNAaDE76M=
X-Received: by 2002:a65:46c9:: with SMTP id n9mr4318796pgr.45.1548109959910;
 Mon, 21 Jan 2019 14:32:39 -0800 (PST)
Date:   Mon, 21 Jan 2019 14:32:16 -0800
In-Reply-To: <20190121223216.66659-1-sxenos@google.com>
Message-Id: <20190121223216.66659-8-sxenos@google.com>
Mime-Version: 1.0
References: <20190121223216.66659-1-sxenos@google.com>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce-goog
Subject: [PATCH 8/8] evolve: Add the git change list command
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
2.20.1.321.g9e740568ce-goog

