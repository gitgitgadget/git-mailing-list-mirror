Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792761125;
	b=I9cd0WncQzBV/s24GQCl0sf84ppmQb+2pNxNDsVURLVq2sQsmjcSBVVxfaLH9CCvNoOl
	 6Gs2mc0oItd0qLCBboJ2o9Xwmx50pOz4NdO2F/bfPqNf9Ds8cSseMLiYWXGA47My7XDP4
	 h6/iH88qGrY7BRPQ+KIQW40QWs07hMUhih++D06pBBMH0Hg+5rR9LBAWoGQEQp9r7quWZ
	 8rIG+Cfg5FPvwN5w1LliCi9JcJEene4SzEBR3Unv7u+HtHbPC1saPD8+tgun6qbBtOKuz
	 nA+m9oZLfyKwSPhpTqyGwEqKcj6G0Nv0aNEngw+7wJ+LvlJUoezuzUH7KjoE/p5KQ+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792761125;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=9/SoSFwXY3w0jifx5GDQGkcEBD7pUsbS3N3CpluRPso=;
	b=dZwZSw88pMb6YkbilyiFNR6GpRKqD7rNTP0zvy9fxDu4MGL86vgSoHjFGXSHsUKEqcxE
	 /ejqHk1em9KOpvHheCRPZPUXsbJ/iuRy3fGGmXXJa3Yda8Dy89C5jzHNDxosoDdUjdADS
	 Hf0wgWH8SAKkaHssc4fxmLXHOhuzPyovKfyMsDWzX25NBeUXTaGS0ggtQtw5KybcEsDnx
	 Ji/g3UKCF7TwBgeMRLhpwzmjWL/3s9TEaQQ1o55wmg0oIY8fI2KIGuiaWj3wd/VKA+8OX
	 DTknrWSBZDDDfKxUZ0T4h3Obe13YBxMq+rLPVMhZJqB3JkR9cjGIjan+OjWN/QDVmqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MTNYQzzt;
	arc=none smtp.remote-ip=74.125.224.47
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E29606A328
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 13:12:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26E29606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MTNYQzzt
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-676804a3a22so893134d50.1
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 06:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792761124; x=1793365924; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9/SoSFwXY3w0jifx5GDQGkcEBD7pUsbS3N3CpluRPso=;
        b=MTNYQzzt23gS2fZVbBOcOhRTSRiMfgr+vhXpWdYkfwSTM3nw3hUEadQHYQvLY5c/HD
         +fNUZhi7pW9zKv2K7O6lzqXCkBs5wxj895qdY6jM3TQp/owsOyd3hbKeWJ8zDxnVAxXm
         5JCww8SinIRNE80PGfgH6RlD99f1x/Gw0sG95SJ8SruUcgJoT6aCcfwR9EdRHRh/fiL7
         Z/5rSAvco43rT7TZO8IfDVTLylKgpqt+XEbqNHRIoRgUS9ssRhfaFia6M2SVA+OGq4O4
         NYJsTFIhzwnTxBevge9WWSd/wIKJP6DL5F2IAmbRi9+6NBE39KDStFpxSWYz0BjpK/UJ
         2SYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792761124; x=1793365924;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9/SoSFwXY3w0jifx5GDQGkcEBD7pUsbS3N3CpluRPso=;
        b=oQ5CJuBpcV/VB6bA7FZt/toMd0a35FHYYDXPhns/kjkYt6VILZSf/9geyDLIbvTBRI
         kfOjlCjDpurnWbWKf66Yw5PAm6RR9pHiXsBCFP5m4mfJyjTNZekMM7eSQl+5xfBRbFna
         Si4afw21BOKtsge4j0RtkdO1Vk+I8tIOI17rzRzcCbOAIiiJEtKIM4rHslv72tuCUEqX
         FW9fiEBtfiSjEBTDt/SLfIVxsjmgcyjdU8iey7EchuJk2SoTAr23J/gcirfA+1QeYsD9
         CqDjjsodCUpKc0NittkJ1NvYrlzt8kSRycXanFbBidJpgXOTU3jJL5eCfwsAycQD0k6L
         jWAw==
X-Gm-Message-State: AFq9FYJKN4+RJXxte2pW3Yea3FaX6+8/WzChagyptd/c8ZqGSSnmnxkX
	4KIdyiYpDy190rgjYeiIKPKq+hpABZvObGe+snsbDSRwRG2RqcRwz1CryO9+6+mk
X-Gm-Gg: AYBFou2nS3gSPh/0WKyqNe7qk156thNh7zcpc2fzCeLo++CoE5EMThi3LWShGPqb6rA
	DRWAt9TFl1DhFc1h1x0dqsixlp+3JKbkjQg/yL3ABi4Pd9F75taf4QDsv8Av2NEjPuij9c6nl91
	TRIB1TlnXntgZLsFFdw5h7frXzAt8E+b9hNuqDuK7bUbft0T6YewPNHtx1kNOvCcJ9vphvwyQ/1
	zAQZ2FH6yy2E3NFrjyG1meK23+w3dEY9QnTMsNrzQ0DT2RvfT92WnBhZlGQD3MaNb/o4xnHUxX7
	C5vctUZOz4Lt1K6zvuWUhe/PxrN/nx7vhELvruONTzrbAvYTcvBfumBnKWw+iCe1WFetfPqz9Uv
	/dPCYrz7uoLhMdxT/vR5rK3GhAPEERBya5JifeMeb8m+MdBzGaVMJXdrVHVcUFlkd5Ilv/yrrJm
	D0q4UI0L54B5pz+OlwVbxp6aQP1B/t+Pr0OOVbvSy074sW7kKOc64lR02m+Hgk0Sbk83TwylY+u
	YoqQCANUkMs9OQCzng6t8a0v1yey5A567hgbSxDia9A/t4ksc3JJ6kvnCM=
X-Received: by 2002:a05:690e:4081:b0:679:42b4:affd with SMTP id 956f58d0204a3-67a35bb8c75mr1718361d50.21.1792761124202;
        Fri, 23 Oct 2026 06:12:04 -0700 (PDT)
Received: from [127.0.0.1] ([52.188.86.148])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a33dbac4asm1309080d50.0.2026.10.23.06.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 06:12:03 -0700 (PDT)
Message-Id: <427b7315a5167f4b5546a08c851a4aa222fcc2f6.1792761119.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2211.v5.git.1792761119.gitgitgadget@gmail.com>
References: <pull.2211.git.1789379276.gitgitgadget@gmail.com>
	<pull.2211.v5.git.1792761119.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 23 Oct 2026 13:11:55 +0000
Subject: [PATCH v5 2/6] p5413: add perf tests for connectivity check
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

