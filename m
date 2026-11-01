Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793530843;
	b=aEb9CRJ8uiML59r4lxECh3xfcSwAHpIeQUNeN775ZEVDBwwqS6HhH3bn3U/doQ1iGlPb
	 fenMpWDXW2JuJLO+pYe4fYErxv5e/AGCP26epcb+iQOUcne9E1pGxmS8doJARrkjsHV8P
	 XvQSbNuiUZzbu16q8X4iOKQsvSb/vP9g0qRuKND1cbS7voHqzPG91510eM/bNSuINLzdM
	 wUP1UcFxl7BAOjG1h7jg1A90J0T9s/zjWS6OfgtGFHPwtJ3m6nVquWsSAHhpNSUy9pDyX
	 agUDsCN0vnOQE255HvmxxnaoIgxNCtWclotdRKsoQkwjfCJaDldyAtIvH20zRlK9AMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793530843;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=qc0VQMEBlrefoI7pWAGEWDUoz5L4VLkMjdbsMCZdSPM=;
	b=v1n6KzusH5mBhPWCsPS88tAd8oEZh4UKZal2lBn3sq3ZdAzobj8+ZySZM6DBnDYkuqLb
	 5T1/dsmWFdrFMJ1Mrw02CIExC4uHe8zwRjb69I2+9Af40ERwQnifrxTyMrpwPCyoRJyQM
	 ByPwUtlG5MjpJPt+DcAwKH1IiRMFNsNbwdcwvYQQInPoWFyjhU6/vmZVfUIO7EQ/ckAda
	 GMjjHIw4pgTt9C27XaNQGJtFzmFYw5sIFNJ1b7JGEKR7eZagZotMmWEDKImuXNYjQXemu
	 Gar8tsRUnx61MJaaAjfGPDmSdkpAT20yCiv0AWMXvowO5xkIrR/F/VDfwczkoBnpqwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Fp/TLLvq";
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD427606A324
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 11:00:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD427606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fp/TLLvq
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-36a315ed211so2566957eec.0
        for <git@vger.kernel.org>; Sun, 01 Nov 2026 03:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793530842; x=1794135642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qc0VQMEBlrefoI7pWAGEWDUoz5L4VLkMjdbsMCZdSPM=;
        b=Fp/TLLvqwC1bMlUKcl3Fdul0NKtbdjoHcMF7j8REKo1ueAEC3jyZk4S9IPaMkW6f7d
         /P2z2ZVU3PW49HP7fPJGQjq6u1+IRQy3Y1Xqku6+5UBU1Ap7YKJvyHwlU7v06Ara6YPT
         JqzaTp5Mb8mWkeGYI+qJSGe/a6CJ3KFpyYKEg6wjxFex0euJoct1IdQ96OOk9XVXN9S5
         s4U+jecaSqxTr0tuK/uAGjyVwwtKFIojGegQk5ZAkAeePUhqdmUA3RtCj9qQlLE4E2Xt
         eEnNAgRIl+DbPHhdFlB6E4bHf/1mIksmIdMfFklSsz58lURhME6nDYMpLGm0x0A7hKbc
         lx+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793530842; x=1794135642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qc0VQMEBlrefoI7pWAGEWDUoz5L4VLkMjdbsMCZdSPM=;
        b=jez3xiZrMAXJoZRgGzzSf1UbHKIMyzSuWMT6NE5pLATSHnvBc2nRuB95jGQIQQppFX
         Xsjoqs3NueTYlk+g8rv8iEybrcsjP+t8xQiLBZ3Rv8RmZvhkVkJUqErRh1YttBHQ8TNJ
         PhymSlFsNejsoCGSV3A5QjDIOv2too3mC+my6tqzMERCXAVDV3rdqgrVPg1GB+aiA6JY
         cXtQ6hXBW0pBlXdO9+0ow/EKoqcGqKtatbsKuwmL9UgU8y1fhyP4zsCgGn7tYSE6yxF8
         DLNkxL7OqW9Jr4k+MZvGivMpu8JCLa916jZNcoO+TJ8QtfnPU/AcWO+pnEk9CtkpeZBu
         e/wQ==
X-Gm-Message-State: APuU4Z98/zKpxPsEbWZ8Wzv4Dh665hnFDHtJMnx05raCoNTO/qjoH/wq
	thhN8jFlCfCUSuJ33hzuJWpsVJoqjoQLwQ5B+MW6OlGzP9EO723anfjQmOMEJg==
