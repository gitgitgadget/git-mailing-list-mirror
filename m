Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.216.95.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793122870;
	b=spJClnMdHMpbaO6U5rJFJi70IpjDaiLb7njcYSiSMXO6235tzYSeOuI5sE7Ql3ieTu2j
	 V+FwDvGJ3QgIt8dafbTUQ6NXPCL79WqD02OpHNGHGmWjfQJtwflfvagAfCxt70NFa2MgI
	 xP+tvleFVgZz9aqEkk3R4BBwzDuIp6YuCPzmQMLoNPRrTr54+JeRCQvqNsWqgVki+hiwg
	 OIQlanVxWWpUa0Qj7EV9TgYJwZcCkt6WEx7tRlpCzdfd2jijdYCvzaK2CLr14LPZ+5fYe
	 i73iB0AuieRE7BOH8wQBeuEeCv4ukiCwyb82FnOthCUBG5KPn2NIVNbRIo+B/tcovNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793122870;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:Date:
	 From:To:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=0TEt7ld9TYe/24kAuWaPAZoCmADBXUgz/Nxlg4Ui84I=;
	b=xFqwu+2LCFne/80zzDYhYnvDAUG6pKj9XN0KIqQ1s/oHqtGJehu6JmFUXNiRNQATTFVF
	 H3kf3TZQyxhH3u3D/RJtuZt3Ol7fCmYuB9TWqyxWxbp2Xnc702R9fPkr6ZeJGwH9IHOf4
	 T+OfMAN5cEaDdETpdgBZAwlZIQvFjgbLw6jJ66eN1mTnb6qukgtpsCD1HbeQicKyoqHkL
	 Z2CqXHaMe5l1JFQTf9s1pWZN8NO6dcwSqP9AgXiNFkBCPC76gmEw9wyo/JDYOeHaN9uRD
	 vUl5KE7KHDSEJXi/vNlBvS19RFXV/yEfKVSfEzhnu7b5Q/3L8+mSc2lKu4x3pM9hxwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=peff.net;
	spf=pass smtp.mailfrom=peff.net;
	dkim=pass header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b="ZOlUs/T6";
	arc=none smtp.remote-ip=217.216.95.84
Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58614606A31E
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 17:41:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58614606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=ZOlUs/T6
Received: (qmail 38413 invoked by uid 106); 27 Oct 2026 17:41:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=khjzADmPM+NfqI5x65bPVWZgKWGG3slCyMPRHOQySxc=; b=ZOlUs/T61/QQTvz4jgZgp3ZuX5EluWjZwDqr3f7wNN5/ZuwN7avNvuZtnbbtDZlN9rJp5Dg5MAOBZblkfRHUx8RL+XKNwISrHpsKKOSnhVEPd8t3UBVYALWZOqmkNKD0ScNpjHFU+XF6QGn7gV3QtnE1Ddmh7Y3g84JaVzVL+HIK7H/o+6sV/0d0+qclYOWvZ+2Q4V8BBJv1Asu0sruKJUqVwbjdq0hmQK6nS+whkt7P3C/3bdZa4ErcuvI94NBvi9paYh55Myta+qh+adDJdd0ddWgnfTZYE3iMszyRulkxx/S5Ov0u8yhat1GjCNFAW5KAm2o9J60UjKbpr7UikA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 27 Oct 2026 17:41:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 276044 invoked by uid 111); 27 Oct 2026 17:41:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Oct 2026 13:41:08 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 27 Oct 2026 13:41:08 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [RFC/PATCH 7/8] test-tool: drop the run-command testsuite mode
Message-ID: <20261027174108.GG136740@coredump.intra.peff.net>
References: <20261027173205.GA97799@coredump.intra.peff.net>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261027173205.GA97799@coredump.intra.peff.net>

The last commit removed the final in-tree caller of "test-tool
run-command testsuite"; it was used only for unit tests, which now
run through the normal suite.

One of the original uses for it was supporting Azure pipelines, but we
dropped that support in e39e332e50 (ci: remove stale code for Azure
Pipelines, 2025-01-10). So in theory it is not used anywhere anymore.

However, commit be5d88e112 (test-tool run-command: learn to run (parts
of) the testsuite, 2019-10-06) indicates that it may also be useful for
Visual Studio users to run the tests without make or prove. It's unclear
if that is still a useful mode or not (if it is, we should drop or
revert this patch).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/helper/test-run-command.c | 173 ------------------------------------
 1 file changed, 173 deletions(-)

diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index 4a56456894..137bdc9d54 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -15,9 +15,6 @@
 #include "strvec.h"
 #include "strbuf.h"
 #include "parse-options.h"
