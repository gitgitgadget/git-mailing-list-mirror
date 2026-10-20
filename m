Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792486517;
	b=g4TYAg3ju3Lo87plpTAUs8Gp+p6G6v4Vy/tPdWV1cfB9Ez1te28PdMNPxh7BuNtM/d1m
	 WbAzbFlRnXPKf/dJxvmDGW2i/yVRran6y1XGW1hw6pT+Bi3qEFuNRlAAQk6DlcXS9+J47
	 msBaSx9yAVvlf0StN3SvK/dtQRQ2lV2QZCXb732yULfnpz4YzpIgGLaUR+bo+X6Bx0CE3
	 kbQsmgyY5AaM60GPl+DjX7oI6i0svm5Q59PoOSlXqT/E4F4jaeEx4t6RlEu3eejh52LMm
	 ZmC8PFmq1Juo051p+2DK3DQ+N8lSYcXNfuhWHA5Xap1tK7lUJ0xokrO+/Fm5G8g5WBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792486517;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=Lu6vfAZl07YP+SKVtVTN0KfO6RETZJueCR0W61pwVcw=;
	b=wX8mDFW8FtzT+IW1DgT/QeTp5jArm0QqwMCmKGR+HtwNuh4pECyNqJMnKn1oOHmwVskm
	 ORUWgCyLo0hiYB/cYRps0rvFYO6/t7hmv/KpIvLMU7FL2aRA7vdn+dgqqTrLFEtzDCfP5
	 LAH9jm3v90IU8VQXFd55GaMQ6QV8FdBivX0uAsIedEBbGcU8ruY41hKzkUnbQ/+PCvVMV
	 V6sUhOW2NZgprFUCdQcK0RB6HCxcpbJtYJXYuyqUkUpowXTodDI68D5IQ2aQzIfTYGdd9
	 J2PYfTNw5Q+kPKEbzsGJovEZcjUkrfDXinfLsg+svZT3xAlPZNfFCye+FQJ+6aDhEDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=cAzatBpO;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=YMgnuux9;
	arc=none smtp.remote-ip=103.168.172.152
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B80606A31B
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 08:55:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48B80606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=cAzatBpO;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=YMgnuux9
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8F31E14000B6
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 04:55:16 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 20 Oct 2026 04:55:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792486516;
	 x=1792572916; bh=Lu6vfAZl07YP+SKVtVTN0KfO6RETZJueCR0W61pwVcw=; b=
	cAzatBpOT/SDfDCNRj7n5zkMbV7Dc0uIEPNHblp6MkRwhYp2hXXE4eCBoKN2HBIa
	8EVvy6rWBuQJHNDWdUzgdKd0OeoDpu6FXlliXAjmQVErY1ak+rEvxewiiyPMksSi
	PurE6mvXjjRahmzoblbmQG5gH3GdlcgQFXRlxptbOrVs/CXGIAUrlRX4LUEh/X3q
	Jkx7OdJVualR/aKvHrCCHZxhb1C/a3Blcmgn2ZLOQUGtikwlzBcx6n5jF6BEY2dM
	If4+1nQhz2QcZoGW+yAFovOgi328i1H71LjE3jEdWlu/8wTgWzUSPDlpwWe9Lg/p
	zADNWKldMxJ/7TJHYFo6zQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792486516; x=
	1792572916; bh=Lu6vfAZl07YP+SKVtVTN0KfO6RETZJueCR0W61pwVcw=; b=Y
	Mgnuux9KyzCFrbKK3ZwVKAkm9Dn7wA4zPpaDhjVIht0rLIhPIX8PCPlepiEtEjNn
	4rzmfZhGBNi3J5WZKNf4xGp6l0QjSZfDvKsrh9XKAHeiZsc+ZMabBqfyygkuq5Md
	gkfXntiZ9FChgRUKFAWM9sGYp2ja9bRcYK7fTgwdadf1quG8WGr8Qq6AQMsAUjbk
	NvbBbckDU+XHUIHrGfl4EkpuLYdTaHtlMfLyJAUUvvN3Nuz0Sghg1d5d0IZm0W3T
	X0csEHH2NYXvfPP3MftNSHNGsXU43jsecQiS5qQPDEJ+MB9It99ms9ZBRQ7lmHY8
	tA94K6AEt9Ng3KjThbu2w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792486516; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:ooX4rXmst9qViUIGlUPv4DGhJMKvxJj+YXB1tXEisNw4EQi
	iMGvkBHBDydFJqn3Tat2CXFMbxW4DaGE/AUqumJf7qlZ0b3zOLgFxqhTnCWN5Xcd
	GyIC0EpO8jNztZXjrNe3z2kAmTiyc2S1aiFGd5lLZxFkywF0asWFkAyNxuJ7Vk99
	z675MQK5xCP7EypkLcVIAK+P0/aN7aPUldFWpzFgPCaVULXE9UUno9Zk0uYwR07v
	25lEHIYpJkkb6Qa+AQaDNLDJ0HTfjv982Zx2di0j9fZYFSZSHu9EY2o8kSAix/z4
	i1r3awaoeM/QVND8MqV9mor3hX+VKF3tSD+aHtA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:YOYdWHhfwM72Sk1ZrBbwqaHyaJwpgAlffTjie0hd1Ds=:L/hZ6YM8jLE1mnPPfbOKG/S4/nGF/7Jxrmxcxi0LDkM=;
