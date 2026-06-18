Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA43330B30
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 18:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781806602; cv=none; b=I69ZIuvh1MgLm6SeGFra3hoD7TlItwgLmiylq3ae+HjfqH9fd6axiBtiz4gYyHZh3nSUCRJc/22EW8FbaTCKGRWKZ2jdW9mXVXZ9k/A2Tqy0vOwzhoF/tcfs2Qv4NMbFX4WbLySOPHJQwAZHZp9Kjys/vlYynjezcWrMoyRsayI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781806602; c=relaxed/simple;
	bh=Qstzn8xZz/xw187lvI4MMhTXZ0N0to+fjKUrscjMrkI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=RRBlq7rJ+QYbxJcxxC5TA9UTfZIg0S3M7ttlp4qLQz9Bvzh3vISpiG9HZaMlvqGuvJmOYEfVyD61w3aQQsfpfU6/b1cw/yB12J9OF6zUk9LhZqKiw+fLVbH+dj2+z5sL424RjUMy3jFqa4e6eP7fARp5mEb5IlHs/xuwiFA6zsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lyD+TdUW; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyD+TdUW"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8ccf887de87so15411276d6.0
        for <git@vger.kernel.org>; Thu, 18 Jun 2026 11:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781806599; x=1782411399; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QZxT0GyT9ITmjGWylni0KaZCyFC8/y+3b2JhZEVmscE=;
        b=lyD+TdUWeWhZQlrzQxfkW+3yU4b0gQodgZJN2r23DcJXokfP+8/SQ1u/LD74wMSztt
         b8XI4FMohyKc8seK7sJAs1IXPdBcRJTT8DpUN8AaxJyp7UVPQrQetN0wo62krs/i45fK
         Rlk3SY7SQrLavBuvNcXO5k1Q57el2ctKlgCGQEIHyrvX9pJB10wggwmOa/1tYO2MRnTN
         eSQPB8RCQ5kJwAABLMTO2u31StzLMYsc2Ju/YK2W7UWidtEkmU2GON/6oD+A2eBTAEmO
         xMl8TOJr0py/pm7KdjoKkv6YO/ALqyEL4lsSsvf9f/U/rGCQK/iu+/IWE2QaaSLX7ZE6
         T4Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781806599; x=1782411399;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QZxT0GyT9ITmjGWylni0KaZCyFC8/y+3b2JhZEVmscE=;
        b=tKJ/KEIRxMX8KYe+xKH8NZ3ZPAFVUHuDGMc5Dc40HrEd3OGQ+9f+++HU/znXrGqfi9
         oKehWbXqSA8Kvmj3Ehfm+hdPMNuMQh+a7eQ4MhjVM2M7+A36ttFoqQWF8jGBU4HGYBA0
         GujxiSY5SRjGknM7IFc7oA/rEnMZfWOTBEPbjHYLYTQHY0DJIdMpv6UDMniOcRBFPrEN
         tY6SrOZMNzn8GPozVFIHCeZ3ZijQFrS0B54kGOR/8m8tiIReFfu+FnxLK74fIW04hu+p
         jVxNP1AoH27SzNK8gsyVEuz5g20ME2vpUN6VeC0Eh590diK4YMEdAEq6HK/5ZrRZhZK9
         ijow==
X-Gm-Message-State: AOJu0Ywv5vLqWfYFqXYmGiPNYScOuRw1JHt0yTFaOjRmO5xDTrUAJj1p
	hjDWgyo/RZY88xZdyRVsCqzoZRrODJygGLIwJZ79xh4o59lD+QMHJtVg6oHohw==
