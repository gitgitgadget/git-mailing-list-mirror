Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17845C433F5
	for <git@archiver.kernel.org>; Wed,  5 Oct 2022 15:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbiJEPBR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Oct 2022 11:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbiJEPAf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2022 11:00:35 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F7A12D20
        for <git@vger.kernel.org>; Wed,  5 Oct 2022 07:59:45 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id bq9so26353221wrb.4
        for <git@vger.kernel.org>; Wed, 05 Oct 2022 07:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=wZ2AaGQrqW1DRy5cNCJr/CPE4guyl6RiVg+ptPx3ksg=;
        b=ZJwnCdoIVeeJ1NbXd9OJzJVnVMJitLbFbBzWgEkW7Lo2zEzDAASOfM5tNj1aH/w763
         anmEordWH8+WSMUX3eJ6LHUOjmYsMPlN65b34nWqGb9xldyHSh58ke/4nZD+KlmMU9sv
         u93EZs573gDVnbj3Js32obnDi69WannmZnHSJQ24d/kJDQM7/b2/iSj+TKNg+CkNYa7s
         opG4+TLNGD8K9oueZXeIPJN4qnBEZ0wPtIW4glOcSp+GL6c9bsClxSLVwqQ369YissPq
         loComiyPbcgIMSqA5VxgZbiFfH1wm5CHH/kknb0cBj43gF/Z7SjaHvHxQrzOlpmG9xRx
         KJig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=wZ2AaGQrqW1DRy5cNCJr/CPE4guyl6RiVg+ptPx3ksg=;
        b=Ufax1gAfcZyvxN0IsUjsZ50sc1vRekdZG0SuaRBHzbmWBMll+ThlBbNAHdFhKXbESP
         m9d4r9JiJx4jMgraLETSYov4nZTY0Iu+ztKDCTSU9o13fiYLm9uJz/s2ng3+Zl1vYGuu
         4zMOj/Aba4OmAQf9H4SCkPbSqG8jULgX0qB4YmADvBybP6bhgoz4dGbwjcyXkWGL+9Zd
         M6WgHVnpB5q0SZqpH/1zjCP33dWpavqJEsUMq9clH/RhYOji9Pab5rSTefYmMyrzp8Pu
         g2wCMauaDicuc2eVaXVix1jg1sTleDq54D1Iw9WUh32gUQ6I+C2x+JoFAMReluJN61Va
         LERQ==
X-Gm-Message-State: ACrzQf22sVyrSP4sOq4WhpkVa8p1OdDVKbNr3aTmLUHqwm1VIty4Gs4u
        sTeTwBGt7TwpcBCAwBolJY3w3c716VI=
X-Google-Smtp-Source: AMsMyM5RFmIoTEJAEVPhC13P1ppttXCmmQ0FtOPciFilibihXeV/uc0gzDTt4+oA+o90bkXcAyCBDg==
X-Received: by 2002:a5d:620b:0:b0:22c:9eb4:d6ed with SMTP id y11-20020a5d620b000000b0022c9eb4d6edmr101830wru.530.1664981968123;
        Wed, 05 Oct 2022 07:59:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t12-20020a05600c198c00b003b4fe03c881sm2199924wmq.48.2022.10.05.07.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 07:59:27 -0700 (PDT)
Message-Id: <a0669fa63a1c3887798d3f8461dc5bd38704c0a0.1664981958.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1356.v2.git.1664981957.gitgitgadget@gmail.com>
References: <pull.1356.git.1663959324.gitgitgadget@gmail.com>
        <pull.1356.v2.git.1664981957.gitgitgadget@gmail.com>
From:   "Chris Poucet via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 05 Oct 2022 14:59:15 +0000
Subject: [PATCH v2 08/10] evolve: add delete command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jerry Zhang <jerry@skydio.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Chris Poucet <poucet@google.com>,
        Christophe Poucet <christophe.poucet@gmail.com>,
        Chris Poucet <poucet@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Chris Poucet <poucet@google.com>

