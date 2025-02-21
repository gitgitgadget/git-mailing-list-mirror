Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09C61D6DDC
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 10:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740132270; cv=none; b=rqIcc1yEBI/1n3Q4O9NWqKL0fwo+e5OPE6ltB8QkgR4NvzE3PLpoPFMFeFsOt19ZyRqhr84X2IONGLddC9orpaAGgL9zJ7JRpZqfTAM0+G5snU9f4svXbEgng0Mi8nX/sG02ZqaCzhlbhIGd2Rj9o4fjD30gHIfIx4lUYrogfcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740132270; c=relaxed/simple;
	bh=L+UCN0bBWCUyKmo0XBiCP2kRnq8UCCgzn0U2Sa6JlL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cHdigR3NoWtZkFTzErWm9fFwP6Ylb5h4hret4YClGIPMR7yZthEbcLPXJlOZXJwTIPBbS99QhG1iUUzISN2MXLx34E8SzQWPPAIj85NuoAzFEqBWfLB5WE2CfLczJrzNq7rOA/2Inu0AZIUMCLn9k0Nloc/gnlcxuaXrraWbRDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gBS/sznX; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gBS/sznX"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso294949966b.3
        for <git@vger.kernel.org>; Fri, 21 Feb 2025 02:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740132266; x=1740737066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gi6DBsRsyNWOpKzV+HJkebZ+KATCrMkMGQhZLKMeoME=;
        b=gBS/sznXMJSHyGPeZfz32PNNqxXuXTK6p0ftvcSIpXSzmN9ufnGR8a6OHFm6AxvWxO
         MfVrVHLBoxMwceduzYjVfWePFhS6M65196djTdrU9xUxs6319ogG62YUdZHdHG0m7wG0
         0afpK8FcrVKGDK3tYrjykknuGTwRZ1EfOs+3sXVysqX7OaLXueu46ZHuOOGcXrYa5/yG
         XpE00HZnEIDAh/fp0YYBPVpsuk9sOylKvFB8kusLuyKtSGFxpD/yH9Q6FxHFxGc+OFv7
         FZUDw9oM6Nk9KgQiRhIYkvM9VcvT7QPRNRDSvZveZn/5AoSiOD9vpBPUfpf+qJv1qy+U
         YGrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740132266; x=1740737066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gi6DBsRsyNWOpKzV+HJkebZ+KATCrMkMGQhZLKMeoME=;
        b=bK0aW0IsDiqhGZrP8x4gIdhgMATubJ89cRQNdO0qduYKXsaiSKyDI7w1a2PPpFB598
         Hqd9id71DfBgb+ikDlENr3aQbuzt8LhIQu8PdftRbbnyjWwRsoI8eUfeRySZDh96utdc
         raOoMWUxme3ECsWLAiaZgwOFGFE5npJiFQuwsvijL/ugLKwYrY4t3eIcRHMlVlx7VGjm
         VMwG0mITqFIPCCXWvKK54h9Hw5Fa+LT5Kgx0iAiV7k+d3s27S2iNwtz4emoQ67xd9TR2
         /xEA8TO10zSaA4buNIU12SdehR1gOdWtXjOo/waLmqC+8LghXfKLZP/VoFx2s0xX3TC6
         kIeA==
X-Gm-Message-State: AOJu0Yy/pvaq73oX3KZNqIbix+2E4wFX86ajvP8UDQjVHLQVsHf3WgDw
	Bm9sOP9aL655r1sIz+tfXp9Pc8ejf5Py65291GTgvWdpGWBUTLCf
X-Gm-Gg: ASbGncudBTNvK/Xcq/TVcirPumzWV/p8HNKSYq8sXY+bHLfrRhsaYA4DXIv85ooNDPm
	qcHAonCORPRzd/tiVvFW+3NckDiqxhi7D4+qDLZA5JN5Squ2epuwForVPpIwUxYJu9xQsv/kFBm
	0HU/MOryizzTEHJknhjriIo/r50eCh6pfsbv+/iwv36Bz6hIiQqL8Ymhs0cKiJxSrELIQwbB+9x
	YImjo+x+E5jrp7wrnD6r6W2ShB96SA3YUMeIIvbM3SJqR+L6EwhzuqBxbt04k3iFWGsz3SkaJ/d
	X50oH0vsGV97sW+9viVMv1FYAba8Atl6yGdp0kL3WUvNyg7FEegy+4wrYBSp
