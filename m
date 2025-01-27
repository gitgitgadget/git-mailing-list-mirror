Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16F61FDE23
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 10:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737974218; cv=none; b=F1B6PqP/VhYv7p5jzcl750dJ+wc8JlBSed7m6r/1P3/9TgGoyouYVAlVZ+Np9GqW7evIkKQ9JrwZiqo7HCMIyIWf2jlDv9UMbOpbXlUYddnM/V8ya70LZniZosew1vymOVQd+Q6tlle6lkDjpHWMswkwm2ygIoPgpHqPN9hmYy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737974218; c=relaxed/simple;
	bh=hnO7JcZcZPcUZRVqMm5MlvJ7O+oyH37wHoO/sbgwRV8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YHwnvpVJOpq+aGir006C0GCEOi8P4efFepxtRIjxHiOV5UTExsg+Nx6FkST4tY768xuj8dtq/3ICAry92zBLIsrvF0JOXEwKElvmF5AQh66TKvYRfIM0FeWZfzqpL9ivNDnRLBgOmOEgn8wwmvd2CQBgW+7JCV71JYX15WcDz90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E//0+RH5; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E//0+RH5"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2efded08c79so5785942a91.0
        for <git@vger.kernel.org>; Mon, 27 Jan 2025 02:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737974215; x=1738579015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YTyIe5C2dhHlbz7R1WmYUhkzzys/0LyT5Rjje5P+PPQ=;
        b=E//0+RH5G0DOa21aBhxeX11hTWm2QChqDHcFSMZTSkgqiVchkztJMfJQgrQYfJAUKX
         UcKuhu0vg0u4NPSeM39NoK9OcWE+IZpiuIhabf/Idjn4LKaP6rGpAbsorMHmgEtnZ/Yp
         ogKYxaARrEPkona7H7S9Ouywe5kOIQvjS+8JvptgeyL6vUtDm7kVUdjYCKQX1zUg6DFU
         //aravgQb0ee1vZaY3jpaQqLy3XLtwd249PHMzG/b+ITeLnLtf9L+WOAVLT+cs+73gFs
         fJWdKZ3HWqtwGeQBcERebTlZ4PaBfgUa5VBCP9YbuuAXZmy75UeDmp0PvnIBQz7owguk
         E0dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737974215; x=1738579015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YTyIe5C2dhHlbz7R1WmYUhkzzys/0LyT5Rjje5P+PPQ=;
        b=QllGm+tSAGPi023NFqEidL4ZYizTHsyl7+tkvXnIB115EchohSnwhIiFsY6x39rNwj
         sESxP6CzXYNQxRABTu2VOBztgWXIae0rYAqIPc5p7Xzzj6LIQp20gZ32Q/oFoI9zL0jy
         bADxzrco0hgvwm0xlCPLvS6IlW6XfoPCoK48wrlEf9bxP7HrKb46t0dvoxfKKNO+yBR4
         yIxsRuhZlBMD4M1ewcl87t23fdyaTqa0tOHrOKWPpjQJuoQzJu4DJRoFeOPOBVvuuQZX
         WCLsuleLmLL05RXpAlTDkFArKuSP4AdzzSho8ptUBryySji7EuQq41xJIng/Xtgsn2Oh
         kNTg==
X-Gm-Message-State: AOJu0YyjsrhGP6U3A6vmDv5/4OoNugxs4M1TeWhYSmIwBtRe8KtVtj+s
	fmaUgUQr5Zqq0RFJKCeTwZuc1QXEv014fIgHLd3E6r63QGVDWwwEE0oLFWSINXY=
