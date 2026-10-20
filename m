Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792491701;
	b=jdMJPILTq+oBV9nm8H1jtr2krZinQbdS0JHvffkilYNJ9Y5nuGHeSxh+XP7gZzuOCoXs
	 9ypW+LyUDWXXAZUPjaoDCedwYiRP3pXIW1f6J9DnKroNps+5/iBXq8m9tz6FpZgOjxGhr
	 XlseT5njZ7t4W3aZ1JkHyeby/rGoLyn86Jlm2SPnceOObRnnm7f/MsitAe2kUBjQL2Rz/
	 OeBTWGZNf7wgzg6sAWuRc/Z/58lv4acCoLclobWpJIG54G7ibiaeNty1lqovKBfTvOsUH
	 aemrtTi3wViyAGsa1MjlJ3LIVRUmfHsHjQz8OOYtkQklLL0Ii23HXdTj4EXhzPGFkKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792491701;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=/h0p6HpxjE8zLYlH/XHsZ3YB+Aa5LR5FSxEMDQl3BYM=;
	b=C2H3ojlt3xdxsTLutXyWMTB/8QqJmMDGKfn/atLtDRHF/iEnzx8naWwZpq6iq+IeCtT2
	 vIJjYaQpSdJA3VcPFYlFFDMSJSu3H4mhgP5rDibBQyuCbJQ8zBVVSM8fqWaul7101BPMp
	 ZaYmXGhbCs7bZK5i6FyGq8zdiYUe5Ig+Cn2V1tzKx/a5S0K9h3gM0OZEchvULiuxgeXgn
	 4aMW+fBl2Lg7LZjAT2pf4H1h7Dy5Efkfwapb00Y9aprh8VG1ZGkcdrEkn9oeXgeNez8K6
	 Cscc76erZNUs4Cq5/REXqleyCnpXnLztscAYrEX7W/G1njDJ4phVUer3wpJ7Ls7CJJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=C1nzAJvE;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C082606A31B
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 10:21:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C082606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=C1nzAJvE
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-35cd4e8bdbdso7338389eec.1
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 03:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792491700; x=1793096500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/h0p6HpxjE8zLYlH/XHsZ3YB+Aa5LR5FSxEMDQl3BYM=;
        b=C1nzAJvEU2Rx70gpicoekRnK0DvwDRWRIhX8FQSrnohivuAwUJprrY5TTvB6gftKdl
         XrxtO+NT9JvbPeh9tPSOJtQFGzfKjenr49X9hLoWCyf+tNqAsI7Ff++hIV5OA3ppuxEy
         /qluqo2vVTVwwURVXFv362tS3EVsAOaYg2s8PCT1Xqb887U4P7mpYcCiEaVg9Yv6kvLx
         ZGqYHViXlv4sV+V/nU8FMLABCTKdkQEPYWQjAxqrbiWzPLMZnaAugj79WPYfyy5SnsG+
         Uz8LxMJrV05iKa3xaF0fn1LBb8/jppQ6K4jrQCAonIpxboBwrUeymNCwVrnlM9MCPlCF
         WBLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792491700; x=1793096500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/h0p6HpxjE8zLYlH/XHsZ3YB+Aa5LR5FSxEMDQl3BYM=;
        b=lboILzhKI7RV4clqiAfR05YmUBr4vknJeeMENQKxUyedXplZUvd07alWz+z5/RbXGM
         3sdfmLU6KlpnRqliSp6nvAl2ey9a/cNO7z1vEZhuECWNjOPiGBAQ6xinyiMwIrPAJHQg
         QVrW20rbyC0K2dBOYOaYB/9AhZcczEci6jLbOxwG+Nq+0FPFTnXWTOU0IqokqPbO6z94
         OuZDJIFtwim7jAdQLHIkSRPexdad0hg+Ia59f77cR7yw4ZjaIdUHauHkIHr28lr5MvN/
         03E0NktOcSaGZHf3TLNn5dy7F3dHdhvQJ/j6wgMwO6ZBZ9V2ADqOWxPppXh0ujN7PUJm
         3JCw==
X-Gm-Message-State: AFq9FYLfXVywM/1G55R8Ge3/G/goR2my087Nc6K+/N5UV/0tOaJhAEeD
	ADV4kpVErExTneTb6xKXMSbMi6huoivOmhskId2MFT0k+Vg3PMBY4ZSGNhBe+IpUvdY=
