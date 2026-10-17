Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8092DEA8F
	for <git@vger.kernel.org>; Sat, 17 Oct 2026 07:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792222361; cv=none; b=Auh6j/KZ2t4jRriMPMiCNXHYUaM0EnM5w197PBkqBmzYLsoIRz5B6zuW75oaBCrIFqtCSkXGYwy5jOjzOA/k0oPz2uAlLQ6RjPZ4MBJtI3sFMWJEKbAIZrUqf8Dp2C55yFYOmzaIhDD0kwoGKgsP8S3/dUQyUWQ3xKD9Wx+/Zjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792222361; c=relaxed/simple;
	bh=ey5En6blTJ/pijF+zH9RKpaw9QcPzqC5CrHHkWlWlmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gx0lOz+yBWWZ7kkHGOvP2F06VGVwIXl3AmTNHXjkwgGWp8BsUhsMW1z6xV/X7ZOZRb2d8/ggY6eIYM9p/WFz2vTtzFvnmeuL8oXOj6/1LHSXqYBWSSZR9WOhkokyzqpg9hH0l9XltqUaXG4oX76MYLG/WnGtaxgsg6elxXVsutI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gBepkDFc; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gBepkDFc"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-7c3b75caad1so295603137.0
        for <git@vger.kernel.org>; Sat, 17 Oct 2026 00:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792222359; x=1792827159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KMZQRreG4v6Q5txWwL1iJRUy9BXyb6tXaeyum02cAtY=;
        b=gBepkDFcQC8Y5Sz+GxoCfxKnH/DuvnWf5A1xhuFha/3k9q5iM7NHhEBhwUlO1IZkr8
         4m1YUGIHft/fjOL3ystMatqFYYJ9XQ7Sd2545YlZe2VdVg+GjRKbRuqsIpgidB6a1PUO
         TT7/sIpEsi7TiAFxlK8u+eribRZF5q/NLxUK/s6GF4D0zI949kE+PO54sVb4MS3BoOrH
         Hrel9CBEg/IACo+SBOMjcRqhjFuEBzh9DgvaPQHfEjfw3RJ6LCwX0HD38OLjl84c5FTi
         8vTqbTJq+oc5JAGB23gRY3lxgidTp6uLSE9TOFSobTGjEHNiHWqDuGNVeodTq99xN8m2
         HUvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792222359; x=1792827159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KMZQRreG4v6Q5txWwL1iJRUy9BXyb6tXaeyum02cAtY=;
        b=Xs5T2KFyfxrxuGSZ5ZfrUnDCdvJaWqbHtYg0PC10iSQO75AVAWf7qoPKykOmC/574D
         hsLKK/GInI6FR8JD+jd3bRcKST8Yj7qG4wFSCtKvgzL+WaAcJ7dAQY1nfgpd1dqKN8Uh
         ESK2UK4KqDDPVX1ftTJpi+miyjYTalAAtyxD8NOnyU6GY8jFTbeAJYeLbordxCZGonSw
         pJA7pkIv8sVDPxtexDzyajHg3qXqQKKwTiXKzLj25Ifgr3zB/PVCqCVFf9t3u4+NycOU
         APgKoajY7tB9gLKWYL5hz5S6HcXfvek+C7XHjbZ5HvfQflLrHZIe2LL78/IxXL9wlCiP
         16Qg==
X-Gm-Message-State: AFq9FYKK6BfbSfV0z56u5Gz54X1dqhpL2pv6++NKstknzZ6g9BDY5K0K
	YYNMEiKOuJ7h8QAD/ahpIKXGTZDGo3re6XSy1i3pfSVrNVCNrUR7hkQkN5bz1w==
X-Gm-Gg: AYBFou0TJDXGMcHxJyxUzRpZx9f0lgnvgZ+yvNOSXJj4QIT5ExIjIoLyEtf8Q0Zfx+r
	eMt8IbgDPD2CTbFXChfyQVarnK8a8CrOExYpE9yFr6bm5S5dzwoDkuKanPVb2YyJbNFjDOcel3x
	uNYHQacC4sUJdAMkKV2QLqs5dU7gFCANZseMYx4RGkMwh56BFrlBeSyX+8o+T8iq+8jou26YqYs
	f1D+wfDGFcvWIbkoGV9PHrx5EeL6cVAUYDIGynZo26fe8M8ZfDtzMS5rC69A6oUSsr5EVt09TZo
	rABAT8zebU9Nf9sj3MoSVneFUAI/B/aU/p8akGygdmSlplNQlGgubedH+48YB/vz/zX127p6In4
	Ovipp+W8nv00rueYaR8In0EOmfDwXjbnaNT2JVSLaRV83PvppISux1njEYFk0RfNmzT2PJR+ZML
	osfMcbx/VMk6I0MatssWX8RqJP0i2kFQE5ENwMmE6j5UujyRSV8+7HfJ0dnuKPi8D5VVNgjFlMu
	9t3OW50Jt1zHyl67wg/8D44Nz2pwpoN+f2I7bF5Eiwg3SZERdNJmaeIhfEcu2AnDw==
