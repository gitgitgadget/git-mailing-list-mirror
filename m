Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7981525D536
	for <git@vger.kernel.org>; Wed, 12 Feb 2025 18:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739385539; cv=none; b=ZyQh2MhKsYmWwpL3//vmbvhQaPvQMyYBJuRZPmSgi8O2wQwichPMuH5GxrY6YP/0lXD6GS2/zgv7p1IgnHOkwMNJD5tmq409QrLKtSqbshTiEomWgM0tlY8gieLuIVwwVCzxex4IZSmF6ZA+tVO/lLybC6zBIceQeIjqqm33Wr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739385539; c=relaxed/simple;
	bh=nPnIHVGNqXVguRaQOnRmyS6x5OIFF9Q3ucW+itV8jT8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:
	 In-Reply-To:References:To:Cc; b=cAUFMCG8wY88g3ho7ay9/bIQPtizHQAdNXG91U4n2I7MV7bhoYd16J5IMzzjmQAoQ5KcTdISB4f710HbgSEeytQAnte2WO5wK/2mx7RBjtaqokLGqsmVcqu8mMSARpO21vkVwdpBwnYMctwsypUrtf3hduaBR2YGdYdm0FpB7Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EW3W91X5; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EW3W91X5"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5de3c29e9b3so10352097a12.3
        for <git@vger.kernel.org>; Wed, 12 Feb 2025 10:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739385536; x=1739990336; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0hx/j0oz9bUVyZQtarDqOjjIKh2XVcnE+L5r+7nRkG0=;
        b=EW3W91X5lzI/MY6H1vxwKs8qiixe/Bf7BARiVicCaoNDc4M/URHxEIoiazL29fSdUg
         wmAuSuJ3baryzBLMmTHIstc4OMFfRtBr4qVLZ3QAvA0Bh38BRjwcZW9OUNWnHm8ro8ub
         MX/G5wHMYLNo5b2cH3L4rcG+du0Aj52h7c4jv27C4eRBBiAIZ4UNR4XPwj/C9vuyNK6M
         Ge12pLO+1DPv3oFoPT+RplHjOw/iY2d1w0YU4JWLyj4LZKF2C5L1GWTAjYODSG52rtZO
         KUevLlIBBCa6yFfL9zJUg2bY252HxK6Dc5Z8c6QkFE7oRux2tzUK3BKhtIVezrEY9ATW
         9eDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739385536; x=1739990336;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0hx/j0oz9bUVyZQtarDqOjjIKh2XVcnE+L5r+7nRkG0=;
        b=U9l7rOxJFQlMPBzP1ldKudZnztU+zp5b9Xg0OHqDzs7HVXSbaTtW5MQBRNfxVRbOwT
         vcBGxV4pIX4b/r84kPNNZ21wuZAwGsoho56bTReaGTlNqd/vOkD33ngTtTuW9a7ldoxG
         j4AX2FF6noHYaxpTyv6rx+eRJjYxtULDDY17G3Yv9Vl069wF8SYwjVsC/FAhERHMYZH0
         tK2Ps3o7BTxd5Ojph7Ymv86ZCgA3EROWl8qVNLPXYEtKZF6/Y4h45Yf7k5GssqKeBnAb
         hkUo8FAVUvSusQhuNVkx7eqNeYF+JN0IpEmO8QXjRpdPHXw+xu8fHjRq9e7h8/zvvdf2
         qbMA==
X-Gm-Message-State: AOJu0Yw6PuRLd2EG57Py4kpDIhHhFndeZ8asKXOSzOZkhE45BOUq2zWi
	aNQomVSwy55FBEvorpmfsLUa9K2O6886Jjf0+Lo79x4wfEyr2l0MQygeL6jJ
X-Gm-Gg: ASbGncuxNwtAH2SWaz0P1P4mt2OiBnwC4Zmc4qGD/7+VR7IEGLtJhjPSDVWWbmk1EWp
	o5NIkvETvdBHOlLOuPk8eacAim1JgxDqk7a3+y3IzTU73Pmxqck+3oVaWumVmlt9VWHYdQuF/tS
	zJZlxTjaj4vyxh7A7JOBl5EMDt4xEPlRoHFYq2CWfwNvcXsP5RzsHQblagFaAgt/H2+nkwM0hVo
	wHuiU/WVBXnDNuZIPMB6BSccpq6W/Cn7CLMGcNPYpnnzqrlJGqJi056S+QozBvY7zUOp5Ieqlk3
	L2ldFLmTPMZb7UOip2cuGA==
