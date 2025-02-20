Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F378101DE
	for <git@vger.kernel.org>; Thu, 20 Feb 2025 09:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740045385; cv=none; b=mgCub2SB9JfQMsdQqsqR7HZRKa5UJ9g8KxYR7IHXU9VD8/GQssQ/fw9UIPqgmD4q9PEpXw/iFTj34DSUoir4WbA/klKJ7lYiRCdqE7Uhl8+WPLdkgN1yQ5R6GFIzvp1vUz6iDXUVYFmWK7387n8SKb1DoiDiTeHklh2wbS+6Yw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740045385; c=relaxed/simple;
	bh=SVat52AOae23BuEpAyLs8mAIh3/BOC6MB3or35U6ww4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QEuWGYNh17uRPkv/vrDXbTQk0ChkSDP+4LXcvt51QJ7BLtkmjTSfw7VuhfTip/tkwTb5A8RcyuyZs02WYJpWXWOBtJ0xXore6BFfuy5cir4ohXIWtFW+HV17XxYeLl9uZ9k3ZZxW6xoa4sxUGNnvuue+mwdOh7sMqXKn2NSgGtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=izBbIQ4B; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izBbIQ4B"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e02eba02e8so951175a12.0
        for <git@vger.kernel.org>; Thu, 20 Feb 2025 01:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740045382; x=1740650182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XSCLve9Fc/A9vmMTsQceJKH8z9ZuHvK0jzdT/oFWJCw=;
        b=izBbIQ4B/kW+Yv1bEQOhI8cX9N+hVEt7JvmbXvekXygsRc5O3JqkWH6kYDUDJwor1B
         qSsupMa9m14QcCC/6HGAINRZg5mzuUCdy0GZcyBAKPyopLXV+Xd8vse9NDLnYFjuObV2
         6FoVmSZupet8FWVM6EIeFBTLYlAn4TLPa1mSU9CjjHOxvwpaY3wEFDE/8V9rntlYSYeG
         ZLlxEdMmmaYwiPeup9uzb5Xmo4ohCBM3eNMyPZDi3gWmzD6qZq1OJf6XHR3kKOcb+3wq
         6FBrusCs2KM1KuILN2nOpCe4ZPWmdcmY6bsB6dNMMzLDyaYv9hZ0Lsj7TbnxDzd/E3k1
         p/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740045382; x=1740650182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XSCLve9Fc/A9vmMTsQceJKH8z9ZuHvK0jzdT/oFWJCw=;
        b=IY64pdL6OhSKpHXNFSjMINXZLjIP+0yptiX4+PygRvHb12pjFsx/nPzIFaOLAYr8XK
         9lGr9IsjdvhXG3xKqCcigcIWObY5V1wMNC8B7Qf9R0cmPA7GJXg3+fy5iHn77YGrQKDq
         A2btkTtSkUFjcGQvexYpXH1c9m/8IKVx2bn6RFdjxY27PT1xjt1naJfKcFQMzdLycJZT
         MkMA7DmeAL8MU8ySyJt8UWZdb920uRZRlDT7n53/i1mj/Vrbb4kKebH24Ay3thYa7Flh
         GYeclKb6lpmXCwqQn+jeuao1PorZWN5nJLayTovCwLnbiFSbzjmuWW66GMvp7xGyB4VO
         uvbg==
X-Gm-Message-State: AOJu0Yy06eIom7AuTbOfiKpeZSKM/7MQdVj6dTxPoCuQtYMj6pAh89Lf
	rywDUGq6SGFwFvY6nP3K/ljgz6NUC8URNL6z/tEFccbHl2F/sGd2
X-Gm-Gg: ASbGncsicfgLiryESjX4AHov658uunq+PcNWBxN1mszkcpSW16bKIBHYmk38ZtYVDk1
	MaRqyM0q6nvoStaOwduScF7YhSzDaDEkjKBanWkQpdHn6TYQgLMXRSBB7ZjEELD4AjtnoDrejQx
	7IpQ6BRnBnMB8wPkIyjqVgRfLw2sk4E7HQ1Lq0CBJD26yxINQSPk0sdKFlOzyndYyBVyKh8VZca
	UtPJOpX0HRb9kDbWBWFPWPpZWxIb81gqWPLxI1VC9r2pP+WwLCTRhr+RmjG5zlveKerHn2bfd9U
	eG+eV5pO+wBW8xL4KCiYE/zSwgH9Fe7R7REK4har+Wln/mGG8g==
