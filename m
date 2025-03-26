Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1FF49659
	for <git@vger.kernel.org>; Wed, 26 Mar 2025 21:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743023183; cv=none; b=VNPqDb4jhGXVxc0mauJfLZ1OWcq98MQFOqEqKwlKql2F7IGNCv9fE3YKblyvZigQz1+HFARzg5YryMIr70Js2dylHVfKkSikZ+FcDtlgfiS64lSMs9vzURKyZIx+/+wb6d+CBvk+b6xkk6e7+uCm0RGzq9uzMfUuzEit+dgVvnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743023183; c=relaxed/simple;
	bh=cvETS+a8Te2YEEuaeE8YOEBJmEaddIVNzZQ5DdSR1gs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:
	 In-Reply-To:References:To:Cc; b=IGi/oQee+MjfNjMTF/VBY8hfzaR6n3MuD3lQhXh9gkCBQaTZxI+ojsgGgJKde8q27fhYX9kWtSxf7KTZ++sH7Wt891z8mlsJJEJgcOK1nSycBv2+pQghdRHnJJnF/bQw+Nn0ExRBBwHZT5BEZLzwM2BSPykmCPZb9oWDTuqQyec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O131rKb9; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O131rKb9"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cebe06e9eso2076495e9.3
        for <git@vger.kernel.org>; Wed, 26 Mar 2025 14:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743023180; x=1743627980; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CsWGhRPuZs7xfWpolmPfeLJFlvmaAOAcZEPw9m+fVPY=;
        b=O131rKb9neLy+a0Gpy+zgdn/Atoim+kQu+nhfJb0N/qLyREVMSsDHVmRE125kTXEBe
         AtMK08mThEznefNwwlRp4Qcufqyrg5Uoa1jVw5kMkZliA+V7cRPGSTsa+N6rn4ozknv5
         Q+/lf42ICVVscxn0soDNAT6OlUX19fERad5kPy4jak9y8XQaMkm+q5qurH2fr7CFCthu
         JlqgN5uQ/QXOP92IrTJ9HDNEpYIxoPolB6bwtao9R/a1FdiDBn5wN6Yt0bvmhEba/3m5
         WqM1Y38Z0XmbvWv+CbBtQBQVxddJ4UtFJYjpQB1FfcXqeJTHLIM38Is4Qe07cgmEUK4/
         6P9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743023180; x=1743627980;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CsWGhRPuZs7xfWpolmPfeLJFlvmaAOAcZEPw9m+fVPY=;
        b=RRF+kWJqSOhmpeNjFydHR1sEd6LGdDhqXaDEKiwFFTmfBxfEVov9Ij5McSB4QRv4XX
         5vYh3T4fFn8/uYVBFh1GKH8CES7IKCNNLVhi7Fh8PgDSiXBiS/XNmnV8raE/lgWp/Lya
         T9a87OtZSFqkYEiUgw38KMcQQbSUOAo0csdYAbyeo/ozBfZeZc8Qc5KPglUmAKUdxTNf
         0dVmK04smTgcYOiUP6yPrxSPl9HQjrsAvFMs2ZNSopx8NzVykO7vTdCpwjmkOpcUcUo/
         1aaPKJMVUNRXFOqJlmon+KmvMBkEabgdje9UBLuE1K76nW5lNMEpJUKVIasS4arO0UbP
         cj0Q==
X-Gm-Message-State: AOJu0Yzv4tQoRbR3mWGJwZNVEM2ARq5POOGNFmeFUyScRo2z+eZLa8co
	WdnyFtzOFZnpMS+LEuTYGflRo108uLUnZaX4ne7cpgz+i5k6BH87RKdG9FaG
X-Gm-Gg: ASbGncsfBnJYFR7OTc6i4T6UECjUCuxhfyxzvB9UP50Jh/u0TkudBHfnomaPNLgkAYt
	lJwStJBshx+umTtHuECbcvUia5H+DZnUU3q6Hfd9ThrABEVHKzzQbDytAtgMkebmFiYZ/R6cRCu
	sYsKQUl93X1Qat+zJtM+Jeu/Pavoz4Ol8lNl7J9oG7GFkDhjQ4HR9ScvB9AAkAPWHXD7P2RbQgc
	YO//bfMlJit0JKI+8OP1emRYzUtMtfVf+lNZrxNvHfFSJjyk+73GVh8NimjFzFkN98uwEmymT7Z
	Q/M2H7dSrtg/MDD+QDPHQiHPEJvn3YlEAc1QmQMzIdFRk+UJg5E=
X-Google-Smtp-Source: AGHT+IFkWIQBTeXgPdbvjMgDjpDK5gFP4N6z0qJlXL/jwezGi1FRaiCq3GaO/mQk95/KJ99xU7OoWQ==
X-Received: by 2002:a05:600c:4fd5:b0:43d:b3:f95 with SMTP id 5b1f17b1804b1-43d850936f9mr6538615e9.28.1743023179526;
        Wed, 26 Mar 2025 14:06:19 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:c222:899f:5bb9:e8a2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d82efe389sm14384635e9.19.2025.03.26.14.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 14:06:19 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 26 Mar 2025 22:06:10 +0100
