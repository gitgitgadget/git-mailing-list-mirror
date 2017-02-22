Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0CDA201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 14:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932737AbdBVOI2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 09:08:28 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35321 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932734AbdBVOI0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 09:08:26 -0500
Received: by mail-pg0-f67.google.com with SMTP id 1so548853pgz.2
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 06:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xQmj6u6inht5w+18DZ+Ktq1ChDlirl2SP3TWmtoFhB8=;
        b=ODpCoDwaCndEQaiYVZl1uQJYe4+mXv8LK0CBTsyhgcNKw6ZWZIk+jD5eqYsa5bJCN1
         ieMpJNHdBp1b+1W2288ga0gInSDEii4misakfkRAicP6O+awfKomN57eM2P/dVRZRcz9
         gpJByP4WOCQrdxYFuT6MHQwuhLTQZFFKE7GDKFVUDK5bYgASSfYVE2DqXByFkYtF1yoJ
         ASJ/xFYInigw//r6ied0gYFR9QIZdeWaE+LpMRGKu26gesgztuAGXTOiU9qb+Qwi0KOr
         +7H4di++APisZh//xbWTgGkDn0kOmCU6D700njOz4OrSLCHL11bUJuK8VTz22j6Y7ciI
         RBog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xQmj6u6inht5w+18DZ+Ktq1ChDlirl2SP3TWmtoFhB8=;
        b=ECXW8+PDCoBJnAKa5FVxwQ7aexo2DqNgAqJnzEO5fx1DfcoMuGp+6gk5g/8g0kGqAL
         1qNKSfLcQB+Sq/10nUATG7APXLlUeL5GhfpWe/uDtyKw+ujLKDTrMGMNZ3Cn6VdV76hh
         vfJTn+3LJBFXrm8dURh2uPZcx//m7hD4MW/PIF5RhGB8eU4Et0Q+1Y1CpLAIU1nEILqx
         V6bXzQ5K2ikYZWsod4W+BSVWDYpSJb2aKAtR2iYU+erbq9SkFwT4M6C+9W8BBdl8kgQI
         WI99f/XapRQjo1gPXo48Asi0+7lMDmG0WT+VfphcP9mj1f6j0UkbYP9Bw4h2lYJfRjEy
         qHsQ==
X-Gm-Message-State: AMke39kxb4HK6OqCeikbI8Q9zGkKxjVXT9ISX8znwRVy3qaoOoGz0VrhBt28oiiU78lKog==
X-Received: by 10.99.125.19 with SMTP id y19mr16731762pgc.79.1487772505055;
        Wed, 22 Feb 2017 06:08:25 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id t184sm4145372pgb.11.2017.02.22.06.08.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Feb 2017 06:08:24 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 22 Feb 2017 21:08:17 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v5 22/24] t/helper: add test-ref-store to test ref-store functions
Date:   Wed, 22 Feb 2017 21:04:48 +0700
Message-Id: <20170222140450.30886-23-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170222140450.30886-1-pclouds@gmail.com>
References: <20170218133303.3682-1-pclouds@gmail.com>
 <20170222140450.30886-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Makefile                        |   1 +
 t/helper/.gitignore             |   1 +
 t/helper/test-ref-store.c (new) | 274 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 276 insertions(+)
 create mode 100644 t/helper/test-ref-store.c

diff --git a/Makefile b/Makefile
index 8e4081e06..d62d64623 100644
--- a/Makefile
+++ b/Makefile
@@ -624,6 +624,7 @@ TEST_PROGRAMS_NEED_X += test-parse-options
 TEST_PROGRAMS_NEED_X += test-path-utils
 TEST_PROGRAMS_NEED_X += test-prio-queue
 TEST_PROGRAMS_NEED_X += test-read-cache
+TEST_PROGRAMS_NEED_X += test-ref-store
 TEST_PROGRAMS_NEED_X += test-regex
 TEST_PROGRAMS_NEED_X += test-revision-walking
 TEST_PROGRAMS_NEED_X += test-run-command
diff --git a/t/helper/.gitignore b/t/helper/.gitignore
index d6e8b3679..5f68aa8f8 100644
--- a/t/helper/.gitignore
+++ b/t/helper/.gitignore
@@ -19,6 +19,7 @@
 /test-path-utils
 /test-prio-queue
 /test-read-cache
