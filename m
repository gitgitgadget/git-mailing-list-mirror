Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2A9525A7B
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 17:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791912203; cv=none; b=rMuHjxOIivYrqIuFJEY157L41oVkgNleDctLcNVPyFdT7aWklQTl5VRxc5A8JyVr0YHbhM0JkKf5sZEnBvgRK10lbbWnS9q4/OWEWVu0qsJfW5PT8PwIZ2YwZg+jymC7FPmFmBrxRo+GB/fUFEitM7Nq3xK1ybGe4you2tquKL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791912203; c=relaxed/simple;
	bh=Ue3YoMmps+Sm/JrbnXjlqbTBNiFFl2pk7f71qYamBEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aFpsax7R11IpMeQqNIwumH4P1J+DFrpt8UxisyhJ+f1Oh52u8hQIrManp6Pmdwa+zmufmoeEyc1keRhyoQqvzf829adFuHuxApodo/hGQbM+ijGX4+6D29PhOCi4Gw2IiyIA5d2M+wPVcPqe4tT9iVbxLPOVa4FdqzAQAuuglgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fPM8Clhf; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPM8Clhf"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3ab33730821so1880116a91.3
        for <git@vger.kernel.org>; Tue, 13 Oct 2026 10:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791912201; x=1792517001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NnQse249rFzzWdH6AEa9zph6OX3gdnxAcV5W3n3Rr7Y=;
        b=fPM8Clhf6csVHawYwnOJw1lOfHwGNTilLpo/xxVr6xu0g8GNd738NKXoKTDSQ2aguV
         OzhF9ECnqwLQJrraFmQS9qeFQR7BTYJc42yXUIn8iWEZvtRVU/mjuJsz6/JVe/Fs51F8
         qRpN+izTLv5F9WwQYwbotcshowKnL8JHzjXbIRBRNzm0qu0jgHepQz3g03/6Ifb+oZZA
         t8o44Q7I6h8DIbdfYH+G4l+eOBKPGEQ8nHqSM4TijklltxesSpv+TCX+TaxFxqNewoJD
         9rdjJZaTJZJy0Acdwx+vCgwgKyTb4zJrN0ZFt/mpdPiTJY98YKpbq9QMIiN6bXgdBaWx
         nVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791912201; x=1792517001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NnQse249rFzzWdH6AEa9zph6OX3gdnxAcV5W3n3Rr7Y=;
        b=PNgvdaJRbt1M2aMTFeKdEQyHyVKrA3PeZwC1heoMNu6S5ZVG//faWhEC5EmfblJEw3
         RwtJcr4PSdB534jVlaotxp3BdVC1iR3hJvOLUwLJUXnzCOB4X89t/gQ8lPHkJzvecQp/
         gIacPsYzGD5X9jAEa9BdWbvVmth5qhecnzFCi1QSz1z4SgTtNwmAaHzhAdVQQBtzp9SS
         P2bdSQzAzcv1KrtUeuujIkZynGquTm2RZ4mhDSM17BesNSdFdiRDnHI6VaHoogUqBvXr
         baN3U4UFsxc04E92phO9+sO9vDTiWi8T9XfHHbL9M5e6a+qe+iMhI23mzTg2bZGhaasN
         TVvg==
X-Gm-Message-State: AFq9FYI3l2esyg5dyZGLSHJ6aacJUs0AMx0+zMDBgQnkq0bavJGydpV9
	i3N6yMttZCxfyYxHC+OsJ/lhoJQsbAdfGmrn0HHLsKaj/k2e6Lk7jmyQmFzg2A==
X-Gm-Gg: AYBFou2Dc1mKZa/4/iza6nwLMRDpHxYbDenqvr1EAOOorimwMZoi+85p9AFcp+84RVS
	V6Y4Ciuj6TtmCen4RPMZbFc69MBQuup9DBdOPTx4h1bYKkvrlio36mXnkx2/IV2WHW/HRuqPNoh
	z6CTTP5iJDrRR/XZy3eJr4ss3socwO6Al3Ha7fB8FwQwgUkotn/cS0NDNV7IgnJFySIzZSCjKN0
	QJrAB4k7vmn78HqWRX/JNK7q0Lznqg3EuhpHwmvSe+Q8k3KqirtuV7aX/o4XRNOCpFtI3W9UFG9
	oviNKDblGykBEKcAEwBlDN956uBkpWWlag39vC9QhhbxKPmfj7+HghN+UvEuftCmgp0ZKBBj3mD
	UFxl2MTOq1FRMZPwhgeUi4iXgeFHjPPvwth5bsa4ZnHH4gAZKglbUocB/D20aM8mUblOCt/STwD
	gbgB0n6fDceCn9mvWPRIX4nEvNCHK6yhT9XUpQF677wUjVqITr/7Btp1KdNfaGU0POEbKHRdOnJ
	20dZ6tj2c+0G3kpEmpTC9/ST749yQ==
