Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7FF396B9D
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 09:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791278328; cv=none; b=g6I3EGfcV9Jhkn7e5gPdJhY7W8GrhiS27wBGlcLNblgBMNcCiwWZLt3ebMab0KMNtJEVVCqYLBWdXLEHvTiVrMcdtnd5H0bBA9pkhPOeMgYh46bw0F8oIFv2kpkfzYKo4iSVg8elLVClCn1umFYhrmIVR/8A4Fu7kTwyoaTEl9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791278328; c=relaxed/simple;
	bh=NN/YM3aaYYQslP0/R/Z3kiGhObcgeXsvBLD0DuamxiM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:
	 In-Reply-To:References:To:Cc; b=SLCxnGfXFR5I3X4pO5CTz7HxWd2+YELmhm3gRxwag4cvUQJZqjz4MSqz8GykXjduGRbti5eCp4CPBrYBUgV3xy/xJiRMU7499HUvYF/i2aDrW7h/X8sYLt2jDrASqqjhHfeu5VI2d1wqkakJfypLUtBXXSyLdq01emnhi3VEh10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jErpZHFm; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jErpZHFm"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48c4d99c32bso379735f8f.1
        for <git@vger.kernel.org>; Tue, 06 Oct 2026 02:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791278323; x=1791883123; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iocz87DT2PXBe2IjWwZji+Yl984xD2SrbxlDSj4Apo8=;
        b=jErpZHFmgtSnDrZSTQFfgtYVOzpTaCyPj7ms+aLGLbLLfENNe2kXRNwGJYmEvnjJof
         OqUhwjG7YGXyNWRXNcrEb+XhfIJslcpcDOOVJin/VcoWJtwIqP8WGppRHJ66FRJyBlSN
         dA2SIEIYi/5U9cbVigUEWmE/TLR4yYlshhE/4ek+5Dd2965O42ZnNPbjgHGic0a8fC+4
         dLWOwcJju+M+A2CUyrkU3ErlVDwoPJq9jWcZfTJrRGLos8LyS+aM9/3fCkRvDfyH1ra6
         +ZCIAHD53jOn7g2dS8WJwXOOKsb3GLwWeL/dj8dIpA9pci6OzZWyCjrK7xXuB9b4/N1C
         kRZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791278323; x=1791883123;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iocz87DT2PXBe2IjWwZji+Yl984xD2SrbxlDSj4Apo8=;
        b=05aP0TGkgiTEgN3XWiPYn3GmjnRnJl74r08fiwDDCWOAHfyPC+pv383onSg0S8myQa
         PnLD0vNiLyy6RHCfEULSGsutxLY+AbbJXlT6Dp0GilQumbXjyhxpu0w2VxuRlmWgRnzP
         zpwOVvchUxKinVfl0JXyPS5Ja1xviju5+7b1oKMYpqNn9CRcmjZ9LyNL6iqiS6OCCnRf
         wYTOVA/VCFBWiDwxkgLw3oyEyGAvXcfj6TzYzgTD6k/B2BmdnihcOpoZ26emgvDR/zTU
         JvtmxH7uayLdA6wrBmYF7usffCXw5MKINCtrGV+DyHXnBtSVCfqIkdMYdtz9e7w8vGrE
         vtvg==
X-Gm-Message-State: AFq9FYKW7oA9B0V128t9nzqR2bUTISwnYYb7nLeiwsRCam+viJHcMVoB
	CjqjSDvg3xswyUr6gR06uPhqVFjcDPcDRE7KzIKDvjPCmUG7gVvRNB5wALbcsw==
X-Gm-Gg: AYBFou2LnFjSPZ4gYoiWX29L+oDi8cKXUOptOVAsLpP4gQNtc+HovMRUJsb5tRRKVWF
	fgOMZRM8xvWaNoWo3Rn9gSGikF7opnoUte0EqYwYlkOcrMYIea/xV5+msb2AnQp8Wxd3VBBbkZ1
	irjuvWKwx5Oroi9HQyYuKI1cVYSnNRPQevXeunNeFBJhnP4vkQ+tVuKay8HQInZ6AwFwtE7YF/x
	w8p7qU+jTWBLJDUbhUW+2jI2eOxc8wZagrf+FLR6rwph41STHdUAga++zpLIooKToWmdBCm+0Q1
	z66vtr0W3E0SyPxjD6MIJwZjeWiuvKXG+lwVYuep2PPljQn2Aevq+X9yyYksrc/ShNckxYPa/6j
	WU5All7NUI06MDSqDgxDmp/GSST9JleZIrNZZzRJnib/YFP1hmpZ/kQs3OyG5UKL+jlckwbmu6a
	/ZXtvUypivexHWxDgOr7rmdoDXqFHzx7ugHyUgRcNeXYfE/98DIbyVSDOKJngKMRjfOCIFy7Eq8
	8BJvsjeR1hkPfIVfYLzpWEXsOHQhqnG1j3FMA==
X-Received: by 2002:adf:e194:0:b0:486:e6a2:2d7c with SMTP id ffacd0b85a97d-48c6d16d87dmr1494642f8f.15.1791278323114;
        Tue, 06 Oct 2026 02:18:43 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:ebe5:eb60:6499:b48e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c6308481dsm10363766f8f.3.2026.10.06.02.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 02:18:42 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 06 Oct 2026 11:18:40 +0200
