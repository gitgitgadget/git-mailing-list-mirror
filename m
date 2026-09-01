Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4ADD42902D
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 15:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788275978; cv=none; b=RQKzwLaRm9eH/azTYrDC9dp+0mubP8IAMnNlP1JJqk1fTDeJK6Rkj8SohY+MEJn/QIBNL6jaF9Foc1hqz2uoq+ZfQB5vre4SXQAkhziqJmHiKc3bPUuDQC38V7UBmZlJ+0pZYhpdcMXR5Ef992IoSs1evuRNCnGVE4Rp1q7CfO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788275978; c=relaxed/simple;
	bh=dtnv/l9RpvuKX3CurbHGEh/oyGj9ik2nxFz4SwMRkDk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P4h1jGLo12u1Hlfs4L4rtqspaUW4xvH3c1pFZLdmlb7afoxj/e+/eqUUCFjWzZA8vEKQ2VLvJy2YWrcpogMEdSNdrBrztpZrjInt5nGaMyDGiOfvhcJXSj63h4HolcCajhFqkqAbNRX2TGVTxKYNbvHaep40OExmO93weYe6vlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qGltDgJj; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qGltDgJj"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4956869750eso33490805e9.2
        for <git@vger.kernel.org>; Tue, 01 Sep 2026 08:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788275974; x=1788880774; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fkf162h5lhbd4LWLFy023NFgJWUSCDdoDiSNBNKSErk=;
        b=qGltDgJjYQXodTFzhcvH3IIjBHQQ7G48VzEPsIadFXZu35g7yLjs1rVvmzfO484BLc
         a9ixC3/UAK9qvayAh/djlaiiFMNwq5TogCftFdMPNwOzf+zLw7Gu+zRIQ8WSdt6WhTy3
         o9q28z7eVWIJrMvJ2phCU3HreNnqQgkaqKUCd+JulsRdY/dhvVqr+GqF0uK2WMq2APB6
         6554Gj3VvjHULEC++pKhhSYeLF6FCRLKgnNYy7G1DpqlK1pS2/CVwVRxLCxQSDrQ/hOt
         MCpHfTG11Q9QC8AxH0TFTfadEh0v80p2AVaoxiYwKcl/CVWdTBLdpP8VoiDWLwlpDL+s
         rW/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788275974; x=1788880774;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fkf162h5lhbd4LWLFy023NFgJWUSCDdoDiSNBNKSErk=;
        b=ZJI0qmbfu6wDINlpTz1Dc8MbYE3azfCd1MXbRzCokIiAWAIXzq/2JgRZOtoUb4xNj1
         kooGR2XF7czEuqK4SATFzuGiYhKJBeugUgNTD8vBF5pbcF6JRpOMv+68R/m2U8meeoRm
         4qt3Zynb9Ay7pRVM77llb/plpsHwc5Ul3YAkc/oQsNwsjC7vpiVCGSui9hOEmygJMSen
         2RdkIH+RfeC+DKvhMPjeyoglUFazBNm8LvOS5pRhi+daFKSNmFaLjTlEMXyem3Ik10Of
         E+APx5T6Jqhvi+Iqfs95P5EZ6hTaT3lYieDV4an8VG9M5ELWZWfnRq+u67rw4cQUXtRd
         PCww==
X-Gm-Message-State: AFuF++lb9JANtAy7eFQJ8UjxeRtPMqJNroU7DKEgLwh8DUv+NjipMarX
	dZbkpN3i7JKRVB2nk1voOuxhS8JFX9v0/93mwuTbhrCg8lVYqbMO0YXP