+/test-ref-store
 /test-regex
 /test-revision-walking
 /test-run-command
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
new file mode 100644
index 000000000..c4c670acd
--- /dev/null
+++ b/t/helper/test-ref-store.c
@@ -0,0 +1,274 @@
+#include "cache.h"
+#include "refs.h"
+
+static const char *notnull(const char *arg, const char *name)
+{
+	if (!arg)
+		die("%s required", name);
+	return arg;
+}
+
+static unsigned int arg_flags(const char *arg, const char *name)
+{
+	return atoi(notnull(arg, name));
+}
+
+static const char **get_store(const char **argv, struct ref_store **refs)
+{
+	const char *gitdir;
+
+	if (!argv[0]) {
+		die("ref store required");
+	} else if (!strcmp(argv[0], "main")) {
+		*refs = get_main_ref_store();
+	} else if (skip_prefix(argv[0], "submodule:", &gitdir)) {
+		struct strbuf sb = STRBUF_INIT;
+		int ret;
+
+		ret = strbuf_git_path_submodule(&sb, gitdir, "objects/");
+		if (ret)
+			die("strbuf_git_path_submodule failed: %d", ret);
+		add_to_alternates_memory(sb.buf);
+		strbuf_release(&sb);
+
+		*refs = get_submodule_ref_store(gitdir);
+	} else
+		die("unknown backend %s", argv[0]);
+
+	if (!*refs)
+		die("no ref store");
+
+	/* consume store-specific optional arguments if needed */
+
+	return argv + 1;
+}
+
+
+static int cmd_pack_refs(struct ref_store *refs, const char **argv)
+{
+	unsigned int flags = arg_flags(*argv++, "flags");
+
+	return refs_pack_refs(refs, flags);
+}
+
+static int cmd_peel_ref(struct ref_store *refs, const char **argv)
+{
+	const char *refname = notnull(*argv++, "refname");
+	unsigned char sha1[20];
+	int ret;
+
+	ret = refs_peel_ref(refs, refname, sha1);
+	if (!ret)
+		puts(sha1_to_hex(sha1));
+	return ret;
+}
+
+static int cmd_create_symref(struct ref_store *refs, const char **argv)
+{
+	const char *refname = notnull(*argv++, "refname");
+	const char *target = notnull(*argv++, "target");
+	const char *logmsg = *argv++;
+
+	return refs_create_symref(refs, refname, target, logmsg);
+}
+
+static int cmd_delete_refs(struct ref_store *refs, const char **argv)
+{
+	unsigned int flags = arg_flags(*argv++, "flags");
+	struct string_list refnames = STRING_LIST_INIT_NODUP;
+
+	while (*argv)
+		string_list_append(&refnames, *argv++);
+
+	return refs_delete_refs(refs, &refnames, flags);
+}
+
+static int cmd_rename_ref(struct ref_store *refs, const char **argv)
+{
+	const char *oldref = notnull(*argv++, "oldref");
+	const char *newref = notnull(*argv++, "newref");
+	const char *logmsg = *argv++;
+
+	return refs_rename_ref(refs, oldref, newref, logmsg);
+}
+
+static int each_ref(const char *refname, const struct object_id *oid,
+		    int flags, void *cb_data)
+{
+	printf("%s %s 0x%x\n", oid_to_hex(oid), refname, flags);
+	return 0;
+}
+
+static int cmd_for_each_ref(struct ref_store *refs, const char **argv)
+{
+	const char *prefix = notnull(*argv++, "prefix");
+
+	return refs_for_each_ref_in(refs, prefix, each_ref, NULL);
+}
+
+static int cmd_resolve_ref(struct ref_store *refs, const char **argv)
+{
+	unsigned char sha1[20];
+	const char *refname = notnull(*argv++, "refname");
+	int resolve_flags = arg_flags(*argv++, "resolve-flags");
+	int flags;
+	const char *ref;
+
+	ref = refs_resolve_ref_unsafe(refs, refname, resolve_flags,
+				      sha1, &flags);
+	printf("%s %s 0x%x\n", sha1_to_hex(sha1), ref, flags);
+	return ref ? 0 : 1;
+}
+
+static int cmd_verify_ref(struct ref_store *refs, const char **argv)
+{
+	const char *refname = notnull(*argv++, "refname");
+	struct strbuf err = STRBUF_INIT;
+	int ret;
+
+	ret = refs_verify_refname_available(refs, refname, NULL, NULL, &err);
+	if (err.len)
+		puts(err.buf);
+	return ret;
+}
+
+static int cmd_for_each_reflog(struct ref_store *refs, const char **argv)
+{
+	return refs_for_each_reflog(refs, each_ref, NULL);
+}
+
+static int each_reflog(unsigned char *old_sha1, unsigned char *new_sha1,
+		       const char *committer, unsigned long timestamp,
+		       int tz, const char *msg, void *cb_data)
+{
+	printf("%s %s %s %lu %d %s\n",
+	       sha1_to_hex(old_sha1), sha1_to_hex(new_sha1),
+	       committer, timestamp, tz, msg);
+	return 0;
+}
+
+static int cmd_for_each_reflog_ent(struct ref_store *refs, const char **argv)
+{
+	const char *refname = notnull(*argv++, "refname");
+
+	return refs_for_each_reflog_ent(refs, refname, each_reflog, refs);
+}
+
+static int cmd_for_each_reflog_ent_reverse(struct ref_store *refs, const char **argv)
+{
+	const char *refname = notnull(*argv++, "refname");
+
+	return refs_for_each_reflog_ent_reverse(refs, refname, each_reflog, refs);
+}
+
+static int cmd_reflog_exists(struct ref_store *refs, const char **argv)
+{
+	const char *refname = notnull(*argv++, "refname");
+
+	return !refs_reflog_exists(refs, refname);
+}
+
+static int cmd_create_reflog(struct ref_store *refs, const char **argv)
+{
+	const char *refname = notnull(*argv++, "refname");
+	int force_create = arg_flags(*argv++, "force-create");
+	struct strbuf err = STRBUF_INIT;
+	int ret;
+
+	ret = refs_create_reflog(refs, refname, force_create, &err);
+	if (err.len)
+		puts(err.buf);
+	return ret;
+}
+
+static int cmd_delete_reflog(struct ref_store *refs, const char **argv)
+{
+	const char *refname = notnull(*argv++, "refname");
+
+	return refs_delete_reflog(refs, refname);
+}
+
+static int cmd_reflog_expire(struct ref_store *refs, const char **argv)
+{
+	die("not supported yet");
+}
+
+static int cmd_delete_ref(struct ref_store *refs, const char **argv)
+{
+	const char *refname = notnull(*argv++, "refname");
+	const char *sha1_buf = notnull(*argv++, "old-sha1");
+	unsigned int flags = arg_flags(*argv++, "flags");
+	unsigned char old_sha1[20];
+
+	if (get_sha1_hex(sha1_buf, old_sha1))
+		die("not sha-1");
+
+	return refs_delete_ref(refs, refname, old_sha1, flags);
+}
+
+static int cmd_update_ref(struct ref_store *refs, const char **argv)
+{
+	const char *msg = notnull(*argv++, "msg");
+	const char *refname = notnull(*argv++, "refname");
+	const char *new_sha1_buf = notnull(*argv++, "old-sha1");
+	const char *old_sha1_buf = notnull(*argv++, "old-sha1");
+	unsigned int flags = arg_flags(*argv++, "flags");
+	unsigned char old_sha1[20];
+	unsigned char new_sha1[20];
+
+	if (get_sha1_hex(old_sha1_buf, old_sha1) ||
+	    get_sha1_hex(new_sha1_buf, new_sha1))
+		die("not sha-1");
+
+	return refs_update_ref(refs, msg, refname,
+			       new_sha1, old_sha1,
+			       flags, UPDATE_REFS_DIE_ON_ERR);
+}
+
+struct command {
+	const char *name;
+	int (*func)(struct ref_store *refs, const char **argv);
+};
+
+static struct command commands[] = {
+	{ "pack-refs", cmd_pack_refs },
+	{ "peel-ref", cmd_peel_ref },
+	{ "create-symref", cmd_create_symref },
+	{ "delete-refs", cmd_delete_refs },
+	{ "rename-ref", cmd_rename_ref },
+	{ "for-each-ref", cmd_for_each_ref },
+	{ "resolve-ref", cmd_resolve_ref },
+	{ "verify-ref", cmd_verify_ref },
+	{ "for-each-reflog", cmd_for_each_reflog },
+	{ "for-each-reflog-ent", cmd_for_each_reflog_ent },
+	{ "for-each-reflog-ent-reverse", cmd_for_each_reflog_ent_reverse },
+	{ "reflog-exists", cmd_reflog_exists },
+	{ "create-reflog", cmd_create_reflog },
+	{ "delete-reflog", cmd_delete_reflog },
+	{ "reflog-expire", cmd_reflog_expire },
+	/*
+	 * backend transaction functions can't be tested separately
+	 */
+	{ "delete-ref", cmd_delete_ref },
+	{ "update-ref", cmd_update_ref },
+	{ NULL, NULL }
+};
+
+int cmd_main(int argc, const char **argv)
+{
+	struct ref_store *refs;
+	const char *func;
+	struct command *cmd;
+
+	argv = get_store(argv + 1, &refs);
+
+	func = *argv++;
+	if (!func)
+		die("ref function required");
+	for (cmd = commands; cmd->name; cmd++) {
+		if (!strcmp(func, cmd->name))
+			return cmd->func(refs, argv);
+	}
+	die("unknown function %s", func);
+	return 0;
+}
-- 
2.11.0.157.gd943d85