X-Gm-Gg: AfdE7cmd/5esKK6zIhHbJk8BiqTpSfIaeHWbHNTfoIqWo0Jf/d+VdIET12TTgZadk/e
	LX8w871fP498cNUgjv8djAn6Pu5vD2e7dVU+AULhJs5eqzKbZ1yxhQx6bMkqCvgfBjhxXt+fgLz
	087I+mGYNOyr9D3neChjbuyYc0pUbkOxTYuW7Loy5U5kx9c8IuXNgKyFlB1OgOsiJGMoCuJjeh9
	u2jIU7IBEC10v9vF/LB/JBBHWR+3/i/5qi4acxDy7bG45Qb+c0MDo5FdFdPHB9p4/nbP94fLBrY
	9+hqwXx7GE/dbi5XGqBQTZ3Ai+puw71uLO0+nGgzJ5EvLCehxldk+2pjCp8hTOGlnnRcm8HuOKL
	XcLdC4PXtlCV8qmhYoAIvUqIOzUQ/vuj2mMzD8sJNkIgS4ZWB1lbQhs974ZvX1ie6iZlhADFraM
	S5l/cHhqpkmxuaZA==
X-Received: by 2002:a0c:e991:0:b0:8ce:f1b:74ea with SMTP id 6a1803df08f44-8de42555b61mr3330506d6.24.1781806599072;
        Thu, 18 Jun 2026 11:16:39 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.177.0])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d9f47407desm102115416d6.25.2026.06.18.11.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 11:16:38 -0700 (PDT)
Message-Id: <d211c82e40446d1d0b33f117d817a03ad716eea0.1781806593.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2152.git.1781806593.gitgitgadget@gmail.com>
References: <pull.2152.git.1781806593.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 18 Jun 2026 18:16:28 +0000
Subject: [PATCH 3/7] diff: emit -L hunk headers via xdiff's formatter
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

The line-range filter builds its own "@@ -<old> +<new> @@" header for
each range hunk.  For a side with no lines (count 0, such as the old
side of a pure insertion), the begin should be the number of the line
before the change, per the convention git diff and xdl_emit_hunk_hdr()
follow.  The hand-rolled code's begin was one too high; in t4211 this
produced

	@@ -25,0 +18,9 @@

an old begin of 25 in a 24-line file, where git diff would give 24.

Stop hand-rolling the header.  flush_range_hunk() now formats it through
xdiff's own emitter: a new xdiff_emit_hunk_header() helper wraps
xdl_emit_hunk_hdr(), the function that produces every other diff's hunk
headers.  The count-0 begin is then correct by construction, and as a
side effect -L headers match git diff exactly, including its omission of
a count of 1 ("@@ -22 +22 @@" rather than "@@ -22,1 +22,1 @@").

xdiff's hunk callback already hands line_range_hunk_fn() a count-0 begin
decremented, so undo that when seeding the cursors and let the formatter
re-apply the convention once, at emit time.

The off-by-one predates this series, and the two regenerated fixtures
reach it from different origins: no-assertion-error has carried it since
its test was added in ab60c693a2 (line-log: fix assertion error,
2025-08-18), while vanishes-early acquired it when 86e986f166 (line-log:
route -L output through the standard diff pipeline) reshaped its tracked
line into a pure insertion.  vanishes-early also drops its count-1
counts.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 diff.c                                   | 27 +++++++++++-------------
 t/t4211/sha1/expect.no-assertion-error   |  2 +-
 t/t4211/sha1/expect.vanishes-early       |  6 +++---
 t/t4211/sha256/expect.no-assertion-error |  2 +-
 t/t4211/sha256/expect.vanishes-early     |  6 +++---
 xdiff-interface.c                        | 19 +++++++++++++++++
 xdiff-interface.h                        | 15 +++++++++++++
 7 files changed, 54 insertions(+), 23 deletions(-)

diff --git a/diff.c b/diff.c
index ee765d7ac2..9751bb6798 100644
--- a/diff.c
+++ b/diff.c
@@ -2636,14 +2636,9 @@ static void flush_range_hunk(struct line_range_filter *filter)
 		return;
 	}
 