X-Gm-Gg: AR+sD11XR07sFrZlobo/IoJKDvGsLE94OtxcS6fJjW3Du/dsmEHm6gWuIgBrWsnul9W
	T//D+kTgyLkZCep5HLhcsgpPEKse9HbnX3htPNaQEidecPj7YiKXl3rIH/6zp7WtiPdmmvJnuav
	c/Gi7JellDlLXf+NFEomClxjuvupCc3LY6+2aqcZ1DVWcq8FN8tPKRgdovqGuDxodniYqXl8IVj
	rHhj0XGIlO/ic0SCFGV5QA1jJVantqRLMDRpcSePIRI7SJFQXIpkNZMYH2gdFeNSCTJIjgrYu8K
	0HcL3SeLgr+YgY+DB5/h6G0km+vTY/SMJV621ECKxGvNaJvpOCJyhbUhDlo4XYL9KwLSXoB3J2Q
	kNIz2FM2V6b/8ioLw8XPAiohUKUEnyAGn+H1ksP/SJ0ARx47SJ8vv12nWgM1/MMUb6v8lkHy/ua
	wag1Sxdzl1sXOMv49yViDPAOcNjuOXBlt2wCnHHvO7LnHXaGQ7oVvo/PsTB+8pCcKFcvWiVs5Qr
	4qhRusJaqAQb2sZlOicKd+FtDY=
X-Received: by 2002:a05:600c:a03:b0:499:93b3:91ea with SMTP id 5b1f17b1804b1-49b91c5096dmr517974485e9.15.1788275973707;
        Tue, 01 Sep 2026 08:19:33 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:645f:6387:edab:db53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce309e418sm17270605e9.13.2026.09.01.08.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 08:19:32 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 01 Sep 2026 17:19:25 +0200
Subject: [PATCH v5 3/3] hook: introduce the receive-report hook
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-758-introduce-hook-v5-3-35cdc6be3cc1@gmail.com>
References: <20260901-758-introduce-hook-v5-0-35cdc6be3cc1@gmail.com>
In-Reply-To: <20260901-758-introduce-hook-v5-0-35cdc6be3cc1@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, gitster@pobox.com, jltobler@gmail.com, 
 kristofferhaugsbakk@fastmail.com, Karthik Nayak <karthik.188@gmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=17836;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=dtnv/l9RpvuKX3CurbHGEh/oyGj9ik2nxFz4SwMRkDk=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGqW7P8q9mKTw+zMtbcGMyaKtLYMLSzYEbyK2
 K810+TrlhgSTIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJqluz/AAoJED7VnySO
 Rox/ZSAL/jpCgUREISmGgI0rGwfOapcb0figZCfZW9Ys4/bgr5EuTe4oDn3jbIf8FgPdqY2Aqzn
 QefB7JM5vE+dP7ycbrUms6HhcZ83uctk9lZp6Ojev2GNV7o15WWJHCRep0ePsdB08ltxNRHrwO2
 XXW+gU1YJpDkVQWJyHxNIBbKgcRzbQXaPKxMKjxF2VRZtef0mWAEx062AVORxGL9avM5VtxKQVU
 SmIOra0bhO++ufSSpXUwmGV0s4TYJ9vOIDVGzyiXGS6w7UFI9QdbBUwW5hezfQLMMBkZz+n3B6F
 +cC+EQXPqlx47hK0s46Z8j9JUYMGsYnV0C5pJd+xzkiukp/7IdaDIu8lIzfnx0Es31ekN0CxHSm
 tl8ZiNOYZXK4iON5tVfMg2zYRYlcvJjnrLPmZnyL4xQ8Iwimc5jXEJMOCQe2DDxT1tFjz+SCjXI
 vhprluxmat5nkGAJ4SwXf4h8gfl37kuG/gHE54hG/U+Wz1XLvEyNimVN67h/IpOvkzXbhEx6286
 7w=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

When running 'git-receive-pack(1)', there is no way for the server to
intercept and modify the status report before it is sent back to the
client. Servers with custom logic may need to transform or gate the
report based on the outcome of external logic post reference updates.

This is specially needed for our usecase at GitLab where we have custom
MVCC logic on top of Git which creates a new version for each push
operation. The new version is only committed when certain external
operations post reference transaction succeed. So reporting the correct
message based on the outcome of these operations is important.

We cannot use any of the existing hooks as:

  - The pre-receive hook runs too early, as we haven't updated
    references at that point yet and we need to have the full view of
    all resulting updates (both objects and references).

  - The update hook is too inefficient as it runs once per reference,
    and we cannot trivially determine the last update.

  - The reference-transaction hook cannot be used by us because we care
    about the phase where it was committed already. And while the hook
    fires in that phase, it does not allow the caller to modify the
    result in any capacity.

  - The post-receive and post-update hooks cannot be used as they run
    too late, at the point where we have already reported success to the
    client.

