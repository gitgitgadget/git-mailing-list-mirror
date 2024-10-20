Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A469C1946AA
	for <git@vger.kernel.org>; Sun, 20 Oct 2024 13:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729431830; cv=none; b=VaktKSe80dA28zBDwazmh8c0mCQw0yMLOuVKVV2QLLawm3lPAZPqIrpsinamLhQz2xJ16Bu0dEqBPbnjkKd1ptf22MvnIYazEKWA6OlnTDqGfqci6aXku7CMwYyjxkIJyknwov8V6qTGATEkyzLvEhArqxE1cGoLa/vh05yRct0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729431830; c=relaxed/simple;
	bh=w2oLDdI6ObfQA5lE1AadEK+ROWTdtCVPIDRGsOseWH8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=cJYZE0UQy+2d1X5Arx/yHtXUxrvIziFdl7qu8fUAwnKfO7f1ZlE40cUlC5FROaVZSFswlXxkUvrXYAUNR4/MhypGpWZ6z8VdtCd6TxNcTLSY7xQ08oZ7+hT6DRByZDhT+Pxf8DKF/tOj+DVXzUgHMN9YhgBBCqJI9xo9PlnND/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KL4U6NHi; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KL4U6NHi"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7aa086b077so399350966b.0
        for <git@vger.kernel.org>; Sun, 20 Oct 2024 06:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729431826; x=1730036626; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2V8zrrz4ZTlOTS6CMVLbGbWPyogZMtXZEspg0S42tk=;
        b=KL4U6NHiDQ53XdoSRs5HaTwdYb8sUGcmuJHxzMu6xhSNxIRdMtZi4sw9yVLjZVKEMH
         wLhOW2oYGiFq3ViLf+Zjg5cwjnF+pNaZKuPtUFUFjhFgU7pVLgNdqc7dGP8bQmmsGpq2
         QIHzrzuIKUwNR9oGy648hUzJ5sEvLe24xNFf3qOZ/e4LuONXK2O4R+fkylDk9NSYVaO5
         kvBJkhXDKwt+NHeKN98oYN6FD8MxtycaBaq3jhX6xVRGXgQhf91q35tLWi56XXPdhaBM
         kN/SVf/lfeLxwm0Gw0cFo8bPrNPphr06aEYUE2BhkdjmrKghuhFCB8NWN/XiDT+a+iKz
         InsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729431826; x=1730036626;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e2V8zrrz4ZTlOTS6CMVLbGbWPyogZMtXZEspg0S42tk=;
        b=qmdC0w9ysb23fUXqlr5EI6RMfalZOkuO9/E5sCsg0x3OaUIb5N0d78386/qCtPDgKg
         RII8GkCLj3cSHkYuTEvE7+NLBpCNJ+k1eM5Rywl3PHKVlW798HyP3YO0mIH4WNC0EJNp
         sQTLejUB/tZm1STQ2W5B2taaYyuXmciK5lINE9expA/+GkFkc6QyxDzqhzxbDDcWfY4U
         BPlLAfq8WsFL5L9oPTYbB3Y9zFs8WQkDwkvW8D6UlF0HrfC9H2+2U2KZiznyCf4kyU+8
         b6YNMqVxjGaiX9kG1s0OPvSAMv06xLd9PGHhBJ59MMWYAPcVOlST5l2A7yHCcn8stcv6
         CjNg==
X-Gm-Message-State: AOJu0YzqeBVMdhDBi54h/erhDGd9saLgz4vuaDbHg6/RteE2VZaIfhXp
	Zg1MJVTUi37wqSCdUUyXCn/GXz5an3mWkLJaP3c4b4wbM+X6KPPY9Dl/AQ==
X-Google-Smtp-Source: AGHT+IE6tUgmAo8F9TDwz7SjPdq4uVUmo/3LV/WcN6sMHHl2rQ14cqtRy9Lc6knuP9bhRamrbr5Rjw==
X-Received: by 2002:a17:907:3d88:b0:a99:f8a2:cd8f with SMTP id a640c23a62f3a-a9a69cdcacamr695448766b.64.1729431826258;
        Sun, 20 Oct 2024 06:43:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91598ef6sm90988166b.192.2024.10.20.06.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 06:43:45 -0700 (PDT)
Message-Id: <834c9ea270932e3d25e2018cca4e74831345f592.1729431810.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1813.v2.git.1729431810.gitgitgadget@gmail.com>
References: <pull.1813.git.1728396723.gitgitgadget@gmail.com>
	<pull.1813.v2.git.1729431810.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 20 Oct 2024 13:43:25 +0000
Subject: [PATCH v2 12/17] repack: add --path-walk option
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
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    christian.couder@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Since 'git pack-objects' supports a --path-walk option, allow passing it
through in 'git repack'. This presents interesting testing opportunities for
comparing the different repacking strategies against each other.

In my copy of the Git repository, the new tests in p5313 show these
results:

Test                                      this tree
-------------------------------------------------------------
5313.10: repack                           27.88(150.23+2.70)
5313.11: repack size                               228.2M
5313.12: repack with --path-walk          134.59(148.77+0.81)
5313.13: repack size with --path-walk              209.7M

Note that the 'git pack-objects --path-walk' feature is not integrated
with threads. Look forward to a future change that will introduce
threading to improve the time performance of this feature with
equivalent space performance.

For the microsoft/fluentui repo [1] had some interesting aspects for the
previous tests in p5313, so here are the repack results:

