Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD48E3090FB
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 21:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768598838; cv=none; b=aoMZrC4NRbVfD/q2Jn+x+Qt+oG6Xi4hw2jIwuZP8ZbINXsm7t2D3sUaRdG19nPyfvylhlqPNAHtREtpjmNbHQyroqNDnvP8HmTu0k3JYQiKL14CYytxDQcCeX+AJG9a2qH41X2aTyD6u7cE1cQE8JuZU0FWXnKCh57FVLh6JMpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768598838; c=relaxed/simple;
	bh=rLVJf4SAxI1OeTQIbZ08KWVXP48o1NHXgjTLD+mJHuw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gu+0QeRfPqAxDrhWdxXstXveJ7h8zUzCx0QS+OO0qQPVrVvZ2tv8SrlTKWSCVyzR/+S6REm6CDTT0+NWzb7mrmztDjHM5z/qXrGWMZkq1TTt/dIxr6ALHtqQtdSOhRgB7y2b9iJGdfaA8T30b0yVmCR2Td6iKf2gHfHgyNpYTcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hYfNFdEH; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYfNFdEH"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4801d1daf53so14829695e9.2
        for <git@vger.kernel.org>; Fri, 16 Jan 2026 13:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768598835; x=1769203635; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FGkIy9wAhShM0Mzicd2BhN7YiqjKjVwdMo2jeYNepWA=;
        b=hYfNFdEHC1KOlSXtWkS1Evk1SJMnJca9ie+5I73HvqUQ02HKidiO4FE6uhHC2njVtU
         tHtbcAikoKr7xNaGA9bPHa5MHrkCZlmk9sA//iZCMpgnHvTAvXD/xGmLFUNTXgzCgN73
         GpTmSefthjubYWo7idD7gdY91erSlbfFmwR43vgjG/x4nYq4MfNJ1vUxYXr5IZYkFCVJ
         eGoMgqt+q3RMDcTp6f6XAJiuSXMKHOuvyZDo69quMGh/e/3w1mSx4+s61eKLXpnzdLBk
         5fwgoi1dhGvOj1MqyeUu5AqHzOUicvh9f76pELsiTouX18bd/t07jLcVjOWp1GzlXGz9
         uqVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768598835; x=1769203635;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FGkIy9wAhShM0Mzicd2BhN7YiqjKjVwdMo2jeYNepWA=;
        b=DSMCHhSeUhR1uEkS2jcrX0y0/n5g/hTky8tJ75PSRCECr4vbWYoQk0P5Yo0RgrXNND
         aRVdE47dQMdfSCASKYjmqjq7I6ldasgP7r6R6h2YPFwo9xpuixdWzu0TC950bg0MxFCg
         oO4PZeauzh7gTUon6aG99e8gT3wnHbo+4K4/fhPKTy/CPhwqTZg4LDU4bedQJQfzK5BM
         AvmbNqdafI2wEnwpJnT99xJfxxvJ38lQObN50z0GVuw5dab45SAmxlhKEnYpbUAKJZlt
         PaQGxmSo1pP0hRKh7sICAQIDI8cfqiToEskTvq6jkmcYve0KxC9TSQScveVPcQowZS1d
         J1nw==
X-Gm-Message-State: AOJu0YxNKADBmrXw6Mkm6JY/aB0E2R0Eoj//NvCuwI/KQiSs+Cu2sfcq
	FbCZz6X1M6A20mahR+5w7JwtjLdgkEnlYmERN79nbozhsbLKK0xRPuVD
X-Gm-Gg: AY/fxX6Ogyy0mlDZt4cm18gfeVQFBDru30nmHI83v7OV5BpQrr/bv2Fp3Z8w2xaGTke
	nUaHWWr4Ukl4asSNNVJVxUlNTbODaWLnCMfB0tXSTsXoOsUe1r8wf3pBv6v/kQRpKSG4QDIvgYF
	XPVxkDWsq3WUek1iYajSpIOX7RWyz9uTza56tlX/ljJ3jIsDjMUtX2pbAlDEfMvAKYDAUZ1//ps
	lQQOSK8vIm1btuUbY36zbm18znin+kziq1aucRSXjB8XEM2JCAxBqsJQn9q+bY/XFAz4COyaXHM
	8ZGcPWdvZShCEl8/aPz6T+fDoRgqagNrTuSn6MLXnzRnCPMNpLKd3z0RiPnEQjXTfTlll8R2P83
	YGQdZyoIw/eqkx7vSHO3i+ak2VQ8kJpsr2rw8fMVo1aPafi0aUqikMWjGeh+cHT1euE/nn/zcg5
	XEXeBW4JC7roec/iKljBY=
