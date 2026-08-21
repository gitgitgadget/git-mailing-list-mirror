Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3CC32B11E
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 13:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787319311; cv=none; b=l2er5/LYuKQOszvx/NHSil86VgsEmgiGluXQAuUuaWUZb3N288VIcih/S4xG66T2RHnM5VK0gkvQqx/h3FgdzI3xyRkBBTV8wjpe57wF5mdsOBOnawVPLvWRSefVPZsNZFhte9+PKhsnj/232dKo8EWlREFZ/pfgmGkdlhvELTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787319311; c=relaxed/simple;
	bh=Ktk9EB3vwQS7W/IHhwAmCdxVoI6Qy/S3Bo8+Wmc019M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:
	 In-Reply-To:References:To:Cc; b=UMtRy25XhgzL0Lp/t2+8z8YuQ2zAJIhmSdwNy7Ib6iHeNsUHDQ+w485js+0K6uPY/+PMKjcjE4LwiIlV0D1cYsfy5MecF0m4HyMuSukcRnx5pFalBIS0gXrKrlHfOY+fvoNIWzPC5Oz8XWyFqL0BsHfaQL1w2By56q2QUnZS+js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E42s8Nl6; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E42s8Nl6"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6a0c8283146so1986644a12.0
        for <git@vger.kernel.org>; Fri, 21 Aug 2026 06:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787319303; x=1787924103; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qpft/Wx8Ee9xA0g4nr11S8/xAoV9ykd9AJX+c7ewz48=;
        b=E42s8Nl6NLgznqIIyGGDJGlJNrd3UdF3rVr0Agth3+T/uUYDnlx24Pm2zcZXJbvVey
         R6Om2izZQgFWRdzo2qj9a2EYLEWYlUrad5whs8AbwFPZDBooQDiVN4kTjPdTykYn29Cc
         FjjdBQNS+EOy1LFZnLxlv/jG9LGYiA2EUAyEMpQ0/+R4Ug5t+M2n0KOSQrVJkyFx1q8n
         MtQap6wl8T/m2YYYTBh89DoUGNNJVI/iJ1t7SDXOGFDIj7oYgerbUi752saz0rfGzBkM
         UxW38Ph+2Bqqyq5hwGRVO2q6ehay9VA7AY3LbA2+5XVg+qes2znJdqRDV9QSt0VgE8cO
         18fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787319303; x=1787924103;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qpft/Wx8Ee9xA0g4nr11S8/xAoV9ykd9AJX+c7ewz48=;
        b=douqqH8yzG2wkris5GWQw+VlTunvQmWUa/UG88/RwL8L+6ej9ah+jiPTHju2FYn87Z
         FUZyHnHLxsaYrJsLG/gzEq1IUNHjzt/4PtWh5fHw6HLyCEGVnXxw1BOT3DmbFUswuswU
         UWhwkkvG9KeKHO9t44WNpSmKc7UgzPaX8m0XPCa2Ztd9SCzfztt/IgQ3o+gcx92lKguY
         QduHIZHWjZZabuB785S+EbxJytU0paqrriooZZ5NBLCVLD/UvplTD945zq7Z87jrxqxh
         b/yDnE+yuj/ezJZxS763WKWVHb8MyTeLVgIWqbPIqi6E+Tqz2D8ilIdu0NWLavq+4tI0
         tX/Q==
X-Gm-Message-State: AFuF++kNtY6xhYp/gAIT6+78hm36KhcS8RoGKJ6PN782SnMCYkJOaiBg
	yzeuG8yt4X0Ip5sZPZit1fjfmXPy6o9aahlSm6VKf8NlUSY6Zv4R1y5TaX5YHQJ6
X-Gm-Gg: AR+sD106Aj3IaQtcSt4rRQS2MnZvuDW6MRILb5NgUtGdHc2oqcdtKw5/y9EtiKeEcfK
	c7KaZg9RL7SE1YrvCZBVxkBRJWrbQuZJSUyIKrtgXvnQK2qoP5G2B80vYckGc9TNui232jIv2dB
	y6PupqAfuWFzTqUYtfN+Nm82IY8ogv/+2dgv/4pHA8Df+MhLbZiiXvnNyNykwbzLk1pdytGCGiD
	1SjGJCiQvhISxf8lncvGksuor51HL1q9YeyvL7XtZihPKKKERZA4xciqzYep45MgCiGqKFejqXl
	43d/Nsl9LSqxRiLfLRxpt5TgjdxnOv1b+yqCIeIxZHyfk4vRY0yGDxNz8J7095mpsbCPvJsy9+a
	wGOZ6BMVSL2cSGyTX6oVw2UDP+wMOSk+c0sKMZhQDgKTogYzYVMDDzoRFACuVjhPXtg33XXylLA
	cxuxDMzoLLCz+pFBbvzy6B3hYng8M29lLhqHs7cElFL4t8+v6z5TTM/9YREg76dOnCL8OR9cXWE
	oFFqf2IUYZ7sA8D9rLnsOZxN/tWEkI0XGi2fA==
