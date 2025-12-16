Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE88233342C
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 17:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765906762; cv=none; b=Df73dN7+HAueCCdn3QGSgVDSCgech7TBbjeHkqo6wD7a++KJot+wPTjiFVx9M1AStG+lBeRmOiNIs6ltu13fhdH70EuRtNPFF0Or/u61pfraxLQDgihzp9Iteftjnu1YrVqLhM85JAyL95INKt3An6I34fvy+Tv0/PQEG6GQuSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765906762; c=relaxed/simple;
	bh=FAzlIEAg7lji6To9KspyUTQzrdmO+gQT3sJyA/dwjCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CIgeswPcAH1r8AducnS6GwoSTxqSEEU+gUcSTTIachBFitdwZk2Zjf7DvQc5AyOQpqemEF/cFyUvJ8x/oADR88LzaalUszPho1j1gj2X+V20v0Rd8dr8AXJSpVeCZm6rVqhAG1pW3Rfee0m5ir62PuFueO0DAjQ0YD53LRryKCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FqaWclbT; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqaWclbT"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6575e760f06so1498937eaf.0
        for <git@vger.kernel.org>; Tue, 16 Dec 2025 09:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765906759; x=1766511559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dkH+fsxdsr3rwTGKJkwYTnUv+u8jviY9EE0qRaSNVKo=;
        b=FqaWclbTQXSyTDbuNjtHgFUWtShBoTUNYvNzMk9UIi5mYGQhudSwCHodlB9GT6iwxs
         bUmVMHUg7jamJI0phFNw+7DT2QpR6R2ie/mxTrpByn9fzsN4531pdwK4GmuPZBAu6HRE
         e7YnX2fCg/y8bnOFKBAvCebuzz+aUGVquJUHjISBx6ydVndGNaL9ouMRkIqSsYuYTKZ7
         DaAWMf4WKgDQX+AlNffQSFoDS3YIJ+VIaxokq8+C6cUaYdxIXsdJNJ8o4fRVfddCZQmS
         yVutsQ2wj5Y/5xKRshpPaguunIr49FPa713VjPJI5wigZ/0pyfx0ufs6o4N9kA73Hmc3
         dB8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765906759; x=1766511559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dkH+fsxdsr3rwTGKJkwYTnUv+u8jviY9EE0qRaSNVKo=;
        b=A5N4o9MNXW4e2A8QVKk5HMseoHmtBAacVzcGonz9MEMIs1Ls1i0gFe0/8tdvVWzZli
         5kVmyUUe3o7VLDQRwU/0ztfw2xpIS7JLSUJnNO8dsybmB1sh+Ek4oNQM5lvPAmER/1OE
         HWjAx0IWxurve9Xa7xXYu+xCjs7oPBg1l+w00G/uzdKkEkfj1HhYtxfGrxTgF0CUVOkZ
         3KPIKQNFq4c9v8MoYUnLaMk6TKCUaCGNzd5eSON7sqXI+HLfkHSwjthWx01v87yLD2Zg
         fg2z0+F9Lq3cVxkP2+Akb+Ph7l+Rj0t743RO4dnirvI3HRH44CjOCdB6RhMh/8kOUvit
         NVJQ==
X-Gm-Message-State: AOJu0YwOLY7YPMa4MWcAEob0v58vFLlHe9eew/utNF0kOjORlTuE+6m7
	akU4eBBfNWRbPTC9iL7MK0F8dP5jODUsh5Pm4/V0fnn8peO29TqOexpKUc9ONw==
X-Gm-Gg: AY/fxX75XX1YiRmNQABcOxDk4pd9l6gkN+ieAbBJ3maLyiDuy4IshVwTuoQAo9bvCUU
	2N3+m9BZIj02Te8T5PVUWrMCsNTaQV5eOAiKQEGf9Nr8rsMxI2GEdd/ca0bhGKOTmkdYCXmzM0B
	05i4q4vZaq2U9DgsNGpONaTHUiTV5MAvNDSWovqjX817Ljo/vxOH6m54M7aO+wPqJ54xemtiRaX
	ZvFMTbsU/nzhdwm+Ovd9Zo7jWsh206YneNIJWQc0yyMsC+XSJ/7CvpvHu50D8r6hacEUb3yVomi
	X6EUk7kHjdLriM1+Kz+evdVK2HKZuw4w0R6pVwMg8hgZpnyp1Gzu0pV7ejqgWfZudefPZCFlEXU
	bI+TpWzlmcnYG8XNy90KjUr7HyVa3rYCeXAJqacoXEAfkEtaW95l/q85sDx+4qPx0MorCR62GQy
	T0r07IKUPqMD6J3S2UH04=
X-Google-Smtp-Source: AGHT+IELfrAWl9U9Cn4/4U5UXGpRB66Q9nqI7UfmKkC4PZL6AUdVsOuy4hpVlDg08dGUf87mcbwnlg==
X-Received: by 2002:a05:6820:6acf:b0:659:9a49:8e82 with SMTP id 006d021491bc7-65b452bff9cmr5248904eaf.82.1765906759448;
        Tue, 16 Dec 2025 09:39:19 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3f614ded1b3sm6438462fac.10.2025.12.16.09.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 09:39:18 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	worldhello.net@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 6/7] builtin/repo: add disk size info to keyvalue stucture output
