Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB7942A9D
	for <git@vger.kernel.org>; Mon, 18 Aug 2025 11:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755515609; cv=none; b=FKRgiB5UblIn3wRVO/IUHSCVVQZYeIJMUfymxkQLEDMJLzZ/ihA2y0Kf/Vua48wf/7kH5aAV7xpJ0UrEg1uyvvS6SQynsw11srw+JOizWX61crmxS1Ey1fc6IeP1IJMXB9QmcwIUzKCI9yKg6ikhvcVBJ6diXPtrzw7BSgtY3Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755515609; c=relaxed/simple;
	bh=txjBtQ6NfTiyfZn82UBWCKTck1GLopQLjeuGDfM1FAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FH8IGqFDkkkwgvXp+p1JAd8X4ANCqu8kOghMSMqhAUYC4vXmY+lQflWbtDYKuUEMbM4i8pkCz02+BMWyP5FIlU4Xw94HBKlmXPVuLtJ+Um/Xt9SCMG0Uozu/aLvwWo3KlsPGm5D+RzDDMiMp0scPfdvrMhDf9txVRyuPqp9G+Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ewIdnAZb; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewIdnAZb"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3bb30c72433so1138812f8f.3
        for <git@vger.kernel.org>; Mon, 18 Aug 2025 04:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755515606; x=1756120406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TE6Nx+uZGC/173WDT2D9h0CcpJVQZm3BT6bljmrhMrA=;
        b=ewIdnAZb0K0b/6vL8O4DH7mVlrBh42ex8qkss+1s//JVBMLrbPd92w3MKvJm/XGjyX
         vc1Ct5ep/jhbWZbEu74YptTnC/komXZh4MShzbwJBLB5kAfER6M1qyvHAXZEI0R+x4Ll
         PnLNbIv+3DUtdSOm0HFt91r6VqiEISWzmLQe3nHDToD/eFkGc53z68sI6WtLuFuWd1z8
         0lRFJjMsA3CbdIyt1MeGE0LD3CYSWj97w8JuiI4tKZ/NwGt8Uu2G0FJlNjql6zaPCFA5
         1SXQgqwPDfUVLtZcf6qA+puIkBHlXbaAFwxs2nmECU/gbgudlsWXx/yZgZUTDHFxxMcS
         eM9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755515606; x=1756120406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TE6Nx+uZGC/173WDT2D9h0CcpJVQZm3BT6bljmrhMrA=;
        b=Hgg3f9KU3+cOAFwzVD2fC/FnjDcJwL6zbXA5M+CuC67pY2JO3SL6xOcTr0UyZdnc3r
         mGhzP2y6fAiX9zzjsKaz6SL8urW0iuuTA19JhYNeToaLaP9CXwhlvBdLuN1Xo1VnMie1
         pBM4+Gz6a2wvqOpwmtK8GtXf3WmZM+IBFW8DwM0sxIcauC5XRnvlLfggTPT6sLO/2SFt
         737T2mHnYPlNjq/qVfvpeg+6t8dICvVJuVr0RH2q5iNnZ6K2XnoWizPtYVlYN3nEJAYo
         gh9PeSG7kA2admEw15KMZQfO6tvgv+UAKAb3wkXVTS52eNu6gbPQkrFXa+9/eBIPyk3P
         PRIQ==
X-Gm-Message-State: AOJu0Yy2wIwYMpN+tbXkYBmlrvREWzGEXu/rDVKkyEYl7Hqrdlklt70U
	oPD2VhIOL2W3TYOXIL6uR5VvRYh8yLITVKVwZnZ7gvdiGv9tT0tohGYPJT7Zsw==
