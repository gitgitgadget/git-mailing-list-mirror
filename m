Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504856;
	b=WcjFalCKCeZrdCfdrwim/O3uJKXxmVy4gdW6xS5kqrxqW8Yq9N0GBKSqFGjw0cyD9o/v
	 cZe5n6EPuf9dxMC6iaW9FgMfxO13bJo0u5R1Nu7Rcf4PAlykfF29oWmAYXg9km0q2//jy
	 uRk/Evh9CbwzS6kcMrdh30KOY4GuvtEc5T7+mv+YKxVsflfjIG5q2I9B64ns50HumS2Vb
	 mmz00Bq8Kgeli0YNUDPv81b3Z60CIbwTL8PEOqzYroReCFOelyWTY0v8uIhEKQiVx6K1i
	 R8EsCTL3U6kH26fS1dETJJotcyJR3pFhDKXuboCa0tBRvKIsw0AdHu9WSKPK6eEHW2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504856;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=uzE0Fn75wkky/NNobYZY+rH1Y705t/ds8bUZew1I9Po=;
	b=uQxClHcwrgJOT4lvqBvw7LtVb83/r0hc45iCGAG42n1g6rbhdLaDARLmpeG+LsxrrmJR
	 1/dnjWzKHl/hoZeC1tA7yfegzPe7SoYLunhlumyKdjz3w+QCUPK1kcWnNfCWq8WGG1ADU
	 FNsCXlKZg+AzzCZTQ7XWNEkudhzFP24n6hUPyPIGQrCDc3myh3/x2wxsiG4U6TbhgtuhB
	 Xazz0PxLpMQwIbM8bjzF22oXEFg7f3/iYBaaVaqxF7eKypsL1RJko65bpz64RqgAOQyw1
	 t71jbwpqcbIScCKIVLjnESGunSW4aPZn+RYMhe3EUasS+0gnYCw23UHFq3qHfYzVkYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aX3XhNWn;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3B960A2639
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 17:34:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B3B960A2639
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aX3XhNWn
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4b4571ff080so606635e9.1
        for <git@vger.kernel.org>; Thu, 12 Nov 2026 09:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794504855; x=1795109655; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uzE0Fn75wkky/NNobYZY+rH1Y705t/ds8bUZew1I9Po=;
        b=aX3XhNWnvom6tXPqx20gT1+OnrLXTA7CBs07fX3Xbc4zgwqnE3WiK6vVAyN3uBFzVw
         iXlvZxqA4XghD2UTyxzG/jAPCmP8ue7BWoeZOnGsroG8gEoWilkIz87ay90Z3Sr01PuP
         Vlrh9+PSP2lguFwNsuumX2KAnYp10mX5B5JphnrHbarzeOxWiilc2bJ788VMBerr5Rfm
         KF1In/NZDhEJzdeID7B14awhhRCtOVnTZmjEy/FXGs5c1ap9zsBO2FW9l1pwoaVPvVSK
         BpCEIo3k5ZH/utc+iR7A/w2n1cefLS/y/TjqBfitHuaaU9HOEPBITkjUTgMej8NlyhbH
         ywhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794504855; x=1795109655;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uzE0Fn75wkky/NNobYZY+rH1Y705t/ds8bUZew1I9Po=;
        b=BkNjpACfH32Eukw7zLPkWGK5E2Bt3OzmiqiZ877rkXP27gUpebmneH2tqd5GRruyIg
         HFMG0zwyWyALrWBDxOsE3e6cjtM3BWGQRdJ6XQHzaLQzWxbIO/Ey4q54/s+uL3SMtoZ6
         F3oWtXjKAAvBIUUQSo8o6g9YsrqKTiQgpOdQC2kmxdKh0tID/wLjV4KtFt5z2na+Hg5T
         m7GMgngIxsK/kyZBLdcGWnr+2z4fmDO/13+8vWi9ci8djpDPd92rYuARvwigOnwp/RuT
         J+fnhXQK7uvxZ0njJdz4nnvyx6pgg5Dwc6PH0Mur1Jp54VnSCS2y+lFK1BL46jZqS0mB
         +5Fw==
