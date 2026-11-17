Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794937470;
	b=smIpxCyeY1Z3H+ZqQI6DaA7mJb9JVMK5oySzkL8Mrx4fJT+KnVYD0F/8Ie+5sIHs8hAP
	 BrIFBb9bqj203k+fIwbBrdpkjCIaVNk7Irati5ptGrKNvTUQepPcSAQ4lpt5UpjLd3q5d
	 +Pt1/74h1LTpHFjNcCAsSa3UQ8Y6cs+lnY3Mys3oLWTg0x6p9KVCqA+9/EF1IHSq9PxiR
	 cJcgIh6aEvgqdbjXrjX8UA2zvTFKnjVWqNVUwKZj7/WfHBTa0S3NPLdisGMIWxaz77uwO
	 NHyS0TMfzNRhoIaTFl+w7EyBSlPisD9S7W17H+8A1dJnQoSHtLHMskZmC71xPXe44mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794937470;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3kHozEu/3Lj+vitlFPds1A4uvE5DfsvBjiE3QwHMQHc=;
	b=c9GvX8KjXcA1dG47u3dZB+AdPDUkQyYUeiYhnLjkuxkDZrnUwBNa0EEfq0iJzbi92JPo
	 ot2k+QJExk61JgQwQG8aITkVSYj2h3cF8Z8jedXNLMIyuFaEeOsfEVSBSR+4/UFNmIqOk
	 55TcwAYIqC3/lm+ye0ExRUNmmX6LS1xHWcUU6ultCK2aqqXGFq5J2OybAJ8RyMZxf798W
	 lGbu/zBcK3yJ3Sz3n+rjp37uf4+CCTosEVFiYcIjf/ktAs9ekWNgTm5AngsBru5Xr3fia
	 xGMDILWT2msH3y0jaAi0Aj8r+jt6kTOhU8TMn3tow1kfLzer3wShYQzXzuB6J9SFVYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ysh6LgC5;
	arc=none smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A65606A32A
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 17:44:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64A65606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ysh6LgC5
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c50a2efbe1dso794784566b.3
        for <git@vger.kernel.org>; Tue, 17 Nov 2026 09:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794937469; x=1795542269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3kHozEu/3Lj+vitlFPds1A4uvE5DfsvBjiE3QwHMQHc=;
        b=Ysh6LgC5sCs6YJwgCAAgoFWVdeP/jdyYo6XYj1gdYGoN5kVR+/IOrw2yu5MgV/ccqc
         GQSVQWwTS8UxMsm+cR26Dx/tphPFAkBbUC1qGSfPfktKTBFvsb3WT89Sfy32hh6mppJq
         +BdNpKMmIO3EDRkA4fal7v1M/ZaMFmWG14nMBOAQ/DgurEnX0jwy1dBCnYE/D6BEWTzX
         qC5/bqSA1+xAGhsb98YeMT1vly4UVD49DQ9CptGzH7zvQK38F0dHf1hsldktmc2rw9XO
         O2kjFmxJi2DL7Z/A/RrjTJaaGra7+chP/RUG9sA7z3sS0womvDUQwiwgazE5+FpiXAbF
         UE5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794937469; x=1795542269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3kHozEu/3Lj+vitlFPds1A4uvE5DfsvBjiE3QwHMQHc=;
        b=yryleoZxdp0NsRnYHYBWqtZ7SBxPVfL1ciBYVDZ8YIrCupcpSOy6xcdMLEmb3vGcau
         RgBqZkUsxctVwJa+uUnYJi3UTSd7bpEN78tw7tU2I9aj6jWlj+cZV474hwVRBScuMgX9
         onYT+umjKnmEhHFv0NTs5/7TDr2//2KA0pp4+pgK+1Gj7YTCB8Hb5QMm6Y7XhDVebA6S
         krhHsUhn9kF/bkhme7+PhKFtajFEdikbafwRKyNIc7GuMOqS2vlzNJ6W4JL5kuVl1NNq
         qCUu9X2fQPtNHRQ0mC/uQfUKsW9W46uCO+pNx9+F5Ud9zDX6YgJ3pkgFvcypNO82V4BK
         2ylA==
X-Gm-Message-State: APuU4Z/AfJFe1wrVHqmxR0FgYjon2HqE6sXnzQgSFCEFvd0eYKTDODW/
	9zGswqxxP9yhanYU2k8ks3FxDvNdDY0mXdHv6Xj0EWLa9Z6bncDoeVhOTUS6QQ==
