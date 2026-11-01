Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793547419;
	b=sYHGoNAHUoJHhKvXswgWmwX69TUmjgzcPJ54oVoT16bAww/4vy5rrXuh6274BGy+t4T8
	 +FQ0zoyqsKPfUkcD6jtB+NnWjFC241q9jXY/kLPns9cZfGcl8ACT6Ah3/LtLZtl8Tw/RI
	 JxkdoFyyxP14/0yyCMBJrKr5/9bf8HKkYA3txPez59ZLc6HFp/Zhm22CheL/YMzluQTRB
	 jvZmC0kjK3TuUuFOxb/mAglNWD0nO/D6Lr2H+HQNh6C8G7dC9gWKTBtj1Xe2O4Io/XOes
	 KGZHQdHh8muun7dkOIKRay7Zk+qjTa7Ffk8E2H1ocaPcKsbJrl3WeRzIY2ZTDCYE9UQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793547419;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dKrpCbQlg9048e0tn+Ci19OTMv+/9H1v9FqHqUqS9uw=;
	b=pdaZ+/aIXKJ1y3ZLkmYdoN2OablkAL4Epqh/70gqHSX+JwqbE1g1UAT8ckuqkwzeTd5v
	 Lh+fwqxh56mgHzriJBylUJaPoVhTFEf0DEJy6bZ4T07olpTCwoFkMMCU+XO+ENGIuzYei
	 szmUsQgS+pIELqSIgPj6kA+2I6LXS1Kv2mqyfLRIBGj8vp+6v/Li0r3JLNbx0rlj/fUAj
	 4tK9t9Q848Bu3TBQCdlnlhBbLafK4SmBe/pVFmLJmd8aZ9GB6fgqoYbqJos5Oiz6Cvhkc
	 VJBbPax6uoi1diqgl1ITfYiP+VatTAOiLUr86RXOaOJAMUmW5rXE5aY2GE2jFTdmaLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=scxbo0zR;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B2B606A32C
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 15:36:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77B2B606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=scxbo0zR
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48c45111bebso902452f8f.0
        for <git@vger.kernel.org>; Sun, 01 Nov 2026 07:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793547418; x=1794152218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dKrpCbQlg9048e0tn+Ci19OTMv+/9H1v9FqHqUqS9uw=;
        b=scxbo0zRuL7JCXLpjelhhJevUwnnLqgu3jXHIxS5DI70Ui3EjyXnYZ6GrwMqI/CLQu
         MNFdcpfYeHDdjuSR/QxjPDc+SX3y1ygE/97QxN6ZtL7jIGdkF+MkyjBRRNK9Ural3gSQ
         SVbdvWm4Tf0eQH2YgjsSBcfnj4tYRjP4UZvN3zvhVGuEHDrBjXeTm5Ed7hkJVLBjPynO
         yZ2kR9U8e+e71hdr/d6mb0igyZ9V5wX3CLJND1q5O0a5hjbfk2QwbIha3CuyojDNgxWd
         /OSWpq69ReOVyotF7IO8ts7QX/fmMWxr9R2iJKvyjmFBhLN9yLYDTzbPc2Z/B+F9ZV5Y
         b7pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793547418; x=1794152218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dKrpCbQlg9048e0tn+Ci19OTMv+/9H1v9FqHqUqS9uw=;
        b=eWU0bzfNnY6Rt01NCPb8iB0py55HXiBUIBlT7tpsx8jgBxAQomasGDgM3qFxWw7W6s
         9Zpo3j5aXOC92ki/3KbV1HTUdqGK+os/8ZX6yPsi7uLlMyc4x+SQkcjq9F6hxPT7qxA2
         eVBfFlG9prilct9iZIM14wVZYzZOf1jVuZJEmcQWS9zggr5XRuZnL3smmWqBf6Nt38PJ
         egkD5//noKGkLQGAAeJVpfJDjvhXx4rgB3WXAqeP5Qbc7E2n1xhoGwM9ateOBMbpLZ51
         vEHbMhQ9Mp2MTF+tOmcT9B4N3R2ONuTXp83Zn8EbAuPc4NdrxHhxJ3mINW3i1ZZgoW33
         VPZQ==
X-Gm-Message-State: APuU4Z/Zh7IiSxwcNNSmNxXwS9LZjJl8BX0vvdIfgzQJ1yBOk+JlnOXB
	TrK/EgnPgWfrBLjM9CBALNdE5sXwBR7ldwFfYbYGeOZcqQpds7sjaY5DwiYhTTwP