X-Gm-Message-State: APuU4Z+R7ZNiJ0Fz/dZvazSHxZu1hXqU/ld7FAlr8tagvZGUzlWgXLyf
	wNsKNNgkCixDLE5RKO4C3jfzx8FAeiH95ppt51obTpRKc9MvXFIA4IzMsUIyZw==
X-Gm-Gg: AYBFou0uDZoqVDmA486iaCIo7zuao0oOh946Oe2XZbdHVo8NCHL1ACBSsm4Ya6tuQI6
	K4fUDIJR6M8iFPxrKMWgAdZYaHqj6nf0UFn2hyL/rNRJq/S0y87a57e897VK6Zc9bjX9zhUT0ep
	le1FJIlz5q8LrYKEmHZiFDp21BaSRRuTq0kXLL/uilk+ZOoatYNQkAgI1i/ZaiD2Fp19tGhkUlm
	3LbrIIa2nUln09jw46yaFKae5vkSGCf47xWDLhqE+brlD9mFy9lPmNi3LpQP6Sc5b2UtTAuLsUV
	iIv9hZvc3g3Yw1zaB5V/PjGfZ3LQBWf11WHQZ1q/ZEVb+REa7tu23/NMiClVt5e60yhRmqWSnnb
	E/VUj09RDg5at7btoxzkbcvdjV0sc07PdIqUqSTk7hRDkN0q+p+H5dH9lASu/6qRaiwh9TJWnvu
	A7QzQpqD2sjRdzpZqwc/e23N0HL58LtSSiFAmYDHUTAClxFKjiUk+RjWrWNQlZCvWVdsm9rEVgy
	f/X1k/2iSApBryHQd4uXLqCG343K9mPbm8hIAWwZmpK6g8ne77IRI9BxZLr0kSs9cPC96abu37j
	gt968y2ndC6y/Yv1z1NFAFTWExaLj0ib4lsIv8N2gfC09E4sFC+2btiJ3auIgxZDFkra
X-Received: by 2002:a05:6000:1445:b0:48e:60ed:b012 with SMTP id ffacd0b85a97d-49c72306b93mr124592f8f.57.1794504854445;
        Thu, 12 Nov 2026 09:34:14 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:cb2b:22fd:d791:9595])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c604ee47dsm345988f8f.38.2026.11.12.09.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 09:34:14 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 12 Nov 2026 18:34:02 +0100
Subject: [PATCH v2 02/20] t9300: make the series B tests self-contained
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-kn-fast-import-tests-1-v2-2-b8c3a0ab27e8@gmail.com>
References: <20261112-kn-fast-import-tests-1-v2-0-b8c3a0ab27e8@gmail.com>
In-Reply-To: <20261112-kn-fast-import-tests-1-v2-0-b8c3a0ab27e8@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=14373;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=ixFBSEa8Ds9rAUW2LIWI6byL7LdysVBBklLqZJLM/bs=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGr1+JAWFvKaQeTu/R8vGEXuI+DNwUYja25o0
 GUMnyy8+ZHywIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJq9fiQAAoJED7VnySO
 Rox/m+kL/id1C7RtGp2k3/wNv6Giq46FZqQzRQhJCx9paVeVvuNAwNxNTiJZ96t2WdUFRyRFbfH
 2TLLTRxkUqRhXM6MOxidhnKJ/T78KAmTA4NDuAy5LzCTWtgW2sOBF5KwR6wWLy7y0+Hx5hsvsBl
 Nfr6Djc4ZHSXkZjocgaZiKI0DxtzERrKu6+FV3sguhZ6z1Y2fDxsH+8wvZn1ac0OwLh8uUMnDkt
 KoqIii4SA5l9sqgzhzi1XCzvk9VcmIw6bIGYtpmKPmEk8cTX34DcsLd8tkOUJM3TvqqkoXfSaG+
 ZhTYJ3Jfu+ZMoBJn83R9ibVKxGIzyTdkQYpwfbsuKOfTNCydo4OyKKfV0Jb0piHSKcwPWvJsWbI
 Grxdp3LlUfqVKSqaHmXQyF8pBgraillHPpoh94x7qnWjcd04tmdJAY+8oelY6LWqohfYOkHYtF2
 z3ziKghjR4BisyYT0VdXHc/vUulnuv+Qg2Z3cco87usrtQYV3vciN+EPAfWkRJKPcZU55CQrrg6
 sE=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The 't/t9300-fast-import.sh' test file contains numerous tests and is
