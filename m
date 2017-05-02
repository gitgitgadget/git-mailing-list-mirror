Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4852207D6
	for <e@80x24.org>; Tue,  2 May 2017 01:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751178AbdEBBCs (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 21:02:48 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:34991 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750732AbdEBBCr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 21:02:47 -0400
Received: by mail-pg0-f54.google.com with SMTP id o3so47001276pgn.2
        for <git@vger.kernel.org>; Mon, 01 May 2017 18:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PT9a5MHsdJntJWCChKGuYDYytAYwz5Zmb9XjsUYhVRU=;
        b=k3LY+kqeRmXjHZR/WG2in4uI1j/L1Qprceqqb0pKXgIbpb7VTe8MTgeV2EM+kkb3kt
         dICNgtk6xwqWo+hajNEGBrsAGqgKq+s9vu2dPRsUjiy3wNf8md1FsXffrfMo8zcv8OER
         nIe8Jdyl6JvRzJNg6g1xWmroQwdUqRKmkISKpudiuZ0QRQzSPjfOujdF7nvoXaszatHf
         54Wvs7lqRbsuWM18HS5UXaYnay/NOAiICfzavhISjyLpIgOITYyhPNLhIqoyqgnHMWKh
         lJ8RV4wTKPJiIRAUrV6dD3hRb88T6f3a5mO/u2nD63jq3hFUSmLe4CS9uIvcrkay8Bg/
         VoGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PT9a5MHsdJntJWCChKGuYDYytAYwz5Zmb9XjsUYhVRU=;
        b=grHtMpqHUPfNuQ46ptPvS6b6YI9ZTZJmPPzOxxTR/qTQDlxMGcaMSX4Bzr33E1fsHj
         XBSvjyyxlM0OcxnmufF9HdCJZoMnDrcVZh/gBLhQ6AYwhoR68pEpXZTJiDltHmGDSAWf
         67BSp6MooiUnFqLWqqq+DoEc961jIKPA5byzDva2/GsDCIfOJc61+rqiU5jLIq2PhMGE
         /mHnVfi2sigx+Ut3whFQ4inkRuHwkVWolx34d5kkZLUc6ZqMTTg6Py3r6nJbUqV4o6qC
         kuGHfKEh8UDhzkrFFQOWlF8c4uGXTiM9hU4/qbVBzSD4NcsqskEE7DtWFDUJbd7OeWoT
         qw0w==
X-Gm-Message-State: AN3rC/6mWE53NJv9TLM3MWVEENw2MFhwqx9VMx55eZPRavBVXX/fdNnR
        Syjq4jVRJIgxopvs
X-Received: by 10.99.163.67 with SMTP id v3mr29300178pgn.206.1493686966370;
        Mon, 01 May 2017 18:02:46 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id d1sm13532526pfa.56.2017.05.01.18.02.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 May 2017 18:02:44 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, gitster@pobox.com,
        sbeller@google.com
Subject: [PATCH v2 1/6] submodule: rename add_sha1_to_array
Date:   Mon,  1 May 2017 18:02:34 -0700
Message-Id: <20170502010239.179369-2-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.rc1.294.g07d810a77f-goog
In-Reply-To: <20170502010239.179369-1-bmwill@google.com>
References: <20170428235402.162251-1-bmwill@google.com>
 <20170502010239.179369-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename 'add_sha1_to_array()' to 'append_oid_to_array()' to more
accurately describe what the function does since it handles 'struct
object_id' and not sha1 character arrays.

Change-Id: Ia6d15f34cee4d0dc32f7a475c69f4cb3aa8ce5bf
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
2.13.0.rc1.294.g07d810a77f-goog