-	strbuf_addf(&hdr, "@@ -%ld,%ld +%ld,%ld @@",
-		    filter->hunk.old_begin, old_count,
-		    filter->hunk.new_begin, new_count);
-	if (filter->funclen > 0) {
-		strbuf_addch(&hdr, ' ');
-		strbuf_add(&hdr, filter->func, filter->funclen);
-	}
-	strbuf_addch(&hdr, '\n');
+	xdiff_emit_hunk_header(&hdr, filter->hunk.old_begin, old_count,
+			       filter->hunk.new_begin, new_count,
+			       filter->func, filter->funclen);
 
 	filter->ret = filter->orig_line_fn(filter->orig_cb_data, hdr.buf, hdr.len);
 	strbuf_release(&hdr);
@@ -2668,19 +2663,21 @@ static void flush_range_hunk(struct line_range_filter *filter)
 }
 
 static void line_range_hunk_fn(void *data,
-			       long old_begin, long old_nr UNUSED,
-			       long new_begin, long new_nr UNUSED,
+			       long old_begin, long old_nr,
+			       long new_begin, long new_nr,
 			       const char *func, long funclen)
 {
 	struct line_range_filter *filter = data;
 
 	/*
-	 * When count > 0, begin is 1-based.  When count == 0, begin is
-	 * adjusted down by 1 by xdl_emit_hunk_hdr(), but no lines of
-	 * that type will arrive, so the value is unused.
+	 * Seed the per-image line cursors from the hunk header's begins.  For
+	 * a side with no lines (count 0), xdiff's callback has already moved
+	 * its begin to the line before the change, so add one back to recover
+	 * the true 1-based start.  xdiff_emit_hunk_header() reapplies that -1
+	 * when the clipped hunk is emitted.
 	 */
-	filter->lno_in_postimage = new_begin;
-	filter->lno_in_preimage = old_begin;
+	filter->lno_in_postimage = new_nr ? new_begin : new_begin + 1;
+	filter->lno_in_preimage = old_nr ? old_begin : old_begin + 1;
 
 	if (funclen > 0) {
 		if (funclen > (long)sizeof(filter->func))
diff --git a/t/t4211/sha1/expect.no-assertion-error b/t/t4211/sha1/expect.no-assertion-error
index 54c568f273..95faf51a7b 100644
--- a/t/t4211/sha1/expect.no-assertion-error
+++ b/t/t4211/sha1/expect.no-assertion-error
@@ -8,7 +8,7 @@ diff --git a/b.c b/b.c
 index bf79c2f..27c829c 100644
 --- a/b.c
 +++ b/b.c
-@@ -25,0 +18,9 @@
+@@ -24,0 +18,9 @@
 +long f(long x)
 +{
 +	int s = 0;
diff --git a/t/t4211/sha1/expect.vanishes-early b/t/t4211/sha1/expect.vanishes-early
index a413ad3659..e4b1a201d5 100644
--- a/t/t4211/sha1/expect.vanishes-early
+++ b/t/t4211/sha1/expect.vanishes-early
@@ -8,7 +8,7 @@ diff --git a/a.c b/a.c
 index 0b9cae5..5de3ea4 100644
 --- a/a.c
 +++ b/a.c
-@@ -23,0 +24,1 @@ int main ()
+@@ -22,0 +24 @@ int main ()
 +/* incomplete lines are bad! */
 
 commit 100b61a6f2f720f812620a9d10afb3a960ccb73c
@@ -21,7 +21,7 @@ diff --git a/a.c b/a.c
 index 5e709a1..0b9cae5 100644
 --- a/a.c
 +++ b/a.c
-@@ -22,1 +22,1 @@ int main ()
+@@ -22 +22 @@ int main ()
 -}
 +}
 \ No newline at end of file
@@ -37,5 +37,5 @@ new file mode 100644
 index 0000000..444e415
 --- /dev/null
 +++ b/a.c
-@@ -0,0 +20,1 @@
+@@ -0,0 +20 @@
 +}