X-Received: by 2002:a05:600c:8b09:b0:47e:e4f5:1910 with SMTP id 5b1f17b1804b1-4801e34a14fmr50401125e9.34.1768598834890;
        Fri, 16 Jan 2026 13:27:14 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:1edb:411c:5531:1628])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801fe67780sm23382025e9.16.2026.01.16.13.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 13:27:14 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 16 Jan 2026 22:27:09 +0100
Subject: [PATCH v2 4/7] update-ref: utilize rejected error details if
 available
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v2-4-925a0e9c7f32@gmail.com>
References: <20260116-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v2-0-925a0e9c7f32@gmail.com>
In-Reply-To: <20260116-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v2-0-925a0e9c7f32@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Elijah Newren <newren@gmail.com>, gitster@pobox.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=12211;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=rLVJf4SAxI1OeTQIbZ08KWVXP48o1NHXgjTLD+mJHuw=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGlqrS2ROwx56KIeuEVH1zsz3+Hf/H4zSWN5v
 J2NzYRQ1JkW0okBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpaq0tAAoJED7VnySO
 Rox/0zsL/A+NmStXGqACsR/p2zHwjHyp7YW6og4qlF4nIt/PF/NzUOvEZIDqhmRiY3UtlmkIttY
 1bEc6Q5YuNmFE2p1/8++vLZy9sNKx7IpBfcdWahZMxKxKXvOLAO8HnLGB91Yd3PRrsEgb5AWjzZ
 BHKDb/cfTooSUDDUtSbCDiyPKoPqAe3cCG5mROIZPIC6gbVmskt+0oihmiy3lW6h+0eHmbXYxID
 9ugtzpXMvaSzhESDrtLN0ZzCABU1BfN++7jiVH/YOROOAgytkgmNTG/hd/sCOZCZ2DV6uqxw97l
 MHYnKaAvrLtPnjmb7VwUTBZCeaqsfqZ48+nZZvBO4qylXdLQehuDGjpUCwSnCrp0FsAIXnYjEPW
 ogqA5V+M0N1GBKU7GwR6WChFjuea/Dkt0gJhvWtNRMZeAiX5bTzj4qXfwlVvvW5WQaOXX2q2U+P
 6v9An6cRmWPoh7RDOENvMFQhG1Wl4AEM3S9K2v4FoE2QZz9v+tAyn2Co08KlVIvKs2iD9/61bx5
 mw=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

When git-update-ref(1) received the '--update-ref' flag, the error
details generated in the refs namespace wasn't propagated with failed
updates. Instead only an error code pertaining to the type of rejection
was noted.

This missed detailed error message which the user can act upon. The
previous commits added the required code to propagate these detailed
error messages from the refs namespace. Now that additional details are
available, let's output this additional details to stderr. This allows
users to have additional information over the already present machine
parsable output.

While we're here, improve the existing tests for the machine parsable
output by checking for the entire output string and not just the
rejection reason.

Reported-by: Elijah Newren <newren@gmail.com>
Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/update-ref.c  |  8 +++---
 t/t1400-update-ref.sh | 71 ++++++++++++++++++++++++++++++---------------------
 2 files changed, 47 insertions(+), 32 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 0046a87c57..2d68c40ecb 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -573,16 +573,18 @@ static void print_rejected_refs(const char *refname,
 				const char *old_target,
 				const char *new_target,
 				enum ref_transaction_error err,
-				const char *details UNUSED,
+				const char *details,
 				void *cb_data UNUSED)
 {
 	struct strbuf sb = STRBUF_INIT;
-	const char *reason = ref_transaction_error_msg(err);
+
+	if (details && *details)
+		error("%s", details);
 
 	strbuf_addf(&sb, "rejected %s %s %s %s\n", refname,
 		    new_oid ? oid_to_hex(new_oid) : new_target,
 		    old_oid ? oid_to_hex(old_oid) : old_target,
-		    reason);
+		    ref_transaction_error_msg(err));
 
 	fwrite(sb.buf, sb.len, 1, stdout);
 	strbuf_release(&sb);
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index db7f5444da..db6585b8d8 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -2093,14 +2093,15 @@ do
 
 			format_command $type "update refs/heads/ref1" "$old_head" "$head" >stdin &&
 			format_command $type "update refs/heads/ref2" "$(test_oid 001)" "$head" >>stdin &&
