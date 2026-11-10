Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794311410;
	b=Y+OoewNylGkBPw35Wv7PYjLylTwu6yY8XZAFR0aAKWUXgp0517ckz3o8Wq3DNFk5jlMz
	 DKERGhyTywJ6eSvh07nXoI6HgmoHpJrRdgFtanRcl0+Q5yVdRJSkB2DlZySNlUY039j7Q
	 xLznc7cCByp+K8mkD+gq5EblQeKN+KTJudzvzuUd+lhfcXjzGdZFaikjMtdbW/HVjFW0i
	 QflAjdE6YG8Gfaocx5YHX71bdPoG/SFHQETfYKsfYoiPopB8kf4kSgCe6xw/nF8nsGdiI
	 A3gxGdw0Gwh7uEL/hj7ZK+4T3Hu+ZIi5NmPfW3W9aT0+wrfAbjb350ituxAWpS635mA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311410;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=Son7yw6NEgXS7N5jbgPLyq4DTY+5vMmlfhphK359Fds=;
	b=y6uHphy/j4Wc1W6CGdyMkN0sIjiBZCpJ+UPtJThxELdDgjxC3bwZmW+G9YjOF9Z14+/x
	 drvlIZKrtkiTJa07tIFC2y0rD80NbXs9snfTllNjEykNfvEsGJJIdPg5Aqf/R+xWpYVJK
	 AWCBgwksiVpZJgluhZLc/6xKy7Dh6QTZJ9p407O6vOsHPqfeV1wfrah6UGi2SW2iSntM7
	 W4b1TKzDE9KwxAPKyH5R2MJX7X0Wld53pA2aNCHcIdvnGPalSmD6jMIY8YiP/6+mf75yA
	 m9XZde6H0ka8++7CTsfMlpQtAorkx0jnbw38Y2SpyQTuqzRm4X58OB7C6F+YBew88Yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hM32VGHg;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF87606A992
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 11:50:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCF87606A992
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hM32VGHg
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4afe2d546f9so25969685e9.3
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 03:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794311408; x=1794916208; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Son7yw6NEgXS7N5jbgPLyq4DTY+5vMmlfhphK359Fds=;
        b=hM32VGHgI+Ki5c5TD8f3Tlb/sV2xVKLcMMO9XtYOZxSePRz8l5BFSLKzop/czrBzRS
         /ynY/w1yaqDqgLAFUR7jH+2snmzb+OVXWA4aWoCtOO9OT3xU02RVYK8UGpFWilAruOog
         YkbBPkbuG11C2jV4cIQZ3HBAmUlJEvyjwLgcBsXKBpoQhPI4pQygHzZdt4YJNW8Mq1Os
         UzNrqoYvMczcTQWJxF2uW03hqQKYOiwTUTlcsp14hATquDi7uvHg1HQijse+dOJK3XHJ
         iq0WcMzltt2x1o8FDEXWmQeu/OpiwpL0sNCM/HpZ+7jOlJ6YSbF9S59MCuwvjeEqdik3
         qCIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794311408; x=1794916208;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Son7yw6NEgXS7N5jbgPLyq4DTY+5vMmlfhphK359Fds=;
        b=NbvfNEf/Aq0mhuKb0Lbd88OAy6ggytZ0+j9uRyncJ3aC1L0LnaXZ3isjyii+NALgP0
         rZp9RwmJ/GFlaiV10lVfLfMgwV9tPYotWnuUEm/65EC5M19Y0w9ue4sj6zPCOUoo5ser
         PpW6LlYsU19nZcLB30Qi2iSZvtpHui9H2GgeUOQXNLpcRjYGA6TzSZnkK48bo5K51k9n
         Djm7d7j30NpWRauIRwgSEp+WEpz6/PvD0zoToT40RKNdAKPcoGsTTMF+SNhPOz12hsf+
         uvQaa1tcU8AeJ2I8Ag3xgYs1xJmdKpDBJoDh5spQHR/5h26greGKC8O19VboNwRIzjr/
         fvkg==
X-Gm-Message-State: APuU4Z9eX5j6nNjgiN1x2qE8gx84H0acnr/bA8+3JFdgvhDy9VGV2bTI
	u6f59fCclxKBJKX4o3IjwWupUV52VdBa4RI6gV+/mG5OGzp4w3yr/xQ3ipg6ww==
