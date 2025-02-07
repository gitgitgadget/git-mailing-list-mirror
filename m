Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F261DC9B4
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 11:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738929466; cv=none; b=n80seWf5gRx6Mt1GwyMeOOENKIligijMeY9v96gqrDzH2muyM1PQNmBjP/tdTGbT1lQS1lHRHlRomnUgycdO08Vf7HW9gVjW7WA1H0+3xY+OZA56d2eh13/JYXgx1QUG+iXPQJIbpTzCDk3bi1UB7n/kfakU+9TMEANOcY3t3Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738929466; c=relaxed/simple;
	bh=fMDXvv4+efXli6nEtYkezFt+pjn8jHqiKNYIiRmG2WI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fGPWa7bqmDBrQIOU8bB0zyDZsJVqN5cVWnkTSyQQHy4ztvY1vO1tsJQunws740R8u1lU1AfcWstqrkC5JuNfHw+EuP3uqhImLPK7tvRUJIz4x/ummTFRHkW989/nckL3IvNB3RzD8m4e30uVvsbmuEgAEd3M1c/6JUqHOqIKUQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M1aWpQQO; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1aWpQQO"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21f48ebaadfso23309425ad.2
        for <git@vger.kernel.org>; Fri, 07 Feb 2025 03:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738929463; x=1739534263; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F47ugB74UVLPpwJUkGE8nSZ4KZh74f6m28JY12AnX6g=;
        b=M1aWpQQObzn8DVBQq4FtWL/SPpdPp3HIwMO01uDsg7e79A29SUoJV+FTsqUqyRIKPA
         W8rib55zwXsFB1KqV6FgiAXu+ywwGNtCZkwcv1KRyTzM0e6goAmnKwlEN3WcYOy/YnQ2
         qwo9SDxhQSJP8WwXeBGlU12sS9G87Pb3rriFEptTEELLy9tgepuzIpYcCV7SJnRVLB6N
         y3YsG3fMWMyFtz+unZwJG0TUj4OGeof4l3BCaQvanblVG09K74txJq6a+08HAdsXww5S
         w4uXWHys/v5cn+xMFeSm/bje7xwCuTwZXU4t7PP1uhdiNiM1vTeILGwUfGn5kidErFL+
         UThA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738929463; x=1739534263;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F47ugB74UVLPpwJUkGE8nSZ4KZh74f6m28JY12AnX6g=;
        b=skxsneHUeecJg5xrlE7UdTfvWBNCPJA0B1eyTxd10x+uxbdSURiYlaoTFHU1dGg+yN
         YART7AfbZtR2DutCOh5xQVw0wf2wU62wEinbbyXhf/7MnQFnrzPL3Ga+Ey8y8CHTYbcJ
         9uit8fvEGX99BGrQTVrwzc2KCgaUzi9agaiTJ1tyVTsBeGA6W0mgpX5FlmxALxHc7bMI
         t0DSFKi4jV5F0VHku9I68v659mB0OtRElwyfzE6JunzriUstKqaj2XWphsrFZ/NMYJBw
         K+64fILSJSCpHFBo3ptjsbpOauFDVNFMjCUlQULd2oyOTTRlnfF+0kJRyzjDXcj8A0jw
         zGiA==
X-Gm-Message-State: AOJu0YzagkfJBc7eEX0KymO1lx0Az5Hohsi4TzpZdMi+kgPXxVO7ShCg
	zCvHflXoQANeZ5wDZk2UYt+2NasM6rma8+RNFI94r3SJgUOjLPS8x239mmPV
X-Gm-Gg: ASbGncs1+D6OSju6NORpLjADHUN0+KLxHoBTT7K8rnHKLyLKbnIzmaPaY7zYr6LOpuL
	Q1ZvcZ59PglGCM8/Ra01J0x8P6JMC5K8ixvkSFCiNT0HdbVN3xPZtzt0Wb79REzDHby18XSlDko
	+47qQDSQ70ShvOvFR60B9hYr+fBPJ/+eFhZQWlM5scQ/o8ffOS/SubJYFLKKv+Eg83G65qmoS8K
	caJINjvgoM/Z+bfrMkTvhpHcM7xjtc2a3GF6SFblzMF09IzMTgHnvI68YVXlVK0NDML1BhhkZJ1
	Ts10appGcJezgIg+c0EZgA==
X-Google-Smtp-Source: AGHT+IFzf7p2r3WxKh++SG4VwCDdscFrVEjKISy0yPw/eg7Y7xX1gLVI1AzkCryq7kPJEi7L8ggHPQ==
X-Received: by 2002:a05:6a00:3e0b:b0:730:29ac:b687 with SMTP id d2e1a72fcca58-7305d518345mr5136713b3a.23.1738929462534;
        Fri, 07 Feb 2025 03:57:42 -0800 (PST)
Received: from [127.0.0.2] ([2401:4900:33b9:ae58:89db:e5e4:299a:5913])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048ad2b7esm2900306b3a.57.2025.02.07.03.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 03:57:42 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 07 Feb 2025 12:57:31 +0100
Subject: [PATCH] builtin/refs: add '--skip-reflog' flag to bypass reflog
 migration
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-477-refs-migrate-add-a-flag-to-ignore-reflogs-during-migration-v1-1-7d40f3b4e30b@gmail.com>
X-B4-Tracking: v=1; b=H4sIACr1pWcC/y2O0QrCMAxFf2Xk2UAtrhV/RXwIaxoDs5V0E2Hs3
 63i44HDPXeDxqbc4DJsYPzSprV0OB4GmO5UhFFTZ/DOj867iKcY0Tg3fKgYLYyUEhLmmQSXiiq
 lGn+NuUrDtJoW+bt9Gs8uhBxSHh1N0CPPbur7d+B62/cPW2I7f5AAAAA=
