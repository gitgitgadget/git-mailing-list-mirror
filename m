Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 690731F404
	for <e@80x24.org>; Wed, 14 Feb 2018 19:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162607AbeBNTCs (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 14:02:48 -0500
Received: from mail-ua0-f201.google.com ([209.85.217.201]:38157 "EHLO
        mail-ua0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162506AbeBNTBS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 14:01:18 -0500
Received: by mail-ua0-f201.google.com with SMTP id 104so15456088uat.5
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 11:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=DgH2C/uZZmzPbn+UOuXAnBkZzWMgCiQPVtkni7wG6UY=;
        b=ZpNfhMPBaRL53w/awYYYi8Ja8FpcUvVXNKW+y6NN76RhgY4k21O52NVhw4bgsRtCWK
         K82j1wSyktSQfQOxKFqTiW8rOy8tHt2g8GBfUQDgEixKFIto8hHFzaDE2cyZYROm3lHt
         Ot9OGsg4Ql+CIf3vaLB+8edovHB6Bkv1NfCyKeVjjYbXQhvGP8GHjbkCBkKzTDuyMGlT
         g6e0YAeDDWlHup0GBAD0EEWXyXQPmKWgXdwHniZBJfQTjkgCZVVlATu0c0/k02sDjcHV
         nUeWL816uaYpbdz4jA7rA5yZnBdVIEJawZ9VMHQR8a5flD+6WkbzFtY7cdEZSj11JHvk
         5yXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=DgH2C/uZZmzPbn+UOuXAnBkZzWMgCiQPVtkni7wG6UY=;
        b=jFdnCJQmAb55NDEhul9E84Lsa2TOZv0iXhZi/KG3FISP9P+RAJvDKTumYjTzqcHlAT
         BA6+rhY/19XYsDIMBg2znNbxVMLGnnbSOeqvqxHw+fQnP5lyFxV+nK/3jSbq5j0xBLbT
         auKUVqrZkYPPF7OXuUGjKlTypGIKa0TT6b7qr6GsjWlNSy0HXbFz2eStnpHe2yDlcNqY
         krdZFmr3B7DMyaspIyjrtgYncZuomXxxhMS6RrA2kUX12vkd8N7xyUe8D2aO0TrsVSG4
         LJF8aWh8OGDRoDaLj/KBQX5clHBsAWi+x4AjkSNlsNi5nPCEhCaFg9WVfJZMBWhARVc6
         K1WQ==
X-Gm-Message-State: APf1xPAiMFuiOb9VNv5ZR0JRuvVnKb3WQl4ABNl55DLcj1vBVptdIM7P
        FyZj6E0nF9N2bZySA63KPoNpVmfxJD+YMau+6BCv20YJSv5tVjAIkh6SWPozNCRaVzeW5CXW2X7
        XrTT+Op66owK0W1hhW/lWj13yRYY+hvbjHRafRJaDDiwZhgMtWXSe/nPkVg==
X-Google-Smtp-Source: AH8x225AZK0b/4blghN0L90V1bB9vxI/ezj8El60ctzo+KXa5PNUriJzqffKpzEPamgfJ3ttV8f47BBX/g8=
MIME-Version: 1.0
X-Received: by 10.31.128.8 with SMTP id b8mr2866001vkd.62.1518634877470; Wed,
 14 Feb 2018 11:01:17 -0800 (PST)
Date:   Wed, 14 Feb 2018 10:59:35 -0800
In-Reply-To: <20180214185959.221906-1-bmwill@google.com>
Message-Id: <20180214185959.221906-14-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com> <20180214185959.221906-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.109.g93438bbb9.dirty
Subject: [PATCH v2 13/37] remote: rename 'new' variables
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, sbeller@google.com, avarab@gmail.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename C++ keyword in order to bring the codebase closer to being able
to be compiled with a C++ compiler.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/remote.c | 66 ++++++++++++++++++++++++------------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index d95bf904c..6487d92ab 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -322,7 +322,7 @@ static void read_branches(void)
 
 struct ref_states {
 	struct remote *remote;
-	struct string_list new, stale, tracked, heads, push;
+	struct string_list new_refs, stale, tracked, heads, push;
 	int queried;
 };
 
@@ -337,12 +337,12 @@ static int get_ref_states(const struct ref *remote_refs, struct ref_states *stat
 			die(_("Could not get fetch map for refspec %s"),
 				states->remote->fetch_refspec[i]);
 
-	states->new.strdup_strings = 1;
+	states->new_refs.strdup_strings = 1;
 	states->tracked.strdup_strings = 1;
 	states->stale.strdup_strings = 1;
 	for (ref = fetch_map; ref; ref = ref->next) {
 		if (!ref->peer_ref || !ref_exists(ref->peer_ref->name))
-			string_list_append(&states->new, abbrev_branch(ref->name));
+			string_list_append(&states->new_refs, abbrev_branch(ref->name));
 		else
 			string_list_append(&states->tracked, abbrev_branch(ref->name));
 	}
@@ -356,7 +356,7 @@ static int get_ref_states(const struct ref *remote_refs, struct ref_states *stat
 	free_refs(stale_refs);
 	free_refs(fetch_map);
 
-	string_list_sort(&states->new);
+	string_list_sort(&states->new_refs);
 	string_list_sort(&states->tracked);
 	string_list_sort(&states->stale);
 
@@ -546,8 +546,8 @@ static int add_branch_for_removal(const char *refname,
 }
 
 struct rename_info {
-	const char *old;
-	const char *new;
+	const char *old_name;
+	const char *new_name;
 	struct string_list *remote_branches;
 };
 
@@ -560,7 +560,7 @@ static int read_remote_branches(const char *refname,
 	int flag;
 	const char *symref;
 
-	strbuf_addf(&buf, "refs/remotes/%s/", rename->old);
+	strbuf_addf(&buf, "refs/remotes/%s/", rename->old_name);
 	if (starts_with(refname, buf.buf)) {
 		item = string_list_append(rename->remote_branches, xstrdup(refname));
 		symref = resolve_ref_unsafe(refname, RESOLVE_REF_READING,
@@ -615,36 +615,36 @@ static int mv(int argc, const char **argv)
 	if (argc != 3)
 		usage_with_options(builtin_remote_rename_usage, options);
 
-	rename.old = argv[1];
-	rename.new = argv[2];
+	rename.old_name = argv[1];
+	rename.new_name = argv[2];
 	rename.remote_branches = &remote_branches;
 
-	oldremote = remote_get(rename.old);
+	oldremote = remote_get(rename.old_name);
 	if (!remote_is_configured(oldremote, 1))
-		die(_("No such remote: %s"), rename.old);
+		die(_("No such remote: %s"), rename.old_name);
 
-	if (!strcmp(rename.old, rename.new) && oldremote->origin != REMOTE_CONFIG)
+	if (!strcmp(rename.old_name, rename.new_name) && oldremote->origin != REMOTE_CONFIG)
 		return migrate_file(oldremote);
 
-	newremote = remote_get(rename.new);
+	newremote = remote_get(rename.new_name);
 	if (remote_is_configured(newremote, 1))
-		die(_("remote %s already exists."), rename.new);
+		die(_("remote %s already exists."), rename.new_name);
 
-	strbuf_addf(&buf, "refs/heads/test:refs/remotes/%s/test", rename.new);
+	strbuf_addf(&buf, "refs/heads/test:refs/remotes/%s/test", rename.new_name);
 	if (!valid_fetch_refspec(buf.buf))
-		die(_("'%s' is not a valid remote name"), rename.new);
+		die(_("'%s' is not a valid remote name"), rename.new_name);
 
 	strbuf_reset(&buf);
-	strbuf_addf(&buf, "remote.%s", rename.old);
-	strbuf_addf(&buf2, "remote.%s", rename.new);
+	strbuf_addf(&buf, "remote.%s", rename.old_name);
+	strbuf_addf(&buf2, "remote.%s", rename.new_name);
 	if (git_config_rename_section(buf.buf, buf2.buf) < 1)
 		return error(_("Could not rename config section '%s' to '%s'"),
 				buf.buf, buf2.buf);
 
 	strbuf_reset(&buf);
-	strbuf_addf(&buf, "remote.%s.fetch", rename.new);
+	strbuf_addf(&buf, "remote.%s.fetch", rename.new_name);
 	git_config_set_multivar(buf.buf, NULL, NULL, 1);
-	strbuf_addf(&old_remote_context, ":refs/remotes/%s/", rename.old);
+	strbuf_addf(&old_remote_context, ":refs/remotes/%s/", rename.old_name);
 	for (i = 0; i < oldremote->fetch_refspec_nr; i++) {
 		char *ptr;
 
@@ -655,8 +655,8 @@ static int mv(int argc, const char **argv)
 			refspec_updated = 1;
 			strbuf_splice(&buf2,
 				      ptr-buf2.buf + strlen(":refs/remotes/"),
-				      strlen(rename.old), rename.new,
-				      strlen(rename.new));
+				      strlen(rename.old_name), rename.new_name,
+				      strlen(rename.new_name));
 		} else
 			warning(_("Not updating non-default fetch refspec\n"
 				  "\t%s\n"
@@ -670,10 +670,10 @@ static int mv(int argc, const char **argv)
 	for (i = 0; i < branch_list.nr; i++) {
 		struct string_list_item *item = branch_list.items + i;
 		struct branch_info *info = item->util;
-		if (info->remote_name && !strcmp(info->remote_name, rename.old)) {
+		if (info->remote_name && !strcmp(info->remote_name, rename.old_name)) {
 			strbuf_reset(&buf);
 			strbuf_addf(&buf, "branch.%s.remote", item->string);
-			git_config_set(buf.buf, rename.new);
+			git_config_set(buf.buf, rename.new_name);
 		}
 	}
 
@@ -703,8 +703,8 @@ static int mv(int argc, const char **argv)
 			continue;
 		strbuf_reset(&buf);
 		strbuf_addstr(&buf, item->string);
-		strbuf_splice(&buf, strlen("refs/remotes/"), strlen(rename.old),
-				rename.new, strlen(rename.new));
+		strbuf_splice(&buf, strlen("refs/remotes/"), strlen(rename.old_name),
+				rename.new_name, strlen(rename.new_name));
 		strbuf_reset(&buf2);
 		strbuf_addf(&buf2, "remote: renamed %s to %s",
 				item->string, buf.buf);
@@ -718,12 +718,12 @@ static int mv(int argc, const char **argv)
 			continue;
 		strbuf_reset(&buf);
 		strbuf_addstr(&buf, item->string);
-		strbuf_splice(&buf, strlen("refs/remotes/"), strlen(rename.old),
-				rename.new, strlen(rename.new));
+		strbuf_splice(&buf, strlen("refs/remotes/"), strlen(rename.old_name),
+				rename.new_name, strlen(rename.new_name));
 		strbuf_reset(&buf2);
 		strbuf_addstr(&buf2, item->util);
-		strbuf_splice(&buf2, strlen("refs/remotes/"), strlen(rename.old),
-				rename.new, strlen(rename.new));
+		strbuf_splice(&buf2, strlen("refs/remotes/"), strlen(rename.old_name),
+				rename.new_name, strlen(rename.new_name));
 		strbuf_reset(&buf3);
 		strbuf_addf(&buf3, "remote: renamed %s to %s",
 				item->string, buf.buf);
@@ -822,7 +822,7 @@ static void clear_push_info(void *util, const char *string)
 
 static void free_remote_ref_states(struct ref_states *states)
 {
-	string_list_clear(&states->new, 0);
+	string_list_clear(&states->new_refs, 0);
 	string_list_clear(&states->stale, 1);
 	string_list_clear(&states->tracked, 0);
 	string_list_clear(&states->heads, 0);
@@ -907,7 +907,7 @@ static int show_remote_info_item(struct string_list_item *item, void *cb_data)
 	if (states->queried) {
 		const char *fmt = "%s";
 		const char *arg = "";
-		if (string_list_has_string(&states->new, name)) {
+		if (string_list_has_string(&states->new_refs, name)) {
 			fmt = _(" new (next fetch will store in remotes/%s)");
 			arg = states->remote->name;
 		} else if (string_list_has_string(&states->tracked, name))
@@ -1176,7 +1176,7 @@ static int show(int argc, const char **argv)
 
 		/* remote branch info */
 		info.width = 0;
-		for_each_string_list(&states.new, add_remote_to_show_info, &info);
+		for_each_string_list(&states.new_refs, add_remote_to_show_info, &info);
 		for_each_string_list(&states.tracked, add_remote_to_show_info, &info);
 		for_each_string_list(&states.stale, add_remote_to_show_info, &info);
 		if (info.list->nr)
-- 
2.16.1.291.g4437f3f132-goog