currently just shy of 4000 lines. This is because the file contains
tests over multiple series, each series testing particular functionality
or sections of 'git-fast-import(1)'. In upcoming commits, we want to
split out these tests into individual files for better discoverability.

First, we need to remove the dependency tests have on preceding tests.
Modify the tests in 'series B' to each run in a new repository, which is
removed when the test completes, so that they neither depend on nor
leave behind any state.

The 'B: fail on invalid blob sha1' and 'B: accept branch name
"TEMP_TAG"' tests import on top of 'main', which used to exist from
earlier tests. Create it with 'test_commit', so that the first import
can only fail because of the invalid blob ID.

The 'fsck' tests require the whole repository to be free of unreachable
objects. They only passed because of the garbage collection in the
cleanup of other tests. A new repository makes that unnecessary.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 t/t9300-fast-import.sh | 472 ++++++++++++++++++++++++++++---------------------
 1 file changed, 275 insertions(+), 197 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 4cffe43a71..e2cf0b7a22 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -358,274 +358,352 @@ test_expect_success 'A: export marks with large values' '
 ###
 
 test_expect_success 'B: fail on invalid blob sha1' '
-	test_tick &&
-	cat >input <<-INPUT_END &&
-	commit refs/heads/branch
-	mark :1
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	data <<COMMIT
-	corrupt
-	COMMIT
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit base &&
 
-	from refs/heads/main
-	M 755 $(echo $ZERO_OID | sed -e "s/0$/1/") zero1
+		test_tick &&
+		cat >input <<-INPUT_END &&
+		commit refs/heads/branch
+		mark :1
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		corrupt
+		COMMIT
 
-	INPUT_END
+		from refs/heads/main
+		M 755 $(echo $ZERO_OID | sed -e "s/0$/1/") zero1
 
-	test_when_finished "rm -f .git/objects/pack_* .git/objects/index_*" &&
-	test_must_fail git fast-import <input
+		INPUT_END
+
+		test_must_fail git fast-import <input
+	)
 '
 
 test_expect_success 'B: accept branch name "TEMP_TAG"' '
-	cat >input <<-INPUT_END &&
-	commit TEMP_TAG
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	data <<COMMIT
-	tag base
-	COMMIT
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit new &&
 
-	from refs/heads/main
+		cat >input <<-INPUT_END &&
+		commit TEMP_TAG
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		tag base
+		COMMIT
 
-	INPUT_END
+		from refs/heads/main
 
-	test_when_finished "rm -f .git/TEMP_TAG && git gc --prune=now" &&
-	git fast-import <input &&
-	test $(test-tool ref-store main resolve-ref TEMP_TAG 0 | cut -f1 -d " " ) != "$ZERO_OID" &&
-	test $(git rev-parse main) = $(git rev-parse TEMP_TAG^)
+		INPUT_END
+
+		git fast-import <input &&
+		test $(test-tool ref-store main resolve-ref TEMP_TAG 0 | cut -f1 -d " " ) != "$ZERO_OID" &&
+		test $(git rev-parse main) = $(git rev-parse TEMP_TAG^)
+	)
 '
 
 test_expect_success 'B: accept empty committer' '
