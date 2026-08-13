Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83614418A48
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 20:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786651742; cv=none; b=tQTOTDMZ1CdEbEylcwtOvf5Fe2MGxdHUFeCREKV2TgubyuZwjhK93yv717kMhyhNqzEI3+2EDzLcjOwG+i6ASDb5zhvoQ5xClc3NtBjVY3nfUQoS1sJirL13MmeUApX/69mxkt+lys8J+RY2zzFLFP00dySg7fRFkOjz82Do5kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786651742; c=relaxed/simple;
	bh=/LIENcHYV8ywtS78yePXRqN4PsGuOtF1pP6kcFSzSDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pjJeV/iIAG0IkLuQ6fuPugNFJ+Y2jLFFb/WOGTqSY4gpU6c6dSaaBzbWZqYeeufpMj1m3nwNkcHDpWQUjv6fqDVAfxp2gtLd48+oD/WjJ09jpIoXvZvZ13Efbd9dBkRNMalq4dYzJeyfHDMTkTscgpUGjZ/Qa9ArtWPDi4yrWMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQc5O4+a; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQc5O4+a"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ceaf8a1265so4869145ad.2
        for <git@vger.kernel.org>; Thu, 13 Aug 2026 13:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786651741; x=1787256541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0Yi/Nwk474DAaW7bCLIq9gr6y8KSWeg0tA+QAXl7ieo=;
        b=nQc5O4+aE9m6aiZ7qOKdotMqqHzI/qOEvpLdFlqC4DC3eWE7ACkgeze37hJI87XHye
         u0ksbg55VwxhAJCdSO0cvPI2dztuuJfA2DY182NZXgD7nHr/ikEAEw2a8LLdy4XOTzmO
         fYxil9Y6quUnDUjNJE9+WbOLVrvCbxMlGgjgrZim1A5PFblm6jqNw59ClzKhafpXDCKO
         IE0rZ+plisC2v4pGY3lbFwemI7D8bxxYgpzNwE7Ib7929cSVgzVtG5WGJnZ/rnSPD+4G
         OqjD715dmM9D1BnyshGCkiHVDRYwxQT6xC5dBHwqaLQuL20Eaqqch6HZ05v7KlhxHnzN
         l60w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786651741; x=1787256541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0Yi/Nwk474DAaW7bCLIq9gr6y8KSWeg0tA+QAXl7ieo=;
        b=Y9JZHB3NY+YTzIj40Ds7NwZlbsZCk74zmybVkDO1gCj5eIaK54BwhFLAzzh949HW+6
         vZbEAPY6pcCWSUKE9hyfpn7u7G92d8ds2LrZ0VjnKkDL+DEJxDj9apNZtgMOVRyqhfFy
         1XoOgb3S9QWR3dcNyuV/6lPxA2hIJ4w57s4/+Hs6JslHEr+ME/buYl4iKIAn3QnEfU01
         26mpmKYnPUKSK7YIXqD77qaRYS1VHfYn8FcSdTgW9O4Nhv/Wkdqb+NBORTM6I4XoMzIM
         bSv+i6Ewt/Imli1bVxFMzU0sMp/mPaGOvE3n8OjziwKLWelluEq8idLXf7GTLWlC4U6J
         TbYw==
X-Gm-Message-State: AOJu0YzQVDUk7B5OsZ1dnFcMLTI/YPoQE3EOa12CCcQVGOWr4FVvWPUh
	znTQeDd7bo0NVRlR3EEuLSdpmJGAQlajb9YnCL1jfr/Xk9u6YixN85x20HkWBEcq
X-Gm-Gg: AR+sD108m1wCKCQyISabjdiGzhKx0NXQ6kw13jr8fx5lKx3fTj9OxaBQjmeUlXeRWre
	xlgE86W/IQV8OT4Nvus4kHIJBRiDR4Jvr/Bd0BjlCp4a6tmg53G+3kX/5KCeQGh4LItmQik2xOx
	qovCF3KsWuAHfZQyQQV2RWWiCRfu//mO/9R3BLe3ePgWHnFSxbd0ABTYGGWJaLxfvtN+A3BCaxp
	IqgJ0JmUfKWM6HuYLrkfx42mvcEg9Zonug7OnoGcrcY0RFVeDj5d440Rt6/GmTmjOpzDNm6kmGJ
	8PpwD/PywqVoGz75xYCSA5SRyYurJks4iiS84iGYyc0XiqnTdX8CwlX13ejWnycvOP5awwfex+x
	9TmRtAHFlfekyiMxaYaUtjhmQr/WROGaD1UAfBf9GkaA4tz18esT0Lgm0xFiSi3MP8ZD5xLFUvp
	Cbqf2Ob65wwVIKU4sm1xqyYd7zmYdrrRd0AHr1buaRGzjXjCh5s8JL/P6d0aai4x+5Fge5Y9IvK
	MosHs6GiJvfO3JqZ8Mk2SNk/2eG5UekhhOcqxKDvIAvDdkUPPIPBtptfxxHyB26eeKiVXNiC5lS
	gjREbFo/xPKRXh69O1hgVA==
X-Received: by 2002:a05:6a20:734a:b0:3c4:3ada:384d with SMTP id adf61e73a8af0-3cc71e25cb4mr266363637.30.1786651740548;
        Thu, 13 Aug 2026 13:09:00 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:ad47:4055:841d:89ad:96b0:2f73])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141387c6f95sm1533440c88.6.2026.08.13.13.08.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 13 Aug 2026 13:09:00 -0700 (PDT)
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	ttaylorr@openai.com,
	ps@pks.im,
	johannes.schindelin@gmx.de,
	l.s.r@web.de,
	r.siddharth.shrimali@gmail.com
Subject: [GSoC PATCH v5 2/6] list-objects-filter: add list_objects_filter__filter_oidset()
Date: Fri, 14 Aug 2026 01:38:26 +0530
Message-ID: <20260813200830.84348-3-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260813200830.84348-1-r.siddharth.shrimali@gmail.com>
References: <20260810174047.6524-1-r.siddharth.shrimali@gmail.com>
 <20260813200830.84348-1-r.siddharth.shrimali@gmail.com>
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
index c912ff3079..10e44f1357 100644
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
+	const struct list_objects_filter_options *opts,
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
+		size_t size;
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
index 9e98814111..5207ab70a9 100644
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
+	const struct list_objects_filter_options *opts,
+	const struct oidset *in,
+	struct oidset *omitted);
+
 #endif /* LIST_OBJECTS_FILTER_H */
-- 
2.54.0

