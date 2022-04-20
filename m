Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC15C433EF
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 20:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382151AbiDTUqV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 16:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382124AbiDTUqO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 16:46:14 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A93D3AA71
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 13:43:27 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id ay36-20020a05600c1e2400b0038ebc885115so2768135wmb.1
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 13:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8V1FoXCb86xqZ2XOaLWrGr4avTXqor6TX1WNeRZ9avw=;
        b=n7Fff8+FNYPUx1hpECFIH8aXbPgYVboN4WAbBlFFXR95H1nTTDzny0ebzMuIecUtwH
         gYRWgolg9iFYdehjsIqzVaXxnft7QWe1pyGZ9DmGe2jXMv8Kcmzn9v1OT4j4EY5oxEdx
         3mlhtRKNeos5ddVhBpL5qXPyUZPDZ9d3Rw1KisB4FKJsHRjiNja93Cqg4Zjl7pHZiAep
         0+uDMNR9HDX5bGuq3KWH02zI9DIM/5WF6LGmZ/IJNu5XtnxL5vCeEu/Z3HXNS1fAV0os
         u/6ys369rDvRk90cWZha9ZhZ7Mr7TQPd/GegAK7nhIBcXLcdrU955XicCXKyGNN8Sp2j
         iJiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8V1FoXCb86xqZ2XOaLWrGr4avTXqor6TX1WNeRZ9avw=;
        b=nkdgt4mJgkYh+sfrRPoW4An8v1rV8Px3YxQaBdq6jyXlRPL8dRNo2TCqrHwqsPdCsj
         nl+MT6af/r7AJvtIeQEp59OSCw84HH3+3AkjXRTg8u4st2jCkn5iZzL0hvabhjZlRCxV
         RnCkFBxIriy7E39IRFPssrKT00RrjTb+UKVbLYKVt4Vof4nTnpVpd/zdibM+STwHJFa/
         rQ/ybCm3ptmkifynjcWH95O4sxgMsEXvT/3ChVkPrOgHsry8E7ayx0PtIULw+0GY+VVr
         tikGKmyUWR4V69heWOrCr76AHzQFeswSjZx3LTII/Pw6rKqWbZOkQTmlI3mbbnvn2s06
         BjSw==
X-Gm-Message-State: AOAM530pl89B+ggio/i4loDFsCWfsW0d1GDlU4frd/7m/Jcz0qGNxaz2
        8pmYDlb8M8/eIpw+YodInVqB9ObVsnU=
X-Google-Smtp-Source: ABdhPJzA1l8TlWV8YKig0vMXQYl1vs14wtcjf6gYo+Kuglxn7ybaBdbCWE0GrMGGHAHtfJ/viTs17w==
X-Received: by 2002:a05:600c:a4b:b0:37b:ea2b:5583 with SMTP id c11-20020a05600c0a4b00b0037bea2b5583mr5394483wmq.139.1650487405711;
        Wed, 20 Apr 2022 13:43:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d5-20020a056000186500b0020a8688963bsm862285wri.89.2022.04.20.13.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 13:43:24 -0700 (PDT)
Message-Id: <8a474d69999514b343ff576ca1d96180c22b403d.1650487398.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>
References: <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
        <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 Apr 2022 20:42:53 +0000
Subject: [PATCH v5 03/28] t/helper/fsmonitor-client: create stress test
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
        rsbecker@nexbridge.com, Bagas Sanjaya <bagasdotme@gmail.com>,
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
index 3062c8a3c2b..54a4856c48c 100644
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
 		"test-tool fsmonitor-client query [<token>]",
 		"test-tool fsmonitor-client flush",
+		"test-tool fsmonitor-client hammer [<token>] [<threads>] [<requests>]",
 		NULL,
 	};
 
 	struct option options[] = {
 		OPT_STRING(0, "token", &token, "token",
 			   "command token to send to the server"),
+
+		OPT_INTEGER(0, "threads", &nr_threads, "number of client threads"),
+		OPT_INTEGER(0, "requests", &nr_requests, "number of requests per thread"),
+
 		OPT_END()
 	};
 
@@ -111,6 +214,9 @@ int cmd__fsmonitor_client(int argc, const char **argv)
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