-	cat >input <<-INPUT_END &&
-	commit refs/heads/empty-committer-1
-	committer  <> $GIT_COMMITTER_DATE
-	data <<COMMIT
-	empty commit
-	COMMIT
-	INPUT_END
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		cat >input <<-INPUT_END &&
+		commit refs/heads/empty-committer-1
+		committer  <> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		empty commit
+		COMMIT
+		INPUT_END
 
-	test_when_finished "git update-ref -d refs/heads/empty-committer-1
-		git gc --prune=now" &&
-	git fast-import <input &&
-	out=$(git fsck) &&
-	echo "$out" &&
-	test -z "$out"
+		git fast-import <input &&
+		out=$(git fsck) &&
+		echo "$out" &&
+		test -z "$out"
+	)
 '
 
 test_expect_success 'B: reject invalid timezone' '
-	cat >input <<-INPUT_END &&
-	commit refs/heads/invalid-timezone
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1234567890 +051800
-	data <<COMMIT
-	empty commit
-	COMMIT
-	INPUT_END
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
 
-	test_when_finished "git update-ref -d refs/heads/invalid-timezone" &&
-	test_must_fail git fast-import <input
+		cat >input <<-INPUT_END &&
+		commit refs/heads/invalid-timezone
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1234567890 +051800
+		data <<COMMIT
+		empty commit
+		COMMIT
+		INPUT_END
+
+		test_must_fail git fast-import <input
+	)
 '
 
 test_expect_success 'B: accept invalid timezone with raw-permissive' '
-	cat >input <<-INPUT_END &&
-	commit refs/heads/invalid-timezone
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1234567890 +051800
-	data <<COMMIT
-	empty commit
-	COMMIT
-	INPUT_END
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
 
-	git init invalid-timezone &&
-	git -C invalid-timezone fast-import --date-format=raw-permissive <input &&
-	git -C invalid-timezone cat-file -p invalid-timezone >out &&
-	test_grep "1234567890 [+]051800" out
+		cat >input <<-INPUT_END &&
+		commit refs/heads/invalid-timezone
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1234567890 +051800
+		data <<COMMIT
+		empty commit
+		COMMIT
+		INPUT_END
+
+		git fast-import --date-format=raw-permissive <input &&
+		git cat-file -p invalid-timezone >out &&
+		test_grep "1234567890 [+]051800" out
+	)
 '
 
 test_expect_success 'B: accept and fixup committer with no name' '
-	cat >input <<-INPUT_END &&
-	commit refs/heads/empty-committer-2
-	committer <a@b.com> $GIT_COMMITTER_DATE
-	data <<COMMIT
-	empty commit
-	COMMIT
-	INPUT_END
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		cat >input <<-INPUT_END &&
+		commit refs/heads/empty-committer-2
+		committer <a@b.com> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		empty commit
+		COMMIT
+		INPUT_END
 
-	test_when_finished "git update-ref -d refs/heads/empty-committer-2
-		git gc --prune=now" &&
-	git fast-import <input &&
-	out=$(git fsck) &&
-	echo "$out" &&
-	test -z "$out"
+		git fast-import <input &&
+		out=$(git fsck) &&
+		echo "$out" &&
+		test -z "$out"
+	)
 '
 
 test_expect_success 'B: fail on invalid committer (1)' '
-	cat >input <<-INPUT_END &&
-	commit refs/heads/invalid-committer
-	committer Name email> $GIT_COMMITTER_DATE
-	data <<COMMIT
-	empty commit
-	COMMIT
-	INPUT_END
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
 
-	test_when_finished "git update-ref -d refs/heads/invalid-committer" &&
-	test_must_fail git fast-import <input
+		cat >input <<-INPUT_END &&
+		commit refs/heads/invalid-committer
+		committer Name email> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		empty commit
+		COMMIT
+		INPUT_END
+
+		test_must_fail git fast-import <input
+	)
 '
 
 test_expect_success 'B: fail on invalid committer (2)' '