X-Google-Smtp-Source: AGHT+IGnJQ7bIYhwPWMmVUpr9eQDgZfp6oMcvXfJaAGgI6bug0ym7EXUsm5UdfFmC0YPCpfGd6GrzQ==
X-Received: by 2002:a05:6402:2689:b0:5dc:584e:853d with SMTP id 4fb4d7f45d1cf-5e089d31fa6mr6532262a12.25.1740045381193;
        Thu, 20 Feb 2025 01:56:21 -0800 (PST)
Received: from knayak--20220801-595b8.fritz.box ([2a02:2455:8268:bc00:be75:ad3c:ad90:b579])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece2866e7sm11760902a12.65.2025.02.20.01.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 01:56:20 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com,
	gitster@pobox.com
Cc: git@vger.kernel.org,
	ps@pks.im,
	toon@iotcl.com
Subject: [PATCH v4] builtin/refs: add '--no-reflog' flag to drop reflogs
Date: Thu, 20 Feb 2025 10:56:14 +0100
Message-ID: <20250220095614.62042-1-karthik.188@gmail.com>
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

The 'git-refs(1)' migrate subcommand, which transfers repositories
between reference backends, currently migrates reflogs by default as of
246cebe320 (refs: add support for migrating reflogs, 2024-12-16).

While this behavior is desirable for most client-side repositories,
server-side repositories are not expected to contain reflogs. However,
due to historical reasons, some may still have them. This could be
caused, for example, by bugs, misconfiguration, or an administrator
enabling reflogs on the server for debugging purposes.

To handle this, introduce the '--no-reflog' flag, which skips reflog
migration. When this flag is used, reflogs from the original reference
backend are not transferred, and since only the new reference backend
remains in the repository, all previous reflogs are permanently removed.

Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/refs.c          |  3 +++
 refs.c                  |  8 +++++---
 refs.h                  |  5 ++++-
 t/t1460-refs-migrate.sh | 28 ++++++++++++++++++++++++----
 4 files changed, 36 insertions(+), 8 deletions(-)

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

1:  42c40d9617 ! 1:  3a02e8e526 builtin/refs: add '--skip-reflog' flag to bypass reflog migration
    @@ Metadata
     Author: Karthik Nayak <karthik.188@gmail.com>
     
      ## Commit message ##
    -    builtin/refs: add '--skip-reflog' flag to bypass reflog migration
    +    builtin/refs: add '--no-reflog' flag to drop reflogs
     
         The 'git-refs(1)' migrate subcommand, which transfers repositories
         between reference backends, currently migrates reflogs by default as of
    @@ Commit message
         caused, for example, by bugs, misconfiguration, or an administrator
         enabling reflogs on the server for debugging purposes.
     
    -    To address this, introduce the --skip-reflog flag, allowing users to
    -    bypass reflog migration. This ensures that the repository ends up in the
    -    expected state after migration.
    +    To handle this, introduce the '--no-reflog' flag, which skips reflog
    +    migration. When this flag is used, reflogs from the original reference
    +    backend are not transferred, and since only the new reference backend
    +    remains in the repository, all previous reflogs are permanently removed.
     
         Helped-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
    @@ builtin/refs.c: static int cmd_refs_migrate(int argc, const char **argv, const c
      		OPT_BIT(0, "dry-run", &flags,
      			N_("perform a non-destructive dry-run"),
      			REPO_MIGRATE_REF_STORAGE_FORMAT_DRYRUN),
    -+		OPT_BIT(0, "skip-reflog", &flags,
    -+			N_("skip migrating reflogs"),
    ++		OPT_BIT(0, "no-reflog", &flags,
    ++			N_("drop reflogs entirely during the migration"),
     +			REPO_MIGRATE_REF_STORAGE_FORMAT_SKIP_REFLOG),
      		OPT_END(),
      	};
    @@ t/t1460-refs-migrate.sh: do
     +			# we see that the repository contains reflogs.
     +			git -C repo reflog --all >reflogs &&
     +			test_line_count = 2 reflogs &&
    -+			test_migration repo "$to_format" true --skip-reflog &&
    ++			test_migration repo "$to_format" true --no-reflog &&
     +			# there should be no reflogs post migration.
     +			git -C repo reflog --all >reflogs &&
     +			test_must_be_empty reflogs

---

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