Date: Tue, 16 Dec 2025 11:38:41 -0600
Message-ID: <20251216173842.3357832-7-jltobler@gmail.com>
X-Mailer: git-send-email 2.52.0.209.ge85ae279b0
In-Reply-To: <20251216173842.3357832-1-jltobler@gmail.com>
References: <20251215205639.2700270-1-jltobler@gmail.com>
 <20251216173842.3357832-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to a prior commit, extend the keyvalue and nul output formats of
the git-repo(1) structure command to additionally provide info regarding
total object disk sizes by object type.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 Documentation/git-repo.adoc |  1 +
 builtin/repo.c              | 18 ++++++++++++++++++
 t/t1901-repo-structure.sh   | 11 ++++++++++-
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 287eee4b93..861073f641 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -51,6 +51,7 @@ supported:
 * Reference counts categorized by type
 * Reachable object counts categorized by type
 * Total inflated size of reachable objects by type
+* Total disk size of reachable objects by type
 
 +
 The output format can be chosen through the flag `--format`. Three formats are
diff --git a/builtin/repo.c b/builtin/repo.c
index b73cfd975b..0ed41bf9d4 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -214,6 +214,7 @@ struct object_values {
 struct object_stats {
 	struct object_values type_counts;
 	struct object_values inflated_sizes;
+	struct object_values disk_sizes;
 };
 
 struct repo_structure {
@@ -462,6 +463,15 @@ static void structure_keyvalue_print(struct repo_structure *stats,
 	printf("objects.tags.inflated_size%c%" PRIuMAX "%c", key_delim,
 	       (uintmax_t)stats->objects.inflated_sizes.tags, value_delim);
 
+	printf("objects.commits.disk_size%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.disk_sizes.commits, value_delim);
+	printf("objects.trees.disk_size%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.disk_sizes.trees, value_delim);
+	printf("objects.blobs.disk_size%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.disk_sizes.blobs, value_delim);
+	printf("objects.tags.disk_size%c%" PRIuMAX "%c", key_delim,
+	       (uintmax_t)stats->objects.disk_sizes.tags, value_delim);
+
 	fflush(stdout);
 }
 
@@ -536,13 +546,16 @@ static int count_objects(const char *path UNUSED, struct oid_array *oids,
 	struct count_objects_data *data = cb_data;
 	struct object_stats *stats = data->stats;
 	size_t inflated_total = 0;
+	size_t disk_total = 0;
 	size_t object_count;
 
 	for (size_t i = 0; i < oids->nr; i++) {
 		struct object_info oi = OBJECT_INFO_INIT;
 		unsigned long inflated;
+		off_t disk;
 
 		oi.sizep = &inflated;
+		oi.disk_sizep = &disk;
 
 		if (odb_read_object_info_extended(data->odb, &oids->oid[i], &oi,
 						  OBJECT_INFO_SKIP_FETCH_OBJECT |
@@ -550,24 +563,29 @@ static int count_objects(const char *path UNUSED, struct oid_array *oids,
 			continue;
 
 		inflated_total += inflated;
+		disk_total += disk;
 	}
 
 	switch (type) {
 	case OBJ_TAG:
 		stats->type_counts.tags += oids->nr;
 		stats->inflated_sizes.tags += inflated_total;
+		stats->disk_sizes.tags += disk_total;
 		break;
 	case OBJ_COMMIT:
 		stats->type_counts.commits += oids->nr;
 		stats->inflated_sizes.commits += inflated_total;
+		stats->disk_sizes.commits += disk_total;
 		break;
 	case OBJ_TREE:
 		stats->type_counts.trees += oids->nr;
 		stats->inflated_sizes.trees += inflated_total;
+		stats->disk_sizes.trees += disk_total;
 		break;
 	case OBJ_BLOB:
 		stats->type_counts.blobs += oids->nr;
 		stats->inflated_sizes.blobs += inflated_total;
+		stats->disk_sizes.blobs += disk_total;
 		break;
 	default:
 		BUG("invalid object type");
diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
index b18213c660..dd17caad05 100755
--- a/t/t1901-repo-structure.sh
+++ b/t/t1901-repo-structure.sh
@@ -4,6 +4,11 @@ test_description='test git repo structure'
 
 . ./test-lib.sh
 
+object_type_disk_usage() {
+	git rev-list --all --objects --disk-usage --filter=object:type=$1 \
+		--filter-provided-objects
+}
+
 test_expect_success 'empty repository' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
@@ -91,7 +96,7 @@ test_expect_success SHA1 'keyvalue and nul format' '
 		test_commit_bulk 42 &&
 		git tag -a foo -m bar &&
 
-		cat >expect <<-\EOF &&
+		cat >expect <<-EOF &&
 		references.branches.count=1
 		references.tags.count=1
 		references.remotes.count=0
@@ -104,6 +109,10 @@ test_expect_success SHA1 'keyvalue and nul format' '
 		objects.trees.inflated_size=28554
 		objects.blobs.inflated_size=453
 		objects.tags.inflated_size=132
+		objects.commits.disk_size=$(object_type_disk_usage commit)
+		objects.trees.disk_size=$(object_type_disk_usage tree)
+		objects.blobs.disk_size=$(object_type_disk_usage blob)
+		objects.tags.disk_size=$(object_type_disk_usage tag)
 		EOF
 
 		git repo structure --format=keyvalue >out 2>err &&
-- 
2.52.0.209.ge85ae279b0

