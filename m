Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB17F1F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 00:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387827AbeGMAPN (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 20:15:13 -0400
Received: from mail-ua0-f202.google.com ([209.85.217.202]:42121 "EHLO
        mail-ua0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387733AbeGMAPL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 20:15:11 -0400
Received: by mail-ua0-f202.google.com with SMTP id m10-v6so7342198uao.9
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 17:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=oMrssp6XfHT4Kfp+IlvYj9oeFkELsiLPtJBxqLnxYwE=;
        b=rYkB8OCe+Z5kxopxVbFoaZ65b7owKPiD0WfGR+KXiUKs+q3KEwdMsDisVpYyFmFqui
         BFvmT/qOHvvosn/9/tYL4L7mhN6TkwZirdJmw85I80YM45APK1QspEum4JNw/tmLd2wT
         GXuiHyXm/2wOMkbgQqgz+lc/rdVRsrE9NoRCezyIWraevYEJijtEiwltnkvCPf3oxOow
         xtVNORdh4ota3K6qlYxQCer7yp+M7XdQDYOC54uCYoF1kKT+xRIMJOkLWujgCCZFQWUW
         OZyF4eKIGUaY+69xFa+gkQTAW36I892Plml+1F3JTirfxeZeI9WY7iQftsNVBIWo+Zgm
         iybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=oMrssp6XfHT4Kfp+IlvYj9oeFkELsiLPtJBxqLnxYwE=;
        b=lnPKbSnnNrJri8mE/HKcRUR17tHAq/atRg9xlVvKTu9ztalqGNTWYixZMjsF9oGl/s
         CVSLdTpCXPrzaLrFVD7ePj7aPYXFzQJ3lN0QcZHNEteq+IVzH6ekh/DWc190xDIoSIAC
         Ap+P32uVTHaqDsaoGqVJPf1ltpRGVazuDr57CB5OBAERBmeUwJ7oe6SDUc8JZgh/72nI
         CNjHP8E4twKlm4KjegAsENxzkJwqPvAhJg6fwUyGZ2KFALMqd0nGGNX8/0jGdMcb570X
         dcWnZxObIjB5PKrpd0p6GBFO+vv3Za0VpEbN8koHRLD/AsRL40eazA99I4t7eM9PTB4m
         /15Q==
X-Gm-Message-State: AOUpUlFsuEoEqk07b4OxdRIV5jxPFf/iRYVCbdz4BPMau9VKKjsCF9Q9
        UuzhiEGJ3W8Ts04OhV8l8w1efedTCK4sgXu9a7wqe1TxOxYd9YMn8gE9v8SnY7nD9egTHIzhmlI
        ZDK6ZlyO6vBOBP9P8aNQlqHukn0N3vYm+xXtOVl+0CZOf8JZdyP+3loAL7h1MRNgLt1Zqr3cZY9
        bd
X-Google-Smtp-Source: AAOMgpf51Q2tPoXTxDWUw7/E1g4Bu6/9z7sM8Nb892gMBueGjAXWNInSic8YvLPvO+8ARZDytFBGC9xTvZOkkBY7dpMI
MIME-Version: 1.0
X-Received: by 2002:a1f:2f8a:: with SMTP id v132-v6mr2091672vkv.64.1531440194818;
 Thu, 12 Jul 2018 17:03:14 -0700 (PDT)
Date:   Thu, 12 Jul 2018 17:03:07 -0700
In-Reply-To: <cover.1531438861.git.jonathantanmy@google.com>
Message-Id: <5a7731b13f8607740f7519e781b22d4098b1e979.1531438861.git.jonathantanmy@google.com>
References: <cover.1531438861.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: [PATCH 2/2] tag: don't warn if target is missing but promised
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

deref_tag() prints a warning if the object that a tag refers to does not
exist. However, when a partial clone has an annotated tag from its
promisor remote, but not the object that it refers to, printing a
warning on such a tag is incorrect.

This occurs, for example, when the checkout that happens after a partial
clone causes some objects to be fetched - and as part of the fetch, all
local refs are read. The test included in this patch demonstrates this
situation.

Therefore, do not print a warning in this case.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 t/t5616-partial-clone.sh |  9 +++++++--
 tag.c                    | 13 ++++++++++---
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index e8dfeafe7..bbbe7537d 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -229,9 +229,13 @@ test_expect_success 'when partial cloning, tolerate server not sending target of
 	git -C "$SERVER" tag -m message -a myblob "$BLOB" &&
 
 	# Craft a packfile including the tag, but not the blob it points to.
-	printf "%s\n%s\n--not\n%s\n" \
+	# Also, omit objects referenced from HEAD in order to force a second
+	# fetch (to fetch missing objects) upon the automatic checkout that
+	# happens after a clone.
+	printf "%s\n%s\n--not\n%s\n%s\n" \
 		$(git -C "$SERVER" rev-parse HEAD) \
 		$(git -C "$SERVER" rev-parse myblob) \
+		$(git -C "$SERVER" rev-parse HEAD^{tree}) \
 		$(git -C "$SERVER" rev-parse myblob^{blob}) |
 		git -C "$SERVER" pack-objects --thin --stdout >incomplete.pack &&
 
@@ -249,7 +253,8 @@ test_expect_success 'when partial cloning, tolerate server not sending target of
 
 	# Exercise to make sure it works.
 	git -c protocol.version=2 clone \
-		--filter=blob:none $HTTPD_URL/one_time_sed/server repo &&
+		--filter=blob:none $HTTPD_URL/one_time_sed/server repo 2> err &&
+	! grep "missing object referenced by" err &&
 
 	# Ensure that the one-time-sed script was used.
 	! test -e "$HTTPD_ROOT_PATH/one-time-sed"
diff --git a/tag.c b/tag.c
index 3d37c1bd2..1110e3643 100644
--- a/tag.c
+++ b/tag.c
@@ -4,6 +4,7 @@
 #include "tree.h"
 #include "blob.h"
 #include "gpg-interface.h"
+#include "packfile.h"
 
 const char *tag_type = "tag";
 
@@ -64,12 +65,18 @@ int gpg_verify_tag(const struct object_id *oid, const char *name_to_report,
 
 struct object *deref_tag(struct object *o, const char *warn, int warnlen)
 {
+	struct object_id *last_oid = NULL;
 	while (o && o->type == OBJ_TAG)
-		if (((struct tag *)o)->tagged)
-			o = parse_object(&((struct tag *)o)->tagged->oid);
-		else
+		if (((struct tag *)o)->tagged) {
+			last_oid = &((struct tag *)o)->tagged->oid;
+			o = parse_object(last_oid);
+		} else {
+			last_oid = NULL;
 			o = NULL;
+		}
 	if (!o && warn) {
+		if (last_oid && is_promisor_object(last_oid))
+			return NULL;
 		if (!warnlen)
 			warnlen = strlen(warn);
 		error("missing object referenced by '%.*s'", warnlen, warn);
-- 
2.18.0.203.gfac676dfb9-goog

