Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA1528B7F8
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 16:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751301697; cv=none; b=gzKBAuHmO5hiL6v3WNH0z9wjX7QcL+dIZ5ekZCJwl5ZHjNhgweVr9ouXSZwWAOx2+q8yDzn8is88ryPdM7q7HnQ0/KhtFbebX7rMQmmlrp36lJnbvsUzai3Z3WFerKCOqltQy+C5hAn4o11kRgnOW8lBcehocFpUxKDYWe7dCgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751301697; c=relaxed/simple;
	bh=UQex3QORacj7W1G6HV+8RZfk+im9knayp7jL+QxYzQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vA4C+D+1YWQ+3It9kGjGi3VJDderf7UZXRNEYSFC4YJAFCpk1prxrME1yPiLT8DrYkkpRvVmaxRLwDM5QBZmnByJHawa22al0UG21jAXF7r7xbjygnABqHS/p24Vf3/Uosr+qLBD5GdqXxflLUq6QuzKRR1+gGHD7TzM3E79LW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QfY7ggmP; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfY7ggmP"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2366e5e4dbaso47566745ad.1
        for <git@vger.kernel.org>; Mon, 30 Jun 2025 09:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751301695; x=1751906495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=edcPGbpab58Yt1d7JOpf51Vebx8AZO6Uz6T/5+Otjf0=;
        b=QfY7ggmPTN1OCooMUZFv/EByaiTjrlg432p/3I6EG83EQPxno8ybnWmokQFiQP/hct
         VAeiG6RxCs3do0UzXK7r/++P6Gv2hpWCPjm2dtJNb/l4K1l7WDJJWYl4cLPj95yAGV0G
         09/IICnwrEz6CIGsg8bpamgl2/hYyG4veGmG+GNn6wnIkxoYK0R8cALZfE/9DunvfBds
         xYaJipoEDlcxAfxu057jACH6kuJERCiUKySUlwZmQszzfeUVxXnYZnbDaxicBb9t83L5
         CzoCS3ETqjYLMxReIBWL8+H+RX4qwBUzhpuBu0SV7tbWk0fpgRcR5oKqLpYl4WKxqT+e
         LB1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751301695; x=1751906495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=edcPGbpab58Yt1d7JOpf51Vebx8AZO6Uz6T/5+Otjf0=;
        b=FgSZtZGSkpFbwkwUX2dTL9CZy7x5FNbgSCIJj5t/1wq2CXBNT4sAx7/lbFrWH5D0Ll
         0KR41g5srDNSLUkJ3/4wzIEUuqSQlVs+pnu36KEYWrCpl9Ou7mzT7ZIl8oDfowAg2i/h
         NMf4NjOj+rlBbDdzu9S8Z5t9R7M1VQfQT+hQK6v+Qy8PLQBh7ELKIGANHslc8v9vYG3B
         p4GOyUOqezLJ5El9/0/XdgZY1AU/R38wPWFgyCg4jc05IWer8yA57BYOfi+qpjy2QUrw
         rCYQgeNNVNelQlm4M8D8jUKaZDVJhEMmFoH8+qldjF4jFBWXwF0DoiyH4lFMt88vcXy3
         0vvg==
X-Forwarded-Encrypted: i=1; AJvYcCXlmcIEYEy1wqSjQTQppX9sbPLB1OOS3Tcf0OJ7T7SqPb33+x1/e4QhdQ8fYe/tAUbpjtE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIK3wCZ6OE99hbrkgjWmHmkjzw4BezLuZpjU0ZuL9OI3OtVq21
	7w73qMfE3t5bKYVZAyPo5/muTulT+L3JMR0veWas6TrS63zdVXwKEAdGnL+NkJDN
X-Gm-Gg: ASbGncvl/zkn3fCpfWCrVzKFLoRJ2cVu6Zge205mDosRMPt60PLhaSWdedKuQo51hRl
	lGdN1V11rGK3yYFfqGgj/QHKK/Rm16j6VlAvToBg5uwZT/v/vEg+ZjLa74BLgiaA1RlLVU8mc+J
	TkXg9clJKLE9/rftJOC6JgwAeQGiK3vFsDikpxfOv4V5XPA3X3iPDzUln3y6t27VJZBTrgmJ3PY
	GEXpJG0lXAL6eBJDybS5Hquj7KDjUhJSdO228QcQKsIQpGrT//hJfnBWyg2C1fFHpfkJho1AG5f
	qTdpS9UTfAH+WYiRFWcr0AO9ueGg1dsU4frNqFBbinD+405Y7GgQs0MHmp4VHGD0HFLbrDG+wiD
	y5Mq48Wow1uOWz+w=
X-Google-Smtp-Source: AGHT+IHfpowN9itxKNgUF6CMkMBe/r8Y2YC+4IK/+PsHFQOI3ZDwNwIGXtNDEKe7mIIhRAA9oqyJ3w==
X-Received: by 2002:a17:903:18c:b0:231:fd73:f8e5 with SMTP id d9443c01a7336-23b3552afddmr2979745ad.24.1751301694613;
        Mon, 30 Jun 2025 09:41:34 -0700 (PDT)