-			git update-ref $type --stdin --batch-updates <stdin >stdout &&
+			git update-ref $type --stdin --batch-updates <stdin >stdout 2>err &&
 			echo $old_head >expect &&
 			git rev-parse refs/heads/ref1 >actual &&
 			test_cmp expect actual &&
 			echo $head >expect &&
 			git rev-parse refs/heads/ref2 >actual &&
 			test_cmp expect actual &&
-			test_grep -q "invalid new value provided" stdout
+			test_grep "rejected refs/heads/ref2 $(test_oid 001) $head invalid new value provided" stdout &&
+			test_grep "trying to write ref ${SQ}refs/heads/ref2${SQ} with nonexistent object" err
 		)
 	'
 
@@ -2119,14 +2120,15 @@ do
 
 			format_command $type "update refs/heads/ref1" "$old_head" "$head" >stdin &&
 			format_command $type "update refs/heads/ref2" "$head_tree" "$head" >>stdin &&
-			git update-ref $type --stdin --batch-updates <stdin >stdout &&
+			git update-ref $type --stdin --batch-updates <stdin >stdout 2>err &&
 			echo $old_head >expect &&
 			git rev-parse refs/heads/ref1 >actual &&
 			test_cmp expect actual &&
 			echo $head >expect &&
 			git rev-parse refs/heads/ref2 >actual &&
 			test_cmp expect actual &&
-			test_grep -q "invalid new value provided" stdout
+			test_grep "rejected refs/heads/ref2 $head_tree $head invalid new value provided" stdout &&
+			test_grep "trying to write non-commit object $head_tree to branch ${SQ}refs/heads/ref2${SQ}" err
 		)
 	'
 
@@ -2143,12 +2145,13 @@ do
 
 			format_command $type "update refs/heads/ref1" "$old_head" "$head" >stdin &&
 			format_command $type "update refs/heads/ref2" "$old_head" "$head" >>stdin &&
-			git update-ref $type --stdin --batch-updates <stdin >stdout &&
+			git update-ref $type --stdin --batch-updates <stdin >stdout 2>err &&
 			echo $old_head >expect &&
 			git rev-parse refs/heads/ref1 >actual &&
 			test_cmp expect actual &&
 			test_must_fail git rev-parse refs/heads/ref2 &&
-			test_grep -q "reference does not exist" stdout
+			test_grep "rejected refs/heads/ref2 $old_head $head reference does not exist" stdout &&
+			test_grep "cannot lock ref ${SQ}refs/heads/ref2${SQ}: unable to resolve reference ${SQ}refs/heads/ref2${SQ}" err
 		)
 	'
 
@@ -2166,13 +2169,14 @@ do
 
 			format_command $type "update refs/heads/ref1" "$old_head" "$head" >stdin &&
 			format_command $type "update refs/heads/ref2" "$old_head" "$head" >>stdin &&
-			git update-ref $type --no-deref --stdin --batch-updates <stdin >stdout &&
+			git update-ref $type --no-deref --stdin --batch-updates <stdin >stdout 2>err &&
 			echo $old_head >expect &&
 			git rev-parse refs/heads/ref1 >actual &&
 			test_cmp expect actual &&
 			echo $head >expect &&
 			test_must_fail git rev-parse refs/heads/ref2 &&
-			test_grep -q "reference does not exist" stdout
+			test_grep "rejected refs/heads/ref2 $old_head $head reference does not exist" stdout &&
+			test_grep "cannot lock ref ${SQ}refs/heads/ref2${SQ}: reference is missing but expected $head" err
 		)
 	'
 
