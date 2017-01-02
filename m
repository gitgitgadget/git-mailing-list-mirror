Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 871C8205C9
	for <e@80x24.org>; Mon,  2 Jan 2017 15:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933018AbdABPfm (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 10:35:42 -0500
Received: from mout.gmx.net ([212.227.15.18]:55740 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932874AbdABPfm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 10:35:42 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LcBin-1cpxDp0VwT-00jYrn; Mon, 02
 Jan 2017 16:35:36 +0100
Date:   Mon, 2 Jan 2017 16:35:34 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Stephan Beyer <s-beyer@gmx.net>, Jeff King <peff@peff.net>
Subject: [PATCH v3 33/38] sequencer (rebase -i): show only failed `git
 commit`'s output
In-Reply-To: <cover.1483370556.git.johannes.schindelin@gmx.de>
Message-ID: <f1ebd5e2de84d197326593a0c8018fd7e0446d6e.1483370556.git.johannes.schindelin@gmx.de>
References: <cover.1481642927.git.johannes.schindelin@gmx.de> <cover.1483370556.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:bFIay83A7bn+F8kCMTzJNbbz+AB4SUs0wXHrhWlZeeEJav1Qix9
 S+jedSSCtoGIwEUtwJx8XWpIohd/qX4FoExxSUpjmkndgKiNgJkYKKJC7jPmRN9XJotRgsj
 I8Kyr1oE8HCSgJ9n5HPhtAw8LeACscnYrpsJYJNVF94rIxoeUtcKlINsi0TDT8hi3upO3N4
 SQn6fhDTw04H9mWOujWjg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZJxiFQPNU5g=:Qs0fgtOAR7IF32KVd6dXlP
 dggPJ69/25t0k5mYWa6gWMTamW/dPBsVwbrf2xur+SVeXDWn90Mtpvvf0fKdwluRu5iwds7Tz
 tGQjj8DY6rkleLuwnvvE9slYTriGhmtAMkLVYS5n5UKxluQ5jGhLkw0xwSN8I/AdmGbIAHVi1
 Ek7pdAvD8WdSHfSY3FMsM/0ZV8PZ0t9XYQjfFNVnaPummRd6rG4U/z6m8fVvLKh8icZo5wE6X
 SI9mYBDlFUChWdZgKDNy2XZl3Q9pNu6JsncspSwcKCyriD+9ffmW+3eMI6X0Ds+KgtFXqgwjz
 58k+DZYMA/B7oqoi0K9feeQktLs+zqPFBNtE5xUI/a+zZqMvlki59jgqx/evzqgGQ81cyrY/G
 DFfwd+2IiEGjVoyesmAGhvbg8GsLHOflx5kpgvG9Qb6bdfZ0i8BvuTuPEOYR9Y9PzmpeqOIUG
 ngNOIjw5+2RwZ9/H6P8zkBQUE78ClnswcKxT+P6SvMrt4lNEc5gwjP+Vyb8WUYoiLkDoD3hJZ
 z5WwQC/t5N30EUIi6hDb1bpqEUgSdC+mVRQUxoWMe8GwL8HDc1SrAu0k/h5YsbjQR0q4w7jrI
 yFIq25KkEh2oIZfpAmdqWkTGLyvEoP16Jy47B6aKsJjp7XiRS19u8ce9vagkRJnPnhWS20Hcm
 0d0xYYxtq8Mjz7QaufIJfNJhdsnnL1NSrFoEcs1nBY49fUaEqOmrwd9YhNMgRiFOPAZDH3rl4
 uG/7MfnISUNX2RPfY12rqULHYg/pulqtyoBxxStKsiL8knSO/C3yGdkk7/n+qCPopTSNEvLMq
 irW0wNf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the behavior of the shell script version of the interactive
rebase, by using the `output` function defined in `git-rebase.sh`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index c7dc5a2ad4..a501dfce38 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -610,6 +610,11 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 	cmd.git_cmd = 1;
 
 	if (is_rebase_i(opts)) {
+		if (!edit) {
+			cmd.stdout_to_stderr = 1;
+			cmd.err = -1;
+		}
+
 		if (read_env_script(&cmd.env_array)) {
 			const char *gpg_opt = gpg_sign_opt_quoted(opts);
 
@@ -644,6 +649,19 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 	if (opts->allow_empty_message)
 		argv_array_push(&cmd.args, "--allow-empty-message");
 
+	if (cmd.err == -1) {
+		/* hide stderr on success */
+		struct strbuf buf = STRBUF_INIT;
+		int rc = pipe_command(&cmd,
+				      NULL, 0,
+				      /* stdout is already redirected */
+				      NULL, 0,
+				      &buf, 0);
+		if (rc)
+			fputs(buf.buf, stderr);
+		strbuf_release(&buf);
+		return rc;
+	}
 
 	return run_command(&cmd);
 }
-- 
2.11.0.rc3.windows.1


