Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792486515;
	b=fIoqQfMtutFnUWuEo0vBxW+VbSBM3WSARltOmavgN8GmqrCCey9pjiAad7Bc+qJVO4nl
	 1w0pEUbhuMZOVkyaTanvSOfPDqy3pmyqiBY8/rsJgRSs/gnrdGXnirDhbPUOVn9zQ4woQ
	 JspRACOwFTPLrLYrlB8bFJ2iLO1jHUXgBLjBDFt99tn1RqzWjl747d+XF7ZyTHNTYgJJa
	 dvkIWPmki8VLRb4OvuMafg5nrVqzL888AJGnSFG/dUtKAFbHtfKRjW36lfPLFUGUlIkNh
	 uLQBpjH/fES7smdWt7K2cpVUYB74+kXqazMz+4cO+uPZx03uphTiuDogNAPwhvxCk0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792486515;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=O4KME3FMBnh3aFkUT/tkMdJZY6JHGCQthYQeyd/Gc70=;
	b=ZWZw2QKUPI6jULKqwUpV0jMYNkkQimZf2MRPRsx3dDIP827kQcmnNatdsyeUgKFXUX1g
	 khZ4Bb5tl+xZtTvBk/gTZ8rlUjynA9fj3vZm+Y+pDUfieYzso88ZlmgRx0mOgMTsSmUTh
	 P7kfVEnvEeMBf5mIDJ3YyjwSXlCVr5fAG61Y081E5beKA4ZiqXfHJltdTRRxV+mdWjFbc
	 YXh2kG46WLWej+gSoNg3BTDB9JbrOv7yYTSTGtYa6j3AjWkD1xmGVYvrIX4SBjF2LqTFJ
	 tKuTCO4044O2IFTzGDoe3MLsKnZQ4RYjIgSf9cWS9PP34QG7dDkZyDGLBKddYh9amlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b="O2/3kZSF";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=NaCAv+Sz;
	arc=none smtp.remote-ip=103.168.172.152
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67CC606A319
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 08:55:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A67CC606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=O2/3kZSF;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=NaCAv+Sz
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E8FA914000F1
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 04:55:13 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 20 Oct 2026 04:55:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792486513;
	 x=1792572913; bh=O4KME3FMBnh3aFkUT/tkMdJZY6JHGCQthYQeyd/Gc70=; b=
	O2/3kZSFsoZl+K4e/7ycIoyBtFpsRTE61nFg3rLCCG9gcfhKK6esf+enjqK31sa5
	dCb8khhhLJNRCxCN4WVxHdNmH774yCG1YUpgku+Gemv7imfEGFKXUti9ZfDa5qqA
	egkfdZlZaRIfEJXEO7Me0ltPPUKCBkF10ZPc/we3t5T1OXyFbjktYEi8x2aX/Ag9
	/M6jb8Cv4gGnQXBlDheP7HUSfc6VhNFWTwFxIrG129BiaIfnHUSBP0CX4GcceBde
	yzoX22PKgPeIE1VeJGt59+Uo/iFFha4PvfHkxeTKFxYAivBXZEc6oprZJNjZYYxd
	DzSt5VQslf9C/8FCy0QDbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792486513; x=
	1792572913; bh=O4KME3FMBnh3aFkUT/tkMdJZY6JHGCQthYQeyd/Gc70=; b=N
	aCAv+Sz8ukwVPqX2QFAmrR/th6V/435a/jZuFxfCfc1BVMfb09U8e3lNy0+zA1Cv
	50Scrbuy5WS+p9bAY4Vpt6NITG91XpuS6ejVAAE4aPWrnTLj8BawYfnOmKNlc55o
	Ecc821t9eFbspnGNulmH8Y4WC++VrBx1KQu79Rk1ItgGlB6PdIOTB9SmmHnqWt7M
	D952RWkM07W9xzvRclDWkae0F0ACrni1/sOuQYNL+wbKJT51mQsF4pj+flZCQEXS
	AnrVLm8pNrNIWggqddq4F+SjOPstLd7SWlcbGPZO5ndNewnUF/4Chr65pRrSmpEG
	pICigsPkWwN2snAC679sA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792486513; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:L2tzmNPcnTFeUCke/BPI4IqZbRo41qH+Yq83FeD1ePZ00kb
	T68DNzshg2UZKAG+w6fmqTU4XKN574ilUJI7Zt3RCdYXzBq24k/sLQJBaXTt/qSS
	Su92vsy2qtZTzNPw2/yEKks/VkwEoZMp5XSLWuuuHzb2y5CCZCWfyhyAufgUO5MW
	vue5XQilao7Onc+XZfmE+ay/9vTLDSWUUONuS5jhZvwNUpMc6+jCxU0LPJS6MW/m
	hYHLCeH12/dT/2wRcHog9nG9Gc9svtyQevej8x64DjfVlDP6BvN0sayiVCI7hkAN
	mRg0CBnU2HsZa+AdLAVd3rY6E6LOT2yYvc36rmQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:EEgUvcCAhMBqL8Eclj36YXmFUAjCr7e52bIyzG5k9No=:j3AKCabNHkE/wmLfZneHNhwLrk6m0wKzCcD2YY0U1pc=;
