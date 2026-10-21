Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792577808;
	b=knUoSsEnys8eGM3iBgnmpM0S3l0OLmRoWlV16JHK3HAp3anMO8iSYEo5+OJQjVKbxlBf
	 5b5+vhxL+Xsmi/qHfs6PlZgJSUQ/QetcLB/9aDC8iUzxhKDr8DexMeWy1fiwn3MJD9Onj
	 LLdnlSjPZF3CP6rer1gIA1Ib48w+bEGAlmPqDuQJbdYhC1+WbWc+NDCDC9wuUlfclHJEH
	 YdBbixPSVAGRWiKLp1DUvyZVYGpRW7UUkAzBStEp2SYkXYpV8frOUyeP0zCgvnp5dRgtz
	 NanANvo0QrSGxcEb94Cvxr1lhwzGHYJSIrt3dyl99Na+5rAUcfrD+H8XADCvXjyPn4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792577808;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=iSblbBDgqkcKMmSRcWg4jRgbRAGt0L6bM7ZI9IHU2vg=;
	b=CCCIRBYjAfEhTk3NaXjR0NEZ4NLpM64ZQEu32LlbNOepSWV37AHmT25chfA0BMt28RIh
	 BkVLXS8rX+aDpr0FxAHL8pKY6v9S7epYFLeElNnlakWZ/moUIxvkwJMQJePBVaeDlfJwE
	 Yabm0bBQWwZjtF0f2QfSszOn5voaVfOlOmP6bEyEKOSXzObyhkoBXkxczxRxa4TEvXgws
	 pD5/zD3y6ibQgCT1BzS+XH3DnAjuHktJdHcCGRVfLxeGYP9NQxhOrde5Oyaq2b4iX/M9B
	 ZkshQKWOyS6E8A6iIBY6LaivUItC1Lob9Ppe/iOlu6Ft15YI34Or2sHh53gmf+Qgg2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=X+JsAbjo;
	arc=none smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484F3606A320
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 10:16:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 484F3606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=X+JsAbjo
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c45551fa84eso68793366b.3
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 03:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792577807; x=1793182607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iSblbBDgqkcKMmSRcWg4jRgbRAGt0L6bM7ZI9IHU2vg=;
        b=X+JsAbjo45gjq8jACjQWPr/yG5vZh4gGzjrbBByVqtCe5AAfZALZhn6d9CnZnOxN9X
         gSMNxur4OvfR3/aErwiYfll0MTr7R3h+MfMRqCkij4RTRFHeTpOnKOURCNOTroMh/EO9
         ghAh9XattA9+yETfTcNQtko4aoYOEWStSIolrbcUDxW4LZ/KRTyPtM6XAbGTij/D9DQt
         oKIqvX3srunbE8SkZqdEOc8B8oc+90FmvJW9TJSx+LfmC00YtidalJQJ41rwMFnOmzI2
         uul24sV6kAH3DBaDJOfMOnig/em7OzWZHzsShcBoNZncxWmT5nDcvFfMtw/6SyTZMQo6
         YY4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792577807; x=1793182607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iSblbBDgqkcKMmSRcWg4jRgbRAGt0L6bM7ZI9IHU2vg=;
        b=gw5lLdbIipQnQyTaqyJvunXt2WJptuPXALELfBZMgQQs8FP6Hftka8WbSO5+BLcaF4
         oiOIPr4prmT1DTvmH6rbnKSKOpaaBKUr25OI8uo76BVFBLDJDPHVla16LRBLpLCVXopV
         wCRd14ejc+/qfpv5R5WrW/Hby73WiKqEXUeiXs8gcUeCeaHw0IjyeoB/IQI77ENDb2Cn
         aYp/D/O3e2LqZ3qH5JSB7LwSCy4ALBueWk4o/mdDJ5rjx9DYXM7yycYB2irC79firUct
         /dyQz0gtydSIpKNiQf35G4eS/PHT53e7GxG7Q/4f34DO8E2ByCX9lUZH1R7dnPjAg++Y
         SXng==
X-Gm-Message-State: AFq9FYJf8hVnjnEZ1f0/L4O5QBv+laFq+MIVNST57epJcgSs7hvFl0Xg
	p66ZUk+LjUKtB5ozG+QwAvVb5EKj3CGzZeEwppOLfdRbJbcfKw7N2N3W4dA5jzxX
X-Gm-Gg: AYBFou1D5829KhnqFzVBv+kg/vo38zap0HmAaiAFYyNGh6B0bH8fVf5GpLOeVMsL0JV
	s9pKmdrdDHdgTXQhOMxxoNwuKZK8UOr2ObdWXBenvOS0by6V+iBrwCwygGd4xh5Gf5E1oXCsIJP
	mNWVEh8rOXxLQklLyfkq/PgQllE90SZb436NSt3u48XO2D5eUt0nYBhL1QBrVlhOOegDLbpA1qJ
	eS5v8xBavYq1+e4OUrDnHfAgUIZ0BUnKrZgHXspltARWI3fzNLvXbuA29GfLdyxFQ/oISHnJIV4
	okCPy6QSfVYHcQTrv4fGNMsjW0vKUHlcGHabdbphl+4w1+ocaoZe1+Skeb86N7GfubElwfNb7b4
	D/APgO639igHUXgGkEpdXNO03ZJ5GBqafB4CpLZsvjuATtiiamhFfYf1mz57zvXhlXtHexfzJRa
	Du1OFINkna6C1JUryPKdJ+DBZGyRH7KMEd71hw6ucwYkMdDb8wQoV5m3PJwcWH/unPWTi8LLnP5
	Tb9yQ5qfDyDJYnP45XXi4P6MlnWhGibWJXa7pRVGwls+Z6yo6+/QKW52fyMajhZryt01XjU7nHK
	dNc91yk1ub8=
