Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3A511F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 00:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfKMAe3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 19:34:29 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:55837 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfKMAe2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 19:34:28 -0500
Received: by mail-pl1-f202.google.com with SMTP id q1so204107pll.22
        for <git@vger.kernel.org>; Tue, 12 Nov 2019 16:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lrJ98Nde3vueeK3LlK8TBlFEVgVJyLjWTnfTa2tND2Q=;
        b=IsLrucgg/EaEtPek5d9Tv2dZWV0pbIT3mgPm2lIaHtBddTnPXwXjyt+rzV10DN4V4c
         R0B2oRSHW7AZFxgkXv+P5AhfV8lrqQELuNHJxAWyZ4Iiq9SWPPhyb2WSNT555Y1+4CjO
         c1WFGDMsi2uFdkVQsrLRq1kMJ1tjB5H5ZPe8pcAcClRAB3gJp4U0bCOZOJrOFTKQs1Fb
         w855WA4eS7VIls5cZsRjVjkrmFdtNodWchokSHXIboS+lIUeeKuqwQ3GKuO/XB2Lljvn
         AwNNEJrTuZ041/MeDLE+N/gB9gLA4RAWpxCLllnfN1e0bX7ufzKd7gWo1XY/hgBMtP4L
         +N9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lrJ98Nde3vueeK3LlK8TBlFEVgVJyLjWTnfTa2tND2Q=;
        b=dQgjTotmHedjg7EHOJb8ShCOFiev5NLcbgXAW8trn8LIlvcBR/Y8GDzt/HLRh4X1PV
         Uswn5Ryo+CB5xbLaB70IRCNBlqP1sn3CDbD4WXVEkLfEzhnJDPmibUAZwgRf2Vt9gKCz
         awKL0ewPcaRl9qU//08FQqbdXNJLpsZC8sKjdMhJ570DwrYJy1CRdx+WG0J4cBxyyMVr
         5U2VT5IDGMMYcyCYIC747PTfXZ2LmpbKNtWLTuHmKstfIZEkU2wWvXJsG8dCC6vmpZQy
         BVDmT41KJNzxpcGEt0dmdUKVIdJjOFKDe46edN+ecfz1jWYA3H/D0vmuVX/HpD+qAyPb
         1L8g==
X-Gm-Message-State: APjAAAW/dL+XeyDOMWJK6yhwscYxUkltiyCAKu/teoHg9l5IyntqcZCx
        ZTzM5N05tF8h5kuj7ZCctwPCWH72REngQHtns4D3+aLqLqupz2afz25rRqUddfzV7QmwGG40UcE
        EIGa2pONglQNo9Gif3l8mrDjKDM3aPXQTR4RE1Jq2BMxkvQvadUqH4tPf8FJ4YmJ3yfx4UuzrUd
        PI
X-Google-Smtp-Source: APXvYqzzEtd9AWM+lVBcOG0of0pA3njIKCN6lHt6PZPhB4cUi3GdW3PidF75WzHlXWWaombZQ3laZsHi3Hkug0sSafbG
X-Received: by 2002:a63:6782:: with SMTP id b124mr421230pgc.220.1573605266372;
 Tue, 12 Nov 2019 16:34:26 -0800 (PST)
Date:   Tue, 12 Nov 2019 16:34:19 -0800
In-Reply-To: <cover.1573604516.git.jonathantanmy@google.com>
Message-Id: <84d8cee52e7c1dc030826c8caa0e107f80783b9c.1573604516.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1573604516.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH 1/2] clone: remove fetch_if_missing=0
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 6462d5eb9a ("fetch: remove fetch_if_missing=0", 2019-11-08)
strove to remove the need for fetch_if_missing=0 from the fetching
mechanism, so it is plausible to attempt removing fetch_if_missing=0
from clone as well. But doing so reveals a bug - when the server does
not send an object directly pointed to by a ref, this should be an
error, not a trigger for a lazy fetch. (This case in the fetching
mechanism was covered by a test using "git clone", not "git fetch",
which is why the aforementioned commit didn't uncover the bug.)

The bug can be fixed by suppressing lazy-fetching during the
connectivity check. Fix this bug, and remove fetch_if_missing from
clone.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/clone.c | 3 ---
 connected.c     | 3 ++-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index c46ee29f0a..8bf12ce5e3 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -927,8 +927,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 	struct argv_array ref_prefixes = ARGV_ARRAY_INIT;
 
-	fetch_if_missing = 0;
-
 	packet_trace_identity("clone");
 	argc = parse_options(argc, argv, prefix, builtin_clone_options,
 			     builtin_clone_usage, 0);
@@ -1265,7 +1263,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	}
 
 	junk_mode = JUNK_LEAVE_REPO;
-	fetch_if_missing = 1;
 	err = checkout(submodule_progress);
 
 	strbuf_release(&reflog_msg);
diff --git a/connected.c b/connected.c
index 36c4e5dedb..c337f5f7f4 100644
--- a/connected.c
+++ b/connected.c
@@ -62,7 +62,8 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 		 * received the objects pointed to by each wanted ref.
 		 */
 		do {
-			if (!repo_has_object_file(the_repository, &oid))
+			if (!repo_has_object_file_with_flags(the_repository, &oid,
+							     OBJECT_INFO_SKIP_FETCH_OBJECT))
 				return 1;
 		} while (!fn(cb_data, &oid));
 		return 0;
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

