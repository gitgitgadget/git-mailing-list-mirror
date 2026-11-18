Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795028891;
	b=cit7370ZCs7E7QK6osKhqPeo9BdlxXA5cxOg0lahuCNGWl7UrGab4bWMyEzta6V+VQMz
	 f73MteKXBWYGYwX+0RaIWnlR1PkEKKtR9g4I0mDfVMMhuD/rJlT4tdrDlQXROigSyQIyN
	 wXO1+oc/lNFmZm9itBfkf75rK9VT91uaMAL+zvipfYo/9CuE2sFJV1uFrLk0J6yrvrvkH
	 apUDpHRC6KY1ytoW94tqGV6bjhozMhj87bWqxwk0LTRpmxmNUV/yQUPxkzCbS38Jp322j
	 OS+v/1bgP7YUjvm51T7tA8sWjbXjC2Op51HNLwje7JEKhkKnXzSNRkJLAdJtFpav2nA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795028891;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HSAuNGVPW83IAHegUxpYQDB5M1FUQrweL8TNZQMYOnQ=;
	b=XYnlwTmA8bWItVB7dofAJOm8Y4qUQhu5L/q9nYeVGoQfklLmS96d5u/psV75Bf2Xqs9s
	 F3rPOOu51RhK+PG8y7RhudjfBWRWzCFvioQcETcPDbz8Ei3MpmiOk1spfTOGeg3qT7QJ+
	 TiKCw3s11XciDuOX1HBEU7D3F3QHbtL4dVJ5BH0Bncmm7wZjREMajDo7LSu25qufItHtE
	 bXQKhdceKbAKqJLbio3b/MTaNivYFdEA2dMcA/Mqv4tP3+a0u2qyEDVLpcXiHpCLoAtMa
	 QEQGtexlljxZIU4NYY0Se2b2hfvTh2DZeQQvhSZwgBcyPx6oYWt4afUd4l9sM+MXvXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w11uyTk1;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B67760A2603
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 19:08:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B67760A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w11uyTk1
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1a3c08d6928so1985569c88.0
        for <git@vger.kernel.org>; Wed, 18 Nov 2026 11:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795028887; x=1795633687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HSAuNGVPW83IAHegUxpYQDB5M1FUQrweL8TNZQMYOnQ=;
        b=w11uyTk1+yWfaY9wqQDQ64RYk3In0e/V1m605nO7cXQ2z+e3kvohOaVTA+oFzoiv6R
         /8RrUvTKEzcQQJR8OI9Il3J2WklWAizMjxgxDZiX5KpCHgoFCG85SJ1dxXMiF/j/dUFF
         ghrrimv5U91azS1y+8DI427OORIT+hLeJqGg2pUMkxESZARlRppje6v/Nuv5o7/8jDtP
         ShgdfX7RlfoJorJpVuZKVjnbQkrGWI5evZ5FrclocdTMKTFsOH/xwdC7sGy5u1oRDdVl
         tkps9pEDHg++p4nxtvUQKrK9jlj4XeXlZUEc35SknPvjN02AokemlXhRiXNrZxAWysmz
         DWvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795028887; x=1795633687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HSAuNGVPW83IAHegUxpYQDB5M1FUQrweL8TNZQMYOnQ=;
        b=yyjhiv35yP0G10+YIVxTHfEbwOC6VNCiR7z7FMbsKfRjbX/Y9Z3ze2jbW1Gmc2RKKM
         fJwZ11ZKtFJ8LVZx1NOpUqrZ6fKrPK6dWtVYGWcby6uCqoJi5FbeglsOjOZ/ORWM710J
         6Yd0s/9PubAv42e0QszjvhYsTnXqtezbla57Uxe43lRAmrqzyo96dEjhnjzlVIS9TTh7
         llV8Za5cEUM+tXT5I5i9A/jKd/4B03Yh6nm/EcOY7OmL7kdTb/iQaP73zIOwii9Rh11L
         Emvn4tM1AU83Hx6ekdVn4n2YmOsT9scxJ1cLEPZteDkeZVEbEgI7O8bJGLwl/hUcLKpM
         KrkQ==
X-Gm-Message-State: APuU4Z8nkZp1/xVim96OqkNEelLwD5JaL/4L85YxvQjS+VVHAX0bOjaU
	MN5zlxADgkEw37xNq+n+qBVjyg54KfJoWSOz4dgk7MkQ+b2OKodDckqGqT53Kg==