Introduce a new 'receive-report' hook. The hook receives the complete
pkt-line encoded status report on standard input, after all ref updates
have been applied to the repository by execute_commands() but before the
report is sent to the client. See linkgit:gitprotocol-pack[5] details on
the protocol structure.

The hook's stdout fully replaces the report sent to the client.
receive-pack fully buffers the hook's stdout before acting on the exit
status, so the exit code is known before the client receives anything.
This gives two distinct behaviors depending on exit status:

- Exit 0: the hook's stdout is used as the report. The hook can
  rewrite 'ok' lines to 'ng' lines to signal per-ref rejection to the
  client while receive-pack itself exits cleanly. The client marks
  rejected refs as '[remote rejected]' and exits with a non-zero
  status if any ref is 'ng'.

- Non-zero exit: the hook's stdout is discarded, receive-pack modifies
  all references to be rejected with a 'receive-report hook failed'
  error.

In both cases, any output the hook writes to standard error is
forwarded to the client over the sideband channel and appears as
'remote:' lines on the client terminal. Writing to stderr alone does
not affect the push outcome.

Note that in either failure mode, ref updates already applied by
execute_commands() are not rolled back. The hook can cause the client
to perceive the push as failed, but cannot undo server-side changes.

This hook does not use the config-based hook infrastructure, which
supports running multiple scripts per hook event. This hook is a
bidirectional filter: it receives the report on stdin and writes a
modified version to stdout. Running multiple such scripts sequentially
would require piping the output of one into the input of the next,
which the current hook infrastructure does not support. A single-script
design is therefore a natural fit, and is consistent with how
'proc-receive' is structured for the same reason.

Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-receive-pack.adoc |   9 ++
 Documentation/githooks.adoc         |  47 ++++++++
 builtin/receive-pack.c              |  54 +++++++++
 t/meson.build                       |   1 +
 t/t5412-receive-report-hook.sh      | 224 ++++++++++++++++++++++++++++++++++++
 5 files changed, 335 insertions(+)

diff --git a/Documentation/git-receive-pack.adoc b/Documentation/git-receive-pack.adoc
index 5806792ba7..ab668ffa0c 100644
--- a/Documentation/git-receive-pack.adoc
+++ b/Documentation/git-receive-pack.adoc
@@ -245,6 +245,15 @@ commands will be executed by this hook, instead of by the internal
 `execute_commands()` function.  This hook is responsible for updating
 the relevant references and reporting the results back to 'receive-pack'.
 
+RECEIVE-REPORT HOOK
+-------------------
+This hook is invoked by 'git-receive-pack' after all the ref updates
+have been applied but before the report is sent to the client. The hook
+receives the complete report in pkt-line format on stdin and its stdout
+replaces the report sent to the client, which allows the hook to rewrite
+the outcomes or abort the push completely. See linkgit:githooks[5] for
+the full protocol description.
+
 QUARANTINE ENVIRONMENT
 ----------------------
 
diff --git a/Documentation/githooks.adoc b/Documentation/githooks.adoc
index ed045940d1..5ac5bf9454 100644
--- a/Documentation/githooks.adoc
+++ b/Documentation/githooks.adoc
@@ -527,6 +527,53 @@ The exit status of the hook is ignored for any state except for the
 status will cause the transaction to be aborted. The hook will not be
 called with "aborted" state in that case.
 
