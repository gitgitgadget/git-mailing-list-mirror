Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1034DC07E9D
	for <git@archiver.kernel.org>; Fri, 23 Sep 2022 18:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbiIWS4H (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Sep 2022 14:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232799AbiIWSzh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2022 14:55:37 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FE9113B6F
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 11:55:34 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id x18so1303610wrm.7
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 11:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=PEnkEJgdzOsvNDgHvHeAhPbE1UBAGiD24xm8FNDIjiU=;
        b=cdeSRLLk3WwXR7IIYdLwd9pua2lxy0lFV6z5C6QVcP/tA/avKlS8nth0kmOYK5AleT
         /xFruL0ijG+Pe1E61+usxsEymesQtdPTZHCYMxRG9ux9wJ0b5fuSSUTz7xVoD5cjAubg
         +4U1+B0QeIygysKbSzdgD2tqAAcdm7AlrSa9H21ffrxosnaFVvGIlmGFBYolGr93F7Hs
         Ejrb3aogEjHwze7tLWfG3LTc2v7ODYcClzvctQ2V/Ldvk5Q0UoASSC+SwWNqpGfhKUSe
         feB9q1oUUMIDDv1ftTqOY14nTJL3m0vV4PUK2PRZbyTzSISLwM3KwERHOK0mYo+NALHZ
         nZ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=PEnkEJgdzOsvNDgHvHeAhPbE1UBAGiD24xm8FNDIjiU=;
        b=BnljKOoy2q+3FVqwbTUTlyW0Dej3f20Gt9cO/z7S2qBwct1kKnqzjph3+sukft2jJh
         wpeH00Snph1O58ZTcQVY6F6HoLoSD3p1MmW+fJcXrtzVPtN3SpDQSwPdFMNGZ0h4R5nD
         mlMUDE25vF7VuILQQAdnI+WBeWsSrJzH0XLyEiY73/bzOTV0ZNgTS3okgPE04M5cE/JX
         /dq9iGfA5OO4hgUe3ZPkeNkAFgP0ofCo+cImvWXLayWJe6OwMZcQo3tqJZXLp42vGNKk
         Fsmqr34SAWRQ8LKgBwvfUatAmx8PGnqb8nU5bkuYFraXU6MPZxReQkVJT+D6K2UCuutz
         oE1Q==
X-Gm-Message-State: ACrzQf2cyCxVSa0NpW3uoEdvnTcpjgAzkzYu0IailNgRnofCVO1Wv0iG
        F2FnmW8ClY9GeDfTML2VjwicZWJHaYo=
X-Google-Smtp-Source: AMsMyM7Hnjg5Y2EOk8GpeQap3LTf0YAHjh/eVl8iEYz7E1HlwOy2D9mecuSDNh2jywK4XCbYmShgZg==
X-Received: by 2002:a5d:5150:0:b0:22a:43a8:145b with SMTP id u16-20020a5d5150000000b0022a43a8145bmr6271634wrt.170.1663959333319;
        Fri, 23 Sep 2022 11:55:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u7-20020a05600c4d0700b003b4e009deb2sm3432024wmp.41.2022.09.23.11.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 11:55:32 -0700 (PDT)
Message-Id: <d087d467e3fe3000eb19939c2bb5e5c0723fd908.1663959325.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1356.git.1663959324.gitgitgadget@gmail.com>
References: <pull.1356.git.1663959324.gitgitgadget@gmail.com>
From:   "Chris Poucet via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Sep 2022 18:55:23 +0000
Subject: [PATCH 09/10] evolve: add delete command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christophe Poucet <christophe.poucet@gmail.com>,
        Chris Poucet <poucet@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Chris Poucet <poucet@google.com>

The delete command allows a user to delete one or more changes.
This effectively deletes the corresponding /refs/metas/foo ref.

Signed-off-by: Chris Poucet <poucet@google.com>
---
 builtin/change.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 80 insertions(+), 2 deletions(-)

diff --git a/builtin/change.c b/builtin/change.c
index 67d708dc8de..07d029d82d5 100644
--- a/builtin/change.c
+++ b/builtin/change.c
@@ -4,10 +4,12 @@
 #include "metacommit.h"
 #include "change-table.h"
 #include "config.h"
+#include "refs.h"
 
 static const char * const builtin_change_usage[] = {
 	N_("git change list [<pattern>...]"),
-	N_("git change update [--force] [--replace <treeish>...] [--origin <treesih>...] [--content <newtreeish>]"),
+	N_("git change update [--force] [--replace <treeish>...] [--origin <treeish>...] [--content <newtreeish>]"),
+	N_("git change delete <change-name>..."),
 	NULL
 };
 
@@ -17,7 +19,12 @@ static const char * const builtin_list_usage[] = {
 };
 
 static const char * const builtin_update_usage[] = {
-	N_("git change update [--force] [--replace <treeish>...] [--origin <treesih>...] [--content <newtreeish>]"),
+	N_("git change update [--force] [--replace <treeish>...] [--origin <treeish>...] [--content <newtreeish>]"),
+	NULL
+};
+
+static const char * const builtin_delete_usage[] = {
+	N_("git change delete <change-name>..."),
 	NULL
 };
 
@@ -238,6 +245,75 @@ static int change_update(int argc, const char **argv, const char* prefix)
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
 	/* No options permitted before subcommand currently */
@@ -255,6 +331,8 @@ int cmd_change(int argc, const char **argv, const char *prefix)
 		result = change_list(argc, argv, prefix);
 	else if (!strcmp(argv[0], "update"))
 		result = change_update(argc, argv, prefix);
+	else if (!strcmp(argv[0], "delete"))
+		result = change_delete(argc, argv, prefix);
 	else {
 		error(_("Unknown subcommand: %s"), argv[0]);
 		usage_with_options(builtin_change_usage, options);
-- 
gitgitgadget