X-Change-ID: 20250207-477-refs-migrate-add-a-flag-to-ignore-reflogs-during-migration-8066f6df50ac
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5089; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=fMDXvv4+efXli6nEtYkezFt+pjn8jHqiKNYIiRmG2WI=;
 b=kA0DAAoBPtWfJI5GjH8ByyZiAGel9TSj04FTxiO5+h9pu1zLW40HHoUH39kmIN4kwFz/xpnaF
 YkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJnpfU0AAoJED7VnySORox/vk8L/RW4
 VSObEfp00s8bgTpU5zxec1x3zHXVjDVDXENA+/20kXVijiHYKLUsaNc9KrxWwsjlhpTXylpEWop
 HToCBdgMO/ukLtS2rxY4K0Ob9mPpfKTErjwCwn/n2li8k+VehBy/ZIrYK4vHSiN+GcXXI++3+xa
 TxfArGjhQlHzPdPKvQBcMXtmDmKYMFBU4z4EVwpG5Ig2CVC1/TodLbYkJJ7Fzk/3GPZJOx78zTj
 sIqR9RKU2Gbab4RifAKF7o1G/6XQNLqg8/MsQ/R9EjbDEUmHcZ2up2yAOuXyPMnI3JRYXkoaGGu
 5xYLNtUQxCjp3AKt4CLGCy5KGTI5TOCYEc437gWnWDuLDCOIb6f62cwFmpPpZBVZxkw3DNFft/m
 66Bw4qUM3fm+J60WOYVbTGIcSbueGhYTSO5XJ8bKzEw6MjQGEaMW8mWcGV+NdVbORi9AKCiP1Ig
 qtFLmxlUUuKSiRBEhF0KIr1KKo5WifnYIyn3JW5khBg5JgSXS+s8JNTDG+lg==
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The 'git-refs(1)' migrate subcommand, which transfers repositories
between reference backends, currently migrates reflogs by default as of
In 246cebe320 (refs: add support for migrating reflogs, 2024-12-16).
While this behavior is desirable for most client-side repositories,
server-side repositories typically don't use reflogs and the migration
of these entries is unnecessary overhead.

Add a '--skip-reflog' flag to the migrate subcommand to make reflog
migration optional. This is particularly useful for server-side
migrations where reflogs are not needed, improving migration performance
in these scenarios.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
---
 builtin/refs.c          |  3 +++
 refs.c                  |  8 +++++---
 refs.h                  |  5 ++++-
 t/t1460-refs-migrate.sh | 17 +++++++++++++++--
 4 files changed, 27 insertions(+), 6 deletions(-)

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
index a6d9b35a46eb59350aa0d59d982a2fbfaecf1448..9059d4c4121842a9d2e77dc4e54c537eeff8afab 100755
--- a/t/t1460-refs-migrate.sh
+++ b/t/t1460-refs-migrate.sh
@@ -9,14 +9,16 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 # Migrate the provided repository from one format to the other and
 # verify that the references and logs are migrated over correctly.
-# Usage: test_migration <repo> <format> <skip_reflog_verify>
+# Usage: test_migration <repo> <format> <skip_reflog_verify> <...options>
 #   <repo> is the relative path to the repo to be migrated.
 #   <format> is the ref format to be migrated to.
 #   <skip_reflog_verify> (true or false) whether to skip reflog verification.
+#   <...options> are other options be passed directly to 'git refs migrate'.
 test_migration () {
 	repo=$1 &&
 	format=$2 &&
 	skip_reflog_verify=${3:-false} &&
+	shift $(( $# >= 3 ? 3 : 2 )) &&
 	git -C "$repo" for-each-ref --include-root-refs \
 		--format='%(refname) %(objectname) %(symref)' >expect &&
 	if ! $skip_reflog_verify
@@ -25,7 +27,7 @@ test_migration () {
 	   git -C "$repo" reflog list >expect_log_list
 	fi &&
 
-	git -C "$repo" refs migrate --ref-format="$2" &&
+	git -C "$repo" refs migrate --ref-format="$format" $@ &&
 
 	git -C "$repo" for-each-ref --include-root-refs \
 		--format='%(refname) %(objectname) %(symref)' >actual &&
@@ -241,6 +243,17 @@ do
 				test_cmp expect.reflog actual.reflog
 			)
 		'
+
+		test_expect_success "$from_format -> $to_format: skip reflog with --skip-reflog" '
+			test_when_finished "rm -rf repo" &&
+			git init --ref-format=$from_format repo &&
+			test_commit -C repo initial &&
+			# we see that the repository contains reflogs.
+			test 2 = $(git -C repo reflog --all | wc -l) &&
+			test_migration repo "$to_format" true --skip-reflog &&
+			# there should be no reflogs post migration.
+			test 0 = $(git -C repo reflog --all | wc -l)
+		'
 	done
 done
 

---

base-commit: bc204b742735ae06f65bb20291c95985c9633b7f
change-id: 20250207-477-refs-migrate-add-a-flag-to-ignore-reflogs-during-migration-8066f6df50ac

Thanks
- Karthik

