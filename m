Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE693839B7
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 05:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788411928; cv=none; b=g9JAt7W0lzo9QwmP8364s0aGVhThu09LPEH9yHszPPoY0+ZnzxPWJ9fOpr2cM5lOWbMYApm2btlVDd1neTjgV84xxNtzWGSw63S4aMayo/P6QADBnv0lBaeJm1qL3eVurEV+9yeoiMMg2uo8je2pgEpxhn3cw0yEcPkr6DXZ0XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788411928; c=relaxed/simple;
	bh=pKC8yx78kK9b6lY42KsmPZ0sJA1YzKesltM3CDom1Ws=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lXZNYKm+X0upaMsDmi6IGlEX8i2PGG/pM2Jx7pB9yAP65NnRFz9LzVadZkeqUqOSp/W6O3licJyhZ0FdUJio7o9wvPhACgoR2WSMe3E9Oy5w6mVLq2yKYWRg71IkoW96M1p2c7qzDsUTwhz7SvSvBSC1bzg6/60wXQoXG3oRsN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PIQKFPA7; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIQKFPA7"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-93900ed2925so181435385a.0
        for <git@vger.kernel.org>; Wed, 02 Sep 2026 22:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788411925; x=1789016725; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QuzM8H5cvXU1a2G1/zaJEVgu8W5CY9cmnnmDpRrIcaA=;
        b=PIQKFPA7G2yfXplFUIlWygivRvy0N334EqAIejCRxqt5hPYwQ5XyyqrTIWCFWLMLOg
         8jzNFZXSgxZpR2nCw4Xf3AgDg87eogzDQB7YvEKZbfi2oNwbfQ2rkxO47ALp1HPxmIRq
         W6QjRLZ5K0EInsC2SF/Mie4+2G09pm+J9XaCXaPv9gLbBE3/HkNaR+NKux2CFzcPm9jD
         xiVOGwp2+xkBS+88CxG4pZGvZQ8i5uwwJzMrp54EfIJS4JWw5puovjP6uTzM9avSEGro
         dUUj/4MecGHnMp885YAHuIr6Ci0gCSJFEz7rnXHSR+Wj9yutqHG2oh6urBHe2tlSI5W0
         1jbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788411925; x=1789016725;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QuzM8H5cvXU1a2G1/zaJEVgu8W5CY9cmnnmDpRrIcaA=;
        b=HZ+qWUqpPSxCyYm7VaCtjGWK59ySim6L/qNvzpAYZ1Aa/HRHffZTIrhhjgdyIbvUDG
         RNWWJlKOEPvwAt1+Xc4DaPnOvnQ09mXzdqRVluR5P3xParR16XJw3rSmzWIczmVM79uW
         S6fiE4P46JQyirC8tdTdxqwSLu2BoLarqUS1Ywfsnb98KxhNj3yBGA3f+wvY4ALxHn8q
         zJUf2sFbWqh1jhBCojDq+v8rZdPr1m67Lp+lAIXeNr6RsfHv9pXPBKRKE3eeCco+7sJ3
         xBCo63aI1oVdi//jqd8lRzljo5FhfXaYUIzlNAx2NHizps7CK0XtAKHBTvsbrWYZz/hR
         m/hw==
X-Gm-Message-State: AFuF++ndTe0KeyNIsolwk44x2jgP7HByoRxT/ZMIvnnyps08ypV4bkwe
	goVPsDxxFYN5znseDnP+fwK3KwsmCOCYuMh9Xbn+og+d5lV3HETCd++n3wCSdcQf
X-Gm-Gg: AYBFou17+VReL7t3uiMzG1Cm43C1soHp+0RoKsTbNl4LRw4LE5GwSTYgOPVjzky+rC3
	NcFYp0DCGbppGzgjHnymM87hKLj0eWzCW6VAiJZB5lQvw8eh+epC20hIj1WAzmSWRvonuvF5x8o
	662lzx8x+61WS2lFOh3vXrOYq712IoRgeG2RV4SADDOwsrpScc/exib8KhWFsfM27MHT+tWfLEm
	B2bXD2HRzwwb2uSyBf8QuycBrySYACdSyfGti1uf4qUOSN0yQti5wIKf+odIZw9PC0N27Wm8ZH7
	1zaKDJVeiFPtBcBcF7aAkf+fzTC2gSfC2eXDn0X10VGqjEgKo8FyW8NYByr64pdRWB4/f2p7k/Y
	FJE9LOCZMmRvd6MO8wDSJY/TmQvc54waqgekZUGtYTG4uFL7n6OnhBprGSarfUfIRR/muVhFY2g
	GYJv2dFIavuCj2WVlPorXzWH0i614yAiVnqynhIU4LpYYNPZOe1bEYdKrdpcJydEuuzhS4Hy27N
	Pc=
