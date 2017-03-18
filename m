Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E8322095D
	for <e@80x24.org>; Sat, 18 Mar 2017 02:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751392AbdCRCHY (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 22:07:24 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34884 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751115AbdCRCHP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 22:07:15 -0400
Received: by mail-pf0-f195.google.com with SMTP id x63so10207147pfx.2
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 19:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ytf48HdPEn/ofocceAHYZ80EPeGM5gm7gUcLbbuQCzQ=;
        b=dbeU3xYvXsEr/kotEdKVVngq6GoAKafireREdYqy5QXx2RUjnTcENBLROXirfUSZ1i
         Y4n/OSUpgxSGVl7cAhV1KWfFGvaQZyl9Tgt+GuT29XnbDg9T2tRFpxRoPt6DeoAz6Iku
         lsBsGnxflYDjmUCOiAZsLa5kLo5FTAxkFvxv6/RUwU6IsebpV4nI1cN5miIIdIUmIZDi
         gGWsOHcU6jiP9YKq34QGgTke5uz2clZMeb1NTKLq4JbPPBoUy1+qPeoVCwCJAu2ZUg/A
         0qpRwXejpdXvzwKp8+Ih3K8qbIcJdymcEIH5NRktnfPwYPnrtlo4HEbvHEbSTc7JjyLd
         IhKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ytf48HdPEn/ofocceAHYZ80EPeGM5gm7gUcLbbuQCzQ=;
        b=ruoBhNkTVpywkRhoUbbThF/FahPsuFpq+WhjKattZAP4vxIU0mrzk7rRpjE7j2O3iY
         6MkjUFhZfe+a1C88g02JDS5g7v1mmw1+bCxsHHcoOS4S30PzLMqTFFYaYrHhJ4n6PzFP
         +458x1LejvbSpIuuZqH4nzzW4j+5qNJfhYXm6+/B4ysOgDGyt2f7JlWedlcF6hLnbRI4
         56cZPWWQ+BDwhiV4V2PB3i2PMLxP9hvbdXGHszbF4E7yXkMTYJ1HW2Cd8VmcGE1yPBga
         pH6X5VXvMBAGH3Z/bXsoBNDEDql+cg+SMIVJqCJngzqurDzbra/F7fVEw3XFSCLppFIk
         662A==
X-Gm-Message-State: AFeK/H05jC1gaJWRkUXzmKH/1jndcosulDM7s6qNCIMgFnbAPUbj+5hf80aMME6VsN8WKg==
X-Received: by 10.98.149.80 with SMTP id p77mr20621595pfd.56.1489802791418;
        Fri, 17 Mar 2017 19:06:31 -0700 (PDT)
Received: from ash ([115.72.187.186])
        by smtp.gmail.com with ESMTPSA id s64sm19139990pfe.10.2017.03.17.19.06.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Mar 2017 19:06:30 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 18 Mar 2017 09:06:25 +0700
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
Subject: [PATCH v6 24/27] t/helper: add test-ref-store to test ref-store functions
Date:   Sat, 18 Mar 2017 09:03:34 +0700
Message-Id: <20170318020337.22767-25-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170318020337.22767-1-pclouds@gmail.com>
References: <20170222140450.30886-1-pclouds@gmail.com>
 <20170318020337.22767-1-pclouds@gmail.com>
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
 t/helper/test-ref-store.c (new) | 275 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 277 insertions(+)
 create mode 100644 t/helper/test-ref-store.c

diff --git a/Makefile b/Makefile
index a5a11e721a..5f3844e33e 100644
--- a/Makefile
+++ b/Makefile
@@ -622,6 +622,7 @@ TEST_PROGRAMS_NEED_X += test-parse-options
 TEST_PROGRAMS_NEED_X += test-path-utils
 TEST_PROGRAMS_NEED_X += test-prio-queue
 TEST_PROGRAMS_NEED_X += test-read-cache
+TEST_PROGRAMS_NEED_X += test-ref-store
 TEST_PROGRAMS_NEED_X += test-regex
 TEST_PROGRAMS_NEED_X += test-revision-walking
 TEST_PROGRAMS_NEED_X += test-run-command
diff --git a/t/helper/.gitignore b/t/helper/.gitignore
index d6e8b36798..5f68aa8f8a 100644
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
index 0000000000..57849ee59a
--- /dev/null
+++ b/t/helper/test-ref-store.c
@@ -0,0 +1,275 @@
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
+static int each_reflog(struct object_id *old_oid, struct object_id *new_oid,
+		       const char *committer, unsigned long timestamp,
+		       int tz, const char *msg, void *cb_data)
+{
+	printf("%s %s %s %lu %d %s\n",
+	       oid_to_hex(old_oid), oid_to_hex(new_oid),
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
+	const char *msg = notnull(*argv++, "msg");
+	const char *refname = notnull(*argv++, "refname");
+	const char *sha1_buf = notnull(*argv++, "old-sha1");
+	unsigned int flags = arg_flags(*argv++, "flags");
+	unsigned char old_sha1[20];
+
+	if (get_sha1_hex(sha1_buf, old_sha1))
+		die("not sha-1");
+
+	return refs_delete_ref(refs, msg, refname, old_sha1, flags);
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

