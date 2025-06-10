Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784102951CA
	for <git@vger.kernel.org>; Tue, 10 Jun 2025 13:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749560583; cv=none; b=nUn/uoRUgVj/dhMmXFiIHw5vA/O++aZ++OdOpAb0Q9yhOMwTujuACQ+mMMBf+AGphUu4z6LA2Lsa8YJ+5roZ+1UEcQYAlV9DBF/feJs6eoNvwZerAQqZn59Tl6rinTfJleUBvd5Xt6NXh4Mr7SJ1w9rfu4XRZbVxO7OZtazu6TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749560583; c=relaxed/simple;
	bh=zDRFUskW98K3diVNSLW3bcF1Oh5FaKcLWKQG+i1csvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OlzvyshQwxY0aATmMvsLZjydFeq1s7/h+fApfsMI3S8OOHITOKjg38ew9a58Yz3R6CcnLyvB7R4NHr1nB7zH6+vYuEXJjoCvuz/cBsmFHciC267oUmrbt163VZlL+IcvEREQVY67TzixOPNdfXK/VvE/MzJtzPiKB8IOgcQ3PWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=acUUdNPH; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acUUdNPH"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-236377f00a1so7255355ad.3
        for <git@vger.kernel.org>; Tue, 10 Jun 2025 06:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749560581; x=1750165381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aap63RBQGuUJ6AqO5NxvieDmHf64uEZbErJRRzvA0NE=;
        b=acUUdNPHNn/TB6q9kyplaV6MKjxKiVw3nznUqvo/rvSvPaJFhiRMeqXftcdvjmnL21
         v1SVNeok/QCnjXz7UILwgD8Co4ChQDj7hiPxopWx1XEC0NoQ7dRniQ5f0sOcc9N1rr3X
         xMutVI643aZGM+GhXY3kE+lMwkKnCZoob+sBof1qtc0X952RpGt4d+SeAuaC4T21X9Hp
         jGM5wSzwqy4wx/kGe/65wRz3FDlsFIUEyohvq5GAJhtOp+oOZhQSlQVyRf9Y9Fpuy4CR
         fbMLl6qydW91tjh7AKH0iXU+uqHty5pJIRNJ+/o9dYc7PiBDMX/opGrDcz+YIfnSklj4
         O05A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749560581; x=1750165381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aap63RBQGuUJ6AqO5NxvieDmHf64uEZbErJRRzvA0NE=;
        b=pgBNmUXnKQ0QaOMUUP+BVyMui7hZ8Atk31FAFcY4ElRVEMR8JCuHgCl3UHtr4NwVGP
         UthAbDUpoo14NIDDR5Dck5r3FBBboaOmNqxPa4QhsbKR7DG1puKhZ+zV8fjcWiG/htyS
         6GdGQS+2Ip1Scm3ITJN89Y5YJeqeiqmhHHDy7pzHxoNhi0Xn5GCjZdWlvomxd67WCzb5
         u+Q+7RMhRPIKe5CLe++JxNHJzfor03+JDT5pGj3ogVhI6r9gw2mgriVFvI83t6U1GY8w
         FWvVNWP27TvEAzQuHX7GUQJiUxtpPk1Emoe2dielBfqarQkcy0OqYx8OT3co9JvklE/N
         qLxw==
X-Gm-Message-State: AOJu0YwmT3RBI2wU+Y4Kc61cMT2IS1upR+v+IuxunakuPp1L02Z4Ed4B
	DH22zULi0FyqPSM+/CHsJTmZzqYoa4WV5nwSXoqCGz1gCxNFHDsR4lDDKHYGQQ==
X-Gm-Gg: ASbGncsNzBXcrIuxPAlv+SVAHLDZaz8sqh8ddvKRaB5QYs8aFP4hGwn5fpaH9cPLIN9
	QNPzcIFuRnb31y4C2Rcp/wsPKvye7YGDeNQuDNKcnkL9giZi4u4O3IvVB6EoXr5ehCGwcqie2F8
	SUlyBtfMsxAIc9ApvO12JKWzeukcj8hTcskZ2jK6T4RhDmElUcRYgUizqDU69qZs4K8araIqZGE
	dV4ztlDCvOtVF4MVAZUmP+bjRKAhShJoMgDVFUJ0W6SXl2ZAVagyxpZ3vaLkJHRRhh5u+m40Ff7
	wFWpXT8omvVgQQvdNZgIKq9kjgFPDYY3tv0YYhHE7Di10jD39wjZYYmgnuHfasExA85lr3UlJOW
	eodc=
