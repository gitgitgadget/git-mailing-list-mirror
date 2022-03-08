Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42988C433EF
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 22:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350652AbiCHWQi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 17:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350600AbiCHWQc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 17:16:32 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C005717F
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 14:15:35 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id u10so233673wra.9
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 14:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6frvxGvKQ2KGBYzAbNuLBDFBvm1OqC1ZTc7LHozpsok=;
        b=R5B5WxXZbd8DNfWkD//2EfmFKFSQCpKdnJWRDzFI0kEYKOUs/YOMeeNIRKedset+mb
         XCelLZWuYcMPxRJduE/d+UK36w6Y5ZvUYdzCKbKkaNP2kFgyYUd1Jg54FnKO3sZGwybL
         cZlqzybMWkchUNdlN1ckE1ZmB9YzEldjRgIYEELtbCrY0w1iYv2G8SvMS7ttoNZgraBv
         Ap9M5UULk2Dn27HT7N3N6NVNwtj893EJxRFlO82KA6Kez5TgB5mOurkiuvXITB+Uv8mu
         DfB03TAaWqoeQYX0yJ5EeDjaAILBC3/6JCcaaCoP1qF6AZP92NL2wiXLNTjhViV0UE3k
         q9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6frvxGvKQ2KGBYzAbNuLBDFBvm1OqC1ZTc7LHozpsok=;
        b=ONwwtmYgNAkIsMXSQZ2u3ZmRWkSLPaupsfFfkfj4ElV3s9D0//1ZW4/2XnGHYLyudC
         zi5adwGev5Wnk5YTUwUs87xRzqqY5A13v5SJQKAt+ajhlw6EXfgmp0j0a+S/Iggj8A72
         qRjd5QZZfwOHdeG/FKkaTgrT7XnS584Vmv2hzt0ML3ffXnnBdMtykCv59q90423YVjBO
         fuk0O/mY5D+vXvihAyLI0ZEgW3b80OLI1RK1PPxZIchi4UAS6DS7DnSFaJKp+GiRbvLx
         m6gJi2neLq7wMT+AjVrVMY9jLKpa1b1iNG+YzAFdsvs/fRmmP7x9itrIyb49c6Gd9Lrx
         I8hA==
X-Gm-Message-State: AOAM530eDA9M9V7mRRd/mj0MkWhY3btrJdF63fMQBkPAe3zGBn0BADJ+
        bVufXZmkpbZ3ZbP6J8Dm7eXXkhQvJDM=
X-Google-Smtp-Source: ABdhPJwfajwDViLpLd+dWyLOakqjJdhWgBdnLAlt22McYWNzAHbYPDeOf192UzQqyFl4zCv04HmCvg==
X-Received: by 2002:a05:6000:170d:b0:1f1:fefa:db85 with SMTP id n13-20020a056000170d00b001f1fefadb85mr7611775wrc.148.1646777733698;
        Tue, 08 Mar 2022 14:15:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e4-20020adffc44000000b001f1dba38a65sm83309wrs.105.2022.03.08.14.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 14:15:32 -0800 (PST)
Message-Id: <87d1c0b6f2afda53bc8a8fc5949af6caca5a0329.1646777727.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
        <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Mar 2022 22:15:03 +0000
Subject: [PATCH v2 03/27] t/helper/fsmonitor-client: create stress test
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Create a stress test to hammer on the fsmonitor daemon.
Create a client-side thread pool of n threads and have
each of them make m requests as fast as they can.

We do not currently inspect the contents of the response.
We're only interested in placing a heavy request load on
the daemon.

This test is useful for interactive testing and various
experimentation.  For example, to place additional load
on the daemon while another test is running.  We currently
do not have a test script that actually uses this helper.
We might add such a test in the future.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/helper/test-fsmonitor-client.c | 106 +++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/t/helper/test-fsmonitor-client.c b/t/helper/test-fsmonitor-client.c
index f7a5b3a32fa..985340ba719 100644
--- a/t/helper/test-fsmonitor-client.c
+++ b/t/helper/test-fsmonitor-client.c
@@ -7,6 +7,8 @@
 #include "cache.h"
 #include "parse-options.h"
 #include "fsmonitor-ipc.h"
