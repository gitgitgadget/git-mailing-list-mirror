Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DDEBC25B0E
	for <git@archiver.kernel.org>; Mon, 15 Aug 2022 15:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbiHOPB6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Aug 2022 11:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232829AbiHOPBg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Aug 2022 11:01:36 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF15C165A6
        for <git@vger.kernel.org>; Mon, 15 Aug 2022 08:01:32 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id bu15so865369wrb.7
        for <git@vger.kernel.org>; Mon, 15 Aug 2022 08:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=Fe3EQkfp/PlgHDNVcACs0V7KSBPzdSwGSd9QjxJXVU4=;
        b=BcffGn+tSXPKJuWBoBRSSHos2Ec/3V73fn5SVA2MghAbnirZLV3eWa0cCebYYAK2zI
         Su4d773WdskN7r/cH0cNeIkuuQ4RNvSDkFE7quscmwPPZ7aTclPnU8MwpAFIVL+Et6kK
         DJpSAutTywnDXFn5Pnv4xKYehintR2C2w1nQPrmK7MHvLg6jh2UwGdnc6ZNk/5p4WKn6
         tYW2zejBmfeRiwCpPMpNSmzG5ntRVoE5IV4cxqsM1yx7maiOYpjmfwfphxHcduCM9yyb
         Sa1ZKlICWil0qMHQvp9viHuY4H79B32MJ9xvs1Ultg7d7KL/Pf7IbVKkwBllWfMM9O4Q
         ROGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=Fe3EQkfp/PlgHDNVcACs0V7KSBPzdSwGSd9QjxJXVU4=;
        b=NSG1xnCihKQYC6RdlJdttOJsUPPoI4QqU1QM5OC3HBFoj3D6c/XOKQ3km8Ql8Dh4IL
         NHAFns+teJE7Nfw4+gDg4F9MUj+tn1Q4aGNaLNxb8B0taXVNbcShk0CuNuV3maHdfCr4
         C0xb0KScM9KB3Sra4SzZWNpn0DBMtwoPqyQ2oM7pDb3cF6cLwTBrycjDKyPtBOx8vWMw
         e+e5DiaMN5dVmj2qu4Tu6SRbQoc4jL5Lt56kphHEbygZM4fnTQMKKFNlt9y1iSQDuZqj
         9e2kyYvefXMNmydy+YpezIlaxFJeeKBF+ULfDeJbBM5c0ro6pHlZ7jx/xyQBXlQlR9r9
         IC2g==
X-Gm-Message-State: ACgBeo08wwA7gBovsKSqSLc74qJE0zqWwf+l6Spo98gyx20Sq61v7aNC
        r+wUM7rkbJQLsu5Gj8HCzgxhpyPiQBI=
X-Google-Smtp-Source: AA6agR40c0UmgQoDgH0XKRnNoM56BWwrDBRTRjeVQxbgdbGAX4ggTdW1UFKwvvhtg1j2vXiIfq9D9w==
X-Received: by 2002:a05:6000:221:b0:225:102b:8faa with SMTP id l1-20020a056000022100b00225102b8faamr588451wrz.24.1660575690950;
        Mon, 15 Aug 2022 08:01:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c14-20020adffb4e000000b002205cbc1c74sm7565757wrs.101.2022.08.15.08.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 08:01:30 -0700 (PDT)
Message-Id: <01c63ea5feefd57721bdcab9f0a30d9c0112e753.1660575688.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1301.v4.git.git.1660575688.gitgitgadget@gmail.com>
References: <pull.1301.v3.git.git.1660575384.gitgitgadget@gmail.com>
        <pull.1301.v4.git.git.1660575688.gitgitgadget@gmail.com>
From:   "Sun Chao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 15 Aug 2022 15:01:26 +0000
Subject: [PATCH v4 1/3] hide-refs: add hook to force hide refs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Sun Chao <16657101987@163.com>, Sun Chao <sunchao9@huawei.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sun Chao <sunchao9@huawei.com>