+receive-report
+~~~~~~~~~~~~~~
+
+This hook is invoked by linkgit:git-receive-pack[1] when it reacts to
+`git push` and updates references in its repository. It executes on
+the repository once after all refs have been updated and after all
+accepted ref changes are applied to the repository, but before the
+pkt-line encoded status report is sent back to the client.
+
+The hook receives the complete pkt-line encoded status report on
+standard input, see linkgit:gitprotocol-pack[5] for details on the
+structure. The hook's standard output entirely replaces the report
+that is sent to the client. The hook must write a valid pkt-line
+encoded report in the same format it received. The hook's stdout is
+fully buffered by `receive-pack` before any data is sent to the client,
+so the hook's exit status is known before the client receives anything.
+
+There are three distinct ways the hook can affect the push outcome:
+
+* To reject the push, modify the unpack status from `ok` to the required
+  error message. While `git-push` will fail, individual references may
+  still show success messages unless modified.
+
+* To reject individual ref updates while keeping `receive-pack` alive,
+  rewrite the corresponding `ok <refname>` lines to
+  `ng <refname>[ <reason>]` lines in the output and exit with status 0.
+  The client will then mark those specific refs as rejected while
+  treating any `ok` refs as successful. The push as a whole is
+  considered failed if any ref is `ng`, and `git push` will exit with
+  a non-zero status on the client side.
+
+* To abort the entire push unconditionally, exit with a non-zero
+  status. In this case the hook's stdout is discarded, `receive-pack`
+  modifies all references to be rejected with a 'receive-report hook
+  failed' error.
+
+Any output written to standard error is forwarded to the client over
+the sideband channel and will appear as `remote:` lines on clients
+using 'git-push(1)', regardless of the hook's exit status. Writing to
+standard error alone does not affect the push outcome.
+
+Note that by the time this hook runs, all ref updates have already been
+applied to the repository. Neither a non-zero exit nor rewriting refs
+to `ng` rolls back any ref changes that were already committed
+server-side. The hook can cause the client to perceive the push as
+failed, but cannot undo the server-side updates.
+
 push-to-checkout
 ~~~~~~~~~~~~~~~~
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 34d5e46097..c9f1eb3335 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1004,6 +1004,41 @@ static int run_update_hook(struct command *cmd)
 	return code;
 }
 
