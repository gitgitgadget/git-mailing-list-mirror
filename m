Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE3D1A281
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 10:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQ29L125"
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA56195
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 03:11:17 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99de884ad25so110367266b.3
        for <git@vger.kernel.org>; Thu, 26 Oct 2023 03:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698315076; x=1698919876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jTrEXOeFol6AmaA9KXR+u1DxcdpMVWbMe6+zVa2nt9I=;
        b=QQ29L125ErNefwMR1I9mQ8aQh8p2iXp5S3kbqOPexdcMKyoF8FYvdJZvSrrNG1QGxp
         DRQe1lRhoQPtUK7itx6bESXdcZk8sQlZWAqSjj+5liUwM8VyXlgw/SlE1Vsasqe9cfiR
         00NCyW8T1msaB/NFJYTpFX1h2CetLh/cfm4hjUk+ql5Tz1Ip23rTYeD3IpVF8vLxNIBJ
         pA48jb0PAZYrVZ1rwURfc+dl+IzNrTqCqIH0gNyufbuT+VGija82d6tuB88v/BR5Lj0x
         NITdNY9SV3Xf4hnr2ct2RRFj0oElsLJm8JYIUqkXruZ/pO7gQmYbotpJHJ8YY0FqlAnr
         dXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698315076; x=1698919876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jTrEXOeFol6AmaA9KXR+u1DxcdpMVWbMe6+zVa2nt9I=;
        b=JxREO/Jd5JCepJDZo1F16BESOFmng1k9zQuAl/nKZp25k1jzyTZXlQD93han0FuU1v
         4xFLL1wlHkDTZUzFC+Pz2N5JhZXu2yll0kpzP520Jqrg2cg/WccpvOW4li6Ot0SJrlWV
         oady1cEzosvz01IP75y0R6yT8pRDUkOlp6PkRBlwuqn8rFI24rTMrJMJivT7xV7ug1zd
         rx9z7P/afKhvJndPi/DMkc/SMjmgZAr9JP2V8ozG88MGDoDJjO+06a/XvkX37XPYEp0o
         5Q3CoVsfzTDE4iq9Ypayn6m38q3PRYydjOJNXbdtG8VrT+8xlxsZ8Ib1nCWeLG/qFkh2
         XshA==
X-Gm-Message-State: AOJu0YxuiNODTRoGvsJc3BYuI7NMvgULOaLr0xUQMnmghKwhdSlibsHB
	tDcbGKR+Uh6iYn+WMAm5+e4=
X-Google-Smtp-Source: AGHT+IFT7cPhRTjua1SN8KBy2GXjJJh5QFk/suEZ1SoGcuEwgC1ADCScx7zivPWDyjLrD1qyjdS5sw==
X-Received: by 2002:a17:906:6a21:b0:9c5:2806:72e9 with SMTP id qw33-20020a1709066a2100b009c5280672e9mr14003681ejc.34.1698315075873;
        Thu, 26 Oct 2023 03:11:15 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2454:56d:f00:561:c52d:5ce2:b147])
        by smtp.gmail.com with ESMTPSA id k15-20020a1709065fcf00b00997d7aa59fasm11635390ejv.14.2023.10.26.03.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 03:11:15 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v5 1/3] revision: rename bit to `do_not_die_on_missing_objects`
Date: Thu, 26 Oct 2023 12:11:07 +0200
Message-ID: <20231026101109.43110-2-karthik.188@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231026101109.43110-1-karthik.188@gmail.com>
References: <20231024122631.158415-1-karthik.188@gmail.com>
 <20231026101109.43110-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bit `do_not_die_on_missing_tree` is used in revision.h to ensure the
revision walker does not die when encountering a missing tree. This is
currently exclusively set within `builtin/rev-list.c` to ensure the
`--missing` option works with missing trees.

In the upcoming commits, we will extend `--missing` to also support
missing commits. So let's rename the bit to
`do_not_die_on_missing_objects`, which is object type agnostic and can
be used for both trees/commits.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/reflog.c   |  2 +-
 builtin/rev-list.c |  2 +-
 list-objects.c     |  2 +-
 revision.h         | 17 +++++++++--------
 4 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index df63a5892e..9e369a5977 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -298,7 +298,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 		struct rev_info revs;
 
 		repo_init_revisions(the_repository, &revs, prefix);
-		revs.do_not_die_on_missing_tree = 1;
+		revs.do_not_die_on_missing_objects = 1;
 		revs.ignore_missing = 1;
 		revs.ignore_missing_links = 1;
 		if (verbose)
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index ff715d6918..ea77489c38 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -561,7 +561,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	}
 
 	if (arg_missing_action)
-		revs.do_not_die_on_missing_tree = 1;
+		revs.do_not_die_on_missing_objects = 1;
 
 	argc = setup_revisions(argc, argv, &revs, &s_r_opt);
 
diff --git a/list-objects.c b/list-objects.c
index c25c72b32c..47296dff2f 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -177,7 +177,7 @@ static void process_tree(struct traversal_context *ctx,
 		    is_promisor_object(&obj->oid))
 			return;
 
-		if (!revs->do_not_die_on_missing_tree)
+		if (!revs->do_not_die_on_missing_objects)
 			die("bad tree object %s", oid_to_hex(&obj->oid));
 	}
 
diff --git a/revision.h b/revision.h
index 50091bbd13..c73c92ef40 100644
--- a/revision.h
+++ b/revision.h
@@ -212,18 +212,19 @@ struct rev_info {
 
 			/*
 			 * Blobs are shown without regard for their existence.
-			 * But not so for trees: unless exclude_promisor_objects
+			 * But not so for trees/commits: unless exclude_promisor_objects
 			 * is set and the tree in question is a promisor object;
 			 * OR ignore_missing_links is set, the revision walker
-			 * dies with a "bad tree object HASH" message when
-			 * encountering a missing tree. For callers that can
-			 * handle missing trees and want them to be filterable
+			 * dies with a "bad <type> object HASH" message when
+			 * encountering a missing object. For callers that can
+			 * handle missing trees/commits and want them to be filterable
 			 * and showable, set this to true. The revision walker
-			 * will filter and show such a missing tree as usual,
-			 * but will not attempt to recurse into this tree
-			 * object.
+			 * will filter and show such a missing object as usual,
+			 * but will not attempt to recurse into this tree/commit
+			 * object. The revision walker will also set the MISSING
+			 * flag for such objects.
 			 */
-			do_not_die_on_missing_tree:1,
+			do_not_die_on_missing_objects:1,
 
 			/* for internal use only */
 			exclude_promisor_objects:1;
-- 
2.42.0

