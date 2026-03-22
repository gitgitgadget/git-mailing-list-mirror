Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005D337CD29
	for <git@vger.kernel.org>; Sun, 22 Mar 2026 20:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774211897; cv=none; b=fxaho0+55Phd9xVjm6/ZSMFk8GEXH4YcAS5H3uMl6OPNbQMwSw2BSVr22yKKK4iyo/y4s0OAl9Bwv22WYAiq3quQW/55Oj3CNSS19V8mXAs8nNO0Uj8q4xEWV3AiKDZd/BrpypWzCKkgODy9GUcfeoLQEEfTcG3SW/skTWVlOEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774211897; c=relaxed/simple;
	bh=/EruzidN746GE6XW0RaRvsHkEvAEq3PnoAPkOF0aR3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AhVMFH2Ngp9pSITLIvH5lQ/N4WbIVSgGvmRFwYodipy4ecGQQXQT+idUP2NY315w9Groqs0sQl9Go1UvJmvNsht9RvhYs13SP6FvpEnRP+5vaPxNhkjshFDGcAV7gG1+t/DKsSXeQamKCp07UwJu2HLYa6czkK/GdggRgnIgQFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bPCjaYzY; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPCjaYzY"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43b4121c40aso2516788f8f.0
        for <git@vger.kernel.org>; Sun, 22 Mar 2026 13:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774211894; x=1774816694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lnuXD4RMuo5FNcir4lYYzoZifCWmTZC1ZESbTGGGY40=;
        b=bPCjaYzYjrMlwb1wmFZH3g7Hb2YgA5PLHHaV4qJfYVBDYHKNcJJbAdqnScAgSvKUXX
         lKnwCl58+HKeM8fgzBShwHC7C+aNebgDTSB5PFJ0G7PgVqakK+Yv489kK85ykZ+DAMDe
         qM/91WaLc6qHf7wZQZGmRNjAROdGIkGX7SV7mR+rNABMTUMMi2MOjjJMlcuea45n41wh
         gMb9xH8v/Fz18S2uS2jf6PZgaHWkqAooveVt2cXbSVa/0i2qdIahRqdEIvd9YWxHfD/Z
         pzFwByEMFa+9IbeZhFzyaIV2huj5ov8ddgl+eu2QObMv/QhErExqkpUI/RpB6QC97X0A
         g6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774211894; x=1774816694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lnuXD4RMuo5FNcir4lYYzoZifCWmTZC1ZESbTGGGY40=;
        b=sBSR3SDi4i5f54eEUA9fa22TWHxEZjMo8K1Kk/U37x61VPPBz2hF+OkrxXnRpukIql
         Wax+U3DLQ3iC6jsC3phOhbTKU0M905gdaE9dOFy7AwO/EcGhFVu4a6NZ6td7RSUx1JyV
         OFLTvvNasTlqhLuPsihfJK4LxZ9ad0UCs1NwkVrzTDVtwkQtWJ17H/tmLAHWgE5nV0uS
         krd9nNiMo9dkIZKu7bKZdG+JYvwGWSbugaVSBZaVbaWdivXSPXUPSVKioEkFK40mBwcA
         EK4Byqm5IfO+w1F2cqwZCuneHgRZ8VutysbI/y2Hs7+YHbX9T4IfJ1nVN6G7sStiJnMp
         hIqA==
X-Gm-Message-State: AOJu0Yxh7EgI0VgcL0I1zYx8M45rAY8N+icGweW6aSTE5PgYXZdYbY/R
	zWxlACk6qC+encwBSf7ZU4/cDRCfb+O3XlyKU5I48FH38Y6Bujx8e/4MjQZImJwex+71pg==
X-Gm-Gg: ATEYQzy/+rIB6Fh7ZIfJ7ZPXL4rxlRXssPJ1zqJAZEPzGeYY4qgYZl0dg1rzlO5Ouu+
	eiBcXxZyi6UysNawnprJPMwDq9+CUStdcq5QJmmTpuzv9nLNYisWOMCd3e7fY5Kw8Gig5JIo25I
	SR9wHT9nkruFvOFA/bRvcubBIsgiHqDP3bM1KIHBlukWZw1RQiJgRLUYbaCD25ydbMqjdVl2pH3
	g2hlUClOigfH/E9A8HvHeIutj+qaRbLHDxPBOgfWL/3PCH4OYeMwb+enfDOyg4eJCmsqmiqHBYn
	8TjcsPxQuWeYcYVn49VSysB8ANm7Nb4qgvijPaNViatP6Rs4Iq0jYRM+ZyrKtcngurn7BOPCXu3
	ga2UZC2dAMs1WvBGsheWPeotao8upzX0c427UBYgYMmwSi0yJ6OusyRsyz8bWAG3yZ268RoA57Z
	AqSRJdOKSnHmFFI5dndH3jPT2W4kL2qbYx2h265n00x0RFB/jIrbbTXcxrAFhFb+BB1zW1NTQ7d
	H8c3k+Msi4DhgwJ3rXisykR++JN4Oypb32Q5qj/XOUYQmMD9ncujhLohSc=
