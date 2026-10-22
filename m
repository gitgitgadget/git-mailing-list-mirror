Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792694676;
	b=SC75maNCyU9fqAUFIx7DEhBsi4FVoCGqOtpNqWYKUWA48r6k9eGiewGHWD2lVgDEka9M
	 KN6RNNUiRCXveaw1n7vT8aU8hqL+unXYa2DLfYt8W4H31EMaXHKbfUHtax+vnrN4fC8cU
	 8ts6ZqudVYJWF8tnA+C406S8ZPPWckQRnKYWcblK2nSNkDkd6+LTNJJ3DIFiTvtfa0uXl
	 /CWeO/jimyyU7s41lnpSw10HKY1d9WAhoyV5Bi0N6ZF39e1l5tMYMVdVp/Qp1/kpTud5Y
	 Fm+BEgIDZpIxzmYpG8enoe5MnSvOolcvLJ9vUKXkULMG9bB2zhaNxyA61oCuvTTq+hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792694676;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DgbSCvm9mOzTgn8ecjFg/g8CFoU/vBUPR0OkksNTT9M=;
	b=NYk4UVOv/JS1suX4DQgCGWW7gm0zaGV5uR/0hmeX2kXhf39/afyii0xMT+UdtJgWhOZw
	 mPKFI3nZLIEKXYw6yfQMI6iwGEHdYYZyIQE17Ah4ADo6GfYDXlRdKOhM9eYixODuWZl7Z
	 dpwviWSmTPEtxq5cv8VUly8L8jmSePo3CUdZPfX8rs9cEl8Dt9eD6KOvt7qD6e4YMneQ3
	 P63dHKfTqK5KH6wtKSdu23M53xlnhDvKuSsnMTJaSzO3WBHxNMG2bip50eoZLe5TNRe1y
	 SKCQxAnIt1CPz3BvHmA0h8FC5uAv6kNgI58bJi/b+ARy0fdlDsEtSnaScPC2vnzrS1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IckxCfkb;
	arc=none smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33675606A32A
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 18:44:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33675606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IckxCfkb
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-53512cd2f85so492951cf.1
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 11:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792694675; x=1793299475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DgbSCvm9mOzTgn8ecjFg/g8CFoU/vBUPR0OkksNTT9M=;
        b=IckxCfkb+ySBxEgZ4+hTu0nB0dU+b4LaTGNz7YZyCkncsJ9adcgASlh66DQV9YGXUM
         7ctB13d4fnt3xL8+Xd7doNpRn1wSLRAZqI8FuVUiST94JYa28bzpL1lukKPE9bkaO5qs
         JEqc7lGZLEC0kO2QAmebuerXjN9pzq+kcgGZCv4EhAjRMsI9yF9KfXMPwGtR4gKbpCXG
         /uSm3E0dmgoLiionOBJmStP+yu2m1h7ZwtewvIkEcU27wWwh32Pt4FFoJp/edLGcftU1
         aEy8pVsCyFmb7U8+OkD27tBIHs/q0v9LzrzULJiZ6Bd/0FEjDmu7wwrM4n0JcCtWkTLz
         TVVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792694675; x=1793299475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DgbSCvm9mOzTgn8ecjFg/g8CFoU/vBUPR0OkksNTT9M=;
        b=zQXHwbGpv4MDkdbiyoLp9314PE6G49qSUoB6Tzjoojb0zFcgaI41W2h4NooHTlSurn
         GkjdgIQDe3nB8u5okS7VEK8D78S/PqD3isJz9VHEHI08CCS2x3gUxsNVlSEgb6osz70Z
         lavfbVqYP3BJZxlB4qI0wys9G3cm4tC+GjZ9byUnHiM3cWrInSp332GI3baErpyR2dlX
         B78OTBoojupNXUTwVNT54TgyPh5TDNytHkeh3Mz2xCukRAkHqLZL5Xxcza7QEGy0Yz4i
         eG8XT4mZkIi7iF7VlRx1GNRTpVepj5KkHZlyDdok0tZBSFVrEl2ktHnovphQLj1Cewu/
         BZnQ==
X-Gm-Message-State: AFq9FYI+44TsCyHlTr/UBW0ErcvSzMluQf0dhZR6vRmQHC0dSdv3svwV
	xmEo2K6bO6bl00mrmTVIGoLdUNckuYpzTb9aFQEVJ0aLNzTxwNbZSacxFtNJNohv7EM=
