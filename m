Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD131DC9B5
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 01:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752716063; cv=none; b=D0w8gMjRIBLwmfMh5aOknj71EjE1aOYylJtVjVnVWJ9Ftbir2i33rV9JJJQ+la/ce3su7lka1xN6tNHZEaVrkaFVhX26xA4WCVZJ/fmYeqY3f2oHLKfYIZ22dCTpoPoYC1QlDZBgMOptncDWKKthDTh3WDLDk4nflanG/nsOn0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752716063; c=relaxed/simple;
	bh=H+3NdWSw9oyP98/YrQ4Tgcs2z0JYwKRk4dse/FlzCzY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ZFGScJoYaqgsfKaHF2RMvrzanQRwHVW233FXERhzFgbn9lMx9cKsBv+LTEgkMDjmSkv5mtG9jQ87QM4XGazImnJlV/EW81pyKhDiOibr1kiYt+VErbaIdxvxDBv8zGpc3xoV6g4RmPTbriWNE1vqmAuutgc5gc0hAS6jelBVhFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iCq4BOzl; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCq4BOzl"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4560cdf235cso2024235e9.1
        for <git@vger.kernel.org>; Wed, 16 Jul 2025 18:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752716059; x=1753320859; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JAriC6us3aMj8k77o+kOu7R1fJVD1fmDRVuBo0mpN3g=;
        b=iCq4BOzlKaMLCdPffSTy/py2sd3YPOl326Os42RCRJURqhyNnKs/+8bNBjWHL1unK9
         G1/I8WEr1DRkE5p0Y/sr2ZZ08x4ELP4ygDuI2UYqaVnwdxggT0c1PRgm6Q3EVLKmWcmR
         GpTj6+Opl+sbvlo8Ll/5ZVD4X78l4TIEz41zqhybD6zFdHa0wpqvQpYUiBd3WGnQUOX6
         JaVSG4hBh13Nfc5/Yxd288RAbjk8vomXcNanbcF7rNEo4utrtEEbtDKe88ulJ1xkPCC2
         3CyWv3d8sCO7oEkKRP+CHrbrE1GYGcHNfmWHywKy7NjS/DPLr4Jf9rU+L7mWQAXbBsDg
         KWOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752716059; x=1753320859;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JAriC6us3aMj8k77o+kOu7R1fJVD1fmDRVuBo0mpN3g=;
        b=AmwNCjIeqijkovt0BsB6sei+R09bvrJhmcZ3GY7o/a9NnO4ARDvxhxpMuCVeYgQblk
         xHRAgngCNlSOEOQ50Hwahw96L6W3AWDoLP6DBKiF0MTnpm6gllZNVt4gItOOvlDgnb/U
         javuyaKr/UWiDWSHrubbC70a4/Ge1WlZ8r/1H/NkGCDwnHCgkpq9tHbvnTSZ6jDZ7jiI
         2aN5wTLZXdW3Ny4pXkxB8j4utcSBnsF183bx6xzgJrxoc9gynCn/VNIlvxN2HHtTOjSB
         OUcGyqI+RLWP8RDYEiY4MESPArxv9KOX6uk2gsuc5kJrtIqtxTwPAObc/Rei9UaIJv11
         1c9g==
X-Gm-Message-State: AOJu0YzNgN8XOOLB5JsyZhhO4HpAhX/5W/AZzj3GGFc8XtQV0LaX2jJK
	rka8lg6RhPTlmskUTAD/zHP/Vxvc5EqdLySUdbW/UbcbQc73ogFNiK1445nzcg==
X-Gm-Gg: ASbGnctHbOMbm9WhxbVkjy5PK3GPV1zFlFVuuvz8Bdk7URK/KCTzm7gotfOvEzRD72y
	8Vwl96ZonnzBpoGwuL05XZHGbkoJ2UCi66JVm0fJlI9YD+XGrVNsBkZU76kKFA/CLRqOmzhRgka
	UKra4JNFzi4hBn7/TnLeiS4T07eKTsPwj6+56TQjuctcs3UJmAM5hWfDfZPgw/42d4XDeozJnkA
	52Gh21U11cWI9BRO7BzPHBZAvxXHfTuuGLNhGjUoh+eO8Aph8U5y5eUURcob30Zz7XUU+lB/qNj
	92c6Y4zTc6IGKQ6STmVfSxvCLSOJVeeMybbvkQ10XYfO5nJBGb+EpaRjf1O1zzgTFQ6/R3Gb6CE
	hk3xuiJcsf00ViW2gA+Mhq/A=
