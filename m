Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA12380A
	for <git@vger.kernel.org>; Sun, 22 Oct 2023 02:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mcclimon.org header.i=@mcclimon.org header.b="KI1gv46d"
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942CCC2
	for <git@vger.kernel.org>; Sat, 21 Oct 2023 19:28:14 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id 6a1803df08f44-66cfef11a25so12028946d6.3
        for <git@vger.kernel.org>; Sat, 21 Oct 2023 19:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mcclimon.org; s=gw; t=1697941693; x=1698546493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4oZKot/+W1qWeS7lTaIzLgEwIQH/09EIdvW2mEE2xL4=;
        b=KI1gv46d/c8RwUKWJO4YZVKFI55ulF5pixI4vqUWmO26c9wOiRWV2K9ZAseljAlsmw
         Qpzr7wXAvyG2u5/SyOl2J1TFedXzGzWBxVJJxMFm7t/bsgXoCtq2mlxCl/BJUTAEWYRY
         lP+V9I+VtlYFjr1fSXS9BehZHUGdR88SyRqV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697941693; x=1698546493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4oZKot/+W1qWeS7lTaIzLgEwIQH/09EIdvW2mEE2xL4=;
        b=HdDVj+vcFaS4kFQ0NshBWwSa1rXnz4RbG2Wp6iUDhOd1e+kJTw/opCXJF9Xx3uubaU
         uGf0h2Tg93hyrXH+6TTZrso58YQdsH84l2VDPHliau9E0IC5GxLWwDO5kngXl4qRfkmS
         qhjZa1rYC0Zxmot1JsVxiLtfzaDrdD3Q3SS7IXP1Rcf1CDYAsgMJGSvPjEXvl5mT7M1Z
         f0VWuGVjOSNFEeVRR7GBkCXW6bME6Gnv+ewLigpo4UsllU9thaYm4+op2DgmBwHrMBzo
         8WIaYUnHeNf8IXSxtm7qKZRMaRev+UawnMWOTyq3BvAhC+Y2Fwv5rYkKtlHK8wpHCjGV
         rD7g==
X-Gm-Message-State: AOJu0Yz5qTmUelnUbC9aQfiYK/9zTCLq62DzdSdEWUmJZQU7y/vgpZhC
	ETXbNtP+LVkJGzJtWNgXeQfrVy88KoQEVrnctzL5FyTu
X-Google-Smtp-Source: AGHT+IHh4cWPDgCnQfQsY5caEO5BHAiHbvS9EMGAjIOE0fODvJEjyg4eYNCXf/n8lFirmmanssTp1A==
X-Received: by 2002:a05:6214:2465:b0:66d:5ee5:815b with SMTP id im5-20020a056214246500b0066d5ee5815bmr5462044qvb.64.1697941693706;
        Sat, 21 Oct 2023 19:28:13 -0700 (PDT)
Received: from localhost ([2600:4040:7ee9:4100:1908:ac84:cbae:dea2])
        by smtp.gmail.com with ESMTPSA id d12-20020a056214184c00b0065d03eae7a0sm1866659qvy.82.2023.10.21.19.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 19:28:13 -0700 (PDT)
From: Michael McClimon <michael@mcclimon.org>
To: git@vger.kernel.org
Cc: Michael McClimon <michael@mcclimon.org>
Subject: [RFC PATCH 1/2] patch-ids: add const modifier to commit
Date: Sat, 21 Oct 2023 22:27:59 -0400
Message-ID: <20231022022800.69219-2-michael@mcclimon.org>
X-Mailer: git-send-email 2.42.0.424.gceadf0f3
In-Reply-To: <20231022022800.69219-1-michael@mcclimon.org>
References: <20231022022800.69219-1-michael@mcclimon.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These aren't modified by these functions, and I want to use them
somewhere where the commit is in fact a const.

Signed-off-by: Michael McClimon <michael@mcclimon.org>
---
 patch-ids.c | 4 ++--
 patch-ids.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/patch-ids.c b/patch-ids.c
index c3e1a0dd..ecfd7ba0 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -6,13 +6,13 @@
 #include "hex.h"
 #include "patch-ids.h"
 
-static int patch_id_defined(struct commit *commit)
+static int patch_id_defined(const struct commit *commit)
 {
 	/* must be 0 or 1 parents */
 	return !commit->parents || !commit->parents->next;
 }
 
-int commit_patch_id(struct commit *commit, struct diff_options *options,
+int commit_patch_id(const struct commit *commit, struct diff_options *options,
 		    struct object_id *oid, int diff_header_only)
 {
 	if (!patch_id_defined(commit))
diff --git a/patch-ids.h b/patch-ids.h
index 490d7393..3f61d88a 100644
--- a/patch-ids.h
+++ b/patch-ids.h
@@ -19,7 +19,7 @@ struct patch_ids {
 	struct diff_options diffopts;
 };
 
-int commit_patch_id(struct commit *commit, struct diff_options *options,
+int commit_patch_id(const struct commit *commit, struct diff_options *options,
 		    struct object_id *oid, int);
 int init_patch_ids(struct repository *, struct patch_ids *);
 int free_patch_ids(struct patch_ids *);
-- 
2.42.0.424.gceadf0f3

