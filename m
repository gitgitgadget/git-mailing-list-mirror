Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794311408;
	b=CWQ8L4yoi/tJ7ZBujQ+ZWIuQY5rLHPJiyDgz4irG/esDQ8WRll1HMbJefiVpGG+fZRTg
	 YxWHl8EkEL/tAyKnS/FKVgM9QqjF8ytKMY3z67MNkWugRNiQSHusL/iB8bO3E0t19e8WI
	 2Ly2XP5EuNRtWcU2J68KJaV7DqFSqZi+gDphqDYsfIm0XRTL6u9rZKmaShycRF8ZzARld
	 v0inO8FEnny4tOOM9RMw2eZ+HInSoB3bc1ZghHKiym3YReNiIO3dPFuSRkfGOdp0vjXM3
	 ZZFxNd+TlMoSZ1V7Vc8zHgbdiSBglfcTKgAEpirVyk4QRucUptpaK9dZjUF8tG6ZfEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311408;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=z4U3TVtqCIXXo6ALR7xqXprigSarVm7QZzmG9t42huI=;
	b=b4oVAI/KTyqWhQ6nB5Y4afpH+m/iZgvVZeR4e1HugkeD5kW2M6oD8sc2/IUmXAXwK4Qw
	 XD2tsUhYJrGQkkMBBVigkFFy6P+PYauITmSMkMkMvqODVCDRLlv0zmFs90kuUfwq3lQZD
	 Hb/1N6wq+oRlECTNF+jRxx0AcHgguwMui9I95SWlEetlAnx3SEcT7UKuAvqmWy7DkDVoq
	 VnNHA7BOEL6agjr1J+RQmiW7TbMVrNYLwBEEQXkGwXYJfxlw4DjDpfAOHREW1oBTixjW8
	 ehoj4BBnkJJQzs9FYyj0RRbJ1QfRxO3vX+GKsgomz+8SStnytoA5+jlJlQv9RJY84lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q502RAAT;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB8F60A6F55
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 11:50:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CB8F60A6F55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q502RAAT
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a5b2be99a8so16106575e9.2
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 03:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794311406; x=1794916206; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z4U3TVtqCIXXo6ALR7xqXprigSarVm7QZzmG9t42huI=;
        b=Q502RAAT4i281QHfbosDGyrOU9AxZVfWFjDMFyzmd6Ad46wpMPbU5o6+ZQm1XWszEv
         GHNfuPO49FQYuvYJFMwgZzexQt9OqBNBmDgt3+I4Aj0ON/VmoWUrrUouwdALU34N0IcK
         TBR+thMuCwDVaP/GaGENgpvUORsr04GDnm+hcGVNQtiZ4drv/UG2xGtLw89hijG4gusD
         wOsYSx/z7imXUuXupdJUukoVpGJN2ge/7Wb5I+mBjMN3UT3REagDO4xdcecw7yK4r2uJ
         HV3eDg6A1dMm+05a7/RlaOINEjaJ5fVzNe4kUQBe1zxSbOeTQTmqVGvsupDr+3ua57DU
         N/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794311406; x=1794916206;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z4U3TVtqCIXXo6ALR7xqXprigSarVm7QZzmG9t42huI=;
        b=FwOgLNdFUuCElPZGMLYQGddMxSDKRkh0OBwikzVF1Ps5Qht5MgL5SgjbvtUchBVVWe
         uQiIwsVb/XqVLjVUBHaGH9sH9BvQ4+kcAIXJzzJ0yagm1Jjk28tkEYlnMrfvO2Ni9R1l
         BLtsV/ZNRjQ6n6Ol5tdy3yI2N1IUnt/33o1Bd2snihSFmUYtpkD8YI1A/oQ6c9lqKG4r
         IBfxSQAes/CBxmx7FnWA4EdRBvBf767BI+RDZ5NDEnsDbeHmYpmLvmq+G8Tct+Ll5poE
         4UO2Xf5ENNyLMXA/pi+MqvRMILQKNqhtNRNq28OG7zHa23Z82c9UDguZM1PsKgoQgJwh
         0U4g==
X-Gm-Message-State: APuU4Z/xJJsfwtyc4h/MDPIKjrXslv4xlT/Uvk80D8jRE/v1GEVWZOgP
	BqA3KVDd/xgUvsKkkBSfIZ52B229FNArcj4NwY71Ja8pGwxCTKt/Wusg9bYpug==
