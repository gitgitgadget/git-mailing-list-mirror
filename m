Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116204;
	b=4KcsYQ4wRTStffV4fOQ1LYYWhyBYZ7ZDJYPKVkSb6l54FoNd1kJxvBochzTf1USlvmLW
	 4BpA6WJBVyvTIeMK8jfLEil58ZhkU2DqK99Hy95ZEFLWy9Is8MDRgxTP7OMuo6WSB7KDz
	 b+YAtaPqs4cpeSpJHLd0kRqYW8Zv2MNDt9UQLVfhq4AEZRUYfkWyc50jHjSSMyBjQCTuw
	 8sZKl26QacoWu0ZotFi1iqcnkVFtU3eRhthNDfMAH/k1q+ef59GnEe2D1XP6ea4jdRgtF
	 /h98MDj0M6QDzBtY5c2fBstvD7Qo2lfcLE0kYWC+DKw4xBwS6RvcRoj2WJqD0CQw7jQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116204;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=jb3MRrNIoVPjKz0sLOrz21qw+fSdqafQ0wY5bj2arH4=;
	b=vDpykQRz9tPHSwzkZPO6qTfhKfYaqCZVj4zxMb1JEegpWSWVhWCBoCu1lR2JFjMpqnjo
	 WkbpS6VJHwQ5CSdsdf8WwHEXjv4VQvyLVGKMNNmk0IMJCV+qIw5djR2oe4GkhlkQBfM1f
	 HsItLaHLj/yXP7qLccYSVEIyKAEd2Ts48xnYFWiHZX1UbRy08fyFbkRkNpdRLmBC7Ecgf
	 /9xVZcNHT5JAIzKerYEen6uWdYNjmyxW+nHJoEvd31uwjmokMGPnf/tSf58PVmRjlykJH
	 WztQQPW/GgZ220iNk3/MOOTryPl0MlQnHFveU1Azo7ZSoqwd58nqzaJ2Z/C797rc98g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmnk.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XMAsPwrZ;
	arc=none smtp.remote-ip=209.85.208.70
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842F7606A320
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 19:23:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 842F7606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmnk.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XMAsPwrZ
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6b582b355eeso87986a12.3
        for <git@vger.kernel.org>; Thu, 19 Nov 2026 11:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795116203; x=1795721003; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jb3MRrNIoVPjKz0sLOrz21qw+fSdqafQ0wY5bj2arH4=;
        b=XMAsPwrZICKQRrcN9XFkvffr5gRSLGH+TFMeL2gx2rvM7FhEalrST3pBJ6XL8gdje5
         T0A1dvPHYrqHKlINKmIw6ZxUoLAQiUcxzue4JDY8srxHAhB6oo16Vump+llnbMNAsLN3
         CbEq3DYpNRcnnOEiEaSV69jkY8zfZSibAMiq+t+6Ois+3q+E+XdeyKC+xkq6IUybhD4r
         jGVyfcCpjKwRKFsTwMHiKCpNk4lRBd0fHmV+IUQDzLkn0X0v4WHwvR3Fa8W3fOQmi6WR
         F3QOKE5GFgHXhy0q10r1REZzXiZlKleaWtzzuOxLED1GRgUAGbYYZRea/R1hU2nxTZby
         Bvew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795116203; x=1795721003;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jb3MRrNIoVPjKz0sLOrz21qw+fSdqafQ0wY5bj2arH4=;
        b=drY0itXJCtNyVs+cC5CgzkK7rYn+VLOqadRU9gsdEMJAOIwZm3mMq8YucfxiVyTnDw
         B5Rgbn0MRNzvxtoxk2PJWWbhVJIyFZioNaLxae2t+L+oHuDYVx4m1xNSZeEiTIrBuby4
         XRXR9nXU2Bp3tOYih89MxbhwpTqlOZ3GEEwzQ2RF9LXIg0+JxfT3hh2Tz57nq69AaTvP
         p4/LFAlc7Ej1QMhvMniwSIBqru6HMY/KQVpKOm+ncwv1L0fi9ZpPLZl0aoTUY3rRiKMP
         IAcKKzMR41XEb/AgVE2C2Uzr9djuPHRsYC0OzwTCKRq4T/jvZFNufI6TM2GmgedbGegZ
         GYBg==
