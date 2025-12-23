Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA763090C2
	for <git@vger.kernel.org>; Tue, 23 Dec 2025 11:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766488307; cv=none; b=jsY0b+TIKXGOfGPaHGdQlERTRsC4+wmo3tAQts5LaNg/SIZOt4ptWVhBxhNuxDg/LsyKx9Cr9QSCqaUf6smX6zx87JN5J5sDGewnXLDEgITJ/Oi7IbCPVAwIbKmgpzcN4THrR08PQ4UB/KPRYHF3i5sSBFkaH8Db8Jgb/C6tSAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766488307; c=relaxed/simple;
	bh=j6XJGaSdlD0X65BW2lLhRhrFlzemmLzwyaej86K7W2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eIt88by0ovwByW7BhS5BhE1QQV2WSwHtWEalbYZG1j6nXQ1Zsp2l8laX5QdlgNkcgxXTcA2LgteaEI88sIxokl/yOyqqxkc1BPlq9uj6E0cMWQvjInPTDn/rW0m8uG/sYIa2bHBICA3mBZO/T3xgPy/iResxlklzIWYUu5AE5Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gXy99Zq8; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXy99Zq8"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47d1d8a49f5so21727495e9.3
        for <git@vger.kernel.org>; Tue, 23 Dec 2025 03:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766488302; x=1767093102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wjPQQmDWIQm7YOmCjO5LgexQo6OLGE43XJqvMF9kdZk=;
        b=gXy99Zq85dC0pHCyd+GYNMts0PHxOx2nzaV/hr+AWcCyGxS6nASlvPE9mqU4p0zO0/
         KucMCYSmLMh0fRvhf2KiAOUwUGiHhDMi+FhhVWa7uU2znhikbe9TJM8HDRP5mUxhR6Nq
         ncYOdKrN5SVOWKxk3PTVZaIjiQnPdZi7KhHQjpJJrrAL/U9jsavpcqXPYWy4fDEuMnUv
         0SIeZ1e/WG1yc1ERzpTuJn/wvaMrpmkBJlGRNqEWdSUiaeOzNy20CgY46M9gMrhI5ivD
         pTy16ZLA11PElOIv9qYRhEOjabxKHH7UnNFOXGE+7al8coS3oRMilHSwQwGpDorohw/m
         HBpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766488302; x=1767093102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wjPQQmDWIQm7YOmCjO5LgexQo6OLGE43XJqvMF9kdZk=;
        b=VBSFiNBlYuClnnsQ4kmBTQf2+kTFXZwwwA/hU/mhOj8h3mKVUHoOkS+TmdzGHaDqa6
         A3H7TIuM3lQd8e62RvuGCP4HzcUxg+k650dGxKvyQdAw+eQ0y+M3gIbU7iwPg4a9alhU
         V1ELmUfN2rH4Vu2FfEkIKMYbpFPX3BSO5T9uw5Sl7Bv/w7ejNu7wXV0FGnXCn8eeSgAx
         XQBwyU93BRXSsmhB9BhurTjFqUvWkOOiey0lOn7E14upuHK9lyvXqE05kPaMAF/krT3H
         sNIaQ0lg4CHmj8K24B95NJyjROhv+8zDCzXIMv8C9xuxHyCb3baidSONKSrnNkTsCfxq
         mhmA==
X-Gm-Message-State: AOJu0YwX9eaGOKBQ5F/FTLW3gBaYlkvhSJg7kli//c4uN1Z318kL3Aqm
	chjZ2nkyp7vrX1xWmQM3dGG2qQduBV5CA8Fd21KUMOn34+JKehPteKlnANvrZA==