Test                                      this tree
-------------------------------------------------------------
5313.10: repack                           91.76(680.94+2.48)
5313.11: repack size                               439.1M
5313.12: repack with --path-walk          110.35(130.46+0.74)
5313.13: repack size with --path-walk              155.3M

[1] https://github.com/microsoft/fluentui

Here, we see the significant improvement of a full repack using this
strategy. The name-hash collisions in this repo cause the space
problems. Those collisions also cause the repack command to spend a lot
of cycles trying to find delta bases among files that are not actually
very similar, so the lack of threading with the --path-walk feature is
less pronounced in the process time.

For the Linux kernel repository, we have these stats:

Test                                      this tree
---------------------------------------------------------------
5313.10: repack                           553.61(1929.41+30.31)
5313.11: repack size                                 2.5G
5313.12: repack with --path-walk          1777.63(2044.16+7.47)
5313.13: repack size with --path-walk                2.5G

This demonstrates that the --path-walk feature does not always present
measurable improvements, especially in cases where the name-hash has
very few collisions.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/git-repack.txt | 17 ++++++++++++++++-
 builtin/repack.c             |  9 ++++++++-
 t/perf/p5313-pack-objects.sh | 18 ++++++++++++++++++
 3 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index c902512a9e8..4ec59cd27b1 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -9,7 +9,9 @@ git-repack - Pack unpacked objects in a repository
 SYNOPSIS
 --------
 [verse]
-'git repack' [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m] [--window=<n>] [--depth=<n>] [--threads=<n>] [--keep-pack=<pack-name>] [--write-midx]
+'git repack' [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m]
+	[--window=<n>] [--depth=<n>] [--threads=<n>] [--keep-pack=<pack-name>]
+	[--write-midx] [--path-walk]
 
 DESCRIPTION
 -----------
@@ -249,6 +251,19 @@ linkgit:git-multi-pack-index[1]).
 	Write a multi-pack index (see linkgit:git-multi-pack-index[1])
 	containing the non-redundant packs.
 
+--path-walk::
+	This option passes the `--path-walk` option to the underlying
+	`git pack-options` process (see linkgit:git-pack-objects[1]).
+	By default, `git pack-objects` walks objects in an order that
+	presents trees and blobs in an order unrelated to the path they
+	appear relative to a commit's root tree. The `--path-walk` option
+	enables a different walking algorithm that organizes trees and
+	blobs by path. This has the potential to improve delta compression
+	especially in the presence of filenames that cause collisions in
+	Git's default name-hash algorithm. Due to changing how the objects
+	are walked, this option is not compatible with `--delta-islands`
+	or `--filter`.
+
 CONFIGURATION
 -------------
 
diff --git a/builtin/repack.c b/builtin/repack.c
index cb4420f0856..af3f218ced7 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -39,7 +39,9 @@ static int run_update_server_info = 1;
 static char *packdir, *packtmp_name, *packtmp;
 
 static const char *const git_repack_usage[] = {
-	N_("git repack [<options>]"),
+	N_("git repack [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m]\n"
+	   "[--window=<n>] [--depth=<n>] [--threads=<n>] [--keep-pack=<pack-name>]\n"
+	   "[--write-midx] [--full-path-walk]"),
 	NULL
 };
 
@@ -58,6 +60,7 @@ struct pack_objects_args {
 	int no_reuse_object;
 	int quiet;
 	int local;
+	int path_walk;
 	struct list_objects_filter_options filter_options;
 };
 
@@ -289,6 +292,8 @@ static void prepare_pack_objects(struct child_process *cmd,
 		strvec_pushf(&cmd->args, "--no-reuse-delta");
 	if (args->no_reuse_object)
 		strvec_pushf(&cmd->args, "--no-reuse-object");
+	if (args->path_walk)
+		strvec_pushf(&cmd->args, "--path-walk");
 	if (args->local)
 		strvec_push(&cmd->args,  "--local");
 	if (args->quiet)
@@ -1182,6 +1187,8 @@ int cmd_repack(int argc,
 				N_("pass --no-reuse-delta to git-pack-objects")),
 		OPT_BOOL('F', NULL, &po_args.no_reuse_object,
 				N_("pass --no-reuse-object to git-pack-objects")),
+		OPT_BOOL(0, "path-walk", &po_args.path_walk,
+				N_("pass --path-walk to git-pack-objects")),
 		OPT_NEGBIT('n', NULL, &run_update_server_info,
 				N_("do not run git-update-server-info"), 1),
 		OPT__QUIET(&po_args.quiet, N_("be quiet")),
diff --git a/t/perf/p5313-pack-objects.sh b/t/perf/p5313-pack-objects.sh
index 840075f5691..b588066ddb0 100755
--- a/t/perf/p5313-pack-objects.sh
+++ b/t/perf/p5313-pack-objects.sh
@@ -56,4 +56,22 @@ test_size 'big pack size with --path-walk' '
 	test_file_size out
 '
 
+test_perf 'repack' '
+	git repack -adf
+'
+
+test_size 'repack size' '
+	pack=$(ls .git/objects/pack/pack-*.pack) &&
+	test_file_size "$pack"
+'
+
+test_perf 'repack with --path-walk' '
+	git repack -adf --path-walk
+'
+
+test_size 'repack size with --path-walk' '
+	pack=$(ls .git/objects/pack/pack-*.pack) &&
+	test_file_size "$pack"
+'
+
 test_done
-- 
gitgitgadget

