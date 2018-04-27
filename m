Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4688E1F424
	for <e@80x24.org>; Fri, 27 Apr 2018 21:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759320AbeD0Vj7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 17:39:59 -0400
Received: from mout.gmx.net ([212.227.17.20]:40229 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759082AbeD0Vj6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 17:39:58 -0400
Received: from localhost.localdomain ([37.201.195.116]) by mail.gmx.com
 (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MHH3P-1f6yQU35Xv-00E2jr; Fri, 27 Apr 2018 23:39:53 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v6 06/11] Add a test for `git replace --convert-graft-file`
Date:   Fri, 27 Apr 2018 23:39:46 +0200
Message-Id: <1a8c25baec240b0242873aedff8295cee7ba9742.1524865158.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.33.gfcbb1fa0445
MIME-Version: 1.0
In-Reply-To: <cover.1524865158.git.johannes.schindelin@gmx.de>
References: <cover.1524650028.git.johannes.schindelin@gmx.de> <cover.1524865158.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
X-Provags-ID: V03:K1:w9ZyANIkHH67FqoOqweHNMir2kVa7Oy8nXC2/7Cs0pGWVqXmP2U
 +Z+AmaocmfEYHp7WgFpf5ZcFkqtrKhysTYJmS2DQg9nLG4xxfmCpHDWp62YuJSJ0OHqlL9b
 7oPniQsSwtopasF75+Udk0TGEYMgLzNnSAUKyYs5fP3uU9jiKK++gFSggoCJF81lPXuvqon
 UbYefQ5p+Wjf0B2RsIb7A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mISBCl4ejTA=:t2nBRegnc1VB9/Lvb4sjYR
 6uXTmfrA4mI0MysPJQdLd1Fbm3xjBq/S3OJfyNrvai5ZSEnPI9J2hU7Q9hSlJdZLWl7YfkAUI
 MCd2av6A0hIybt+sKKEt4EFU4Qi0iL7WUiomRnQiv+d0VMDdTzLYqYOrBEN9w8ZoIY95IhoLG
 lTYNrKVHsLufL4hhReqRDLnEKzYfQd4r5UU8xq9j0n8E+sdNXgOej//kUlnq4BfWYgAMEK+AR
 x7HVxKeUGmL1xlWO4VTA7GlbZa32UVleBDZAYsyXEUCqnf5PSspWmYEjOtshmUGbpO5GKvSKj
 wJZyGgk+rjIN82zK7MZU3RmYz+Qjsajns+vtlQKhNMet6xcR6xp69JFIuBqyvedQfo8FnjR52
 B9mKVp2c4N0dVdfUOQTbwF8h4mzDDVpGYd4w/N3FxIAQ+HwJbPn8EYIQevBQp2mSZXUxb5Aoo
 ujPODUQ8GWX4X+eHdWDWdJxS9i03tC2xgaQN67jK1MeajvJGrbwv53cadr1t9dsr5xyedtbo2
 dcWwOfGPUf4MDNk1M1Xn25rTAzXeJiMVRfahOFXxcaOVsBsUxUmAqqfM92aZx+kp+1Lh1qAzG
 bt/GBkPUXZYbmWMfMx1YC+vdnJkdEvcCENgINvskNWLGLDCMI70zwM+mw2ixHmTGni93ZN5zB
 1zVU3WU00l7mQuVNJUkb72QXWOg3TdzRS1ZkmFYAR5U1tvAGakEPCg3ALeDPp5bmrmeSWcMR2
 KyY8Rscd90j8kRPFJKd4PrzazSj9aL7iFPU2JWFAQV15fU9yJ6fGJIA+g/7yS3tKVHagBYlne
 YEdj7jk
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