-#include "string-list.h"
-#include "thread-utils.h"
-#include "wildmatch.h"
 
 static int number_callbacks;
 static int parallel_next(struct child_process *cp,
@@ -103,174 +100,6 @@ static int test_stdin_pipe_feed(int hook_stdin_fd, void *cb UNUSED, void *task_c
 	return !(*lines_remaining);
 }
 
-struct testsuite {
-	struct string_list tests, failed;
-	int next;
-	int quiet, immediate, verbose, verbose_log, trace, write_junit_xml;
-	const char *shell_path;
-};
-#define TESTSUITE_INIT { \
-	.tests = STRING_LIST_INIT_DUP, \
-	.failed = STRING_LIST_INIT_DUP, \
-}
-
-static int next_test(struct child_process *cp, struct strbuf *err, void *cb,
-		     void **task_cb)
-{
-	struct testsuite *suite = cb;
-	const char *test;
-	if (suite->next >= suite->tests.nr)
-		return 0;
-
-	test = suite->tests.items[suite->next++].string;
-	if (suite->shell_path)
-		strvec_push(&cp->args, suite->shell_path);
-	strvec_push(&cp->args, test);
-	if (suite->quiet)
-		strvec_push(&cp->args, "--quiet");
-	if (suite->immediate)
-		strvec_push(&cp->args, "-i");
-	if (suite->verbose)
-		strvec_push(&cp->args, "-v");
-	if (suite->verbose_log)
-		strvec_push(&cp->args, "-V");
-	if (suite->trace)
-		strvec_push(&cp->args, "-x");
-	if (suite->write_junit_xml)
-		strvec_push(&cp->args, "--write-junit-xml");
-
-	strbuf_addf(err, "Output of '%s':\n", test);
-	*task_cb = (void *)test;
-
-	return 1;
-}
-
-static int test_finished(int result, struct strbuf *err, void *cb,
-			 void *task_cb)
-{
-	struct testsuite *suite = cb;
-	const char *name = (const char *)task_cb;
-
-	if (result)
-		string_list_append(&suite->failed, name);
-
-	strbuf_addf(err, "%s: '%s'\n", result ? "FAIL" : "SUCCESS", name);
-
-	return 0;
-}
-
-static int test_failed(struct strbuf *out, void *cb, void *task_cb)
-{
-	struct testsuite *suite = cb;
-	const char *name = (const char *)task_cb;
-
-	string_list_append(&suite->failed, name);
-	strbuf_addf(out, "FAILED TO START: '%s'\n", name);
-
-	return 0;
-}
-
-static const char * const testsuite_usage[] = {
-	"test-run-command testsuite [<options>] [<pattern>...]",
-	NULL
-};
-
-static int testsuite(int argc, const char **argv)
-{
-	struct testsuite suite = TESTSUITE_INIT;
-	int max_jobs = 1, i, ret = 0;
-	DIR *dir;
-	struct dirent *d;
-	struct option options[] = {
-		OPT_BOOL('i', "immediate", &suite.immediate,
-			 "stop at first failed test case(s)"),
-		OPT_INTEGER('j', "jobs", &max_jobs, "run <N> jobs in parallel"),
-		OPT_BOOL('q', "quiet", &suite.quiet, "be terse"),
-		OPT_BOOL('v', "verbose", &suite.verbose, "be verbose"),
-		OPT_BOOL('V', "verbose-log", &suite.verbose_log,
-			 "be verbose, redirected to a file"),
-		OPT_BOOL('x', "trace", &suite.trace, "trace shell commands"),
-		OPT_BOOL(0, "write-junit-xml", &suite.write_junit_xml,
-			 "write JUnit-style XML files"),
-		OPT_END()
-	};
-	struct run_process_parallel_opts opts = {
-		.get_next_task = next_test,
-		.start_failure = test_failed,
-		.feed_pipe = test_stdin_pipe_feed,
-		.task_finished = test_finished,
-		.data = &suite,
-	};
-	struct strbuf progpath = STRBUF_INIT;
-	size_t path_prefix_len;
-
-	argc = parse_options(argc, argv, NULL, options,
-			testsuite_usage, PARSE_OPT_STOP_AT_NON_OPTION);
-
-	if (max_jobs <= 0)
-		max_jobs = online_cpus();
-
-	/*
-	 * If we run without a shell, execute the programs directly from CWD.
-	 */
-	suite.shell_path = getenv("TEST_SHELL_PATH");
-	if (!suite.shell_path)
-		strbuf_addstr(&progpath, "./");
-	path_prefix_len = progpath.len;
-
-	dir = opendir(".");
-	if (!dir)
-		die("Could not open the current directory");
-	while ((d = readdir(dir))) {
-		const char *p = d->d_name;
-
-		if (!strcmp(p, ".") || !strcmp(p, ".."))
-			continue;
-
-		/* No pattern: match all */
-		if (!argc) {
-			strbuf_setlen(&progpath, path_prefix_len);
-			strbuf_addstr(&progpath, p);
-			string_list_append(&suite.tests, progpath.buf);
-			continue;
-		}
-
-		for (i = 0; i < argc; i++)
-			if (!wildmatch(argv[i], p, 0)) {
-				strbuf_setlen(&progpath, path_prefix_len);
-				strbuf_addstr(&progpath, p);
-				string_list_append(&suite.tests, progpath.buf);
-				break;
-			}
-	}
-	closedir(dir);
-
-	if (!suite.tests.nr)
-		die("No tests match!");
-	if (max_jobs > suite.tests.nr)
-		max_jobs = suite.tests.nr;
-
-	fprintf(stderr, "Running %"PRIuMAX" tests (%d at a time)\n",
-		(uintmax_t)suite.tests.nr, max_jobs);
-
-	opts.processes = max_jobs;
-	run_processes_parallel(&opts);
-
-	if (suite.failed.nr > 0) {
-		ret = 1;
-		fprintf(stderr, "%"PRIuMAX" tests failed:\n\n",
-			(uintmax_t)suite.failed.nr);
-		for (i = 0; i < suite.failed.nr; i++)
-			fprintf(stderr, "\t%s\n", suite.failed.items[i].string);
-	}
-
-	string_list_clear(&suite.tests, 0);
-	string_list_clear(&suite.failed, 0);
-	strbuf_release(&progpath);
-
-	return ret;
-}
-
 static uint64_t my_random_next = 1234;
 
 static uint64_t my_random(void)
@@ -448,8 +277,6 @@ int cmd__run_command(int argc, const char **argv)
 		.data = &proc,
 	};
 
-	if (argc > 1 && !strcmp(argv[1], "testsuite"))
-		return testsuite(argc - 1, argv + 1);
 	if (!strcmp(argv[1], "inherited-handle"))
 		return inherit_handle(argv[0]);
 	if (!strcmp(argv[1], "inherited-handle-child"))
-- 
2.56.0.559.g7c1a1d8168