X-Gm-Gg: AYBFou2V7IqAnLu6uRN2Pb4Gww66B90/INbfN/rsf59WYUQRD0zb9eEvRs5doJxRWVq
	DS4xrvoIZyu1xXzhrg6UcCuO6ta065HYMohL0xnanIT/ETTgxRm6Oro+Zz6X9+NiEu06kX5/kxK
	UxyAyPaeXxU5MRFtDXarkkUjDvhF2TJ9dj8H756J7XmUENYO26yYgchV2UYMEC6i7GRRVkoRL3Y
	H1Lm7BEKyOW8uFq9YcV9hxkDubnS0ZWX4IYjxO8duUao2NJkkFP0w5sTrJeAZhDDADWSP48355Z
	aih4x1fMS7Kdfj1EBDghdxTEazg/zfDj49wxMDZYTcSHZBKRmKySIf9VOwnSgxhepfyRfGyW4AV
	Vl2qSo76R6r/QNVKPRtxg9u1VizsN8sKLlopEb2NT2iPb6PzDx3W1kIIYbb4MDuy93mzWXj/6hq
	B9wg1DKvorU8yBS/xHfHJBqBx7vdf6zspjgJ6JusE/YG7Oao7O5hZPswxEsG+TS/B4H9f/3vV/2
	eYBFcIw4Kra7PmH+E/Fqba1p4rjtoZOoJLLUJwaKEjo3QBPxl/UvCAjKXNoVdnmtrMfZXKYFNOU
	B/jqSN9avY2Ufu0u7PepK/VR7cUJZzjX6RUHWuvLNRDXkY0BpRzs2lYTt6ZkHJ0Wab29mSOEzEU
	6DOnMxozOh+jD
X-Received: by 2002:a05:600c:3486:b0:4a1:f68a:9736 with SMTP id 5b1f17b1804b1-4ba0234ede9mr37568385e9.26.1794311408094;
        Tue, 10 Nov 2026 03:50:08 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:1917:82b:d709:897d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba02005762sm60715995e9.2.2026.11.10.03.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 03:50:07 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 10 Nov 2026 12:49:50 +0100
Subject: [PATCH 05/20] t9300: make the series V tests self-contained
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
Message-Id: <20261110-kn-fast-import-tests-1-v1-5-dbd9ee502aae@gmail.com>
References: <20261110-kn-fast-import-tests-1-v1-0-dbd9ee502aae@gmail.com>
In-Reply-To: <20261110-kn-fast-import-tests-1-v1-0-dbd9ee502aae@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5633; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=DuIa99Zg1FCeK8nYJPpUZNFfECy8SniNQo20I2Z3KQo=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGrzBOWlUX2wz9GbJOy9szktPU7MNgw9s4OaY
 7RrS+9CRrZLeYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJq8wTlAAoJED7VnySO
 Rox/wD8MAJAg4iaRLJ8n5FVc5J6WYxIWjD/r7GwSliORCDtv/Us/UPVfiqQ2+7IDfwY9r5IfxNM
 tO5nY06Mx9JL8WXexUQHR4KiQ9eNjlxgmKJME5KUPMi+pgc4NqkKeSFoXTld4kDMXiF+0y7tNKg
 NNbsjvpKX818KTz1Q95FVXc4lm3wJaohj8m1w2o8IdFVn8DxP4w6uTuJpG9aomPa/N+fKewbTe4
 Y141hniRcganr+dck6E7z2Yg/d7FC+mwJS1EZ5LwtWqDRDEUAxuRy79/A0eK5UKhbQ8+HxA4nWR
 1zlZyyILoA1VqQGfpevdHo63JZyoRpx4HFCNsnuuPJNh4BrEsNE2OgsFD2utNR/7oyywyohE26x
 yFBk92s1kjTMexk6jmRYkHMJUYEaU8A/8XN7lCLZuQjgbNrzg59MIUkGywF0Ru8wTVXjLa7BgFx
 pVd4RPPzQIIxIz1N5YHF5Kk3DAybzImQBga+Kux0X+FQJqK/S/nyhw57sLREgILdeubz7Lq50g4
 V0=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Similar to the previous commits, modify the tests in 'series V' to make
them independent of state from previous tests.

Move the setup to a 'setup_checkpoint_repo()' function, so each test can
invoke it. The tests used to build on the 'U' branch from series U, so
let the function create a 'base' commit instead. For the same reason,
the tag test now tags 'base' and not 'V'.

'background_import_then_checkpoint()' registers a cleanup with
'test_when_finished', which is not allowed in a subshell, so call it
from the main shell.

