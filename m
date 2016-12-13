Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 731A12042F
	for <e@80x24.org>; Tue, 13 Dec 2016 15:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933843AbcLMPjV (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 10:39:21 -0500
Received: from mout.gmx.net ([212.227.15.18]:51454 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932493AbcLMPjP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 10:39:15 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Md3ZK-1bzqRl29sQ-00IEoT; Tue, 13
 Dec 2016 16:32:35 +0100
Date:   Tue, 13 Dec 2016 16:32:34 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH v2 29/34] sequencer (rebase -i): show only failed `git
 commit`'s output
In-Reply-To: <cover.1481642927.git.johannes.schindelin@gmx.de>
Message-ID: <4cce3c1462b290494b3195c9ff4918ad99c24a14.1481642927.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de> <cover.1481642927.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:RSrrVdCvuQrxPPuMVxQMRBlTz9H9D5sdtMTyJ3P2VZPD6n65AWd
 pobpdpbsiFH0jYxIkYKYZziMIfWL/Ha2qATkmq0mCfulx5CXGhCp7K26/FO32N+chZVCVtl
 8k4mVJv8toDGUaIYZNgIi4GgocCVw97tbicjegHQ/dCbfTUFW3ZQ/iYSyoYRSt6Hg+cWspI
 3zjXReb5ft/cMIiLmn08g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JoMBeejJZvw=:1hhJRl66tk0gdajEfTFoq1
 z5KIed7Xf3IstKsWcuTz22DDSHnV2ecDnVif5s28XiOqGi7EnNZ0zVcY3WFjQSPYDZQ9AWFAA
 BJowoyVYgj/JdzcQgN0KJnTCddij37HOMhxvfKaITmFxnjHOB4dzV3JL5Yuex5G+etIpbEr7X
 0VcvzMNj8tkL6ORz1oIdP3BDLLcG1YG2/aF3Cwxcw3F2AV8ivzTEkw7Bx6NHq/PDrkdlgOpFi
 p8ZCQu90AZ1e6cnJ3/CcNNB3dVhGEzNPamIQFQrxjndKK828aerE3AIvANxKVd74UZExBf+bw
 /pVwtFHir9PVmqcF1xJ2onWUxBpc4Gjr9o2tEfgCcEpXGPjLtQLO9v7vOUBGXF89m7qNjBFsD
 0VJa7kHlxDCoPLmBdgetljhZhL/MMqF0XeIhiVT1AVElnYtc6wnop4HIX6pCdZv37bsdeY8Qt
 TABIEmk7hh3bpEan5OyBCXLEiBzU3+a33YYttK0t59fQ+mSliTBNHNjfGGzLqpR71nAPTP7D1
 U0mzMNTEBveghg9I+NDyBSxYTCF7KM/IuiLqKYeadHFeDQ1KcXjYh7n61MTeh+r82fdI8YtCB
 5XxQJ0PwI20SaWFyptgLZIiQvs364tBXEevax6JBrhVbY3lMKr9ySeFy/qzYOt0D3we/wtNOY
 vVd4nFlkD8gbXYi2EwrohGpBM0c7RHX5WgYQbVkxyAjgUtnz7SDmm6NH1PrHdQiSjrhANsLeO
 sYNBr/Phw51UZrkze0kMDzQ6N8DtaFWVgQrTHHnaRHVCD47EAQ9Z5s27dYGZmGeC2X8eUQJNf
 Owlclns
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the behavior of the shell script version of the interactive
rebase, by using the `output` function defined in `git-rebase.sh`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 63f6f25ced..dfa4fab98b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -647,10 +647,15 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 {
 	char **env = NULL;
 	struct argv_array array;
-	int rc;
+	int opt = RUN_GIT_CMD, rc;
 	const char *value;
 
 	if (is_rebase_i(opts)) {
+		if (!edit) {
+			opt |= RUN_COMMAND_STDOUT_TO_STDERR;
+			opt |= RUN_HIDE_STDERR_ON_SUCCESS;
+		}
+
 		env = read_author_script();
 		if (!env) {
 			const char *gpg_opt = gpg_sign_opt_quoted(opts);
@@ -687,7 +692,7 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 	if (opts->allow_empty_message)
 		argv_array_push(&array, "--allow-empty-message");
 
-	rc = run_command_v_opt_cd_env(array.argv, RUN_GIT_CMD, NULL,
+	rc = run_command_v_opt_cd_env(array.argv, opt, NULL,
 			(const char *const *)env);
 	argv_array_clear(&array);
 	free(env);
-- 
2.11.0.rc3.windows.1