X-Gm-Gg: ASbGncsQFTmMax4vMglmRLwW0z2KqVKeL4fU+hMG2pbKDByDsUKI8JBv+bwkeXMklEv
	k1ll0ya/SvGammFh0vpOzEXnO5Ek9aGy0Yt7ywHptu9VjpVM4RIejABscc7LRo2XXAjO1YsLJKZ
	QMcCmbQ5wshJf4RZdjJv/iFqBgyy195cpQN5LBHfMhZAiBLfgeSaaAn9AI9RGEQj1Q9hNF8EuU9
	M8TTdpkBlM1itljB/dH6RA0P62RWOmmfK0I+AnXTkPJ8t8o6dKVVnFw5/jamoL/bLLnWXgJy7OC
	3olu/2WL/BgMwQ3ZdgIESIybOMZosFgU4/ykxgUVsHUg11gitTIN3gxEkI/iZcsxuPFWQ0jt/E3
	kiKmVtCpTRCkrbi4dztWLRqp0xonQ4tDQiY658KEoSQhoGiz2J00fRTgXszF13JHuwNdb+HuuuZ
	xvGd6G6jDdnpK7
X-Google-Smtp-Source: AGHT+IHWxhaiyW8OfQHQ58t/2le+fT5wpE6tOTWkEnQiw3DfBUnDAAhmS1rgBnMSofP3l8HAeQQLIw==
X-Received: by 2002:a05:6000:2902:b0:3b8:eb9f:a756 with SMTP id ffacd0b85a97d-3bb66567decmr8275044f8f.11.1755515605940;
        Mon, 18 Aug 2025 04:13:25 -0700 (PDT)
Received: from localhost (2A0011100205B3242CE2DE6CDE8A6370.mobile.pool.telekom.hu. [2a00:1110:205:b324:2ce2:de6c:de8a:6370])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb64758561sm12553138f8f.11.2025.08.18.04.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 04:13:25 -0700 (PDT)
From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To: git@vger.kernel.org
Cc: Evgeni Chasnovski <evgeni.chasnovski@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 2/2] line-log: show all line ranges touched by the same diff range
Date: Mon, 18 Aug 2025 13:13:10 +0200
Message-ID: <20250818111310.1283932-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.51.0.rc2.346.g6515629ae9
In-Reply-To: <20250818111310.1283932-1-szeder.dev@gmail.com>
References: <20250818111310.1283932-1-szeder.dev@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When line-level log is invoked with more than one disjoint line range
in the same file, and one of the commits happens to change that file
such that one diff range modifies more than one line range, then
changes to all modified line ranges should be shown, but only the
changes in the first modified line range are:

  $ git log --oneline -p
  80ca903 (HEAD -> master) Initial
  diff --git a/file b/file
  new file mode 100644
  index 0000000..00935f1
  --- /dev/null
  +++ b/file
  @@ -0,0 +1,10 @@
  +Line 1
  +Line 2
  +Line 3
  +Line 4
  +Line 5
  +Line 6
  +Line 7
  +Line 8
  +Line 9
  +Line 10
  $ git log --oneline -L1,2:file -L4,5:file -L7,8:file
  80ca903 (HEAD -> master) Initial

  diff --git a/file b/file
  --- /dev/null
  +++ b/file
  @@ -0,0 +1,2 @@
  +Line 1
  +Line 2

The line-log-specific diff printer is already clever enough to handle
the case when one line range covers multiple diff ranges, but the
possibility of one diff range touching multiple disjoint line ranges
was apparently overlooked.

Add the necessary condition to dump_diff_hacky_one() to handle this case
as well, and show all modified line ranges:

  $ git log --oneline -L1,2:file -L4,5:file -L7,8:file
  0f9a5b4 (HEAD -> master) Initial

  diff --git a/file b/file
  --- /dev/null
  +++ b/file
  @@ -0,0 +1,2 @@
  +Line 1
  +Line 2
  @@ -0,0 +4,2 @@
  +Line 4
  +Line 5
  @@ -0,0 +7,2 @@
  +Line 7
  +Line 8

This bug was already present in the initial line-log implementation
added in 2da1d1f6f (Implement line-history search (git log -L),
2013-03-28).  Interestingly, that commit already contained a canned
test case covering a similar scenario:

  "-L '/long f/',/^}/:a.c -L /main/,/^}/:a.c simple"