diff --git a/t/t4211/sha256/expect.no-assertion-error b/t/t4211/sha256/expect.no-assertion-error
index c25f2ce19c..815d27f7f1 100644
--- a/t/t4211/sha256/expect.no-assertion-error
+++ b/t/t4211/sha256/expect.no-assertion-error
@@ -8,7 +8,7 @@ diff --git a/b.c b/b.c
 index 69cb69c..a0d566e 100644
 --- a/b.c
 +++ b/b.c
-@@ -25,0 +18,9 @@
+@@ -24,0 +18,9 @@
 +long f(long x)
 +{
 +	int s = 0;
diff --git a/t/t4211/sha256/expect.vanishes-early b/t/t4211/sha256/expect.vanishes-early
index bc33b963dc..263fc9eaac 100644
--- a/t/t4211/sha256/expect.vanishes-early
+++ b/t/t4211/sha256/expect.vanishes-early
@@ -8,7 +8,7 @@ diff --git a/a.c b/a.c
 index e4fa1d8..62c1fc2 100644
 --- a/a.c
 +++ b/a.c
-@@ -23,0 +24,1 @@ int main ()
+@@ -22,0 +24 @@ int main ()
 +/* incomplete lines are bad! */
 
 commit 29f32ac3141c48b22803e5c4127b719917b67d0f8ca8c5248bebfa2a19f7da10
@@ -21,7 +21,7 @@ diff --git a/a.c b/a.c
 index d325124..e4fa1d8 100644
 --- a/a.c
 +++ b/a.c
-@@ -22,1 +22,1 @@ int main ()
+@@ -22 +22 @@ int main ()
 -}
 +}
 \ No newline at end of file
@@ -37,5 +37,5 @@ new file mode 100644
 index 0000000..9f550c3
 --- /dev/null
 +++ b/a.c
-@@ -0,0 +20,1 @@
+@@ -0,0 +20 @@
 +}
diff --git a/xdiff-interface.c b/xdiff-interface.c
index 5ee2b96d0a..32e04630ee 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -91,6 +91,25 @@ static int xdiff_outf(void *priv_, mmbuffer_t *mb, int nbuf)
 	return 0;
 }
 
+static int strbuf_out_line(void *priv, mmbuffer_t *mb, int nbuf)
+{
+	struct strbuf *out = priv;
+	int i;
+	for (i = 0; i < nbuf; i++)
+		strbuf_add(out, mb[i].ptr, mb[i].size);
+	return 0;
+}
+
+void xdiff_emit_hunk_header(struct strbuf *out,
+			    long old_begin, long old_count,
+			    long new_begin, long new_count,
+			    const char *func, long funclen)
+{
+	xdemitcb_t ecb = { .priv = out, .out_line = strbuf_out_line };
+	xdl_emit_hunk_hdr(old_begin, old_count, new_begin, new_count,
+			  func, funclen, &ecb);
+}
+
 /*
  * Trim down common substring at the end of the buffers,
  * but end on a complete line.
diff --git a/xdiff-interface.h b/xdiff-interface.h
index ce54e1c0e0..51c88296ed 100644
--- a/xdiff-interface.h
+++ b/xdiff-interface.h
@@ -76,4 +76,19 @@ int xdiff_compare_lines(const char *l1, long s1,
  */
 unsigned long xdiff_hash_string(const char *s, size_t len, long flags);
 
+struct strbuf;
+
+/*
+ * Append a unified-diff hunk header to `out`, e.g.
+ * "@@ -<old> +<new> @@ func\n".  The header comes from wrapping xdiff's
+ * own hunk-header emitter, so it matches what a normal diff would
+ * produce for these begins and counts.  For a side with no lines
+ * (count 0) the begin is the line before the change, and a count of 1
+ * is omitted.
+ */
+void xdiff_emit_hunk_header(struct strbuf *out,
+			    long old_begin, long old_count,
+			    long new_begin, long new_count,
+			    const char *func, long funclen);
+
 #endif
-- 
gitgitgadget