X-Google-Smtp-Source: AGHT+IF9MYNFCBizPcNLUKnZUIvDjQCtP03LX7ZZXK6BzCRr/w9z9qB22qDBxC5p0V8ygtQ6SMeHpA==
X-Received: by 2002:a17:903:244f:b0:234:d7b2:2aa9 with SMTP id d9443c01a7336-236383676a1mr37288985ad.29.1749560580055;
        Tue, 10 Jun 2025 06:03:00 -0700 (PDT)
Received: from thinku.domain.name ([2401:4900:1c17:909b:153b:8cf8:294b:5a5a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603506d58sm70338175ad.227.2025.06.10.06.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 06:02:59 -0700 (PDT)
From: Ayush Chandekar <ayu.chandekar@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	shyamthakkar001@gmail.com,
	Ayush Chandekar <ayu.chandekar@gmail.com>
Subject: [GSOC PATCH 1/2] environment: remove the global variable 'core_preload_index'
Date: Tue, 10 Jun 2025 18:32:20 +0530
Message-ID: <1dda6c9ab616bcdf5632c0c1359b489844f7933f.1749557133.git.ayu.chandekar@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749557133.git.ayu.chandekar@gmail.com>
References: <cover.1749557133.git.ayu.chandekar@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The global variable 'core_preload_index' is used in a single function
named 'preload_index()' in "preload-index.c". Move its declaration inside
that function, removing unnecessary global state.

This change is part of an ongoing effort to eliminate global variables,
improve modularity and help libify the codebase.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Signed-off-by: Ayush Chandekar <ayu.chandekar@gmail.com>
---
 config.c        | 5 -----
 environment.c   | 3 ---
 environment.h   | 1 -
 preload-index.c | 4 ++++
 4 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/config.c b/config.c
index b18b5617fc..eb60c293ab 100644
--- a/config.c
+++ b/config.c
@@ -1595,11 +1595,6 @@ static int git_default_core_config(const char *var, const char *value,
 		return 0;
 	}
 
-	if (!strcmp(var, "core.preloadindex")) {
-		core_preload_index = git_config_bool(var, value);
-		return 0;
-	}
-
 	if (!strcmp(var, "core.createobject")) {
 		if (!value)
 			return config_error_nonbool(var);
diff --git a/environment.c b/environment.c
index c61d773e7e..7bf0390a33 100644
--- a/environment.c
+++ b/environment.c
@@ -113,9 +113,6 @@ const char *comment_line_str = "#";
 char *comment_line_str_to_free;
 int auto_comment_line_char;
 
-/* Parallel index stat data preload? */
-int core_preload_index = 1;
-
 /* This is set by setup_git_directory_gently() and/or git_default_config() */
 char *git_work_tree_cfg;
 
diff --git a/environment.h b/environment.h
index 3d98461a06..9a3d05d414 100644
--- a/environment.h
+++ b/environment.h
@@ -155,7 +155,6 @@ extern int pack_compression_level;
 extern unsigned long pack_size_limit_cfg;
 extern int max_allowed_tree_depth;
 
-extern int core_preload_index;
 extern int precomposed_unicode;
 extern int protect_hfs;
 extern int protect_ntfs;
diff --git a/preload-index.c b/preload-index.c
index 40ab2abafb..9fee4cc3aa 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -19,6 +19,7 @@
 #include "repository.h"
 #include "symlinks.h"
 #include "trace2.h"
+#include "config.h"
 
 /*
  * Mostly randomly chosen maximum thread counts: we
@@ -111,6 +112,9 @@ void preload_index(struct index_state *index,
 	struct thread_data data[MAX_PARALLEL];
 	struct progress_data pd;
 	int t2_sum_lstat = 0;
+	int core_preload_index = 1;
+
+	repo_config_get_bool(the_repository, "core.preloadindex", &core_preload_index);
 
 	if (!HAVE_THREADS || !core_preload_index)
 		return;
-- 
2.49.0