X-Gm-Gg: AYBFou3wBk4vqnZeGcBxq+UTCkxjxph6M4mZRDWG8MBkxR6CE+zfmldkdiv/OY6sGMk
	Ly08Ux9zeR56xC5BzU+nXLZr+TyRGp0Ji1qpC5NfxBlXBqe0Gnea5PHqtOQq7xb3Jv3FcP9ZDPv
	HAp4G/P2t8cYx00T2dE0YD8pWXu/9VR4TsaXpDC/J5/87mRSQtPQ61+64ctV9tQNZhfCoVXuKBf
	42atK5Z9XBgfaDKrFARJ5HRPhhgDabkfhNHJY16dmWRD19vO8vbEEVfLHbBDvzSvM+CcuAhrQbQ
	H2/+XmCJzJn8vRTM4Hn/i0/NOaZJZFQ3Rr3elL1b3CKpgTQkLZ8YZozkJzeMBBJwu9csuDyGBcT
	KwfPBIdgZlV3p03AJJ2R2QbDf92iAAAyFhb4FUwzvhxRoZcBHBLVL2LxXbInXM7nYtzob29w77B
	3RUIcUoPQ5jA6p+59gBNmpsZXdZkTT0lgrcJx1NZ+QocahKnFcFiuIqaHplk48pxLG3806GZ47S
	GAzTtPJyyGv64B9bDAVb1nvB114cwSi3PVZP3fKhTEc4D+4Avi5h2H/ME2oCkT4VvRpejVNqRsa
	7kSezyKWbH6N0NzYaNOPcKJlBItP97lXhXyDOhlDjSZnB4aMjeAp2+jeQ6onYwIzJYubm11H7XI
	7Hw/Hqv9+aEGulxghsFLoKB10U2Aw
X-Received: by 2002:a05:622a:580f:b0:533:33c6:e635 with SMTP id d75a77b69052e-5369b50cfc9mr97914981cf.8.1792694674916;
        Thu, 22 Oct 2026 11:44:34 -0700 (PDT)
Received: from 3950x.home ([76.69.137.39])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c370fe729sm3956136d6.45.2026.10.22.11.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 11:44:34 -0700 (PDT)
From: Mihai Cosma <mcosma@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	peff@peff.net,
	stolee@gmail.com,
	quark.zju@gmail.com,
	Mihai Cosma <mcosma@gmail.com>
Subject: [PATCH 2/2] status: lock the index only to write it
Date: Thu, 22 Oct 2026 14:44:20 -0400
Message-ID: <20261022184420.3648771-3-mcosma@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022184420.3648771-1-mcosma@gmail.com>
References: <20261022184420.3648771-1-mcosma@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Editors and shell prompts run "git status" in the background. Status
takes index.lock before collecting and holds it to the end, even when
it writes nothing, so a "git add" or "git commit" run meanwhile fails
with "index.lock: File exists".

The lock does not need to cover the collection, because
repo_update_index_if_able() refuses to write an index that changed
since status read it. 226c051adb (status: enable untracked cache,
2015-03-08) moved the write after wt_status_collect() to save the
untracked cache, but left the lock where it was.

Add repo_lock_and_update_index_if_able(), which takes the lock only if
the index has something to write, and call it after collecting. When
there is nothing to write, status no longer creates index.lock; when
there is, it holds the lock only for the write. In a clean gcc checkout
with status running in a loop, 104 of 200 "git add" runs failed before
and none after.

Assisted-by: Claude Opus 5.5, Gemini 4 Argon
Signed-off-by: Mihai Cosma <mcosma@gmail.com>
---
 builtin/commit.c  | 14 +++++-----
 read-cache.c      | 22 +++++++++++++---
 repository.h      |  7 +++++
 t/t7508-status.sh | 67 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 99 insertions(+), 11 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 0e750f6157..851125f1e9 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1543,7 +1543,6 @@ struct repository *repo UNUSED)
 	static const char *rename_score_arg = (const char *)-1;
 	static struct wt_status s;
 	unsigned int progress_flag = 0;
-	int fd;
 	struct object_id oid;
 	static struct option builtin_status_options[] = {
 		OPT__VERBOSE(&verbose, N_("be verbose")),
@@ -1631,11 +1630,6 @@ struct repository *repo UNUSED)
 		      REFRESH_QUIET|REFRESH_UNMERGED|progress_flag,
 		      &s.pathspec, NULL, NULL);
 
-	if (use_optional_locks())
-		fd = repo_hold_locked_index(the_repository, &index_lock, 0);
-	else
-		fd = -1;
-
 	s.is_initial = repo_get_oid(the_repository, s.reference, &oid) ? 1 : 0;
 	if (!s.is_initial)
 		oidcpy(&s.oid_commit, &oid);
@@ -1654,8 +1648,12 @@ struct repository *repo UNUSED)
 
 	wt_status_collect(&s);
 
-	if (0 <= fd)
-		repo_update_index_if_able(the_repository, &index_lock);
+	/*
+	 * Lock only after collecting (the slow part), so that status
+	 * does not block other commands while it works.
+	 */
+	if (use_optional_locks())
+		repo_lock_and_update_index_if_able(the_repository);
 
 	if (s.relative_paths)
 		s.prefix = prefix;
