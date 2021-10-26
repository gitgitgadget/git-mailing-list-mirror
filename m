Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E24C433F5
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 12:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D27F61156
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 12:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235685AbhJZMN6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 08:13:58 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:33611 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbhJZMN5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 08:13:57 -0400
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MWixU-1mCdGO1UXA-00X6Hr; Tue, 26 Oct 2021 14:11:24 +0200
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id 8B0591E01E7;
        Tue, 26 Oct 2021 12:11:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id d6z4iaE4ET-y; Tue, 26 Oct 2021 14:11:23 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (30-usr-pf-main.vpn.it.cetitec.com [10.8.5.30])
        by mail.cetitecgmbh.com (Postfix) with ESMTPSA id 323B01E01E6;
        Tue, 26 Oct 2021 14:11:23 +0200 (CEST)
Received: by pflmari.corp.cetitec.com (Postfix, from local account)
Date:   Tue, 26 Oct 2021 14:11:22 +0200
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH] Fix "commit-msg" hook unexpectedly called for "git pull
 --no-verify"
Message-ID: <YXfwanz3MynCLDmn@pflmari>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:+jmZBp80tSxFxKUqKzg6K6CtqdGbKpHzyK+8GdxYkOF+4Gm8iVw
 vt6H1pTCbgobQ/NC37ZXUUJcLefIm6IyWXYxlDtwKPDkPLG6BqERpVXqtxUelWnOg4z0+3k
 oxiao1tuD48Tdq2VLQs2m6nhlmjnjGuwNeRddFbOHXGML69pq7K2m1QIfMGz8alboorp/bz
 cQI+Gooj0EzAzrxBmgWWA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2gFsFvBlhoI=:D2epdKlJwwtDARjXZxDmmd
 rMwax0y4KKJBsajxDjXxNZ0OJdREEv6iJjjIg06/NOsQEOz/nIaacqBtxoMyDERjXoRbRLpOb
 WRDpFkBeSYWT1fA9rYMKp+vSCNBBNOvSVcvkWy1At0X1a+E7tIKTMcKTmiLUNR9+27BfUXR61
 ZYP/3nsOjmnXxT55ercab9b+8xWHhxdbs0xOIiN+VZsW9b0hzuuqZsLAtalNFTIIkH/rBT2SS
 owwxfDY0QG2265w6cBxeJM9+3FZWiiL5NRwCen4PulEkZZrJjNLtj2kwE4GTE4IzBBqu3VWZI
 nGcU+7N3H66eZd4qMg0f/qdWSggHvectwuXUNYrx9X20pdxh6JELeJEF2wLa/0B8RoEN7CzXf
 2c85NHD6jGXqjfJcZHzaZN2CVw8IVvb9onEqzGmc/yifWiG2exLNtCw+GHd9LqVyDrkM6+d1U
 yVPWazEGWRIfOaHLpvUQdlpcpiMfAzvP+UY42kgfwnt4hQa6GMFPcK/yAUcpvKWpb0M6SLD6F
 9jsgric3+mZxZq8FL2Wm9B9YyAcwSKKS1AGu/vp+vyI7gxSgPmI5dadyp5JE7vjWUr81Zg7S1
 qN+taOitMSi9C00mOtIONbsFXQYnqZGo+e7Sn3b5ThJD4JqMdAcKSXGxVnpR2lgCGoi2SAZPG
 q9bIlw9Li2vGq9rXYizK1eMnZGjdfuYEZ7nsUBsDqPHLHhGPrDbo/fSfuXIXn31vnvcUDLsX/
 vzZnYXgkuOleP35f
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The option is incorrectly translated to "--no-verify-signatures",
which causes the unexpected effect of the hook being called.
And an even more unexpected effect of disabling verification
of signatures.

The manual page describes the option to behave same as the similarly
named option of "git merge", which seems to be the original intention
of this option in the "pull" command.

Signed-off-by: Alexander Riesen <raa.lkml@gmail.com>
---
 builtin/pull.c          |  6 ++++++
 t/t5521-pull-options.sh | 11 +++++++++++
 2 files changed, 17 insertions(+)

diff --git a/builtin/pull.c b/builtin/pull.c
index 425950f469..428baea95b 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -84,6 +84,7 @@ static char *opt_edit;
 static char *cleanup_arg;
 static char *opt_ff;
 static char *opt_verify_signatures;
+static char *opt_no_verify;
 static int opt_autostash = -1;
 static int config_autostash;
 static int check_trust_level = 1;
@@ -160,6 +161,9 @@ static struct option pull_options[] = {
 	OPT_PASSTHRU(0, "ff-only", &opt_ff, NULL,
 		N_("abort if fast-forward is not possible"),
 		PARSE_OPT_NOARG | PARSE_OPT_NONEG),
+	OPT_PASSTHRU(0, "no-verify", &opt_no_verify, NULL,
+		N_("bypass pre-merge-commit and commit-msg hooks"),
+		PARSE_OPT_NOARG | PARSE_OPT_NONEG),
 	OPT_PASSTHRU(0, "verify-signatures", &opt_verify_signatures, NULL,
 		N_("verify that the named commit has a valid GPG signature"),
 		PARSE_OPT_NOARG),
@@ -688,6 +692,8 @@ static int run_merge(void)
 		strvec_pushf(&args, "--cleanup=%s", cleanup_arg);
 	if (opt_ff)
 		strvec_push(&args, opt_ff);
+	if (opt_no_verify)
+		strvec_push(&args, opt_no_verify);
 	if (opt_verify_signatures)
 		strvec_push(&args, opt_verify_signatures);
 	strvec_pushv(&args, opt_strategies.v);
diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index db1a381cd9..0eb1916175 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -225,4 +225,15 @@ test_expect_success 'git pull --no-signoff flag cancels --signoff flag' '
 	test_must_be_empty actual
 '
 
+test_expect_success 'git pull --no-verify flag passed to merge' '
+	test_when_finished "rm -fr src dst actual" &&
+	git init src &&
+	test_commit -C src one &&
+	git clone src dst &&
+	echo false >dst/.git/hooks/commit-msg &&
+	chmod +x dst/.git/hooks/commit-msg &&
+	test_commit -C src two &&
+	git -C dst pull --no-ff --no-verify
+'
+
 test_done
-- 
2.31.0.30.g60a470ee5c

