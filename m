Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6862257A
	for <git@vger.kernel.org>; Thu, 25 Jan 2024 20:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706215985; cv=none; b=ZKLiw65S9QenU+WoaTLhwJAkpqHqlaAuM9MTrejAJ5a/UuCBvYQFEUCIG03V7S8f+zP1rKI1/13H9g/oNJbO9vkxlquWxBB9jJc58JhU8DPNkYHeO58X7JsdzJJt3c1jpVu9UUE0z8myvU3YKCwA7HySVcEBQ2pXzQAhHVLvPqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706215985; c=relaxed/simple;
	bh=3D2xRA9SJyUSHvcB3BezxmWDWCYdoGfClkcvGaEUyW4=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ofLy43rL9nR74tZp/6RjJCl9869kqzEFsBkjiPFYe5dUtxtxHOuW2CKPHKIBgrUFYxsNltOQJH6ePD+HdhELDD/vHYeIA/wAe+vsqi5cR5Lx6bkvTNKYZFw3kH6+FczSiII+R6JzET/o9LJdp1uiX2jc1qm1IF6rvKrf37UpZPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AojSo58H; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AojSo58H"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3392d417a9fso3343319f8f.1
        for <git@vger.kernel.org>; Thu, 25 Jan 2024 12:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706215981; x=1706820781; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ylBWPrjeGrWVrQ7sjNX/8Cwv12rkDt1RmSAQA0j3IrY=;
        b=AojSo58HEofUnkyMaGlkxwJl/nludtWZFGTBZsAI3Ar3M35+j0SPmUAyk2zeev/zoa
         0sws0KCFPybN8n6wt0U1n5tMmVaY4+NIX+MluklG0NHSf4VSbtfz+aktCMudkFif1+n/
         lUkY1FhTWqH4rUXoqamgtlWsNHV9Mmtdjgv/iAxFxlkLjaIoD/xCwOShoVxETDi1cnKX
         6be5RL4Gl8YNs4h1fv+mn2MTC/1c11qX2cEN36/w2qabp+kg0BkD65fYuU3MuANHPRpK
         hNkyFNtjp++7/ADwGX60ofpJthALLTFUhr3DcTvL3YYcXM40ymeNrNgdosSoUGbOLOB5
         qM4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706215981; x=1706820781;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ylBWPrjeGrWVrQ7sjNX/8Cwv12rkDt1RmSAQA0j3IrY=;
        b=Tt6TLZ4cUpboT+MPCbQ5LPnm8EX+FlEmNYRJKK7YiwB89PkDV115fihfFmafjT6kyw
         vRFHsabFTy6+4+VMmQre/q+kb0tC0B9B6U8KNmWT2ypXRe0qfrNFbQNow9n5aDgLp5Um
         6U2K3JHfzApYaHyhrb10ua8CKqPqJXTO1TpZQOReHW6S6DZwhWFTAz3JuXyLCa2DTkqn
         v+T7IBFhQ3GycusIbmlrS+7kaT7fiFOjulqqxNd5stLncc/EeHcq9CBDEKH0wHUiAFZw
         qbunZDAEdrQV/6WzZfwCEWRFAHYuzuqUJXsZdI+jRVEy67b2vShUSo7+YsDFLYkPlE8j
         E0rQ==
X-Gm-Message-State: AOJu0Yx9QIXN5nR/M6D5JVRHNsAHU7Ju3vDDOyhKkO5UFjVt1A6n1ZJW
	TDfrvgvbUM42I9HvlA/EuFP3B5CdoG5p/Ynfn/xq9EUAEF7k6sBaY7eDUkwc
X-Google-Smtp-Source: AGHT+IFSZdCf1IN1nxulk8gubgkuPgSXbhv3Ud7J8vj6miuI3kv4cEzn9z9fuqchxKJNFeA6td6NSQ==
X-Received: by 2002:a5d:42c5:0:b0:339:37a2:7328 with SMTP id t5-20020a5d42c5000000b0033937a27328mr185020wrr.15.1706215980878;
        Thu, 25 Jan 2024 12:53:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t8-20020adff048000000b003366c058509sm13562207wro.23.2024.01.25.12.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 12:52:59 -0800 (PST)