X-Gm-Gg: AYBFou1Qo+nS0JuFzqByCb2WPOC/MIpYsWQU0bggJq9xx8uJcUxHy+iA4ZuWR28FerN
	qdxkmGrSHNHXgqUs3+RTQXdbWfDrltta9D0lyQGQe2M8d1/oeBG38keGr/N5P4TCSeEOTHyzPIJ
	Tg1SP9mR1jWtyIiSKvhTANw6Oo9OzTYdCmeAx8UeTnHECNWrINuOkYX83naOyKbA1tBwaePckN1
	QAilB1CNoOyStJgWuOdrNxr+QQ85bK5pXOAK2UcuU1B8NZ8YN5dv/10ZgoIt4vTtN50UajbO9wQ
	mJU0ksav+bb8jKOvugi0wYaSTikY766oBi9GurqQvZ2oSWS+qwCpqrtJR7tYs0kRiVCJLISX0+O
	ytWcmQzmmzLnbB9SAN565WE93EhDC9VMZ3CztM8TbYS3W8FD3La7NmVOhLwnlVVT6kMo2eaWb05
	IVUiH9MmQ5pSr9XcSpJSuFaIQiRkZSJrI8zf0x8Yase+gagD5kUAnnnSL1ej8KWI1arIJB+UDp6
	gS2N6csYEKE95kDY0ehA1NVduWYspqPZEvWQEwhpjb33SO67GlGC05ht8XNPqqR+rX/Dz9e8gne
	rXUg+Zy76+hD5UvZP8nTJ73UCegHHAaZAOxRjM1zpoLE5qX/1rWja7yA5HOzhz01DdU=
X-Received: by 2002:a05:600c:1384:b0:4a2:392:9de2 with SMTP id 5b1f17b1804b1-4ba0234ed82mr37044635e9.28.1794311405728;
        Tue, 10 Nov 2026 03:50:05 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:1917:82b:d709:897d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba02005762sm60715995e9.2.2026.11.10.03.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 03:50:05 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 10 Nov 2026 12:49:47 +0100
Subject: [PATCH 02/20] t9300: make the series B tests self-contained
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
Message-Id: <20261110-kn-fast-import-tests-1-v1-2-dbd9ee502aae@gmail.com>
References: <20261110-kn-fast-import-tests-1-v1-0-dbd9ee502aae@gmail.com>
In-Reply-To: <20261110-kn-fast-import-tests-1-v1-0-dbd9ee502aae@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=14373;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=5IDkeUba462k77/8EBDyyGt+y3DPNh5VITcLvPpfzfI=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGrzBOTSJrgE8Za9caQ5ukXsQ0hqNFd88TWSO
 pSQfQAefL3qh4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJq8wTkAAoJED7VnySO
 Rox/WuUL/jAej53WFV2a1qn+Rw7jMUS51W3HVk8CiwROJl4+U0BIC/Hni7f4k7fTCWWDxRhIqhS
 RVdlMRIaPl+uLzKvaRa6tFpZPzXUS5SBt4yqWeUzv8JjYwm0w/xH+gzzXAwuyDauJD+L5PlmAV7
 ENsN7FmdgRHOigtsPKhZwmyIVQ99Zea2UVcvwdmt/g4k07eXOH6M6zx9zuliC145jJKVqGvMtD1
 +BzsJ2jcEJTEiRG/VBbJSni9lXNhvXv6KckxSI2a0feFUJ9Ur3nTOyY2XVKDolRL/YLdOEE1vaR
 NCJScCkgQm44rYpD33ZNMmfW3OVMNOsbVhY/XZ3G9I3NbNlrcFYprx4KQhmI0cjSrLzFBfaI7RA
 UvXYhVer+D250cbjBjbjCDQuVckldOYA6fVJB0oR97o/rYTNabhiJX/TeTLxkxNiHa/PAcFwkXb
 u22v5/tuMCw9Fg4B9gyQMHjGrGc4Xzgzm8kp6z9PIK2+o79gAxZgbjyjNm1R81XNMTRMKK4kD07
 2A=
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
index fb23492202..1b34f6491c 100755
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

