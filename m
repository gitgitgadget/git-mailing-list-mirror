Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF66501294
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 15:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790781347; cv=none; b=cwZJtv9nh9JNi1zI2Y0lVZUN7O/ASGU6uYYH+L41izsXUmZ7iQgg2aMBYA0mXoXPQK+z8TXJZk/6Wz9AlV1XBbYBFvLeohNzwQ22EpT4Hqfg/bW/ADMBrmjss/id11H+M0KuVcpnZJGq93yRx3wCNej7ah0n4wKuUjqYy/JHdls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790781347; c=relaxed/simple;
	bh=q0ith4kl4WVUNFqPIKxfPvo9tmjzWbDblymgnp5ku0E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=I18YA8FybhIXf6OfLsw83bPERd2aikX6QeY+hZ5n+Aa9C/9xvnUcFrMYoI3CmUjADYnaD6nYGpoqGcPpl5qDuUXtTviDq8vDss6SSG4hAi51Uu8+FX3LCPK3aULP+/dcR1b2KoGsA8Zk5sIRXUEiEZpEMNwkIdETeOoLUZb5O68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qWKvirL7; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qWKvirL7"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912d391aso41942635e9.2
        for <git@vger.kernel.org>; Wed, 30 Sep 2026 08:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790781332; x=1791386132; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SWvsF7wDxyvpkamYYOoXuZ3K03Wo+yXrjN8h/+dUl3I=;
        b=qWKvirL7gl5c7/LiHDC5O6FWly6P6DxmmyhivgC3YooeFAxo/RJTQXzfAHN0pMQB3W
         KjGbO+zFvzx7fU7/h5W0T7b9dJ9iDQmKEK71RAFf2zCGKTkgJwO1BxvoORN3yc9Coshx
         J5vXQGDGxgode4JVpdsEcUKHWKZBlLx0o2XM/LVKaqwAjcs4BNHhxD3i91HhKPnUUb5I
         /oTbxaY3+zHTAvhbUWuQz1YnVht/BZx5jBFyRehFSz6oh8AyJ59wCmPgPsthX4hrabzz
         iJ5jH6oWhHaO0vumpxWd6CnMhGigPJHOgf8kmmx7ZDXKyBh3+R5lPTsCJTX6+cWJA81O
         52dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790781332; x=1791386132;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=SWvsF7wDxyvpkamYYOoXuZ3K03Wo+yXrjN8h/+dUl3I=;
        b=a6lD9JlWQnoIoLlHZT9dURTisfJJYP3CzziFZE3lTaL8CJRNehseWJ+MpjePoR3hCw
         n7Sm2G7PtKeEwIggwBVSeI8WyiV3kF69BV8ozFQVmidauu4mEr4/j/MZ/bWjedhOxuLZ
         u4RVVa/WHIlGZr3NAX1undyKKRec0EGDigRVWFCa3esfarJjKSAiacmp0QPhKBdUK4YE
         z/3vvs29qb0iHXeEEGq6g6x8oIXxJ3KajRngXAJEMYYfTkxBgzO3+kiRc7Dgigy5TRx8
         ZtIA1PLqO/S46Z3OyQKWX8xggmb/YOqntBJ6yaSFIf/l+fyKGeY0u9eyftkT72K1bL+t
         Sw+A==
X-Gm-Message-State: AFuF++ms466dqwEQ/f8TW9H6wRTrXsx8lumEIJ+cKw3UNrTNccmGlaxp
	eEvJC4u6+KPF+cjdeEj8dMyBC/SMweHqICjLf5DGKmxgLH1G9nifSnB4
X-Gm-Gg: AYBFou0qqBIYcF9PtSXnZZEyqkTMQaMEgx/TTllbWMT4t4aD1x5z+k5hI99ARQ1NsAE
	A9ODF2/tnlPTFgJDnsNPLWMhJTw9A+kRu4OjuswultkV/UO5p1ll8CWOMA5KfjwcLehMpMjNBeT
	cz94OSDZhFNeTMHU3ZFgQ4tB3oVAWQehdevMvTYbM58xDZN5HRgr6HO6U5iTjBf5Byc0lhm5LIF
	BxhP4fgMX/TgTWiqx+klLMigkWA56JVG7Ytah4ZhLXrZjFSgDCRvopvuuvsLB6pPOPOgdVNEcFf
	izZggqpobV2mkxPc1SN1pwCPq6Bvvq/K535Anf4cYydlk5cxTbSGXWjR+x/4M3qgaV2ncXW2Xk3
	OQQLCDdFe+0txpqMaqFSC9NVRd6+t2ShUNCag/kWQZVWOccrEct2mRnFdFVvORSF1afdQ8HPURQ
	50WbrGN7DnUEvAoZory3UHx0pFxWfmDwj/W/ifQll5fF9fxwsFRcbr4exBNKFhq1NF1fdOhyYJ4
	OuOb/FCsQu45e1SoBGzJATWH09VS9M1qIsRIw==
