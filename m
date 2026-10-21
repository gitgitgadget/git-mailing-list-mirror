Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792581750;
	b=l1sK3sLNo9MMkk7o3bPNZjfT+QQGbCRyLkwR6XQFwVRX0JxnIgFAeIDwe6OjQlEQEKs0
	 JH0/FbFf4hSQCdI8gWnKR3BLsx3qMKyP1vDgCV4rVT+gEGFfVI4lQUtrq4YwmYdL7aJ6B
	 k3kYlez5aeVxuDx4JN+dJ2qRZQClGh07BU4JvSG2DqRWkYM0beVIeG1RwPUa84y6HT7Wd
	 ISeyvcAbhMtyBMsxAIzJdCxgOtUGTr11byRrb+mCXJa1iRTFsnVzNBvVj8rNNaxPu9vSQ
	 f5qjp874sDtQje0L8rAEyE6C+rjaBIlETeDdHgGsS6a2y1FBWbrx7ZY6Zj4aXiJcMlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792581750;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=9/SoSFwXY3w0jifx5GDQGkcEBD7pUsbS3N3CpluRPso=;
	b=f7Gbmq7nrsO1oSTXJ+YrgTQSeuTTyOa6FS36SZzBfDxeIBzeaz82EI8DY0drV8HoV4UN
	 QuW50Dvj62sDZK3aRN9uXFMIJ73AYWr03+6dPNeftamQyTgQsg8600AO6ih9EsCZoCHBF
	 YdP1FgfNWk81r51+70tb8QnFes/dWf213hClCgTlNGQcWVeQQDKsOjHJ2wQTLMlBCOSBx
	 kiC0q3dQYxsUJSu4Ohqqgxc4wOTDrvW2d30ea7aLJ7N2oB3aVGvZd2d/z5k/Lc8L/hXb+
	 qoGN3SxO29796IOswZScP+MiAJ5ZejT+bT7H1IursxUMxuNiK24GFtsvlm53CuFSf0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=M9cSoLsv;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCCA606A32A
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 11:22:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FCCA606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=M9cSoLsv
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e5d0ee1951so3922995ad.0
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 04:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792581750; x=1793186550; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9/SoSFwXY3w0jifx5GDQGkcEBD7pUsbS3N3CpluRPso=;
        b=M9cSoLsvZWmvwzoCSjM0n0qUbMMEa9Ab+h1V3FN+d2AvB8wJxuBGyIUYGDiPGf8HSe
         rP9YJAuIubEdHVzM/DaRTiyKnE1ULxVwLpfZ1xs13t50mzsTTANC2/KU9qtfaJulR7vh
         JM8vRON8x7ZmhRzXo3LvKwbfKw3Sing5TE+IKwegTPNfV8P+4vSjVjYLtgtg8Czhstpe
         HWnAk9ODdLmiBZBWEnmKOZBsg7Cxjr21K7q0w/VXAE9of6u3W3rFgNUZM38fNUgYqRAy
         TfErSvaE6yNXv3lnxit4bHnuZ4+nLrJtDPk2RjEzPTBWTieOZppZWTphxa5aArgtYu8T
         pCYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792581750; x=1793186550;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9/SoSFwXY3w0jifx5GDQGkcEBD7pUsbS3N3CpluRPso=;
        b=GjQsUlZuPoukv8ZQ3iyukzFST2yyuOC9zk0n0zR+Z35Z8NjXulOLLhC6Oq1gqmmRyq
         Mb55NZjXLBT/jFDP7P1xifBdNrYDPLuQiNN/5cdRUib+iSMcNNuTdthLxylIjdiiJiMD
         dKOG7DHtu41DqIAzpkFhGfjBt4lfRicTAA9lFlzwTDt/coWShFr0F5U6OZaiQgd4hsff
         xGAU/kb9PEHUwOGl8IdNrpDJldKDN+XG36brj7Xcq7QGes6mz8raf92MQJCsl6z/yNGQ
         DZzPtIy9X6bs0KBPptd3jk/qPrF8dajutzN26iVdq1LewRs9wW0e9TpA+xvjRpz6myfU
         3BaA==
X-Gm-Message-State: AFq9FYLj+1Ag8v0Fpziuazlg4R1Bg2CrjCibKUsnXc4PRfpuRbqLh9Wn
	mnhpieOVv6Mkrru2wn8v7E9i0FQDypJCQT2ITttJxeXzXnTGQxMx7NrzvzpfhQ==
