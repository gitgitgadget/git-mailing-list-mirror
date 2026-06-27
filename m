Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC35F227EA4
	for <git@vger.kernel.org>; Sat, 27 Jun 2026 17:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782581352; cv=none; b=reJckSKOvsfMeiZuQrAnj7Fmv+Raadk8UDYe0rowFqK7kErz8umrx2fEnzWuwqR+FN7fnYK6IBGgvluVbrUwNe0nj0QlJQ+gs7ErHirM4+MJkf0Y08rOn6xqF8sdy5JqtGIlr7wtvcZ/agkBfkVrr0+7KMObIbBu6VCyGqMhsqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782581352; c=relaxed/simple;
	bh=Qstzn8xZz/xw187lvI4MMhTXZ0N0to+fjKUrscjMrkI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ry9l/8VSR+2sxmY8lDgxW5qdg7IF3U7g7rY35iSpza/KFzMvU8PqUexWTASE2d8i6B6khih21HfjhaWQr49qP1guDHwypDJ+myebr3s60ixN0ZeOErCJngjfd1ndYVA97VQYOxJ+SoftOhnZ0pmNowYCVBsWrQGWO6LnVh3apKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C0OVCMBk; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0OVCMBk"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51a837c8618so15839741cf.1
        for <git@vger.kernel.org>; Sat, 27 Jun 2026 10:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782581350; x=1783186150; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QZxT0GyT9ITmjGWylni0KaZCyFC8/y+3b2JhZEVmscE=;
        b=C0OVCMBklu4agV9j/+uIrayTwGXa389U7Nsod1WOMh2DWbj7eCqFgYQ5FqqzjAcz1J
         lkMriOxUEcJ9dnX+xaovfJgyd9+6qYKNwOZGoX5Nkuos6QT9HD0NYYUjVvnYheEPuztD
         twXHXdZaJe+hFNV28+RLvu4aWg17a2hL6PccH7wEl8nSQiiiHtur/ZoofCVEghCDBAco
         1evuV0TRT54Xb/4Z+qIq0sDKrSO+xTiwJqbuQIZZ3DpY7wiCqJMtajj7nLzh5q5G4aGY
         Sha6g6gYXQRHo7av4N5BJkvi0SCNINZmuLmgQmt7+TA5BmJTcHSIWlX4TYDop5uG3rCm
         R2Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782581350; x=1783186150;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QZxT0GyT9ITmjGWylni0KaZCyFC8/y+3b2JhZEVmscE=;
        b=nPE3MSss6/5Pga8NpV3sYvn//iRn5fgPCUS+I0c9GcAEJZFf9MSGliLOdRShTKYG8O
         tL1RC8rPROWFWJLdMWoeiJTGcKwdUMjbDlQNwnkTAGLISGrV9FANNJq3OcY4UPVhWQqr
         wNXsI2xnT1FHAtJc9gw853A+jOmOnnuJWGwuFa1KruDkQ33MG9QFKPwAJvrUexjrPStk
         okVZMCybxTdszfoEwDDihy1E1r1EmmrL0X4sJwrKahG8G02QMNkky5r/GqsMaq1+m/av
         wV7KW/NpZRoLlMR3bCjPDX6Jw95XzwkmJtziBupe2Ddi/PB0VXmlfKffxFMUS/TMYLX+
         RD9Q==
X-Gm-Message-State: AOJu0YziLWx/1Fmewt/8IKOmL8msKRI8D8rJyWf3f5vkaPi79RGKnhgQ
	aXC5VzGssrR0Ahv9yMqxCw7sbtxClajYsPgKK5UqZHwiwzC3UP4K4fKsNeIWww==
X-Gm-Gg: AfdE7ckl3zozdffOBVqAfZh6FCS31IQN/56gdiV/Nd9VSC2tjnVL6+k7gkkZKok9kTz
	4SgZedKhI/J3j1dPIbdIt4rn/SHMR6hmN4YtztrFdoW6AaMTwfZgGEcNGu5UNCDI1s4Ti6We9xk
	EJVuqSm61hh63eZY3jpJL7vrYscQl23Z+ygFIUC5ppaL7ajJapi8nx/AqUmr9SxuAYid3rF4q+2
	QkmdIj28z3cq1JfB9MMq9yqq7wlKsRQkvwte9zvCyR5t/tyBeP4cN19DzS08f5zQ4IQp/wlvX3n
	QBC3uT4GdytLpKYtuyYeviBUUv+QKWgquM4qKJQhc1JwQJIsym8OaQBYm4p4LnYgYGeZ9Urmqkf
	BHBxNPqugJ53vzrXyDwgWDhpwe/jakiUZ99ia12VFElsGU2cckf3ywoKv3efhTDXzDMp/s5IdUl
	NVEoXyJWqjjBovPiu85q7Zy2qALg==
X-Received: by 2002:a05:622a:16:b0:517:6c6f:8ee6 with SMTP id d75a77b69052e-51a8af6e1fbmr71959441cf.6.1782581349907;
        Sat, 27 Jun 2026 10:29:09 -0700 (PDT)
Received: from [127.0.0.1] ([40.76.191.160])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51a51106a09sm121094881cf.0.2026.06.27.10.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 10:29:08 -0700 (PDT)
Message-Id: <d211c82e40446d1d0b33f117d817a03ad716eea0.1782581342.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2152.v2.git.1782581342.gitgitgadget@gmail.com>
References: <pull.2152.git.1781806593.gitgitgadget@gmail.com>
	<pull.2152.v2.git.1782581342.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 27 Jun 2026 17:28:57 +0000
Subject: [PATCH v2 3/7] diff: emit -L hunk headers via xdiff's formatter
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

