Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793622633;
	b=rqHvsT+oxZnM57YyyV4uDzFgmP0DxVu5y414Vs58LA8BJcVw8/83UQWNtKuU5QexwjZ0
	 Qp+4Y8SgFxymHL/QB3V+VAmNcJadu1zzUHYlVoFnUOGEMnTzGP+j8t1qos+AherWxVRFi
	 fRyF8S4+XhQ6LougJ8xC6S2motWmzhuawsHc54qZ+tjDi4+sXJuWwLaWEL1ULfF1F4aTc
	 cGrFNyr8C9i4XRdoRcMqiaTO5bO5lA5TimV2wafdFqOdksO1oMmgWXpTnpvZLShkPM2Xk
	 iPuI4I+mCFgmWfHkEujU9t0gdW8DeIPZJf715ahTVOYUPMldCAWcc5/t/B0aVaB5SGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622633;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uUtr+yZKrqdINMLxZosLA70QbqgFBP8B9JV89981zNc=;
	b=IlU3vsF61l0+NGqeI8FelpY66Vd9V+Q8UuW0Ub+ymu7GlEfYGTBxpSPkQ4u+fRimYwgn
	 MJLJn4h6Ybu0vrJLuaGBGBN0G3U4wu+sVQsruR4ZmxPJ9Cz1zrTzd0q2ihrnHgxE0gmas
	 /rXBzVtMYhNsT2G3ll0VV8iUtAtiHSeAfzujnvu9Rw1YWYRJ7eGYLLfwtkRpkWPMCOy2/
	 Lg8KwYKNOTsieFuWTV0HAxto4o4nVXyLb3CKYsaszBCmQUxnc38aRH5R2DfZI8E0/s5JH
	 1uE586fafwHVnmP0z7VFOHT2jRtz2Q1uVu/IbzVWV+vpHD2thdnwehZiCjz9qgOPxew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cpBPtAHV;
	arc=none smtp.remote-ip=209.85.160.181
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D97606A329
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 12:30:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70D97606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cpBPtAHV
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5351d76e1baso34824321cf.1
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 04:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793622632; x=1794227432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uUtr+yZKrqdINMLxZosLA70QbqgFBP8B9JV89981zNc=;
        b=cpBPtAHVfOcyqZ3nvzHwlrQVYZ2OtAhW2J8TiyzGi0ayXmDTtOFMwKuc1PST5tkhUb
         cV0d6NaFaLNcijT5lAleSvUMgWDIMP/xiWEvAcjDzAw0/QgjVcRsZtUl+gzYIrCM+nB2
         xtKWBw94V7AJdLT5/UQAr94UO6GJ8MKXADCzQyGgCBUGkQ489pGzICi13Me44/jH82Iw
         Y+gDIJ4MyLa11/6kW+JJCBi+0mBOFmdZvFj4vszRK6SalO3GM9DzNnxN0EXJGG/vjkZY
         surs0jQNRv0AbWH6bPQsfJEOLvdSICXzQhVpju1/AbFaCFjRUYlO3Enet/sNugxaiTwB
         LuGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793622632; x=1794227432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uUtr+yZKrqdINMLxZosLA70QbqgFBP8B9JV89981zNc=;
        b=I1rcI2Ie0WXkVfxopzWgCYXK9pDpkqYpTL5/2gRDjo7OFeanm3WRr6vmJZw8NTCdGK
         EQx/skIPA+Ylu6Is3izqSqKpvQR6EAdg/Y9g+kwMwcMgqofGLMSRfJY+rKDJlp+k08u6
         aLEwiVY+JZ5044O5Hhdj2BVvIs2njPi2iaKhI7RVSoZhfRtPkHzWLc4jCDUO3MBXejqx
         MzJWWBCBsm51yrEYMHlTVub83iXtSwsssZ+NW8JNKZfegUW+h0AkhYbHeRZLfpxETHWO
         g+xalpRpm2Ff1xPmiUNMBLAu3bLyM0KuZVo5Jo5YwUYnCHz5c6sXbsU5RX86vFfPc9et
         htTg==
X-Gm-Message-State: APuU4Z+6tgmTiiKFUtECxKKK9YBgdwLVYBYSst+5CBQ5xtNEQUKqWEzX
	nvYXB6Zwr6J69JDkw3XereDLsdp0TUKUF7/fSAhmhY6df+cIXEqbovKY