Gerrit is implemented by JGit and is known as a centralized workflow system
which supports reference-level access control for repository. If we choose
to work in centralized workflow like what Gerrit provided, reference-level
access control is needed and we might add a reference filter hook
`hide-refs` to hide the private data.

This hook would be invoked by 'git-receive-pack' and 'git-upload-pack'
during the reference discovery phase, each reference will be filtered
with this hook. The hook executes once with no arguments for each
'git-upload-pack' and 'git-receive-pack' process. Once the hook is invoked,
a version number and server process name ('uploadpack' or 'receive') will
send to it in pkt-line format, followed by a flush-pkt. The hook should
respond with its version number.

During reference discovery phase, each reference will be filtered by this
hook. In the following example, the letter 'G' stands for 'git-receive-pack'
or 'git-upload-pack' and the letter 'H' stands for this hook. The hook
decides if the reference will be hidden or not, it sends result back in
pkt-line format protocol, a response "hide" means the references will hide
to the client and can not fetch its private data even in protocol V2.

        # Version negotiation
        G: PKT-LINE(version=1\0uploadpack)
        G: flush-pkt
        H: PKT-LINE(version=1)
        H: flush-pkt

        # Send reference filter request to hook
        G: PKT-LINE(ref <refname>:<refname_full>)
        G: flush-pkt

        # Receive result from the hook.
        # Case 1: this reference is hidden
        H: PKT-LINE(hide)
        H: flush-pkt

        # Case 2: this reference can be advertised
        H: flush-pkt

To enable the `hide-refs` hook, we should config hiderefs with `force:`
option, eg:

        git config --add transfer.hiderefs force:refs/prefix1/
        git config --add uploadpack.hiderefs force:!refs/prefix2/

the `hide-refs` will be called during reference discovery phase and
check each matched reference, a 'hide' response means the reference will
be hidden for its private data even if `allowTipSHA1InWant` or
`allowReachableSHA1InWant` are set to true.

Signed-off-by: Sun Chao <sunchao9@huawei.com>
---
 Makefile                  |   1 +
 builtin/receive-pack.c    |   5 +-
 ls-refs.c                 |   2 +-
 refs.c                    | 221 ++++++++++++++++++++++++++++++++++++--
 refs.h                    |   6 ++
 serve.c                   |   2 +
 t/helper/test-hide-refs.c | 152 ++++++++++++++++++++++++++
 t/helper/test-tool.c      |   1 +
 t/helper/test-tool.h      |   1 +
 upload-pack.c             |  32 +++---
 upload-pack.h             |   1 +
 11 files changed, 394 insertions(+), 30 deletions(-)
 create mode 100644 t/helper/test-hide-refs.c

diff --git a/Makefile b/Makefile
index 2ec9b2dc6bb..0c1865370cd 100644
--- a/Makefile
+++ b/Makefile
@@ -793,6 +793,7 @@ TEST_BUILTINS_OBJS += test-wildmatch.o
 TEST_BUILTINS_OBJS += test-windows-named-pipe.o
 TEST_BUILTINS_OBJS += test-write-cache.o
 TEST_BUILTINS_OBJS += test-xml-encode.o
