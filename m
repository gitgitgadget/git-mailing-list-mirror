Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3761E231E
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 01:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752716064; cv=none; b=EjUDPT47TT30w6FK7j1GnkrSj1GUMA9GB4bxRJ9NmcS1q+hzcR9ORM2YSLEduJd89R+E08vQQJUvjVF7xCZniKDKAfieeCqvBXw+p8St/vU+TtJUKdDUJdp4QvbdQocStvBrnml78P6CXVCclwr531cYu8wHDQStNPYvs+q2U2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752716064; c=relaxed/simple;
	bh=JTh8M+w5HYpwX6KpwF3z1lXt1DeMGvtnY3IxTw8xUsw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=q5N5jvMJB9phzApJNcFWk563thGv/at6M6hiw0/sGPwNsj+mscnPb5HWzM045oku2OgkO+knPQGAGuNMPd3VAZiGnJndK57lNHgh75jLjyes1YRmG/C/wlRjopamkSHO1F4AJRRTv8k/pK6vKlT5XDXBsdZtEk1AYqSD1RLtYBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R3TTHQBB; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3TTHQBB"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a4fb9c2436so234605f8f.1
        for <git@vger.kernel.org>; Wed, 16 Jul 2025 18:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752716061; x=1753320861; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SK3ralSKBR0bnc85IAzrhJp16JQCsbClx75XK9VHCKM=;
        b=R3TTHQBBycwdYwH6qkKATjgsHwWQHCgZMCEkf05nnDZdz8W1HUGOU/12e6u54li63t
         dss9w1oMtvX10MNebsXGcZgdMq79bK6lfdWc00TcjYIRA9iN5MMQ7zf7Ct4fPVpTM2iQ
         TIh8Rfp1uTD2FNu005mqSOIYbZKi8PC4rIQ7v9U7RNN60Se0YtlQqjW8KgOvjSzwUqun
         HF6tH9DAwBvTswffpd+/pxOlpGlAQyhzqwnhital1l7xJtc0MZGSm6gjF/57bi6bni++
         JhYlDDREIRGSjfUs6nDTNXARoby9/4is9Jkjh47RYNUbE+1r8EdDetpPWHH9v029fJz3
         n1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752716061; x=1753320861;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SK3ralSKBR0bnc85IAzrhJp16JQCsbClx75XK9VHCKM=;
        b=agtd7aUxcNfaMx1S1QbX6QzX0C7u4FuyGBZw6TOX1oaPP52Li0CjWq9f8jGLhQ1E58
         neeZwJ5n/X92ndpV/Sl23lJJAw8KhJC7Knbf2y3Yf3s4T2XXSaLGVS5qdguLukwnU7TG
         ZYSfIkuxTHaC2n3QbBL2J59tWHkHeFCUx7B4Aaulp6zVoYGjW8WYqIxNoTNwBj2X2B3m
         trXvjbjMi1GMnvbaNMrjjbO7BtMZ+MLvOoGoCe91ce0ykOjZTDtPfdhGdUaRXJ6OF2nh
         LnUgNqZqaVsg7W2yDBxex52hx5KnWQyDAzMs4j4zK4r8mWj0CrzGXFKAD+boGf3MgFqS
         swRg==
X-Gm-Message-State: AOJu0YzIMdVUuHcwByRElrBeEDi5SIwW4VUYZ5U2YAjJGgJeEKy7wq/b
	GyqtjRA/U7/wuFcyO77Iixulgq3xtrueaio50WIvHDw+V0Y7uzqCswYJ584y2Q==
X-Gm-Gg: ASbGncu1KZMm399cz04tt8SrRAhtExD7ETjQmwlYJ1REWr8RpkKrjKdDheKDbpxzQV5
	IjEcZVyq7wobvhWB9fT2/+pxxCNBxz2QROut+iquk+zFjwd//QHkoUspbYyK4viUAVtBeMxKHKP
	Ve6Knb4hCxUhxWoJWGyGy9bZPaRmcYBiAEK7ktaOhtzJaMZIMioyws/Qk87D94fKUcMiTg9WKmJ
	X4jlS8qJfrdni1KvyyZDRClKYopi202sPoBNe8MKwPUaP55jkdpn+Wz3fV/rjwc/tc7UcqiusmI
	8slpsubW62NB+0D4DfSW0M8GSRtHcKZm2IdZBStvA1CQfiv+pmgZr1BUX0JYDPPRWDCLqTF1PGl
	hAmYpE2vS4wfP3YvGoLQBkq0=
X-Google-Smtp-Source: AGHT+IElxF+13DFtioRpNpiRp56W5eeDOylO9RMHskK46fAezbI1aw1C0LatMqqafP8lCTF1Cln1QQ==
X-Received: by 2002:a05:6000:1acf:b0:3a4:ea8f:efe4 with SMTP id ffacd0b85a97d-3b60dd517bfmr3583073f8f.18.1752716060686;
        Wed, 16 Jul 2025 18:34:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e886104sm36188085e9.25.2025.07.16.18.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 18:34:20 -0700 (PDT)