The delete command allows a user to delete one or more changes.
This effectively deletes the corresponding /refs/metas/foo ref.

Signed-off-by: Chris Poucet <poucet@google.com>
---
 builtin/change.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/builtin/change.c b/builtin/change.c
index e4e8e15b768..12ea5f68197 100644
--- a/builtin/change.c
+++ b/builtin/change.c
@@ -3,11 +3,13 @@
 #include "parse-options.h"
 #include "metacommit.h"
 #include "config.h"
+#include "refs.h"
 
 static const char * const builtin_change_usage[] = {
 	N_("git change list [<pattern>...]"),
 	N_("git change update [--force] [--replace <treeish>...] "
 	   "[--origin <treeish>...] [--content <newtreeish>]"),
+	N_("git change delete <change-name>..."),
 	NULL
 };
 
@@ -22,6 +24,11 @@ static const char * const builtin_update_usage[] = {
 	NULL
 };
 
+static const char * const builtin_delete_usage[] = {
+	N_("git change delete <change-name>..."),
+	NULL
+};
+
 static int change_list(int argc, const char **argv, const char* prefix)
 {
 	struct option options[] = {
@@ -228,6 +235,75 @@ static int change_update(int argc, const char **argv, const char* prefix)
 	return result;
 }
 
+typedef int (*each_change_name_fn)(const char *name, const char *ref,
+				   const struct object_id *oid, void *cb_data);
+
+static int for_each_change_name(const char **argv, each_change_name_fn fn,
+				void *cb_data)
+{
+	const char **p;
+	struct strbuf ref = STRBUF_INIT;
+	int had_error = 0;
+	struct object_id oid;
+
+	for (p = argv; *p; p++) {
+		strbuf_reset(&ref);
+		/* Convenience functionality to avoid having to type `metas/` */
+		if (strncmp("metas/", *p, 5)) {
+			strbuf_addf(&ref, "refs/metas/%s", *p);
+		} else {
+			strbuf_addf(&ref, "refs/%s", *p);
+		}
+		if (read_ref(ref.buf, &oid)) {
+			error(_("change '%s' not found."), *p);
+			had_error = 1;
+			continue;
+		}
+		if (fn(*p, ref.buf, &oid, cb_data))
+			had_error = 1;
+	}
+	strbuf_release(&ref);
+	return had_error;
+}
+
+static int collect_changes(const char *name, const char *ref,
+			   const struct object_id *oid, void *cb_data)
+{
+	struct string_list *ref_list = cb_data;
+
+	string_list_append(ref_list, ref);
+	ref_list->items[ref_list->nr - 1].util = oiddup(oid);
+	return 0;
+}
+
+static int change_delete(int argc, const char **argv, const char* prefix) {
+	int result = 0;
+	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
+	struct string_list_item *item;
+	struct option options[] = {
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options, builtin_delete_usage, 0);
+
+	result = for_each_change_name(argv, collect_changes, (void *)&refs_to_delete);
+	if (delete_refs(NULL, &refs_to_delete, REF_NO_DEREF))
+		result = 1;
+
+	for_each_string_list_item(item, &refs_to_delete) {
+		const char *name = item->string;
+		struct object_id *oid = item->util;
+		if (!ref_exists(name))
+			printf(_("Deleted change '%s' (was %s)\n"),
+				item->string + 5,
+				find_unique_abbrev(oid, DEFAULT_ABBREV));
+
+		free(oid);
+	}
+	string_list_clear(&refs_to_delete, 0);
+	return result;
+}
+
 int cmd_change(int argc, const char **argv, const char *prefix)
 {
 	parse_opt_subcommand_fn *fn = NULL;
@@ -235,6 +311,7 @@ int cmd_change(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_SUBCOMMAND("list", &fn, change_list),
 		OPT_SUBCOMMAND("update", &fn, change_update),
+		OPT_SUBCOMMAND("delete", &fn, change_delete),
 		OPT_END()
 	};
 
-- 
gitgitgadget