X-Google-Smtp-Source: AGHT+IGXUFBJcc5zKZmp4EoQR1zYX9QU+TranK13QRtZXMMQrgjaa5eSThOoCvo070I52mvpa6NPqQ==
X-Received: by 2002:a17:906:3088:b0:ab7:9bea:4e04 with SMTP id a640c23a62f3a-abc0d9d99e9mr185385666b.15.1740132265796;
        Fri, 21 Feb 2025 02:04:25 -0800 (PST)
Received: from knayak--20220801-595b8.fritz.box ([2a02:2455:8268:bc00:77a4:b052:f5d3:8b81])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb978e2c9dsm984707366b.65.2025.02.21.02.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 02:04:25 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com,
	gitster@pobox.com
Cc: git@vger.kernel.org,
	ps@pks.im,
	toon@iotcl.com
Subject: [PATCH v5] builtin/refs: add '--no-reflog' flag to drop reflogs
Date: Fri, 21 Feb 2025 11:04:23 +0100
Message-ID: <20250221100423.91075-1-karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250207-477-refs-migrate-add-a-flag-to-ignore-reflogs-during-migration-v1-1-7d40f3b4e30b@gmail.com>
References: <20250207-477-refs-migrate-add-a-flag-to-ignore-reflogs-during-migration-v1-1-7d40f3b4e30b@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "git refs migrate" subcommand converts the backend used for ref
storage. It always migrates reflog data as well as refs. Introduce an
option to exclude reflogs from migration, allowing them to be discarded
when they are unnecessary.

This is particularly useful in server-side repositories, where reflogs
are typically not expected. However, some repositories may still have
them due to historical reasons, such as bugs, misconfigurations, or
administrative decisions to enable reflogs for debugging. In such
repositories, it would be optimal to drop reflogs during the migration.

To address this, introduce the '--no-reflog' flag, which prevents reflog
migration. When this flag is used, reflogs from the original reference
backend are migrated. Since only the new reference backend remains in
the repository, all previous reflogs are permanently discarded.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-refs.txt | 11 ++++++++---
 builtin/refs.c             |  3 +++
 refs.c                     |  8 +++++---
 refs.h                     |  5 ++++-
 t/t1460-refs-migrate.sh    | 28 ++++++++++++++++++++++++----
 5 files changed, 44 insertions(+), 11 deletions(-)

Changes in v5:
- Add missing documentation and cleanup the commit message.
- I also see that 'git-refs.txt' in master has been renamed to 'git-refs.adoc',
  but I'm going to avoid rebasing on latest master, since the resolution is
  quite simple here. Happy to do it if needed. 

Changes in v4:
- Modify the flag to `--no-reflog` to better indicate that reflogs will
  be dropped during the migration. This is also reflected in the help text
  and the commit message.

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

Range-diff:

1:  3a02e8e526 ! 1:  f0c11e6a4d builtin/refs: add '--no-reflog' flag to drop reflogs
    @@ Metadata
      ## Commit message ##
         builtin/refs: add '--no-reflog' flag to drop reflogs
     
    -    The 'git-refs(1)' migrate subcommand, which transfers repositories
    -    between reference backends, currently migrates reflogs by default as of
    -    246cebe320 (refs: add support for migrating reflogs, 2024-12-16).
    +    The "git refs migrate" subcommand converts the backend used for ref
    +    storage. It always migrates reflog data as well as refs. Introduce an
    +    option to exclude reflogs from migration, allowing them to be discarded
    +    when they are unnecessary.
     
    -    While this behavior is desirable for most client-side repositories,
    -    server-side repositories are not expected to contain reflogs. However,
    -    due to historical reasons, some may still have them. This could be
    -    caused, for example, by bugs, misconfiguration, or an administrator
    -    enabling reflogs on the server for debugging purposes.
    +    This is particularly useful in server-side repositories, where reflogs
    +    are typically not expected. However, some repositories may still have
    +    them due to historical reasons, such as bugs, misconfigurations, or
    +    administrative decisions to enable reflogs for debugging. In such
    +    repositories, it would be optimal to drop reflogs during the migration.
     
    -    To handle this, introduce the '--no-reflog' flag, which skips reflog
    +    To address this, introduce the '--no-reflog' flag, which prevents reflog
         migration. When this flag is used, reflogs from the original reference
    -    backend are not transferred, and since only the new reference backend
    -    remains in the repository, all previous reflogs are permanently removed.
    +    backend are migrated. Since only the new reference backend remains in
    +    the repository, all previous reflogs are permanently discarded.
     
    +    Helped-by: Junio C Hamano <gitster@pobox.com>
         Helped-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
    + ## Documentation/git-refs.txt ##
    +@@ Documentation/git-refs.txt: git-refs - Low-level access to refs
    + 
    + SYNOPSIS
    + --------
    +-[verse]
    +-'git refs migrate' --ref-format=<format> [--dry-run]
    +-'git refs verify' [--strict] [--verbose]
    ++[synopsis]
    ++git refs migrate --ref-format=<format> [--no-reflog] [--dry-run]
    ++git refs verify [--strict] [--verbose]
    + 
    + DESCRIPTION
    + -----------
    +@@ Documentation/git-refs.txt: include::ref-storage-format.txt[]
    + 	can be used to double check that the migration works as expected before
    + 	performing the actual migration.
    + 
    ++--reflog::
    ++--no-reflog::
    ++	Choose between migrating the reflog data to the new backend,
    ++	and discarding them.  The default is "--reflog", to migrate.
    ++
    + The following options are specific to 'git refs verify':
    + 
    + --strict::
    +
      ## builtin/refs.c ##
     @@ builtin/refs.c: static int cmd_refs_migrate(int argc, const char **argv, const char *prefix,
      		OPT_BIT(0, "dry-run", &flags,

---

diff --git a/Documentation/git-refs.txt b/Documentation/git-refs.txt
index 9829984b0a..733ada7d51 100644
--- a/Documentation/git-refs.txt
+++ b/Documentation/git-refs.txt
@@ -8,9 +8,9 @@ git-refs - Low-level access to refs
 
 SYNOPSIS
 --------
-[verse]
-'git refs migrate' --ref-format=<format> [--dry-run]
-'git refs verify' [--strict] [--verbose]
+[synopsis]
+git refs migrate --ref-format=<format> [--no-reflog] [--dry-run]
+git refs verify [--strict] [--verbose]
 
 DESCRIPTION
 -----------
@@ -43,6 +43,11 @@ include::ref-storage-format.txt[]
 	can be used to double check that the migration works as expected before
 	performing the actual migration.
 
+--reflog::
+--no-reflog::
+	Choose between migrating the reflog data to the new backend,
+	and discarding them.  The default is "--reflog", to migrate.
+
 The following options are specific to 'git refs verify':
 
 --strict::
diff --git a/builtin/refs.c b/builtin/refs.c
index a29f195834..c459507d51 100644
--- a/builtin/refs.c
+++ b/builtin/refs.c
@@ -30,6 +30,9 @@ static int cmd_refs_migrate(int argc, const char **argv, const char *prefix,
 		OPT_BIT(0, "dry-run", &flags,
 			N_("perform a non-destructive dry-run"),
 			REPO_MIGRATE_REF_STORAGE_FORMAT_DRYRUN),
+		OPT_BIT(0, "no-reflog", &flags,
+			N_("drop reflogs entirely during the migration"),
+			REPO_MIGRATE_REF_STORAGE_FORMAT_SKIP_REFLOG),
 		OPT_END(),
 	};
 	struct strbuf errbuf = STRBUF_INIT;
diff --git a/refs.c b/refs.c
index f4094a326a..5e8f5c06fa 100644
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
index a0cdd99250..ccee8fc670 100644
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
index a6d9b35a46..2ab97e1b7d 100755
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
+			test_migration repo "$to_format" true --no-reflog &&
+			# there should be no reflogs post migration.
+			git -C repo reflog --all >reflogs &&
+			test_must_be_empty reflogs
+		'
 	done
 done
 
-- 
2.47.2

