Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793445029;
	b=WtsG/hd6d2kG6lZtY/cWDDUnqxEq+OfGyeFB2NS50zohmpAqjCRfqjPb6pvpHXGnNqiF
	 qfmnuvUuLBHqNCy1nnntPoZYn0XokaHaOs91cxoqwNqQEjjXHy6EuvCx19bq/yjeyc2iu
	 XZQTjlILZsuruu7oOwyKeyqOBOxaaLyArzhev9/KQ7cdgfVjV+x5yF4NJzppMH0nJ5oBs
	 btapoJRNeb447I7BUliTaYoOb1+Eal2yM4lPwI/GcQ7vPbjkQDmZIucMnC24RVxLTOnAO
	 EP5kXyU3Ix004t2HH/lEsWPeUWNWkpmBry3MKhUFH8FlxYw7a4UrZCr4nf5F3/+N9yQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793445029;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UTgxOaC7uVVCdVz94UpR7b7OKsBoxftChcK4BvtcoPM=;
	b=yTB8jUpstPb5jhOyLIa6NlD5g0vrE7RGj7T2csZXv7dLfw8esK2XtYBDzb5MRAC2t7rX
	 UuNZmNb9foHJfDrIgsBshtbhCjXa591mRTTl9hCenVVDVVEULipSmN56OgrjuDuKs/ru1
	 BKTB15tD7T5OxA69Xs2ZELVOSmS9x+bBVu948pFSBP8ECEyEo21EVQZKyj0IXa5zDebHR
	 ztdavV+sZct0+prK3p9u94L0XVA69PKJuDXsSPxma8Xht32ee8kosOw8ubWaoDA+7KNaM
	 wmYE4cSx2PjW+D5gcF3G5W/OjbaGvNXeYtpbmVtJ6c9fWFasbbXuVh6tckPBXbonhUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SLSkZw+B;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDDD606A31A
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 11:10:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCDDD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SLSkZw+B
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48b060ec084so838773f8f.0
        for <git@vger.kernel.org>; Sat, 31 Oct 2026 04:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793445027; x=1794049827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UTgxOaC7uVVCdVz94UpR7b7OKsBoxftChcK4BvtcoPM=;
        b=SLSkZw+Bm1UgIqJLV6GyBAugh7VqeseWz91H9Hk8yHg+P9zmgSZIILYmNhBPseV5ur
         kHkU5DHGYjO22OHMOyOmVULD9IeZ/AKkCZ1nykx2Sk1yAiFjDsrA2W+CnC5zvzZh6pbD
         AovewwVGOy6nHgaN2O6NS68Uh9I+zTPp+DoSBsN8jyPlJFGvGH7NmZ/B0ZGvZRIJ0/bN
         hmP1NjmJMkuEuL3Sabqazbbuo8HtJX92ehJkEOiSXEmN287KxRIduqygq2r1DHwSxzuE
         QCVP9ViSJNwjVjLebw3NU+0XLkNrnNDb8rhnFSKznXBvsHRewW7xCcSLGFX4ht3gXj92
         ITEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793445027; x=1794049827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UTgxOaC7uVVCdVz94UpR7b7OKsBoxftChcK4BvtcoPM=;
        b=y5lAD6Y347leSlrMjBgUi3b33NVaZeEeK1Q8RBswy+L2X3dveLaBX5t4q/GmzrmAcZ
         gUcoszx1LRK8A3ljVVXRJLJuuoCAW/bDKVyvQ8xu/yCTNBA21zx+QGxpRwcphALsvy7x
         gaaRFtkWtJYLcGuD5Zf/x6JSUGWXMdZxh5rNFO48GpZ98RZscaTC5nsOMyKfR7kw98hb
         JcwcCOUvZkPxmi1uNJO6wiI0A5LQOzY7cBeGNE0Oqk8yT4Ieie5DME7NvYEsjkGz3b1X
         X3/0yPWTjElmZGb9WLbXbkOOJCeSH/3arozYqhJHGIQgJSG9cbrQXVR+R2PFRfeLiZOJ
         qaJw==
X-Gm-Message-State: AFq9FYIfFNMifKCbF1mHAqgOnfD87BsJKAaZIdCuA4tR4KTZErvlTZPc
	wlUriczI3NXXq948QNARr4j7Fw/O+mRE60P0aJbbi5XseQOEZQKfVn5LR6ZgEP/e
