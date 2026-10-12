Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E234A013A
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 15:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791818973; cv=none; b=qiof+7Q4xgeA6VQYu2nmSifRD4gSUsb4fbkN4VLs8IUyBGlxW2s8cvgypKlccVDz8H0I3PvOeJ2IFnwRJ1oFnngW8hy1t+gD9Ykcv/IYQ+mgyynJynCIbQtQK+pP9CDjvwNAEPiCR2fnkVRzYClJ/X0dHmpC238tcxNPwgCwa5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791818973; c=relaxed/simple;
	bh=gguFcLm0wGQn+jGrqQrskmkdhdWz96yubpMY+C+1wZI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:
	 In-Reply-To:References:To:Cc; b=VcPxLl7yFNcOLkzhwhI+e6wX/fUIhl0Lsb3ptzblOO4HaOjR7SZHht2os+kkSKoTMe8oBeeKAbobs8IRSWJnAGCjbPTxHd/CwCRxb15BQD1sH69I6Vq6RupJO33qcL+Wje0DhPGYoV22v7oWj6AjquanzMZj91Hb1Tk5Er6JWp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s7VBsDcX; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s7VBsDcX"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a021c809e3so19824805e9.0
        for <git@vger.kernel.org>; Mon, 12 Oct 2026 08:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791818970; x=1792423770; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DBKfZJ+OXCG+hrNKUJxMKJavzEkMLt5ptfP4bPc8CjE=;
        b=s7VBsDcX4XgVMi/xaQkf9Wk3wQ4E++iOJ+Ol+o2dT1DKKu5Vohsnk1dlxirU31Ky9e
         swfxBRIMr0HMEiErJ2T+BwUg+UgHrvAFjm83nlyuUN7PbUBdI2Jm1IzBL2vnyR11V7ak
         Q5qpTSzh4LJchWacP+Ek4hd8yzz7mKiH9myV531onZ9zo2JXMSAl6dnyOcdd/x4848FA
         eb3nYfkrocvkeKoCha+GrbGOf9Zs+obNrmB4LghTnBdMwr22gsm3/Zm6Qh3aKCHC5OHP
         sXXJ5iCET3HhQkDfD7FG9IUAhfIvWkC3IMFwdzJDLYg71vS8pw1TzIe1BYftw17utSx2
         a0JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791818970; x=1792423770;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DBKfZJ+OXCG+hrNKUJxMKJavzEkMLt5ptfP4bPc8CjE=;
        b=UuPLSWsDP880tiKI5RWY/rm0x9Etg7VNUOcINCEbcnR52mkh6JTilY2Uwd1bxPT5Az
         Tz8sb3KusbpZolV3fwy2BkVsKWN+xMuNm9ef0aHCsKNi/tmdbgtvD0hY5R+A+YximVAo
         L0cLIwN06mgUIZeeFJb5kNzQaaYQJ5NyHYRRTiDwkjyvbBG/ZygEp87uKTodNa2Jw4bW
         oh/52ltKuOTi9ABjJmBkBQ5GnPzI5ONbGlMm8+GpnuOpS1dOT9eXP6d9BLVsJt8HXsKt
         het4d02PTVhcCP9wdzvv1YYvT7K62KU2GkXau1Kv2+jUU1tj3Cv6Y7Nofo48pmHbD3qX
         pomQ==
X-Gm-Message-State: AFq9FYKkv4WL8hcU0Cb44bqdeXPvfShfaXtyzQgJK/XwNtmiRlqU6wjo
	78/nlcijLjauPGXrQGBw7Jif8XK1bLjCn3N9fYnbSlkbectRkgpEmTCx
X-Gm-Gg: AYBFou2JJ4SfNzVEGXoidr55yh/i8+1dtN+yka9P70Df0S9+qteBS8wP+frip2Zh/bX
	pVDprlVR304SNrDjeEOkUNbEtXAy1YDje9rnjr2QbQDeZawjycREPWdvBgUGgh0mE20kReQALi6
	ZPSbJBM2jo5lkhusnYlQHisRLXFoPMaGyGFFDbewADR9fL38QH+2YTV5REOwt1GTWml0Fqk8TsW
	kTs9+6oNVaytKJ4bz5HuSOuJONRONoKbhzT9jZeHgjSBHFMHqTvlHfG8FQtNes0ESYE/kf3ikXa
	OFf0UerbAFJUaZ0tdghkmYgSHrcj3WhYhBnvjG0KAIzqrgyYqYIAsK/o+mEvwcjnjPYzBSJ6c41
	Kd70BU0spkALoDL2wub6H0PSug8mLWJezoIWvJcpK+tD6GXWm/VjXR5uMXohEpf/+QA/V+LdHR3
	v9JwHhG9qaTNaHlZUBkUklwF/o2T8uodCQm3CfrjNWHiwOtJIfK8qQ1t0XZKFLsRX8BY8WDa1in
	ftd/5xzpFoWziYEbzKlF9lqLEL+lpbtLpUb3GyFswUtWeNSZHoZKltB7h0kebD4z5r4ZiBjvdMs
	OHllfpX0