X-Gm-Gg: AYBFou2z83Nt4rqy3LsAnf+3YUZxeoZaqrOpLXrT3lGxcKvMoSHkHufSzufZv7SkXBG
	PTl5mCQuGj68Xwj6Wdy+O98C3Pp25J/t5kHkfgRyZiusczUN8vLvuz0JeIh35FS46U8GRDOu9st
	tnWveYGO/Bj/FImypkB+tUagS1o1HAvhpDtCKvqLX0PuFzrzvIDfUfjoZu0qtXa0SenAye1OWhN
	MTLpjMBmPh727IUTj01yyLRRxv+f2fGaiv/L7Ukk5bG5Z67WdeDK/bASBJjq7drNWSTOpgPLE+u
	DW5SDidgv6ctyOz19IlauSka9A+MlMcgf8yPTf8d9YZ5Kk+wgnSA1Hs5T2fSGSn7+Qasdybyifj
	Vn/F28LiH74H51cUPpWeteCtdfOROS9H1xgDec2fu33Rq/LDchEnUoIiOyITNYX85Fiv4sTOvB7
	JCUYOWZtZCEdNQaxTxknJXSjjNWjdG9HFUgM0+O3Utk6/89xO3xMKwcwNIBOurOVEsvp4pHGEBN
	IXB7AC5vKhZtoD8HJ2L1ia+ET1wD+KaBvRABJ/jKEf4QWGbA4QjxqT+8trijFfv6BbfmkCSL04r
	lA==
X-Received: by 2002:a17:903:1585:b0:2e8:1910:e398 with SMTP id d9443c01a7336-2ea43a13f95mr15120445ad.9.1792581749699;
        Wed, 21 Oct 2026 04:22:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.83.42.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b43524esm10323515ad.37.2026.10.21.04.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 04:22:29 -0700 (PDT)
Message-Id: <427b7315a5167f4b5546a08c851a4aa222fcc2f6.1792581744.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2211.v4.git.1792581744.gitgitgadget@gmail.com>
References: <pull.2211.git.1789379276.gitgitgadget@gmail.com>
	<pull.2211.v4.git.1792581744.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 21 Oct 2026 11:22:20 +0000
Subject: [PATCH v4 2/6] p5413: add perf tests for connectivity check
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Kristofer Karlsson <krka@spotify.com>,
    Patrick Steinhardt <ps@pks.im>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

Add benchmarks for the rev-list connectivity check.  Each fixture
varies one dimension: total tree size, incoming commit count, or
files changed per commit.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 ...enerate-repo-p5413-connectivity-check.perl | 44 ++++++++++
 t/perf/p5413-connectivity-check.sh            | 85 +++++++++++++++++++
 2 files changed, 129 insertions(+)
 create mode 100644 t/perf/generate-repo-p5413-connectivity-check.perl
 create mode 100755 t/perf/p5413-connectivity-check.sh