X-Received: by 2002:a05:6402:5188:b0:6a4:ae1:333a with SMTP id 4fb4d7f45d1cf-6a42f2490acmr6104302a12.12.1787319302968;
        Fri, 21 Aug 2026 06:35:02 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:a4cb:d15d:c860:3e50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3ff1567f8sm6699072a12.18.2026.08.21.06.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 06:35:02 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 21 Aug 2026 15:34:58 +0200
Subject: [PATCH v2] hook: introduce the report hook for git-receive-pack(1)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-758-introduce-hook-v2-1-e90e2f7ac2cf@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NQQ6CMBBFr2Jm7RhaAgyuvIdhUcoAo0JNC0RDu
 LuAcefyJf+/N0NgLxzgfJjB8yRBXL+CPh7AtqZvGKVaGXSk04iUxiwhlH7wrhotY+vcHZMyNnV
 eK5MxwXp8eq7ltUuvxZfDWN7YDptpW7QSBuffe3VS2+4XoH+BSaFCMlRRzmlCMV2azsjjZF0Hx
 bIsH12/BHHGAAAA
X-Change-ID: 20260812-758-introduce-hook-5b3af9f1a7e8
In-Reply-To: <20260818-758-introduce-hook-v1-1-8a8d89e65838@gmail.com>
References: <20260818-758-introduce-hook-v1-1-8a8d89e65838@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, gitster@pobox.com, kristofferhaugsbakk@fastmail.com, 
 Phillip Wood <phillip.wood@dunelm.org.uk>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=17155;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=Ktk9EB3vwQS7W/IHhwAmCdxVoI6Qy/S3Bo8+Wmc019M=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGqIVARooMh/lexJrNwKkbKV1vPiOH7GbY0T8
 OZjd0n78ydOaIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJqiFQEAAoJED7VnySO
 Rox/DboL/06GQhYyTmyqM1JntFpnY/KnCD82tWJUbzldosKdHq/ttnBMFob2tLbs/PX+kx5Aebw
 hzjRJ4+gIgGo6R3o92MLPCnfmSEaphQs3QMuGu6hXSoeBi2SsFDaKptb5asr6gxJNrrx9Ls6lkK
 QFk8NTX8fc4M20NuC530WKA4qudaLKlINZEygic8fgkDSdYazCr7uGGv1eEyDDcTW8itmnQxaaV
 kq712bb3l0tS86pMyTUR3JRroofTszuGHC0QNbCEPX9eu9I/kgKGCTQPbk+xy0XANe34x9ryNU0
 86cHgMxlL6G0XjPFxMqs2qNz6rgLKpDaPbbak5E/1fdJjyqomz4aZPSzYVmiQmvAKbCb/BiG14m
 TvJ/i5oJRGqWER2aSFaS4sMqSG4x2GOKwzKFJbbtGPYrqVwJ1X5U1O8zKX1mdwg0enB+Qyn3b4q
 L0B0xPCHZ1Al3Q1IJ0IzGN0MZEv3jf/sv2RFGvj4p5pGj+gceycxKwJJFPzcGJhQH929cFMEsh7
 9Q=
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

Introduce a new 'report' hook. The hook receives the complete pkt-line
encoded status report on standard input, after all ref updates have
been applied to the repository by execute_commands() but before the
report is sent to the client. The report consists of an 'unpack ok'
or 'unpack <error>' line, followed by one 'ok <refname>' or
'ng <refname> <reason>' line per pushed ref, terminated by a flush
packet.

The hook's stdout fully replaces the report sent to the client.
receive-pack fully buffers the hook's stdout before acting on the exit
status, so the exit code is known before the client receives anything.
This gives two distinct behaviours depending on exit status:

