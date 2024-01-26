Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E1A22F0D
	for <git@vger.kernel.org>; Fri, 26 Jan 2024 20:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706302755; cv=none; b=Ycu0ZmvZpzq0NxfO5yK0zVNYCnsgysLzjNv2qdcOtcsUevjeiYKkIsMfrvgF8PbKvCY2LV3FxaZQs74YDxJCWtTv+2+IbWqiiB3sBAwqCin41zv9c9CmvdvuGThCxozKzDbg2y//n77KPMBkinyHrtLEnxTs8F4xDDvuwzw/ZGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706302755; c=relaxed/simple;
	bh=z73mdDzNaFG/F8/QUj7UaGTODOLyVEmawvUWo+PlGU0=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=IXr8I20tDJ37p4PqpfX3Gfpk0tPF7TWu/DW6Sagftxpzc+XEUtZY0MLljZ6enmJFJo4ugkzeaLc3fz4fWcKLEns5icc7ub5Ctk0sXcvL1fqBm9LNY6ZarbRBHrlTAWpLaTfl3qU51PTKc3tIhvYj9+rCwXhOXklbSD4lHhCGhK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RxpHOK+3; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RxpHOK+3"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40e7065b7bdso16245355e9.3
        for <git@vger.kernel.org>; Fri, 26 Jan 2024 12:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706302751; x=1706907551; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UOOZa5dwNDVldGL3UVEGbXFAIPT2xntKxgTVQVWIFGQ=;
        b=RxpHOK+3T3s97ioERBLIl8f91ZMl5ptZ95K5injDT83UCANekhOZ+2h4OLgke0uY91
         2DghA4B29DajnjqwWIt5FuWBQD4V0ainZuPqdRx2fXV0t5KzjJ2lym68MvJKPXLVuZx5
         /ObeTcPF+j1+MYTcsBotuxzkDeTti64Si/Z+zPI368vAp++tv9m4DUu7Gtt2uCXVycVK
         Ug7uQvvPNwtG6z/+2qwgBKwsCZMnlRrS296ChSLHRbO7NdFDbTRMc6AI7wS/ycNXeB2p
         g/4kH/VTRUDx0jkmm2IfDPsMu4XlVIUIbFvmuhrrGJwi15K4UDNKvUTGWvaCOx7yJ4ZN
         jQcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706302751; x=1706907551;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UOOZa5dwNDVldGL3UVEGbXFAIPT2xntKxgTVQVWIFGQ=;
        b=VQVAFxVbuztd/GTc63FFVbxEoVDBijkwId7clOOwHjSb993eIiEpV5VnJJCRHe2l7C
         66pOPOte+YRtGYmmxpLMTy2B1EpnYmPNR3EsechDSoX9S1fcwU0gkxkq1EP1Xu7DCzbO
         7vIMlU04NY2NH+ZgvNVtbkksYGs8MqXGMA25ETueYFdSKEOg7dHvBtgpMG96avVeluMl
         Q29QyNcg0zadsIE9zCzHznsvTjRDjoyWkESZISsdJ6viZ5ou5cs5oWk1/sa1teEVYAdg
         perS3/kxh1BiIGz/s3PW613jlHHIY2jOMA7r1jjVC+iKlJV8nQ158RowB6hLLNdIzlMn
         tgQw==
X-Gm-Message-State: AOJu0YwPdwLTH4o1Sd//S2uc58aRu8vbzWThLgqghde16F+VxSdTPEHC
	Ay09JITNlLdgznsFNZ5hF5RPEPpVsefdXtGM+WQ5lSHdO39E+loujjYe1f5s
X-Google-Smtp-Source: AGHT+IEHMPelmEVQS19CaAzXdjlAK8oAkesXbyJC1HwUW6+j4+F5KwjTjLzH5/IA4YWECinXeg6cWQ==
X-Received: by 2002:a05:600c:4683:b0:40e:b2f4:79d3 with SMTP id p3-20020a05600c468300b0040eb2f479d3mr219829wmo.28.1706302751326;
        Fri, 26 Jan 2024 12:59:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j9-20020a05600c190900b0040ecdd672fasm2856238wmq.13.2024.01.26.12.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 12:59:11 -0800 (PST)
Message-ID: <cdf7fc7fe8a9d5664c9fdfb85f8c9293aa446c13.1706302749.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1658.v3.git.git.1706302749.gitgitgadget@gmail.com>
References: <pull.1658.v2.git.git.1706289180.gitgitgadget@gmail.com>
	<pull.1658.v3.git.git.1706302749.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 26 Jan 2024 20:59:08 +0000
Subject: [PATCH v3 1/2] index-pack: test and document
 --strict=<msg-id>=<severity>...
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
tested. Though it is true that most users would not call this option
directly, (nor use index-pack for that matter) it is still useful to
document and test this feature.

Reviewed-by: Christian Couder <christian.couder@gmail.com>
Signed-off-by: John Cai <johncai86@gmail.com>
---
 Documentation/git-index-pack.txt |  9 +++++++--
 builtin/index-pack.c             |  2 +-
 t/t5300-pack-object.sh           | 22 ++++++++++++++++++++++
 3 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index-pack.txt
index 6486620c3d8..694bb9409bf 100644
--- a/Documentation/git-index-pack.txt
+++ b/Documentation/git-index-pack.txt
@@ -79,8 +79,13 @@ OPTIONS
 	to force the version for the generated pack index, and to force
 	64-bit index entries on objects located above the given offset.
 
---strict::
-	Die, if the pack contains broken objects or links.
+--strict[=<msg-id>=<severity>...]::
+	Die, if the pack contains broken objects or links. An optional
+	comma-separated list of `<msg-id>=<severity>` can be passed to change
+	the severity of some possible issues, e.g.,
+	 `--strict="missingEmail=ignore,badTagName=error"`. See the entry for the
+	`fsck.<msg-id>` configuration options in linkgit:git-fsck[1] for more
+	information on the possible values of `<msg-id>` and `<severity>`.
 
 --progress-title::
 	For internal use only.
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 1ea87e01f29..240c7021168 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -24,7 +24,7 @@
 #include "setup.h"
 
 static const char index_pack_usage[] =
-"git index-pack [-v] [-o <index-file>] [--keep | --keep=<msg>] [--[no-]rev-index] [--verify] [--strict] (<pack-file> | --stdin [--fix-thin] [<pack-file>])";
+"git index-pack [-v] [-o <index-file>] [--keep | --keep=<msg>] [--[no-]rev-index] [--verify] [--strict[=<msg-id>=<severity>...]] (<pack-file> | --stdin [--fix-thin] [<pack-file>])";
 
 struct object_entry {
 	struct pack_idx_entry idx;
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index d402ec18b79..496fffa0f8a 100755
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
+		commit: this is a commit with bad emails
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