+TEST_BUILTINS_OBJS += test-hide-refs.o
 
 # Do not add more tests here unless they have extra dependencies. Add
 # them in TEST_BUILTINS_OBJS above.
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 31b48e728be..16f2a21e97a 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -296,7 +296,7 @@ static int show_ref_cb(const char *path_full, const struct object_id *oid,
 	struct oidset *seen = data;
 	const char *path = strip_namespace(path_full);
 
-	if (ref_is_hidden(path, path_full))
+	if (ref_is_hidden(path, path_full) || ref_is_force_hidden(path, path_full))
 		return 0;
 
 	/*
@@ -1794,7 +1794,8 @@ static void reject_updates_to_hidden(struct command *commands)
 		strbuf_setlen(&refname_full, prefix_len);
 		strbuf_addstr(&refname_full, cmd->ref_name);
 
-		if (!ref_is_hidden(cmd->ref_name, refname_full.buf))
+		if (!ref_is_hidden(cmd->ref_name, refname_full.buf) &&
+			!ref_is_force_hidden(cmd->ref_name, refname_full.buf))
 			continue;
 		if (is_null_oid(&cmd->new_oid))
 			cmd->error_string = "deny deleting a hidden ref";
diff --git a/ls-refs.c b/ls-refs.c
index 98e69373c84..b5cb1316d38 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -84,7 +84,7 @@ static int send_ref(const char *refname, const struct object_id *oid,
 
 	strbuf_reset(&data->buf);
 
-	if (ref_is_hidden(refname_nons, refname))
+	if (mark_our_ref(refname_nons, refname, oid))
 		return 0;
 
 	if (!ref_match(&data->prefixes, refname_nons))
diff --git a/refs.c b/refs.c
index 90bcb271687..4a6abbfe4fd 100644
--- a/refs.c
+++ b/refs.c
@@ -8,6 +8,7 @@
 #include "lockfile.h"
 #include "iterator.h"
 #include "refs.h"
+#include "pkt-line.h"
 #include "refs/refs-internal.h"
 #include "run-command.h"
 #include "hook.h"
@@ -1296,39 +1297,191 @@ char *shorten_unambiguous_ref(const char *refname, int strict)
 }
 
 static struct string_list *hide_refs;
-
+static struct string_list *force_hide_refs;
+static struct strbuf hide_refs_section = STRBUF_INIT;
 int parse_hide_refs_config(const char *var, const char *value, const char *section)
 {
 	const char *key;
+	int force = 0;
+
 	if (!strcmp("transfer.hiderefs", var) ||
 	    (!parse_config_key(var, section, NULL, NULL, &key) &&
 	     !strcmp(key, "hiderefs"))) {
 		char *ref;
 		int len;
+		int forcelen;
 
 		if (!value)
 			return config_error_nonbool(var);
+
+		forcelen = strlen("force:");
+		len = strlen(value);
+		if ((len >= forcelen) && !strncmp(value, "force:", forcelen)) {
+			if (len == forcelen)
+				return error(_("missing value for '%s' with force option"), var);
+
+			force = 1;
+			value += forcelen;
+		}
+
 		ref = xstrdup(value);
 		len = strlen(ref);
 		while (len && ref[len - 1] == '/')
 			ref[--len] = '\0';
-		if (!hide_refs) {
-			CALLOC_ARRAY(hide_refs, 1);
-			hide_refs->strdup_strings = 1;
+
+		if (force) {
+			if (!force_hide_refs) {
+				CALLOC_ARRAY(force_hide_refs, 1);
+				force_hide_refs->strdup_strings = 1;
+			}
+			string_list_append(force_hide_refs, ref);
+		} else {
+			if (!hide_refs) {
+				CALLOC_ARRAY(hide_refs, 1);
+				hide_refs->strdup_strings = 1;
+			}
+			string_list_append(hide_refs, ref);
 		}
-		string_list_append(hide_refs, ref);
 	}
+
+	if (hide_refs_section.len == 0) {
+		strbuf_addstr(&hide_refs_section, section);
+	}
+
 	return 0;
 }
 
-int ref_is_hidden(const char *refname, const char *refname_full)
+static struct child_process *hide_refs_proc;
+static struct packet_reader *hide_refs_reader;
+static void create_hide_refs_process(void) {
+	struct child_process *proc;
+	struct packet_reader *reader;
+	const char *hook_path;
+	int version = 0;
+	int code;
+
+	hook_path = find_hook("hide-refs");
+	if (!hook_path) {
+		die("can not find hide-refs hook");
+	}
+
+	proc = (struct child_process *) xcalloc (1, sizeof (struct child_process));
+	reader = (struct packet_reader *) xcalloc (1, sizeof(struct packet_reader));
+
+	child_process_init(proc);
+	strvec_push(&proc->args, hook_path);
+	proc->in = -1;
+	proc->out = -1;
+	proc->trace2_hook_name = "hide-refs";
+	proc->err = 0;
+
+	code = start_command(proc);
+	if (code)
+		die("can not run hook hide-refs");
+
+	sigchain_push(SIGPIPE, SIG_IGN);
+
+	/* Version negotiaton */
+	packet_reader_init(reader, proc->out, NULL, 0,
+			   PACKET_READ_CHOMP_NEWLINE |
+			   PACKET_READ_GENTLE_ON_EOF);
+	code = packet_write_fmt_gently(proc->in, "version=1%c%s", '\0', hide_refs_section.buf);
+	if (!code)
+		code = packet_flush_gently(proc->in);
+
+	if (!code)
+		for (;;) {
+			enum packet_read_status status;
+
+			status = packet_reader_read(reader);
+			if (status != PACKET_READ_NORMAL) {
+				/* Check whether hide-refs exited abnormally */
+				if (status == PACKET_READ_EOF)
+					die("can not read version message from hook hide-refs");
+				break;
+			}
+
+			if (reader->pktlen > 8 && starts_with(reader->line, "version=")) {
+				version = atoi(reader->line + 8);
+			}
+		}
+
+	if (code)
+		die("can not read version message from hook hide-refs");
+
+	switch (version) {
+	case 0:
+		/* fallthrough */
+	case 1:
+		break;
+	default:
+		die(_("hook hide-refs version '%d' is not supported"), version);
+	}
+
+	sigchain_pop(SIGPIPE);
+
+	hide_refs_proc = proc;
+	hide_refs_reader = reader;
+	return;
+}
+
+static int ref_force_hidden_check(const char *refname, const char *refname_full)
+{
+	struct strbuf buf = STRBUF_INIT;
+	int code;
+	int ret = 0;
+
+	if (!force_hide_refs) {
+		return 0;
+	}
+
+	if (!hide_refs_proc) {
+		create_hide_refs_process();
+	}
+
+	sigchain_push(SIGPIPE, SIG_IGN);
+	code = packet_write_fmt_gently(hide_refs_proc->in, "ref %s:%s", refname, refname_full);
+	if (code)
+		die("hook hide-refs died abnormally");
+
+	code = packet_flush_gently(hide_refs_proc->in);
+	if (code)
+		die("hook hide-refs died abnormally");
+
+	for (;;) {
+		enum packet_read_status status;
+
+		status = packet_reader_read(hide_refs_reader);
+		if (status != PACKET_READ_NORMAL) {
+			/* Check whether hide-refs exited abnormally */
+			if (status == PACKET_READ_EOF)
+				die("hook hide-refs died abnormally");
+			break;
+		}
+
+		strbuf_reset(&buf);
+		strbuf_addstr(&buf, hide_refs_reader->line);
+	}
+
+	if (!strncmp("hide", buf.buf, 4))
+		ret = 1;
+
+	sigchain_pop(SIGPIPE);
+	return ret;
+}
+
+static int ref_hidden_check(const char *refname, const char *refname_full, int force)
 {
+	struct string_list *hide_refs_list = hide_refs;
 	int i;
 
-	if (!hide_refs)
+	if (force)
+		hide_refs_list = force_hide_refs;
+
+	if (!hide_refs_list)
 		return 0;
-	for (i = hide_refs->nr - 1; i >= 0; i--) {
-		const char *match = hide_refs->items[i].string;
+	for (i = hide_refs_list->nr - 1; i >= 0; i--) {
+		const char *match = hide_refs_list->items[i].string;
 		const char *subject;
 		int neg = 0;
 		const char *p;
@@ -1348,12 +1501,58 @@ int ref_is_hidden(const char *refname, const char *refname_full)
 		/* refname can be NULL when namespaces are used. */
 		if (subject &&
 		    skip_prefix(subject, match, &p) &&
-		    (!*p || *p == '/'))
-			return !neg;
+		    (!*p || *p == '/')) {
+			if (neg)
+				return 0;
+			if (!force)
+				return 1;
+			return ref_force_hidden_check(refname, refname_full);
+		}
 	}
 	return 0;
 }
 
