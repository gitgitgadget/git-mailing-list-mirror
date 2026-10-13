Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC31A3F9A1E
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 17:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791912203; cv=none; b=eNa+LKD6i2JSs1XsyazlkCo0YNzpQ4k7wxmMZdONrPitNS9li/znWnckZquBNSKk3XKiURlDjHKnlw88W6lg4q/l7JfmYLrOyM6iEM47LA+wBmDXabLflj1iT2AmKHi53EZiIjphh3TyZSDICdHPkz2571iMu8Uo/n69i3RX+jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791912203; c=relaxed/simple;
	bh=jIA+f/2I4+oJ1hOrQTCL+lUvBHvB7qZyF+Gku4lRvGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XX8vqJy8zjtkowSA3VeiZJhIGO0AxMd908Jlqit3YrfJoz+YFW6z/D+Nry9+Ofsadi+BNzAzZOxyx1OA7HnwbcvFzFZDBxYegwAJKMTSfyYEkk2/g94EAYf1+RuRyLcWUOagoAusSIqEQ8E3xkUKhj8VOPu1rhYTxZPcWWTCe1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KeTBtx7F; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KeTBtx7F"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3a8adb68d8bso2255952a91.1
        for <git@vger.kernel.org>; Tue, 13 Oct 2026 10:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791912200; x=1792517000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/QZ0NdmBCctaUK9VotV+k+7o0OL3brIBiKzQvuP7V6g=;
        b=KeTBtx7FsclPQrY4vswRMsLtleFzTSyg2EVEn5jlTLh1WQd9RoT5lCMeprzK9LSfML
         FD9DWHLYrMzqW3MaovMOOwAQZWaGN2g9gdOKVKtyezxLETRJ9FyAqfTJv/gvTsa2JXC4
         biszXziMmwlKg15Kc4NHDhu/67ccxG74flPPsawwD8Rv2Ah8vyaKsjvNtCezdyG4vupC
         ZagYQDNlpJEgLCxnfL2QA+TuClMRqz2t02d6b+miRqnVNV0SA3IDVpIGD/Lv8AJV3r1y
         hrEd8uMJJ0e/8/2FmievIEoiT9jP2NxKZWnt7dQUpUaSk8xcv+mTs8Kuck0905PsJTH1
         AGJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791912200; x=1792517000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/QZ0NdmBCctaUK9VotV+k+7o0OL3brIBiKzQvuP7V6g=;
        b=swd3qt5m3IL1Yzb+x2va75VRx+R1AX298y+4SfCTVz9CEjaMHxysWiqf/Q12p8Jo+B
         cB6cW9X2i5D5yYYVd3bBIGwabStCN5wkwQomYmZjY9LuJ1gRg+R6nPg9xj/InpxeA4YY
         bKNeGxq+5hIPjLbGeAL0pjnkXZPBEnZLzA0BONYwZ3gJebx/J7W70qKJR4hJn3JnlomS
         nUnlgHB+pBpTwS8TasBvP18rdYVyzlB7BcometOmhqoWzCCKO0S+fDSomNvu/4YTBoHU
         tl322G0d7Cb/HTg+uQifopZgfv6BxyWBhzO9GtNMlfSEfuaKvCULSemGRawd22EILNLK
         uZ6A==
X-Gm-Message-State: AFq9FYJcad7qvA5e3vmQXJZNjg/eNKbGrbheAHBAFop4jx6Nu3RvC81N
	QQUAXA4hOXkt4Qna7juyHpElTGsJgRSg68iynUjEIeb4cpaisnhC5G5yc+L4Sw==
