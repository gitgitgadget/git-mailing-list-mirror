Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C07C200B9
	for <e@80x24.org>; Thu,  3 May 2018 15:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751140AbeECPbP (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 11:31:15 -0400
Received: from mout.gmx.net ([212.227.17.20]:35029 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751501AbeECPbF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 11:31:05 -0400
Received: from virtualbox.mshome.net ([37.201.195.116]) by mail.gmx.com
 (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0M4Wwq-1eQz1e12K4-00yln0; Thu, 03 May 2018 17:31:02 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 15/18] branch-diff: offer to dual-color the diffs
Date:   Thu,  3 May 2018 17:31:01 +0200
Message-Id: <2f8017c732fce38f45074125554fddf6e072ea99.1525361419.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.409.g0f525fc0ba7
In-Reply-To: <cover.1525361419.git.johannes.schindelin@gmx.de>
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ZFCmS5mcmAMc5oEii9Xpq/+7yHJ1gK1N2VUR+k6U+DWNel33fDM
 J07E3FhoZq+pIMTiMapwOtBzLT43RISrwpiFZ6OmCU9iAbFK4hiZXkuMmjibumbaFVjRCZW
 hi7FKMoy72Cq6LLexdnC/RUAiX6l3jgT5pJGMum275yfvb+V1aU1Qx5DW0ck4C5pGRBkQKM
 RsR+wP1cRadxs/aukbkog==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ADjJ5ADXCAg=:spaNKq+7mC6J5JaL7EBKcB
 YiJRXtOOKG0tP7VM24Dp7E9Yhn0nHP52Cq5+7sGrrl/oZ5eqBXT1ovsFryb3UCm3qzrzEHfOE
 sx4nZCaRNpk4enB2MVRZDaurLVHQAUlvoIQTk6ANiFyYPN6b2F0NN6Xd0cUBcbQoihjbhjsFS
 pHAVQP3acV3v1WqecBVF1DoGTizuLf6KQTFjwTMnT+d1Z2UVz7DGxDww9PM+PD+WoQpbUd+OJ
 ZQn9JIFMN2ChpVMEsqK2HXxu4GFzuK2+jM2PRIQpbD+lzdb+RJrEGbwViWbjMqHTRdperSqe9
 feG9zyJ/1MCgmverP4HYYifat2MunBcIeIM7VElfZCGrBKxHLKYctaJdXM4Qg7Q/poLGU7LDZ
 zdQaWvC/BurSBLkz0WGu7jj8Y7Kme1Gf3absnkTlXNMJAi8l2IgIPzGYTuMvVBLP3yuUje9GK
 xP/nvRmmuwSVE9JLjUHPTYSIzit9hiJuPD4xpczROLj7YpCP2hPdlOOoMsq5pTu4v3MqBxqr2
 IFemqVK5+dOmeuUMc9yMp1c3O390AQwGzrl6PJQ2ptd7yISN11pbLJ5vPwLqs/gnvMwfboN73
 XdBPIbwDuNYRFZc2T7qn5zTaLlp5tgleZdI5vGoZ9aax9p56NF9rs3sKTJktAv1ErZwVfxuda
 QDZSWtAhte5OTUcyBp8lMLGeE/kvb/rpJOcUnxFTCIMBvQtup371SWq8X3eCJgY/O3jODY3N8
 LK26e+6TIGoGd+T0UsWUnSykFJzqyYc32zouErgdHJ7CyBmTmjHhlUlb6+AFBy5dgo5Rs9MN4
 CQQ0e+U
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When showing what changed between old and new commits, we show a diff of
the patches. This diff is a diff between diffs, therefore there are
nested +/- signs, and it can be relatively hard to understand what is
going on.

With the --dual-color option, the preimage and the postimage are colored
like the diffs they are, and the *outer* +/- sign is inverted for
clarity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/branch-diff.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/builtin/branch-diff.c b/builtin/branch-diff.c
index e505b696d11..edf80ecb736 100644
--- a/builtin/branch-diff.c
+++ b/builtin/branch-diff.c
@@ -432,8 +432,11 @@ int cmd_branch_diff(int argc, const char **argv, const char *prefix)
 {
 	struct diff_options diffopt = { 0 };
 	struct strbuf four_spaces = STRBUF_INIT;
+	int dual_color = 0;
 	double creation_weight = 0.6;
 	struct option options[] = {
+		OPT_BOOL(0, "dual-color", &dual_color,
+			    N_("color both diff and diff-between-diffs")),
 		OPT_SET_INT(0, "no-patches", &diffopt.output_format,
 			    N_("short format (no diffs)"),
 			    DIFF_FORMAT_NO_OUTPUT),
@@ -469,6 +472,11 @@ int cmd_branch_diff(int argc, const char **argv, const char *prefix)
 	argc = j;
 	diff_setup_done(&diffopt);
 
+	if (dual_color) {
+		diffopt.use_color = 1;
+		diffopt.flags.dual_color_diffed_diffs = 1;
+	}
+
 	if (argc == 2) {
 		if (!strstr(argv[0], ".."))
 			warning(_("no .. in range: '%s'"), argv[0]);
-- 
2.17.0.395.g6a618d6010f.dirty