+int ref_is_hidden(const char *refname, const char *refname_full)
+{
+	return ref_hidden_check(refname, refname_full, 0);
+}
+
+int ref_is_force_hidden(const char *refname, const char *refname_full)
+{
+	return ref_hidden_check(refname, refname_full, 1);
+}
+
+#define OUR_REF		(1u << 12)
+#define HIDDEN_REF	(1u << 19)
+#define HIDDEN_REF_FORCE	(1u << 20)
+static int has_force_hidden;
+int mark_our_ref(const char *refname, const char *refname_full,
+			const struct object_id *oid)
+{
+	struct object *o;
+
+	if (!oid || is_null_oid(oid)) {
+		return 0;
+	}
+
+	o = lookup_unknown_object(the_repository, oid);
+	if (ref_is_force_hidden(refname, refname_full)) {
+		o->flags |= HIDDEN_REF_FORCE;
+		has_force_hidden = 1;
+		return 1;
+	}
+	if (ref_is_hidden(refname, refname_full)) {
+		o->flags |= HIDDEN_REF;
+		return 1;
+	}
+	o->flags |= OUR_REF;
+	return 0;
+}
+
+int has_force_hidden_refs(void) {
+	return has_force_hidden;
+}
+
 const char *find_descendant_ref(const char *dirname,
 				const struct string_list *extras,
 				const struct string_list *skip)
