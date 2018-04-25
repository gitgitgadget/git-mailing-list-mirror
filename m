Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A29E1F404
	for <e@80x24.org>; Wed, 25 Apr 2018 09:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751936AbeDYJye (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 05:54:34 -0400
Received: from mout.gmx.net ([212.227.17.21]:35605 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751710AbeDYJya (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 05:54:30 -0400
Received: from localhost.localdomain ([37.201.195.116]) by mail.gmx.com
 (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0M7kwW-1eOvjN0c0u-00vRCo; Wed, 25 Apr 2018 11:54:25 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v5 06/11] Add a test for `git replace --convert-graft-file`
Date:   Wed, 25 Apr 2018 11:54:17 +0200
Message-Id: <07372da0d614a13b0aeb58cac3b5994530e6de5c.1524650029.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.33.gfcbb1fa0445
MIME-Version: 1.0
In-Reply-To: <cover.1524650028.git.johannes.schindelin@gmx.de>
References: <cover.1524303776.git.johannes.schindelin@gmx.de> <cover.1524650028.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
X-Provags-ID: V03:K1:cCCq0lVVGy8skxZ4D+fCXhb6czZ7k3VgLiDW1u6lJPtPq7Q9H7t
 9JAvSfVJDlSI60KW8oH8phctn3bg/L9uzAhUoRJoACbQW7NF2R1LGpt+yzQ/HcqAic5xZFk
 MgmaS3LbnMk/D0RfssKHgnqQXphfLoNNH7ZI2zNNF7FTQxMuxowG1cOwAgjujAyEwOMXyJg
 HVqb1k5Vm5GPpn7jC/yxA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:o50luuLdr3E=:xu3VQtTM7W+zOvqfXfDc4s
 5oPIsYZM6LtcXFJHus4R/1Nz2EnjVVnYykESGLk4r+Mi19gR+LCMTtc7jA6zDt81CJUlnZ+qd
 /QcTgHOs8ngPEt+M9OaIs2tyUt8ODvpYfQgbe4V2FCSyna3JQpGkyjy+kPTcZLcgisdS1h9s5
 5c8BkMfIJemsQlHXBad27ptrZJj0AhnRBUVeIiZTikuFhds5DRyS4xDJ3CRgTQyCPN5Cwa2Kj
 nVEEFPvtsKaEXWMQp/KNKzEuPvQBVfppeAR/tXDdkw0AIkrq2qkpNHnQyYtfyuTOC6nI2txwJ
 BAFW4heiGxM4kMSyvgz8bbu58VeJWLP+IpVjzzGbPafw9Hdu3mqAWe73eXijfOwz0gMnlfjLB
 CfPPg55ApjLhZfIWy7E59+1Ro2k9AM8rsil9aTKx2N6bSAm7llm0eld27gBzt3Ec88IJq8eFC
 Zt4WUGHMSUJdRc3xKxhJ3dQw02SsXwxGxDsxNz3TIgRyt7mduHsBOkQs7qS9jMBKukq08x7iC
 toT8ydfQEjeKoYxspz9TwiGC+i1/W4D3XP2ufAYdtK0327xnrVsxLRtAVXxzheHaguwBCPHLd
 InWbM5qdc/03wp2ZNJfmJwThZ1LyPA5w+U2CgL10/5OCjfWrspHQeniHgDaopERt46AHJy6UI
 MDSAvqQ1H+kOHsbX9Tx1SH340YZ6Qk3HYOjc2R2UMsUBs4FPorrff0YWezoqh4+2QAzGCNa8+
 Zu5Z2T/i6iOnEYs+rhj19trGlqPITCcBhqUuG+xnBPTBKjrgUrTTs08K8b4jXQQDmkUYXzxv6
 Khv4641UBW/45psJ4HU+22ZaSLdS6p2ZKMka37ELELNCA+I6LhQkGtGkNpjkYqkuq24CyV5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The proof, as the saying goes, lies in the pudding. So here is a
regression test that not only demonstrates what the option is supposed to
accomplish, but also demonstrates that it does accomplish it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/replace.c  |  1 -
 t/t6050-replace.sh | 20 ++++++++++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index fdd12c5ffc0..acd30e3d824 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -494,7 +494,6 @@ static int convert_graft_file(int force)
 	fclose(fp);
 
 	strbuf_release(&buf);
-	argv_array_clear(&args);
 
 	if (!err.len)
 		return unlink_or_warn(graft_file);
diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index c630aba657e..bed86a0af3d 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -444,4 +444,24 @@ test_expect_success GPG '--graft on a commit with a mergetag' '
 	git replace -d $HASH10
 '
 
+test_expect_success '--convert-graft-file' '
+	: add and convert graft file &&
+	printf "%s\n%s %s\n\n# comment\n%s\n" \
+		$(git rev-parse HEAD^^ HEAD^ HEAD^^ HEAD^2) \
+		>.git/info/grafts &&
+	git replace --convert-graft-file &&
+	test_path_is_missing .git/info/grafts &&
+
+	: verify that the history is now "grafted" &&
+	git rev-list HEAD >out &&
+	test_line_count = 4 out &&
+
+	: create invalid graft file and verify that it is not deleted &&
+	test_when_finished "rm -f .git/info/grafts" &&
+	echo $EMPTY_BLOB $EMPTY_TREE >.git/info/grafts &&
+	test_must_fail git replace --convert-graft-file 2>err &&
+	test_i18ngrep "$EMPTY_BLOB $EMPTY_TREE" err &&
+	test_i18ngrep "$EMPTY_BLOB $EMPTY_TREE" .git/info/grafts
+'
+
 test_done
-- 
2.17.0.windows.1.33.gfcbb1fa0445


