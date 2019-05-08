Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EB591F45F
	for <e@80x24.org>; Wed,  8 May 2019 15:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbfEHPyH (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 11:54:07 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36080 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727839AbfEHPyE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 11:54:04 -0400
Received: by mail-ed1-f67.google.com with SMTP id a8so22554601edx.3
        for <git@vger.kernel.org>; Wed, 08 May 2019 08:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=p96xa/X4tw+yqZyrXz07+namZBiZMo8owflm8h6gj90=;
        b=tuzIpFhUoSlBZoNPW3gGqDXpLzzJb6El0rsTctG03hp/HF/tn79KIg6cRRzM3VOYqQ
         5T7MouDmVPq/rgwue6zG+yda1pZhy8tQBs6A7I0dn5ZmAMqsnJWerBzDBzSMlFlWw7m9
         37tyym3oeFvM97yVUeur4ln5BSpC4q19+38bKBrAJdy3BRpaFor2UoK72e1iv9vzsCkb
         /SLnFKyBVNRGbgYDLA8qyPdOp3Uv+meg0tCpMC565GsTtC2uiw/8Fu4GIZRbS4iRJyH5
         Z1BFM41Xn6qi9WNaRRBgYyVR0sGHymNsWUrIKe79ShWjGyOIs0pq99+37+0oO7KSyKjm
         5p+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=p96xa/X4tw+yqZyrXz07+namZBiZMo8owflm8h6gj90=;
        b=sZ5/wDUXxH+znTQUq3MmXveWjFgH+BUfodHCDr5zH/y9xbPglkkd896/nYxmaG5Kic
         c4G6oo/IslqPjJgKYMg5GgKwNXb0NLa3fyVhPQkMxEn0DuXEL3AHat+o8xVqtSpy2GxG
         3FinVTp1wLo4F/7CFA2ihkjwof0z89baHtNTZgdJL9pz6eTlkzR6zgy8dZM2QNiE2OZA
         hPA7tn0xAj82k0ovdmyHjyrGIJ+sN98+WtnB/VY+5bSjNfodiCtBQhVsplPtOzaRLlRp
         RH0aTkfVq6aRsJUE2Rlo0Ev5Rde4Epiih+vcD76dMWHSAt+xZn4QzNAKnqm1bW86TWtE
         FvwQ==
X-Gm-Message-State: APjAAAVA5cfORH/N+LAp/CXrm+AFeU0qentEmKWop2TC/5hna2+bAHNn
        1lVUDgAntoVPuoWkHAQowQCzUO8e/80=
X-Google-Smtp-Source: APXvYqzw8VfJdOCWNFT9aWGOcs165lWUd7VDo5FjChVT6R2ZQ+FrxJSrbTFmjT9aF3FgbgR4r4tnBw==
X-Received: by 2002:a17:907:104e:: with SMTP id oy14mr30306976ejb.253.1557330842502;
        Wed, 08 May 2019 08:54:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f8sm5223713edd.15.2019.05.08.08.54.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 08:54:02 -0700 (PDT)
Date:   Wed, 08 May 2019 08:54:02 -0700 (PDT)
X-Google-Original-Date: Wed, 08 May 2019 15:53:46 GMT
Message-Id: <3c52385e5696887c40cab4a6b9b7923d60a0567c.1557330827.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.git.gitgitgadget@gmail.com>
References: <pull.184.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 17/17] fetch: add fetch.writeCommitGraph config setting
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, git@jeffhostetler.com,
        jrnieder@google.com, steadmon@google.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/fetch.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index b620fd54b4..cf0944bad5 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -23,6 +23,7 @@
 #include "packfile.h"
 #include "list-objects-filter-options.h"
 #include "commit-reach.h"
+#include "commit-graph.h"
 
 static const char * const builtin_fetch_usage[] = {
 	N_("git fetch [<options>] [<repository> [<refspec>...]]"),
@@ -62,6 +63,7 @@ static const char *submodule_prefix = "";
 static int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
 static int recurse_submodules_default = RECURSE_SUBMODULES_ON_DEMAND;
 static int shown_url = 0;
+static int fetch_write_commit_graph = 0;
 static struct refspec refmap = REFSPEC_INIT_FETCH;
 static struct list_objects_filter_options filter_options;
 static struct string_list server_options = STRING_LIST_INIT_DUP;
@@ -79,6 +81,11 @@ static int git_fetch_config(const char *k, const char *v, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(k, "fetch.writecommitgraph")) {
+		fetch_write_commit_graph = 1;
+		return 0;
+	}
+
 	if (!strcmp(k, "submodule.recurse")) {
 		int r = git_config_bool(k, v) ?
 			RECURSE_SUBMODULES_ON : RECURSE_SUBMODULES_OFF;
@@ -1670,6 +1677,16 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 
 	string_list_clear(&list, 0);
 
+	if (fetch_write_commit_graph) {
+		int commit_graph_flags = COMMIT_GRAPH_SPLIT;
+
+		if (progress)
+			commit_graph_flags |= COMMIT_GRAPH_PROGRESS;
+
+		write_commit_graph_reachable(get_object_directory(),
+					     commit_graph_flags);
+	}
+
 	close_all_packs(the_repository->objects);
 
 	argv_array_pushl(&argv_gc_auto, "gc", "--auto", NULL);
-- 
gitgitgadget
