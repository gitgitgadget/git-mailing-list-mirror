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
	by dcvr.yhbt.net (Postfix) with ESMTP id DE71D1F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 10:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfKLKim (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 05:38:42 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50438 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbfKLKik (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 05:38:40 -0500
Received: by mail-wm1-f67.google.com with SMTP id l17so2555974wmh.0
        for <git@vger.kernel.org>; Tue, 12 Nov 2019 02:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vMv3vzr3BnanY2d+E5rxW0m9+LMWs5sc3C5exAsemYk=;
        b=bR6KNBnBKp2N3Ma7N2HU1OW9jarLgjEAuNJZ7Ckdzhi9R/63n+u+ckNyZdZEFtwFue
         aXJC9uROgmcwnDHrALCBgjfdveMEH998m0p+kkxKX6kj4OeFuMWuyddtQKZww0Hylo1u
         v+up2cjjZbWofm459JejJWuKbNPwSsfgu5Wu81RviP+9mRy5W6BRjsjH7Ue1PfGEQi4s
         NNeh9JcE2+EUpap+cnqb4R9sg6J5qLRO/ixk00tk79k1fT+ZatRJ3aLfpiNYzQR/LeNq
         yl7TkD4Wxjk89xxS69/rt7D6WqCE/NPf6xxb9Gm73BxWRQoP3d8M5iCMSBeN9Xtq5ebt
         7A3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vMv3vzr3BnanY2d+E5rxW0m9+LMWs5sc3C5exAsemYk=;
        b=C42nh9V4ri7bns6UszMJUpPQpet9X5EwHcUEsUi++cBHq5zIEHHYyE62GVrLErtmjQ
         e+z1ajBT7CbmQJ9E1PFM/nJ/dT70mdrbuvvmj1BtQinibDrJYYCYqx1fg657PFV2Pdgd
         lYVmTx8WXwMvBsk463b+mGaEvNtuQ4N2rdi2/XrTuoRGqHpf7CV8mEFMWVmObwADKylS
         Carvb50u5BukT/DmY5R1IO2ZCqyDwt4NyJh9cW+KN2nmyAF7p0Hmcw79hkcYXDQ9ro2R
         qti1S7VRUHo6eRhHBfBd6Ruuot1OcbtUPPzYm0o0Svwww528G0/HhxIxCJqOU1nGkL0g
         Vm7w==
X-Gm-Message-State: APjAAAUG/tLnY3jZaGkGC4pH/fOoLRJU2nGdUpby1mCmSD0LMAvQWhta
        iP8m6d0yGQ4+3hmKVwwMqkM=
X-Google-Smtp-Source: APXvYqyhEycLVNJRfG9Irby99LiXcDOaU2yU/r67jVz5UXq4GFUgssL2NvyJVoJiM2UVV3uMG0D8Lw==
X-Received: by 2002:a7b:c776:: with SMTP id x22mr3144651wmk.144.1573555118758;
        Tue, 12 Nov 2019 02:38:38 -0800 (PST)
Received: from localhost.localdomain (x4d0c65ae.dyn.telefonica.de. [77.12.101.174])
        by smtp.gmail.com with ESMTPSA id f24sm2313759wmb.37.2019.11.12.02.38.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Nov 2019 02:38:38 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 08/13] name-rev: pull out deref handling from the recursion
Date:   Tue, 12 Nov 2019 11:38:16 +0100
Message-Id: <20191112103821.30265-9-szeder.dev@gmail.com>
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

The 'if (deref) { ... }' condition near the beginning of the recursive
name_rev() function can only ever be true in the first invocation,
because the 'deref' parameter is always 0 in the subsequent recursive
invocations.

Extract this condition from the recursion into name_rev()'s caller and
drop the function's 'deref' parameter.  This makes eliminating the
recursion a bit easier to follow, and it will be moved back into
name_rev() after the recursion is eliminated.

Furthermore, drop the condition that die()s when both 'deref' and
'generation' are non-null (which should have been a BUG() to begin
with).

Note that this change reintroduces the memory leak that was plugged in
in commit 5308224633 (name-rev: avoid leaking memory in the `deref`
case, 2017-05-04), but a later patch (name-rev: restructure
creating/updating 'struct rev_name' instances) in this series will
plug it in again.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/name-rev.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index e43df19709..e112a92b03 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -106,30 +106,19 @@ static struct rev_name *create_or_update_name(struct commit *commit,
 
 static void name_rev(struct commit *commit,
 		const char *tip_name, timestamp_t taggerdate,
-		int generation, int distance, int from_tag,
-		int deref)
+		int generation, int distance, int from_tag)
 {
 	struct commit_list *parents;
 	int parent_number = 1;
-	char *to_free = NULL;
 
 	parse_commit(commit);
 
 	if (commit->date < cutoff)
 		return;
 
-	if (deref) {
-		tip_name = to_free = xstrfmt("%s^0", tip_name);
-
-		if (generation)
-			die("generation: %d, but deref?", generation);
-	}
-
 	if (!create_or_update_name(commit, tip_name, taggerdate, generation,
-				   distance, from_tag)) {
-		free(to_free);
+				   distance, from_tag))
 		return;
-	}
 
 	for (parents = commit->parents;
 			parents;
@@ -148,11 +137,11 @@ static void name_rev(struct commit *commit,
 
 			name_rev(parents->item, new_name, taggerdate, 0,
 				 distance + MERGE_TRAVERSAL_WEIGHT,
-				 from_tag, 0);
+				 from_tag);
 		} else {
 			name_rev(parents->item, tip_name, taggerdate,
 				 generation + 1, distance + 1,
-				 from_tag, 0);
+				 from_tag);
 		}
 	}
 }
@@ -284,12 +273,16 @@ static int name_ref(const char *path, const struct object_id *oid, int flags, vo
 	if (o && o->type == OBJ_COMMIT) {
 		struct commit *commit = (struct commit *)o;
 		int from_tag = starts_with(path, "refs/tags/");
+		const char *tip_name;
 
 		if (taggerdate == TIME_MAX)
 			taggerdate = commit->date;
 		path = name_ref_abbrev(path, can_abbreviate_output);
-		name_rev(commit, xstrdup(path), taggerdate, 0, 0,
-			 from_tag, deref);
+		if (deref)
+			tip_name = xstrfmt("%s^0", path);
+		else
+			tip_name = xstrdup(path);
+		name_rev(commit, tip_name, taggerdate, 0, 0, from_tag);
 	}
 	return 0;
 }
-- 
2.24.0.388.gde53c094ea

