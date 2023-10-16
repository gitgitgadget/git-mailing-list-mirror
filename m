Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A4820B21
	for <git@vger.kernel.org>; Mon, 16 Oct 2023 10:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwS2IrOk"
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14E0C5
	for <git@vger.kernel.org>; Mon, 16 Oct 2023 03:38:43 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-53e751aeb3cso3011599a12.2
        for <git@vger.kernel.org>; Mon, 16 Oct 2023 03:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697452722; x=1698057522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1FiY2+5KerkCg3TRlt8yED0XiGRko5TMen1uOL/Q64Y=;
        b=hwS2IrOkuS/5fge0ZVmMrILvewHJBpfaIYjQiRqNLUJi6QiImCkTH5ewVbM6XwFG6Z
         DgDt2pvvhkhqs1ItKkOkOZrO8F5p7DsV8FDBPAEMlyyYqQOoI7L4KI/x2F7Rjk7wkq1y
         Q+wirYt/ILKgDvp0I9cSccfn5HsV91YZq32kX/zDFny6R7OYS1S48v5BaehsTQDvSuba
         42jjmMNFWlOLs+YYrtHfhD6/VY5IwURci1DSztTJDfwHXFjfvRtee+DLIRvH2f1/b98g
         WugRxE0j/s+mL/qHCB66Eb5wO1vc6jyM9vgh6qK+JAcG6kQzZtpaKfiiW49Hge/4X/K/
         givA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697452722; x=1698057522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1FiY2+5KerkCg3TRlt8yED0XiGRko5TMen1uOL/Q64Y=;
        b=afuHB6rK3/baD/2ZB0m+l+0wUp1McBvzShqXM4K8kYtmQkZ8XrLQntPF0lX+msOBtT
         NSaUtJ2NF2ZBLHfj0HpPhNI4XA1xIsTa/M7zGLDdWmOCnBJf8lmzLyh63JTyMNd1u3Bv
         GT4sGgbLt8YNrurPDyEaUN/UlwUZbtEKc924xC65x/I8h9XswpCIrj9fKWCbJNUgq3n7
         VjKFYPQBmXDlqu5O6VjoqINdRmRF7cvqauVFHGIcbczD6whbGRZhne+y6PpM5K1S9Zok
         7N8vRNgrifBI4xNqjBLHuK0yAbNBJkGa4sC7q4lbMPefDX+DgyjiKkbvSDMrjzgyT9n2
         LJ5w==
X-Gm-Message-State: AOJu0YzG+9mdnWLJITHjpsZjVldMQ9kcqMMtClQth4hG+onZC5hT3Ghz
	EJN4LDnq5ONVOvYZRK7rbp8=
X-Google-Smtp-Source: AGHT+IG0sMgUT5bz3LT5BPeb09e7yZ/g/dEyr9M1UcxQfElRbXPV++/9aIXeEJqwPB1u0v1qIk8OmA==
X-Received: by 2002:a17:906:dc89:b0:9bf:d70:fc6b with SMTP id cs9-20020a170906dc8900b009bf0d70fc6bmr5271500ejc.71.1697452721669;
        Mon, 16 Oct 2023 03:38:41 -0700 (PDT)
Received: from worklaptop.fritz.box ([2a02:2454:56d:f00:b15b:356c:2a07:7b52])
        by smtp.gmail.com with ESMTPSA id jx17-20020a170907761100b009ad875d12d7sm3784390ejc.210.2023.10.16.03.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 03:38:41 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v2 1/3] revision: rename bit to `do_not_die_on_missing_objects`
Date: Mon, 16 Oct 2023 12:38:28 +0200
Message-ID: <20231016103830.56486-2-karthik.188@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231016103830.56486-1-karthik.188@gmail.com>
References: <20231009105528.17777-1-karthik.188@gmail.com>
 <20231016103830.56486-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
2.41.0