X-Received: by 2002:a17:907:9608:b0:c2d:bf61:24d1 with SMTP id a640c23a62f3a-c4679102581mr130070266b.1.1792577806351;
        Wed, 21 Oct 2026 03:16:46 -0700 (PDT)
Received: from ubuntu26lts1.example.com ([151.28.1.33])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e258427cesm4472602f8f.52.2026.10.21.03.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 03:16:45 -0700 (PDT)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	Elia Pinto <gitter.spiros@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 1/3] odb: use size_t for the length of objects to write
Date: Wed, 21 Oct 2026 12:16:37 +0200
Message-ID: <20261021101640.329990-2-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021101640.329990-1-gitter.spiros@gmail.com>
References: <20261021101640.329990-1-gitter.spiros@gmail.com>
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

c6a4629e32 (odb: use size_t for object_info.sizep and the size APIs,
2026-06-15) widened the read side of the object database API, and the
write_object() callback of odb_source already takes a size_t. But
odb_write_object_ext(), odb_write_object() and odb_source_write_object()
in front of it, as well as write_loose_object() behind it, still take
an "unsigned long", which is only 32 bits wide on Windows.

Most callers hand them a size_t from a strbuf or from odb_read_object(),
which silently gets truncated. The most visible case is index_mem() and
index_stream_convert_blob(): when "git add" or "git hash-object -w"
runs a file over 4GiB through a conversion (core.autocrlf, which is on
by default in Git for Windows, an eol or ident attribute, or a clean
filter), we write a blob made of the first "size mod 2^32" bytes. The
index records it with the stat data of the real file, so "git status"
stays clean and nobody notices until the file is checked out again.
"git hash-object" without "-w" uses hash_object_file(), which takes a
size_t, so the two disagree on the object ID of the same file.

Use size_t throughout, including for the size kept by the in-memory
source.

The existing "hash filtered files over 4GB correctly" test in t1007
only hashes. Running the same with "git hash-object -w" on Windows
shows the problem, but needs another pass over a 5GiB file, so no new
test is added here.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 odb.c                 | 2 +-
 odb.h                 | 4 ++--
 odb/source-inmemory.c | 2 +-
 odb/source-loose.c    | 2 +-
 odb/source.h          | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/odb.c b/odb.c
index 98c5c862f5..6e9daf11e4 100644
--- a/odb.c
+++ b/odb.c
@@ -667,7 +667,7 @@ void odb_assert_oid_type(struct object_database *odb,
 }
 
 int odb_write_object_ext(struct object_database *odb,
-			 const void *buf, unsigned long len,
+			 const void *buf, size_t len,
 			 enum object_type type,
 			 struct object_id *oid,
 			 const struct object_id *compat_oid_in,
diff --git a/odb.h b/odb.h
index 0ccc47ee73..25d02fae75 100644
--- a/odb.h
+++ b/odb.h
@@ -633,14 +633,14 @@ enum odb_write_object_flags {
  * Returns 0 on success, a negative error code otherwise.
  */
 int odb_write_object_ext(struct object_database *odb,
-			 const void *buf, unsigned long len,
+			 const void *buf, size_t len,
 			 enum object_type type,
 			 struct object_id *oid,
 			 const struct object_id *compat_oid,
 			 enum odb_write_object_flags flags);
 
 static inline int odb_write_object(struct object_database *odb,
-				   const void *buf, unsigned long len,
+				   const void *buf, size_t len,
 				   enum object_type type,
 				   struct object_id *oid)
 {
diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
index 868e723c81..ab7173cd2d 100644
--- a/odb/source-inmemory.c
+++ b/odb/source-inmemory.c
@@ -10,7 +10,7 @@
 struct inmemory_object {
 	enum object_type type;
 	const void *buf;
-	unsigned long size;
+	size_t size;
 };
 
 static const struct inmemory_object *find_cached_object(struct odb_source_inmemory *source,
diff --git a/odb/source-loose.c b/odb/source-loose.c
index 0664634938..fe1a298364 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -770,7 +770,7 @@ static int end_loose_object_common(struct odb_source_loose *loose,
 
 static int write_loose_object(struct odb_source_loose *loose,
 			      const struct object_id *oid, char *hdr,
-			      int hdrlen, const void *buf, unsigned long len,
+			      int hdrlen, const void *buf, size_t len,
 			      const time_t *mtime, unsigned flags)
 {
 	int fd, ret;
diff --git a/odb/source.h b/odb/source.h
index 1867347dfc..8e6ed96399 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -469,7 +469,7 @@ static inline int odb_source_freshen_object(struct odb_source *source,
  * object ID and the compatibility object ID, if non-NULL.
  */
 static inline int odb_source_write_object(struct odb_source *source,
-					  const void *buf, unsigned long len,
+					  const void *buf, size_t len,
 					  enum object_type type,
 					  const struct object_id *oid,
 					  const struct object_id *compat_oid,
-- 
2.53.0