diff --git a/refs.h b/refs.h
index 47cb9edbaa8..ae584a644fa 100644
--- a/refs.h
+++ b/refs.h
@@ -818,6 +818,12 @@ int parse_hide_refs_config(const char *var, const char *value, const char *);
  * parameter always points to the full ref name.
  */
 int ref_is_hidden(const char *, const char *);
+int ref_is_force_hidden(const char *, const char *);
+/* return non-zero if the ref is hidden, otherwise 0 */
+int mark_our_ref(const char *refname, const char *refname_full,
+			const struct object_id *oid);
+int has_force_hidden_refs(void);
+void lazy_load_hidden_refs(void);
 
 enum ref_type {
 	REF_TYPE_PER_WORKTREE,	  /* refs inside refs/ but not shared       */
diff --git a/serve.c b/serve.c
index 733347f602a..6b556719d9f 100644
--- a/serve.c
+++ b/serve.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "repository.h"
 #include "config.h"
+#include "refs.h"
 #include "pkt-line.h"
 #include "version.h"
 #include "ls-refs.h"
@@ -320,6 +321,7 @@ void protocol_v2_serve_loop(int stateless_rpc)
 	 * a single request/response exchange
 	 */
 	if (stateless_rpc) {
+		lazy_load_hidden_refs();
 		process_request();
 	} else {
 		for (;;)
diff --git a/t/helper/test-hide-refs.c b/t/helper/test-hide-refs.c
new file mode 100644
index 00000000000..8dcd6700782
--- /dev/null
+++ b/t/helper/test-hide-refs.c
@@ -0,0 +1,152 @@
+#include "cache.h"
+#include "hash.h"
+#include "config.h"
+#include "connect.h"
+#include "parse-options.h"
+#include "pkt-line.h"
+#include "sigchain.h"
+#include "test-tool.h"
+
+static const char *hide_refs_usage[] = {
+	"test-tool hide-refs [<options>...]",
+	NULL
+};
+
+static int die_read_version;
+static int die_write_version;
+static int die_read_first_ref;
+static int die_read_second_ref;
+static int die_after_proc_ref;
+static int verbose;
+static int version = 1;
+static int first_ref;
+static int second_ref;
+static int hash_size = GIT_SHA1_HEXSZ;
+static struct string_list returns = STRING_LIST_INIT_NODUP;
+
+struct command {
+	struct command *next;
+	const char *error_string;
+	unsigned int skip_update:1,
+		     did_not_exist:1;
+	int index;
+	struct object_id old_oid;
+	struct object_id new_oid;
+	char ref_name[FLEX_ARRAY]; /* more */
+};
+
+static void hide_refs_verison(struct packet_reader *reader) {
+	int server_version = 0;
+
+	if (die_read_version)
+		die("die with the --die-read-version option");
+
+	for (;;) {
+		if (packet_reader_read(reader) != PACKET_READ_NORMAL)
+			break;
+
+		/* Ignore version negotiation for version 0 */
+		if (version == 0)
+			continue;
+
+		if (reader->pktlen > 8 && starts_with(reader->line, "version=")) {
+			server_version = atoi(reader->line+8);
+			if (server_version != 1)
+				die("bad protocol version: %d", server_version);
+		}
+	}
+
+	if (die_write_version)
+		die("die with the --die-write-version option");
+
+	packet_write_fmt(1, "version=%d\n", version);
+	packet_flush(1);
+}
+
+static void hide_refs_proc(struct packet_reader *reader)
+{
+	const char *p;
+	struct strbuf buf = STRBUF_INIT;
+	enum packet_read_status status;
+
+	if (!first_ref) {
+		if (die_read_first_ref)
+			die("die with the --die-read-first-ref option");
+
+		first_ref = 1;
+	}
+
+	if (first_ref && !second_ref) {
+		if (die_read_second_ref)
+			die("die with the --die-read-second-ref option");
+
+		second_ref = 1;
+	}
+
+	for (;;) {
+		status = packet_reader_read(reader);
+		if (status == PACKET_READ_EOF)
+			exit(0);
+
+		if (status != PACKET_READ_NORMAL)
+			break;
+
+		p = reader->line;
+		strbuf_reset(&buf);
+		strbuf_addstr(&buf, reader->line);
+	}
+
+	p = strchr(buf.buf, ':');
+	if (unsorted_string_list_has_string(&returns, p + 1)) {
+		packet_write_fmt(1, "hide");
+	}
+
+	if (die_after_proc_ref)
+		die("die with the --die-after-proc-refs option");
+
+	packet_flush(1);
+}
+
+int cmd__hide_refs(int argc, const char **argv) {
+	int nongit_ok = 0;
+	struct packet_reader reader;
+	const char *value = NULL;
+	struct option options[] = {
+		OPT_BOOL(0, "die-read-version", &die_read_version,
+			 "die when reading version"),
+		OPT_BOOL(0, "die-write-version", &die_write_version,
+			 "die when writing version"),
+		OPT_BOOL(0, "die-read-first-ref", &die_read_first_ref,
+			 "die when reading first reference"),
+		OPT_BOOL(0, "die-read-second-ref", &die_read_second_ref,
+			 "die when reading second reference"),
+		OPT_BOOL(0, "die-after-proc-refs", &die_after_proc_ref,
+			 "die after proc ref"),
+		OPT_STRING_LIST('r', "reserved", &returns, "refs-to-force-hidden",
+				"refs that will force hide"),
+		OPT__VERBOSE(&verbose, "be verbose"),
+		OPT_INTEGER('V', "version", &version,
+			    "use this protocol version number"),
+		OPT_END()
+	};
+
+	setup_git_directory_gently(&nongit_ok);
+
+	argc = parse_options(argc, argv, "test-tools", options, hide_refs_usage, 0);
+	if (argc > 0)
+		usage_msg_opt("Too many arguments.", hide_refs_usage, options);
+
+	packet_reader_init(&reader, 0, NULL, 0, PACKET_READ_CHOMP_NEWLINE | PACKET_READ_GENTLE_ON_EOF);
+
+	if (!git_config_get_value("extensions.objectformat", &value)) {
+		if (!strcmp(value, "sha256"))
+			hash_size = GIT_SHA256_HEXSZ;
+	}
+
+	hide_refs_verison(&reader);
+	for (;;) {
+		hide_refs_proc(&reader);
+	}
+
+	return 0;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 318fdbab0c3..0c30be9fe44 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -69,6 +69,7 @@ static struct test_cmd cmds[] = {
 	{ "regex", cmd__regex },
 	{ "repository", cmd__repository },
 	{ "revision-walking", cmd__revision_walking },
+	{ "hide-refs", cmd__hide_refs },
 	{ "run-command", cmd__run_command },
 	{ "scrap-cache-tree", cmd__scrap_cache_tree },
 	{ "serve-v2", cmd__serve_v2 },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index bb799271631..79e9068cbeb 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -58,6 +58,7 @@ int cmd__reftable(int argc, const char **argv);
 int cmd__regex(int argc, const char **argv);
 int cmd__repository(int argc, const char **argv);
 int cmd__revision_walking(int argc, const char **argv);
+int cmd__hide_refs(int argc, const char **argv);
 int cmd__run_command(int argc, const char **argv);
 int cmd__scrap_cache_tree(int argc, const char **argv);
 int cmd__serve_v2(int argc, const char **argv);
diff --git a/upload-pack.c b/upload-pack.c
index b217a1f469e..095d6c4cb40 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -38,9 +38,10 @@
 #define NOT_SHALLOW	(1u << 17)
 #define CLIENT_SHALLOW	(1u << 18)
 #define HIDDEN_REF	(1u << 19)
+#define HIDDEN_REF_FORCE	(1u << 20)
 
-#define ALL_FLAGS (THEY_HAVE | OUR_REF | WANTED | COMMON_KNOWN | SHALLOW | \
-		NOT_SHALLOW | CLIENT_SHALLOW | HIDDEN_REF)
+#define ALL_FLAGS (THEY_HAVE |WANTED | COMMON_KNOWN | SHALLOW | \
+		NOT_SHALLOW | CLIENT_SHALLOW)
 
 /* Enum for allowed unadvertised object request (UOR) */
 enum allow_uor {
@@ -1155,20 +1156,6 @@ static void receive_needs(struct upload_pack_data *data,
 		packet_flush(1);
 }
 
-/* return non-zero if the ref is hidden, otherwise 0 */
-static int mark_our_ref(const char *refname, const char *refname_full,
-			const struct object_id *oid)
-{
-	struct object *o = lookup_unknown_object(the_repository, oid);
-
-	if (ref_is_hidden(refname, refname_full)) {
-		o->flags |= HIDDEN_REF;
-		return 1;
-	}
-	o->flags |= OUR_REF;
-	return 0;
-}
-
 static int check_ref(const char *refname_full, const struct object_id *oid,
 		     int flag, void *cb_data)
 {
@@ -1454,6 +1441,7 @@ static int parse_want_ref(struct packet_writer *writer, const char *line,
 
 		strbuf_addf(&refname, "%s%s", get_git_namespace(), refname_nons);
 		if (ref_is_hidden(refname_nons, refname.buf) ||
+			ref_is_force_hidden(refname_nons, refname.buf) ||
 		    read_ref(refname.buf, &oid)) {
 			packet_writer_error(writer, "unknown ref %s", refname_nons);
 			die("unknown ref %s", refname_nons);
@@ -1695,6 +1683,12 @@ enum fetch_state {
 	FETCH_DONE,
 };
 
+static int lazy_load_hidden = 0;
+// lazy load hidden refs for protocol V2
+void lazy_load_hidden_refs(void) {
+	lazy_load_hidden = 1;
+}
+
 int upload_pack_v2(struct repository *r, struct packet_reader *request)
 {
 	enum fetch_state state = FETCH_PROCESS_ARGS;
@@ -1740,6 +1734,12 @@ int upload_pack_v2(struct repository *r, struct packet_reader *request)
 				state = FETCH_DONE;
 			break;
 		case FETCH_SEND_PACK:
+			if (lazy_load_hidden) {
+				head_ref_namespaced(check_ref, NULL);
+				for_each_namespaced_ref(check_ref, NULL);
+			}
+			if (has_force_hidden_refs())
+				check_non_tip(&data);
 			send_wanted_ref_info(&data);
 			send_shallow_info(&data);
 
diff --git a/upload-pack.h b/upload-pack.h
index d6ee25ea98e..541610ba800 100644
--- a/upload-pack.h
+++ b/upload-pack.h
@@ -12,4 +12,5 @@ struct strbuf;
 int upload_pack_advertise(struct repository *r,
 			  struct strbuf *value);
 
+void lazy_load_hidden_refs(void);
 #endif /* UPLOAD_PACK_H */
-- 
gitgitgadget

