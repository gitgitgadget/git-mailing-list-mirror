Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29236364EAF
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 12:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791806884; cv=none; b=M3nry0NE0CbAGFmypfGTsyaf/YkwUGDL3fRyg4OPm24uprx2udS/O9lR8kJvVfKoqKTHwAUKXnOiZoCtkeZejo1je7PrFO27H3uyN2tgWwkVPu94d+/ehNpBqlWWGIszo4SV2i0jv24cPNRGqsCC1Fx1eSUX51SHLdvIBiIF7Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791806884; c=relaxed/simple;
	bh=bCFJevER+pZPJXlo0DejBMj7QgJS3LrvF6ENyAeKYNE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fQJXnuhGn7fzUEZ8UNwMC8PRuYwZaS7d1gplQgLzJAJdUWR0i5g2Kml8XBmE83Nw98vhFvLXPB6KxpYw24XvbF3xsn58jejgQ/FjfBL+mbtfjWCAJh6rJAN2KKT+TYVwd9yPGqeaNkkO9GnqcOGLoMl/Ze0cfdq/+xbXi5O5iNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pFu47eJ1; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pFu47eJ1"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-93e6eb77f0bso184441685a.3
        for <git@vger.kernel.org>; Mon, 12 Oct 2026 05:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791806882; x=1792411682; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DKmCvK7m8wERL2miFc+MaJ8TEThe4d4dpigfNRC/h8E=;
        b=pFu47eJ1xqwVMJCLYVCfCtaujc1kW+8Xy2PTuPWM7/PgU7citXuRYOhRoOjZGQxIqk
         WZWzQ9lUZEsrWLytBpkjvY64xi3fwYai6PiNbg6mGiCcMNFYBkqMQjrABQPrdxd6A72M
         tvgy6wYbX0oZXztRsB1x1JL416+Lvjwmc+74IvqrEHDPA3yA0/j/MwA0Yi7ae4CVVwrp
         nFq5TEV/TWWFRTS4X/apPpn93MUr7T/RhBlHKzJzzkZuuGWFBra6TA55MMfYEgv5hav2
         tMHO75wn60XPJHZuAhea760q5ot7OMbiTlO2M6CSEH5dk6J07Q+3wL7I4x0UCMMJ4jxc
         bAnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791806882; x=1792411682;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DKmCvK7m8wERL2miFc+MaJ8TEThe4d4dpigfNRC/h8E=;
        b=NXX0hw1YY7dpjaVDIC6cOCRcqyXjuqfyNkGCufEaI4fHWoISM0Dvlo/naE+w4IJFQk
         8+0n/h4rrgSQlM7IRheRU1JjlU6s/JUAuSBIFB+UAJVeBpOBcTKw5GKLE7HSVptZdwGq
         OV7zWUXXO6SrLUkdrd4P4tN8bJfAi/tXRd5Sa27VK3pTTMhgStr6jW49SJsk0yliAYRg
         ygBKIgE1x7GvdQ6UXBLgKP1iIZfLZ3zYityWCmvTa/ePtxwr9OE50EOzHGq7p86hF1C1
         Q3Sh4pcd8xxqvkDZCSBoETGw0gdIynATyxQnDc6d2mSPzUsUZj2jW0T3k8Kr6XtRDyhD
         a+bQ==
X-Gm-Message-State: AFq9FYLGR3Cp6V9i0fX3CIt4FgnfiBg8A1TY3kERIMj9GST03dBpIetG
	wfYjeLGc6QEuUtr64WJZjjeH7JfXf5SpJBDeyBq/vzRzbleLxBX1fdiF2qE6Uehy
X-Gm-Gg: AYBFou20IAWYLJzBqPgb7Yv+sDFrR3hawapgUirULbdBdZoCXjLjJRF9avsgHnGIKn2
	Qki+MJFrHD3gGSK16GjeYKKgsB+v5afPWGBa3QGJso5IXYygB7Zvck/3qJuPe4mybsjKMgnNVI1
	pB5meE86meuLcC7t119ueu3bvhCp8lCTT326toJyLdWW0u3AhAWSVrv3EosiagHfhmQuDsfBOUj
	GqFa4eKRN2I5TAIptqxS9Zl4ajkc/SnBLJ7qgaPbY3cs99QZSH/FE+lZu6hL50OyLHqipKe3210
	mf0fIN4E84cxJNHCPoyPaMQzk5w8Hr1IT3hViAWSLeCC7Sd6YPHdo/Q77yuiiXDuVkW2WDCcQcn
	EQq/CIuTUXDd0bLBkMGtm4OpMT0hKciF/NI00L/yhFdodkHKG+i1xo7nPhzxlkWJyyEz0AGrWgv
	BrzR80ltXW2//yFcH3M00gvAg/bLmGvGufwOVxbtWcxcX65gFvCLSpRS+hwu96x8irz5zqVQM/L
	Q==
X-Received: by 2002:a05:620a:2605:b0:93b:d7a2:83cc with SMTP id af79cd13be357-93ebd246adbmr1487146085a.59.1791806881870;
        Mon, 12 Oct 2026 05:08:01 -0700 (PDT)
Received: from [127.0.0.1] ([172.208.13.57])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93eb9847f8esm845082885a.9.2026.10.12.05.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 05:08:01 -0700 (PDT)
Message-Id: <211794c9252181fa0c31fcd968379c189d001a8c.1791806877.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2211.v3.git.1791806877.gitgitgadget@gmail.com>
References: <pull.2211.git.1789379276.gitgitgadget@gmail.com>
	<pull.2211.v3.git.1791806877.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 12 Oct 2026 12:07:55 +0000
Subject: [PATCH v3 2/4] p5413: add perf tests for connectivity check
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
index 0000000000..9546996280
--- /dev/null
+++ b/t/perf/generate-repo-p5413-connectivity-check.perl
@@ -0,0 +1,44 @@
+#!/usr/bin/perl
+#
+# Generate a fast-import stream for p5412 connectivity check benchmarks.
+#
+# Usage: generate-repo-p5412-connectivity-check.perl
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
index 0000000000..3fabc82a87
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
+	test_expect_success "setup $label" '
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
+	test_perf "$label" '
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