X-Received: by 2002:a17:90b:17d1:b0:3a6:f1d2:57f8 with SMTP id 98e67ed59e1d1-3ac53df025cmr1094516a91.2.1791912200935;
        Tue, 13 Oct 2026 10:23:20 -0700 (PDT)
Received: from quark-fedora-PF5F60VQ.thefacebook.com ([2620:10d:c090:500::4:4699])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac5f2026efsm631690a91.4.2026.10.13.10.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 10:23:20 -0700 (PDT)
From: Jun Wu <quark.zju@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	peff@peff.net,
	ps@pks.im,
	Jun Wu <quark@meta.com>
Subject: [PATCH 2/2] commit: lock index before reading
Date: Tue, 13 Oct 2026 10:23:15 -0700
Message-ID: <20261013172315.2997446-3-quark.zju@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261013172315.2997446-1-quark.zju@gmail.com>
References: <20261013172315.2997446-1-quark.zju@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jun Wu <quark@meta.com>

Take the index lock before reading the index, in one place, instead
of separately in each `if` branch.

`commit` now respects the `core.indexLockTimeout` config.

History suggests no particular reason for reading before locking:
- f5bbc3225c (Port git commit to C., 2007-11-08): lock before reading
- 2888605c64 (builtin-commit: fix partial-commit support, 2007-11-18):
  seems to accidentally move reading to before locking

Signed-off-by: Jun Wu <quark@meta.com>
---
 builtin/commit.c              | 9 ++-------
 t/t0032-index-lock-timeout.sh | 4 ++--
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 840b6b4083..08dd53ad4e 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -389,13 +389,13 @@ static const char *prepare_index(const char **argv, const char *prefix,
 	    (!amend || (fixup_message && strcmp(fixup_prefix, "amend"))))))
 		die(_("No paths with --include/--only does not make sense."));
 
+	repo_hold_locked_index(the_repository, &index_lock, LOCK_DIE_ON_ERROR);
+
 	if (repo_read_index_preload(the_repository, &pathspec, 0) < 0)
 		die(_("index file corrupt"));
 
 	if (interactive) {
 		char *old_index_env = NULL, *old_repo_index_file;
-		repo_hold_locked_index(the_repository, &index_lock,
-				       LOCK_DIE_ON_ERROR);
 
 		refresh_cache_or_die(refresh_flags);
 
@@ -453,8 +453,6 @@ static const char *prepare_index(const char **argv, const char *prefix,
 	 */
 	if (all || (also && pathspec.nr)) {
 		char *ps_matched = xcalloc(pathspec.nr, 1);
-		repo_hold_locked_index(the_repository, &index_lock,
-				       LOCK_DIE_ON_ERROR);
 		add_files_to_cache(the_repository, also ? prefix : NULL,
 				   &pathspec, ps_matched, 0, 0, 0 );
 		if (!all && report_path_error(ps_matched, &pathspec))
@@ -480,8 +478,6 @@ static const char *prepare_index(const char **argv, const char *prefix,
 	 * We still need to refresh the index here.
 	 */
 	if (!only && !pathspec.nr) {
-		repo_hold_locked_index(the_repository, &index_lock,
-				       LOCK_DIE_ON_ERROR);
 		refresh_cache_or_die(refresh_flags);
 		if (the_repository->index->cache_changed
 		    || !cache_tree_fully_valid(the_repository->index))
@@ -531,7 +527,6 @@ static const char *prepare_index(const char **argv, const char *prefix,
 	if (repo_read_index(the_repository) < 0)
 		die(_("cannot read the index"));
 
-	repo_hold_locked_index(the_repository, &index_lock, LOCK_DIE_ON_ERROR);
 	add_remove_files(&partial);
 	refresh_index(the_repository->index, REFRESH_QUIET, NULL, NULL, NULL);
 	cache_tree_update(the_repository->index, WRITE_TREE_SILENT);
diff --git a/t/t0032-index-lock-timeout.sh b/t/t0032-index-lock-timeout.sh
index ca334c3eef..0c36a7cdfe 100755
--- a/t/t0032-index-lock-timeout.sh
+++ b/t/t0032-index-lock-timeout.sh
@@ -29,9 +29,9 @@ test_expect_success 'index locked, add waits with indexLockTimeout>0' '
 	git -c core.indexLockTimeout=5000 add foo
 '
 
-test_expect_success 'index locked, commit fails even with indexLockTimeout>0 (read index before lock)' '
+test_expect_success 'index locked, commit waits with indexLockTimeout>0' '
 	prepare_index_lock &&
-	test_must_fail_with_index_lock git -c core.indexLockTimeout=5000 commit -m init
+	git -c core.indexLockTimeout=5000 commit -m init
 '
 
 test_done
-- 
2.56.0