X-Received: by 2002:a05:600c:4691:b0:49e:799a:8951 with SMTP id 5b1f17b1804b1-4a01aff4450mr26126105e9.11.1790781331161;
        Wed, 30 Sep 2026 08:15:31 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:c442:398f:5ba7:af40])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01e686cf1sm5713405e9.15.2026.09.30.08.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 08:15:30 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 30 Sep 2026 17:15:29 +0200
Subject: [PATCH] packed-refs: use `fwrite()` when passing refs verbatim
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260930-kn-speedup-packed-refs-v1-1-111cd03d9b0e@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMUQqDMBCE4avIPruQWhTTqxQfYjK2WyEN2VoK4
 t1N9fEbmH8lRRYo3aqVMr6i8o4Fl7oi/3TxAZZQTI1pOmOvhufImoCwJE7OzwicMSnbvuunNhg
 3wlI5p7LK7wjfh9O6jC/4z79G27YD+wJDy3oAAAA=
X-Change-ID: 20260930-kn-speedup-packed-refs-9868f5d0abe9
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4962; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=q0ith4kl4WVUNFqPIKxfPvo9tmjzWbDblymgnp5ku0E=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGq9J5Ht+lP5mz3+cxKGf6e9ynNvJdKap0QBC
 xiZ07bUCVuLlYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJqvSeRAAoJED7VnySO
 Rox/bUEMAISLGcXV81Dew2foBvFqwbDHfeiSFt1++/LbR3eqHF/FgJG6zAfrbX0Wr51/SQPXXbZ
 sQapsigiBZ/7gTD43yNepYcTPWRrrwag0PAtVjoFNhN9lLvTtU56FLlQhH1N1JMohmDWFQ2SSsF
 X8f6hoEvIvBz+BhKtTxI10H6gzvYpt1Xa3t3Ys4z8EdcbXhbKB7SmbvhLRjw8Qs+ajJTP1ukA0y
 xb+K5SeUdkwSsO+HGPZfrF3WEPNV9UEMbLneELvj6c62yOpVlFkoff3MfqDCkdaqk5wMKa/QIlg
 +WP1OObGmnd/8Q5vVdCJoRZW1Lr6xVAchQRSi3wKfIv5RlnLZ3wj70f3888V4wWRKaWXHGQUDtk
 iVfkgI6MGVdWS19nV2U2JVbtM6qc200EqYbkMYzsVJzh8UgMq4AncaiL19O/SkhvUz4W7a2csYn
 oDXaRrSrKlQd35o+4WcLtXFPdZJIHyftn2v7f7vt3mGUyhMXoxdSGXzyJHwdeXlA0QV8vBNtYv6
 1w=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The `write_with_updates()` function uses a `struct ref_iterator` to
iterate over all refs to write to the temporary packfile. It receives
the iterator from `packed_ref_iterator_begin()` which takes a snapshot
of the 'packed-refs' file.

While writing to the new packfile, writes are routed via
`write_packed_entry()` which uses `fprintf()`. Even for references which
haven't changed, we use the same mechanism. Instead, let's track the
position of unchanged references in the snapshot iterator and directly
use `fwrite()`.

This removes the unnecessary formatting operation involved. We can see a
consistent ~20% performance improvement when deleting from packed
references.

Benchmark 1: update-ref: delete ref (refcount = 100000, revision = master)
  Time (mean ± σ):      28.7 ms ±   1.7 ms    [User: 22.5 ms, System: 5.9 ms]
  Range (min … max):    26.7 ms …  33.3 ms    46 runs

