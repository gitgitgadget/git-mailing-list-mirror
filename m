Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B79ECAAD8
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 08:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbiITIZx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 04:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbiITIZG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 04:25:06 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807125B7B1
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 01:22:53 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id c2-20020a1c3502000000b003b2973dafb7so6368067wma.2
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 01:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=DwTWJ6N47SM/rdtyan7U+NESnFMlwr8QaBDguqQpB/U=;
        b=oqL50cxpT9jmhkvII4XiVVmNB88wTSJjjShzjn3G5z8Eka2A5omf3IvIJVGnH2IHIr
         4uBnVpCQgTsUC1JJ6av7B2k27QcmTwYiQPWSu8r9vAnlv2ztY76SXBsAN1s94lM4sNJg
         +nLNcItOfKQWWBi71AjoW3l0HSYLHqEmJoez4lbWSeL0igaMPaTwJADN4o8tzUpWQD0X
         wTnQnedLhwLfqoNUnes51TT1ETDo2D/2LdbuL58JEJ2ByuRjJUyJ0ntJNhc/QbSSpa4j
         E3rBihOH4mAftq9K7mpBqFM9im6zn7mA39AZlQ28vJ8qhFwnFFnIlc7MTEogOBvk0lTg
         MOIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=DwTWJ6N47SM/rdtyan7U+NESnFMlwr8QaBDguqQpB/U=;
        b=VAjdS5FafExMNZ4eHlAucBjSuu6yAoR4Zohiw6RER/8g+/c26mjJGmcvoxH1VkMY+H
         tccKcFU7LeUoJANWFa5snvp2JtJ3Hbus9O03o1GSUheoJesoOSENyFYRMxb2+RGqZ1gV
         q+nM1cKFBEE+tlsjR1dLlmuqdSLRASvTeYGfm9JAAEQZsL2iSw1tH7HdFk0ZupxVPeJL
         eYcACh/2utiBk7kvvAN83aHozeogiKVl/W6u1ymVIogV+azuk+pvA7GXo6ZsUpl5xdWl
         OXsHUuciep5KEBlU0MVrPzItxMeJZW3b8+JcQQoUTvpgLeie8Jc03AYG1sUkC6Ve7uZf
         rJzA==
X-Gm-Message-State: ACrzQf18kwVEypAgeNSi3uLsgiWMWuXSEwj2E1HRmQRpDJSRvzxwH42Y
        L803FhyMkjfzNT6dv7YQjM7X4XY/UJQ=
X-Google-Smtp-Source: AMsMyM6RBUJ0Gqk6usgETwS06YzIoTKc+yS1eEgs+q59kNs4w5vpP2WuRjMVr3nHeRejE04I1dcCXA==
X-Received: by 2002:a05:600c:3d93:b0:3b4:c28f:6a2b with SMTP id bi19-20020a05600c3d9300b003b4c28f6a2bmr1448675wmb.121.1663662169539;
        Tue, 20 Sep 2022 01:22:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o17-20020a05600c511100b003b4935f04a4sm2085393wms.5.2022.09.20.01.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 01:22:49 -0700 (PDT)
Message-Id: <99402c1b89fd6dcaf23cd43e5df91d3ac850ebca.1663662167.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1301.v6.git.git.1663662167.gitgitgadget@gmail.com>
References: <pull.1301.v5.git.git.1662735985.gitgitgadget@gmail.com>
        <pull.1301.v6.git.git.1663662167.gitgitgadget@gmail.com>
From:   "Sun Chao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Sep 2022 08:22:43 +0000
Subject: [PATCH v6 1/5] hiderefs: add hide-refs hook to hide refs dynamically
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

Muti-branch workflows are used in some development scenarios, especially
for large teams, where different small teams are assigned to implement
different features on different branches or to develop secret features
on special branches.

If we can control the visible reference list based on developer
permissions, we can reduce the interference between reference lists of
different teams, and can achieve the protection of critical core code
(only certain team members can see it before making it public). This
kind of reference management makes sense, and on some platforms, sunch
as Gerrit implement it through server-side reference access control.

We can use '{transfer,uploadpack,receive}.hiderefs' config items to
control which references need to hide from clients, but the config items
are static and cannot satisfy the above requirements. We need the Git
server to hide references according to the user's permissions, we can
try to implement this mechanism by introducing a server-side hook
'hide-refs' to dynamically hide references during reference discovery
phase.

This hook would be invoked by 'git-receive-pack' and 'git-upload-pack'
during the reference discovery phase, each reference will be filtered
with this hook. The hook executes once with no arguments for each
'git-upload-pack' and 'git-receive-pack' process. Once the hook is invoked,
a version number and server process name ('uploadpack' or 'receive') will
send to it in pkt-line format, followed by a flush-pkt. The hook should
respond with its version number.

