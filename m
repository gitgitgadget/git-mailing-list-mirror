Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC6F71F404
	for <e@80x24.org>; Fri, 20 Apr 2018 22:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752644AbeDTWXb (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 18:23:31 -0400
Received: from mout.gmx.net ([212.227.17.21]:56825 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751227AbeDTWXa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 18:23:30 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MI9n0-1f800W21fi-003ulb; Sat, 21
 Apr 2018 00:23:26 +0200
Date:   Sat, 21 Apr 2018 00:23:10 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 06/11] Add a test for `git replace --convert-graft-file`
In-Reply-To: <cover.1524262793.git.johannes.schindelin@gmx.de>
Message-ID: <de1d455d6e526cf264ce1291c1923b97271969c3.1524262793.git.johannes.schindelin@gmx.de>
References: <cover.1524125760.git.johannes.schindelin@gmx.de> <cover.1524262793.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Tap8IJTA+ZDjoFN4kzwCCXjwKSRrAlvbSDmGrnPjPwC2QXJAO17
 kVEiKKXcOb9aFgMtP1gE/giJVnN/llYW2S/EFfR+54bKjnwNkqzs9BcIzuOyFYWN064gM2z
 H8gTlT/h7u4qkXgd2h6/s/kKWBpN8O+LvmVHElpCtGNJpuOyxbKOVHyE1aT4QuY6DCxmJug
 FuBuNbbPuOQCIA7uNOPug==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6Tozq0MiSUE=:ETVDy+PKPeJ1QgNa8Y/sf4
 ZyLTFUxFzAtTM/TUFhjJ1pKTaAqvt2L1Bg4LoWQVlur9DBTQ0EEfharbwLvwzO8IZ/vHpwSth
 Fu6NQzP44mReJKLnaSOc8PJu2Pxx1OtqB9Rp+MqqHgYMpIv3/WckqjmD8fZmEuynwDzsKbFpC
 ynF6VZvLNW9pUVPuRbnrXVhZFhe2za5/IZy0kdP9e94KHpt0m3iO5jxznyuU69ZjSfyncoRGh
 67aXxJ1A9O3lMaoqDPLHzs1knkQbw5uwOQ0BUv4deu3qShFgiUtZt+BsnFNRGso5QrIjBqGX0
 tnXOt8eaHtY84dY5hz/t8MwXOjM6Ruj6JsifYKT2l0ZjBHPZksFaEMJf0V9F213w/BrWuixaJ
 vt9ULQ8InYv8ZqR1hy5/ItRINJxFT6ffimuRq/l8TWe02X5bCunIVm81eNCfPSmQ+rWIjJgbd
 o02vKqOmBDeVkcquDB3vDBjOVHTflfWsO3idZGFFbMuGsXzvojxSSWsgQsukcEKywNKZX725w
 Q/IopSwRGrSYpiHgHfbyRzE584VTN3Y+sLvVwpknguebeLz/oGhIaWL5THVEqqc3a2TbWSG1P
 oeyTfe9EViLzhJ3ZNN4gcwJUaSA7ibcCTRiaIixn7QTWUx5FMiz4lj4/RYb1wwir8lD5o64qy
 8SpR3vvRdDcDpuR1b0O7WRY1ScZgiWgWPVeB4PGlHX39txXmkcmuMfdNVF6iZ9Jr7edZMTokU
 +MNRKpQ4O8S0nzr8symvnf6PJMLOfSAi7Wi3nO7VMHnQkCnJJy9OPnstijc8vSxNrYAJWwmH1
 OUcdpEhsnx54mHJNopuzcgY9GFVNkeeYD3X73l4QS9QDiPgM0U=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The proof, as the saying goes, lies in the pudding. So here is a
regression test that not only demonstrates what the option is supposed to
accomplish, but also demonstrates that it does accomplish it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t6050-replace.sh | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index c630aba657e..8a3ee7c3db9 100755
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
+	grep "$EMPTY_BLOB $EMPTY_TREE" err &&
+	grep "$EMPTY_BLOB $EMPTY_TREE" .git/info/grafts
+'
+
 test_done
-- 
2.17.0.windows.1.15.gaa56ade3205


