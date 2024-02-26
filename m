Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A04C131E57
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 21:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708983576; cv=none; b=A4HiWU2B5WDDRMAAh1K8WdClRAJWjITJnSxWB8CqT43CcZR5L9rvUbqtmOabhVAGVfcElQ6IwMVvbLv8COgGtFFlOx0XHPn/5TJl7ILsWaGw3sOA2ou6Xgz7Z2Jh4xg5kFeHkoeVTlnIG6EJxOEeS1nS1YclkOlKiNy9jCbeIbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708983576; c=relaxed/simple;
	bh=pUzGHm4St4fqmQCNCQNAfBEF8BWjY/h1Tbq3KDHzyW4=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=kl4xNGiIEEL7gI5EbDLhPGuWkTYP7CVImpmuq6n8UKPA88PN/vPyw/7PjOlIVrjQNeds1Fq6VMMCmodhVak+CEjutwlrTJVNIilLHhVwcs2a+jvx/ZuoTOo7TjUfBF1kGyOonOStMJ88z+V3W7ygz/oAXWn0t52/INYRfs4B4VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ErT8IMh2; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ErT8IMh2"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40fd72f7125so28882145e9.1
        for <git@vger.kernel.org>; Mon, 26 Feb 2024 13:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708983572; x=1709588372; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txFVTpVywcZhgtkGGUVkhR9t/l/lhIwbfkCUpw21Y/U=;
        b=ErT8IMh2kgp8qAVUtxjs23iSZAB5AnNm+xgj5z8moCd+HCQQqmuL5tRw5QOgyHiE3O
         dmDm1P0mYvMMQ1dXqWM+E+F/1YysIuDeHTh5XBxRak71OP54qElMuRKB9kUD1tp1bBI7
         uCK8Ns67cFZfGgu5F64KUIgqUKvSoXs+U5xfWoo1ip5oAiXC1vwLkAOcSJBi6ifLrlXZ
         vTVH3cfKr5WX4kJ/P5uqYpxg9IXLv94P+hyagD+D4+Iy2zrEyfMQmSL987HYkihM69bh
         A8ABqrIEVPlpqumzbCR0F3XXChAIY1RB8mBoYhAyk92Xe/n5O64H+Z+zwY0R4KlWx242
         n5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708983572; x=1709588372;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=txFVTpVywcZhgtkGGUVkhR9t/l/lhIwbfkCUpw21Y/U=;
        b=gLG4vQ7D7Dqgk4LQTt8qzTpOnSe8MwsvjsYkPYT4P9FKOY5W2mb6eKDfqEFGScOPiN
         jOfl0dNpylCL7fQX1F3OFXaaKOsJsQawPL7NRoxWmmyRhdr3sC6Bk84kJELixT8RLjd4
         1bDqkeEnA3vgzGsfFn1L/l1KkBEOYvCj8Fn7OicZpkS0T03VX2lNV2pND98b6bT97XIS
         k0NIPndh99h0aajSh+KQqcreOGRiwQGOUPxQY31PNxvmJNcQDUGFmt3DtqhCG/nbnxSm
         CI8QizIj/NpNqskU6gQ2a3KVFN0spD6HOv2Zy22CUv0/ODcZq0v8m3AFm7qxqEeNVVGB
         xRmA==
X-Gm-Message-State: AOJu0YzorocLvmoQVVQ7Q5yEexnGfmo6YaQoZWsntqyXfKJX6o9ADTHM
	xUCcLf5aww7/dF+msbYyOxtnfqYu/0mAwJg9bBtfDfXvLkEyo7zeYKE0t6ho
X-Google-Smtp-Source: AGHT+IEiEjJVVkUpxGpj34azxnkeZPqgAjPGmzaAvEoO8MMyp9sS29tvrfqehoe/VipyHcOVgRgPmQ==
X-Received: by 2002:a05:600c:4e86:b0:412:a20a:7d91 with SMTP id f6-20020a05600c4e8600b00412a20a7d91mr3838282wmq.8.1708983572552;
        Mon, 26 Feb 2024 13:39:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t17-20020a05600c451100b00412a2060d5esm6374803wmo.23.2024.02.26.13.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 13:39:32 -0800 (PST)
Message-ID: <ed735e3f1cb90ef887a211a5e208ebe9f13810a3.1708983566.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1662.v3.git.1708983565.gitgitgadget@gmail.com>
References: <pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
	<pull.1662.v3.git.1708983565.gitgitgadget@gmail.com>
From: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 26 Feb 2024 21:39:17 +0000
Subject: [PATCH v3 06/14] dir: create
 untracked_cache_invalidate_trimmed_path()
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Jeff Hostetler <git@jeffhostetler.com>,
    Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
    Jeff Hostetler <jeffhostetler@github.com>,
    Jeff Hostetler <jeffhostetler@github.com>

From: Jeff Hostetler <jeffhostetler@github.com>

Create a wrapper function for untracked_cache_invalidate_path()
that silently trims a trailing slash, if present, before calling
the wrapped function.

The untracked cache expects to be called with a pathname that
does not contain a trailing slash.  This can make it inconvenient
for callers that have a directory path.  Lets hide this complexity.

This will be used by a later commit in the FSMonitor code which
may receive directory pathnames from an FSEvent.

Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
---
 dir.c | 20 ++++++++++++++++++++
 dir.h |  7 +++++++
 2 files changed, 27 insertions(+)

diff --git a/dir.c b/dir.c
index ac699542302..20ebe4cba26 100644
--- a/dir.c
+++ b/dir.c
@@ -3918,6 +3918,26 @@ void untracked_cache_invalidate_path(struct index_state *istate,
 				 path, strlen(path));
 }
 
+void untracked_cache_invalidate_trimmed_path(struct index_state *istate,
+					     const char *path,
+					     int safe_path)
+{
+	size_t len = strlen(path);
+
+	if (!len)
+		BUG("untracked_cache_invalidate_trimmed_path given zero length path");
+
+	if (path[len - 1] != '/') {
+		untracked_cache_invalidate_path(istate, path, safe_path);
+	} else {
+		struct strbuf tmp = STRBUF_INIT;
+
+		strbuf_add(&tmp, path, len - 1);
+		untracked_cache_invalidate_path(istate, tmp.buf, safe_path);
+		strbuf_release(&tmp);
+	}
+}
+
 void untracked_cache_remove_from_index(struct index_state *istate,
 				       const char *path)
 {
diff --git a/dir.h b/dir.h
index 98aa85fcc0e..45a7b9ec5f2 100644
--- a/dir.h
+++ b/dir.h
@@ -576,6 +576,13 @@ int cmp_dir_entry(const void *p1, const void *p2);
 int check_dir_entry_contains(const struct dir_entry *out, const struct dir_entry *in);
 
 void untracked_cache_invalidate_path(struct index_state *, const char *, int safe_path);
+/*
+ * Invalidate the untracked-cache for this path, but first strip
+ * off a trailing slash, if present.
+ */
+void untracked_cache_invalidate_trimmed_path(struct index_state *,
+					     const char *path,
+					     int safe_path);
 void untracked_cache_remove_from_index(struct index_state *, const char *);
 void untracked_cache_add_to_index(struct index_state *, const char *);
 
-- 
gitgitgadget