X-Gm-Gg: ASbGnctnwXARF65OhRUkmw0t+idfMlRu95NwdYrL67lGYuJn7P/4e0ItjJjMwwePeMP
	5YjVTsFANSFWPurPP7g2meXuyriRpyPCly848oN5/6aL60K/q7rVSF/pfb/zJGn7iOouUiHrMvr
	HiH01KJTrDqM5QB+5n+v45DyteJYDM3apms21jmpdNrFeVleJddn0AgfFK3FIKn1EYUT/Sm8wpl
	WAktV6cAJ2j9Y25E7kItPAHRGcZ6nZhqkIem89wWRPpimUke5dYy9XZOUFg6tNhZIKismJyW/i3
	Htc=
X-Google-Smtp-Source: AGHT+IE81HeRypXPf90N8CXHVwUNwR/3kJI4CTHtGMRsjQ7xeRd9twGXBgUwIHufH5B0+kENGpCz1g==
X-Received: by 2002:a17:90b:2dc9:b0:2ea:7329:43 with SMTP id 98e67ed59e1d1-2f782c628e8mr53969816a91.6.1737974215399;
        Mon, 27 Jan 2025 02:36:55 -0800 (PST)
Received: from meet.. ([103.240.169.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffa454f5sm6879439a91.1.2025.01.27.02.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 02:36:54 -0800 (PST)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: shubham.kanodia10@gmail.com,
	Meet Soni <meetsoni3017@gmail.com>,
	Pavel Rappo <pavel.rappo@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Patrick Steinhardt <ps@pks.im>,
	Matthew Rogers <mattr94@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v2 1/3] refspec: relocate omit_name_by_refspec and related functions
Date: Mon, 27 Jan 2025 16:06:42 +0530
Message-Id: <20250127103644.36627-2-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250127103644.36627-1-meetsoni3017@gmail.com>
References: <20250127103644.36627-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the functions `omit_name_by_refspec()`, `refspec_match()`, and
`match_name_with_pattern()` from `remote.c` to `refspec.c`. These
functions focus on refspec matching, so placing them in `refspec.c`
aligns with the separation of concerns. Keep refspec-related logic in
`refspec.c` and remote-specific logic in `remote.c` for better code
organization.

Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 refspec.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 refspec.h | 13 +++++++++++++
 remote.c  | 48 ------------------------------------------------
 remote.h  |  6 ------
 4 files changed, 61 insertions(+), 54 deletions(-)

diff --git a/refspec.c b/refspec.c
index 6d86e04442..66989a1d75 100644
--- a/refspec.c
+++ b/refspec.c
@@ -276,3 +276,51 @@ void refspec_ref_prefixes(const struct refspec *rs,
 		}
 	}
 }
+
+int match_name_with_pattern(const char *key, const char *name,
+				   const char *value, char **result)
+{
+	const char *kstar = strchr(key, '*');
+	size_t klen;
+	size_t ksuffixlen;
+	size_t namelen;
+	int ret;
+	if (!kstar)
+		die(_("key '%s' of pattern had no '*'"), key);
+	klen = kstar - key;
+	ksuffixlen = strlen(kstar + 1);
+	namelen = strlen(name);
+	ret = !strncmp(name, key, klen) && namelen >= klen + ksuffixlen &&
+		!memcmp(name + namelen - ksuffixlen, kstar + 1, ksuffixlen);
+	if (ret && value) {
+		struct strbuf sb = STRBUF_INIT;
+		const char *vstar = strchr(value, '*');
+		if (!vstar)
+			die(_("value '%s' of pattern has no '*'"), value);
+		strbuf_add(&sb, value, vstar - value);
+		strbuf_add(&sb, name + klen, namelen - klen - ksuffixlen);
+		strbuf_addstr(&sb, vstar + 1);
+		*result = strbuf_detach(&sb, NULL);
+	}
+	return ret;
+}
+
+static int refspec_match(const struct refspec_item *refspec,
+			 const char *name)
+{
+	if (refspec->pattern)
+		return match_name_with_pattern(refspec->src, name, NULL, NULL);
+
+	return !strcmp(refspec->src, name);
+}
+
+int omit_name_by_refspec(const char *name, struct refspec *rs)
+{
+	int i;
+
+	for (i = 0; i < rs->nr; i++) {
+		if (rs->items[i].negative && refspec_match(&rs->items[i], name))
+			return 1;
+	}
+	return 0;
+}
diff --git a/refspec.h b/refspec.h
index 69d693c87d..891d50b159 100644
--- a/refspec.h
+++ b/refspec.h
@@ -71,4 +71,17 @@ struct strvec;
 void refspec_ref_prefixes(const struct refspec *rs,
 			  struct strvec *ref_prefixes);
 