- Exit 0: the hook's stdout is used as the report. The hook can
  rewrite 'ok' lines to 'ng' lines to signal per-ref rejection to the
  client while receive-pack itself exits cleanly. The client marks
  rejected refs as '[remote rejected]' and exits with a non-zero
  status if any ref is 'ng'.

- Non-zero exit: the hook's stdout is discarded, receive-pack calls
  die(), and no report is sent to the client at all. The client
  observes a sideband disconnect and reports 'the remote end hung up
  unexpectedly', treating the entire push as failed.

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
Changes in v2:
- Modify the documentation and commit message to be more verbose.
- Add documentation to 'git-receive-pack.adoc'
- Use 'ret' as the variable name for the return code.
- Modify the test to also check for the 'remote:'.
- Link to v1: https://patch.msgid.link/20260818-758-introduce-hook-v1-1-8a8d89e65838@gmail.com
---
 Documentation/git-receive-pack.adoc |  15 +++
 Documentation/githooks.adoc         |  51 +++++++++
 builtin/receive-pack.c              |  41 ++++++++
 t/meson.build                       |   1 +
 t/t5412-report-hook.sh              | 201 ++++++++++++++++++++++++++++++++++++
 5 files changed, 309 insertions(+)

diff --git a/Documentation/git-receive-pack.adoc b/Documentation/git-receive-pack.adoc
index 0956086d61..e6cc0acaaf 100644
--- a/Documentation/git-receive-pack.adoc
+++ b/Documentation/git-receive-pack.adoc
@@ -236,6 +236,21 @@ if the repository is packed and is served via a dumb transport.
 exec git update-server-info
 ----
 
+PROC-RECEIVE HOOK
+-----------------
+This hook is invoked by 'git-receive-pack' when it processes push
+requests. It handles refs whose names match the patterns defined by
+`receive.procReceiveRefs` and executes the actual ref updates. See
+linkgit:githooks[5] for the full protocol description.
+
+REPORT HOOK
+-----------
+This hook is invoked by 'git-receive-pack' after all the ref updates
+have been applied but before the report is sent to the client. The hook
+receives the complete report in pkt-line format on stdin and its stdout
+replaces the report sent to the client. Allowing the hook to rewrite
+the outcomes or abort the push completely. See linkgit:githooks[5] for
+the full protocol description.
 
 QUARANTINE ENVIRONMENT
 ----------------------
diff --git a/Documentation/githooks.adoc b/Documentation/githooks.adoc
index ed045940d1..06c9e4b017 100644
--- a/Documentation/githooks.adoc
+++ b/Documentation/githooks.adoc
@@ -527,6 +527,57 @@ The exit status of the hook is ignored for any state except for the
 status will cause the transaction to be aborted. The hook will not be
 called with "aborted" state in that case.
 
+report
+~~~~~~
+
+This hook is invoked by linkgit:git-receive-pack[1] when it reacts to
+`git push` and updates references in its repository. It executes on
+the repository once after all refs have been updated and after
+`execute_commands()` has applied all accepted ref changes to the
+repository, but before the pkt-line encoded status report is sent back
+to the client.
+
+The hook receives the complete pkt-line encoded status report on
+standard input. The report begins with an `unpack` line indicating
+whether the object transfer succeeded (`unpack ok` or
+`unpack <error>`), followed by one `ok <refname>` or
+`ng <refname> <reason>` line per ref that was pushed, and is
+terminated by a flush packet.
+
+The hook's standard output entirely replaces the report that is sent
+to the client. The hook must write a valid pkt-line encoded report in
+the same format it received. The hook's stdout is fully buffered by
+`receive-pack` before any data is sent to the client, so the hook's
+exit status is known before the client receives anything.
+
+There are two distinct ways the hook can affect the push outcome:
+
+* To reject individual ref updates while keeping `receive-pack` alive,
+  rewrite the corresponding `ok <refname>` lines to
+  `ng <refname> <reason>` lines in the output and exit with status 0.
+  The client will then mark those specific refs as rejected while
+  treating any `ok` refs as successful. The push as a whole is
+  considered failed if any ref is `ng`, and `git push` will exit with
+  a non-zero status on the client side.
+
+* To abort the entire push unconditionally, exit with a non-zero
+  status. In this case the hook's stdout is discarded, `receive-pack`
+  calls `die()`, and no report is sent to the client at all. The client
+  observes an unexpected sideband disconnect, making the entire push
+  appear to have failed. In general, the hook should never exit with a
+  non-zero status code and doing so would indicate a bug.
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
index 86933d8d7e..9a0905f67e 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1004,6 +1004,41 @@ static int run_update_hook(struct command *cmd)
 	return code;
 }
 