X-ME-Sender: <xms:dCzXalRR0PgMHXP9F64EsTYH1KmstvstATbMnCWAYz7JkufmpT9hWg>
    <xme:dCzXalst1JFs55kUYorrTbi0n322mLUBPyg1OId1fEv5hpgrb93gg4yfirUUyndXw
    50PXinLFDQjDYJG9V9izJsnSc6j_TiVw45Cix5iddfXhE8ktpD5YGo>
X-ME-Received: <xmr:dCzXagd9He5GuBJBarOhURoHqxyZLri4-8tDLw7l-iD_CvXo0CRT4UY_DzDOH_AlXZpsLA>
X-ME-Proxy-Cause: dmFkZTEoAWeqDIdvYdPW/Ob8fmRFqyctnra01MHUoyqpTTc3YM6RK0bgGT0aLpHQOBFJrJ
    Tn5iwWOejFFuLFmPVHmfpDLtNwcT9JpDPi/WCslDHr1oaC6mbddPYTeNqt2kXpTFK02KV/
    S0P5ZWt+yHpKFiIO9BJHA59oyZgaQB++ivLAtWp6tlZO2wl8kmyo0tc8R/+V3RsuYRq8R2
    dxOkyl629wudA0cVkTJybOtT3+dum8FAStWXGOw1o5kt3GUWyDIFim8B0Y6qGBa3WwCGbw
    WJnYalhC9hYQVtx6pjwtG5TrBC9FoFulniB4opNu7O95zROweyGUPIjPOrF9Ic//PqJLAV
    /PBQWxdhbJ/7tpXbM4ehCDvVNJE11bwiM926KxAAvIjjmRwPv279r6Ze3oTTZIHhMvuIwD
    j8s3Cw0G9mgVjnUnyyEr+MT/jMAAZUuKHYJpUhFlQ02+1mOAXkFD/NCgwDrGz8WdJEZ5b3
    EZtL9s1qytS1yJYHgsl4pMSMIFAN6I8wHbebjPrw9yZlVgfRq5sMoRHYoBVlpMqWlT1yES
    IB5KSQEs6xRmsmOu8m/qWVXbGRLjO7Jvqjg1ftoKVp2T09x/f3yhZU3kE7DRmqbWQkg+xD
    2o7bZw68XQ7FDq9DOq7RYS72IZnsUB3W5LaIUDnWjUm/IHwkr4FBUxn/ZJLA
X-ME-Proxy: <xmx:dCzXaiIHzJ13y34Fz3eRXnvWN8JDtF2eTA4UDrzcHrXh80Orjnq8Tg>
    <xmx:dCzXauaKxC6RZy3jAd5KCvUU4qdqf5ediLSikUp7B1PTkSINt1vC0g>
    <xmx:dCzXatu0LMDsVkIBOMGfnOcbM0-OcmPvdTWUJDPrzGdQROEddefT9A>
    <xmx:dCzXarvMaLDjPZbFUvTXZq_kOowLa8vf33l2AW8E_Fg7sRpWlQP9TA>
    <xmx:dCzXahRjOAZAFvzGXESabBtTtm_NjuceqSVEs_yVF-XmSVpIIhdyelEr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 20 Oct 2026 04:55:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 904950fa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 20 Oct 2026 08:55:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 20 Oct 2026 10:54:54 +0200
Subject: [PATCH 3/4] odb/source-files: avoid rechecking already-known
 alternates
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
Message-Id: <20261020-pks-odb-files-reload-alternates-v1-3-d9e156323836@pks.im>
References: <20261020-pks-odb-files-reload-alternates-v1-0-d9e156323836@pks.im>
In-Reply-To: <20261020-pks-odb-files-reload-alternates-v1-0-d9e156323836@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