Subject: [PATCH v2] blame: print unblamable and ignored commits in
 porcelain mode
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-514-git-blame-1-s-porcelain-output-does-not-emit-unblamable-and-ignored-markers-v2-1-79037e17a74b@gmail.com>
X-B4-Tracking: v=1; b=H4sIAEFs5GcC/7WOQQ6DIBREr9Kw7m+EorVd9R6NC5Cv/lTAAJo2x
 rsXvUOXbzKZeSuLGAgje5xWFnChSN5lEOcTawflegQymZkoRFlcBYeSS+gpgR6VReAQYfKhxVG
 RAz+naU5gPEZwPgHaXJzdXlV6RFDOAPXOBzRgVXhjiCBVJ6uuELW8IcuvU8COPofRq8k8UEw+f
 A/Bhe/p/1wWnkek1GUlzF2jrp+9VTReWm9Zs23bDwTzx9cuAQAA
X-Change-ID: 20250321-514-git-blame-1-s-porcelain-output-does-not-emit-unblamable-and-ignored-markers-4af46f02847e
In-Reply-To: <20250321-514-git-blame-1-s-porcelain-output-does-not-emit-unblamable-and-ignored-markers-v1-1-44b562d9beb8@gmail.com>
References: <20250321-514-git-blame-1-s-porcelain-output-does-not-emit-unblamable-and-ignored-markers-v1-1-44b562d9beb8@gmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com, ps@pks.im, toon@iotcl.com, gitster@pobox.com, 
 Christian Couder <chriscool@tuxfamily.org>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6313; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=cvETS+a8Te2YEEuaeE8YOEBJmEaddIVNzZQ5DdSR1gs=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGfkbEpHnAH4/bYsa2eUznFLMDZhWaR9/j/a9
 GtlH8SA8LFLf4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJn5GxKAAoJED7VnySO
 Rox/VikL/j/pWN5caJRMz2ZPFYCLLwxyODvBfjMvTEUG43Y6CU+Fbi0OVKBY62VLk7T0Y1r8opR
 ld3omn/JHe9e4XJbIYxWTEaAJV/lHZcO2qHyf+lMR2H/nsT7MWAf9EcuMgMVd6BMuX8ZrlbXbe5
 57RCbwNG3k004mN2bpq+SodB5zBL6Cj8XZpFvUeIV2p3IyO8+e9zT+qkt4Qj7Ok0MiXRRwdof9L
 Yba8Kxq3PpHb9kJbYt7k1RbhBjs6OScda5b7brPt17FtXb212+RtP5ElPpwa6Zf8j3f1PYmMH/5
 rBiT0VtD6IlZRjUn8QBTA97dVGgf50AbF3vyN/jwg21kV+AR7swo8+N2PyrIvU/Y7oeYYg2Qo4F
 pSiJEa9ks9L3hYqST+T0miH1cyWcbm+LnyUPCqukQNTsw+oAUWIFSAJ2XjUXDt0ogpagCo5d1nA
 1QdH0wxRWQn1eeljddbDg01NyfnNVFMuMEu9SNhnVEgUwtY02Vd29NLZtPHx/KIGjGbInCyeMu6
 0I=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The 'git-blame(1)' command allows users to ignore specific revisions via
the '--ignore-rev <rev>' and '--ignore-revs-file <file>' flags. These
flags are often combined with the 'blame.markIgnoredLines' and
'blame.markUnblamableLines' config options. These config options prefix
ignored and unblamable lines with a '?' and '*', respectively.

However, this option was never extended to the porcelain mode of
'git-blame(1)'. Since the documentation does not indicate this
exclusion, it is a bug.

Fix this by printing 'ignored' and 'unblamable' respectively for the
options when using the porcelain modes.

Helped-by: Patrick Steinhardt <ps@pks.im>
Helped-by: Toon Claes <toon@iotcl.com>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
Changes in v2:
- Instead of printing the markers before the SHA in porcelain
  mode and breaking scripts and backward compatability, let's 
  instead add a newline printing 'unblamable' or 'ignored'.
  This is printed per line in both the porcelain modes. 
- Link to v1: https://lore.kernel.org/r/20250321-514-git-blame-1-s-porcelain-output-does-not-emit-unblamable-and-ignored-markers-v1-1-44b562d9beb8@gmail.com
---
Range-diff versus v1:

1:  9650db628f < -:  ---------- blame: fix unblamable and ignored lines in porcelain mode
-:  ---------- > 1:  6bbfc0cbd2 blame: print unblamable and ignored commits in porcelain mode
---
 Documentation/blame-options.adoc |  3 ++-
 Documentation/git-blame.adoc     |  9 +++++----
 builtin/blame.c                  | 15 +++++++++++++++
 t/t8013-blame-ignore-revs.sh     | 20 ++++++++++++++++++++
 4 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/Documentation/blame-options.adoc b/Documentation/blame-options.adoc
