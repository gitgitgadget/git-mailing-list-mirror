Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1AA309EF9
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 11:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786015348; cv=none; b=J2tIaPPm0FCCtE01bmqj/VuacUEFYyXDhIrO+UrmgtN8QhjrW9u5vPYbc2siBVrw5Gw77wFcgM0ZJNP77fKNY3V0A+ff/jf+KVOYO9OTmZPmx02/8gR+pQ9qH5jO8ISU4P0uXpztpz7A1+ViE8dj37IGOa354QmxWqhLRTrowdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786015348; c=relaxed/simple;
	bh=73bH0MiODiQL/EeHkddlbHF9SACFGPZsjuaqPnJbIWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q1pQ3jF7b8Qsd0uMdpLwlZHEF1jjnHL6L1ZR3RFRVB3ii7tg6oSULnJjifeudHZMrkXXwRzoEVTcWjRGxnElpua30Rh9SplLQb1MBHvcTt+WFYSZpmz3zszRgCRiycSDgqZv5KQMxtIy4tnoctRFnp8sIXUoqqtvAT8gmaxkVeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YygBUej/; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YygBUej/"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38511175ad3so1756624a91.2
        for <git@vger.kernel.org>; Thu, 06 Aug 2026 04:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786015346; x=1786620146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2Cg6cZdSF9f8VVfLqRonYhMdW2NhQaOydkDst5gPhxA=;
        b=YygBUej/u8CyLUZEGaeCTLZ4q4AhhqhIU8Oj1LrdkMBstQkU7JxWDh57SPDyPrzmg/
         AN9m+i47U119WUmYDlOE1UpQwrT5KamvzSxbjBcFk42owFM1GkneTWEJ1VdLgnpoZpj8
         5JT6HyvCtI6d0bFuBvIbDSus0oJkHqPUm78tsKfnjsUDWNPHZxmz6OSMbLox3CFezhlB
         8ipG5n1TGzPedG45//q9UEC0MHdRKorERkovXBti7fwRmyIeppdZ0Nuk1+UBb7oUXbVL
         j/d8Z2X6yzSLEf5zYtAVGgSsXvRgvQvZnnVS/pHxrgS50A8PhNv1QzRg1fhXm4P+pz2u
         3djg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786015346; x=1786620146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2Cg6cZdSF9f8VVfLqRonYhMdW2NhQaOydkDst5gPhxA=;
        b=N5nk1zASdlCwCazAFBGAEgX1CcMm/pd+ErNR1+PkzRAp/JSCv5qoNqCUCSPv2WHK9S
         aLtcml2m7GVrEm4hiDEr59FwdbEJ4CyO6BAZwh3sq+dV2Z+A99SpsrRWrzSV/lV//lO/
         KFw+1iTvDYczFegOCkM/Ml540e9yB30IlTj4g4zVAO02lzVkxTlK8ZzMXUNCsCxeDLnX
         3d2AQrT8LKN0RtHCu0HKLa97FgGoHLT1M2ZK6nliR03pXrPK3yMWCEliHW5jMWrS0kqw
         s+IQEASDvWSSRbfWMRPdjGUvOeSaCe5Iwrcj0VHLlYyXN/drDcK0Cu5zY7d5dhPIkyon
         gCzw==
X-Gm-Message-State: AOJu0Yx7tYtppIB9MCSDugSQ2Jatc5uFMbzbci6YlpQCXqYiwrIU2kda
	H7pScsb4Xg2M+3swC2XehuyQv5JDxzQpbpUEiLUFJ4RNQQjI+8qz4Rwl2PAMz+bK
X-Gm-Gg: AR+sD12iq1H+5NaO3CbDEC3ftnAo18rcS718AL0b5JsdC0aMDEnWN+N0WC6NiwmBwTC
	Wde6qlvbxW8/Ueh7TIOLwwIzRbxUjwSo3VBhZ9UEEcOhJNM13JlYV52Od6o/f1TXWSkxT6z2aF1
	AgGLhv6/Tg76HO//A+gXBi1jFJl5jtm6VzFGf0I6VGYnVibfh2/W/x1qZE0KVh5BPB/aJmVE118
	SwmaiUkMFmRrqnuvTRIRpI+mIPTwFbv3hyf25Jw3/Ja1y9MTMR9p+P4w1OFXN+vBTMQWt4P6BMd
	YHeUJpWLizWzh4z3LcCOb24AJKd7k+Jib/ITKLh5JLAZf6ynVNH/1oj9M1QO4DesQ4smG3dJJ4F
	vVoChmtfp6Usxvvg6fRGlPZCWUDcHJ4dvdZ8VxpEUewgUiX9iR6Q3uEmdXgiaCxFf255z1owqcM
	r8mDXJsXDtLNBJU/PONy6buWOrIgwkCXo/Tf/cJe5EdndeLOJQHAKBe67JZWFlUYD4+HFzL+4Up
	neAS+rXhoRjTJ0NYzpvdbOFar9yvzYdUZrylhOOJM/f38otieXCZYg0b1UrTkH4JBaE7XiTa47g
	Sv7qKUnsWs/4
