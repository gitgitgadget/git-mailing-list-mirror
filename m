Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E60C1F462
	for <e@80x24.org>; Thu, 25 Jul 2019 17:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403841AbfGYRqf (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 13:46:35 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45005 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403829AbfGYRqd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 13:46:33 -0400
Received: by mail-pf1-f195.google.com with SMTP id t16so23089830pfe.11
        for <git@vger.kernel.org>; Thu, 25 Jul 2019 10:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rpm5Sx0bHVnvrta+O7m5G8oNBcSRQyp6mhnlfk9vVgQ=;
        b=AqDxgf9NufDz3S+M1dicU325435gEROWhBym+Lv0Lfix8DipV5AynamkHhpp2Pv9Oz
         sPW9CeVHaUEnS29FnUWx++eV5sKb4uEQl3h581X2tbVfSOHMHriC+fjmvdU4gHPVW93W
         cOdAeLzlAVdMZB5S48C0n39fhFsqHVeK6Rk3RwRCPA9VZxekxZ3GsOT5f5Kd1308ZNDw
         Ksh3JBidpqHtRTGNzAjouAX5cLK6AhYQQbwYyqpSmOLLqtcH4RYzgFNjgklE3zEJfyUg
         thzMsw9cgfWhH3esUaCH8UNOvqcSddtjxsYV/+ic0G91xLbmCHWGLNF9PgdhuyZx2Hnr
         M/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rpm5Sx0bHVnvrta+O7m5G8oNBcSRQyp6mhnlfk9vVgQ=;
        b=aAWZSN5xgyeVCqrkYp79HrR7yXgBRJChJ+y7nTdJz/U8/8wPs2Uh052V/G+q8iJFLq
         bUHpU+na53HmjOXvBzySCtOD4vN9fcfDdIndyEnnOhLLLmEj3VmDCk5L6SLDpbXqSZrD
         sUYOdNepjukvc7TAkknlu4G88FyjHdRw8Zlfa3QJBNXnj3nm5woReScVVfNvz0Xhp0Lb
         DCWSEyaEHv1ZGGOspRmQC9sj+cXbo6z9DPHAYPjr6SvzOcbuwBiT/D+7jLdoCXUHwuXH
         QI6yPX0Tje2KjI0ptC07ZvnL8VaZJ2M1UVVHTbwekdKltik77RzHIsuQ9vH9u6irdGpk
         YHYg==
X-Gm-Message-State: APjAAAVaIV2mj/ULh3FcVl+ZPgxgS91xU9yH1H2+4Y6U1KubaWXf6hEJ
        dvuaic6nRkvaz9x6rq5WI6woZg/X
X-Google-Smtp-Source: APXvYqy8ohhWWQBRCf/wJz8ZGuPTC+zaUSBoBnKfvGcSXjPgzgeM7oJViLHOWcrCXTRqfDUF99c8IA==
X-Received: by 2002:a63:6901:: with SMTP id e1mr57134763pgc.390.1564076792438;
        Thu, 25 Jul 2019 10:46:32 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id v138sm58171800pfc.15.2019.07.25.10.46.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jul 2019 10:46:31 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH 17/19] merge-recursive: rename MERGE_RECURSIVE_* to MERGE_VARIANT_*
Date:   Thu, 25 Jul 2019 10:46:09 -0700
Message-Id: <20190725174611.14802-18-newren@gmail.com>
X-Mailer: git-send-email 2.22.0.559.g28a8880890.dirty
In-Reply-To: <20190725174611.14802-1-newren@gmail.com>
References: <20190725174611.14802-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I want to implement the same outward facing API as found within
merge-recursive.h in a different merge strategy.  However, that makes
names like MERGE_RECURSIVE_{NORMAL,OURS,THEIRS} look a little funny;
rename to MERGE_VARIANT_{NORMAL,OURS,THEIRS}.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 14 +++++++-------
 merge-recursive.h |  6 +++---
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 32889a2f0d..0f689095d9 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1046,10 +1046,10 @@ static int merge_3way(struct merge_options *opt,
 		ll_opts.variant = 0;
 	} else {
 		switch (opt->recursive_variant) {
-		case MERGE_RECURSIVE_OURS:
+		case MERGE_VARIANT_OURS:
 			ll_opts.variant = XDL_MERGE_FAVOR_OURS;
 			break;
-		case MERGE_RECURSIVE_THEIRS:
+		case MERGE_VARIANT_THEIRS:
 			ll_opts.variant = XDL_MERGE_FAVOR_THEIRS;
 			break;
 		default:
@@ -1359,15 +1359,15 @@ static int merge_mode_and_contents(struct merge_options *opt,
 							&b->oid);
 		} else if (S_ISLNK(a->mode)) {
 			switch (opt->recursive_variant) {
-			case MERGE_RECURSIVE_NORMAL:
+			case MERGE_VARIANT_NORMAL:
 				oidcpy(&result->blob.oid, &a->oid);
 				if (!oid_eq(&a->oid, &b->oid))
 					result->clean = 0;
 				break;
-			case MERGE_RECURSIVE_OURS:
+			case MERGE_VARIANT_OURS:
 				oidcpy(&result->blob.oid, &a->oid);
 				break;
-			case MERGE_RECURSIVE_THEIRS:
+			case MERGE_VARIANT_THEIRS:
 				oidcpy(&result->blob.oid, &b->oid);
 				break;
 			}
@@ -3779,9 +3779,9 @@ int parse_merge_opt(struct merge_options *opt, const char *s)
 	if (!s || !*s)
 		return -1;
 	if (!strcmp(s, "ours"))
-		opt->recursive_variant = MERGE_RECURSIVE_OURS;
+		opt->recursive_variant = MERGE_VARIANT_OURS;
 	else if (!strcmp(s, "theirs"))
-		opt->recursive_variant = MERGE_RECURSIVE_THEIRS;
+		opt->recursive_variant = MERGE_VARIANT_THEIRS;
 	else if (!strcmp(s, "subtree"))
 		opt->subtree_shift = "";
 	else if (skip_prefix(s, "subtree=", &arg))
diff --git a/merge-recursive.h b/merge-recursive.h
index a1bb29dc33..c4e6fb85f1 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -28,9 +28,9 @@ struct merge_options {
 	/* xdiff-related options (patience, ignore whitespace, ours/theirs) */
 	long xdl_opts;
 	enum {
-		MERGE_RECURSIVE_NORMAL = 0,
-		MERGE_RECURSIVE_OURS,
-		MERGE_RECURSIVE_THEIRS
+		MERGE_VARIANT_NORMAL = 0,
+		MERGE_VARIANT_OURS,
+		MERGE_VARIANT_THEIRS
 	} recursive_variant;
 
 	/* console output related options */
-- 
2.22.0.559.g28a8880890.dirty