diff --git a/read-cache.c b/read-cache.c
index 58bae677b8..1d2b97c429 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2790,17 +2790,33 @@ int has_racy_timestamp(struct index_state *istate)
 	return 0;
 }
 
+static int index_needs_write(struct index_state *istate)
+{
+	return istate->cache_changed || has_racy_timestamp(istate);
+}
+
 void repo_update_index_if_able(struct repository *repo,
 			       struct lock_file *lockfile)
 {
-	if ((repo->index->cache_changed ||
-	     has_racy_timestamp(repo->index)) &&
-	    repo_verify_index(repo))
+	if (index_needs_write(repo->index) && repo_verify_index(repo))
 		write_locked_index(repo->index, lockfile, COMMIT_LOCK);
 	else
 		rollback_lock_file(lockfile);
 }
 
+void repo_lock_and_update_index_if_able(struct repository *repo)
+{
+	struct lock_file lock = LOCK_INIT;
+
+	if (!index_needs_write(repo->index) ||
+	    repo_hold_locked_index(repo, &lock, 0) < 0)
+		return;
+	if (repo_verify_index(repo))
+		write_locked_index(repo->index, &lock, COMMIT_LOCK);
+	else
+		rollback_lock_file(&lock);
+}
+
 static int record_eoie(void)
 {
 	int val;
diff --git a/repository.h b/repository.h
index 11f5c2ed10..82738d03a3 100644
--- a/repository.h
+++ b/repository.h
@@ -295,6 +295,13 @@ int repo_read_index_unmerged(struct repository *);
  */
 void repo_update_index_if_able(struct repository *, struct lock_file *);
 
+/*
+ * Like repo_update_index_if_able(), but take the lock only if the index
+ * has something to write, so that a caller that read the index without
+ * the lock holds it only for the write.
+ */
+void repo_lock_and_update_index_if_able(struct repository *);
+
 /*
  * Return 1 if upgrade repository format to target_version succeeded,
  * 0 if no upgrade is necessary, and -1 when upgrade is not possible.
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index c045a651f8..e10c961268 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -1722,6 +1722,73 @@ do
 	'
 done
 
+# While status collects, it runs "git status" in the submodule, which
+# runs the submodule's fsmonitor hook. The hook stands in for a user
+# command that updates the superproject's index at that moment.
+setup_index_update_during_collection () {
+	git init "$1" &&
+	(
+		cd "$1" &&
+		test_commit base &&
+		git init sub &&
+		test_commit -C sub sub-base &&
+		git -c advice.addEmbeddedRepo=false add sub &&
+		git commit -m "add sub" &&
+		write_script sub/.git/fsmonitor-hook <<-\EOF &&
+		# The hook runs in the submodule with GIT_DIR exported for it;
+		# clear that before working in the superproject.
+		unset $(git rev-parse --local-env-vars)
+		if test -f ../to-add
+		then
+			git -C .. add to-add
+		fi
+		# Report failure so that status checks every path itself.
+		exit 1
+		EOF
+		git -C sub config core.fsmonitorHookVersion 2 &&
+		git -C sub config core.fsmonitor .git/fsmonitor-hook
+	)
+}
+
+test_expect_success 'status does not block index updates while collecting' '
+	test_when_finished "rm -rf update-while-collecting" &&
+	setup_index_update_during_collection update-while-collecting &&
+	(
+		cd update-while-collecting &&
+		git status &&
+		echo content >to-add &&
+		git status &&
+		echo to-add >expect &&
+		git diff --cached --name-only >actual &&
+		test_cmp expect actual
+	)
+'
+
+for skip_hash in false true
+do
+	test_expect_success "status refresh does not overwrite an index update made while collecting (index.skipHash=$skip_hash)" '
+		test_when_finished "rm -rf refresh-while-collecting" &&
+		(
+			if test $skip_hash = true
+			then
+				# index.skipHash does not work with a split index.
+				sane_unset GIT_TEST_SPLIT_INDEX
+			fi &&
+			setup_index_update_during_collection refresh-while-collecting &&
+			cd refresh-while-collecting &&
+			git config index.skipHash $skip_hash &&
+			git update-index --force-write-index &&
+			git status &&
+			test-tool chmtime -60 base.t &&
+			echo content >to-add &&
+			git status &&
+			echo to-add >expect &&
+			git diff --cached --name-only >actual &&
+			test_cmp expect actual
+		)
+	'
+done
+
 test_expect_success 'racy timestamps will be fixed for clean worktree' '
 	echo content >racy-dirty &&
 	echo content >racy-racy &&
-- 
2.56.0