Received: from thinku.localdomain ([2401:4900:1c20:3d25:645c:9adb:1b15:c2cc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb39f34dsm84841385ad.130.2025.06.30.09.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 09:41:34 -0700 (PDT)
From: Ayush Chandekar <ayu.chandekar@gmail.com>
To: ayu.chandekar@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	shyamthakkar001@gmail.com,
	shejialuo@gmail.com
Subject: [GSOC PATCH v2 2/2] builtin/prune: stop depending on 'the_repository'
Date: Mon, 30 Jun 2025 22:11:05 +0530
Message-ID: <f70de9d549f2cb744810df7a9ee09e0b3626e62a.1751296633.git.ayu.chandekar@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1751296633.git.ayu.chandekar@gmail.com>
References: <cover.1751296633.git.ayu.chandekar@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor builtin/prune.c to remove the dependency on the global
'the_repository'. Replace all the occurrences of 'the_repository' with
repo and thus remove the definition '#define
USE_THE_REPOSITORY_VARIABLE'

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Signed-off-by: Ayush Chandekar <ayu.chandekar@gmail.com>
---
 builtin/prune.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/builtin/prune.c b/builtin/prune.c
index dab3c19b6f..499d2432d1 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
@@ -64,7 +63,7 @@ static void perform_reachability_traversal(struct rev_info *revs)
 		return;
 
 	if (show_progress)
-		progress = start_delayed_progress(the_repository,
+		progress = start_delayed_progress(revs->repo,
 						  _("Checking connectivity"), 0);
 	mark_reachable_objects(revs, 1, expire, progress);
 	stop_progress(&progress);
@@ -78,7 +77,7 @@ static int is_object_reachable(const struct object_id *oid,
 
 	perform_reachability_traversal(revs);
 
-	obj = lookup_object(the_repository, oid);
+	obj = lookup_object(revs->repo, oid);
 	return obj && (obj->flags & SEEN);
 }
 
@@ -99,8 +98,7 @@ static int prune_object(const struct object_id *oid, const char *fullpath,
 	if (st.st_mtime > expire)
 		return 0;
 	if (show_only || verbose) {
-		enum object_type type = oid_object_info(the_repository, oid,
-							NULL);
+		enum object_type type = oid_object_info(revs->repo, oid, NULL);
 		printf("%s %s\n", oid_to_hex(oid),
 		       (type > 0) ? type_name(type) : "unknown");
 	}
@@ -154,7 +152,7 @@ static void remove_temporary_files(const char *path)
 int cmd_prune(int argc,
 	      const char **argv,
 	      const char *prefix,
-	      struct repository *repo UNUSED)
+	      struct repository *repo)
 {
 	struct rev_info revs;
 	int exclude_promisor_objects = 0;
@@ -173,20 +171,19 @@ int cmd_prune(int argc,
 	expire = TIME_MAX;
 	save_commit_buffer = 0;
 	disable_replace_refs();
-	repo_init_revisions(the_repository, &revs, prefix);
+	repo_init_revisions(repo, &revs, prefix);
 
 	argc = parse_options(argc, argv, prefix, options, prune_usage, 0);
 
-	if (the_repository->repository_format_precious_objects)
+	if (repo->repository_format_precious_objects)
 		die(_("cannot prune in a precious-objects repo"));
 
 	while (argc--) {
 		struct object_id oid;
 		const char *name = *argv++;
 
-		if (!repo_get_oid(the_repository, name, &oid)) {
-			struct object *object = parse_object_or_die(the_repository, &oid,
-								    name);
+		if (!repo_get_oid(repo, name, &oid)) {
+			struct object *object = parse_object_or_die(repo, &oid, name);
 			add_pending_object(&revs, object, "");
 		}
 		else
@@ -200,16 +197,16 @@ int cmd_prune(int argc,
 		revs.exclude_promisor_objects = 1;
 	}
 
-	for_each_loose_file_in_objdir(repo_get_object_directory(the_repository),
+	for_each_loose_file_in_objdir(repo_get_object_directory(repo),
 				      prune_object, prune_cruft, prune_subdir, &revs);
 
 	prune_packed_objects(show_only ? PRUNE_PACKED_DRY_RUN : 0);
-	remove_temporary_files(repo_get_object_directory(the_repository));
-	s = mkpathdup("%s/pack", repo_get_object_directory(the_repository));
+	remove_temporary_files(repo_get_object_directory(repo));
+	s = mkpathdup("%s/pack", repo_get_object_directory(repo));
 	remove_temporary_files(s);
 	free(s);
 
-	if (is_repository_shallow(the_repository)) {
+	if (is_repository_shallow(repo)) {
 		perform_reachability_traversal(&revs);
 		prune_shallow(show_only ? PRUNE_SHOW_ONLY : 0);
 	}
-- 
2.49.0