X-Gm-Gg: AYBFou2Ft68sCejA4PwS03AItbv1IE1Vyaln//hcN6OrAY02lJpcE7SpCli3kINZxmV
	jVYwx2hFM2+bRnENqHSCJrniCqIFk5NOoL8mpc6SKxeB7ZHeOxM0vxcIp16anAYBjY+490SoZgo
	A0zn5ZSnum2hdLE5DqMuFps7iD9d9Gru8GZ79sTF5zWetyyaF1AjO+iC7jOlrDWIa23lGToUzCP
	fgBbJk/24uhYuzwLM6tt8Isia18XZy1S0MkBQU7+4bQuESyUF6hZ2YIB+tbcRYPv8D01iPmqqvT
	HhcEo9myG+buIxjoC4ZUvwRnIvTHRcUn0VlgIqtV332m0eipVJPW+pLO3cGAcgd3i042CtWvNy+
	P2Aa/tklQkDfFDXO+hpBuwI6vBkvc70ocQSft13Tkyd8TmNxqYg0ifd09VVbZ52KxtWUmKS1Iel
	EhZ6ahD5fgSl9JMBH+BkZJh8mJss6ux7HESWjcUTigdrd4CjeGQ+3sFReRND1gTBotQA7+1uj+O
	PlHeKaDzv4Ieb/l4eE=
X-Received: by 2002:a17:90a:d44d:b0:3a4:b0f3:6597 with SMTP id 98e67ed59e1d1-3ab39fea5c6mr12177693a91.0.1791912199961;
        Tue, 13 Oct 2026 10:23:19 -0700 (PDT)
Received: from quark-fedora-PF5F60VQ.thefacebook.com ([2620:10d:c090:500::4:4699])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac5f2026efsm631690a91.4.2026.10.13.10.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 10:23:19 -0700 (PDT)
From: Jun Wu <quark.zju@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	peff@peff.net,
	ps@pks.im,
	Jun Wu <quark@meta.com>
Subject: [PATCH 1/2] repository: add core.indexLockTimeout
Date: Tue, 13 Oct 2026 10:23:14 -0700
Message-ID: <20261013172315.2997446-2-quark.zju@gmail.com>
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

When an IDE runs `git status` periodically in the background, `status`
can take the index lock, and this prevents other commands like `add`,
`commit` from running.

Commit 27344d6a6c (git: add --no-optional-locks option, 2017-09-27)
avoids the conflict by letting background `git --no-optional-locks status`
skip the index lock, at the cost of losing refreshed stat info, so
the next `status` has to re-hash files.

Approach the conflict from the other side: let non-status commands wait
for the index lock. Mercurial and Sapling have a similar "waiting for wlock"
behavior, and Git already has `core.{config,filesRef}LockTimeout`.

Ideally all non-status commands can wait for the index lock. However,
some code paths (e.g. `commit`) load the index without locking, then lock and
write changes. It is already racy and the wait behavior would make it much
worse. As a defense, waiting is disabled if index was already read.

Default timeout is 1s, effective but not too long to avoid breaking potential
user expectation (e.g. "an index.lock error means I should check whether a
commit message editor is open somewhere"). Tests that are slowed down by the
default timeout now set the timeout to 0.

Signed-off-by: Jun Wu <quark@meta.com>
---
 Documentation/config/core.adoc |  6 ++++++
 repository.c                   | 17 +++++++++++++++-
 t/meson.build                  |  1 +
 t/t0031-lockfile-pid.sh        |  4 ++++
 t/t0032-index-lock-timeout.sh  | 37 ++++++++++++++++++++++++++++++++++
 t/t7400-submodule-basic.sh     |  1 +
 6 files changed, 65 insertions(+), 1 deletion(-)
 create mode 100755 t/t0032-index-lock-timeout.sh

diff --git a/Documentation/config/core.adoc b/Documentation/config/core.adoc
index 0b697f53f1..d06990b7ea 100644
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
index b857e1c580..3eaea3143c 100644
--- a/repository.c
+++ b/repository.c
@@ -473,7 +473,22 @@ int repo_hold_locked_index(struct repository *repo,
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
+		 * Index was initialized (read) without lock. To minimize the
+		 * chance of lost update, do not wait.
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
diff --git a/t/meson.build b/t/meson.build
index f65eb04684..d4debf674e 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -102,6 +102,7 @@ integration_tests = [
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
index 0000000000..ca334c3eef
--- /dev/null
+++ b/t/t0032-index-lock-timeout.sh
@@ -0,0 +1,37 @@
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