@@ -2190,7 +2194,7 @@ do
 
 			format_command $type "update refs/heads/ref1" "$old_head" "$head" >stdin &&
 			format_command $type "symref-update refs/heads/ref2" "$old_head" "ref" "refs/heads/nonexistent" >>stdin &&
-			git update-ref $type --no-deref --stdin --batch-updates <stdin >stdout &&
+			git update-ref $type --no-deref --stdin --batch-updates <stdin >stdout 2>err &&
 			echo $old_head >expect &&
 			git rev-parse refs/heads/ref1 >actual &&
 			test_cmp expect actual &&
@@ -2198,7 +2202,8 @@ do
 			echo $head >expect &&
 			git rev-parse refs/heads/ref2 >actual &&
 			test_cmp expect actual &&
-			test_grep -q "expected symref but found regular ref" stdout
+			test_grep "rejected refs/heads/ref2 $ZERO_OID $ZERO_OID expected symref but found regular ref" stdout &&
+			test_grep "cannot lock ref ${SQ}refs/heads/ref2${SQ}: expected symref with target ${SQ}refs/heads/nonexistent${SQ}: but is a regular ref" err
 		)
 	'
 
@@ -2216,14 +2221,15 @@ do
 
 			format_command $type "update refs/heads/ref1" "$old_head" "$head" >stdin &&
 			format_command $type "update refs/heads/ref2" "$old_head" "$Z" >>stdin &&
-			git update-ref $type --stdin --batch-updates <stdin >stdout &&
+			git update-ref $type --stdin --batch-updates <stdin >stdout 2>err &&
 			echo $old_head >expect &&
 			git rev-parse refs/heads/ref1 >actual &&
 			test_cmp expect actual &&
 			echo $head >expect &&
 			git rev-parse refs/heads/ref2 >actual &&
 			test_cmp expect actual &&
-			test_grep -q "reference already exists" stdout
+			test_grep "rejected refs/heads/ref2 $old_head $ZERO_OID reference already exists" stdout &&
+			test_grep "cannot lock ref ${SQ}refs/heads/ref2${SQ}: reference already exists" err
 		)
 	'
 
@@ -2241,14 +2247,15 @@ do
 
 			format_command $type "update refs/heads/ref1" "$old_head" "$head" >stdin &&
 			format_command $type "update refs/heads/ref2" "$head" "$old_head" >>stdin &&
-			git update-ref $type --stdin --batch-updates <stdin >stdout &&
+			git update-ref $type --stdin --batch-updates <stdin >stdout 2>err &&
 			echo $old_head >expect &&
 			git rev-parse refs/heads/ref1 >actual &&
 			test_cmp expect actual &&
 			echo $head >expect &&
 			git rev-parse refs/heads/ref2 >actual &&
 			test_cmp expect actual &&
-			test_grep -q "incorrect old value provided" stdout
+			test_grep "rejected refs/heads/ref2 $head $old_head incorrect old value provided" stdout &&
+			test_grep "cannot lock ref ${SQ}refs/heads/ref2${SQ}: is at $head but expected $old_head" err
 		)
 	'
 
@@ -2264,12 +2271,13 @@ do
 			git update-ref refs/heads/ref/foo $head &&
 
 			format_command $type "update refs/heads/ref/foo" "$old_head" "$head" >stdin &&
-			format_command $type "update refs/heads/ref" "$old_head" "" >>stdin &&
-			git update-ref $type --stdin --batch-updates <stdin >stdout &&
+			format_command $type "update refs/heads/ref" "$old_head" "$ZERO_OID" >>stdin &&
+			git update-ref $type --stdin --batch-updates <stdin >stdout 2>err &&
 			echo $old_head >expect &&
 			git rev-parse refs/heads/ref/foo >actual &&
 			test_cmp expect actual &&
-			test_grep -q "refname conflict" stdout
+			test_grep "rejected refs/heads/ref $old_head $ZERO_OID refname conflict" stdout &&
+			test_grep "${SQ}refs/heads/ref/foo${SQ} exists; cannot create ${SQ}refs/heads/ref${SQ}" err
 		)
 	'
 