diff --git a/t/perf/generate-repo-p5413-connectivity-check.perl b/t/perf/generate-repo-p5413-connectivity-check.perl
new file mode 100644
index 0000000000..bfa25f60fc
--- /dev/null
+++ b/t/perf/generate-repo-p5413-connectivity-check.perl
@@ -0,0 +1,44 @@
+#!/usr/bin/perl
+#
+# Generate a fast-import stream for p5413 connectivity check benchmarks.
+#
+# Usage: generate-repo-p5413-connectivity-check.perl
+#            <dirs> <files_per_dir> <commits> [<hot_dirs>] [<files_per_commit>]
+#
+# Creates one initial commit with dirs*files_per_dir files, then
+# <commits> additional commits each modifying <files_per_commit>
+# files in directories chosen round-robin from 1..<hot_dirs>.
+
+use strict;
+use warnings;
+
+my ($nd, $nf, $nc, $hot, $fpc) = @ARGV;
+$hot = $nd if !$hot || $hot > $nd;
+$fpc = 1   if !$fpc;
+
+sub data {
+	printf "data %d\n%s\n", length($_[0]), $_[0];
+}
+
+# Initial tree: one commit with nd*nf files.
+printf "commit refs/heads/main\n";
+printf "committer perf <perf\@test.com> now\n";
+data("initial");
+for my $d (1..$nd) {
+	for my $f (1..$nf) {
+		printf "M 100644 inline d-%04d/f-%03d\n", $d, $f;
+		data(sprintf "%03d%03d", $d, $f);
+	}
+}
+
+# Subsequent commits (auto-chained by fast-import).
+for my $i (1..$nc) {
+	printf "commit refs/heads/main\n";
+	printf "committer perf <perf\@test.com> now\n";
+	data(sprintf "change-%03d", $i);
+	for my $j (0..$fpc-1) {
+		my $d = (($i + $j) % $hot) + 1;
+		printf "M 100644 inline d-%04d/f-001\n", $d;
+		data(sprintf "c%d-%d", $i, $j);
+	}
+}
diff --git a/t/perf/p5413-connectivity-check.sh b/t/perf/p5413-connectivity-check.sh
new file mode 100755
index 0000000000..9e968d0106
--- /dev/null
+++ b/t/perf/p5413-connectivity-check.sh
@@ -0,0 +1,85 @@
+#!/bin/sh
+
+test_description='performance of connectivity check
+
+Benchmark the rev-list connectivity check, avoiding pack transfer
+noise.
+
+Each repository has a flat tree of many directories with 100 files
+in each.  Three axes are scaled independently: tree size, commit
+count, and files changed per commit.'
+
+. ./perf-lib.sh
+
+test_perf_fresh_repo
+
+generate="$TEST_DIRECTORY/perf/generate-repo-p5413-connectivity-check.perl"
+
+# $1=dirs  $2=files_per_dir  $3=commits  $4=hot_dirs (optional, default=all)
+# $5=files_per_commit (optional, default=1)
+test_perf_conn () {
+	local nd="$1" nf="$2" nc="$3" hot="${4:-$1}" fpc="${5:-1}"
+	local total=$(($nd * $nf))
+	local name="repo-${nd}d-${nf}f-${nc}c-${hot}h-${fpc}fpc"
+	local label="${total} files, ${nc} commits"
+	if test "$hot" -lt "$nd"
+	then
+		label="$label (${hot} hot dirs)"
+	fi
+	if test "$fpc" -gt 1
+	then
+		label="$label (${fpc} files/commit)"
+	fi
+
+	test_expect_success PERL "setup $label" '
+		if test -d '"$name"'
+		then
+			true
+		else
+			git init '"$name"' &&
+			"$PERL_PATH" '"$generate"' '"$nd"' '"$nf"' '"$nc"' '"$hot"' '"$fpc"' |
+			git -C '"$name"' fast-import --date-format=now --quiet &&
+			(
+				cd '"$name"' &&
+				git rev-parse main~'"$nc"' >../'"${name}"'_old &&
+				git rev-parse main >../'"${name}"'_new &&
+				git update-ref refs/heads/main \
+					$(cat ../'"${name}"'_old) &&
+				git repack -ad &&
+				git config gc.auto 0
+			)
+		fi
+	'
+
+	test_perf "$label" --prereq PERL '
+		cat '"${name}"'_new |
+		git -C '"$name"' rev-list \
+			--objects --stdin --not --all --quiet \
+			--exclude-promisor-objects
+	'
+}
+
+# Scaling tree size (10 commits, 10 files/commit).
+test_perf_conn   50 100 10   50 10
+test_perf_conn  500 100 10  500 10
+test_perf_conn 2000 100 10 2000 10
+test_perf_conn 8000 100 10 8000 10
+
+# Scaling commit count (200K files, 10 files/commit).
+test_perf_conn 2000 100    1 2000 10
+test_perf_conn 2000 100   10 2000 10
+test_perf_conn 2000 100  100 2000 10
+test_perf_conn 2000 100   500 2000 10
+test_perf_conn 2000 100  3000 2000 10
+test_perf_conn 2000 100  5000 2000 10
+test_perf_conn 2000 100 10000 2000 10
+
+# Scaling files per commit (200K files, 10 commits).
+test_perf_conn 2000 100 10 2000   1
+test_perf_conn 2000 100 10 2000  10
+test_perf_conn 2000 100 10 2000  100
+test_perf_conn 2000 100 10 2000  500
+test_perf_conn 2000 100 10 2000 1000
+test_perf_conn 2000 100 10 2000 2000
+
+test_done
-- 
gitgitgadget

