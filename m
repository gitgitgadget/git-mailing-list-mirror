Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D8011F428
	for <e@80x24.org>; Sun, 29 Apr 2018 22:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754438AbeD2WSJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Apr 2018 18:18:09 -0400
Received: from mout.gmx.net ([212.227.17.21]:34103 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754410AbeD2WSH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Apr 2018 18:18:07 -0400
Received: from localhost.localdomain ([37.201.195.116]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MbrR4-1etaqE1KnW-00JG5u; Mon, 30 Apr 2018 00:18:02 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH 2/6] t1406: prepare for the refs code to fail with BUG()
Date:   Mon, 30 Apr 2018 00:17:58 +0200
Message-Id: <9bbfd73a8e03a888a5e9e8800d853ece518a8bf5.1525040253.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.36.gdf4ca5fb72a
In-Reply-To: <cover.1525040253.git.johannes.schindelin@gmx.de>
References: <cover.1525040253.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:5uxBFFsyWncvPhX1NUnUwJoK2VcNCgBg+Cgp0vRcHMEkTkvQxQ+
 PorGZXmEv3L1WBERHbnrt0V3rtYYYH5flTqb21+Jw5tzyldKIklXi7KLF6sBUtWAHn4hKFA
 Yio4MJ7dwO9N7n/zClTxBUT72Lbi0f183lRUafwmidgIWy45XdTfxLqQzX1WTG6S8p1gU5J
 KHLmrGDUTJNZikOM+BmVQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:psB48F6gUEA=:/i6lzyp0brAbTgEccuLRhJ
 hVF3rJG44u/l3AsTZQCYsGs7832607OYEQR5SWFB9uS2mKVTGeXTXiNx3TePnQu5bopKqqk+a
 XzoNBrfPBvg0ewSt6GyJT9W8Ujkm4PZta+Hu8nlEGx3LQFkwNIPt/Dct4giRAsuMVqCvtIrkF
 sLQuWZu5CE7yDTPPhj5ojcbtl3JHvXIPgSY8MMjKJWhVQljOa0ip8tNstCFw7Pp3sTivLCrb3
 DBWSVxQTQHu5Cvg3xv2OMaWXAYdVjXHO2HqRgiuUt8EB+DBknxoy4bQvWnr/mZBtEJyuXhSZf
 bNuhuZXH2E9rQBACBFyyydGkE8TK/ZRArD8N/9tJvW9AA3QedXXzV322ppluxPd/NbUspRXB/
 zk5EkjQKLMvHd7LFWB6Texst9QilseX3DbPwiFWutKX7cAaHXTBZhARMBMOgTfGWzJgnqgCx6
 BC4eG52nOxBHfGga76/UQqm6wJN13UI1lbrYAIK4gbCWUQD5dBhOvry+WDSlnRc9pzB9IrPOb
 hUejMvqGj8aGtfOiFkbKBphJnOv0l/hskiYkiAJNq7CfHnQiwUKzAx32CU2gRDkhxchQN0P+0
 XpLtl12uvw3vS+AI3JbUZHJ/PhiS1p68ZYQkWWxJo+DuB8w5jubr9f0yFzTjAUxhPoV35il86
 H6IaNhUuvSgWdvArRmeydCk4ahjuiEPLOfhr9ftfFn84gZvggTd8BivV3y1OWivCnt6K9BS+K
 LK6c7ICWgaf3n2TM1S5RwCVkikXIUfWz8zNkn3zDsh/AKSLzVjiSdYV/fB5aK7ih+lmGvKPSr
 uzpaZwq
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

t1406 specifically verifies that certain code paths fail with a BUG: ...
message.

In the upcoming commit, we will convert that message to be generated via
BUG() instead of die("BUG: ..."), which implies SIGABRT instead of a
regular exit code.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1406-submodule-ref-store.sh | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/t/t1406-submodule-ref-store.sh b/t/t1406-submodule-ref-store.sh
index e093782cc37..0ea3457cae3 100755
--- a/t/t1406-submodule-ref-store.sh
+++ b/t/t1406-submodule-ref-store.sh
@@ -16,7 +16,7 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'pack_refs() not allowed' '
-	test_must_fail $RUN pack-refs 3
+	test_must_fail ok=sigabrt $RUN pack-refs 3
 '
 
 test_expect_success 'peel_ref(new-tag)' '
@@ -27,15 +27,18 @@ test_expect_success 'peel_ref(new-tag)' '
 '
 
 test_expect_success 'create_symref() not allowed' '
-	test_must_fail $RUN create-symref FOO refs/heads/master nothing
+	test_must_fail ok=sigabrt \
+		$RUN create-symref FOO refs/heads/master nothing
 '
 
 test_expect_success 'delete_refs() not allowed' '
-	test_must_fail $RUN delete-refs 0 nothing FOO refs/tags/new-tag
+	test_must_fail ok=sigabrt \
+		$RUN delete-refs 0 nothing FOO refs/tags/new-tag
 '
 
 test_expect_success 'rename_refs() not allowed' '
-	test_must_fail $RUN rename-ref refs/heads/master refs/heads/new-master
+	test_must_fail ok=sigabrt \
+		$RUN rename-ref refs/heads/master refs/heads/new-master
 '
 
 test_expect_success 'for_each_ref(refs/heads/)' '
@@ -91,11 +94,11 @@ test_expect_success 'reflog_exists(HEAD)' '
 '
 
 test_expect_success 'delete_reflog() not allowed' '
-	test_must_fail $RUN delete-reflog HEAD
+	test_must_fail ok=sigabrt $RUN delete-reflog HEAD
 '
 
 test_expect_success 'create-reflog() not allowed' '
-	test_must_fail $RUN create-reflog HEAD 1
+	test_must_fail ok=sigabrt $RUN create-reflog HEAD 1
 '
 
 test_done
-- 
2.17.0.windows.1.36.gdf4ca5fb72a