X-Gm-Gg: AYBFou0ZnkzZSa+hD2E0uFVv6YYPFI2BrKZFk1av0aNoFtDE4hd+zp7lZWdafXgs+zq
	Yeu0cZjJEqYZ3EU4+OzsDYeRc+9mM4SJ2acwaEOUTmT70Bqv5RW+Dh0gsq14X1MtrXAwAuAZhJW
	FS3EWCTYjXEtkwmlzyJnR19deD9iF2C+LtkjMwl4NPjryMTdjrG/FBLe5lfcF1JxbVjALBWPUMI
	D4FcpKy1ttj21v4lgroX9w/MqbnKAILfqy03kJRoIo3wTH1fWWRF59ZlukJL2qV9NVkyWLUffzw
	d/ukFFbg5oBhitXWIC+n6bsfY5hxYLbHDTJuE6PcJPLUUyjGKAFR23gifB6ixEyOTcKiY9k1Fc5
	5mTlbernbmdiP3s9rDO64khcDwII+1Zk6j/u9ffDom/9uYHK3HZ9/8Q3ly0SA/BLo0bnqdPDkTi
	RY4Q/07aUsOJf4bPiyvhBklPPzVN9PMjeOW35UJMMjifhiFIZJBi6AnP/OrkgBYIWw+IAqsbfpG
	+shcfAIcq/pQD/BeDAK87p9W8i4glncDkrwzCGilCyL347HVJQd1XiBrceJlX7TuWzC3Q3eNNCX
	2IvoaeURCKCSSuhuMGW8mz6KLRQNdvjS0fMgj+jnF//NjkxVxizJcorevAIwKM9oyZc/3lIAqUG
	AETTwXlC7Vm5CmSXSgGGt4XzfzoOjZSod6zUzs1je60nHN13AkLltemS8nKJskp55LmqdpJ2j5J
	LnTIu2lCIjXiShudXYj2E7zeaMKIaUfvj0T9kYfgg=
X-Received: by 2002:a17:907:608f:b0:c33:923b:ad51 with SMTP id a640c23a62f3a-c509638bf57mr1233844966b.45.1794937468689;
        Tue, 17 Nov 2026 09:44:28 -0800 (PST)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c510c83fe47sm7947366b.5.2026.11.17.09.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 09:44:28 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 2/3] odb: widen odb_write_object() length to size_t
Date: Tue, 17 Nov 2026 18:43:56 +0100
Message-ID: <20261117174353.1158905-7-christian.couder@gmail.com>
X-Mailer: git-send-email 2.56.1.495.ge87f5c5eed.dirty
In-Reply-To: <20261117174353.1158905-5-christian.couder@gmail.com>
References: <20261117174353.1158905-5-christian.couder@gmail.com>
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

odb_write_object() and odb_write_object_ext() use an `unsigned long`
for their object length argument, while almost everything they pass it
to already uses `size_t`: hash_object_file(), format_object_header(),
convert_object_file(), the `write_object` callback of `struct
odb_source`, and `git_zstream`.

Many callers also pass a `size_t`, often a `strbuf.len`. On LLP64
platforms like 64-bit Windows, where `unsigned long` is 32 bits, such
lengths may silently be truncated.

Since 81db32ddce (Merge branch 'jk/xdiff-size_t', 2026-10-15), the size
of an ll_merge() result is also passed as a `size_t` to
odb_write_object(). It cannot be truncated as since 1c93cc03ea (Merge
branch 'kn/safer-mem-arithmetic-in-xdiff', 2026-10-16), that size
argument cannot be greater than LONG_MAX because xdl_do_merge() errors
out if `size > LONG_MAX`.

But we want to get rid of that `size > LONG_MAX` check in a following
commit.

To fix the possible truncation issues with many callers and to prepare
for getting rid of the check, let's use `size_t` for:

- the length argument of odb_write_object(), odb_write_object_ext(),
  the odb_source_write_object() wrapper, and write_loose_object(),

- the size stored in `struct inmemory_object`, which is later
  copied back into `size_t` fields (`object_info.sizep` and
  `odb_stream.size`).

Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 odb.c                 | 2 +-
 odb.h                 | 4 ++--
 odb/source-inmemory.c | 2 +-
 odb/source-loose.c    | 2 +-
 odb/source.h          | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/odb.c b/odb.c
index de5be285d3..56a7910b03 100644
--- a/odb.c
+++ b/odb.c
@@ -702,7 +702,7 @@ void odb_assert_oid_type(struct object_database *odb,
 }
 
 int odb_write_object_ext(struct object_database *odb,
-			 const void *buf, unsigned long len,
+			 const void *buf, size_t len,
 			 enum object_type type,
 			 struct object_id *oid,
 			 const struct object_id *compat_oid_in,
diff --git a/odb.h b/odb.h
index 857637f980..a09748bdc2 100644
--- a/odb.h
+++ b/odb.h
@@ -634,14 +634,14 @@ enum odb_write_object_flags {
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
index 75cf29fa9d..c13cffc805 100644
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
index 50cb388c35..60801e70e8 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -758,7 +758,7 @@ static int end_loose_object_common(struct odb_source_loose *loose,
 
 static int write_loose_object(struct odb_source_loose *loose,
 			      const struct object_id *oid, char *hdr,
-			      int hdrlen, const void *buf, unsigned long len,
+			      int hdrlen, const void *buf, size_t len,
 			      const time_t *mtime, unsigned flags)
 {
 	int fd, ret;
diff --git a/odb/source.h b/odb/source.h
index 7b56f51b82..8daf5df31c 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -454,7 +454,7 @@ static inline int odb_source_freshen_object(struct odb_source *source,
  * object ID and the compatibility object ID, if non-NULL.
  */
 static inline int odb_source_write_object(struct odb_source *source,
-					  const void *buf, unsigned long len,
+					  const void *buf, size_t len,
 					  enum object_type type,
 					  const struct object_id *oid,
 					  const struct object_id *compat_oid,
-- 
2.56.0