X-Gm-Gg: AYBFou0OXTAgwlwKackHNzwiHwXF9OBaWFqL8h3+OHFXc0H0Ip4UmfUV44xXuRW46Sj
	PkBtIsB6qv9HyCcOb/K0+/YVBXKrufsqckw/E6riXZG9tqwJX5bzSOFZr17Vu8nkZggt3NTpCAo
	ARFCHQS4QeV8OpgUDDXiPmt1i8zWlB/jhKWT9SIyQEzeaFnrpAYt8e4ClRceUiDxEDISrC4hgH7
	ZcR/gqoGcXhgXhHTNH1oMaC6TwoXvUnC7xQMDNMC5rqTEcxQvvM3gAL2tf8WRVo/JywLK5TjI09
	QX3b12pg/koo3q5qrkPWCAbBMbW3f5GOwWyz/6dI1eCYCcqp+BU5HNS/JGFpa9AV5CWoRCW17OW
	GCKHYwgsqh00QRWC+OMzx8Qd46oMVV5J09h4kYcCWOb+mgTJd6uxkuq7O/239iDV8IkbBDS1mO3
	q9K8bYSr8MW2xsyXOHd5W1av96rcqzHBkboc+TpyO0tZGCUcaHJcVrgzuiw1WfwApD/mdcHq4+T
	lmhSXejXMY7dEiNqu4DgyUr/KUQDQtdzuOr56HVvHRIgGZOUbFTcy8Dre6TrJkYh+7j+caDbg+d
	sn7hozw8M+EO3zbeikA7Mm/Ietoo10uwrAI=
X-Received: by 2002:a05:622a:48a:b0:536:64ee:73e8 with SMTP id d75a77b69052e-542b6973680mr156998101cf.8.1793622632050;
        Mon, 02 Nov 2026 04:30:32 -0800 (PST)
Received: from HP-V15.xu.edu.in ([125.22.10.135])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54311a89ba2sm84860141cf.4.2026.11.02.04.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 04:30:31 -0800 (PST)
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
To: pushkarkumarsingh1970@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	mail@thomasbachem.com,
	ps@pks.im,
	ttaylorr@openai.com
Subject: [PATCH v2] maintenance: improve handling of lock acquisition failures
Date: Mon,  2 Nov 2026 12:29:56 +0000
Message-ID: <20261102122955.143018-2-pushkarkumarsingh1970@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261101105859.25579-2-pushkarkumarsingh1970@gmail.com>
References: <20261101105859.25579-2-pushkarkumarsingh1970@gmail.com>
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

When git maintenance run --auto fails to acquire the maintenance
lock, emit a Trace2 data event describing the reason for the
failure. This makes it easier to identify cases where automatic
maintenance is repeatedly skipped.

For manual invocations, report lock acquisition failures as
errors and return a non-zero exit status instead of silently
succeeding. Respect the --quiet option when reporting the error.

Signed-off-by: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
---
Changes in v2:
- Report lock acquisition failures for manual invocations as errors.
- Print a warning for automatic invocations while preserving successful exit status.
- Trace the reason for all automatic lock acquisition failures, not just EEXIST.
- Add tests for automatic and manual lock failure behavior.

 builtin/gc.c           | 28 ++++++++++++++++++++++++----
 t/t7900-maintenance.sh | 26 ++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 81cecf6b6c..9223409750 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1402,6 +1402,8 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts,
 	enum auto_gc_hook_result auto_gc_hook_result = AUTO_GC_HOOK_UNDECIDED;
 
 	if (repo_hold_lock_file_for_update(r, &lk, lock_path, LOCK_NO_DEREF) < 0) {
+		int err = errno;
+
 		/*
 		 * Another maintenance command is running.
 		 *
@@ -1409,11 +1411,29 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts,
 		 * recursive process stack. Do not report an error in
 		 * that case.
 		 */
-		if (!opts->auto_flag && !opts->quiet)
-			warning(_("lock file '%s' exists, skipping maintenance"),
-				lock_path);
+		if (opts->auto_flag) {
+			trace2_data_string("maintenance", r, "lock/skip",
+				(err == EEXIST) ? "exists" : strerror(err));
+
+			if (!opts->quiet) {
+				struct strbuf buf = STRBUF_INIT;
+				unable_to_lock_message(lock_path, err, &buf);
+				warning("%s", buf.buf);
+				strbuf_release(&buf);
+			}
+
+			free(lock_path);
+			return 0;
+		}
+
+		if (!opts->quiet) {
+			struct strbuf buf = STRBUF_INIT;
+			unable_to_lock_message(lock_path, err, &buf);
+			error("%s", buf.buf);
+			strbuf_release(&buf);
+		}
 		free(lock_path);
-		return 0;
+		return -1;
 	}
 	free(lock_path);
 
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 9d610a29fe..c0763cb6e2 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -387,6 +387,32 @@ test_expect_success 'loose-objects task' '
 	test_cmp packs-between packs-after
 '
 
+test_expect_success 'auto maintenance warns and traces existing lock' '
+	test_when_finished "rm -f trace.txt err .git/objects/maintenance.lock" &&
+	: >.git/objects/maintenance.lock &&
+	GIT_TRACE2_EVENT="$(pwd)/trace.txt" \
+		git maintenance run --auto --no-quiet 2>err &&
+	test_grep "Unable to create.*maintenance\.lock" err &&
+	test_trace2_data maintenance lock/skip exists <trace.txt &&
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
