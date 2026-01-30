Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF64B2253A0
	for <git@vger.kernel.org>; Fri, 30 Jan 2026 17:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769792494; cv=none; b=syjnUZjNh9mmDCtOuj9kkZ5iv5Gx08SD8yYWJA4QFcYb0HKhY5rGxKg3jLgLR5meoddJEEfnPcXEtSs7nwsj1wd49BzXQKcb6mUJ4AqTeDOIJ0lGIDAgXRbthZv92/KuCkI0T0/MvRX0dZtRrgnlULCcjuJ20LZGE3tJ3d8epvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769792494; c=relaxed/simple;
	bh=WXyBj6WcIws48AerWrgICze66kOj+xsVvXnHM+XaJag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QHvMm0ONZTsWe4FbBvvx6yunHkMYwE1wiO/lfohnb6xa2gsV4i/bu9okpgY4TzhQCGnNwPiLsDRPAu0/MxHuDEKTZe6MVpnUufzPvvTa4Y5t7t3kqwttdxbHlcJ1utijJsR1BFw4qiqISQ4YjepTR3yKUVZz1vgyMjtAfFRXKi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mkIovWqs; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkIovWqs"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a80ed99c62so847815ad.3
        for <git@vger.kernel.org>; Fri, 30 Jan 2026 09:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769792491; x=1770397291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BrB9eyIVyC3JdUnDVUDtIDi5UTXGFWXrVMxbXWCSt3k=;
        b=mkIovWqs5FTMNF/MmHZ3KGzlJA2SoxCIZLUZBkSolODCjact4vMEUnauiDexBMFyr0
         JUzsfqzxrETa9ES1R2GqhQxUXUiJp/B5vGGJ2UsmXTmwf4AHm7/eyhu6Wdu5CceOnjww
         yHMfSy36Tl/jTVqS56kPumFgKWeBmrH6zMltO9ig+V6l3z12eusNgzBdDJ5AFmy1Hk7X
         X3gAm9GD0aWzXP5MzJZ7prw0r1d9amUBQmoYNh5EbeuTF6W66/sLGF7TZG4PWEJbo59a
         FmAY14rl8IvnacgAz41csELj5nP5aylZQvBg2fdOC8ZehDs7RaeV56czlosaeTH4erNo
         WCqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769792491; x=1770397291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BrB9eyIVyC3JdUnDVUDtIDi5UTXGFWXrVMxbXWCSt3k=;
        b=K+qHgoHFin4Myvz9MCg4WarRpRPUzv5tC3AQ9REIzANF1fDk+77gIwCS9ZOGVkpxGw
         Vn5tzuXQRrhlQl8YoRYkVpKZ4gUeDjiJ3nXHY3+9DKz9c27w2Ehv3j/rDO95Pg03JL64
         4zX1CrjlThN7zF5SrH6yXrHFCUKJP57tJSS0fhTdaR5AHUbh09YjKkgDGUcrvTGCp9+9
         LKNvb+WYVYOvsqVI0jcoDb73cHB6C8sa35WGmJvtfQUEE8Uv86RxRXNyTvvPG/xc6Y8P
         uJXRIcSdzFvT5cPY4CY/1vwZ9J/PvQploy/ePswpbhZOsFP4J7Lwz7k62gvfsStWQGV2
         PDXQ==
X-Gm-Message-State: AOJu0Yz2Qu1GtZQD+LyNvDhsFLdN+vWPJbtiRQQLWkvOvZXrIAN6B7a4
	F2VHUckn8u2g+3mSrEkZtfUpVToST1YtPHtTm/xb2ocskkKBtrsO9qB47FtMgLCTW0E=
X-Gm-Gg: AZuq6aI1Dea+Ki947/9NG1F3RyuTPOAf+Eq1q87eA0NBpPOlSdiDo2qJklko3Fi47Ri
	6kghmQCth9kKW11L2wWRao2deaHpl7oOLwMsHOL+pqet1pYX8PZDFCePqhA9o3aDWMLZy5q1sTa
	d0NG9oHMxZTXzZ7QFhOBixBaNzkoArfwejJnas55qSJgae6dRM9AoBRtsBM310bTPYx34Jzpk55
	Xkpdz1ZFBmt9mYb4+3tADVvuMRTbBO0XRt9AALChLUg1uAI4HezKG1XcY7IlPfuvvi3BiSCcPP8
	Ov9GpOPllYP3IGo1FYrRK4N6o9K7qRsMenzsxM8RNz1dmq1vRSJAb/IYf0fVInKaCjn/OtoGLuy
	SQjoCFCOkAxoWNCmvbXK91ypFaq5JdB6jUFyeD2g31x1wPkFFOYZC8ykIFBWBkzMZPvp0C8X9Jj
	xzFH5dwT7SaFHS5J4iN0QuR1siqyw=