X-Google-Smtp-Source: AGHT+IEsbLXaaimDVI2Ze+8ZVV6gCZb4muzUDlZpiviKr39CEQR+1jm2btZeR2THEd4CoGjcQUWRTw==
X-Received: by 2002:a05:600c:450a:b0:442:c993:6f94 with SMTP id 5b1f17b1804b1-456352e8aa8mr6589475e9.12.1752716058751;
        Wed, 16 Jul 2025 18:34:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45634f9a53asm7056185e9.30.2025.07.16.18.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 18:34:18 -0700 (PDT)
Message-Id: <221f3e5fb0c56b75f8fbfa9f4aa34ae93fad0cdb.1752716054.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1941.v2.git.1752716054.gitgitgadget@gmail.com>
References: <pull.1941.git.1751973594.gitgitgadget@gmail.com>
	<pull.1941.v2.git.1752716054.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 17 Jul 2025 01:34:09 +0000
Subject: [PATCH v2 3/8] sparse-checkout: match some 'clean' behavior
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

The 'git sparse-checkout clean' subcommand is somewhat similar to 'git
clean' in that it will delete files that should not be in the worktree.
The big difference is that it focuses on the directories that should not
be in the worktree due to cone-mode sparse-checkout. It also does not
discriminate in the kinds of files and focuses on deleting entire
directories.

However, there are some restrictions that would be good to bring over
from 'git clean', specifically how it refuses to do anything without the
'-f'/'--force' or '-n'/'--dry-run' arguments. The 'clean.requireForce'
config can be set to 'false' to imply '--force'.

Add this behavior to avoid accidental deletion of files that cannot be
recovered from Git.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/git-sparse-checkout.adoc |  9 ++++
 builtin/sparse-checkout.c              | 15 +++++-
 t/t1091-sparse-checkout-builtin.sh     | 66 +++++++++++++++++++++++++-
 3 files changed, 87 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-sparse-checkout.adoc b/Documentation/git-sparse-checkout.adoc
index 6db88f00781d..823a66c40bc5 100644
--- a/Documentation/git-sparse-checkout.adoc
+++ b/Documentation/git-sparse-checkout.adoc
@@ -119,6 +119,15 @@ all sparsity paths.
 	This command can be used to be sure the sparse index works
 	efficiently, though it does not require enabling the sparse index
   feature via the `index.sparse=true` configuration.
++
+To prevent accidental deletion of worktree files, the `clean` subcommand
+will not delete any files without the `-f` or `--force` option, unless
+the `clean.requireForce` config option is set to `false`.
++
+The `--dry-run` option will list the directories that would be removed
+without deleting them. Running in this mode can be helpful to predict the
+behavior of the clean comand or to determine which kinds of files are left
+in the sparse directories.
 
 'disable'::
 	Disable the `core.sparseCheckout` config setting, and restore the
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 6fe6ec718fe3..fe332ff5f941 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -931,6 +931,7 @@ static char const * const builtin_sparse_checkout_clean_usage[] = {
 };
 
 static const char *msg_remove = N_("Removing %s\n");
