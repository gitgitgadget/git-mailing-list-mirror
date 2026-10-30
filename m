Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793354343;
	b=B7CWuUw7t1JV7mSecDwFG40JiqeIDHSWa7CEAKfuofqAJAEFzfMp8PpqWXvDew74AFz0
	 9JHGztbINr5wQNLiOzsDIj85jmF447aw/+s6LGWrH/SnR0BW/4Vb5CgVyESelLzAQBvyc
	 VPl28wpdEInoiKacUbJRErVc4J7L+3uXbLLue7eyFveY847ZjgAbtE1fbEZD4+cV80Oqj
	 fLyMcqKphaVUF03Dl89byfkT1Ueg7cziOrxtYlv5wBdgF5gyEGC+5rKSqJTH3XU/0G5vK
	 8amfzMbi+YmMsSafj9sxIT8G/37eFAQfzpJ8FuJZPtTCx6gWe0bHc4/FhE+pYPUMWlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793354343;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SuLEXYTmuhsbw0HUoXxlmJgqO2YnSVWsrRaUkFsW0fY=;
	b=t9siSmP+bzYLrADlZaNwG6UC12udgOkxT2oSW5eJ6zcrRdExmThD2f6SXsZjgxnOXasq
	 PcvYnDyW5NST6D3RNcPolPwlch91UXJ7uhvYo6ILBEhL2zDgOdOrv/XA7PsUh2TEyQTyT
	 aM90cpegHF1skNMl+vEOUv15xPi6z7ZPAIUikLDj1r7r7FPpIYDTE1Mdx6/DgoioZSvZt
	 hNJ+RYaFFBy0AtmMJbwGpPrlBZW8dKHd3gQVbc4xk9/oDw8WM3ukwb7xed6N53BDVLBbA
	 LnIi70vQ8sBUBQW33/s2Es0cu8WjsEJ5V4d1IFJnZ4Zz2YXt+9M42zVtEodnm+q1ESA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O5jOkB0n;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF72B606A321
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 09:59:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF72B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O5jOkB0n
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48df4e9d2d4so243664f8f.3
        for <git@vger.kernel.org>; Fri, 30 Oct 2026 02:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793354341; x=1793959141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SuLEXYTmuhsbw0HUoXxlmJgqO2YnSVWsrRaUkFsW0fY=;
        b=O5jOkB0n9CtHo0AzK+m8OITBM8VMuIgFMhQ88154FwcMN8aAkLZEF2YoNCQYHrCIk6
         8FAc/Hc7QfU0taQfPX3Z5hqWYaTwUDSONzRtmrkrkcAJOLlKBbX9V89ptkyrndawQQzg
         SZPZMXbMQ7z7hh5zVMP+ljuOaQWybvnxQ5+lqJ7kC8QZk3vGsstCvmZunUSveIRJtbkC
         +ahkyTruJCej1cnrMTzo564zDjA883BuyIZ+CtjEQbTQEm4c43/tYpSKnei/iFcE0DW3
         eGR7EslQUIk0ZoDKciFc0e+iIEsLbPrnBUcGC8XUjkopBehAV4gw4JuzyKf33Q5DnjB/
         di+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793354341; x=1793959141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SuLEXYTmuhsbw0HUoXxlmJgqO2YnSVWsrRaUkFsW0fY=;
        b=Ax3Cq1AuSa82tka1c/ZiPqXPcUQhckQABSrfXJvWLNzmycvvkabeYR6Y9ZgvuJ6Ixu
         nL81D1GrTpefG7sfhk8oL0QFXzDXxZucLoD/XUx5P03pqeDq+gX1dli9GFEeyDk7VIcs
         17IO+2iDYmie/0i3Ve4S7G/tKT2JEuC0vRBlRzXCmkWyYjSfUtg/TrhLrCMGmrm4F0U5
         Ax1AQ2XjgtYh+fBBvtU846SW5EdP4PKAG2DGXORBtSoURDJDnlIlMkC84QazrgEh32Ih
         y8LVhZ6h6d/d7TPB/ovc3LrG4i+FLo6d4s9oXAkC6T4qNIug4OwH/znvGtLuV34Ebdct
         ACFA==
X-Gm-Message-State: AFq9FYLOD/CISaGVDAA//nGIMsVtzfNbpImfNmxNhpPwbJ69vZ4KUA4N
	3S5q1Pqjj44CVGl9zUMj4v5D5s/U3q+MJhqhwHpgltzmlYmg5RUQn2liTtaeT1sg