-	cat >input <<-INPUT_END &&
-	commit refs/heads/invalid-committer
-	committer Name <e<mail> $GIT_COMMITTER_DATE
-	data <<COMMIT
-	empty commit
-	COMMIT
-	INPUT_END
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
 
-	test_when_finished "git update-ref -d refs/heads/invalid-committer" &&
-	test_must_fail git fast-import <input
+		cat >input <<-INPUT_END &&
+		commit refs/heads/invalid-committer
+		committer Name <e<mail> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		empty commit
+		COMMIT
+		INPUT_END
+
+		test_must_fail git fast-import <input
+	)
 '
 
 test_expect_success 'B: fail on invalid committer (3)' '
-	cat >input <<-INPUT_END &&
-	commit refs/heads/invalid-committer
-	committer Name <email>> $GIT_COMMITTER_DATE
-	data <<COMMIT
-	empty commit
-	COMMIT
-	INPUT_END
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
 
-	test_when_finished "git update-ref -d refs/heads/invalid-committer" &&
-	test_must_fail git fast-import <input
+		cat >input <<-INPUT_END &&
+		commit refs/heads/invalid-committer
+		committer Name <email>> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		empty commit
+		COMMIT
+		INPUT_END
+
+		test_must_fail git fast-import <input
+	)
 '
 
 test_expect_success 'B: fail on invalid committer (4)' '
-	cat >input <<-INPUT_END &&
-	commit refs/heads/invalid-committer
-	committer Name <email $GIT_COMMITTER_DATE
-	data <<COMMIT
-	empty commit
-	COMMIT
-	INPUT_END
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
 
-	test_when_finished "git update-ref -d refs/heads/invalid-committer" &&
-	test_must_fail git fast-import <input
+		cat >input <<-INPUT_END &&
+		commit refs/heads/invalid-committer
+		committer Name <email $GIT_COMMITTER_DATE
+		data <<COMMIT
+		empty commit
+		COMMIT
+		INPUT_END
+
+		test_must_fail git fast-import <input
+	)
 '
 
 test_expect_success 'B: fail on invalid committer (5)' '
-	cat >input <<-INPUT_END &&
-	commit refs/heads/invalid-committer
-	committer Name<email> $GIT_COMMITTER_DATE
-	data <<COMMIT
-	empty commit
-	COMMIT
-	INPUT_END
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
 
-	test_when_finished "git update-ref -d refs/heads/invalid-committer" &&
-	test_must_fail git fast-import <input
+		cat >input <<-INPUT_END &&
+		commit refs/heads/invalid-committer
+		committer Name<email> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		empty commit
+		COMMIT
+		INPUT_END
+
+		test_must_fail git fast-import <input
+	)
 '
 
 test_expect_success 'B: fail on invalid file path of ..' '
-	cat >input <<-INPUT_END &&
-	blob
-	mark :1
-	data <<EOF
-	File contents
-	EOF
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
 
-	commit refs/heads/badpath
-	committer Name <email> $GIT_COMMITTER_DATE
-	data <<COMMIT
-	Commit Message
-	COMMIT
-	M 100644 :1 ../invalid-path
-	INPUT_END
+		cat >input <<-INPUT_END &&
+		blob
+		mark :1
+		data <<EOF
+		File contents
+		EOF
 
-	test_when_finished "git update-ref -d refs/heads/badpath" &&
-	test_must_fail git fast-import <input
+		commit refs/heads/badpath
+		committer Name <email> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		Commit Message
+		COMMIT
+		M 100644 :1 ../invalid-path
+		INPUT_END
+
+		test_must_fail git fast-import <input
+	)
 '
 
 test_expect_success 'B: fail on invalid file path of .' '
-	cat >input <<-INPUT_END &&
-	blob
-	mark :1
-	data <<EOF
-	File contents
-	EOF
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
 