X-Received: by 2002:a05:6300:6d83:20b0:3cb:9a16:b159 with SMTP id adf61e73a8af0-3cb9a16b43fmr6672688637.6.1786015346147;
        Thu, 06 Aug 2026 04:22:26 -0700 (PDT)
Received: from localhost.localdomain ([123.252.204.197])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fca8df89asm42490376c88.9.2026.08.06.04.22.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 06 Aug 2026 04:22:25 -0700 (PDT)
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	ttaylorr@openai.com,
	me@ttaylorr.com,
	ps@pks.im,
	johannes.schindelin@gmx.de,
	l.s.r@web.de,
	r.siddharth.shrimali@gmail.com
Subject: [GSoC PATCH v3 2/7] list-objects-filter: add list_objects_filter__filter_oidset()
Date: Thu,  6 Aug 2026 16:51:57 +0530
Message-ID: <20260806112202.75067-3-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260806112202.75067-1-r.siddharth.shrimali@gmail.com>
References: <20260730174153.9949-1-r.siddharth.shrimali@gmail.com>
 <20260806112202.75067-1-r.siddharth.shrimali@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The existing filter entry point, list_objects_filter__filter_object(),
is built around the object-walk path: it expects traversal context and
provisional omit sets, and is meant to be called as objects are
visited during a walk. A caller that already has a set of OIDs in hand
and only wants to know which ones a filter would select has no usable
entry point into the filter API.

--drop-filtered is exactly such a caller: it collects promisor blobs
into an oidset and needs to know which of them exceed the filter
threshold, without performing an object walk.

Add a helper, list_objects_filter__filter_oidset(), that takes a set
of OIDs and populates an "omitted" set with those that would be
filtered out by the given filter options. Only blob:limit=N filters
are supported for now.

This helper does not actually reuse the existing filter machinery.
It reimplements the blob:limit size check directly. That machinery
is tied to the object-walk path and cannot easily be driven
from a plain oidset. A NEEDSWORK comment marks this so the helper can
later be refactored to reuse the real filter logic instead of
duplicating it.

OBJECT_INFO_SKIP_FETCH_OBJECT is passed when reading object info so
the helper never triggers a lazy fetch.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Siddharth Asthana <siddharthasthana31@gmail.com>
Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
---
 list-objects-filter.c | 45 +++++++++++++++++++++++++++++++++++++++++++
 list-objects-filter.h | 16 +++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/list-objects-filter.c b/list-objects-filter.c
index c912ff3079..6a2e9d5b24 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -828,3 +828,48 @@ void list_objects_filter__free(struct filter *filter)
 	filter->free_fn(filter->filter_data);
 	free(filter);
 }
+
+/*
+ * NEEDSWORK: this reimplements the blob:limit size check rather than
+ * reusing the existing filter machinery in
+ * list_objects_filter__filter_object(). That machinery is currently
+ * tied to the object-walk path and cannot easily be driven from a
+ * plain oidset. It would be nice to refactor the filter code so this
+ * helper can reuse it instead of duplicating the size check.
+ */
+int list_objects_filter__filter_oidset(struct repository *r,
+	struct list_objects_filter_options *opts,
+	const struct oidset *in,
+	struct oidset *omitted)
+{
+	struct oidset_iter iter;
+	const struct object_id *oid;
+
+	if (opts->choice != LOFC_BLOB_LIMIT)
+		return error(_("filter_oidset: only blob:limit filters are supported"));
+
+	oidset_iter_init(in, &iter);
+	while ((oid = oidset_iter_next(&iter))) {
+		struct object_info info = OBJECT_INFO_INIT;
+		enum object_type type;
+		unsigned long size;
+
+		info.typep = &type;
+		info.sizep = &size;
+
+		/*
+		 * Use OBJECT_INFO_SKIP_FETCH_OBJECT to avoid triggering
+		 * a lazy fetch while inspecting candidates for removal.
+		 */
+		if (odb_read_object_info_extended(r->objects, oid, &info,
+				OBJECT_INFO_SKIP_FETCH_OBJECT) < 0)
+			continue;
+
+		if (type != OBJ_BLOB)
+			continue;
+
+		if (size >= opts->blob_limit_value)
+			oidset_insert(omitted, oid);
+	}
+	return 0;
+}
diff --git a/list-objects-filter.h b/list-objects-filter.h
index 9e98814111..56a2d87aa0 100644
--- a/list-objects-filter.h
+++ b/list-objects-filter.h
@@ -94,4 +94,20 @@ enum list_objects_filter_result list_objects_filter__filter_object(
  */
 void list_objects_filter__free(struct filter *filter);
 
+/*
+ * Given a set of OIDs in 'in', populate 'omitted' with those that
+ * would be filtered by 'opts'. Currently only blob:limit=N is
+ * supported. Objects that cannot be read are silently skipped.
+ *
+ * NEEDSWORK: this reimplements the blob:limit size check rather than
+ * reusing the existing filter machinery. See the matching comment in
+ * list-objects-filter.c.
+ *
+ * Return 0 on success, -1 if the filter is not supported.
+ */
+int list_objects_filter__filter_oidset(struct repository *r,
+	struct list_objects_filter_options *opts,
+	const struct oidset *in,
+	struct oidset *omitted);
+
 #endif /* LIST_OBJECTS_FILTER_H */
-- 
2.54.0

