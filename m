Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20C441F89D
	for <e@80x24.org>; Wed, 26 Jul 2017 01:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751641AbdGZBfC (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 21:35:02 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35294 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751611AbdGZBfC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 21:35:02 -0400
Received: by mail-pf0-f169.google.com with SMTP id h29so29723624pfd.2
        for <git@vger.kernel.org>; Tue, 25 Jul 2017 18:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=c719qdL98kowEBoeSTAgLMrYceU3jnZ3iZKadbNO6u4=;
        b=OQHbP6yiLbt3mURWjxtnWb9ympbNMA3FuMkg5zCm090qnrC4IKgYK9dR7X0B2DYTa7
         40i7XIyoq8OpICaiF5b6BSaz3+/GpZPCHFBBTKBUdEdQcoU+ZW577avDwE+FxU3r24no
         oYONcK/gWrrXnz4UmHDp7w5iJGSAl9teX3rbo5HzizN/w4W03cjcGXFDrO+XxCtRP3DK
         xyYHguuuH6ayWCtAeBsh2Kw12lc8IxJP3T+aOCJNhzrik07igxApVDsJbS1SXedPqM8U
         Vq8MmuWSm8iSb8KncUbPD2wckEl4Sz9sXhoYGxhVZ7+qaD20JfWw9nv/AY98wIFdyH5y
         KMhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=c719qdL98kowEBoeSTAgLMrYceU3jnZ3iZKadbNO6u4=;
        b=T/IFd7ZZSJC50KxskmQXd50w72ddaYu/tSz5tWJVpA+8d75xX0Dp9rMXNqRS6JPWej
         aW8/Teaap3zvFSBJcrPoqG9GtWkFePCPnsnlGuzzOJ+z4qWpkO+ARIZURaSI44+KchS9
         pLia3AulrGj1qHZD4VH5moN5pRXVqRtdk5csDfxLZkFG9IbUtHSyilm9NTqitHVEzy3I
         5bpzLwOudkSKntI4dntQdbIN8Cns6FqPIAJnyYadHiLklbyaQLozeMT+lzHH0y8/Vq2O
         4Ns6V225Fuo9X6MO9exuD/Axck3MbEsX022kulbgkAfypE6CGvJCR3jKAaAKu5nfJDm1
         QTOw==
X-Gm-Message-State: AIVw110LiqM/QedpGJ3JguXQBkSPONEPY968mIfQXGwRd5u4VSbZwuHP
        feUeZkHQlVaxtpa560EPng==
X-Received: by 10.84.174.3 with SMTP id q3mr24013567plb.289.1501032901139;
        Tue, 25 Jul 2017 18:35:01 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id u13sm26884259pgq.75.2017.07.25.18.34.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Jul 2017 18:34:59 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH] fsck: cleanup unused variable
Date:   Tue, 25 Jul 2017 18:34:56 -0700
Message-Id: <20170726013456.4187-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.0.rc0.400.g1c36432dff-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the unused variable "heads" from cmd_fsck().

This variable was made unused in commit c3271a0 ("fsck: do not fallback
"git fsck <bogus>" to "git fsck"", 2017-01-17).

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
While working on fsck, I noticed one more possible cleanup.
---
 builtin/fsck.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 99dea7adf..cc5a5cfab 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -667,7 +667,7 @@ static struct option fsck_opts[] = {
 
 int cmd_fsck(int argc, const char **argv, const char *prefix)
 {
-	int i, heads;
+	int i;
 	struct alternate_object_database *alt;
 
 	errors_found = 0;
@@ -735,7 +735,6 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	heads = 0;
 	for (i = 0; i < argc; i++) {
 		const char *arg = argv[i];
 		unsigned char sha1[20];
@@ -753,7 +752,6 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 				add_decoration(fsck_walk_options.object_names,
 					obj, xstrdup(arg));
 			mark_object_reachable(obj);
-			heads++;
 			continue;
 		}
 		error("invalid parameter: expected sha1, got '%s'", arg);
-- 
2.14.0.rc0.400.g1c36432dff-goog