X-Received: by 2002:a05:6102:5127:b0:7c1:f386:1b7a with SMTP id ada2fe7eead31-7cc36aa1844mr626222137.27.1792222358846;
        Sat, 17 Oct 2026 00:32:38 -0700 (PDT)
Received: from quark-fedora-PF5F60VQ (162-199-88-188.lightspeed.sntcca.sbcglobal.net. [162.199.88.188])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-990835c2180sm3379305241.3.2026.10.17.00.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 00:32:38 -0700 (PDT)
From: Jun Wu <quark.zju@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	peff@peff.net,
	ps@pks.im,
	Jun Wu <quark@meta.com>
Subject: [PATCH v2 2/4] repository: add core.indexLockTimeout
Date: Sat, 17 Oct 2026 00:32:29 -0700
Message-ID: <20261017073231.3357477-3-quark.zju@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261017073231.3357477-1-quark.zju@gmail.com>
References: <20261013172315.2997446-1-quark.zju@gmail.com>
 <20261017073231.3357477-1-quark.zju@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jun Wu <quark@meta.com>

Make "git add/rm/checkout" wait for the index lock, so they won't fail
immediately.

When an IDE runs "git status" every 5 seconds, and each "git status" holds the
index lock for 0.5s, a user has 10% chance to be unable to commit or checkout.
By waiting, the add and checkout commands can succeed.

Example commands that will wait:
- add, rm, mv, checkout / switch / restore, read-tree, apply --index /
  --cached, update-index, cherry-pick, revert, clone.

Example commands that are unchanged:
- repo_try_hold_locked_index() users (see previous commit):
  status, describe --dirty, part of diff / merge / rebase.
- repo_hold_locked_index() users, but racy (waiting makes race worse,
  see code comment for details): stash, part of merge, am,
  add -i / -p, checkout-index, sparse-checkout, rerere,
  commit (until the next commit), reset (until a later commit).

Default timeout is 1s. Mercurial uses 600s. In case of an unexpected
use-case with unexpected expectation, I picked a conservative middle
ground.

Some tests emulate the index lock being taken, the new behavior makes
those tests slower (but still passing). Those tests now set timeout to 0
to run as fast as before.

Alternatively, IDEs could use "git --no-optional-locks status" to avoid taking
the index lock. However, not all tool authors know about "--no-optional-locks",
and "--no-optional-locks" will lose the refreshed stat info, so later
(periodical) "git --no-optional-locks status" runs become slower over time
(assuming nothing refreshes the index).

Signed-off-by: Jun Wu <quark@meta.com>
---
 Documentation/config/core.adoc |  6 +++++
 repository.c                   | 26 +++++++++++++++++++-
 repository.h                   |  4 ++++
 t/meson.build                  |  1 +
 t/t0031-lockfile-pid.sh        |  4 ++++
 t/t0032-index-lock-timeout.sh  | 43 ++++++++++++++++++++++++++++++++++
 t/t7400-submodule-basic.sh     |  1 +
 7 files changed, 84 insertions(+), 1 deletion(-)
 create mode 100755 t/t0032-index-lock-timeout.sh

diff --git a/Documentation/config/core.adoc b/Documentation/config/core.adoc
index bdc74d291c..88f3529cc0 100644
--- a/Documentation/config/core.adoc
+++ b/Documentation/config/core.adoc
@@ -604,6 +604,12 @@ core.configLockTimeout::
 	that is already on disk before the lock is taken, so it can be
 	set persistently like any other option.
 
+core.indexLockTimeout::
+	The length of time, in milliseconds, to retry when trying to
+	lock the index file for writing. Value 0 means not to retry at
+	all; -1 means to try indefinitely. Default is 1000 (i.e., retry
+	for 1 second). Not supported by all commands.
+
 core.pager::
 	Text viewer for use by Git commands (e.g., 'less').  The value
 	is meant to be interpreted by the shell.  The order of preference
