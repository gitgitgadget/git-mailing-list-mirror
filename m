Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 841F0ECAAA1
	for <git@archiver.kernel.org>; Fri,  9 Sep 2022 15:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbiIIPGe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Sep 2022 11:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbiIIPGc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2022 11:06:32 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163201398AF
        for <git@vger.kernel.org>; Fri,  9 Sep 2022 08:06:30 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id az6so1606867wmb.4
        for <git@vger.kernel.org>; Fri, 09 Sep 2022 08:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=pIG82mq/Y3cFYjwIHAD0Rz74+6bfAtDlCiMLrgOVCn8=;
        b=gEbhnVNA6DYZBvKKOnIINftoumiuedsvB6WNWKcGhEdVLt8kbT2g/ZE9Y0V3YWwpNl
         kavR2SFfVoLhOUY4fZRySXNGJdIaqzdxPV3kHuwdplpC/714Eis7Oc5M5JEc/gZkLJf3
         2gVXXQ8QdTNGqBHuAGxuUyKZeyYLcqStPjkpheutncpztnHdXG488oT3qSaf36C3eJvN
         Z+z72zDLEiGYS7qjcddtAm3nQMWvZEY2n1Tq7zP947Mjx6PHKjlW50EB+Xot8D1fgCGQ
         RhNOqts9JDG3JNAosNAbCJ475jvMUvad/VGvyY6uHENO5St6YB4t5M7lyc9iKHfWQ/cH
         85lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=pIG82mq/Y3cFYjwIHAD0Rz74+6bfAtDlCiMLrgOVCn8=;
        b=reeKhH8UiXPjRYHZVYLGMGVztw+WHTuux1BCpdzzPsS60MsNq9oaI4zdQUAHK8XfKX
         G4DD0HEbBpmq9uhmRfZnyu8pIUHEn26A4sieip15qMZWpOhuyc9gRMmY7UqNTU/ffrmi
         zkVCdHzfnIzlQYQSfte1H7o5R3ykpu/TUpBTxugCkRbRhLnTWGVwKSLsNLcBTueBPMng
         Uzz2Cvxns5HyvnQWtU0xb03IyTKnxV4ny8MlI3dtJxkD+C/JNqBdhK8vvea4zNHhgw7F
         RgQuyxPlwycqmbpVh7P7n/pxKksSj3ZseNV4agewJoYtr6165ltSHruz+PT8iDpL970A
         M9sA==
X-Gm-Message-State: ACgBeo1VEuosPXJJ0TzMz8WJWfHM6VGbODNzacQYwyI/xrdjQ83UB44F
        8dkFfLiX5XGvJDIB4Qkc+oCspwVZOHE=
X-Google-Smtp-Source: AA6agR7rFUM75DvhtesytSQPD93TT7ZOgn5oY8FIFsExT14j5H5sLobalQGnpmHMUkETsD9bNycd0Q==
X-Received: by 2002:a1c:770f:0:b0:3a5:ef7f:2973 with SMTP id t15-20020a1c770f000000b003a5ef7f2973mr5793371wmi.111.1662735988301;
        Fri, 09 Sep 2022 08:06:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l10-20020a5d560a000000b00226d1711276sm761183wrv.1.2022.09.09.08.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 08:06:27 -0700 (PDT)
Message-Id: <278bd185aec26285f8c00aca838f89e5f3877748.1662735985.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1301.v5.git.git.1662735985.gitgitgadget@gmail.com>
References: <pull.1301.v4.git.git.1660575688.gitgitgadget@gmail.com>
        <pull.1301.v5.git.git.1662735985.gitgitgadget@gmail.com>
From:   "Sun Chao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 09 Sep 2022 15:06:21 +0000
Subject: [PATCH v5 1/5] hiderefs: add hide-refs hook to hide refs dynamically
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
pkt-line format protocol, a response "hide" means the references will be
hidden to the client.

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
option, eg:

        git config --add transfer.hiderefs hook:refs/prefix1/
        git config --add uploadpack.hiderefs hook:!refs/prefix2/

Signed-off-by: Sun Chao <sunchao9@huawei.com>
---
 refs.c | 229 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 219 insertions(+), 10 deletions(-)

diff --git a/refs.c b/refs.c
index 92819732ab7..a99734fedcd 100644
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
@@ -1384,10 +1385,14 @@ char *shorten_unambiguous_ref(const char *refname, int strict)
 }
 
 static struct string_list *hide_refs;
+static struct string_list *hook_hide_refs;
+static struct strbuf hide_refs_section = STRBUF_INIT;
 
 int parse_hide_refs_config(const char *var, const char *value, const char *section)
 {
 	const char *key;
+	int hook = 0;
+
 	if (!strcmp("transfer.hiderefs", var) ||
 	    (!parse_config_key(var, section, NULL, NULL, &key) &&
 	     !strcmp(key, "hiderefs"))) {
@@ -1396,27 +1401,218 @@ int parse_hide_refs_config(const char *var, const char *value, const char *secti
 
 		if (!value)
 			return config_error_nonbool(var);
+
+		/*
+		 * the prefix 'hook:' means that the matched refs will be
+		 * checked by the hide-refs hook dynamically, we need to put
+		 * the 'ref' string to the hook_hide_refs list
+		 */
+		if (skip_prefix(value, "hook:", &value)) {
+			if (!strlen(value))
+				return error(_("missing value for '%s' after hook option"), var);
+			hook = 1;
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
+		if (hook) {
+			if (!hook_hide_refs) {
+				CALLOC_ARRAY(hook_hide_refs, 1);
+				hook_hide_refs->strdup_strings = 1;
+			}
+			string_list_append(hook_hide_refs, ref);
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
+	/*
+	 * Once hide-refs hook is invoked, Git need to do version negotiation,
+	 * with it, version number and process name ('uploadpack' or 'receive')
+	 * will send to it in pkt-line format, the proccess name is recorded
+	 * by hide_refs_section
+	 */
+	if (hook && hide_refs_section.len == 0)
+		strbuf_addstr(&hide_refs_section, section);
+
 	return 0;
 }
 
-int ref_is_hidden(const char *refname, const char *refname_full)
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
+		}
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
+	}
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
+	return 0;
+}
+
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
 
-	if (!hide_refs)
+	if (hook)
+		hide_refs_list = hook_hide_refs;
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
@@ -1436,12 +1632,25 @@ int ref_is_hidden(const char *refname, const char *refname_full)
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
 	return 0;
 }
 
+int ref_is_hidden(const char *refname, const char *refname_full)
+{
+	if (ref_hidden_check(refname, refname_full, 0) ||
+	    ref_hidden_check(refname, refname_full, 1))
+		return 1;
+	return 0;
+}
+
 const char *find_descendant_ref(const char *dirname,
 				const struct string_list *extras,
 				const struct string_list *skip)
-- 
gitgitgadget