X-Gm-Gg: AY/fxX5GFHO8ofDOFLt9GkI1Yq708RmyxVfdisM58dSSM20fxMNiwXAlJ8DAmfDPci3
	9KM1zf/IGncx2r2E5PRPULDgA99UKsCgWqUpbuj0C5xrLXHbiaXrRKHUSG4S3mPUfMlLxFTJViV
	s5dLYCYGcqUMRvByqjhzPdcTJOsreA/t/PK0Sz1IaTJ7yDRTeIqw02wJ5ZdwW/N9RqgkTk4qtHq
	83zgFvg+YNqUcrIcgU0924IxqYkuYw0oq7Ewhfa1Li8wI4DrsvHogVHSmm86jbceS/3Kbb61ZyQ
	1DamTvgX+3zLacMnVSORKxz9OXlqO9gjPJ0yboMbpmmofNxR6VGUSFU/6xt8M9j/xBdvtW5GqWT
	pN5DQmReI6/ZKgi3iZ6/kdGOW6ESc9EcTybahiRj4siF0EVZB4FADkYl7A1CWxvPNju/QE+MyJb
	xzoeTv6rcnk6H9yE5U2l7qqM1WtajbHeIF8g7R2C7S0mrX8GafdTzk6gseLZo3fFX+JnupLtag2
	9cHClY/Stbemq1kCmX81hXOZNr4vfrYv9v1Cw==
X-Google-Smtp-Source: AGHT+IGNSCbFnQ3FvcoxW+7jpmTuhsPcMeYmKSvN7e2XNhaV2/IRGFcLqwc3y2t0tyEiq1Mopab5og==
X-Received: by 2002:a05:600c:1991:b0:479:3a86:dc1d with SMTP id 5b1f17b1804b1-47d195a63b0mr127245345e9.37.1766488302317;
        Tue, 23 Dec 2025 03:11:42 -0800 (PST)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea227e0sm27932795f8f.17.2025.12.23.03.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 03:11:41 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 7/9] list-objects-filter-options: implement auto filter resolution
Date: Tue, 23 Dec 2025 12:11:11 +0100
Message-ID: <20251223111113.47473-8-christian.couder@gmail.com>
X-Mailer: git-send-email 2.52.0.319.gfcaffa7898
In-Reply-To: <20251223111113.47473-1-christian.couder@gmail.com>
References: <20251223111113.47473-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a following commit, we will need to aggregate filters from multiple
accepted promisor remotes into a single filter.

For that purpose, let's add a `list_objects_filter_combine()` helper
function that takes a list of filter specifications and combines them
into a single string. If multiple filters are provided, it constructs a
"combine:..." filter, ensuring that sub-filters are properly
URL-encoded using the existing `allow_unencoded` logic.

In a following commit, we will add a `--filter=auto` option that will
enable a client to use the filters suggested by the server for the
promisor remotes the client accepted.

To simplify the filter processing related to this new feature, let's
also add a small `list_objects_filter_resolve_auto()` function.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 list-objects-filter-options.c                | 35 ++++++++++++++++++++
 list-objects-filter-options.h                | 19 +++++++++++
 t/unit-tests/u-list-objects-filter-options.c | 33 ++++++++++++++++++
 3 files changed, 87 insertions(+)

diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index f13ae5caeb..4a9c1991c1 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -230,6 +230,41 @@ static void filter_spec_append_urlencode(
 		     filter->filter_spec.buf + orig_len);
 }
 
