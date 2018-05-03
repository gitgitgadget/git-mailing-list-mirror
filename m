Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34B7F200B9
	for <e@80x24.org>; Thu,  3 May 2018 23:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751461AbeECXBi (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 19:01:38 -0400
Received: from mout.gmx.net ([212.227.17.20]:45499 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751423AbeECXBg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 19:01:36 -0400
Received: from virtualbox.mshome.net ([37.201.195.116]) by mail.gmx.com
 (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MTfZc-1eo4uw1udM-00QTuM; Fri, 04 May 2018 01:01:30 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Wink Saville <wink@saville.com>
Subject: [PATCH v2 6/6] rebase --rebase-merges: root commits can be cousins, too
Date:   Fri,  4 May 2018 01:01:29 +0200
Message-Id: <f7ee1b3de12e2163c6b370eac5fbbc62c718b973.1525388473.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.38.g05ca542f78d
In-Reply-To: <cover.1525388472.git.johannes.schindelin@gmx.de>
References: <cover.1524868165.git.johannes.schindelin@gmx.de> <cover.1525388472.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:u7lyrwUujjMlSPtnClLswUoTjcECL0tr0nkF7iAIS5ShiIpL6uc
 2RUkYmPUImgZnJjRfDC1xx1x4lWOSvryYlNVCjhF6tuJhIgxT1kb5oIx6wxj1clRpkB6O3B
 YRzhzpIHfFXfo4uFFDMIWPCgmMhYjyjCQdHe/1Xk5sCMFgc4h+Zp9ybN2ML2XfHM4akrbhh
 k3wqhw1JkILQ/dkMex7TA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BVaGq2i1ypU=:EvbUovcIXslfVBLMyc4j1x
 H1Qe5tUrbKYpk9cpUSWT2SfYriHsoTA1TehzrFxW+CUggbgYgl8DhzI/gnruqisExWRTP4xjr
 Iw1o8L49bvEkC8s4+CYBRWKqLMXzXbTw0hAXQ7ARsXUTidwDIRoU4p463JJJnpobZi6bOooA0
 61s4/gtDKSewXial7txQ3W3cqZJEpUVToGI+Hhfy3E3BDqs9kEwyg3fPNpMKmbKQYAlOorDI9
 r7Sd2A6flHedMmYS1LBZImoKeENXTaQGWmF1uLvp79p7zVfc+DvaTgfzkqBEpD9zXkVvypJs3
 vwxEob8LmTYGe0XYC0keIKi7qILzlx1HG1r4AdDwmXlnkjdKPjSIk9RVvYbxc4qXVDlCGTwxM
 3rqfSEprFVw4cSjMsTm9E1KaSIqHY0lwZL2X4nPUZeIkYjnGDA5XNrgSLracT/iJQ9oBZaoxZ
 hZ3O3id51kSPqR11Idf8KLf4cT/0EpY7lWMsA2rxr44npgK4RMFIj/NNCJb3lEsK8/y8dlgmy
 8UiPz2ZV3C13Z5YP9b618BWlUKLsoWF1bgUFEneg17rbdkmgGOFDTuVbhgTTR+IlbeaQBaIpO
 zK2TbTqn8lUIbVkjmyAD7rCXtFYlo5HwsKcIq9dThKNHry7LIUa/s60lLrmDsGhq1Y6Sd8GnV
 dNnPsh35YxH7dgXDXKvNdFdIl7fBhuXm7Pv2SbtYBGgjcon8/3Sp0aLnwRNBCCwn02ebEGoL6
 VnLbjwzPfSdoZuNpyp2iKZU89OYA9WI/+gkgrPiVzYLLaoJKdQ8AbrQDKw4gQDwvN7E+zrpA0
 DsthRJO
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reported by Wink Saville: when rebasing with no-rebase-cousins, we
will want to refrain from rebasing all of them, even when they are
root commits.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c              |  3 ++-
 t/t3430-rebase-merges.sh | 25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 65a8c493781..01e561bc20e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3903,7 +3903,8 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 		}
 
 		if (!commit)
-			fprintf(out, "%s onto\n", cmd_reset);
+			fprintf(out, "%s %s\n", cmd_reset,
+				rebase_cousins ? "onto" : "[new root]");
 		else {
 			const char *to = NULL;
 
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index 5543f1d5a34..ce6de6f491e 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -287,5 +287,30 @@ test_expect_success 'a "merge" into a root commit is a fast-forward' '
 	test_cmp_rev HEAD $head
 '
 
+test_expect_success 'A root commit can be a cousin, treat it that way' '
+	git checkout --orphan khnum &&
+	test_commit yama &&
+	git checkout -b asherah master &&
+	test_commit shamkat &&
+	git merge --allow-unrelated-histories khnum &&
+	test_tick &&
+	git rebase -f -r HEAD^ &&
+	! test_cmp_rev HEAD^2 khnum &&
+	test_cmp_graph HEAD^.. <<-\EOF &&
+	*   Merge branch '\''khnum'\'' into asherah
+	|\
+	| * yama
+	o shamkat
+	EOF
+	test_tick &&
+	git rebase --rebase-merges=rebase-cousins HEAD^ &&
+	test_cmp_graph HEAD^.. <<-\EOF
+	*   Merge branch '\''khnum'\'' into asherah
+	|\
+	| * yama
+	|/
+	o shamkat
+	EOF
+'
 
 test_done
-- 
2.17.0.windows.1.38.g05ca542f78d