X-Received: by 2002:a05:620a:916d:b0:939:6de6:9515 with SMTP id af79cd13be357-9396de696dcmr401016885a.44.1788411925129;
        Wed, 02 Sep 2026 22:05:25 -0700 (PDT)
Received: from [127.0.0.1] ([48.217.140.230])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9395f35d823sm397881185a.25.2026.09.02.22.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 22:05:24 -0700 (PDT)
Message-Id: <2081d5d257d65b7b823fc46777e952a2f650e6dd.1788411919.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2152.v3.git.1788411919.gitgitgadget@gmail.com>
References: <pull.2152.git.1781806593.gitgitgadget@gmail.com>
	<pull.2152.v3.git.1788411919.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 03 Sep 2026 05:05:15 +0000
Subject: [PATCH v3 3/7] diff: emit -L hunk headers via xdiff's formatter
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
Cc: Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

Currently, diff's line-range filter implements its own method for
emitting diff hunk headers. This mostly matches what xdiff itself
outputs, but there is a discrepancy for postimage or preimage sides
with 0 line changes. For a side with no lines (count 0), the begin is
the line before the change. The header omits the line count of 1.

Rather than fix this case in the line-range implementation, expose the
function xdiff uses to emit its headers. Reusing it keeps the header
format consistent with and without -L.

Update test scenarios and fixtures to reflect the now consistent header
format.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 diff.c                                   | 21 ++++++++-------------
 t/t4211/sha1/expect.no-assertion-error   |  2 +-
 t/t4211/sha1/expect.vanishes-early       |  6 +++---
 t/t4211/sha256/expect.no-assertion-error |  2 +-
 t/t4211/sha256/expect.vanishes-early     |  6 +++---
 xdiff-interface.c                        | 19 +++++++++++++++++++
 xdiff-interface.h                        | 13 +++++++++++++
 7 files changed, 48 insertions(+), 21 deletions(-)

diff --git a/diff.c b/diff.c
index c94ddbebe5..cb1a85c624 100644
--- a/diff.c
+++ b/diff.c
@@ -2560,15 +2560,10 @@ static void flush_range_hunk(struct line_range_filter *filter)
 		return;
 	}
 
-	strbuf_addf(&hdr, "@@ -%ld,%ld +%ld,%ld @@",
-		    filter->accumulating_hunk.old_begin, old_count,
-		    filter->accumulating_hunk.new_begin, new_count);
-	if (filter->accumulating_hunk.func_name_len > 0) {
-		strbuf_addch(&hdr, ' ');
-		strbuf_add(&hdr, filter->accumulating_hunk.func_name,
-			   filter->accumulating_hunk.func_name_len);
-	}
-	strbuf_addch(&hdr, '\n');
+	xdiff_emit_hunk_header(&hdr, filter->accumulating_hunk.old_begin, old_count,
+			       filter->accumulating_hunk.new_begin, new_count,
+			       filter->accumulating_hunk.func_name,
+			filter->accumulating_hunk.func_name_len);
 
 	filter->ret = filter->orig_line_fn(filter->orig_cb_data, hdr.buf, hdr.len);
 	strbuf_release(&hdr);
@@ -2589,14 +2584,14 @@ static void flush_range_hunk(struct line_range_filter *filter)
 }
 
 static void line_range_hunk_fn(void *data,
-			       long old_begin, long old_nr UNUSED,
-			       long new_begin, long new_nr UNUSED,
+			       long old_begin, long old_nr,
+			       long new_begin, long new_nr,
 			       const char *func, long funclen)
 {
 	struct line_range_filter *filter = data;
 
-	filter->accumulating_hunk.lno_in_postimage = new_begin;
-	filter->accumulating_hunk.lno_in_preimage = old_begin;
+	filter->accumulating_hunk.lno_in_postimage = new_nr ? new_begin : new_begin + 1;
+	filter->accumulating_hunk.lno_in_preimage = old_nr ? old_begin : old_begin + 1;
 
 	if (funclen > 0) {
 		if (funclen > (long)sizeof(filter->accumulating_hunk.func_name))
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
index db6938689f..686db8bb8b 100644
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
index ce54e1c0e0..2428456629 100644
--- a/xdiff-interface.h
+++ b/xdiff-interface.h
@@ -76,4 +76,17 @@ int xdiff_compare_lines(const char *l1, long s1,
  */
 unsigned long xdiff_hash_string(const char *s, size_t len, long flags);
 
+struct strbuf;
+
+/*
+ * Append a unified-diff hunk header to `out`, e.g.
+ * "@@ -<old> +<new> @@ func\n". The header comes from wrapping xdiff's
+ * own hunk-header emitter, so it matches what a normal diff would
+ * produce for the given line number begins and line counts.
+ */
+void xdiff_emit_hunk_header(struct strbuf *out,
+			    long old_begin, long old_nr,
+			    long new_begin, long new_nr,
+			    const char *func, long funclen);
+
 #endif
-- 
gitgitgadget