X-ME-Sender: <xms:cSzXajR7tYDyHaYpxjQJFi3OFmjLL5x-Tv95T-Y9w-9Kx3PSHxS_hQ>
    <xme:cSzXartBhixt6H3OAE-VmrOxaput4APwaaoK3ubirwzLMGb2jIJKODPeQH55yd2sb
    iB-7Mhj569bmLRmzEcgdhTwVJtjOA-49-gcs2W6VuRQnXRDQ34yLxQ>
X-ME-Received: <xmr:cSzXaudpvtIEc6Z4EXBjkpAkqZXn2cI4Rwpd3tGa2X6YkYeTQZm9kpVBxZusMLZF4xfOfw>
X-ME-Proxy-Cause: dmFkZTEoAWeqDIdvYdPW/Ob8fmRFqyctnra01MHUoyqpTTc3YM6RK0bgGT0aLpHQOBFJrJ
    Tn5iwWOejFFuLFmPVHmfpDLtNwcT9JpDPi/WCslDHr1oaC6mbddPYTeNqt2kXpTFK02KV/
    S0P5ZWt+yHpKFiIO9BJHA59oyZgaQB++ivLAtWp6tlZO2wl8kmyo0tc8R/+V3RsuYRq8R2
    dxOkyl629wudA0cVkTJybOtT3+dum8FAStWXGOw1o5kt3GUWyDIFim8B0Y6qGBa3WwCGbw
    WJnYalhC9hYQVtx6pjwtG5TrBC9FoFulniB4opNu7O95zROweyGUPIjPOrF9Ic//PqJLGw
    Vr5NaWPf52WLzLsYLiOrFwyLypgnwKtAo3HH7BmQMZgzSE3Czq6cur53DrnKhegiJPoz66
    +DgICMk/79JX65tnIObeDpFYarNZY/mxrlH/gw40jdj06T8aT8vTmuIFwtIZjVeBe2ix0T
    CD8u6xLC4DxFUxjOIcSE6o/H1n9LnTCm2T5G9gpNwqzjXokhqnG7pE0rMKPId/Gvvd+bC9
    cSIUbbgXrd5BH3SBwEaXL577Tc2UKvsIr8TQ3YXEr8c+QPKy2BtxhZ3QvOBwr3mBQx1Kvp
    2uZKls+I433LQFPwaJChQe/FIj2z7yLNoZruzqEbFJPouTuVOmT6o8V60fmA
X-ME-Proxy: <xmx:cSzXaoIioikoIq-IFmxuOVut95jmeWHtc3WSDd-sts7cQNWRyDBVww>
    <xmx:cSzXasZyBpIHHdbA5fz6noVWESB-wAaDO9bQz0Ot0oxbUaOCmJn6Lw>
    <xmx:cSzXajuvDzzqoUsH-bcL_9sta7G2QESbbOb6j1izYGffl8bK1X6F-Q>
    <xmx:cSzXapunf20o8vUaFHSWbLIFllM3Qi9rkq6uUjcmx-TPthfemRI31w>
    <xmx:cSzXanQWTJvIXmSS7cfrh0ysclFC4C4xLDbeiyKk2NLO658r43BSR_tj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 20 Oct 2026 04:55:13 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f170ef20 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 20 Oct 2026 08:55:12 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 20 Oct 2026 10:54:53 +0200
Subject: [PATCH 2/4] odb/source-files: reload alternates on retry
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261020-pks-odb-files-reload-alternates-v1-2-d9e156323836@pks.im>
References: <20261020-pks-odb-files-reload-alternates-v1-0-d9e156323836@pks.im>
In-Reply-To: <20261020-pks-odb-files-reload-alternates-v1-0-d9e156323836@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

When an object ID cannot be found we retry reading it from our packfiles
after we have flushed the respective caches of the packed backends. But
this misses one scenario: it may happen that the object databases'
alternates get rewritten concurrently and all of its objects are moved
to such an alternate. If so, we won't be able to find any of the objects
anymore. This used to be working just fine, but with 5946a564cd
(odb/source: make `read_object_info()` function pluggable, 2026-03-05)
we have accidentally dropped this logic.

This scenario sounds somewhat unlikely, but we've actually been hitting
it in the wild: when running long-lived git-cat-file(1) processes that
we interactively query over many minutes, and that repository gets
forked concurrently, then we move all objects into an object pool, write
a new alternates file, and the git-cat-file(1) process will remain
broken for the rest of its lifetime.

Fix this bug by re-preparing alternates when the object in question
could not be found and then retrying the read. Note that this also
requires us to re-read loose objects, which is an operation that we
previously skipped on the retry. But we only need to do this for the
loose object directories that are actually new.

