Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B4001F453
	for <e@80x24.org>; Fri,  1 Feb 2019 03:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbfBADJx (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Jan 2019 22:09:53 -0500
Received: from mail-yw1-f73.google.com ([209.85.161.73]:44916 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfBADJw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 22:09:52 -0500
Received: by mail-yw1-f73.google.com with SMTP id l9so3287781ywl.11
        for <git@vger.kernel.org>; Thu, 31 Jan 2019 19:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EJ6w56MxGJ/XzkBBzxrjhc+5pYLeB79I2hagRTafE28=;
        b=eDH9aKlrN63rI/NU3oj8mf2pCEizrWbi3eUCjDugyErJll093swtO70fpCQwfLuyW4
         1y2VyghHHu6rUpzHPNc9UOupbQMizFWX4ce9UYcqN6uPAMYhgX1vTz2VBG3OxFhdSqGR
         f+47uyXntXkn/Xp/PkFggesYMJLrxZlgMOc5vFP7xyiKKvpXdGUNn3y/9V9K+2k3rDgO
         W3KUPItUMq66Ub7+H+JL3LE4V3G8uBSUVj/hmBLzNQSmXUiibPweXbMR35yhudO0iwse
         Re6aXh5EJsBw7PQjORVplI6urvtukVmasCotaHYRxTCikfpTFGgqHwJjlHnhmCNuXsGB
         tDqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EJ6w56MxGJ/XzkBBzxrjhc+5pYLeB79I2hagRTafE28=;
        b=FnPyBOfzuW9gtoRthmhnzgnzMf7HH6gMPy8Zy8u/MiDb+ETItEXC5iwndcECgyonS4
         RlsyRbJ1KYqBl+hpFgnSKpggfZfNu0deasEZjmFmJDazPf8Y7lX+MuMvSWuGdwqMpXXE
         sP5kMxLlHHYy2sLYbbzP+KjkZA4jj0Z1xyKEQ4AB81N170OI0gSKSq/u38MclflV7xoO
         b8lEQNNxSRufT8prP3kO5Ks/6n2NVoHQqlm3LLmxWX6p+6Jf4Gwp/wP3YliUn/C+1G7s
         6Y/1/GlR0FwzRpvav2mMeQMUMFomcC5NJU+REDXUy0Hn10ykfaKU4RbirsfiGgu2QRRS
         dS8Q==
X-Gm-Message-State: AHQUAuazTFrtJ5hjNp9c8tRPFPX92NG8aUXvNa/7AuOwGHvuPaOHa+KD
        uKJ0SvKWkS0+/PkAA//2+KsOMZM6H2EhsYPUjJJGSlYCcDCwDkgEPD0+Kz5LDVtwiPq4jnYC6VO
        TW3Zo5uT/41h40xZIugPpa0C4dbHfbykgfMxfyt+wS2ml44o7wDGgzIIEZA==
X-Google-Smtp-Source: AHgI3IZsqswlipXEWHBlm+c5stLzcalGbMXchNc/wV/MfwvvgW7pTAJvxnOh2JYWAXzWlZWf5gbf3HL1s1E=
X-Received: by 2002:a25:770f:: with SMTP id s15mr8548775ybc.88.1548990591773;
 Thu, 31 Jan 2019 19:09:51 -0800 (PST)
Date:   Thu, 31 Jan 2019 19:09:25 -0800
In-Reply-To: <20190201030925.177124-1-sxenos@google.com>
Message-Id: <20190201030925.177124-8-sxenos@google.com>
Mime-Version: 1.0
References: <20190201030925.177124-1-sxenos@google.com>
X-Mailer: git-send-email 2.20.1.611.gfbb209baf1-goog
Subject: [PATCH v4 8/8] evolve: add the git change list command
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
 builtin/change.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/builtin/change.c b/builtin/change.c
index 06cbb50679..33a5983bc7 100644
--- a/builtin/change.c
+++ b/builtin/change.c
@@ -5,15 +5,64 @@
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
+	/* TODO: Sorting temporarily disabled. See comments, below.
+	 * struct ref_sorting *sorting = ref_default_sorting(); */
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
+	/* TODO: This causes a crash. It sets one of the atom_value handlers to
+	 * something invalid, which causes a crash later when we call
+	 * show_ref_array_item. Figure out why this happens and put back the sorting.
+	 *ref_array_sort(sorting, &array); */
+
+	if (!format.format)
+		format.format = "%(refname:lstrip=1)";
+
+	if (verify_ref_format(&format))
+		die(_("unable to parse format string"));
+
+	for (i = 0; i < array.nr; i++)
+		show_ref_array_item(array.items[i], &format);
+
+	ref_array_clear(&array);
+
+	return 0;
+}
+
 struct update_state {
 	int options;
 	const char* change;
@@ -164,6 +213,8 @@ int cmd_change(int argc, const char **argv, const char *prefix)
 
 	if (argc < 1)
 		usage_with_options(builtin_change_usage, options);
+	else if (!strcmp(argv[0], "list"))
+		result = change_list(argc, argv, prefix);
 	else if (!strcmp(argv[0], "update"))
 		result = change_update(argc, argv, prefix);
 	else {
-- 
2.20.1.611.gfbb209baf1-goog

