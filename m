Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793813720;
	b=Eq4G6HNbQ4ort3HmS9XlzBs0ejeaoHIhdcBflKFZs4bbIAgxOzDvzdZCqEekhzJrHMnh
	 RUaEP5woDSL2tjnEHFfprLRw6Ekjp1CJ4/gPqVfRdmhe/jxLDEJQD1SIk/zigu5SNQHGp
	 mr9/pD5FQiGl/ivguVJjoCiR6PMlVhzzwLi1gAie4y60XsH8svoovWo9k5oYE7SlB0asc
	 2S9L04wQxr0gld4k4qpso02j6Kv+5nrrD+96Nsi3sYvtsa6NIVjuYpJ7L04pn7CDttOr7
	 DaPBx5NLsscSsrVxFbDlRa46J6U8b2ZF8l9tgmGgrxPO8FgJ7qXt9PgwfbqVfb0nd3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793813720;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+xELJ96simVANEH3A52Xutazq4TyciqcjvfvVc3nZ7c=;
	b=Dm1Vw9C0QBKjyW0z5TxdzzUElSoZqs7U5VkBsFRYFLfV43vbW2Ol5wJb/E2LVy1fHmTT
	 JSwHHsu8lCNv/hRRfaCoo1YhJXLVMNbeyi115y7Dblz88Vu0Y9oXE2V+UxqFLAkVrj/D7
	 f7i4AMY4wc0fgO6ylsvd9EWBeLqJuuowdlitfvG/kmfjGNtxi8JdsvekN7F2/SdUVT+44
	 u80cHZsBHh0jIzsDY2Ya7zGbNBH/rDVIJ6yHx5MJe9WCfnyfewXz/PqxpIsSizR4VFrW/
	 z8BLcYYAE6rdvIO3bba8cgArRxjSiJqyRuWCKkkquG85JQoVb7YbhpEIpX1KUcDj7wQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lZXFiHEZ;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1863606A329
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 17:35:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1863606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lZXFiHEZ
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-36cedf1bd63so1021371eec.1
        for <git@vger.kernel.org>; Wed, 04 Nov 2026 09:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793813719; x=1794418519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+xELJ96simVANEH3A52Xutazq4TyciqcjvfvVc3nZ7c=;
        b=lZXFiHEZQnErmgX4CWJCeliwnpyrmU5q3oJQfFBNtM5qfSD9X1kV0+wGWZEtj776gW
         wTlxpiCLkj9OoTAhmfJqUzLX4KVthR+sfyeADxJBkg9Oham4YgVL9uHA9Ud6WUAKqrcd
         CtPNU50pdBLXAVUsyQDH/ZL995t/EALG35ec+gwADRdYqwG5b6arQyzGWi6juYdvQCzm
         /XYJXgTEnnPJxb+dEz9thvgsLtGIERpEiqQA9qrZf41CS/mnePTvHCaD4A0tGgKROTdC
         Afc/QqtWvgODqUCtnxH363oYZE0aimmXI6Tfb61XfgdSJLldFhPTUty96vC/TRJ09RC+
         vZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793813719; x=1794418519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+xELJ96simVANEH3A52Xutazq4TyciqcjvfvVc3nZ7c=;
        b=RFqEi0u7D+iFJiSA0JsTK6QGUScQo/aMaoZ7q3w0FqAD1BhEuOVnR5GrtpGP1N8HUR
         tEJJQrbULKQaJe8qY1ZZmbm8smh+hf8gaV8g8Zy9K3vTRScJdkK1IIyNQ4DTwVpt1qHg
         hAvM/phVgw9kTjePlaGtihUAtr3GA0er9aR8/wzER/8RKjrGpGZ4Tvt/74YrQ4IIUBX+
         pnA04smkysuYhmO9vfAoJYb/8buEJZr4uN9QPYlXTTJOGQcxQVVeTTguaRVZPDs2YiFD
         Xp4bDL+CkkOw+TqRr/go8oRWuzRwGu2W+8jDrGzYVdedZzyf5Lp8cDB94ObWGzbucf3b
         Db+g==
X-Gm-Message-State: APuU4Z/rNxWo+AKvwF9M4EfXwo6yL+78L5mvKRaEFl6J0TSTognVQrM3
	fh3BRHIqhukeIFalkDqKxQkqdDbJcRpVb0B46wqCJMMz0Z+wSyL56EkaDv99mQ==