@@ -2284,13 +2292,14 @@ do
 			head=$(git rev-parse HEAD) &&
 			git update-ref refs/heads/ref/foo $head &&
 
-			format_command $type "update refs/heads/foo" "$old_head" "" >stdin &&
-			format_command $type "update refs/heads/ref" "$old_head" "" >>stdin &&
-			git update-ref $type --stdin --batch-updates <stdin >stdout &&
+			format_command $type "update refs/heads/foo" "$old_head" "$ZERO_OID" >stdin &&
+			format_command $type "update refs/heads/ref" "$old_head" "$ZERO_OID" >>stdin &&
+			git update-ref $type --stdin --batch-updates <stdin >stdout 2>err &&
 			echo $old_head >expect &&
 			git rev-parse refs/heads/foo >actual &&
 			test_cmp expect actual &&
-			test_grep -q "refname conflict" stdout
+			test_grep "rejected refs/heads/ref $old_head $ZERO_OID refname conflict" stdout &&
+			test_grep "${SQ}refs/heads/ref/foo${SQ} exists; cannot create ${SQ}refs/heads/ref${SQ}" err
 		)
 	'
 
@@ -2309,14 +2318,15 @@ do
 				format_command $type "create refs/heads/ref" "$old_head" &&
 				format_command $type "create refs/heads/Foo" "$old_head"
 			} >stdin &&
-			git update-ref $type --stdin --batch-updates <stdin >stdout &&
+			git update-ref $type --stdin --batch-updates <stdin >stdout 2>err &&
 
 			echo $head >expect &&
 			git rev-parse refs/heads/foo >actual &&
 			echo $old_head >expect &&
 			git rev-parse refs/heads/ref >actual &&
 			test_cmp expect actual &&
-			test_grep -q "reference conflict due to case-insensitive filesystem" stdout
+			test_grep "rejected refs/heads/Foo $old_head $ZERO_OID reference conflict due to case-insensitive filesystem" stdout &&
+			test_grep -e "cannot lock ref ${SQ}refs/heads/Foo${SQ}: Unable to create" -e "Foo.lock" err
 		)
 	'
 
@@ -2357,8 +2367,9 @@ do
 			git symbolic-ref refs/heads/symbolic refs/heads/non-existent &&
 
 			format_command $type "delete refs/heads/symbolic" "$head" >stdin &&
-			git update-ref $type --stdin --batch-updates <stdin >stdout &&
-			test_grep "reference does not exist" stdout
+			git update-ref $type --stdin --batch-updates <stdin >stdout 2>err &&
+			test_grep "rejected refs/heads/non-existent $ZERO_OID $head reference does not exist" stdout &&
+			test_grep "cannot lock ref ${SQ}refs/heads/symbolic${SQ}: unable to resolve reference ${SQ}refs/heads/non-existent${SQ}" err
 		)
 	'
 
@@ -2373,8 +2384,9 @@ do
 			head=$(git rev-parse HEAD) &&
 
 			format_command $type "delete refs/heads/new-branch" "$head" >stdin &&
-			git update-ref $type --stdin --batch-updates <stdin >stdout &&
-			test_grep "incorrect old value provided" stdout
+			git update-ref $type --stdin --batch-updates <stdin >stdout 2>err &&
+			test_grep "rejected refs/heads/new-branch $ZERO_OID $head incorrect old value provided" stdout &&
+			test_grep "cannot lock ref ${SQ}refs/heads/new-branch${SQ}: is at $(git rev-parse new-branch) but expected $head" err
 		)
 	'
 
@@ -2387,8 +2399,9 @@ do
 			head=$(git rev-parse HEAD) &&
 
 			format_command $type "delete refs/heads/non-existent" "$head" >stdin &&
-			git update-ref $type --stdin --batch-updates <stdin >stdout &&
-			test_grep "reference does not exist" stdout
+			git update-ref $type --stdin --batch-updates <stdin >stdout 2>err &&
+			test_grep "rejected refs/heads/non-existent $ZERO_OID $head reference does not exist" stdout &&
+			test_grep "cannot lock ref ${SQ}refs/heads/non-existent${SQ}: unable to resolve reference ${SQ}refs/heads/non-existent${SQ}" err
 		)
 	'
 done

-- 
2.51.2