+static const char *msg_would_remove = N_("Would remove %s\n");
 
 static int sparse_checkout_clean(int argc, const char **argv,
 				   const char *prefix,
@@ -939,8 +940,12 @@ static int sparse_checkout_clean(int argc, const char **argv,
 	struct strbuf full_path = STRBUF_INIT;
 	const char *msg = msg_remove;
 	size_t worktree_len;
+	int force = 0, dry_run = 0;
+	int require_force = 1;
 
 	struct option builtin_sparse_checkout_clean_options[] = {
+		OPT__DRY_RUN(&dry_run, N_("dry run")),
+		OPT__FORCE(&force, N_("force"), PARSE_OPT_NOCOMPLETE),
 		OPT_END(),
 	};
 
@@ -954,6 +959,13 @@ static int sparse_checkout_clean(int argc, const char **argv,
 			     builtin_sparse_checkout_clean_options,
 			     builtin_sparse_checkout_clean_usage, 0);
 
+	repo_config_get_bool(repo, "clean.requireforce", &require_force);
+	if (require_force && !force && !dry_run)
+		die(_("for safety, refusing to clean without one of --force or --dry-run"));
+
+	if (dry_run)
+		msg = msg_would_remove;
+
 	if (repo_read_index(repo) < 0)
 		die(_("failed to read index"));
 
@@ -977,7 +989,8 @@ static int sparse_checkout_clean(int argc, const char **argv,
 
 		printf(msg, ce->name);
 
-		if (remove_dir_recursively(&full_path, 0))
+		if (dry_run <= 0 &&
+		    remove_dir_recursively(&full_path, 0))
 			warning_errno(_("failed to remove '%s'"), ce->name);
 	}
 
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index a48eedf766d2..69f5a6dcc689 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -1056,12 +1056,29 @@ test_expect_success 'clean' '
 	touch repo/deep/deeper2/file &&
 	touch repo/folder1/file &&
 
+	test_must_fail git -C repo sparse-checkout clean 2>err &&
+	grep "refusing to clean" err &&
+
+	git -C repo config clean.requireForce true &&
+	test_must_fail git -C repo sparse-checkout clean 2>err &&
+	grep "refusing to clean" err &&
+
+	cat >expect <<-\EOF &&
+	Would remove deep/deeper2/
+	Would remove folder1/
+	EOF
+
+	git -C repo sparse-checkout clean --dry-run >out &&
+	test_cmp expect out &&
+	test_path_exists repo/deep/deeper2 &&
+	test_path_exists repo/folder1 &&
+
 	cat >expect <<-\EOF &&
 	Removing deep/deeper2/
 	Removing folder1/
 	EOF
 
-	git -C repo sparse-checkout clean >out &&
+	git -C repo sparse-checkout clean -f >out &&
 	test_cmp expect out &&
 
 	test_path_is_missing repo/deep/deeper2 &&
@@ -1077,16 +1094,61 @@ test_expect_success 'clean with staged sparse change' '
 
 	git -C repo add --sparse folder1/file &&
 
+	cat >expect <<-\EOF &&
+	Would remove deep/deeper2/
+	EOF
+
+	git -C repo sparse-checkout clean --dry-run >out &&
+	test_cmp expect out &&
+	test_path_exists repo/deep/deeper2 &&
+	test_path_exists repo/folder1 &&
+	test_path_exists repo/folder2 &&
+
 	# deletes deep/deeper2/ but leaves folder1/ and folder2/
 	cat >expect <<-\EOF &&
 	Removing deep/deeper2/
 	EOF
 
+	# The previous test case checked the -f option, so
+	# test the config option in this one.
+	git -C repo config clean.requireForce false &&
 	git -C repo sparse-checkout clean >out &&
 	test_cmp expect out &&
 
 	test_path_is_missing repo/deep/deeper2 &&
-	test_path_exists repo/folder1
+	test_path_exists repo/folder1 &&
+	test_path_exists repo/folder2
+'
+
+test_expect_success 'clean with merge conflict status' '
+	git clone repo clean-merge &&
+
+	echo dirty >clean-merge/deep/deeper2/a &&
+	touch clean-merge/folder2/extra &&
+
+	cat >input <<-EOF &&
+	0 $ZERO_OID	folder1/a
+	100644 $(git -C clean-merge rev-parse HEAD:folder1/a) 1	folder1/a
+	EOF
+	git -C clean-merge update-index --index-info <input &&
+
+	git -C clean-merge sparse-checkout set deep/deeper1 &&
+
+	test_must_fail git -C clean-merge sparse-checkout clean -f 2>err &&
+	grep "failed to convert index to a sparse index" err &&
+
+	mkdir -p clean-merge/folder1/ &&
+	echo merged >clean-merge/folder1/a &&
+	git -C clean-merge add --sparse folder1/a &&
+
+	# deletes folder2/ but leaves staged change in folder1
+	# and dirty change in deep/deeper2/
+	cat >expect <<-\EOF &&
+	Removing folder2/
+	EOF
+
+	git -C clean-merge sparse-checkout clean -f >out &&
+	test_cmp expect out
 '
 
 test_done
-- 
gitgitgadget