When adding alternates we first check whether the alternate is usable
via `odb_files_dir_is_usable()`. This function performs three checks:

  - It verifies that the alternate is not the same as the primary object
    directory.

  - It verifies that the alternate exists on disk.

  - It verifies that the alternate isn't already known to us by looking
    it up in `dirs_by_path`.

The first two checks hit the filesystem, whereas the last one is a mere
hashmap lookup. But the way the code is currently arranged we perform
the hashmap lookup last, which may cause us to do a couple of syscalls
only to then notice that we already know the alternate anyway, which is
of course quite inefficient.

Furthermore, the first check has gotten more expensive over time. While
we traditionally stored the relative path to the primary object
directory, we nowadays store an absolute path. This change is overall a
sensible one as it brings it in line with alternate object directories,
for which we always used to store absolute paths. But it also results in
more calls to lstat(3p) when calling `strbuf_realpath()` to resolve the
path of the primary object directory, as that syscall is made once per
path component.

Reorder the logic so that we perform the hash lookup first for an easy
win. Using the same benchmark as in the preceding commit:

  Benchmark 1: ./git -C /tmp/repo cat-file --batch-check (rev = 5946a564cd~)
    Time (mean ± σ):     282.5 ms ±   2.9 ms    [User: 100.0 ms, System: 178.4 ms]
    Range (min … max):   279.8 ms … 289.1 ms    10 runs

  Benchmark 2: ./git -C /tmp/repo cat-file --batch-check (rev = 5946a564cd)
    Time (mean ± σ):     181.1 ms ±   1.7 ms    [User: 53.9 ms, System: 123.4 ms]
    Range (min … max):   178.2 ms … 183.6 ms    16 runs

  Benchmark 3: ./git -C /tmp/repo cat-file --batch-check (rev = HEAD~)
    Time (mean ± σ):     309.7 ms ±   2.7 ms    [User: 108.0 ms, System: 197.4 ms]
    Range (min … max):   305.4 ms … 315.1 ms    10 runs

  Benchmark 4: ./git -C /tmp/repo cat-file --batch-check (rev = HEAD)
    Time (mean ± σ):     263.4 ms ±   3.6 ms    [User: 92.2 ms, System: 167.1 ms]
    Range (min … max):   254.8 ms … 268.2 ms    11 runs

  Summary
    ./git -C /tmp/repo cat-file --batch-check (rev = 5946a564cd) ran
      1.45 ± 0.02 times faster than ./git -C /tmp/repo cat-file --batch-check (rev = HEAD)
      1.56 ± 0.02 times faster than ./git -C /tmp/repo cat-file --batch-check (rev = 5946a564cd~)
      1.71 ± 0.02 times faster than ./git -C /tmp/repo cat-file --batch-check (rev = HEAD~)

So we're faster than the original, non-broken state now, but still
significantly slower compared to the regressed commit where we didn't
reload alternates at all.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-files.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/odb/source-files.c b/odb/source-files.c
index 86f3fd1136..917f5e9d25 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -228,16 +228,6 @@ static bool odb_files_dir_is_usable(struct odb_source_files *files,
 	struct hashmap_entry key;
 	bool usable = false;
 
-	strbuf_realpath(&normalized_objdir, files->dirs->abspath, 1);
-
-	/* Detect cases where alternate disappeared */
-	if (!is_directory(path)) {
-		error(_("object directory %s does not exist; "
-			"check .git/objects/info/alternates"),
-		      path);
-		goto out;
-	}
-
 	/*
 	 * Prevent the common mistake of listing the same
 	 * thing twice, or object directory itself.
@@ -249,12 +239,21 @@ static bool odb_files_dir_is_usable(struct odb_source_files *files,
 		hashmap_add(&files->dirs_by_path, &files->dirs->by_path_entry);
 	}
 
+	hashmap_entry_init(&key, strihash(path));
+	if (hashmap_get(&files->dirs_by_path, &key, path))
+		goto out;
+
+	strbuf_realpath(&normalized_objdir, files->dirs->abspath, 1);
 	if (!odb_files_dir_paths_cmp(files, path, normalized_objdir.buf))
 		goto out;
 
-	hashmap_entry_init(&key, strihash(path));
-	if (hashmap_get(&files->dirs_by_path, &key, path))
+	/* Detect cases where alternate disappeared */
+	if (!is_directory(path)) {
+		error(_("object directory %s does not exist; "
+			"check .git/objects/info/alternates"),
+		      path);
 		goto out;
+	}
 
 	usable = true;
 

-- 
2.56.0.269.g68944adf51.dirty