X-Gm-Message-State: APuU4Z+beWbnoplwqmxN2CoSsX7AmAN5hVkACgFnq7gavRoa/fvY8wRb
	0sRjXTLcHeYJpdb3LLyePb4tdd/rpDkJ9vaHz0ahxAMSEH9MBY1ckBYxq9umkIaJedG6LXcyeMd
	twc0lutc/x/UMBC/j49MRo62fhnL5s0v5SuwXnL5vlP7O8wNGVYr1ODv4OwtHSZvVAAV0Pzr5zn
	OTPZhj5x1Rt/Ir2ZosHaALPw==
X-Received: from edc27-n2.prod.google.com ([2002:a05:6402:461b:20b0:6b8:afbd:bc1a])
 (user=dmnk job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:1d4b:b0:6b7:9ced:824
 with SMTP id 4fb4d7f45d1cf-6ba37e97cf6mr300510a12.26.1795116202515; Thu, 19
 Nov 2026 11:23:22 -0800 (PST)
Date: Thu, 19 Nov 2026 20:23:21 +0100
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261119192321.2690660-1-dmnk@google.com>
Subject: [PATCH] cvsexportcommit: avoid shell in -W git calls
From: Dominik Maier <dmnk@google.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, dmnk+artist@google.com, 
	Dominik Maier <dmnk@google.com>
Content-Type: text/plain; charset="UTF-8"

When "-W" is enabled, git-cvsexportcommit reads "$go_back_to" from
"git symbolic-ref HEAD" and passes it unquoted to single-argument
system("git checkout $go_back_to") and system("git symbolic-ref HEAD
$go_back_to"). Valid Git branch names may contain shell metacharacters
such as ';', causing Perl to invoke "/bin/sh -c" and split or execute
unintended shell tokens instead of restoring HEAD.

Chomp "$go_back_to" and invoke list-form system('git', ...) for the "-W"
checkout and symbolic-ref calls so git is executed directly without a
shell.

Signed-off-by: Dominik Maier <dmnk@google.com>
---
 git-cvsexportcommit.perl       | 11 +++++++----
 t/t9200-git-cvsexportcommit.sh | 19 +++++++++++++++++++
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index edf02f9964..ce21d1ac8f 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -142,7 +142,9 @@
     $opt_v && print "Resetting to $parent\n";
     $go_back_to = `git symbolic-ref HEAD 2> /dev/null ||
 	git rev-parse HEAD` || die "Could not determine current branch";
-    system("git checkout -q $parent^0") && die "Could not check out $parent^0";
+    chomp $go_back_to;
+    system('git', 'checkout', '-q', "$parent^0") &&
+	die "Could not check out $parent^0";
 }
 
 $opt_v && print "Applying to CVS commit $commit from parent $parent\n";
@@ -331,7 +333,7 @@
 
 print "Applying\n";
 if ($opt_W) {
-    system("git checkout -q $commit^0") && die "cannot patch";
+    system('git', 'checkout', '-q', "$commit^0") && die "cannot patch";
 } else {
     `GIT_INDEX_FILE=$tmpdir/index git apply $context --summary --numstat --apply <.cvsexportcommit.diff` || die "cannot patch";
 }
@@ -410,9 +412,10 @@
 unlink(".cvsexportcommit.diff");
 
 if ($opt_W) {
-    system("git checkout $go_back_to") && die "cannot move back to $go_back_to";
+    system('git', 'checkout', '--end-of-options', $go_back_to, '--') &&
+	die "cannot move back to $go_back_to";
     if (!($go_back_to =~ /^[0-9a-fA-F]{$hexsz}$/)) {
-	system("git symbolic-ref HEAD $go_back_to") &&
+	system('git', 'symbolic-ref', 'HEAD', $go_back_to) &&
 	    die "cannot move back to $go_back_to";
     }
 }
diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
index 8e0272df20..74058f0128 100755
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -341,4 +341,23 @@ test_expect_success 'use the same checkout for Git and CVS' '
 
 '
 
+test_expect_success 'cvsexportcommit -W handles shell metacharacters in branch name' '
+	(
+		mkdir shared_meta &&
+		cd shared_meta &&
+		sane_unset GIT_DIR &&
+		cvs co . &&
+		git init &&
+		git checkout -b "topic;false" &&
+		echo init >meta_base &&
+		git add meta_base &&
+		git commit -m "initial" &&
+		echo added >meta_new &&
+		git add meta_new &&
+		git commit -m "add meta_new" &&
+		git cvsexportcommit -W -p -u -c HEAD &&
+		test "$(git symbolic-ref HEAD)" = "refs/heads/topic;false"
+	)
+'
+
 test_done
-- 
2.56.1.750.gf70dc682cf-goog