X-Gm-Gg: AZFdTZeVmGopBsEQdu1Ast2jEA0Cmp5BV8dLfVvBCLh5Od63Y3PcKsyBrYpgsaVQMK7
	fJd0r8/OkYmYlA0qOrCXubEUaAgvKBUhShkEKYVrnFIXC3Xl9oQWE43JAXfsWSrNrr6DXppZYja
	4WMdxTAxjjP1l0sALiKi2rmKe28SBj9PlNhkoxt9Oezl2yKKtpJRsSG/U6Ogdvt8aY56gxsmC4c
	CQ52P/xrGxPGFVjfSkFVolhga7OkoXP5Ki6uGPy+9a9MYXfEOBtziTpj9PQDUUJAVu9iyu57U0J
	UO0CvGAlepAn2Eeamaokegb3B8ByX3ajlc08IgmnzfVoHlgctY823bU24uceFzWamQKMNetJEk4
	o1E6JPGCY9NQeToyPZ2P62KT3hvLT9LvUPzh9r2nilMdDMcv1RMCNW2XipQLit6zojUo/slX5wj
	0KaPKxHBOzky1AMInEaEFdrcz2O1k365K/S2QqYfQyLRoJe1ajuZ/BHI7iV4yeNP/8y2j1Ui3LJ
	AGeF3iZveUGu3jVrWvUC7I9029JIv1G/Diue4c+Necq/bn3S1u7kngNjXtAKfRAAQtNPVh7hjvC
	16lxbNIO7v0S8Fd6ujclVuksAZKOyBeK9EugMvjJWocn+hJxQMZfh+AR4Aa7SeExCe9EeCRK
X-Received: by 2002:a05:7300:cd90:b0:36c:a154:db1d with SMTP id 5a478bee46e88-3827d8222b6mr4623352eec.4.1795028887042;
        Wed, 18 Nov 2026 11:08:07 -0800 (PST)