X-Gm-Gg: AYBFou0lFAJBeTQPoUapPB+G/YnqXflwNr1pkExCKJAEbhBjUNqi6cN7UToGdtQp43H
	TMmjLHCbo2i5XckwnuQjXYsyJx3neSJ3rhWRn27drqLa3C3Mqj6Ptqan3YIQKb7D4ITQamx/kBw
	CIVMT2lsROs95k233LYe5TJTp63jQrbiwimeXVyur0UazdJ7F25XnH6VLrDr615VdbyhwiAOTEu
	/FW/4mtb9Cfkg6XgOP7WTk5+0mGrdIMf+mJi+RFwac1IF0+kCP8CvEmIlDgxsX0eM/W6TNYHHhc
	dOgTD9WftQEnfBw4Mj7HA4JPOiHy0IgKiYlpTKXPYmXxAzaodbhFFI1iO2PndNL5XZuJKn9zjkK
	UhpcslRBn4chkevjDeapfk8t9szixQXzuWRz4CRyqV8PaiD2e0dCibSfafDKJ585Qxj/1UF/0H2
	b8cUF1qX0UpMl32PwM/bZZqK+LZkgj1cTv53kYF7DBGb8lCzS5id1sSCANMniibqF35tKOSgSw6
	9nM4nNVdB1ETTiXFATYJ9ZRqn2Yqp2mdOGfjqGRR5oAeQ/4Zn1sF/8RA147q/PIwFeCXfw9TH33
	UENkBCTFSQrl3q7UNjKQNGgwXssPMrWRWHyQY8wY4QDCEQMzfw==
X-Received: by 2002:a05:6000:2209:b0:48d:ee0d:8b3d with SMTP id ffacd0b85a97d-48e6e2f6d6fmr4394863f8f.28.1793354340953;
        Fri, 30 Oct 2026 02:59:00 -0700 (PDT)
Received: from ubuntu26lts1.example.com ([205.147.30.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b9b54dsm2359421f8f.47.2026.10.30.02.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 02:59:00 -0700 (PDT)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	Elia Pinto <gitter.spiros@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/4] odb: use size_t for the length of objects to write
Date: Fri, 30 Oct 2026 10:58:50 +0100
Message-ID: <8fcb9f10f13962acd5cdac652bea8fc4164f2e78.1793352943.git.gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793352943.git.gitter.spiros@gmail.com>
References: <20261021101640.329990-1-gitter.spiros@gmail.com> <cover.1793352943.git.gitter.spiros@gmail.com>
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
only hashes, so add a variant that writes the object with "git
hash-object -w" and checks both its object ID and its size. Like the
other tests over 4GB, it needs EXPENSIVE and SIZE_T_IS_64BIT. Truncating
the length to 32 bits in odb_write_object_ext(), as happens on Windows
without this patch, makes it fail with a different object ID.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 odb.c                  |  2 +-
 odb.h                  |  4 ++--
 odb/source-inmemory.c  |  2 +-
 odb/source-loose.c     |  2 +-
 odb/source.h           |  2 +-
 t/t1007-hash-object.sh | 13 +++++++++++++
 6 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/odb.c b/odb.c
index 2c93a9490c..1f173625b7 100644
--- a/odb.c
+++ b/odb.c
@@ -640,7 +640,7 @@ void odb_assert_oid_type(struct object_database *odb,
 }
 
 int odb_write_object_ext(struct object_database *odb,
-			 const void *buf, unsigned long len,
+			 const void *buf, size_t len,
 			 enum object_type type,
 			 struct object_id *oid,
 			 const struct object_id *compat_oid_in,
diff --git a/odb.h b/odb.h
index dd85b880a7..45182d28cb 100644
--- a/odb.h
+++ b/odb.h
@@ -621,14 +621,14 @@ enum odb_write_object_flags {
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
index 8b839caa39..07d5019aa5 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -451,7 +451,7 @@ static inline int odb_source_freshen_object(struct odb_source *source,
  * object ID and the compatibility object ID, if non-NULL.
  */
 static inline int odb_source_write_object(struct odb_source *source,
-					  const void *buf, unsigned long len,
+					  const void *buf, size_t len,
 					  enum object_type type,
 					  const struct object_id *oid,
 					  const struct object_id *compat_oid,
diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
index 463b38f990..0a89bbb455 100755
--- a/t/t1007-hash-object.sh
+++ b/t/t1007-hash-object.sh
@@ -297,4 +297,17 @@ test_expect_success EXPENSIVE,SIZE_T_IS_64BIT \
 	test_cmp expect actual
 '
 
+test_expect_success EXPENSIVE,SIZE_T_IS_64BIT \
+		'write filtered files over 4GB correctly' '
+	{ test -f big || test-tool genzeros $((5*1024*1024*1024)) >big; } &&
+	test_oid large5GB >expect &&
+	test_config filter.null-filter.clean "cat" &&
+	echo "big filter=null-filter" >.gitattributes &&
+	git hash-object -w -- big >actual &&
+	test_cmp expect actual &&
+	echo $((5*1024*1024*1024)) >expect &&
+	git cat-file -s $(cat actual) >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.53.0