X-Gm-Gg: AYBFou2lHQB6orQhyjbbHUAnxTX2CbWjf7M4W+0LFNC6NJTQnf8wpS1IqtJwLEKY/CV
	4fnSVV18GNCJuRWMaD0l5pFKKcDTsU7HcRjXnNsXXMKGaBe8/Ij+c07bZYGSbZK7uRNs33MVhMz
	ia52XMPf7NKE2HZiB+1WyZl5pFtEOwV/jvFXFT44FiO/mbqFCrA/FySRm/1r+7HZ/ATJ7naoRzp
	5tKCeSaTQS0IEUUeI9HIX7kI8pDsPGn77S6cqp3jJmG4riCiYkEvxrZFpsGydy9jWj9K9CbBv4o
	NX9x1AWl6ipFrVMRS52OdzyZbBouVx4LrcuxdT9dl0v4SLFlThwWiBGH3CJKsWFohOjp8NWUUkC
	apEItMTxNgzzwiE8iSQIBB25dxtRE25jvWXtZQq6r9mL83jb+NMrpY5Xioodw8QOF0pILEgzbrL
	qAq8Az5HqTxwaXzglSs7csIAJ+eT+3Gsc5OO4FRT1JkPAcJWOYqaneipWkW0RY89+MwSWLJqPc6
	3Q4eRstca5dnwjDzhJPsf3RXdNGawDJvy7GMHgU2W5YgYMkm8ufcSS1uMyVhCPSrbmLaWAO7SU/
	n+6r6tVbyUJRoROc1J6m6aE36s9Zcc5IoJEQTaFi2NGhFyJ15w==
X-Received: by 2002:a05:701a:ca06:b0:196:b805:9546 with SMTP id a92af1059eb24-1b24f43f63dmr196069c88.10.1793813718580;
        Wed, 04 Nov 2026 09:35:18 -0800 (PST)
Received: from HP-V15.xu.edu.in ([125.22.10.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c4f83fsm13520264c88.17.2026.11.04.09.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 09:35:18 -0800 (PST)
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	mail@thomasbachem.com,
	ps@pks.im,
	ttaylorr@openai.com,
	Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Subject: [PATCH v3 1/2] maintenance: report lock acquisition failures
Date: Wed,  4 Nov 2026 17:34:21 +0000
Message-ID: <20261104173422.20725-2-pushkarkumarsingh1970@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104173422.20725-1-pushkarkumarsingh1970@gmail.com>
References: <20261102122955.143018-2-pushkarkumarsingh1970@gmail.com>
 <20261104173422.20725-1-pushkarkumarsingh1970@gmail.com>
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

When git maintenance run fails to acquire the maintenance
lock, report the failure instead of silently succeeding.

For automatic invocations, print a warning while preserving
the successful exit status. For manual invocations, report
the failure as an error and return a non-zero exit status.

Respect the --quiet option when reporting the failure.

Signed-off-by: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
---
 builtin/gc.c           | 15 +++++++++++----
 t/t7900-maintenance.sh | 24 ++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 81cecf6b6c..9ca9a3584b 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1402,6 +1402,7 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts,
 	enum auto_gc_hook_result auto_gc_hook_result = AUTO_GC_HOOK_UNDECIDED;
 
 	if (repo_hold_lock_file_for_update(r, &lk, lock_path, LOCK_NO_DEREF) < 0) {
+	    int err = errno;
 		/*
 		 * Another maintenance command is running.
 		 *
@@ -1409,11 +1410,17 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts,
 		 * recursive process stack. Do not report an error in
 		 * that case.
 		 */
-		if (!opts->auto_flag && !opts->quiet)
-			warning(_("lock file '%s' exists, skipping maintenance"),
-				lock_path);
+		if (!opts->quiet) {
+		    struct strbuf buf = STRBUF_INIT;
+			unable_to_lock_message(lock_path, err, &buf);
+			if (opts->auto_flag)
+				warning("%s", buf.buf);
+			else
+				error("%s", buf.buf);
+			strbuf_release(&buf);
+		}
 		free(lock_path);
-		return 0;
+		return opts->auto_flag ? 0 : -1;
 	}
 	free(lock_path);
 
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 9d610a29fe..3288efb391 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -387,6 +387,30 @@ test_expect_success 'loose-objects task' '
 	test_cmp packs-between packs-after
 '
 
+test_expect_success 'auto maintenance warns when lock exists' '
+	test_when_finished "rm -f err .git/objects/maintenance.lock" &&
+	: >.git/objects/maintenance.lock &&
+	git maintenance run --auto --no-quiet 2>err &&
+	test_grep "Unable to create.*maintenance\.lock" err &&
+	test_path_is_file .git/objects/maintenance.lock
+'
+
+test_expect_success 'manual maintenance fails with existing lock' '
+	test_when_finished "rm -f err .git/objects/maintenance.lock" &&
+	: >.git/objects/maintenance.lock &&
+	test_must_fail git maintenance run --no-quiet 2>err &&
+	test_grep "maintenance\.lock" err &&
+	test_path_is_file .git/objects/maintenance.lock
+'
+
+test_expect_success 'manual maintenance with --quiet suppresses diagnostic' '
+	test_when_finished "rm -f err .git/objects/maintenance.lock" &&
+	: >.git/objects/maintenance.lock &&
+	test_must_fail git maintenance run --quiet 2>err &&
+	test_must_be_empty err &&
+	test_path_is_file .git/objects/maintenance.lock
+'
+
 test_expect_success 'maintenance.loose-objects.auto' '
 	git repack -adk &&
 	GIT_TRACE2_EVENT="$(pwd)/trace-lo1.txt" \
-- 
2.53.0