+static int run_report_hook(struct strbuf *report)
+{
+	struct child_process proc = CHILD_PROCESS_INIT;
+	struct async sideband_async;
+	int sideband_async_started = 0;
+	int saved_stderr = -1;
+	struct strbuf out = STRBUF_INIT;
+	const char *hook_path;
+	int ret;
+
+	hook_path = find_hook(the_repository, "report");
+	if (!hook_path)
+		return 0;
+
+	strvec_push(&proc.args, hook_path);
+	proc.trace2_hook_name = "report";
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
@@ -2547,6 +2582,9 @@ static void report(struct command *commands, const char *unpack_status)
 	}
 	packet_buf_flush(&buf);
 
+	if (run_report_hook(&buf))
+		die("report hook failed");
+
 	if (use_sideband)
 		send_sideband(1, 1, buf.buf, buf.len, use_sideband);
 	else
@@ -2592,6 +2630,9 @@ static void report_v2(struct command *commands, const char *unpack_status)
 	}
 	packet_buf_flush(&buf);
 
+	if (run_report_hook(&buf))
+		die("report hook failed");
+
 	if (use_sideband)
 		send_sideband(1, 1, buf.buf, buf.len, use_sideband);
 	else
diff --git a/t/meson.build b/t/meson.build
index a25f37d2f5..7056e31326 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -651,6 +651,7 @@ integration_tests = [
   't5409-colorize-remote-messages.sh',
   't5410-receive-pack.sh',
   't5411-proc-receive-hook.sh',
+  't5412-report-hook.sh',
   't5500-fetch-pack.sh',
   't5501-fetch-push-alternates.sh',
   't5502-quickfetch.sh',
diff --git a/t/t5412-report-hook.sh b/t/t5412-report-hook.sh
new file mode 100755
index 0000000000..62e5174c58
--- /dev/null
+++ b/t/t5412-report-hook.sh
@@ -0,0 +1,201 @@
+#!/bin/sh
+
+test_description='test report hook'
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
+	test_hook -C upstream --setup report <<-\EOF &&
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
+test_expect_success "non-zero exit causes receive-pack to die" '
+	test_when_finished "rm -rf upstream" &&
+	test_when_finished "git -C workbench remote remove origin" &&
+
+	git init --bare upstream &&
+	git -C workbench remote add origin ../upstream &&
+	git -C workbench push origin $A:refs/heads/main &&
+
+	test_hook -C upstream --setup report <<-\EOF &&
+	exit 1
+	EOF
+
+	test_must_fail git -C workbench push origin $B:refs/heads/main >out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-\EOF &&
+	fatal: report hook failed
+	send-pack: unexpected disconnect while reading sideband packet
+	fatal: the remote end hung up unexpectedly
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "hook is invoked and receives report on stdin" '
+	test_when_finished "rm -rf upstream" &&
+	test_when_finished "git -C workbench remote remove origin" &&
+
+	git init --bare upstream &&
+	test_hook -C upstream --setup report <<-EOF &&
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
+	test_hook -C upstream --setup report <<-\EOF &&
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
+test_expect_success "hook can report a custom failure message" '
+	test_when_finished "rm -rf upstream" &&
+	test_when_finished "git -C workbench remote remove origin" &&
+
+	git init --bare upstream &&
+	git -C workbench remote add origin ../upstream &&
+	git -C workbench push origin $A:refs/heads/main &&
+
+	test_hook -C upstream --setup report <<-\EOF &&
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
+	test_hook -C upstream --setup report <<-\EOF &&
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
+	test_hook -C upstream --setup report <<-\EOF &&
+	echo "hook-stderr-message" >&2
+	exit 1
+	EOF
+
+	test_must_fail git -C workbench push origin $B:refs/heads/main >out 2>&1 &&
+	test_grep "remote: hook-stderr-message" out
+'
+
+test_done

---
base-commit: 11c6700f10234578d10523faf35656ca491425c9
change-id: 20260812-758-introduce-hook-5b3af9f1a7e8


Thanks
- Karthik