X-Gm-Gg: AYBFou0U+uXfZEheutNvFD7p41kFqCR1iRybk+4vKn6JxZim9X1RA2o0v9Ll8OFqevY
	le0o9DuKGWPxGjl4zLUKFqhaITINgcFh1oomRRtB2UAKi3fuYvSB1+XBGRQCa8oswkBbEKiLYJx
	ktxzI9PWlkI/trZ+B1TgfbyuoMH20PT3cZQvXVMuXXTruJ2CzrO4SBZn2rZF2hViC5HvS3J0YD3
	p+913Ohjaruh06gYEozI0jfIl7ggGJy7yF4f04Ou2p7oK1WG4oUZK2AJH7jnm/DsMYhMOcwUeYX
	IXt6nLEe/bTwZ5Jt330Oh4wn895IZljW4TkjhF1jLwET8lqzpDwEv064hIV58XDN1AINP0gCDMT
	wPVLsMIrA+eHW2zJtOE287fwq8qChM3GLBj7NCDbNBlhhmQdr/dIk3dxUHY1ElqJh3YVt22RY9z
	8+pDyVw+uljPuNpL1Tims7n2xRPelmuH9X9KicYPlqnmw9fss7xAecB86WD460JatCg7g6jrceV
	TTLXKV50ocIZA5bftp1iSsvsE096wqJx5FmW1adtFQ=
X-Received: by 2002:a05:701b:4212:20b0:143:3c9f:10a6 with SMTP id a92af1059eb24-1850c40d561mr15936715c88.4.1792491700270;
        Tue, 20 Oct 2026 03:21:40 -0700 (PDT)
Received: from LAPTOP-PVRSMPQK ([223.190.84.93])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831c2e7bf4sm31773149c88.20.2026.10.20.03.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 03:21:39 -0700 (PDT)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Aniket Gupta <aniketgupta3001@gmail.com>
Subject: [GSoC PATCH] fsck: report the real object count in the connectivity message
Date: Tue, 20 Oct 2026 10:21:34 +0000
Message-ID: <20261020102134.42151-1-aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.56.0.116.g6de20f609.dirty
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

The verbose "Checking connectivity" message prints the value of
get_max_object_index(), which is number of buckets in the object hash
and not the number of objects in it. The hash is larger than what it
holds so a repository with 21 objects says 64 objects.

Add get_object_count() to return the number of objects in the hash and
use it for the message. The loop below will still walk every bucket and
it keeps using get_max_object_index().

Signed-off-by: Aniket Gupta <aniketgupta3001@gmail.com>
---
This goes on top of "fsck: use Q_() for the verbose connectivity
message" which Junio had queued. He mentioned that the number was not
the real count and this is the separate fix for that.

index-pack also uses get_max_object_index() as the total for its
"Checking objects" progress. That is unchanged since it walks the same
buckets.

 builtin/fsck.c  | 13 ++++++++-----
 object.c        |  5 +++++
 object.h        |  7 +++++++
 t/t1450-fsck.sh | 15 +++++++++++++++
 4 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 710780e35..da51b2a91 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -378,11 +378,14 @@ static void check_connectivity(struct repository *repo)
 
 	/* Look up all the requirements, warn about missing objects.. */
 	max = get_max_object_index(repo);
-	if (verbose)
-		fprintf_ln(stderr, Q_("Checking connectivity (%d object)",
-				      "Checking connectivity (%d objects)",
-				      max),
-			   max);
+	if (verbose) {
+		unsigned int nr = get_object_count(repo);
+
+		fprintf_ln(stderr, Q_("Checking connectivity (%u object)",
+				      "Checking connectivity (%u objects)",
+				      nr),
+			   nr);
+	}
 
 	for (i = 0; i < max; i++) {
 		struct object *obj = get_indexed_object(repo, i);
diff --git a/object.c b/object.c
index 97f7fc0e8..2fdba93d4 100644
--- a/object.c
+++ b/object.c
@@ -20,6 +20,11 @@ unsigned int get_max_object_index(const struct repository *repo)
 	return repo->parsed_objects->obj_hash_size;
 }
 
+unsigned int get_object_count(const struct repository *repo)
+{
+	return repo->parsed_objects->nr_objs;
+}
+
 struct object *get_indexed_object(const struct repository *repo,
 				       unsigned int idx)
 {
diff --git a/object.h b/object.h
index 46cade33f..20ea6f5c0 100644
--- a/object.h
+++ b/object.h
@@ -173,6 +173,13 @@ int type_from_string_gently(const char *str, ssize_t, int gentle);
  */
 unsigned int get_max_object_index(const struct repository *repo);
 
+/*
+ * Return the number of objects currently in the object hashmap. This
+ * is smaller than the value get_max_object_index() returns, as that
+ * counts the buckets, which are not all in use.
+ */
+unsigned int get_object_count(const struct repository *repo);
+
 /*
  * Return the object from the specified bucket in the object hashmap.
  */
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 1b4074304..ceb7c649c 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -1152,4 +1152,19 @@ test_expect_success 'fsck reports problems in current worktree index without fil
 	test_cmp expect actual
 '
 
+test_expect_success 'fsck --verbose reports the number of objects' '
+	git init count &&
+	test_commit -C count one &&
+	git -C count fsck --verbose 2>err &&
+	test_grep "Checking connectivity (3 objects)" err
+'
+
+test_expect_success 'fsck --verbose uses the singular for a single object' '
+	git init single &&
+	blob=$(echo single | git -C single hash-object -w --stdin) &&
+	git -C single update-ref refs/tags/blob $blob &&
+	git -C single fsck --verbose 2>err &&
+	test_grep "Checking connectivity (1 object)" err
+'
+
 test_done
-- 
2.43.0