X-Received: by 2002:a05:600c:46cf:b0:499:b65e:49c9 with SMTP id 5b1f17b1804b1-4a18e47ad5fmr209959535e9.10.1791818969365;
        Mon, 12 Oct 2026 08:29:29 -0700 (PDT)
Received: from [127.0.0.2] (ip-188-192-242-085.vkd88.pools.vodafone-ip.de. [188.192.242.85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a192d3efb6sm178837075e9.1.2026.10.12.08.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 08:29:28 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 12 Oct 2026 17:29:17 +0200
Subject: [PATCH v2] fetch: commit references fetched before backfilling
 tags
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261012-799-shallow-fetch-with-tags-v2-1-4211e9a13d3c@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQ6CMBAAv0J6dk1bBFJP/sNwKGVL14A1bQUN4
 e8CxqvHSSYzM4sYCCM7ZzMLOFIkf19BHjJmnL53CNSuzCSXpeC8gkopiE73vZ/AYjIOJkoOku4
 itKVscrSNVJaztfAIaOm116/1l+OzuaFJW3IzHMXkw3vfj2Lzfif19zQKEJBXqi1FwU/aFpdu0
 NQfjR9YvSzLB2Ebu47YAAAA
X-Change-ID: 20261007-799-shallow-fetch-with-tags-d62b3efb29f0
In-Reply-To: <20261009-799-shallow-fetch-with-tags-v1-1-379d61504af5@gmail.com>
References: <20261009-799-shallow-fetch-with-tags-v1-1-379d61504af5@gmail.com>
To: git@vger.kernel.org
Cc: =?utf-8?q?Mitja_Bezen=C5=A1ek?= <mitja.bezensek@login5.org>, 
 Karthik Nayak <karthik.188@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5252; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=gguFcLm0wGQn+jGrqQrskmkdhdWz96yubpMY+C+1wZI=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGrM/NdqDmu0s2ysT937IFWGxe1sPPC7c+HXe
 kVGydODJ51S3okBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJqzPzXAAoJED7VnySO
 Rox/g5QMAJvDJOAVJtHGfO378LWL6ndBP3FbnWrgT75dd4zqSlsXL5unJZQoIiRqnEZxFlWvSLq
 J/qlxYbksTZCP/5+RSe3XutuXs2de0dhmnKUseY+Vki7lDRcbmvZMdHLfsJ6wSHNriS6lzockXb
 IlFcroAd6B/zaCSDYBYAY6CedgMG2/3Ifn1RyGmc5EcvMBDEoVhvkGkmSR3wf9bnQ3XtnnNGrUv
 uaYOfZWggghDuCWxy0pAWt1NVRzC//+VVesPP1DzpKgy+dXJyjJNOOQo9rDkty5OTLWsowPAyzv
 Ckz9EW1TuXEpoJL+ltVWGvCBHD31SfBsisQkEnIaxbp+Rb0dVdKbEYd/MQq1LOm6THEloD6BNvp
 jkMdOtoHOSAD9e7bt/0HziC6jWTx4iTBavC0ZlrR2jqzTx6EVHBZytT4d5cO5O8SCc/6Ry5FjFc
 ijn/qZuG3NQ2or2oOPJyudJIiAd0b0GhIuVwRcjKjVI8sLIoAvJHIcNwD6GPf7tVH8EJ9lGbp36
 T0=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

In 0e358de64a (fetch: use batched reference updates, 2025-05-19), the
fetch code was modified to use batched updates to provide a good
performance improvement. Wherein batched updates were used to fetch both
references and backfill tags.

When using batched updates, the references aren't yet committed to disk
when we start backfilling tags. This means in situations such as shallow
fetching the negotiation during backfilling tags, the client doesn't
have any references to report in the 'have' section. Since backfilling
doesn't use a depth limit, this can cause the server to send all the
objects present in the repository.

Fix this by committing the previous batched update and initiating a new
one for backfilling tags. Also add a test which captures this regression.

While this does make it a little slower than master, due to two
transactions:

Benchmark 1: fetch: many refs (refformat = reftable, refcount = 10000, revision = master)
  Time (mean ± σ):      82.1 ms ±   3.3 ms    [User: 60.2 ms, System: 24.4 ms]
  Range (min … max):    77.4 ms …  89.4 ms    33 runs

Benchmark 2: fetch: many refs (refformat = reftable, refcount = 10000, revision = HEAD)
  Time (mean ± σ):      82.6 ms ±   2.4 ms    [User: 59.3 ms, System: 25.2 ms]
  Range (min … max):    78.1 ms …  88.7 ms    31 runs

Summary
  fetch: many refs (refformat = reftable, refcount = 10000, revision = master) ran
   1.01 ± 0.05 times faster than fetch: many refs (refformat = reftable, refcount = 10000, revision = HEAD)

It is still faster than not using batched updates:

Benchmark 1: fetch: many refs (refformat = reftable, refcount = 10000, revision = 0e358de64a9e014575d11ef884bfc9beb931e37f~1)
  Time (mean ± σ):      1.468 s ±  0.041 s    [User: 0.839 s, System: 0.587 s]
  Range (min … max):    1.427 s …  1.558 s    10 runs

Benchmark 2: fetch: many refs (refformat = reftable, refcount = 10000, revision = HEAD)
  Time (mean ± σ):      84.4 ms ±   1.7 ms    [User: 60.9 ms, System: 25.8 ms]
  Range (min … max):    81.4 ms …  88.6 ms    29 runs

Summary
  fetch: many refs (refformat = reftable, refcount = 10000, revision = HEAD) ran
   17.38 ± 0.61 times faster than fetch: many refs (refformat = reftable, refcount = 10000, revision = 0e358de64a9e014575d11ef884bfc9beb931e37f~1)

Reported-by: Mitja Bezenšek <mitja.bezensek@login5.org>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
The issue was reported by Mitja Bezenšek on GitLab's Git repo [1].

[1]: https://gitlab.com/gitlab-org/git/-/work_items/799
---
Changes in v2:
- Add benchmarks between master and this branch to show perf regression.
- Instead of checking the trace file, simply check that we didn't fetch
  older objects in the test.
- Link to v1: https://patch.msgid.link/20261009-799-shallow-fetch-with-tags-v1-1-379d61504af5@gmail.com

CC: Patrick Steinhardt <ps@pks.im>
CC: Justin Tobler <jltobler@gmail.com>
---
 builtin/fetch.c  | 21 +++++++++++++++++++++
 t/t5510-fetch.sh | 16 ++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index b2decc6cfd..68b04d0f8a 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2076,6 +2076,27 @@ static int do_fetch(struct transport *transport,
 		struct ref *tags_ref_map = NULL, **tail = &tags_ref_map;
 
 		find_non_local_tags(remote_refs, transaction, &tags_ref_map, &tail);
+
+		/*
+		 * Backfilling tags has no depth limit. If we don't commit
+		 * the fetched references, the backfill will report no refs
+		 * in the 'have' section of the negotiation. This can cause
+		 * the server to send all objects.
+		 */
+		if (tags_ref_map && !atomic_fetch) {
+			retcode |= commit_ref_transaction(&transaction, false,
+							  transport->remote->name,
+							  &rejected_refs, &err);
+
+			transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
+								  REF_TRANSACTION_ALLOW_FAILURE, &err);
+			if (!transaction) {
+				free_refs(tags_ref_map);
+				retcode = -1;
+				goto cleanup;
+			}
+		}
+
 		if (tags_ref_map) {
 			/*
 			 * If backfilling of tags fails then we want to tell
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 300bd5396d..5ba372fbcb 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -1942,6 +1942,22 @@ test_expect_success "backfill tags when providing a refspec" '
 	test_cmp expect actual
 '
 
+test_expect_success 'shallow fetch does not fetch objects again for tags' '
+	test_when_finished rm -rf source target &&
+
+	git init source &&
+	test_commit_bulk -C source 10 &&
+	git -C source tag -a tag -m tag HEAD~2 &&
+	root_oid=$(git -C source rev-parse HEAD~9) &&
+
+	git init target &&
+	git -C target remote add origin ../source &&
+	git -C target fetch --depth 5 origin &&
+
+	# Should not fetch objects beyond the pre-specified depth.
+	test_must_fail git -C target cat-file -e "$root_oid"
+'
+
 test_expect_success REFFILES "FETCH_HEAD is updated even if ref updates fail" '
 	test_when_finished rm -rf base repo &&
 

---
base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
change-id: 20261007-799-shallow-fetch-with-tags-d62b3efb29f0


Thanks
- Karthik