+/*
+ * Check whether a name matches any negative refspec in rs. Returns 1 if the
+ * name matches at least one negative refspec, and 0 otherwise.
+ */
+int omit_name_by_refspec(const char *name, struct refspec *rs);
+
+/*
+ * Checks whether a name matches a pattern and optionally generates a result.
+ * Returns 1 if the name matches the pattern, 0 otherwise.
+ */
+int match_name_with_pattern(const char *key, const char *name,
+				   const char *value, char **result);
+
 #endif /* REFSPEC_H */
diff --git a/remote.c b/remote.c
index 0f6fba8562..40c2418065 100644
--- a/remote.c
+++ b/remote.c
@@ -907,54 +907,6 @@ void ref_push_report_free(struct ref_push_report *report)
 	}
 }
 
-static int match_name_with_pattern(const char *key, const char *name,
-				   const char *value, char **result)
-{
-	const char *kstar = strchr(key, '*');
-	size_t klen;
-	size_t ksuffixlen;
-	size_t namelen;
-	int ret;
-	if (!kstar)
-		die(_("key '%s' of pattern had no '*'"), key);
-	klen = kstar - key;
-	ksuffixlen = strlen(kstar + 1);
-	namelen = strlen(name);
-	ret = !strncmp(name, key, klen) && namelen >= klen + ksuffixlen &&
-		!memcmp(name + namelen - ksuffixlen, kstar + 1, ksuffixlen);
-	if (ret && value) {
-		struct strbuf sb = STRBUF_INIT;
-		const char *vstar = strchr(value, '*');
-		if (!vstar)
-			die(_("value '%s' of pattern has no '*'"), value);
-		strbuf_add(&sb, value, vstar - value);
-		strbuf_add(&sb, name + klen, namelen - klen - ksuffixlen);
-		strbuf_addstr(&sb, vstar + 1);
-		*result = strbuf_detach(&sb, NULL);
-	}
-	return ret;
-}
-
-static int refspec_match(const struct refspec_item *refspec,
-			 const char *name)
-{
-	if (refspec->pattern)
-		return match_name_with_pattern(refspec->src, name, NULL, NULL);
-
-	return !strcmp(refspec->src, name);
-}
-
-int omit_name_by_refspec(const char *name, struct refspec *rs)
-{
-	int i;
-
-	for (i = 0; i < rs->nr; i++) {
-		if (rs->items[i].negative && refspec_match(&rs->items[i], name))
-			return 1;
-	}
-	return 0;
-}
-
 struct ref *apply_negative_refspecs(struct ref *ref_map, struct refspec *rs)
 {
 	struct ref **tail;
diff --git a/remote.h b/remote.h
index bda10dd5c8..0d109fa9c9 100644
--- a/remote.h
+++ b/remote.h
@@ -261,12 +261,6 @@ int resolve_remote_symref(struct ref *ref, struct ref *list);
  */
 struct ref *ref_remove_duplicates(struct ref *ref_map);
 
-/*
- * Check whether a name matches any negative refspec in rs. Returns 1 if the
- * name matches at least one negative refspec, and 0 otherwise.
- */
-int omit_name_by_refspec(const char *name, struct refspec *rs);
-
 /*
  * Remove all entries in the input list which match any negative refspec in
  * the refspec list.
-- 
2.34.1