X-Google-Smtp-Source: AGHT+IEPR/k5C9ULirsyhsRqeUIIL20aFNbPxkebJXR4sUYnInpoG6FRXH47KsAGlg24zvjW8E+tng==
X-Received: by 2002:a17:907:da9:b0:ab6:c4e0:2d18 with SMTP id a640c23a62f3a-aba4ebbce11mr24128866b.16.1739385535436;
        Wed, 12 Feb 2025 10:38:55 -0800 (PST)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:6727:83fd:fe12:fd02])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7dd005e9bsm400556466b.37.2025.02.12.10.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 10:38:55 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 12 Feb 2025 19:38:52 +0100
Subject: [PATCH v3] builtin/refs: add '--skip-reflog' flag to bypass reflog
 migration
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-477-refs-migrate-add-a-flag-to-ignore-reflogs-during-migration-v3-1-98b2c4d2bb0c@gmail.com>
X-B4-Tracking: v=1; b=H4sIALvqrGcC/63OQQ6CMBAF0KuYrh3TFqTiynsYFyOdlkmAmhaJx
 nB3i3HBXpd/8jPvv0SiyJTEcfMSkSZOHIYciu1GNC0OnoBtzkJLvZdaGiiNgUguQc8+4kiA1gK
 C69DDGID9ECItjS74BPYeefDfbn4NB1lVrrJuL7ERGbnlJj8+A86XnFtOY4jPz55JLde/0ZMCB
 caW0hXXkgp5Pfkeuds1oRcLPekVp9TPnM5cXSvU1NRo6mrNzfP8BhSdUQ97AQAA
X-Change-ID: 20250207-477-refs-migrate-add-a-flag-to-ignore-reflogs-during-migration-8066f6df50ac
In-Reply-To: <20250211-477-refs-migrate-add-a-flag-to-ignore-reflogs-during-migration-v2-1-991a2ec9a796@gmail.com>
References: <20250211-477-refs-migrate-add-a-flag-to-ignore-reflogs-during-migration-v2-1-991a2ec9a796@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, jltobler@gmail.com, gitster@pobox.com, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8329; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=nPnIHVGNqXVguRaQOnRmyS6x5OIFF9Q3ucW+itV8jT8=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGes6r7ncNOJGNqx886x9eXJn2tJGcPlmrEdW
 Ihl12N8T1obTYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJnrOq+AAoJED7VnySO
 Rox/qdIMAJwwfxlJUrzRxFAlJ0oeHUO2m2Gju/yfUVxkO1WBbQBG/JPqxioPJyj55IIzCYuHcWJ
 sS40WrjOC15cys8fB7WB5uNXbbSkHu/4uevF7rr9X++yArRmz/SeKpXT+kgAam5c42sbiv/CT8N
 1hTf4uRrp0/bdmB5oVy5VrI1iFYx+H1GkkcqIdTFBK/b45lgAx7SG4QCF2etDwL1NOCqiu2GLS7
 Kyc5O3d0wXJcCIgdlBSHoc2yCgYmWE9KrvwReHeuajdrSkdkD1M6k6LLUnhfnmLO8clL1palUUx
 rPjd/piHtlU4rqcc8u3shz28mqmxcvJwHeMBbxA12GJdwBx5w9lR7SJ3sW2Gb4q1ruTukaSrOhS
 3MuuesKKsr47jp4aTCP5czD2j+/NWPINKqY1LlbDTQE6vacvtounQMXcI4fmMuoI8EeREFraV3V
 Aeau0YljA8nb92DOtHcZcj0PX2PIGkQY/I6yeUm80cccMTNU9gnEBcWLbbDMWGXfZEK6qPmqVY8
 fo=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The 'git-refs(1)' migrate subcommand, which transfers repositories
between reference backends, currently migrates reflogs by default as of
246cebe320 (refs: add support for migrating reflogs, 2024-12-16).

While this behavior is desirable for most client-side repositories,
server-side repositories are not expected to contain reflogs. However,
due to historical reasons, some may still have them. This could be
caused, for example, by bugs, misconfiguration, or an administrator
enabling reflogs on the server for debugging purposes.

To address this, introduce the --skip-reflog flag, allowing users to
bypass reflog migration. This ensures that the repository ends up in the
expected state after migration.

Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/refs.c          |  3 +++
 refs.c                  |  8 +++++---
 refs.h                  |  5 ++++-
 t/t1460-refs-migrate.sh | 28 ++++++++++++++++++++++++----
 4 files changed, 36 insertions(+), 8 deletions(-)