X-Received: by 2002:a17:903:240f:b0:2a7:8851:847e with SMTP id d9443c01a7336-2a8d99322cbmr27061695ad.6.1769792491438;
        Fri, 30 Jan 2026 09:01:31 -0800 (PST)
Received: from malon-Yoga-14sARE-2020.. ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b6efc1bsm79439355ad.74.2026.01.30.09.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 09:01:31 -0800 (PST)
From: Tian Yuchen <a3205153416@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	j6t@kdbg.org,
	phillip.wood123@gmail.com
Subject: [PATCH v4] t/perf/p3400: speed up setup using fast-import
Date: Sat, 31 Jan 2026 01:01:23 +0800
Message-ID: <20260130170123.642344-1-a3205153416@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260130162927.638672-1-a3205153416@gmail.com>
References: <20260130162927.638672-1-a3205153416@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The setup phase in 't/perf/p3400-rebase.sh' generates 100 commits to
simulate a noisy history. It currently uses a shell loop that invokes
'git add', 'git commit', 'test_seq', and 'sort' in each iteration.
This incurs significant overhead due to repeated process spawning.

Optimize the setup by using 'git fast-import' to generate the commit
history. Additionally, pre-compute the forward and reversed file contents
to avoid repetitive execution of 'seq' and 'sort'.

To ensure the test measures rebase performance against a consistent
object layout (rather than the suboptimal pack/loose objects created
by the raw import), perform a full repack (`git repack -a -d`) at the
end of the setup.

This reduces the setup time significantly while maintaining the validity
of the subsequent performance tests.

Performance enhancement (Average value of 5 tests):
            Real        Rebase
  Before:  29.045s      13.34s
   After:  21.989s      12.84s

Measured on Lenovo Yoga 2020, Ubuntu 24.04.

Signed-off-by: Tian Yuchen <a3205153416@gmail.com>
---

Changes since v3:
- Refactored the fast-import generation to write to a temporary file 
  (`fast_import_stream`) instead of using a pipe. This allows for better 
  debugging if fast-import fails, as suggested by Johannes Sixt and 
  endorsed by Junio C Hamano.
- Switched from `return 1` to `exit 1` inside the subshell to correctly 
  propagate exit codes.
- Undid the unnecessary removal of a blank line.

 t/perf/p3400-rebase.sh | 53 ++++++++++++++++++++++++++++++------------
 1 file changed, 38 insertions(+), 15 deletions(-)

diff --git a/t/perf/p3400-rebase.sh b/t/perf/p3400-rebase.sh
index e6b0277729..425f484681 100755
--- a/t/perf/p3400-rebase.sh
+++ b/t/perf/p3400-rebase.sh
@@ -9,21 +9,44 @@ test_expect_success 'setup rebasing on top of a lot of changes' '
 	git checkout -f -B base &&
 	git checkout -B to-rebase &&
 	git checkout -B upstream &&
-	for i in $(test_seq 100)
-	do
-		# simulate huge diffs
-		echo change$i >unrelated-file$i &&
-		test_seq 1000 >>unrelated-file$i &&
-		git add unrelated-file$i &&
-		test_tick &&
-		git commit -m commit$i unrelated-file$i &&
-		echo change$i >unrelated-file$i &&
-		test_seq 1000 | sort -nr >>unrelated-file$i &&
-		git add unrelated-file$i &&
-		test_tick &&
-		git commit -m commit$i-reverse unrelated-file$i ||
-		return 1
-	done &&
+	test_seq 1000 >content_fwd &&
+	sort -nr content_fwd >content_rev &&
+	(
+		for i in $(test_seq 100)
+		do
+			test_tick &&
+			echo "commit refs/heads/upstream" &&
+			echo "committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE" &&
+			echo "data <<EOF" &&
+			echo "commit$i" &&
+			echo "EOF" &&
+			
+			if test "$i" = 1; then
+				echo "from refs/heads/upstream^0"
+			fi &&
+
+			echo "M 100644 inline unrelated-file$i" &&
+			echo "data <<EOF" &&
+			echo "change$i" &&
+			cat content_fwd &&
+			echo "EOF" &&
+
+			echo "commit refs/heads/upstream" &&
+			echo "committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE" &&
+			echo "data <<EOF" &&
+			echo "commit$i-reverse" &&
+			echo "EOF" &&
+			echo "M 100644 inline unrelated-file$i" &&
+			echo "data <<EOF" &&
+			echo "change$i" &&
+			cat content_rev &&
+			echo "EOF" || exit 1
+		done
+	) >fast_import_stream &&
+
+	git fast-import <fast_import_stream &&
+	git repack -a -d &&
+	git checkout -f upstream &&
 	git checkout to-rebase &&
 	test_commit our-patch interesting-file
 '
-- 
2.43.0

