Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AA3E1F404
	for <e@80x24.org>; Mon, 29 Jan 2018 22:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752229AbeA2WkR (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 17:40:17 -0500
Received: from mail-oi0-f74.google.com ([209.85.218.74]:39988 "EHLO
        mail-oi0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752139AbeA2WiM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 17:38:12 -0500
Received: by mail-oi0-f74.google.com with SMTP id s5so5933147oib.7
        for <git@vger.kernel.org>; Mon, 29 Jan 2018 14:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=IBoDRKBZg/4fIl3E60qE1aCLG0+lQvXoF9Y34/onxxc=;
        b=HtsOpICGTR6KoXECtHmcPqFdTXXZd7TmUHcSmpB8mTdzriUuPJwwTYCKvSA4LgwDVp
         U4MI4ZtnGUN4pgSjM9a3B5rFchUsgCEojeTZnOw6QD0UxwSFLJ3QxubfarXMehq3SAgc
         7vE5LhXm6/UcoSq/0WSg1jD3HtswJV9sKcMKbE/rzeUk5Ce5ruF5xvYN6YG+7U8V7oZ3
         iMCYvEBTso8b8mxNWwoLYpaW6Xr8TBOORgyj0XVKdQGSBTxReyms3LV7BRJHHFyzzCCg
         Q+kCJlyjNnmp7AdHaMz7TDwYqX4WMosKKIZQ5bNL7o5wVcWEl0Dk8y+bsN+svcdIiQI8
         CFlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=IBoDRKBZg/4fIl3E60qE1aCLG0+lQvXoF9Y34/onxxc=;
        b=gFI09DtzsIUl7mhbUuRBY4x7vV40DsZDCwTZ0pJBmz/Q2Z8Scs/cVuAQZ3ESaFgQow
         zvQR1ouPSoel7bptdNu+XxHd9iRoQX0pBy9zACbESi4b8xKbpJnAnW7/IhhHBr8Uwepu
         XTXUz7smCB85+gEgtjSwrGh5RGKT+OMgUBC+ON/VDQ3QqLMuDBInEFauTobJ0hJDAwl9
         f0Fya3LK3Bz7E2bTfLkaoysTptr3DnDtwPA9uXPbpVr3yx49wu9VoSMpQVv6ksyqfw0s
         Civtm8ybhSP/gSrVJo9Lk24ZicuTgtAyyffNXKrwruR7dnQBVsnxb1uSwFLtIVmpxD7L
         ipXA==
X-Gm-Message-State: AKwxytcROd7NVkVJ+Ir4lwu2GGNQuEFxazQthXeEU0AaOA9LXkHqezsc
        DM+oiJfso7gJsjFxs52YxVI5AT8I8C+CQm4n9Bd3eEf/4ZuJ8RFkDOrQ6mqVC1rhT/OnwHQooiJ
        aWpIwUl0mXoC3mlw6a/oizTXar4SPjULMysUDCL0xa5PPlDoV8r/QtiIy7w==
X-Google-Smtp-Source: AH8x226HDfgFz81lHMBXfxcN9Dr+q5pREiLL+RsIU5pPM5gBGu5WCG9caOSMRxOZk26dxWuVIDfGhgl7LDM=
MIME-Version: 1.0
X-Received: by 10.157.6.108 with SMTP id 99mr14713216otn.96.1517265491427;
 Mon, 29 Jan 2018 14:38:11 -0800 (PST)
Date:   Mon, 29 Jan 2018 14:37:04 -0800
In-Reply-To: <20180129223728.30569-1-bmwill@google.com>
Message-Id: <20180129223728.30569-14-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH 13/37] remote: rename 'new' variables
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, avarab@gmail.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename C++ keyword in order to bring the codebase closer to being able
to be compiled with a C++ compiler.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/remote.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index d95bf904c..4f4783e70 100644
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
 
@@ -547,7 +547,7 @@ static int add_branch_for_removal(const char *refname,
 
 struct rename_info {
 	const char *old;
-	const char *new;
+	const char *new_name;
 	struct string_list *remote_branches;
 };
 
@@ -616,33 +616,33 @@ static int mv(int argc, const char **argv)
 		usage_with_options(builtin_remote_rename_usage, options);
 
 	rename.old = argv[1];
-	rename.new = argv[2];
+	rename.new_name = argv[2];
 	rename.remote_branches = &remote_branches;
 
 	oldremote = remote_get(rename.old);
 	if (!remote_is_configured(oldremote, 1))
 		die(_("No such remote: %s"), rename.old);
 
-	if (!strcmp(rename.old, rename.new) && oldremote->origin != REMOTE_CONFIG)
+	if (!strcmp(rename.old, rename.new_name) && oldremote->origin != REMOTE_CONFIG)
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
 	strbuf_addf(&buf, "remote.%s", rename.old);
-	strbuf_addf(&buf2, "remote.%s", rename.new);
+	strbuf_addf(&buf2, "remote.%s", rename.new_name);
 	if (git_config_rename_section(buf.buf, buf2.buf) < 1)
 		return error(_("Could not rename config section '%s' to '%s'"),
 				buf.buf, buf2.buf);
 
 	strbuf_reset(&buf);
-	strbuf_addf(&buf, "remote.%s.fetch", rename.new);
+	strbuf_addf(&buf, "remote.%s.fetch", rename.new_name);
 	git_config_set_multivar(buf.buf, NULL, NULL, 1);
 	strbuf_addf(&old_remote_context, ":refs/remotes/%s/", rename.old);
 	for (i = 0; i < oldremote->fetch_refspec_nr; i++) {
@@ -655,8 +655,8 @@ static int mv(int argc, const char **argv)
 			refspec_updated = 1;
 			strbuf_splice(&buf2,
 				      ptr-buf2.buf + strlen(":refs/remotes/"),
-				      strlen(rename.old), rename.new,
-				      strlen(rename.new));
+				      strlen(rename.old), rename.new_name,
+				      strlen(rename.new_name));
 		} else
 			warning(_("Not updating non-default fetch refspec\n"
 				  "\t%s\n"
@@ -673,7 +673,7 @@ static int mv(int argc, const char **argv)
 		if (info->remote_name && !strcmp(info->remote_name, rename.old)) {
 			strbuf_reset(&buf);
 			strbuf_addf(&buf, "branch.%s.remote", item->string);
-			git_config_set(buf.buf, rename.new);
+			git_config_set(buf.buf, rename.new_name);
 		}
 	}
 
@@ -704,7 +704,7 @@ static int mv(int argc, const char **argv)
 		strbuf_reset(&buf);
 		strbuf_addstr(&buf, item->string);
 		strbuf_splice(&buf, strlen("refs/remotes/"), strlen(rename.old),
-				rename.new, strlen(rename.new));
+				rename.new_name, strlen(rename.new_name));
 		strbuf_reset(&buf2);
 		strbuf_addf(&buf2, "remote: renamed %s to %s",
 				item->string, buf.buf);
@@ -719,11 +719,11 @@ static int mv(int argc, const char **argv)
 		strbuf_reset(&buf);
 		strbuf_addstr(&buf, item->string);
 		strbuf_splice(&buf, strlen("refs/remotes/"), strlen(rename.old),
-				rename.new, strlen(rename.new));
+				rename.new_name, strlen(rename.new_name));
 		strbuf_reset(&buf2);
 		strbuf_addstr(&buf2, item->util);
 		strbuf_splice(&buf2, strlen("refs/remotes/"), strlen(rename.old),
-				rename.new, strlen(rename.new));
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
2.16.0.rc1.238.g530d649a79-goog