Karthik Nayak (1):

builtin/refs: add '--skip-reflog' flag to bypass reflog migration
---
Changes in v3:
- Make changes to the test:
  - Use "$@" instead of $@
  - Mark optional arguments correctly
  - Use <options...> instead of <...options> as the former is more widely
    used.
- Link to v2: https://lore.kernel.org/r/20250211-477-refs-migrate-add-a-flag-to-ignore-reflogs-during-migration-v2-1-991a2ec9a796@gmail.com

Changes in v2:
- Fix typo in commit mesasge and clarify the intent.
- Modify the test to use `test_line_count` and `test_must_be_empty`.
- Link to v1: https://lore.kernel.org/r/20250207-477-refs-migrate-add-a-flag-to-ignore-reflogs-during-migration-v1-1-7d40f3b4e30b@gmail.com

Range-diff versus v2:

1:  fcc313ad3b ! 1:  bbc3d154cf builtin/refs: add '--skip-reflog' flag to bypass reflog migration
    @@ t/t1460-refs-migrate.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
      # Migrate the provided repository from one format to the other and
      # verify that the references and logs are migrated over correctly.
     -# Usage: test_migration <repo> <format> <skip_reflog_verify>
    -+# Usage: test_migration <repo> <format> <skip_reflog_verify> <...options>
    ++# Usage: test_migration <repo> <format> [<skip_reflog_verify> [<options...>]]
      #   <repo> is the relative path to the repo to be migrated.
      #   <format> is the ref format to be migrated to.
    - #   <skip_reflog_verify> (true or false) whether to skip reflog verification.
    -+#   <...options> are other options be passed directly to 'git refs migrate'.
    +-#   <skip_reflog_verify> (true or false) whether to skip reflog verification.
    ++#   <skip_reflog_verify> (default: false) whether to skip reflog verification.
    ++#   <options...> are other options be passed directly to 'git refs migrate'.
      test_migration () {
      	repo=$1 &&
      	format=$2 &&
    - 	skip_reflog_verify=${3:-false} &&
    -+	shift $(( $# >= 3 ? 3 : 2 )) &&
    +-	skip_reflog_verify=${3:-false} &&
    ++	shift 2 &&
    ++	skip_reflog_verify=false &&
    ++	if test $# -ge 1
    ++	then
    ++		skip_reflog_verify=$1
    ++		shift
    ++	fi &&
      	git -C "$repo" for-each-ref --include-root-refs \
      		--format='%(refname) %(objectname) %(symref)' >expect &&
      	if ! $skip_reflog_verify
    @@ t/t1460-refs-migrate.sh: test_migration () {
      	fi &&
      
     -	git -C "$repo" refs migrate --ref-format="$2" &&
    -+	git -C "$repo" refs migrate --ref-format="$format" $@ &&
    ++	git -C "$repo" refs migrate --ref-format="$format" "$@" &&
      
      	git -C "$repo" for-each-ref --include-root-refs \
      		--format='%(refname) %(objectname) %(symref)' >actual &&


base-commit: bc204b742735ae06f65bb20291c95985c9633b7f

Thanks
- Karthik
---
 builtin/refs.c          |  3 +++
 refs.c                  |  8 +++++---
 refs.h                  |  5 ++++-
 t/t1460-refs-migrate.sh | 28 ++++++++++++++++++++++++----
 4 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/builtin/refs.c b/builtin/refs.c
index a29f19583474518ee0942ea53c39cbdf9661c5e2..30be0254c14dd3d07693d70c25dddc9990756e9c 100644
--- a/builtin/refs.c
+++ b/builtin/refs.c
@@ -30,6 +30,9 @@ static int cmd_refs_migrate(int argc, const char **argv, const char *prefix,
 		OPT_BIT(0, "dry-run", &flags,
 			N_("perform a non-destructive dry-run"),
 			REPO_MIGRATE_REF_STORAGE_FORMAT_DRYRUN),
+		OPT_BIT(0, "skip-reflog", &flags,
+			N_("skip migrating reflogs"),
+			REPO_MIGRATE_REF_STORAGE_FORMAT_SKIP_REFLOG),
 		OPT_END(),
 	};
 	struct strbuf errbuf = STRBUF_INIT;
diff --git a/refs.c b/refs.c
index f4094a326a9f88f979654b668cc9c3d27d83cb5d..5e8f5c06fa68d16c93ee11edd9742995eea994b6 100644
--- a/refs.c
+++ b/refs.c
@@ -3035,9 +3035,11 @@ int repo_migrate_ref_storage_format(struct repository *repo,
 	if (ret < 0)
 		goto done;
 
-	ret = refs_for_each_reflog(old_refs, migrate_one_reflog, &data);
-	if (ret < 0)
-		goto done;
+	if (!(flags & REPO_MIGRATE_REF_STORAGE_FORMAT_SKIP_REFLOG)) {
+		ret = refs_for_each_reflog(old_refs, migrate_one_reflog, &data);
+		if (ret < 0)
+			goto done;
+	}
 
 	ret = ref_transaction_commit(transaction, errbuf);
 	if (ret < 0)
diff --git a/refs.h b/refs.h
index a0cdd99250e8286b55808b697b0a94afac5d8319..ccee8fc6705e6e93a1c6234e7395180f8dfd815b 100644
--- a/refs.h
+++ b/refs.h
@@ -1157,8 +1157,11 @@ int is_pseudo_ref(const char *refname);
  *   - REPO_MIGRATE_REF_STORAGE_FORMAT_DRYRUN: perform a dry-run migration
  *     without touching the main repository. The result will be written into a
  *     temporary ref storage directory.
+ *
+ *   - REPO_MIGRATE_REF_STORAGE_FORMAT_SKIP_REFLOG: skip migration of reflogs.
  */
-#define REPO_MIGRATE_REF_STORAGE_FORMAT_DRYRUN (1 << 0)
+#define REPO_MIGRATE_REF_STORAGE_FORMAT_DRYRUN      (1 << 0)
+#define REPO_MIGRATE_REF_STORAGE_FORMAT_SKIP_REFLOG (1 << 1)
 
 /*
  * Migrate the ref storage format used by the repository to the
diff --git a/t/t1460-refs-migrate.sh b/t/t1460-refs-migrate.sh
index a6d9b35a46eb59350aa0d59d982a2fbfaecf1448..83466bde1865071ee633c738fd5c2ad9ae65bca3 100755
--- a/t/t1460-refs-migrate.sh
+++ b/t/t1460-refs-migrate.sh
@@ -9,14 +9,21 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 # Migrate the provided repository from one format to the other and
 # verify that the references and logs are migrated over correctly.
-# Usage: test_migration <repo> <format> <skip_reflog_verify>
+# Usage: test_migration <repo> <format> [<skip_reflog_verify> [<options...>]]
 #   <repo> is the relative path to the repo to be migrated.
 #   <format> is the ref format to be migrated to.
-#   <skip_reflog_verify> (true or false) whether to skip reflog verification.
+#   <skip_reflog_verify> (default: false) whether to skip reflog verification.
+#   <options...> are other options be passed directly to 'git refs migrate'.
 test_migration () {
 	repo=$1 &&
 	format=$2 &&
-	skip_reflog_verify=${3:-false} &&
+	shift 2 &&
+	skip_reflog_verify=false &&
+	if test $# -ge 1
+	then
+		skip_reflog_verify=$1
+		shift
+	fi &&
 	git -C "$repo" for-each-ref --include-root-refs \
 		--format='%(refname) %(objectname) %(symref)' >expect &&
 	if ! $skip_reflog_verify
@@ -25,7 +32,7 @@ test_migration () {
 	   git -C "$repo" reflog list >expect_log_list
 	fi &&
 
-	git -C "$repo" refs migrate --ref-format="$2" &&
+	git -C "$repo" refs migrate --ref-format="$format" "$@" &&
 
 	git -C "$repo" for-each-ref --include-root-refs \
 		--format='%(refname) %(objectname) %(symref)' >actual &&
@@ -241,6 +248,19 @@ do
 				test_cmp expect.reflog actual.reflog
 			)
 		'
+
+		test_expect_success "$from_format -> $to_format: skip reflog with --skip-reflog" '
+			test_when_finished "rm -rf repo" &&
+			git init --ref-format=$from_format repo &&
+			test_commit -C repo initial &&
+			# we see that the repository contains reflogs.
+			git -C repo reflog --all >reflogs &&
+			test_line_count = 2 reflogs &&
+			test_migration repo "$to_format" true --skip-reflog &&
+			# there should be no reflogs post migration.
+			git -C repo reflog --all >reflogs &&
+			test_must_be_empty reflogs
+		'
 	done
 done
 

