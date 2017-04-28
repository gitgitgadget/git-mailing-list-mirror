Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCA10207E4
	for <e@80x24.org>; Fri, 28 Apr 2017 23:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1951719AbdD1XyR (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 19:54:17 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:36353 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1948362AbdD1XyN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 19:54:13 -0400
Received: by mail-pg0-f48.google.com with SMTP id t7so21627743pgt.3
        for <git@vger.kernel.org>; Fri, 28 Apr 2017 16:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N6ZltBlhEhESOqz0s60loPKvIEZLoMbz0tJu15LbRNI=;
        b=diKMem+YWn3WB8QTWM7H97+zutiq67vUeTa6GbfMU7b3KGnFYUUXNMksGJ+lUShg+c
         q6SbXTEiYpDVy2tpqzi3uawJoGVwRdK67zk4KK9SUNuuZxLx37A6RfjlF9xHt+Yu4SKC
         HIuUvflHyGYs08E37igo8bJimJOAJiH/scyVaI5OC7n6QkXcgsM/c6exqjG9HhkdR07D
         Zi1xkoNtOIFqPQdt7ixskHwtRStkBbHV8HjACT43dE5sJ4ejPPuUxOuGpPiPDiUBNrkg
         P8lGaqwXlgVSdw1kisWIVhcz+8sdZzpzD3VN3q/XVwFelMgq9liTcHxFZfGrhjVsH4mF
         u/AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N6ZltBlhEhESOqz0s60loPKvIEZLoMbz0tJu15LbRNI=;
        b=ZCFfYq/m+9Q9E/BK5pQKVt4b+AeulyN+T8zOglFtuNenPZQiaWvWn7WgFiYHo3E/Xq
         sdiBVxevBdaheeIfDtio+8kbQPpVl56/a5em0yT7IgqjTTlxPUob+dXZ5wDxZ7tfM9nT
         gB8WhUAJXud1onBJdHWv/nX+RILS7fVuViw0Srb2e0lpcUItFv+HWKBJimnHPXYD3Qbz
         D9rZ4XMEaQ574Ttwyj2AD6Bu5o30yIOYRtsgNS/53JoLGGoalJaqLFiUIv7pqlaOrI6G
         MM2C6KB9eS5R6ZVwhISbxa/+fs3HPI6TZehakEh9Ra3EwAsCQq8ijmX41UETuZjy6e9+
         jp3Q==
X-Gm-Message-State: AN3rC/5R+sKtJFu+7KMpJrL1XuMQ0SKouc6pw+WOKO/yqSMXE86GURL1
        V/9iyQyf5thiYRiSIN+xuQ==
X-Received: by 10.84.238.9 with SMTP id u9mr18480810plk.126.1493423652008;
        Fri, 28 Apr 2017 16:54:12 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id 188sm5332429pfu.15.2017.04.28.16.54.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 28 Apr 2017 16:54:10 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [PATCH 1/6] submodule: rename add_sha1_to_array
Date:   Fri, 28 Apr 2017 16:53:57 -0700
Message-Id: <20170428235402.162251-2-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.rc0.306.g87b477812d-goog
In-Reply-To: <20170428235402.162251-1-bmwill@google.com>
References: <20170428235402.162251-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename 'add_sha1_to_array()' to 'append_oid_to_array()' to more
accuratly describe what the function does since it handles 'struct
object_id' and not sha1 character arrays.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 submodule.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/submodule.c b/submodule.c
index d3299e29c..be0f5d847 100644
--- a/submodule.c
+++ b/submodule.c
@@ -951,17 +951,18 @@ static void submodule_collect_changed_cb(struct diff_queue_struct *q,
 	}
 }
 
-static int add_sha1_to_array(const char *ref, const struct object_id *oid,
-			     int flags, void *data)
+static int append_oid_to_array(const char *ref, const struct object_id *oid,
+			       int flags, void *data)
 {
-	oid_array_append(data, oid);
+	struct oid_array *array = data;
+	oid_array_append(array, oid);
 	return 0;
 }
 
 void check_for_new_submodule_commits(struct object_id *oid)
 {
 	if (!initialized_fetch_ref_tips) {
-		for_each_ref(add_sha1_to_array, &ref_tips_before_fetch);
+		for_each_ref(append_oid_to_array, &ref_tips_before_fetch);
 		initialized_fetch_ref_tips = 1;
 	}
 
-- 
2.13.0.rc0.306.g87b477812d-goog