+#include "thread-utils.h"
+#include "trace2.h"
 
 #ifndef HAVE_FSMONITOR_DAEMON_BACKEND
 int cmd__fsmonitor_client(int argc, const char **argv)
@@ -79,20 +81,121 @@ static int do_send_flush(void)
 	return 0;
 }
 
+struct hammer_thread_data
+{
+	pthread_t pthread_id;
+	int thread_nr;
+
+	int nr_requests;
+	const char *token;
+
+	int sum_successful;
+	int sum_errors;
+};
+
+static void *hammer_thread_proc(void *_hammer_thread_data)
+{
+	struct hammer_thread_data *data = _hammer_thread_data;
+	struct strbuf answer = STRBUF_INIT;
+	int k;
+	int ret;
+
+	trace2_thread_start("hammer");
+
+	for (k = 0; k < data->nr_requests; k++) {
+		strbuf_reset(&answer);
+
+		ret = fsmonitor_ipc__send_query(data->token, &answer);
+		if (ret < 0)
+			data->sum_errors++;
+		else
+			data->sum_successful++;
+	}
+
+	strbuf_release(&answer);
+	trace2_thread_exit();
+	return NULL;
+}
+
+/*
+ * Start a pool of client threads that will each send a series of
+ * commands to the daemon.
+ *
+ * The goal is to overload the daemon with a sustained series of
+ * concurrent requests.
+ */
+static int do_hammer(const char *token, int nr_threads, int nr_requests)
+{
+	struct hammer_thread_data *data = NULL;
+	int k;
+	int sum_join_errors = 0;
+	int sum_commands = 0;
+	int sum_errors = 0;
+
+	if (!token || !*token)
+		token = get_token_from_index();
+	if (nr_threads < 1)
+		nr_threads = 1;
+	if (nr_requests < 1)
+		nr_requests = 1;
+
+	CALLOC_ARRAY(data, nr_threads);
+
+	for (k = 0; k < nr_threads; k++) {
+		struct hammer_thread_data *p = &data[k];
+		p->thread_nr = k;
+		p->nr_requests = nr_requests;
+		p->token = token;
+
+		if (pthread_create(&p->pthread_id, NULL, hammer_thread_proc, p)) {
+			warning("failed to create thread[%d] skipping remainder", k);
+			nr_threads = k;
+			break;
+		}
+	}
+
+	for (k = 0; k < nr_threads; k++) {
+		struct hammer_thread_data *p = &data[k];
+
+		if (pthread_join(p->pthread_id, NULL))
+			sum_join_errors++;
+		sum_commands += p->sum_successful;
+		sum_errors += p->sum_errors;
+	}
+
+	fprintf(stderr, "HAMMER: [threads %d][requests %d] [ok %d][err %d][join %d]\n",
+		nr_threads, nr_requests, sum_commands, sum_errors, sum_join_errors);
+
+	free(data);
+
+	/*
+	 * Return an error if any of the _send_query requests failed.
+	 * We don't care about thread create/join errors.
+	 */
+	return sum_errors > 0;
+}
+
 int cmd__fsmonitor_client(int argc, const char **argv)
 {
 	const char *subcmd;
 	const char *token = NULL;
+	int nr_threads = 1;
+	int nr_requests = 1;
 
 	const char * const fsmonitor_client_usage[] = {
 		N_("test-helper fsmonitor-client query [<token>]"),
 		N_("test-helper fsmonitor-client flush"),
+		N_("test-helper fsmonitor-client hammer [<token>] [<threads>] [<requests>]"),
 		NULL,
 	};
 
 	struct option options[] = {
 		OPT_STRING(0, "token", &token, N_("token"),
 			   N_("command token to send to the server")),
+
+		OPT_INTEGER(0, "threads", &nr_threads, N_("number of client threads")),
+		OPT_INTEGER(0, "requests", &nr_requests, N_("number of requests per thread")),
+
 		OPT_END()
 	};
 
@@ -116,6 +219,9 @@ int cmd__fsmonitor_client(int argc, const char **argv)
 	if (!strcmp(subcmd, "flush"))
 		return !!do_send_flush();
 
+	if (!strcmp(subcmd, "hammer"))
+		return !!do_hammer(token, nr_threads, nr_requests);
+
 	die("Unhandled subcommand: '%s'", subcmd);
 }
 #endif
-- 
gitgitgadget