-	commit refs/heads/badpath
-	committer Name <email> $GIT_COMMITTER_DATE
-	data <<COMMIT
-	Good path
-	COMMIT
-	M 100644 :1 ok-path
+		cat >input <<-INPUT_END &&
+		blob
+		mark :1
+		data <<EOF
+		File contents
+		EOF
 
-	commit refs/heads/badpath
-	committer Name <email> $GIT_COMMITTER_DATE
-	data <<COMMIT
-	Bad path
-	COMMIT
-	R ok-path ./invalid-path
-	INPUT_END
+		commit refs/heads/badpath
+		committer Name <email> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		Good path
+		COMMIT
+		M 100644 :1 ok-path
 
-	test_when_finished "git update-ref -d refs/heads/badpath" &&
-	test_must_fail git fast-import <input
+		commit refs/heads/badpath
+		committer Name <email> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		Bad path
+		COMMIT
+		R ok-path ./invalid-path
+		INPUT_END
+
+		test_must_fail git fast-import <input
+	)
 '
 
 test_expect_success WINDOWS 'B: fail on invalid file path of C:' '
-	cat >input <<-INPUT_END &&
-	blob
-	mark :1
-	data <<EOF
-	File contents
-	EOF
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
 
-	commit refs/heads/badpath
-	committer Name <email> $GIT_COMMITTER_DATE
-	data <<COMMIT
-	Commit Message
-	COMMIT
-	M 100644 :1 C:/invalid-path
-	INPUT_END
+		cat >input <<-INPUT_END &&
+		blob
+		mark :1
+		data <<EOF
+		File contents
+		EOF
 
-	test_when_finished "git update-ref -d refs/heads/badpath" &&
-	test_must_fail git fast-import <input
+		commit refs/heads/badpath
+		committer Name <email> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		Commit Message
+		COMMIT
+		M 100644 :1 C:/invalid-path
+		INPUT_END
+
+		test_must_fail git fast-import <input
+	)
 '
 
 test_expect_success 'B: fail on invalid file path of .git' '
-	cat >input <<-INPUT_END &&
-	blob
-	mark :1
-	data <<EOF
-	File contents
-	EOF
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
 
-	commit refs/heads/badpath
-	committer Name <email> $GIT_COMMITTER_DATE
-	data <<COMMIT
-	Commit Message
-	COMMIT
-	M 100644 :1 .git/invalid-path
-	INPUT_END
+		cat >input <<-INPUT_END &&
+		blob
+		mark :1
+		data <<EOF
+		File contents
+		EOF
 
-	test_when_finished "git update-ref -d refs/heads/badpath" &&
-	test_must_fail git fast-import <input
+		commit refs/heads/badpath
+		committer Name <email> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		Commit Message
+		COMMIT
+		M 100644 :1 .git/invalid-path
+		INPUT_END
+
+		test_must_fail git fast-import <input
+	)
 '
 
 test_expect_success 'B: fail on invalid file path of .gitmodules' '
-	cat >input <<-INPUT_END &&
-	blob
-	mark :1
-	data <<EOF
-	File contents
-	EOF
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
 
-	commit refs/heads/badpath
-	committer Name <email> $GIT_COMMITTER_DATE
-	data <<COMMIT
-	Commit Message
-	COMMIT
-	M 120000 :1 .gitmodules
-	INPUT_END
+		cat >input <<-INPUT_END &&
+		blob
+		mark :1
+		data <<EOF
+		File contents
+		EOF
 
-	test_when_finished "git update-ref -d refs/heads/badpath" &&
-	test_must_fail git fast-import <input
+		commit refs/heads/badpath
+		committer Name <email> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		Commit Message
+		COMMIT
+		M 120000 :1 .gitmodules
+		INPUT_END
+
+		test_must_fail git fast-import <input
+	)
 '
 
 ###

-- 
2.56.GIT