X-Received: by 2002:a05:6000:2203:b0:43b:45a0:9df8 with SMTP id ffacd0b85a97d-43b642781a8mr16242431f8f.35.1774211894072;
        Sun, 22 Mar 2026 13:38:14 -0700 (PDT)
Received: from farblopa.localdomain ([84.126.0.122])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64703650sm23569157f8f.20.2026.03.22.13.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 13:38:13 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	karthik.188@gmail.com,
	jltobler@gmail.com,
	ayu.chandekar@gmail.com,
	siddharthasthana31@gmail.com,
	chandrapratap3519@gmail.com,
	gitster@pobox.com,
	j6t@kdbg.org,
	Pablo Sabater <pabloosabaterr@gmail.com>
Subject: [GSoC PATCH WIP RFC v3 3/3] graph: add documentation and testing about --graph-lane-limit
Date: Sun, 22 Mar 2026 21:38:01 +0100
Message-ID: <20260322203801.637769-3-pabloosabaterr@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260322203801.637769-1-pabloosabaterr@gmail.com>
References: <20260322195406.108280-1-pabloosabaterr@gmail.com>
 <20260322203801.637769-1-pabloosabaterr@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document --graph-lane-limit option in rev-list-options.adoc with
--graph option.

Add two tests in t4215 reusing last test graph structure.

- --graph-lane-limit=2 on one tip showing only two rendered
  lanes and the rest replaced with the truncation
  marker.

- --graph-lane-limit=3 with multiple tips, showing only three
  rendered lanes.

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 Documentation/rev-list-options.adoc |  5 +++
 t/t4215-log-skewed-merges.sh        | 53 +++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
index 2d195a1474..1819228b60 100644
--- a/Documentation/rev-list-options.adoc
+++ b/Documentation/rev-list-options.adoc
@@ -1259,6 +1259,11 @@ This implies the `--topo-order` option by default, but the
 	in between them in that case. If _<barrier>_ is specified, it
 	is the string that will be shown instead of the default one.
 
+`graph-lane-limit=<n>`::
+	When `--graph` is used, limit the number of graph lanes to be shown.
+	Lanes over the limit are replaced with a truncation mark '.'. By default
+	there is no limit.
+
 ifdef::git-rev-list[]
 `--count`::
 	Print a number stating how many commits would have been
diff --git a/t/t4215-log-skewed-merges.sh b/t/t4215-log-skewed-merges.sh
index 28d0779a8c..657e3ff2a5 100755
--- a/t/t4215-log-skewed-merges.sh
+++ b/t/t4215-log-skewed-merges.sh
@@ -370,4 +370,57 @@ test_expect_success 'log --graph with multiple tips' '
 	EOF
 '
 
+test_expect_success 'log --graph --graph-lane-limit=2 limited to two columns' '
+	check_graph --graph-lane-limit=2 M_7 <<-\EOF
+	*-.   7_M4
+	|\ \
+	| | * 7_G
+	| | * 7_F
+	| * . 7_E
+	| * . 7_D
+	* | . 7_C
+	| |/
+	|/|
+	* | 7_B
+	|/
+	* 7_A
+	EOF
+'
+
+test_expect_success 'log --graph --graph-lane-limit=3 limited to three columns' '
+	check_graph --graph-lane-limit=3 M_1 M_3 M_5 M_7 <<-\EOF
+	*   7_M1
+	|\
+	| | *   7_M2
+	| | |\
+	| | | * 7_H
+	| | | . 7_M3
+	| | | . 7_J
+	| | | . 7_I
+	| | | . 7_M4
+	| |_|_.
+	|/| | .
+	| | |_.
+	| |/| .
+	| | | .
+	| | |/.
+	| | * . 7_G
+	| | | .
+	| | |/.
+	| | * . 7_F
+	| * | . 7_E
+	| | |/.
+	| |/| .
+	| * | . 7_D
+	| | |/
+	| |/|
+	* | | 7_C
+	| |/
+	|/|
+	* | 7_B
+	|/
+	* 7_A
+	EOF
+'
+
 test_done
-- 
2.43.0