index aa77406d4e..19ea187238 100644
--- a/Documentation/blame-options.adoc
+++ b/Documentation/blame-options.adoc
@@ -125,7 +125,8 @@ take effect.
 	another commit will be marked with a `?` in the blame output.  If the
 	`blame.markUnblamableLines` config option is set, then those lines touched
 	by an ignored commit that we could not attribute to another revision are
-	marked with a '*'.
+	marked with a '*'. In the porcelain modes, we print 'ignored' and
+	'unblamable' on a newline respectively.
 
 --ignore-revs-file <file>::
 	Ignore revisions listed in `file`, which must be in the same format as an
diff --git a/Documentation/git-blame.adoc b/Documentation/git-blame.adoc
index f75ed44790..e438d28625 100644
--- a/Documentation/git-blame.adoc
+++ b/Documentation/git-blame.adoc
@@ -135,10 +135,11 @@ header elements later.
 The porcelain format generally suppresses commit information that has
 already been seen. For example, two lines that are blamed to the same
 commit will both be shown, but the details for that commit will be shown
-only once. This is more efficient, but may require more state be kept by
-the reader. The `--line-porcelain` option can be used to output full
-commit information for each line, allowing simpler (but less efficient)
-usage like:
+only once. Information which is specific to individual lines will not be
+grouped together, like revs to be marked 'ignored' or 'unblamable'. This
+is more efficient, but may require more state be kept by the reader. The
+`--line-porcelain` option can be used to output full commit information
+for each line, allowing simpler (but less efficient) usage like:
 
 	# count the number of lines attributed to each author
 	git blame --line-porcelain file |
diff --git a/builtin/blame.c b/builtin/blame.c
index c470654c7e..528bfef249 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -351,6 +351,19 @@ static void emit_porcelain_details(struct blame_origin *suspect, int repeat)
 		write_filename_info(suspect);
 }
 
+/*
+ * Information which needs to be printed per-line goes here. Any
+ * information which can be clubbed on a commit/file level, should
+ * be printed via 'emit_one_suspect_detail()'.
+ */
+static void emit_per_line_details(struct blame_entry *ent)
+{
+	if (mark_unblamable_lines && ent->unblamable)
+		printf("unblamable\n");
+	if (mark_ignored_lines && ent->ignored)
+		printf("ignored\n");
+}
+
 static void emit_porcelain(struct blame_scoreboard *sb, struct blame_entry *ent,
 			   int opt)
 {
@@ -367,6 +380,7 @@ static void emit_porcelain(struct blame_scoreboard *sb, struct blame_entry *ent,
 	       ent->lno + 1,
 	       ent->num_lines);
 	emit_porcelain_details(suspect, repeat);
+	emit_per_line_details(ent);
 
 	cp = blame_nth_line(sb, ent->lno);
 	for (cnt = 0; cnt < ent->num_lines; cnt++) {
@@ -377,6 +391,7 @@ static void emit_porcelain(struct blame_scoreboard *sb, struct blame_entry *ent,
 			       ent->lno + 1 + cnt);
 			if (repeat)
 				emit_porcelain_details(suspect, 1);
+			emit_per_line_details(ent);
 		}
 		putchar('\t');
 		do {
diff --git a/t/t8013-blame-ignore-revs.sh b/t/t8013-blame-ignore-revs.sh
index 370b768149..306fc61057 100755
--- a/t/t8013-blame-ignore-revs.sh
+++ b/t/t8013-blame-ignore-revs.sh
@@ -158,6 +158,16 @@ test_expect_success mark_unblamable_lines '
 	test_cmp expect actual
 '
 
+for opt in --porcelain --line-porcelain
+do
+	test_expect_success 'mark_unblamable_lines with $opt' '
+		sha=$(git rev-parse Y) &&
+
+		git -c blame.markUnblamableLines=true blame $opt --ignore-rev Y file >actual &&
+		test $(grep ^unblamable actual | wc -l) -eq 2
+	'
+done
+
 # Commit Z will touch the first two lines.  Y touched all four.
 # 	A--B--X--Y--Z
 # The blame output when ignoring Z should be:
@@ -191,6 +201,16 @@ test_expect_success mark_ignored_lines '
 	! test_cmp expect actual
 '
 
+for opt in --porcelain --line-porcelain
+do
+	test_expect_success 'mark_ignored_lines line_porcelain' '
+		sha=$(git rev-parse Y) &&
+
+		git -c blame.markIgnoredLines=true blame $opt --ignore-rev Z file >actual &&
+		test $(grep ^ignored actual | wc -l) -eq 2
+	'
+done
+
 # For ignored revs that added 'unblamable' lines and more recent commits changed
 # the blamable lines, mark the unblamable lines with a
 # '*'

---

base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
change-id: 20250321-514-git-blame-1-s-porcelain-output-does-not-emit-unblamable-and-ignored-markers-4af46f02847e

Thanks
- Karthik