Note that the result is still incomplete though, as we only reload the
alternates of the local object directory. But alternates are added
recursively, so in theory we'd also have to check whether alternates of
any of the alternates have changed. But we never did that before the
regression, either, so for now we don't care about this edge case.

Furthermore, this change causes a performance regression when asking for
lots of missing objects. But that regression is basically in line with
the performance we had before this mechanism got broken. The following
benchmark demonstrates this when asking for 20k missing commits in an
empty repository with a single empty alternate:

  Benchmark 1: git cat-file --batch-check (rev = 5946a564cd~)
    Time (mean ± σ):     282.8 ms ±   2.9 ms    [User: 99.8 ms, System: 178.6 ms]
    Range (min … max):   279.7 ms … 288.3 ms    10 runs

  Benchmark 2: git cat-file --batch-check (rev = 5946a564cd)
    Time (mean ± σ):     180.0 ms ±   1.7 ms    [User: 55.9 ms, System: 120.3 ms]
    Range (min … max):   178.2 ms … 183.9 ms    16 runs

  Benchmark 3: git cat-file --batch-check (rev = HEAD~)
    Time (mean ± σ):     187.7 ms ±   3.7 ms    [User: 59.7 ms, System: 124.3 ms]
    Range (min … max):   182.2 ms … 193.7 ms    15 runs

  Benchmark 4: git cat-file --batch-check (rev = HEAD)
    Time (mean ± σ):     309.8 ms ±   5.3 ms    [User: 105.9 ms, System: 199.1 ms]
    Range (min … max):   302.5 ms … 316.0 ms    10 runs

  Summary
    git cat-file --batch-check (rev = 5946a564cd) ran
      1.04 ± 0.02 times faster than git cat-file --batch-check (rev = HEAD~)
      1.57 ± 0.02 times faster than git cat-file --batch-check (rev = 5946a564cd~)
      1.72 ± 0.03 times faster than git cat-file --batch-check (rev = HEAD)

There's no helping this though, with the regression fixed we will be
slower compared to before as we have to do more work. But the next
commits will improve the status quo a bit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-files.c  | 12 ++++++++----
 t/t1006-cat-file.sh | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/odb/source-files.c b/odb/source-files.c
index d31da6e5d9..86f3fd1136 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -425,6 +425,7 @@ static enum odb_read_status odb_source_files_read_object_info(struct odb_source
 							      struct strbuf *errmsg)
 {
 	struct odb_source_files *files = odb_source_files_downcast(source);
+	struct odb_files_dir **tail = NULL;
 	enum odb_read_status status = ODB_READ_NOT_FOUND;
 	enum odb_read_status ret;
 	bool retry = false;
@@ -448,10 +449,11 @@ static enum odb_read_status odb_source_files_read_object_info(struct odb_source
 			status = ret;
 	}
 
-	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next) {
-		if (retry)
-			break;
-
+	/*
+	 * When we have reprepared alternates then we only re-scan directories
+	 * that were newly added.
+	 */
+	for (struct odb_files_dir *dir = tail ? *tail : files->dirs; dir; dir = dir->next) {
 		ret = odb_source_read_object_info(&dir->loose->base, oid, oi, flags,
 						  status == ODB_READ_NOT_FOUND ? errmsg : NULL);
 		if (!ret)
@@ -461,6 +463,8 @@ static enum odb_read_status odb_source_files_read_object_info(struct odb_source
 	}
 
 	if (!retry && !(flags & OBJECT_INFO_QUICK)) {
+		tail = files->dirs_tail;
+		prepare_alternates(files, NULL);
 		retry = true;
 		goto retry;
 	}
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 72fc8acc61..f2b24dd278 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -1481,4 +1481,36 @@ test_objects_filter "object:type=commit"
 test_objects_filter "object:type=tag"
 test_objects_filter "object:type=tree"
 
+test_expect_success PIPE 'concurrently written alternates are loaded' '
+	test_when_finished "rm -rf repo alternate stdin stdout" &&
+	git init repo &&
+	git init alternate &&
+	oid=$(git -C alternate hash-object -w --stdin </dev/null) &&
+	mkfifo stdin &&
+	mkfifo stdout &&
+	{ git -C repo cat-file --batch-check <stdin >stdout & } &&
+	(
+		exec 8>stdin &&
+		exec 9<stdout &&
+
+		# Read the object the first time, without having alternates
+		# wired up yet. The object should be reported as missing.
+		echo "$oid" >&8 &&
+		read line <&9 &&
+		echo "$line" >actual &&
+		echo "$oid missing" >expect &&
+		test_cmp expect actual &&
+
+		# Read the object the second time, this time with the alternate
+		# set up. The backend should reload alternates and thus find
+		# the object.
+		echo "$PWD/alternate/.git/objects" >repo/.git/objects/info/alternates &&
+		echo "$oid" >&8 &&
+		read line <&9 &&
+		echo "$line" >actual &&
+		echo "$oid blob 0" >expect &&
+		test_cmp expect actual
+	)
+'
+
 test_done

-- 
2.56.0.269.g68944adf51.dirty