During reference discovery phase, each reference will be filtered by this
hook. In the following example, the letter 'G' stands for 'git-receive-pack'
or 'git-upload-pack', and the letter 'H' stands for this hook. The hook
decides if the reference will be hidden or not, and it sends the result
back in pkt-line format protocol, a response "hide" means the references
will be hidden to the client.

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

To enable the `hide-refs` hook, we should config hiderefs with `hook:`
option, e.g. if we want to pass all the refs to the new hook except for
the tags:

        git config --add transfer.hiderefs hook:
        git config --add transfer.hiderefs hook:!refs/tags/

Signed-off-by: Sun Chao <sunchao9@huawei.com>
---
 refs.c | 250 ++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 228 insertions(+), 22 deletions(-)

diff --git a/refs.c b/refs.c
index 92819732ab7..68368055946 100644
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
@@ -1384,39 +1385,221 @@ char *shorten_unambiguous_ref(const char *refname, int strict)
 }
 
 static struct string_list *hide_refs;
+static struct string_list *hook_hide_refs;
+static struct strbuf hide_refs_section = STRBUF_INIT;
 
 int parse_hide_refs_config(const char *var, const char *value, const char *section)
 {
+	struct string_list **refs_list= &hide_refs;
 	const char *key;
-	if (!strcmp("transfer.hiderefs", var) ||
-	    (!parse_config_key(var, section, NULL, NULL, &key) &&
-	     !strcmp(key, "hiderefs"))) {
-		char *ref;
-		int len;
-
-		if (!value)
-			return config_error_nonbool(var);
-		ref = xstrdup(value);
-		len = strlen(ref);
-		while (len && ref[len - 1] == '/')
-			ref[--len] = '\0';
-		if (!hide_refs) {
-			CALLOC_ARRAY(hide_refs, 1);
-			hide_refs->strdup_strings = 1;
+	char *ref;
+	int len;
+
+	if (strcmp("transfer.hiderefs", var) &&
+	    !(!parse_config_key(var, section, NULL, NULL, &key) &&
+	      !strcmp(key, "hiderefs")))
+		return 0;
+
+	if (!value)
+		return config_error_nonbool(var);
+
+	if (skip_prefix(value, "hook:", &value)) {
+		refs_list = &hook_hide_refs;
+
+		/*
+		 * Once the 'hide-refs' hook is invoked, Git needs to do
+		 * version negotiation with it, the version number and the
+		 * process name ('uploadpack' or 'receive') will send to
+		 * it in pkt-line format, and the process name is recorded
+		 * by hide_refs_section
+		 */
+		if (hide_refs_section.len == 0)
+			strbuf_addstr(&hide_refs_section, section);
+	}
+
+	ref = xstrdup(value);
+	len = strlen(ref);
+	while (len && ref[len - 1] == '/')
+		ref[--len] = '\0';
+
+	if (!*refs_list) {
+		CALLOC_ARRAY(*refs_list, 1);
+		(*refs_list)->strdup_strings = 1;
+	}
+	string_list_append(*refs_list, ref);
+
+	return 0;
+}
+
+static struct child_process *hide_refs_proc;
+static struct packet_reader *hide_refs_reader;
+
+/*
+ * Create the hide-refs hook child process and complete version negotiation,
+ * return non-zero upon success, otherwise 0
+ */
+static int create_hide_refs_process(void)
+{
+	struct child_process *proc;
+	struct packet_reader *reader;
+	const char *hook_path;
+	int version = 0;
+	int err;
+
+	hook_path = find_hook("hide-refs");
+	if (!hook_path)
+		return 0;
+
+	proc = (struct child_process *)xcalloc(1, sizeof (struct child_process));
+	reader = (struct packet_reader *)xcalloc(1, sizeof(struct packet_reader));
+
+	child_process_init(proc);
+	strvec_push(&proc->args, hook_path);
+	proc->in = -1;
+	proc->out = -1;
+	proc->trace2_hook_name = "hide-refs";
+	proc->err = 0;
+
+	err = start_command(proc);
+	if (err)
+		goto cleanup;
+
+	sigchain_push(SIGPIPE, SIG_IGN);
+
+	/* Version negotiaton */
+	packet_reader_init(reader, proc->out, NULL, 0,
+			   PACKET_READ_CHOMP_NEWLINE | PACKET_READ_GENTLE_ON_EOF);
+	err = packet_write_fmt_gently(proc->in, "version=1%c%s", '\0', hide_refs_section.buf);
+	if (!err)
+		err = packet_flush_gently(proc->in);
+
+	if (!err)
+		for (;;) {
+			enum packet_read_status status;
+
+			status = packet_reader_read(reader);
+			if (status != PACKET_READ_NORMAL) {
+				/* Check whether hide-refs exited abnormally */
+				if (status == PACKET_READ_EOF)
+					goto failure;
+				break;
+			}
+
+			if (reader->pktlen > 8 && starts_with(reader->line, "version=")) {
+				version = atoi(reader->line + 8);
+			}
 		}
-		string_list_append(hide_refs, ref);
+
+	if (err)
+		goto failure;
+
+	switch (version) {
+	case 0:
+		/* fallthrough */
+	case 1:
+		break;
+	default:
+		trace_printf(_("hook hide-refs version '%d' is not supported"), version);
+		goto failure;
 	}
+
+	sigchain_pop(SIGPIPE);
+
+	hide_refs_proc = proc;
+	hide_refs_reader = reader;
+	return 1;
+
+failure:
+	close(proc->in);
+	close(proc->out);
+	kill(proc->pid, SIGTERM);
+	finish_command_in_signal(proc);
+
+cleanup:
+	free(proc);
+	free(reader);
+	sigchain_pop(SIGPIPE);
 	return 0;
 }
 
-int ref_is_hidden(const char *refname, const char *refname_full)
+/* If hide-refs child process start failed, set skip_hide_refs_proc to true */
+static int skip_hide_refs_proc;
+
+/*
+ * Return non-zero if hide-refs hook want to hide the ref and 0 otherwise,
+ * and return 0 if hide-refs child proccess start failed or exit abnormally
+ */
+static int ref_hidden_check_by_hook(const char *refname, const char *refname_full)
+{
+	struct strbuf buf = STRBUF_INIT;
+	int err;
+	int ret = 0;
+
+	if (skip_hide_refs_proc)
+		return 0;
+
+	if (!hide_refs_proc)
+		if (!create_hide_refs_process()) {
+			skip_hide_refs_proc = 1;
+			return 0;
+		}
+
+	sigchain_push(SIGPIPE, SIG_IGN);
+	err = packet_write_fmt_gently(hide_refs_proc->in, "ref %s:%s", refname, refname_full);
+	if (err)
+		goto cleanup;
+
+	err = packet_flush_gently(hide_refs_proc->in);
+	if (err)
+		goto cleanup;
+
+	for (;;) {
+		enum packet_read_status status;
+
+		status = packet_reader_read(hide_refs_reader);
+		if (status != PACKET_READ_NORMAL) {
+			/* Check whether hide-refs exited abnormally */
+			if (status == PACKET_READ_EOF)
+				goto cleanup;
+			break;
+		}
+
+		strbuf_addstr(&buf, hide_refs_reader->line);
+	}
+
+	if (!strncmp("hide", buf.buf, 4))
+		ret = 1;
+
+	sigchain_pop(SIGPIPE);
+	return ret;
+
+cleanup:
+	close(hide_refs_proc->in);
+	close(hide_refs_proc->out);
+	kill(hide_refs_proc->pid, SIGTERM);
+	finish_command_in_signal(hide_refs_proc);
+
+	free(hide_refs_proc);
+	free(hide_refs_reader);
+	sigchain_pop(SIGPIPE);
+
+	skip_hide_refs_proc = 1;
+	return 0;
+}
+
+static int ref_hidden_check(const char *refname, const char *refname_full, int hook)
 {
+	struct string_list *hide_refs_list = hide_refs;
 	int i;
+	int match_all = 0;
 
-	if (!hide_refs)
+	if (hook)
+		hide_refs_list = hook_hide_refs;
+	if (!hide_refs_list)
 		return 0;
-	for (i = hide_refs->nr - 1; i >= 0; i--) {
-		const char *match = hide_refs->items[i].string;
+
+	for (i = hide_refs_list->nr - 1; i >= 0; i--) {
+		const char *match = hide_refs_list->items[i].string;
 		const char *subject;
 		int neg = 0;
 		const char *p;
@@ -1426,6 +1609,12 @@ int ref_is_hidden(const char *refname, const char *refname_full)
 			match++;
 		}
 
+		/* empty string with the 'hook:' option matches all the refs */
+		if (hook && !*match) {
+			match_all = !neg;
+			continue;
+		}
+
 		if (*match == '^') {
 			subject = refname_full;
 			match++;
@@ -1436,9 +1625,26 @@ int ref_is_hidden(const char *refname, const char *refname_full)
 		/* refname can be NULL when namespaces are used. */
 		if (subject &&
 		    skip_prefix(subject, match, &p) &&
-		    (!*p || *p == '/'))
-			return !neg;
+		    (!*p || *p == '/')) {
+			if (neg)
+				return 0;
+			if (!hook)
+				return 1;
+			return ref_hidden_check_by_hook(refname, refname_full);
+		}
 	}
+
+	if (hook && match_all)
+		return ref_hidden_check_by_hook(refname, refname_full);
+
+	return 0;
+}
+
+int ref_is_hidden(const char *refname, const char *refname_full)
+{
+	if (ref_hidden_check(refname, refname_full, 0) ||
+	    ref_hidden_check(refname, refname_full, 1))
+		return 1;
 	return 0;
 }
 
-- 
gitgitgadget

