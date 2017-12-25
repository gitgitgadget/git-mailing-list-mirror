Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D1761F406
	for <e@80x24.org>; Mon, 25 Dec 2017 17:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753119AbdLYRsl (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Dec 2017 12:48:41 -0500
Received: from mout.web.de ([212.227.17.12]:55533 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753007AbdLYRsk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Dec 2017 12:48:40 -0500
Received: from [192.168.178.36] ([91.20.60.211]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LtFQN-1ewZ8C2yOx-012qth; Mon, 25
 Dec 2017 18:48:35 +0100
Subject: [PATCH v2 9/9] commit: remove unused function
 clear_commit_marks_for_object_array()
To:     Git List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <6ace4f8f-824b-2825-ef18-1fccebb9fb5c@web.de>
 <ac4c77a1-6403-ca20-2021-50c99201915a@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <ec7e1e97-4c29-6455-513c-c68ec3d88e4f@web.de>
Date:   Mon, 25 Dec 2017 18:48:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <ac4c77a1-6403-ca20-2021-50c99201915a@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:OEGo73/A8jbx0utHAN0REaLbtQXTEHmKLrtfuyTMCOeUJqIjPRw
 6ZUasWSX3TCyYDZ87rKW3lMEGNhBHOwRISEZ7RPnnLw85Fo3HBdDUhIDNS59TZ14Pq3CRSW
 /Ee0pDFksMj+L89FsntKH0d9htnpremPwfzPZpjyGsws7DwJxcBknhGOlXZtmMKunByFa7a
 eCsj+5Cr84LLe+8Gy7U3Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pLyTSnHdgH8=:RsliJEhL7KFZ5Wyer6jQwR
 3IuSAqr6IExQR5ljCnZrx5smM6jikw2dQa17Z2kD4gL1Gkr+g9qbLU0Xk/46MGhBmmGryX41c
 uY2PqvJxFS7ZdW9hoErM2vq0u9JEbHKwJxq7QH4jGbO7yycnzDaB8VuAWmI0DXYiT8++a8wLF
 5uNd6Br6QGLCJZNKy4kHNJ3oABMH/zQrI9U+NisE5LKg4FVMYYRMSouQaT1Rtx5RBraR2wshF
 vuqwc9sqwXdeuVCebMbj6VyWYFXibUY2EG6pp1/EnCcwltrgEWJuFWDU2Kren31nFP2iAiBVx
 G4JRCdTSstIcr5dKATz4GJbfr6KwbYtGJePf2q7uwNHJJjnZBf8jvwvhvCo4lldcMcTJxRIc0
 9iY7KImftHxXYnYdDRvfeg01Ayd8wsyYKBwM2uoPmVXT8XFE8S6Y+r5fUAEmeOKhsqt4MRZcN
 RINCoNJgoicCY8Q/Pu23erX9LTIJn+j6JiQZdiGbk3eaNiu0LcwlDUkFVRN/XCOARAcWwWlJz
 ByWY4/TfQtrwm4gf1dsUzi2exDJlzARyqDdMjPROy84wZRFq4g2zEDCaWo0Ty4faoQI6z46KN
 gsB/UVl+B3L1wD5JG8zxPy5mFettbo4G/i0WlWBMFDKL6qWeRLP/RxdNd+ukYPEhK/ZcqR5Ue
 SkLWpZPb0q4nSVoSe3keHy0qQvC1tG54yFCzlaHVg5eXLbUbCRX7IN1D9nsBmfRA9i0/LM/r2
 RXwvg4NxADLMFTRe4cxgy6qHIFPLBc80DfOO+mX8HBO4ZyYCdnDTtaV4cEegyy4PRJzwqyh3m
 /zd8UAS5SOx1YaJkTG9LR+7qaMedz1Zm7sh7PsKBUJ7Pi1HO3M=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 commit.c | 14 --------------
 commit.h |  1 -
 2 files changed, 15 deletions(-)

diff --git a/commit.c b/commit.c
index 9edc12f338..ff51c9f34a 100644
--- a/commit.c
+++ b/commit.c
@@ -559,20 +559,6 @@ void clear_commit_marks(struct commit *commit, unsigned int mark)
 	clear_commit_marks_many(1, &commit, mark);
 }
 
-void clear_commit_marks_for_object_array(struct object_array *a, unsigned mark)
-{
-	struct object *object;
-	struct commit *commit;
-	unsigned int i;
-
-	for (i = 0; i < a->nr; i++) {
-		object = a->objects[i].item;
-		commit = lookup_commit_reference_gently(&object->oid, 1);
-		if (commit)
-			clear_commit_marks(commit, mark);
-	}
-}
-
 struct commit *pop_commit(struct commit_list **stack)
 {
 	struct commit_list *top = *stack;
diff --git a/commit.h b/commit.h
index 99a3fea68d..bdf14f0a72 100644
--- a/commit.h
+++ b/commit.h
@@ -219,7 +219,6 @@ struct commit *pop_commit(struct commit_list **stack);
 
 void clear_commit_marks(struct commit *commit, unsigned int mark);
 void clear_commit_marks_many(int nr, struct commit **commit, unsigned int mark);
-void clear_commit_marks_for_object_array(struct object_array *a, unsigned mark);
 
 
 enum rev_sort_order {
-- 
2.15.1