X-Gm-Gg: AYBFou2PLMhx9R+0xQgeJUbyEjuYT/fPuYuzMX5v/WDFKmIplPSUXaypyz2VxGs4vQy
	OOqTaqwAVBs6Cbeu1v9sfWr7afPCpwXYbgX+ZernaapxCDdnLI9xFsMuIdLtD75eXdJeqnHdTLe
	Ai8/6H0FD28O8Lt10lDz2VVueJUcQj4UoQDCj9SjMuJIT0hhx+cCaG5HzyAoQSHGrbB3h2KEfML
	sOnQwl3NmfOgqte3TkP8UydHjDY7b2QdvHad93BUAZgBPGWhC6fFleNAPt7ADc1pN0J8aXRpd/5
	NajxopS0led/mRC5nppYV4iVjLZda3p2hJkrXNyKKtwqNVFuhzrSJRtxGWktihutG0NTdL/mutT
	PhOmV5a9ZL2TY+VyAa9aA39XHwoJKgiFRMXUT1dshImROGHpGJMzLGOAuWa7g+hg4cYW1gF1enD
	TVx/HGvlhFhiHWEyW9R8r+Qd+8h/chS8xs28nbvp2eO6ULTYPITIrbuXXkR9000ux1ALw5o0Dij
	m0KZiyzTtcLZY7fT/zBKELlEUrKJqcOjskIW6SMTFEHMSSf7X5WY5R7Juc+VDHj4mDKU0xtCDsl
	b9pGvBpRJxS8Sr5m6UoaPXhmVXf0PEbXwgq1L8TqS7+oI6vLwHZxjf4cEzQN274=
X-Received: by 2002:a05:6000:2f84:b0:48e:e98:8b64 with SMTP id ffacd0b85a97d-48e6e2eb232mr10535003f8f.19.1793445027007;
        Sat, 31 Oct 2026 04:10:27 -0700 (PDT)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71ba7168sm8853670f8f.55.2026.10.31.04.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 04:10:23 -0700 (PDT)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elia Pinto <gitter.spiros@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/4] tag, fmt-merge-msg, ref-filter: use size_t for message buffers
Date: Sat, 31 Oct 2026 12:10:00 +0100
Message-ID: <7008380756525a72d292a473613a7b3d9dd5d8d4.1793444420.git.gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793444420.git.gitter.spiros@gmail.com>
References: <cover.1793444420.git.gitter.spiros@gmail.com>
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

Functions like run_gpg_verify(), fmt_tag_signature(), copy_subject(),
and append_lines() take the length of a tag or message as an "unsigned
long", while callers pass a size_t. On platforms where "long" is 32
bits, this truncates the length for objects of 4GiB or more.

When handling large tags or messages on those platforms, "git tag -v"
inspects only a prefix and fails to find the signature placed at the end
of the tag. Additionally, in copy_subject(), the loop index is an "int",
causing an overflow on subjects of 2GiB or more across all platforms.

Use size_t for the length parameters and the loop index.

Triggering this requires processing 2GiB or 4GiB or more of input, so no
test is added.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 fmt-merge-msg.c | 2 +-
 ref-filter.c    | 6 +++---
 tag.c           | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index 14441f23ae..5a96c50383 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -505,7 +505,7 @@ static void fmt_merge_msg_title(struct strbuf *out,
 static void fmt_tag_signature(struct strbuf *tagbuf,
 			      struct strbuf *sig,
 			      const char *buf,
-			      unsigned long len)
+			      size_t len)
 {
 	const char *tag_body = strstr(buf, "\n\n");
 	if (tag_body) {
diff --git a/ref-filter.c b/ref-filter.c
index bdf54f6f59..8e2dcb74b0 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1657,10 +1657,10 @@ static const char *copy_email(const char *buf, struct used_atom *atom)
 	return xmemdupz(email, eoemail - email);
 }
 
-static char *copy_subject(const char *buf, unsigned long len)
+static char *copy_subject(const char *buf, size_t len)
 {
 	struct strbuf sb = STRBUF_INIT;
-	int i;
+	size_t i;
 
 	for (i = 0; i < len; i++) {
 		if (buf[i] == '\r' && i + 1 < len && buf[i + 1] == '\n')
@@ -1952,7 +1952,7 @@ static void find_subpos(const char *buf,
  * If 'lines' is greater than 0, append that many lines from the given
  * 'buf' of length 'size' to the given strbuf.
  */
-static void append_lines(struct strbuf *out, const char *buf, unsigned long size, int lines)
+static void append_lines(struct strbuf *out, const char *buf, size_t size, int lines)
 {
 	int i;
 	const char *sp, *eol;
diff --git a/tag.c b/tag.c
index 414681c64f..8709e8c46d 100644
--- a/tag.c
+++ b/tag.c
@@ -16,7 +16,7 @@
 
 const char *tag_type = "tag";
 
-static int run_gpg_verify(const char *buf, unsigned long size, unsigned flags)
+static int run_gpg_verify(const char *buf, size_t size, unsigned flags)
 {
 	struct signature_check sigc;
 	struct strbuf payload = STRBUF_INIT;
-- 
2.53.0