Benchmark 2: update-ref: delete ref (refcount = 100000, revision = b4/kn-speedup-packed-refs)
  Time (mean ± σ):      23.8 ms ±   1.2 ms    [User: 17.5 ms, System: 6.0 ms]
  Range (min … max):    22.1 ms …  27.7 ms    56 runs

Summary
  update-ref: delete ref (refcount = 100000, revision = b4/kn-speedup-packed-refs) ran
    1.21 ± 0.09 times faster than update-ref: delete ref (refformat = files, refcount = 100000, revision = master)

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs/packed-backend.c | 43 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 11 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index a73fc6aca7..ef952cdba6 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -879,6 +879,12 @@ struct packed_ref_iterator {
 	/* The current position in the snapshot's buffer: */
 	const char *pos;
 
+	/*
+	 * Start of the current record, set when advancing `pos`. Used to
+	 * pass records verbatim to `fwrite()`.
+	 */
+	const char *record_start;
+
 	/* The end of the part of the buffer that will be iterated over: */
 	const char *eof;
 
@@ -933,6 +939,7 @@ static int next_record(struct packed_ref_iterator *iter)
 	if (iter->pos == iter->eof)
 		return ITER_DONE;
 
+	iter->record_start = iter->pos;
 	iter->base.ref.flags = REF_ISPACKED;
 	p = iter->pos;
 
@@ -1218,17 +1225,27 @@ static struct ref_iterator *packed_ref_iterator_begin(
 
 /*
  * Write an entry to the packed-refs file for the specified refname.
- * If peeled is non-NULL, write it as the entry's peeled value. On
- * error, return a nonzero value and leave errno set at the value left
- * by the failing call to `fprintf()`.
+ *
+ * If the raw data is available, skip the formatting and directly write to
+ * the file using `fwrite()`. e.g. when deleting references and remaining
+ * refs need to be written verbatim. Otherwise, use `fprintf()`.
+ *
+ * If peeled is non-NULL, write it as the entry's peeled value.
+ *
+ * On error, return a nonzero value and leave errno set at the value left
+ * by the failing call to `fwrite()` or `fprintf()`.
  */
-static int write_packed_entry(FILE *fh, const char *refname,
-			      const struct object_id *oid,
+static int write_packed_entry(FILE *fh, const char *raw, size_t raw_len,
+			      const char *refname, const struct object_id *oid,
 			      const struct object_id *peeled)
 {
-	if (fprintf(fh, "%s %s\n", oid_to_hex(oid), refname) < 0 ||
-	    (peeled && fprintf(fh, "^%s\n", oid_to_hex(peeled)) < 0))
+	if (raw) {
+		if (fwrite(raw, raw_len, 1, fh) != 1)
+			return -1;
+	} else if (fprintf(fh, "%s %s\n", oid_to_hex(oid), refname) < 0 ||
+		   (peeled && fprintf(fh, "^%s\n", oid_to_hex(peeled)) < 0)) {
 		return -1;
+	}
 
 	return 0;
 }
@@ -1530,9 +1547,13 @@ static enum ref_transaction_error write_with_updates(struct packed_ref_store *re
 		}
 
 		if (cmp < 0) {
-			/* Pass the old reference through. */
-			if (write_packed_entry(out, iter->ref.name,
-					       iter->ref.oid, iter->ref.peeled_oid))
+			const struct packed_ref_iterator *packed_iter =
+				(const struct packed_ref_iterator *)iter;
+			size_t len = packed_iter->pos - packed_iter->record_start;
+
+			if (write_packed_entry(out, packed_iter->record_start,
+					       len, iter->ref.name, iter->ref.oid,
+					       iter->ref.peeled_oid))
 				goto write_error;
 
 			if ((ok = ref_iterator_advance(iter)) != ITER_OK) {
@@ -1551,7 +1572,7 @@ static enum ref_transaction_error write_with_updates(struct packed_ref_store *re
 		} else {
 			bool peeled = update->flags & REF_HAVE_PEELED;
 
-			if (write_packed_entry(out, update->refname,
+			if (write_packed_entry(out, NULL, 0, update->refname,
 					       &update->new_oid,
 					       peeled ? &update->peeled : NULL))
 				goto write_error;

---
base-commit: a018953688f1b10bddf91bff8747068f5f4746a4
change-id: 20260930-kn-speedup-packed-refs-9868f5d0abe9


Thanks
- Karthik