Message-Id: <f464bb5ed6be91940c3abb54b77cb7b9d893bd67.1752716054.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1941.v2.git.1752716054.gitgitgadget@gmail.com>
References: <pull.1941.git.1751973594.gitgitgadget@gmail.com>
	<pull.1941.v2.git.1752716054.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 17 Jul 2025 01:34:11 +0000
Subject: [PATCH v2 5/8] sparse-checkout: add --verbose option to 'clean'
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    newren@gmail.com,
    Patrick Steinhardt <ps@pks.im>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The 'git sparse-checkout clean' subcommand is focused on directories,
deleting any tracked sparse directories to clean up the worktree and
make the sparse index feature work optimally.

However, this directory-focused approach can leave users wondering why
those directories exist at all. In my experience, these files are left
over due to ignore or exclude patterns, Windows file handles, or
possibly merge conflict resolutions.

Add a new '--verbose' option for users to see all the files that are
being deleted (with '--force') or would be deleted (with '--dry-run').

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/git-sparse-checkout.adoc |  5 +++++
 builtin/sparse-checkout.c              | 28 ++++++++++++++++++++++++--
 t/t1091-sparse-checkout-builtin.sh     | 14 ++++++++++---
 3 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-sparse-checkout.adoc b/Documentation/git-sparse-checkout.adoc
index 823a66c40bc5..604f53f77caf 100644
--- a/Documentation/git-sparse-checkout.adoc
+++ b/Documentation/git-sparse-checkout.adoc
@@ -128,6 +128,11 @@ The `--dry-run` option will list the directories that would be removed
 without deleting them. Running in this mode can be helpful to predict the
 behavior of the clean comand or to determine which kinds of files are left
 in the sparse directories.
++
+The `--verbose` option will list every file within the directories that
+are considered for removal. This option is helpful to determine if those
+files are actually important or perhaps to explain why the directory is
+still present despite the current sparse-checkout.
 
 'disable'::
 	Disable the `core.sparseCheckout` config setting, and restore the
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index fe332ff5f941..f38a0809c098 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -930,6 +930,26 @@ static char const * const builtin_sparse_checkout_clean_usage[] = {
 	NULL
 };
 
+static int list_file_iterator(const char *path, const void *data)
+{
+	const char *msg = data;
+
+	printf(msg, path);
+	return 0;
+}
+
+static void list_every_file_in_dir(const char *msg,
+				   const char *directory)
+{
+	struct strbuf path = STRBUF_INIT;
+
+	strbuf_addstr(&path, directory);
+	fprintf(stderr, "list every file in %s\n", directory);
+
+	for_each_file_in_dir(&path, list_file_iterator, msg);
+	strbuf_release(&path);
+}
+
 static const char *msg_remove = N_("Removing %s\n");
 static const char *msg_would_remove = N_("Would remove %s\n");
 
@@ -940,12 +960,13 @@ static int sparse_checkout_clean(int argc, const char **argv,
 	struct strbuf full_path = STRBUF_INIT;
 	const char *msg = msg_remove;
 	size_t worktree_len;
-	int force = 0, dry_run = 0;
+	int force = 0, dry_run = 0, verbose = 0;
 	int require_force = 1;
 
 	struct option builtin_sparse_checkout_clean_options[] = {
 		OPT__DRY_RUN(&dry_run, N_("dry run")),
 		OPT__FORCE(&force, N_("force"), PARSE_OPT_NOCOMPLETE),
+		OPT__VERBOSE(&verbose, N_("report each affected file, not just directories")),
 		OPT_END(),
 	};
 
@@ -987,7 +1008,10 @@ static int sparse_checkout_clean(int argc, const char **argv,
 		if (!is_directory(full_path.buf))
 			continue;
 
-		printf(msg, ce->name);
+		if (verbose)
+			list_every_file_in_dir(msg, ce->name);
+		else
+			printf(msg, ce->name);
 
 		if (dry_run <= 0 &&
 		    remove_dir_recursively(&full_path, 0))
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 69f5a6dcc689..9a89b902c3f5 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -1052,9 +1052,9 @@ test_expect_success 'check-rules null termination' '
 
 test_expect_success 'clean' '
 	git -C repo sparse-checkout set --cone deep/deeper1 &&
-	mkdir repo/deep/deeper2 repo/folder1 &&
+	mkdir -p repo/deep/deeper2 repo/folder1/extra/inside &&
 	touch repo/deep/deeper2/file &&
-	touch repo/folder1/file &&
+	touch repo/folder1/extra/inside/file &&
 
 	test_must_fail git -C repo sparse-checkout clean 2>err &&
 	grep "refusing to clean" err &&
@@ -1071,7 +1071,15 @@ test_expect_success 'clean' '
 	git -C repo sparse-checkout clean --dry-run >out &&
 	test_cmp expect out &&
 	test_path_exists repo/deep/deeper2 &&
-	test_path_exists repo/folder1 &&
+	test_path_exists repo/folder1/extra/inside/file &&
+
+	cat >expect <<-\EOF &&
+	Would remove deep/deeper2/file
+	Would remove folder1/extra/inside/file
+	EOF
+
+	git -C repo sparse-checkout clean --dry-run --verbose >out &&
+	test_cmp expect out &&
 
 	cat >expect <<-\EOF &&
 	Removing deep/deeper2/
-- 
gitgitgadget