Message-ID: <9b353aff73d6351b86cc7b55982f1565e76d08e9.1706215884.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1658.git.git.1706215884.gitgitgadget@gmail.com>
References: <pull.1658.git.git.1706215884.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 25 Jan 2024 20:51:23 +0000
Subject: [PATCH 1/2] index-pack: test and document --strict=<msg>
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
Cc: John Cai <johncai86@gmail.com>,
    John Cai <johncai86@gmail.com>

From: John Cai <johncai86@gmail.com>

5d477a334a (fsck (receive-pack): allow demoting errors to warnings,
2015-06-22) allowed a list of fsck msg to downgrade to be passed to
--strict. However this is a hidden argument that was not documented nor
tested. Though true that most users would not call this option
direction, (nor use index-pack for that matter) it is still useful to
document and test this feature.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 Documentation/git-index-pack.txt |  9 +++++++--
 builtin/index-pack.c             |  2 +-
 t/t5300-pack-object.sh           | 22 ++++++++++++++++++++++
 3 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index-pack.txt
index 6486620c3d8..14f806d07d1 100644
--- a/Documentation/git-index-pack.txt
+++ b/Documentation/git-index-pack.txt
@@ -79,8 +79,13 @@ OPTIONS
 	to force the version for the generated pack index, and to force
 	64-bit index entries on objects located above the given offset.
 
---strict::
-	Die, if the pack contains broken objects or links.
+--strict[=<msg-ids>]::
+	Die, if the pack contains broken objects or links. If `<msg-ids>` is passed,
+	it should be a comma-separated list of `<msg-id>=<severity>` elements where
+	`<msg-id>` and `<severity>` are used to change the severity of some possible
+	issues, eg: `--strict="missingEmail=ignore,badTagName=error"`. See the entry
+	for the `fsck.<msg-id>` configuration options in `linkgit:git-fsck[1] for
+	more information on the possible values of `<msg-id>` and `<severity>`.
 
 --progress-title::
 	For internal use only.
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 1ea87e01f29..1e53ca23775 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -24,7 +24,7 @@
 #include "setup.h"
 
 static const char index_pack_usage[] =
-"git index-pack [-v] [-o <index-file>] [--keep | --keep=<msg>] [--[no-]rev-index] [--verify] [--strict] (<pack-file> | --stdin [--fix-thin] [<pack-file>])";
+"git index-pack [-v] [-o <index-file>] [--keep | --keep=<msg>] [--[no-]rev-index] [--verify] [--strict[=<msg-ids>]] (<pack-file> | --stdin [--fix-thin] [<pack-file>])";
 
 struct object_entry {
 	struct pack_idx_entry idx;
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index d402ec18b79..9563372ae27 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -441,6 +441,28 @@ test_expect_success 'index-pack with --strict' '
 	)
 '
 
+test_expect_success 'index-pack with --strict downgrading fsck msgs' '
+	test_when_finished rm -rf strict &&
+	git init strict &&
+	(
+		cd strict &&
+		test_commit first hello &&
+		cat >commit <<-EOF &&
+		tree $(git rev-parse HEAD^{tree})
+		parent $(git rev-parse HEAD)
+		author A U Thor
+		committer A U Thor
+
+		commit: this is a commit wit bad emails
+
+		EOF
+		git hash-object --literally -t commit -w --stdin <commit >commit_list &&
+		PACK=$(git pack-objects test <commit_list) &&
+		test_must_fail git index-pack --strict "test-$PACK.pack" &&
+		git index-pack --strict="missingEmail=ignore" "test-$PACK.pack"
+	)
+'
+
 test_expect_success 'honor pack.packSizeLimit' '
 	git config pack.packSizeLimit 3m &&
 	packname_10=$(git pack-objects test-10 <obj-list) &&
-- 
gitgitgadget

