Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D95D21F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 10:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfKLKiq (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 05:38:46 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53819 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbfKLKio (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 05:38:44 -0500
Received: by mail-wm1-f68.google.com with SMTP id u18so2528951wmc.3
        for <git@vger.kernel.org>; Tue, 12 Nov 2019 02:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a6MP/bZbj3rJQcHQQraeUyrLBln2w0orScmhIltzCEI=;
        b=CVPC1ETsI5KEv1IJgukSKLu6TA1baMo/RnCX/QIBEr99z9Bh8y+SkW6d92AkknXePz
         WJmeN8a3xxxCZkFvaoOpgcZs+J/HlVNPFt0C8Jim6dRi7xyby9eZLq48ySCERJGc5iTv
         ptW7nfL4zR4fOMsHf0sNsDcKT/q+lBQR91SfjakLr7H7EY/dbMZPVdMEAiX3WDjj7nV8
         Uvn19mH7mIOkQdkP0v+LvK9yGAilaf2qBkS32IMYWhvBFYbrctZqsXLLd5tefHEPg0Rj
         5gitrNfkpZ7JcM+UH/ymQCMe7l6gMnAkmIL2tBAVHtA6+LfkZqX49BGdTWz9XD4aJuhr
         HB1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a6MP/bZbj3rJQcHQQraeUyrLBln2w0orScmhIltzCEI=;
        b=AiNFiVUmQS5GTP9T5EeVFdC3ENxkQp1ks9nX0sTxGd4CCUPdc/PA8wHUzle8SUG1zz
         6NEg15jvE+2WMfmZ0IpUZPcf6X1enmLzk5u93cpkWuPF7pmpo6uRvn9vT6EIb3SnUxFU
         gXI5j3zDWKyJN430zIAYULZOD4tV55AWRcE76OFoSfg/ZBCLpQ9AgOi5bcezWB9k3RVy
         AjYyc0adAG03cMZpj8EiEr/xAvR+G8dDsWT92JaDL4ngzQWQekECfGPOuEyuGbmWr6Iq
         Ru3yVLSz5s+dkwZww8jjw2Dxu4qtXo+hjinoOUcJDQaxLiB97jx6hWmaL5r7cPY5KDp9
         XMEQ==
X-Gm-Message-State: APjAAAW8yQAU4XeSfrT3KcAqfV1hB0E/t/UUmSPkgrTcGqQW0KGUChg8
        nlk/TG8TJ2up1Xfc0bMuYtY=
X-Google-Smtp-Source: APXvYqzcq30uWCw4enOCGJv8rRH0cVpwX9yM0og9yqfpMCgL5gsSdkr4ygi9HgzsSGUCVqiRQTLEJw==
X-Received: by 2002:a05:600c:2550:: with SMTP id e16mr3096044wma.69.1573555121041;
        Tue, 12 Nov 2019 02:38:41 -0800 (PST)
Received: from localhost.localdomain (x4d0c65ae.dyn.telefonica.de. [77.12.101.174])
        by smtp.gmail.com with ESMTPSA id f24sm2313759wmb.37.2019.11.12.02.38.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Nov 2019 02:38:40 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 10/13] name-rev: restructure creating/updating 'struct rev_name' instances
Date:   Tue, 12 Nov 2019 11:38:18 +0100
Message-Id: <20191112103821.30265-11-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.24.0.388.gde53c094ea
In-Reply-To: <20191112103821.30265-1-szeder.dev@gmail.com>
References: <20190919214712.7348-1-szeder.dev@gmail.com>
 <20191112103821.30265-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At the beginning of the recursive name_rev() function it creates a new
'struct rev_name' instance for each previously unvisited commit or, if
this visit results in better name for an already visited commit, then
updates the 'struct rev_name' instance attached to the commit, or
returns early.

Restructure this so it's caller creates or updates the 'struct
rev_name' instance associated with the commit to be passed as
parameter, i.e. both name_ref() before calling name_rev() and
name_rev() itself as it iterates over the parent commits.

This makes eliminating the recursion a bit easier to follow, and the
condition moved to name_ref() will be moved back to name_rev() after
the recursion is eliminated.

This change also plugs the memory leak that was temporarily unplugged
in the earlier "name-rev: pull out deref handling from the recursion"
patch in this series.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/name-rev.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 5041227790..6416c49f67 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -111,14 +111,12 @@ static void name_rev(struct commit *commit,
 	struct commit_list *parents;
 	int parent_number = 1;
 
-	if (!create_or_update_name(commit, tip_name, taggerdate, generation,
-				   distance, from_tag))
-		return;
-
 	for (parents = commit->parents;
 			parents;
 			parents = parents->next, parent_number++) {
 		struct commit *parent = parents->item;
+		const char *new_name;
+		int new_generation, new_distance;
 
 		parse_commit(parent);
 		if (parent->date < cutoff)
@@ -126,7 +124,6 @@ static void name_rev(struct commit *commit,
 
 		if (parent_number > 1) {
 			size_t len;
-			char *new_name;
 
 			strip_suffix(tip_name, "^0", &len);
 			if (generation > 0)
@@ -135,15 +132,19 @@ static void name_rev(struct commit *commit,
 			else
 				new_name = xstrfmt("%.*s^%d", (int)len, tip_name,
 						   parent_number);
-
-			name_rev(parent, new_name, taggerdate, 0,
-				 distance + MERGE_TRAVERSAL_WEIGHT,
-				 from_tag);
+			new_generation = 0;
+			new_distance = distance + MERGE_TRAVERSAL_WEIGHT;
 		} else {
-			name_rev(parent, tip_name, taggerdate,
-				 generation + 1, distance + 1,
-				 from_tag);
+			new_name = tip_name;
+			new_generation = generation + 1;
+			new_distance = distance + 1;
 		}
+
+		if (create_or_update_name(parent, new_name, taggerdate,
+					  new_generation, new_distance,
+					  from_tag))
+			name_rev(parent, new_name, taggerdate,
+				 new_generation, new_distance, from_tag);
 	}
 }
 
@@ -280,11 +281,17 @@ static int name_ref(const char *path, const struct object_id *oid, int flags, vo
 		path = name_ref_abbrev(path, can_abbreviate_output);
 		if (commit->date >= cutoff) {
 			const char *tip_name;
+			char *to_free = NULL;
 			if (deref)
-				tip_name = xstrfmt("%s^0", path);
+				tip_name = to_free = xstrfmt("%s^0", path);
 			else
 				tip_name = xstrdup(path);
-			name_rev(commit, tip_name, taggerdate, 0, 0, from_tag);
+			if (create_or_update_name(commit, tip_name, taggerdate,
+						  0, 0, from_tag))
+				name_rev(commit, tip_name, taggerdate, 0, 0,
+					 from_tag);
+			else
+				free(to_free);
 		}
 	}
 	return 0;
-- 
2.24.0.388.gde53c094ea

