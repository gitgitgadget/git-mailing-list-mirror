Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 804E420248
	for <e@80x24.org>; Fri,  8 Mar 2019 21:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfCHVzl (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 16:55:41 -0500
Received: from mail-qt1-f201.google.com ([209.85.160.201]:53265 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfCHVzl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 16:55:41 -0500
Received: by mail-qt1-f201.google.com with SMTP id g42so4022717qtb.20
        for <git@vger.kernel.org>; Fri, 08 Mar 2019 13:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wNUkgnbKPaE8zyDrl2JzNKhkZOQyW5hMytqyZiyiuYc=;
        b=hnla7YMgzQtkNUeDWzp6o/hyY4Bl3pNlozRYXRh8YLUFyPbxGq8teTG+QhOzQpMl5z
         E6yGIzlRnUUrbDbrqoTx9TNeHHJ1jMWX/x2i4pV4e6OS+vFHYzjHiG7wpVOrRA6qnBRH
         Zif/Mz2MDz2KVUteqjZeEGJsA8pYk8akPYJtY7juGc1t8pmtaLWN2D3VLy0vRXdIB4dA
         Th2bOL+V0rglApkZ59YgA+3QkjRnEa25YWyTB1y2Ow1sd9YbBZ5uovLR50rGyRBCkVlT
         x299FvCastC/BLImlMYEgWYeGjtrE9PUKZcI9a0c79Zn8J/pQS+518fiKdjcbEsj7D33
         PpRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wNUkgnbKPaE8zyDrl2JzNKhkZOQyW5hMytqyZiyiuYc=;
        b=jQwn33I+hMKAriK9/gsApqYkRNRuGzFHBJlcyP++pbhZQyEqr58QKbZaZY0IfRFqq/
         QDYrB1gWLZBdh9Q69T/YT4FngmxFUV/KPbg4OYfSwP5b5wM5a/kDvwvIRovmDfKh4KRs
         SQiU8kgSpyWW5U9REwNDH+hr4SWdzU7s2CmJa783+y9BZDlknxNOzcK/MdAS7n2Lrwv2
         nU1OMlFow0mdYLTplH80BesOMtV8VfjWXOlvPzdrzdu/wuJQVzVZjy2hAnek3jxczBcn
         HlBRRpB1EC4e7sG7Q4cVLX8hZ8Lvutd3ctAitcAHcPjj3zFBaNhfQ+1irI2dzdMMIATh
         R+tw==
X-Gm-Message-State: APjAAAXLPScyfkTpy3kH+enxeds1NqBHGLlnKH27KMg/YJcEBEic8PmE
        7sJMrKx5UZQNORDyf4jAIYrvezmdVJTitrjdU257
X-Google-Smtp-Source: APXvYqzaJwp3Vv+X2pCYw+/ElIKS7EV175LL1FQ5DC9+jK/chMH2ccoP1qqHKbbeDZuN2hFN0JcAauqkuvj5TO5uRV3K
X-Received: by 2002:a0c:b8a3:: with SMTP id y35mr11661953qvf.25.1552082140227;
 Fri, 08 Mar 2019 13:55:40 -0800 (PST)
Date:   Fri,  8 Mar 2019 13:55:14 -0800
In-Reply-To: <cover.1552073690.git.jonathantanmy@google.com>
Message-Id: <66d31720a045e8be11561fe9a4fd511b57557f02.1552073690.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1550963965.git.jonathantanmy@google.com> <cover.1552073690.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH v2 2/8] http: improve documentation of http_pack_request
From:   Jonathan Tan <jonathantanmy@google.com>
To:     avarab@gmail.com, git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

struct http_pack_request and the functions that use it will be modified
in a subsequent patch. Using it is complicated (to use, call the
initialization function, then set some but not all fields in the
returned struct), so add some documentation to help future users.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 http.h | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/http.h b/http.h
index 4eb4e808e5..ded1edcca4 100644
--- a/http.h
+++ b/http.h
@@ -202,14 +202,31 @@ extern int http_get_info_packs(const char *base_url,
 	struct packed_git **packs_head);
 
 struct http_pack_request {
+	/*
+	 * Initialized by new_http_pack_request().
+	 */
 	char *url;
 	struct packed_git *target;
+	struct active_request_slot *slot;
+
+	/*
+	 * After calling new_http_pack_request(), point lst to the head of the
+	 * pack list that target is in. finish_http_pack_request() will remove
+	 * target from lst and call install_packed_git() on target.
+	 */
 	struct packed_git **lst;
+
+	/*
+	 * State managed by functions in http.c.
+	 */
 	FILE *packfile;
 	struct strbuf tmpfile;
-	struct active_request_slot *slot;
 };
 
+/*
+ * target must be an element in a pack list obtained from
+ * http_get_info_packs().
+ */
 extern struct http_pack_request *new_http_pack_request(
 	struct packed_git *target, const char *base_url);
 extern int finish_http_pack_request(struct http_pack_request *preq);
-- 
2.19.0.271.gfe8321ec05.dirty