The 'no new objects' test needs the 'V' commit in a pack, because
fast-import only detects duplicates against packs and not against loose
objects. It used to rely on the 'fastimport.unpackLimit' set by an
earlier test, so create the commit in the test with
'fastimport.unpackLimit' set to 0.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 t/t9300-fast-import.sh | 80 ++++++++++++++++++++++++++++++++++----------------
 1 file changed, 55 insertions(+), 25 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 14af91cffd..8124983409 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -3777,7 +3777,7 @@ background_import_then_checkpoint () {
 	rm V.output
 
 	(
-		git fast-import $options <&8 >&9 &
+		git -C repo fast-import $options <&8 >&9 &
 		echo $! >&9
 		wait $!
 		echo >&2 "background fast-import terminated too early with exit code $?"
@@ -3829,80 +3829,110 @@ background_import_still_running () {
 	fi
 }
 
+setup_checkpoint_repo () {
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	test_tick &&
+	git -C repo fast-import <<-INPUT_END
+	commit refs/heads/base
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	base commit
+	COMMIT
+	INPUT_END
+}
+
 test_expect_success PIPE 'V: checkpoint helper does not get stuck with extra output' '
-	cat >input <<-INPUT_END &&
+	setup_checkpoint_repo &&
+	cat >repo/input <<-INPUT_END &&
 	progress foo
 	progress bar
 
 	INPUT_END
 
-	background_import_then_checkpoint "" input &&
+	background_import_then_checkpoint "" repo/input &&
 	background_import_still_running
 '
 
 test_expect_success PIPE 'V: checkpoint updates refs after reset' '
-	cat >input <<-\INPUT_END &&
+	setup_checkpoint_repo &&
+	cat >repo/input <<-\INPUT_END &&
 	reset refs/heads/V
-	from refs/heads/U
+	from refs/heads/base
 
 	INPUT_END
 
-	background_import_then_checkpoint "" input &&
-	test "$(git rev-parse --verify V)" = "$(git rev-parse --verify U)" &&
+	background_import_then_checkpoint "" repo/input &&
+	test "$(git -C repo rev-parse --verify V)" = "$(git -C repo rev-parse --verify base)" &&
 	background_import_still_running
 '
 
 test_expect_success PIPE 'V: checkpoint updates refs and marks after commit' '
-	cat >input <<-INPUT_END &&
+	setup_checkpoint_repo &&
+	cat >repo/input <<-INPUT_END &&
 	commit refs/heads/V
 	mark :1
 	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 	data 0
-	from refs/heads/U
+	from refs/heads/base
 
 	INPUT_END
 
-	background_import_then_checkpoint "--export-marks=marks.actual" input &&
+	background_import_then_checkpoint "--export-marks=marks.actual" repo/input &&
+	(
+		cd repo &&
+		echo ":1 $(git rev-parse --verify V)" >marks.expected &&
 
-	echo ":1 $(git rev-parse --verify V)" >marks.expected &&
-
-	test "$(git rev-parse --verify V^)" = "$(git rev-parse --verify U)" &&
-	test_cmp marks.expected marks.actual &&
+		test "$(git rev-parse --verify V^)" = "$(git rev-parse --verify base)" &&
+		test_cmp marks.expected marks.actual
+	) &&
 	background_import_still_running
 '
 
 # Re-create the exact same commit, but on a different branch: no new object is
 # created in the database, but the refs and marks still need to be updated.
 test_expect_success PIPE 'V: checkpoint updates refs and marks after commit (no new objects)' '
-	cat >input <<-INPUT_END &&
+	setup_checkpoint_repo &&
+	git -C repo -c fastimport.unpackLimit=0 fast-import <<-INPUT_END &&
+	commit refs/heads/V
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data 0
+	from refs/heads/base
+
+	INPUT_END
+
+	cat >repo/input <<-INPUT_END &&
 	commit refs/heads/V2
 	mark :2
 	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 	data 0
-	from refs/heads/U
+	from refs/heads/base
 
 	INPUT_END
 
-	background_import_then_checkpoint "--export-marks=marks.actual" input &&
+	background_import_then_checkpoint "--export-marks=marks.actual" repo/input &&
+	(
+		cd repo &&
+		echo ":2 $(git rev-parse --verify V2)" >marks.expected &&
 
-	echo ":2 $(git rev-parse --verify V2)" >marks.expected &&
-
-	test "$(git rev-parse --verify V2)" = "$(git rev-parse --verify V)" &&
-	test_cmp marks.expected marks.actual &&
+		test "$(git rev-parse --verify V2)" = "$(git rev-parse --verify V)" &&
+		test_cmp marks.expected marks.actual
+	) &&
 	background_import_still_running
 '
 
 test_expect_success PIPE 'V: checkpoint updates tags after tag' '
-	cat >input <<-INPUT_END &&
+	setup_checkpoint_repo &&
+	cat >repo/input <<-INPUT_END &&
 	tag Vtag
-	from refs/heads/V
+	from refs/heads/base
 	tagger $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 	data 0
 
 	INPUT_END
 
-	background_import_then_checkpoint "" input &&
-	git show-ref -d Vtag &&
+	background_import_then_checkpoint "" repo/input &&
+	git -C repo show-ref -d Vtag &&
 	background_import_still_running
 '
 

-- 
2.56.GIT

