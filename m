Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B802748C
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 12:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cytct41X"
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989AB123
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 05:26:39 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9936b3d0286so668160666b.0
        for <git@vger.kernel.org>; Tue, 24 Oct 2023 05:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698150398; x=1698755198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jTrEXOeFol6AmaA9KXR+u1DxcdpMVWbMe6+zVa2nt9I=;
        b=Cytct41X5C9yYUmxrYOxaaJSMEeNiMZ3XYcNifjRqJWm7W0XZH68QDOxDBjd7HVMx6
         Y5if2I+yhn4spMTWw6v3KELKfM75hkXOBkG5jlgn32NIvOHnYVGd0w0slmTNswVW4hlj
         HXZiM3kJ2c8GWG7ei+aR7PjLq4XB+Q7I1AcSrPO++nVrlOX2iKn7wOadCExXc48vneo/
         aQRzx45ADusTrasr8pnL8RCUCdAsY7K6m435C1XumgN22eIVL6cYx4+4ho7DHsmuxsaN
         PnnaY68TnBIusPtAH1ysidD6LWUg4fcBJmHijvdMY1QIsw4uko9gXOi4OHECk8+VlenE
         EhsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698150398; x=1698755198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jTrEXOeFol6AmaA9KXR+u1DxcdpMVWbMe6+zVa2nt9I=;
        b=AXJZ28cTLRRnGFIY5osjZJIX7gp6uGKLWUjNmEJZIab4MbR6yHpZWlzemdwwY9WOR9
         ehO7XTtuMuoDGSHpIJstlfpPtVxp9eeqzX6TMrAsHkVfP9lobMDcUB0+JOLLww3CLtxm
         Dcc35xHkkH8i71G+fOtmoF9G0r5IzXgBTPw7bG9E/ulgcOSQ1kgWRJA1rba/OgCRt0QC
         CoG9MAVenavdd2R1Egbi7B7v5lIztRSZW0+M4R/bY62uDYs3FFB3QnEOOPqII2Ow4abU
         q3y22e/Z0aZ1z/6h0u+14rU4+dFYcMB93w+f+3Hfyu0djYNXVBrFjfOJlw78Fls5THAE
         /V5Q==
X-Gm-Message-State: AOJu0Yybs9rPCrey1464J0Rg8NLwsyA1gtp1y4bitu5pNFxj6DJHEm+k
	voR10MRNSy6GFbj4KaMt/piy7pLkO5W/pA==
X-Google-Smtp-Source: AGHT+IFC4X9vFJ4MaXL2v8S80JLzHopjxB0Lk12BhiQ8cfKNYoEOQt/nml28IJ0EyKpROYt/EdfyIw==
X-Received: by 2002:a17:907:c0d:b0:9be:8693:66bb with SMTP id ga13-20020a1709070c0d00b009be869366bbmr9089151ejc.59.1698150397657;
        Tue, 24 Oct 2023 05:26:37 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2454:56d:f00:be13:9408:ebb5:e370])
        by smtp.gmail.com with ESMTPSA id jl24-20020a17090775d800b0099315454e76sm8102726ejc.211.2023.10.24.05.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 05:26:37 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v4 1/3] revision: rename bit to `do_not_die_on_missing_objects`
Date: Tue, 24 Oct 2023 14:26:29 +0200
Message-ID: <20231024122631.158415-2-karthik.188@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231024122631.158415-1-karthik.188@gmail.com>
References: <20231019121024.194317-1-karthik.188@gmail.com>
 <20231024122631.158415-1-karthik.188@gmail.com>
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