X-Gm-Gg: AYBFou1WEfmEGI6lqfr+8W+fxSl+RQ+MxHTfZTfeNz2Jmg4NYxEQk56NfrUFJ7Ii5Rx
	mFURqv20gGEewrHMh2Lfy4YQ2MEwdZyPW2bIaHDxa06HfRz5NepAvvqZUaDi1+Np4ayYae4nlVT
	nWY+VmaRwH9qVLshDI5TD13CH/acBFOpoZZ3qBRwKIOXziQN8kgrMCe/w4y2OVf+G8BiA6TbUUS
	0cRx/BRqjjGoqvuYRg5spTkFLPNVfLfaizRDFh0KiMgdqsu9LQebOCOGe6m3UR1nqZIHp/Ux1ZS
	fLvmJnicBMC2ELtbKdsg4rKFapsluhsZTnlVY0oTRnjqbugjmvgCeDUS2QkiuM7OSrg2S8paucj
	GMq6AYCehMgUF4b9rxDcojig4FQ3nzrz0Cc0xJoBE6yQkoh8/Ud75Is47ePTnIwqUnj5RQbOdVM
	Xvh63a9FhiUG8LPPIEZZLrmpQj+l+puxholBqsb6ZKYpFNs8hd7tQ7WC6Z1h1Ts4JsiN+WSPK5O
	kCponTLHaOQeYQk/Ghc54fPUS54ytkPcvp9pcDbcmR4FwTtPwA3WKrflCi2VPiqos+NU2GmwJ+C
	FhHu55m9e5uQi1SKuPqpCFYk+WuDLIMvcqpfAb+Ehc/sxMF6RmkiYRULWMAsQW4=
X-Received: by 2002:a05:6000:128b:b0:48c:69bd:e971 with SMTP id ffacd0b85a97d-48e6e307437mr12635170f8f.16.1793547417626;
        Sun, 01 Nov 2026 07:36:57 -0800 (PST)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b7246fsm14908450f8f.19.2026.11.01.07.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 07:36:57 -0800 (PST)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elia Pinto <gitter.spiros@gmail.com>,
	Neeraj Singh <neerajsi@microsoft.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 1/3] csum-file: use size_t for the count passed to hashwrite()
Date: Sun,  1 Nov 2026 16:36:49 +0100
Message-ID: <07baad46b153b255b6e70f2597f1bf41b9c48dfd.1793546752.git.gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793546752.git.gitter.spiros@gmail.com>
References: <cover.1793546752.git.gitter.spiros@gmail.com>
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

hashwrite() takes the byte count as "uint32_t" on all platforms. When
pack-objects writes the entire compressed buffer of an object in a
single call, which can exceed 4GiB if the object is in memory, poorly
compressible and core.bigFileThreshold is raised accordingly, it writes
only "count mod 2^32" bytes, corrupting the pack.

This was verified using a 16-bit simulation, where "git cat-file" and
"git fsck" failed after "git repack -a -d" with "offset beyond end of
packfile (truncated pack?)".

Make the count parameter of hashwrite() a "size_t". The internal loop
already handles writing in buffer-sized blocks.

Triggering this requires processing an object of 4GiB or more, so no
test is added.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 csum-file.c | 2 +-
 csum-file.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/csum-file.c b/csum-file.c
index fe18ee1de3..26aa662637 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -102,7 +102,7 @@ int finalize_hashfile(struct hashfile *f, unsigned char *result,
 	return fd;
 }
 
-void hashwrite(struct hashfile *f, const void *buf, uint32_t count)
+void hashwrite(struct hashfile *f, const void *buf, size_t count)
 {
 	while (count) {
 		unsigned left = f->buffer_len - f->offset;
diff --git a/csum-file.h b/csum-file.h
index 6ed74d1637..f1c8a9df13 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -75,7 +75,7 @@ void free_hashfile(struct hashfile *f);
  * Finalize the hashfile by flushing data to disk and free'ing it.
  */
 int finalize_hashfile(struct hashfile *, unsigned char *, enum fsync_component, unsigned int);
-void hashwrite(struct hashfile *, const void *, uint32_t);
+void hashwrite(struct hashfile *, const void *, size_t);
 void hashflush(struct hashfile *f);
 void crc32_begin(struct hashfile *);
 uint32_t crc32_end(struct hashfile *);
-- 
2.53.0