This test case looks for two line ranges in the same file, and both
trace back disjointly to the test repository's inital commit,
therefore changes to both line ranges should have been shown for the
initial commit, but only changes for the first line range are shown.
So this test case should have failed from the very beginning, but it
never did, because, unfortunately, the canned expected result is
incorrect, as it doesn't include changes for the second line range.

A similar test with a similarly incorrect canned expected result was
added later in 209618860c (log -L: fix overlapping input ranges,
2013-04-05).

Correct these two canned expected results to contain the changes for
the second line range for the initial commit as well.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 line-log.c                       | 9 +++++++++
 t/t4211/sha1/expect.multiple     | 6 ++++++
 t/t4211/sha1/expect.two-ranges   | 6 ++++++
 t/t4211/sha256/expect.multiple   | 6 ++++++
 t/t4211/sha256/expect.two-ranges | 6 ++++++
 5 files changed, 33 insertions(+)

diff --git a/line-log.c b/line-log.c
index 9cb8ea1484..9b75b4ac39 100644
--- a/line-log.c
+++ b/line-log.c
@@ -939,6 +939,15 @@ static void dump_diff_hacky_one(struct rev_info *rev, struct line_log_data *rang
 		long t_cur = t_start;
 		unsigned int j_last;
 
+		/*
+		 * If a diff range touches multiple line ranges, then all
+		 * those line ranges should be shown, so take a step back if
+		 * the current line range is still in the previous diff range
+		 * (even if only partially).
+		 */
+		if (j > 0 && diff->target.ranges[j-1].end > t_start)
+			j--;
+
 		while (j < diff->target.nr && diff->target.ranges[j].end < t_start)
 			j++;
 		if (j == diff->target.nr || diff->target.ranges[j].start >= t_end)
diff --git a/t/t4211/sha1/expect.multiple b/t/t4211/sha1/expect.multiple
index 76ad5b598c..1eee8a7801 100644
--- a/t/t4211/sha1/expect.multiple
+++ b/t/t4211/sha1/expect.multiple
@@ -102,3 +102,9 @@ diff --git a/a.c b/a.c
 +		s++;
 +	}
 +}
+@@ -0,0 +16,5 @@
++int main ()
++{
++	printf("%d\n", f(15));
++	return 0;
++}
diff --git a/t/t4211/sha1/expect.two-ranges b/t/t4211/sha1/expect.two-ranges
index 6109aa0dce..c5164f3be3 100644
--- a/t/t4211/sha1/expect.two-ranges
+++ b/t/t4211/sha1/expect.two-ranges
@@ -100,3 +100,9 @@ diff --git a/a.c b/a.c
 +		s++;
 +	}
 +}
+@@ -0,0 +16,5 @@
++int main ()
++{
++	printf("%d\n", f(15));
++	return 0;
++}
diff --git a/t/t4211/sha256/expect.multiple b/t/t4211/sha256/expect.multiple
index ca00409b9a..dbd987b74a 100644
--- a/t/t4211/sha256/expect.multiple
+++ b/t/t4211/sha256/expect.multiple
@@ -102,3 +102,9 @@ diff --git a/a.c b/a.c
 +		s++;
 +	}
 +}
+@@ -0,0 +16,5 @@
++int main ()
++{
++	printf("%d\n", f(15));
++	return 0;
++}
diff --git a/t/t4211/sha256/expect.two-ranges b/t/t4211/sha256/expect.two-ranges
index af57c8b997..6a94d3b9cb 100644
--- a/t/t4211/sha256/expect.two-ranges
+++ b/t/t4211/sha256/expect.two-ranges
@@ -100,3 +100,9 @@ diff --git a/a.c b/a.c
 +		s++;
 +	}
 +}
+@@ -0,0 +16,5 @@
++int main ()
++{
++	printf("%d\n", f(15));
++	return 0;
++}
-- 
2.51.0.rc2.346.g6515629ae9