+static int run_receive_report_hook(struct strbuf *report)
+{
+	struct child_process proc = CHILD_PROCESS_INIT;
+	struct async sideband_async;
+	int sideband_async_started = 0;
+	int saved_stderr = -1;
+	struct strbuf out = STRBUF_INIT;
+	const char *hook_path;
+	int ret;
+
+	hook_path = find_hook(the_repository, "receive-report");
+	if (!hook_path)
+		return 0;
+
+	strvec_push(&proc.args, hook_path);
+	proc.trace2_hook_name = "receive-report";
+
+	prepare_sideband_async(&sideband_async, &saved_stderr,
+			       &sideband_async_started);
+
+	sigchain_push(SIGPIPE, SIG_IGN);
+	ret = pipe_command(&proc, report->buf, report->len, &out,
+			   report->len, NULL, 0);
+	sigchain_pop(SIGPIPE);
+
+	finish_sideband_async(&sideband_async, saved_stderr,
+			      sideband_async_started);
+
+	if (!ret)
+		strbuf_swap(&out, report);
+
+	strbuf_release(&out);
+	return ret;
+}
+
 static struct command *find_command_by_refname(struct command *list,
 					       const char *refname)
 {
@@ -2530,6 +2565,13 @@ static void update_shallow_info(struct command *commands,
 	free(ref_status);
 }
 
+static void override_cmds_error(struct command *commands, const char *err)
+{
+	for (struct command *cmd = commands; cmd; cmd = cmd->next) {
+		cmd->error_string = err;
+	}
+}
+
 /*
  * Generate the response to be sent to the client invoking 'git-receive-pack(1)'.
  * For v2 protocol, set `detailed_report` to true, which will also add detailed
@@ -2583,6 +2625,12 @@ static void report(struct command *commands, const char *unpack_status)
 
 	generate_report(&buf, commands, unpack_status, false);
 
+	if (run_receive_report_hook(&buf)) {
+		strbuf_reset(&buf);
+		override_cmds_error(commands, "receive-report hook failed");
+		generate_report(&buf, commands, unpack_status, false);
+	}
+
 	if (use_sideband)
 		send_sideband(1, 1, buf.buf, buf.len, use_sideband);
 	else
@@ -2596,6 +2644,12 @@ static void report_v2(struct command *commands, const char *unpack_status)
 
 	generate_report(&buf, commands, unpack_status, true);
 
+	if (run_receive_report_hook(&buf)) {
+		strbuf_reset(&buf);
+		override_cmds_error(commands, "receive-report hook failed");
+		generate_report(&buf, commands, unpack_status, true);
+	}
+
 	if (use_sideband)
 		send_sideband(1, 1, buf.buf, buf.len, use_sideband);
 	else
diff --git a/t/meson.build b/t/meson.build
index a25f37d2f5..7088c2c1c1 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -651,6 +651,7 @@ integration_tests = [
   't5409-colorize-remote-messages.sh',
   't5410-receive-pack.sh',
   't5411-proc-receive-hook.sh',
+  't5412-receive-report-hook.sh',
   't5500-fetch-pack.sh',
   't5501-fetch-push-alternates.sh',
   't5502-quickfetch.sh',
diff --git a/t/t5412-receive-report-hook.sh b/t/t5412-receive-report-hook.sh
new file mode 100755
index 0000000000..24679de37b
--- /dev/null
+++ b/t/t5412-receive-report-hook.sh
@@ -0,0 +1,224 @@
+#!/bin/sh
+
+test_description='test receive-report hook'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+. "$TEST_DIRECTORY"/t5411/common-functions.sh
+
+URL_PREFIX="\.\."
+
+test_expect_success "setup workbench" '
+	git init workbench &&
+	create_commits_in workbench A B
+'
+
+test_expect_success "no report hook, push succeeds" '
+	test_when_finished "rm -rf upstream" &&
+	test_when_finished "git -C workbench remote remove origin" &&
+	git init --bare upstream &&
+
+	git -C workbench remote add origin ../upstream &&
+	git -C workbench push origin $A:refs/heads/main &&
+	git -C workbench push origin $B:refs/heads/main >out 2>&1 &&
+
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-\EOF &&
+	To ../upstream
+	   <COMMIT-A>..<COMMIT-B>  <COMMIT-B> -> main
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "passthrough does not alter report" '
+	test_when_finished "rm -rf upstream" &&
+	test_when_finished "git -C workbench remote remove origin" &&
+	git init --bare upstream &&
+
+	test_hook -C upstream --setup receive-report <<-\EOF &&
+	cat
+	EOF
+
+	git -C workbench remote add origin ../upstream &&
+	git -C workbench push origin $A:refs/heads/main &&
+	git -C workbench push origin $B:refs/heads/main >out 2>&1 &&
+
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-\EOF &&
+	To ../upstream
+	   <COMMIT-A>..<COMMIT-B>  <COMMIT-B> -> main
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "non-zero exit reports as hook failed" '
+	test_when_finished "rm -rf upstream" &&
+	test_when_finished "git -C workbench remote remove origin" &&
+
+	git init --bare upstream &&
+	git -C workbench remote add origin ../upstream &&
+	git -C workbench push origin $A:refs/heads/main &&
+
+	test_hook -C upstream --setup receive-report <<-\EOF &&
+	exit 1
+	EOF
+
+	test_must_fail git -C workbench push origin $B:refs/heads/main >out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-\EOF &&
+	To ../upstream
+	 ! [remote rejected] <COMMIT-B> -> main (receive-report hook failed)
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "hook is invoked and receives report on stdin" '
+	test_when_finished "rm -rf upstream" &&
+	test_when_finished "git -C workbench remote remove origin" &&
+
+	git init --bare upstream &&
+	test_hook -C upstream --setup receive-report <<-EOF &&
+	tee raw
+	EOF
+
+	git -C workbench remote add origin ../upstream &&
+	git -C workbench push origin $A:refs/heads/main &&
+	git -C workbench push origin $B:refs/heads/main >out 2>&1 &&
+
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	To ../upstream
+	   <COMMIT-A>..<COMMIT-B>  <COMMIT-B> -> main
+	EOF
+	test_cmp expect actual &&
+
+	test-tool pkt-line unpack <upstream/raw >actual-report &&
+	cat >expect-report <<-EOF &&
+	unpack ok
+	ok refs/heads/main
+	0000
+	EOF
+	test_cmp expect-report actual-report
+'
+
+test_expect_success "hook can modify the report sent to client" '
+	test_when_finished "rm -rf upstream" &&
+	test_when_finished "git -C workbench remote remove origin" &&
+
+	git init --bare upstream &&
+	git -C workbench remote add origin ../upstream &&
+	git -C workbench push origin $A:refs/heads/main &&
+
+	test_hook -C upstream --setup receive-report <<-\EOF &&
+	test-tool pkt-line unpack |
+	sed "s/^ok /ng /" |
+	test-tool pkt-line pack
+	EOF
+
+	test_must_fail git -C workbench push origin $B:refs/heads/main >out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-\EOF &&
+	To ../upstream
+	 ! [remote rejected] <COMMIT-B> -> main (failed)
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "hook can modify the unpack status" '
+	test_when_finished "rm -rf upstream" &&
+	test_when_finished "git -C workbench remote remove origin" &&
+
+	git init --bare upstream &&
+	git -C workbench remote add origin ../upstream &&
+	git -C workbench push origin $A:refs/heads/main &&
+
+	test_hook -C upstream --setup receive-report <<-\EOF &&
+	test-tool pkt-line unpack |
+	sed "s/^unpack ok$/unpack push failed due to server error/" |
+	test-tool pkt-line pack
+	EOF
+
+	test_must_fail git -C workbench push origin $B:refs/heads/main >out 2>&1 &&
+	test_grep "error: remote unpack failed: push failed due to server error" out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-\EOF &&
+	To ../upstream
+	   <COMMIT-A>..<COMMIT-B>  <COMMIT-B> -> main
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "hook can report a custom failure message" '
+	test_when_finished "rm -rf upstream" &&
+	test_when_finished "git -C workbench remote remove origin" &&
+
+	git init --bare upstream &&
+	git -C workbench remote add origin ../upstream &&
+	git -C workbench push origin $A:refs/heads/main &&
+
+	test_hook -C upstream --setup receive-report <<-\EOF &&
+	echo "push rejected: service X is down" >&2
+	test-tool pkt-line unpack |
+	sed "s/^ok \(.*\)/ng \1 service-x-is-down/" |
+	test-tool pkt-line pack |
+	tee raw
+	EOF
+
+	test_must_fail git -C workbench push origin $B:refs/heads/main >out 2>&1 &&
+	test_grep "push rejected: service X is down" out &&
+
+	test-tool pkt-line unpack <upstream/raw >actual-report &&
+	cat >expect-report <<-\EOF &&
+	unpack ok
+	ng refs/heads/main service-x-is-down
+	0000
+	EOF
+	test_cmp expect-report actual-report
+'
+
+test_expect_success "hook stderr with zero exit status code" '
+	test_when_finished "rm -rf upstream" &&
+	test_when_finished "git -C workbench remote remove origin" &&
+
+	git init --bare upstream &&
+	git -C workbench remote add origin ../upstream &&
+	git -C workbench push origin $A:refs/heads/main &&
+
+	test_hook -C upstream --setup receive-report <<-\EOF &&
+	echo "push rejected: service X is down" >&2
+	tee raw
+	EOF
+
+	git -C workbench push origin $B:refs/heads/main >out 2>&1 &&
+	test_grep "push rejected: service X is down" out &&
+
+	test-tool pkt-line unpack <upstream/raw >actual-report &&
+	cat >expect-report <<-\EOF &&
+	unpack ok
+	ok refs/heads/main
+	0000
+	EOF
+	test_cmp expect-report actual-report
+'
+
+test_expect_success "hook stderr is relayed to client via sideband" '
+	test_when_finished "rm -rf upstream" &&
+	test_when_finished "git -C workbench remote remove origin" &&
+
+	git init --bare upstream &&
+	git -C workbench remote add origin ../upstream &&
+	git -C workbench push origin $A:refs/heads/main &&
+
+	test_hook -C upstream --setup receive-report <<-\EOF &&
+	echo "hook-stderr-message" >&2
+	exit 1
+	EOF
+
+	test_must_fail git -C workbench push origin $B:refs/heads/main >out 2>&1 &&
+	test_grep "remote: hook-stderr-message" out
+'
+
+test_done

-- 
2.55.GIT