diff --git a/repository.c b/repository.c
index a74b1118cb..c7d098d166 100644
--- a/repository.c
+++ b/repository.c
@@ -473,9 +473,33 @@ int repo_hold_locked_index(struct repository *repo,
 			   struct lock_file *lf,
 			   int flags)
 {
+	int timeout_ms;
+
 	if (!repo->index_file)
 		BUG("the repo hasn't been setup");
-	return repo_hold_lock_file_for_update(repo, lf, repo->index_file, flags);
+
+	if (repo->index->initialized) {
+		/*
+		 * Index was read before lock. Depending on the callsite
+		 * logic, the write might be racy:
+		 *
+		 * - read: repo_read_index()
+		 * - lock: repo_hold_locked_index() -> maybe sleep()
+		 * - write: repo_update_index_if_able() # okay
+		 *          write_locked_index() # racy, worse with sleep()
+		 *
+		 * Be conservative, avoid sleep() to not make the write race
+		 * worse. If the callsite wants the "waiting for index lock"
+		 * behavior, fix the read/lock order.
+		 */
+		timeout_ms = 0;
+	} else {
+		timeout_ms = 1000;
+		repo_config_get_int(repo, "core.indexlocktimeout", &timeout_ms);
+	}
+
+	return repo_hold_lock_file_for_update_timeout(repo, lf, repo->index_file,
+						      flags, timeout_ms);
 }
 
 int repo_try_hold_locked_index(struct repository *repo,
diff --git a/repository.h b/repository.h
index 253a5f1d3f..fe4eedd7d3 100644
--- a/repository.h
+++ b/repository.h
@@ -284,6 +284,10 @@ void repo_clear(struct repository *repo);
  * populated then the number of entries will simply be returned.
  */
 int repo_read_index(struct repository *repo);
+
+/*
+ * Obtain the index lock. This can block (retry with backoff).
+ */
 int repo_hold_locked_index(struct repository *repo,
 			   struct lock_file *lf,
 			   int flags);
diff --git a/t/meson.build b/t/meson.build
index 11b3752f00..3aff2a9f50 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -108,6 +108,7 @@ integration_tests = [
   't0029-core-unsetenvvars.sh',
   't0030-stripspace.sh',
   't0031-lockfile-pid.sh',
+  't0032-index-lock-timeout.sh',
   't0033-safe-directory.sh',
   't0034-root-safe-directory.sh',
   't0035-safe-bare-repository.sh',
diff --git a/t/t0031-lockfile-pid.sh b/t/t0031-lockfile-pid.sh
index e9e2f04049..3fc8de02b6 100755
--- a/t/t0031-lockfile-pid.sh
+++ b/t/t0031-lockfile-pid.sh
@@ -8,6 +8,10 @@ The feature is opt-in via core.lockfilePid config setting (boolean).
 
 . ./test-lib.sh
 
+test_expect_success 'setup' '
+	git config --global core.indexLockTimeout 0
+'
+
 test_expect_success 'stale lock detected when PID is not running' '
 	git init repo &&
 	(
diff --git a/t/t0032-index-lock-timeout.sh b/t/t0032-index-lock-timeout.sh
new file mode 100755
index 0000000000..cde6f1892c
--- /dev/null
+++ b/t/t0032-index-lock-timeout.sh
@@ -0,0 +1,43 @@
+#!/bin/sh
+
+test_description='Test config core.indexLockTimeout'
+
+. ./test-lib.sh
+
+prepare_index_lock () {
+	test_when_finished "rm -f .git/index.lock" &&
+	touch .git/index.lock &&
+	{
+		( sleep 1 && rm -f .git/index.lock ) &
+	} &&
+	test_when_finished "wait"
+}
+
+test_must_fail_with_index_lock () {
+	test_must_fail "$@" 2>err &&
+	test_grep index.lock err
+}
+
+test_expect_success 'index locked, add fails with indexLockTimeout=0' '
+	prepare_index_lock &&
+	touch foo &&
+	test_must_fail_with_index_lock git -c core.indexLockTimeout=0 add foo
+'
+
+test_expect_success 'index locked, add waits with indexLockTimeout>0' '
+	prepare_index_lock &&
+	git -c core.indexLockTimeout=5000 add foo
+'
+
+test_expect_success 'index locked, commit fails even with indexLockTimeout>0 (read index before lock)' '
+	prepare_index_lock &&
+	test_must_fail_with_index_lock git -c core.indexLockTimeout=5000 commit -m init
+'
+
+test_expect_success 'index locked, checkout waits with indexLockTimeout>0' '
+	git commit -m init &&
+	prepare_index_lock &&
+	git -c core.indexLockTimeout=5000 checkout HEAD
+'
+
+test_done
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index eefdecb0bd..9a90b6a76d 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -276,6 +276,7 @@ test_expect_success 'submodule add to reconfigure existing submodule with --forc
 '
 
 test_expect_success 'submodule add relays add --dry-run stderr' '
+	test_config_global core.indexLockTimeout 0 &&
 	test_when_finished "rm -rf addtest/.git/index.lock" &&
 	(
 		cd addtest &&
-- 
2.56.0