Received: from HP-V15.xu.edu.in ([125.22.10.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a680032dsm9065155eec.10.2026.11.18.11.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 11:08:06 -0800 (PST)
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	mail@thomasbachem.com,
	ps@pks.im,
	ttaylorr@openai.com,
	Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Subject: [PATCH v4 1/2] maintenance: handle lock acquisition failures correctly
Date: Wed, 18 Nov 2026 19:07:34 +0000
Message-ID: <20261118190735.3928-2-pushkarkumarsingh1970@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261118190735.3928-1-pushkarkumarsingh1970@gmail.com>
References: <20261104173422.20725-1-pushkarkumarsingh1970@gmail.com>
 <20261118190735.3928-1-pushkarkumarsingh1970@gmail.com>
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

When git maintenance run fails to acquire objects/maintenance.lock,
the failure should be handled appropriately depending on the invocation:

- Explicit manual maintenance should report an error and return a
  non-zero exit status, or suppress the diagnostic when --quiet is set.
- Automatic maintenance (--auto) and scheduled maintenance (--schedule)
  should remain non-fatal and exit successfully (0) to avoid failing
  routine background runs when another maintenance process holds the lock.
- For automatic maintenance, print a warning diagnostic unless --quiet
  is set, while scheduled maintenance remains silent.

Use unable_to_lock_message() to format error and warning diagnostics,
and check opts->schedule to distinguish scheduled invocations from
manual runs.

In addition, pass --no-auto-maintenance to child fetch invocations in
fetch_remote() to prevent the prefetch task from triggering nested
automatic maintenance while the parent process holds the lock.

Add tests in t/t7900-maintenance.sh covering manual, quiet, automatic,
and scheduled lock acquisition handling, as well as prefetch child fetch
arguments.

Signed-off-by: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
---
 builtin/gc.c           | 23 +++++++++++++++++------
 t/t7900-maintenance.sh | 40 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 55 insertions(+), 8 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 81cecf6b6c..d423b68cce 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -902,6 +902,7 @@ static int fetch_remote(struct remote *remote, void *cbdata)
 	strvec_pushl(&child.args, "fetch", remote->name,
 		     "--prefetch", "--prune", "--no-tags",
 		     "--no-write-fetch-head", "--recurse-submodules=no",
+		     "--no-auto-maintenance",
 		     NULL);
 
 	if (opts->quiet)
@@ -1402,18 +1403,28 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts,
 	enum auto_gc_hook_result auto_gc_hook_result = AUTO_GC_HOOK_UNDECIDED;
 
 	if (repo_hold_lock_file_for_update(r, &lk, lock_path, LOCK_NO_DEREF) < 0) {
+		int err = errno;
+
 		/*
 		 * Another maintenance command is running.
 		 *
 		 * If --auto was provided, then it is likely due to a
-		 * recursive process stack. Do not report an error in
-		 * that case.
+		 * recursive process stack. If --schedule was provided,
+		 * another scheduled run is already running. Do not
+		 * report an error in either case.
 		 */
-		if (!opts->auto_flag && !opts->quiet)
-			warning(_("lock file '%s' exists, skipping maintenance"),
-				lock_path);
+		if (!opts->quiet) {
+			struct strbuf buf = STRBUF_INIT;
+
+			unable_to_lock_message(lock_path, err, &buf);
+			if (opts->auto_flag)
+				warning("%s", buf.buf);
+			else if (!opts->schedule)
+				error("%s", buf.buf);
+			strbuf_release(&buf);
+		}
 		free(lock_path);
-		return 0;
+		return (opts->auto_flag || opts->schedule) ? 0 : -1;
 	}
 	free(lock_path);
 
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 9d610a29fe..4e519e4a5d 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -327,9 +327,10 @@ test_expect_success 'prefetch multiple remotes' '
 	test_commit -C clone1 one &&
 	test_commit -C clone2 two &&
 	GIT_TRACE2_EVENT="$(pwd)/run-prefetch.txt" git maintenance run --task=prefetch 2>/dev/null &&
-	fetchargs="--prefetch --prune --no-tags --no-write-fetch-head --recurse-submodules=no --quiet" &&
+	fetchargs="--prefetch --prune --no-tags --no-write-fetch-head --recurse-submodules=no --no-auto-maintenance --quiet" &&
 	test_subcommand git fetch remote1 $fetchargs <run-prefetch.txt &&
 	test_subcommand git fetch remote2 $fetchargs <run-prefetch.txt &&
+	test_subcommand ! git maintenance run --auto <run-prefetch.txt &&
 	git for-each-ref refs/remotes >actual &&
 	test_must_be_empty actual &&
 	git log prefetch/remotes/remote1/one &&
@@ -345,7 +346,10 @@ test_expect_success 'prefetch multiple remotes' '
 	git config remote.remote1.skipFetchAll true &&
 	GIT_TRACE2_EVENT="$(pwd)/skip-remote1.txt" git maintenance run --task=prefetch 2>/dev/null &&
 	test_subcommand ! git fetch remote1 $fetchargs <skip-remote1.txt &&
-	test_subcommand git fetch remote2 $fetchargs <skip-remote1.txt
+	test_subcommand git fetch remote2 $fetchargs <skip-remote1.txt &&
+
+	git maintenance run --task=prefetch --no-quiet 2>err &&
+	test_must_be_empty err
 '
 
 test_expect_success 'loose-objects task' '
@@ -387,6 +391,38 @@ test_expect_success 'loose-objects task' '
 	test_cmp packs-between packs-after
 '
 
+test_expect_success 'auto maintenance warns when lock exists' '
+	test_when_finished "rm -f err .git/objects/maintenance.lock" &&
+	: >.git/objects/maintenance.lock &&
+	git maintenance run --auto --no-quiet 2>err &&
+	test_grep "Unable to create.*maintenance\.lock" err &&
+	test_path_is_file .git/objects/maintenance.lock
+'
+
+test_expect_success 'manual maintenance fails with existing lock' '
+	test_when_finished "rm -f err .git/objects/maintenance.lock" &&
+	: >.git/objects/maintenance.lock &&
+	test_must_fail git maintenance run --no-quiet 2>err &&
+	test_grep "maintenance\.lock" err &&
+	test_path_is_file .git/objects/maintenance.lock
+'
+
+test_expect_success 'manual maintenance with --quiet suppresses diagnostic' '
+	test_when_finished "rm -f err .git/objects/maintenance.lock" &&
+	: >.git/objects/maintenance.lock &&
+	test_must_fail git maintenance run --quiet 2>err &&
+	test_must_be_empty err &&
+	test_path_is_file .git/objects/maintenance.lock
+'
+
+test_expect_success 'scheduled maintenance skips with existing lock' '
+	test_when_finished "rm -f err .git/objects/maintenance.lock" &&
+	: >.git/objects/maintenance.lock &&
+	git maintenance run --schedule=hourly 2>err &&
+	test_must_be_empty err &&
+	test_path_is_file .git/objects/maintenance.lock
+'
+
 test_expect_success 'maintenance.loose-objects.auto' '
 	git repack -adk &&
 	GIT_TRACE2_EVENT="$(pwd)/trace-lo1.txt" \
-- 
2.53.0