+char *list_objects_filter_combine(const struct string_list *specs)
+{
+	struct strbuf buf = STRBUF_INIT;
+
+	if (!specs->nr)
+		return NULL;
+
+	if (specs->nr == 1)
+		return xstrdup(specs->items[0].string);
+
+	strbuf_addstr(&buf, "combine:");
+
+	for (size_t i = 0; i < specs->nr; i++) {
+		const char *spec = specs->items[i].string;
+		if (i > 0)
+			strbuf_addch(&buf, '+');
+
+		strbuf_addstr_urlencode(&buf, spec, allow_unencoded);
+	}
+
+	return strbuf_detach(&buf, NULL);
+}
+
+void list_objects_filter_resolve_auto(struct list_objects_filter_options *filter_options,
+	char *new_filter, struct strbuf *errbuf)
+{
+	if (filter_options->choice != LOFC_AUTO)
+		return;
+
+	list_objects_filter_release(filter_options);
+
+	if (new_filter)
+		gently_parse_list_objects_filter(filter_options, new_filter, errbuf);
+}
+
 /*
  * Changes filter_options into an equivalent LOFC_COMBINE filter options
  * instance. Does not do anything if filter_options is already LOFC_COMBINE.
diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
index 77d7bbc846..832d615c17 100644
--- a/list-objects-filter-options.h
+++ b/list-objects-filter-options.h
@@ -6,6 +6,7 @@
 #include "strbuf.h"
 
 struct option;
+struct string_list;
 
 /*
  * The list of defined filters for list-objects.
@@ -168,4 +169,22 @@ void list_objects_filter_copy(
 	struct list_objects_filter_options *dest,
 	const struct list_objects_filter_options *src);
 
+/*
+ * Combine the filter specs in 'specs' into a combined filter string
+ * like "combine:<spec1>+<spec2>", where <spec1>, <spec2>, etc are
+ * properly urlencoded. If 'specs' contains no element, NULL is
+ * returned. If 'specs' contains a single element, a copy of that
+ * element is returned.
+ */
+char *list_objects_filter_combine(const struct string_list *specs);
+
+/*
+ * Check if 'filter_options' are an 'auto' filter, and if that's the
+ * case populate it with the filter specified by 'new_filter'.
+ */
+void list_objects_filter_resolve_auto(
+	struct list_objects_filter_options *filter_options,
+	char *new_filter,
+	struct strbuf *errbuf);
+
 #endif /* LIST_OBJECTS_FILTER_OPTIONS_H */
diff --git a/t/unit-tests/u-list-objects-filter-options.c b/t/unit-tests/u-list-objects-filter-options.c
index f7d73701b5..84a012af3c 100644
--- a/t/unit-tests/u-list-objects-filter-options.c
+++ b/t/unit-tests/u-list-objects-filter-options.c
@@ -1,6 +1,7 @@
 #include "unit-test.h"
 #include "list-objects-filter-options.h"
 #include "strbuf.h"
+#include "string-list.h"
 
 /* Helper to test gently_parse_list_objects_filter() */
 static void check_gentle_parse(const char *filter_spec,
@@ -51,3 +52,35 @@ void test_list_objects_filter_options__combine_auto_fails(void)
 	check_gentle_parse("combine:blob:none+auto", 0, 1, 0);
 	check_gentle_parse("combine:auto+auto", 0, 1, 0);
 }
+
+/* Helper to test list_objects_filter_combine() */
+static void check_combine(const char **specs, size_t nr, const char *expected)
+{
+	struct string_list spec_list = STRING_LIST_INIT_NODUP;
+	char *actual;
+
+	for (size_t i = 0; i < nr; i++)
+		string_list_append(&spec_list, specs[i]);
+
+	actual = list_objects_filter_combine(&spec_list);
+
+	cl_assert_equal_s(actual, expected);
+
+	free(actual);
+	string_list_clear(&spec_list, 0);
+}
+
+void test_list_objects_filter_options__combine_helper(void)
+{
+	const char *empty[] = { NULL };
+	const char *one[] = { "blob:none" };
+	const char *two[] = { "blob:none", "tree:0" };
+	const char *complex[] = { "blob:limit=1k", "object:type=tag" };
+	const char *needs_encoding[] = { "blob:none", "combine:tree:0+blob:limit=1k" };
+
+	check_combine(empty, 0, NULL);
+	check_combine(one, 1, "blob:none");
+	check_combine(two, 2, "combine:blob:none+tree:0");
+	check_combine(complex, 2, "combine:blob:limit=1k+object:type=tag");
+	check_combine(needs_encoding, 2, "combine:blob:none+combine:tree:0%2bblob:limit=1k");
+}
-- 
2.52.0.319.gfcaffa7898