Subject: [PATCH v3] packed-refs: use `fwrite()` when passing refs verbatim
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261006-kn-speedup-packed-refs-v3-1-a1c76b1df9e0@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNyw6CMBBFf4V0bU1bwqOu/A/joo8BKgJNC42G8
 O+2mBg3xszqTO49d0UenAGPTtmKHATjzTRGyA8ZUp0YW8BGR0aMsJLwnOB+xN4C6MViK1QPGjt
 oPOZ1WTeFJkICR7Fs49c8dvHl+ma/yBuoOdlSojN+ntxzXw405f6OBIrjUao0yTWXBM7tIMz9q
 KYBpZHAPhpKCPupYVHDBFRFVTGQin5rtm17AazSLQQVAQAA
X-Change-ID: 20260930-kn-speedup-packed-refs-9868f5d0abe9
In-Reply-To: <20260930-kn-speedup-packed-refs-v1-1-111cd03d9b0e@gmail.com>
References: <20260930-kn-speedup-packed-refs-v1-1-111cd03d9b0e@gmail.com>
To: git@vger.kernel.org
Cc: toon@iotcl.com, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4363; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=NN/YM3aaYYQslP0/R/Z3kiGhObcgeXsvBLD0DuamxiM=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGrEvPJzf+evuVtcgtSBH2QKR8S4u34RjejM0
 Iyj4HtwmqDvo4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJqxLzyAAoJED7VnySO
 Rox/1QkMAIHP8TKL52KGj47tmPZijUpDgC5I4DB+gjxQrnf1Td9mjRHv7TW2iMUZvnBE4Vn3hQA
 yoaHAwguW5+pSbXopzkXEacH8D8q3K603gT1BPwV0N8/H2GJjtZZ47kApqBWOBw7BNXqHUMX0hU
 uckYJufyhlszF1TZVoCCaxceDRWHz0La75abiyCfHaIsAg5sd2zy4YoyIuWCuuUgNnL4YRDrrtw
 QuM725k43o3sb15zdz+S6PpCkV1S81zkmxGB/3WqiYcJBnAsU5RK6h0S/8uDI8vr6sYDtQ44WCi
 8zM3WzuWem0zhIKiTmnTWiGHLYy0LhL+zgoCNysLPMKIAtT50s3e7ezTKZ4VWZupcMoo4LBjg8I
 ruPlQPSOaRZVteKKaE1BL8KG8wvGAdL/ggd4KSci6oEscgbQoKUU5wmC5eyIemvLvS+Z+gcEIfN
 eDyQCn0RbgyD4IJxsRZM5zxd5yoXmyQOA1bnHnucLY5tw5zLsF6UnDJ7Fy7lgbKdhz+ClyaQjt7
 Ek=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The `write_with_updates()` function uses a `struct ref_iterator` to
iterate over all refs to write to the temporary packed-refs file. It
receives the iterator from `packed_ref_iterator_begin()` which takes a
snapshot of the 'packed-refs' file.

While writing to the new packed-refs file, writes are routed via
`write_packed_entry()` which uses `fprintf()`. Even for references which
haven't changed, we use the same mechanism. Instead, let's track the
position of unchanged references in the snapshot iterator and directly
use `fwrite()`.

With this, any sanitation which was happening as a side effect of
reformatting is now lost. But that was never the job of this section of
the code, since the main intention is to simply rewrite the remaining
refs post deletion of the selective few.

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
Changes in v3:
- Fixed a typo in the commit message.
- Link to v2: https://patch.msgid.link/20261002-kn-speedup-packed-refs-v2-1-2ae75772ebc1@gmail.com

Changes in v2:
- Instead of using the existing function, introduce a new
  `write_packed_entry_raw()`.
- Modify the commit to also note that we lose sanitization.
- Link to v1: https://patch.msgid.link/20260930-kn-speedup-packed-refs-v1-1-111cd03d9b0e@gmail.com
---
 refs/packed-backend.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index a73fc6aca7..43ad674cf4 100644
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
 
@@ -1233,6 +1240,19 @@ static int write_packed_entry(FILE *fh, const char *refname,
 	return 0;
 }
 
+/*
+ * Write an entry to the packed-refs file skip any formatting and directly
+ * write to  the file using `fwrite()`. e.g. when deleting references and
+ * remaining refs need to be written verbatim.
+ */
+static int write_packed_entry_raw(FILE *fh, const char *entry, size_t len)
+{
+	if (fwrite(entry, len, 1, fh) != 1)
+		return -1;
+
+	return 0;
+}
+
 int packed_refs_lock(struct ref_store *ref_store, int flags, struct strbuf *err)
 {
 	struct packed_ref_store *refs =
@@ -1530,9 +1550,13 @@ static enum ref_transaction_error write_with_updates(struct packed_ref_store *re
 		}
 
 		if (cmp < 0) {
-			/* Pass the old reference through. */
-			if (write_packed_entry(out, iter->ref.name,
-					       iter->ref.oid, iter->ref.peeled_oid))
+			const struct packed_ref_iterator *packed_iter =
+				(const struct packed_ref_iterator *)iter;
+			size_t len = packed_iter->pos - packed_iter->record_start;
+
+			if (write_packed_entry_raw(out,
+						   packed_iter->record_start,
+						   len))
 				goto write_error;
 
 			if ((ok = ref_iterator_advance(iter)) != ITER_OK) {

---
base-commit: a018953688f1b10bddf91bff8747068f5f4746a4
change-id: 20260930-kn-speedup-packed-refs-9868f5d0abe9


Thanks
- Karthik