X-Gm-Gg: AYBFou2bmTeDAJgkwMXE8G6Wyj1+QyefpFgP7QG3s7N9k/nyWQEvHotavK7MLwrKYOk
	5i2j8TuEN5f4feOSAUWFVlrxAp+blWvym/05HeiGHzyRB1KMXxUBFjNNKBVvCGK2CumKV/+gitS
	BM2U9KQeuOf3FJyXAJUnZMyXq0Qds6qRZjUpdYWlgdd8kB+4KU1LreqAtLWcffgmydoFkLxZzLP
	QUFAgayF8vjqDVbJT915PvLa8Etl4GwmYiBVVgZywBtHp5lo9QPxKdLTirRrsshkZmGb4pAIXrG
	UD2tG9PtoW8nXGmcZ7VH6r0t3w34KYCB7jXyD5vBZ5t0qVb9//puJAh3QwySgNmDaYuVlZJeKEu
	T6uTEIZ4PVwMQzUhpHU5W83W3H4MgMtGpKHKmvv+yDwXG2+z1mg3EA/me3U6Yt+tqst156Flaow
	nP+kzrR9vy9y9y/Fxb8zx+As1y14TQysvEvxxdqkyI8QICiyrvftwGbBz6J2NTtlk98jdTPeu1W
	UifV5wX1tyCyCCvTbLm/yaJo6Uo46irehFD97yzQgKtOKdFj/6O6+Kyor2hRzXIsAdhAH9x3quK
	n4gkvWvSyp8lWcdeg9E/aRwPR0vPSaC5SBLiqryzsC7l9NVB/RhGTBskEBxwg3iMaUj/Ck55
X-Received: by 2002:a05:7301:f8d:b0:369:f1ca:5b24 with SMTP id 5a478bee46e88-36a42389011mr9781222eec.6.1793530841549;
        Sun, 01 Nov 2026 03:00:41 -0800 (PST)
Received: from HP-V15.xu.edu.in ([125.22.10.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428af1easm22755427eec.5.2026.11.01.03.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 03:00:41 -0800 (PST)
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	mail@thomasbachem.com,
	ps@pks.im,
	ttaylorr@openai.com,
	Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Subject: [PATCH] maintenance: trace when auto maintenance skips due to lock
Date: Sun,  1 Nov 2026 10:59:00 +0000
Message-ID: <20261101105859.25579-2-pushkarkumarsingh1970@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When git maintenance run --auto encounters an existing
maintenance.lock, it silently skips running maintenance and
returns successfully.

This makes it difficult to identify cases where automatic
maintenance is being skipped repeatedly, for example due to
a stale lock left behind by an interrupted maintenance
process.

Emit a Trace2 data event when automatic maintenance skips
due to an existing lock, allowing users to identify these
skips when Trace2 event logging is enabled.

Signed-off-by: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
---
 builtin/gc.c           | 2 ++
 t/t7900-maintenance.sh | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/builtin/gc.c b/builtin/gc.c
index 81cecf6b6c..e73d1f1d49 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1409,6 +1409,8 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts,
 		 * recursive process stack. Do not report an error in
 		 * that case.
 		 */
+		if (opts->auto_flag && errno == EEXIST)
+			trace2_data_string("maintenance", r, "lock/skip", "exists");
 		if (!opts->auto_flag && !opts->quiet)
 			warning(_("lock file '%s' exists, skipping maintenance"),
 				lock_path);
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 9d610a29fe..440eeb956d 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -387,6 +387,14 @@ test_expect_success 'loose-objects task' '
 	test_cmp packs-between packs-after
 '
 
+test_expect_success 'auto maintenance traces existing lock' '
+	test_when_finished "rm -f trace .git/objects/maintenance.lock" &&
+	: >.git/objects/maintenance.lock &&
+	GIT_TRACE2_EVENT="$PWD/trace" git maintenance run --auto &&
+	test_grep "\"event\":\"data\".*\"category\":\"maintenance\".*\"key\":\"lock/skip\".*\"value\":\"exists\"" trace &&
+	test_path_is_file .git/objects/maintenance.lock
+'
+
 test_expect_success 'maintenance.loose-objects.auto' '
 	git repack -adk &&
 	GIT_TRACE2_EVENT="$(pwd)/trace-lo1.txt" \
-- 
2.53.0

