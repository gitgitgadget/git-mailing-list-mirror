Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8EC372EDD
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 17:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786470874; cv=none; b=J+tJWtGrEk8jSlKuRnrVBcK4nT+7lKMe1h/JTtb9XH07EPP1q7Vpq2aqzYKAOiuP66If36kBM0cuh3UxlcV0znAHB7TkGIIhHwViiJ1NJWvGqYScpAErUr0A7atuZPSakimKrNAIcmRrW1vWbAfksYnsnjftlm008pxtSpo2zQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786470874; c=relaxed/simple;
	bh=hp7hL9GUO92/tuyKC18WbeZrEg8SBY1JEoT/czKR/As=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RlcWUUJjSC3LtZQAjcUCGecORcMwBxDBg9EKJCsNcgQ8/t76cIWxTMqsAGAsKb/67557RlB295lcMZpDbMoKQaoKWY+rqHSvnxUeLUeaqaL174FfFFqJvSGleIs98sIQpO3NaLJdiZ3ZI24HNym86zvychqIyN7buTv/Cwwxwqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CbuE6fss; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbuE6fss"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-48a0ca07c38so102698b6e.2
        for <git@vger.kernel.org>; Tue, 11 Aug 2026 10:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786470872; x=1787075672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jrten55U9ibjP+63dt73FqGe9Ka9VRkz9SFsCtTd2tw=;
        b=CbuE6fsswUm4NglqWBvPnxNY9IJJcen5Hnkyjkk8/l7cHFN0uB2oIA0p/jPiZ5B6Pi
         zjDFNdSOPwz3oUrm2UHwvxyETCTgJLncw/H6uO5zLsAmWMh2GrFT0eA7ZLEjk/DzNfno
         6JDyqzEeNqP1olHzzNCVfrn/BWZaqc4utosME5iesJ60KZggXkOIc4a/u3oemnMJ1MHS
         hhUimVBd/ApWDmzDBTojIHcO4kzV3F8PF3IVg06XYAQGHYq8z0wv28xXuy9oozF+1089
         av0Do3wcbLq60Crx7ZL5ob6yUSIWTSX8V3VyWShVdpolz6+KQg+Gnk+gAJxNEKJpYOE+
         mwKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786470872; x=1787075672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jrten55U9ibjP+63dt73FqGe9Ka9VRkz9SFsCtTd2tw=;
        b=Y0ueniKtQxQTQYCb8F2PaeIrLUnVuRc1BDd5BAnrO0ZMUtibVHlTDLHcpezbE0ZfMr
         xxxPNFA8m4P8borgc1fbRLT4tiLNiRC6ZDbYBOO2n2D32KYkOyZjVEoML+4nyMaN1uif
         OT5BjHWub9qGQWPpQv+RtWIYxhrCCL6R1SegZReT3ZjxTK5ExN2VrTmsz739GR9HKaQs
         nh8/U2JqqYvwCIFExq9wfKNn81IoIvvKRnptdxY8wW0v6cjn2FhcLgsfMKzJ3u4znim6
         lmHFgKTaMypxEoRogAag4rsV3tbYoEUINB26ewbrWkjYOGBJJsO/h8Shnco10nfi9B1T
         foIQ==
X-Gm-Message-State: AOJu0YxltXmeSC4ZeRSmQW+MLyDR3BbATuoxH4/qldJzDgSz3ti9FTW2
	CXA+DjjkW+AJhvt5eU2rOchBlOlxg5JllWmeWEDL73JNWtSWhZ5/1fA38xVdJw==
X-Gm-Gg: AR+sD11UewRMS8t9hax7H08sMoRkJ+Y4Yin3T1HojallTt0u+Ig1tFXHngrQYnQxqzD
	sBP3Ue133Adr3PWV0Xuz6ZWb/nHI6kS6q4AqXOYADSCQiG/BAPFmmjQvFoc1OE68w0G3Iwhwa2C
	eXegxyauT9QJ2w3kY2HMkm/STxjsWJSR5/qTgGLsueYhxOfIrklaDkcAXZPx2J5eIfkTioHUEvv
	lJlAl6eKdr5mvRuMToJnChuzhErKgX8mLx3zCPtOQu64KCIdWrqubExq4KX3wlcCKO61/drYRxA
	la5lBCF9o0Sf2R25TyLfUJZkvgXtQSispmxfJPzucAzjEOLcBynjdXBW/2c6TLJBm9Va+SyoCBq
	+CsCawmNqEXi8pfO/uekZuXPmGIKqU01Mr8QKehht9MDPDW15uCAaiOIae1Jwn1LLp4c5oDAOJl
	xreYyZWgEfTvSoPEneqDo56qLNjA6ge2jjEPGDaFf2XF1JvhswaPggNoHt2dEylHkDer73
X-Received: by 2002:a05:6808:4feb:b0:492:3ed0:9073 with SMTP id 5614622812f47-4b209a4e473mr1445530b6e.4.1786470871677;
        Tue, 11 Aug 2026 10:54:31 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b2001331d2sm1241489b6e.11.2026.08.11.10.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 10:54:31 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 8/9] odb: return temporary ODB source when set
Date: Tue, 11 Aug 2026 12:54:14 -0500
Message-ID: <20260811175415.2044235-9-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.424.g13c7afec21
In-Reply-To: <20260811175415.2044235-1-jltobler@gmail.com>
References: <20260809190106.1565882-1-jltobler@gmail.com>
 <20260811175415.2044235-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When invoked, `odb_set_temporary_primary_source()` installs a temporary
object directory as the new primary ODB source. A caller that wants to
operate on the ODB source of the open transaction must assume that it is
the first entry in the ODB source list which is a bit awkward and
fragile.

Instead, return the newly installed source directly and report the
previous primary source via a new `prev_source` out parameter. Propagate
the installed source through `tmp_objdir_replace_primary_odb()` and
start storing it in the "files" ODB transaction so a subsequent commit
can easily access it without relying on the ODB source list ordering.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 object-file.c | 3 ++-
 odb.c         | 9 +++++++--
 odb.h         | 6 ++++--
 tmp-objdir.c  | 8 +++++---
 tmp-objdir.h  | 6 ++++--
 5 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/object-file.c b/object-file.c
index 4d03c167d5..db63587f6d 100644
--- a/object-file.c
+++ b/object-file.c
@@ -485,6 +485,7 @@ struct odb_transaction_files {
 	struct odb_transaction base;
 
 	struct tmp_objdir *objdir;
+	struct odb_source *quarantine;
 	struct transaction_packfile packfile;
 	const char *prefix;
 };
@@ -507,7 +508,7 @@ int odb_transaction_files_prepare(struct odb_transaction *base)
 	if (!transaction->objdir)
 		return error(_("unable to create temporary object directory"));
 
-	tmp_objdir_replace_primary_odb(transaction->objdir, 0);
+	transaction->quarantine = tmp_objdir_replace_primary_odb(transaction->objdir, 0);
 
 	return 0;
 }
diff --git a/odb.c b/odb.c
index caf1d0f542..8afcb6b637 100644
--- a/odb.c
+++ b/odb.c
@@ -226,7 +226,8 @@ struct odb_source *odb_add_to_alternates_memory(struct object_database *odb,
 }
 
 struct odb_source *odb_set_temporary_primary_source(struct object_database *odb,
-						    const char *dir, int will_destroy)
+						    const char *dir, int will_destroy,
+						    struct odb_source **prev_source)
 {
 	struct odb_source *source;
 
@@ -250,7 +251,11 @@ struct odb_source *odb_set_temporary_primary_source(struct object_database *odb,
 	source->will_destroy = will_destroy;
 	source->next = odb->sources;
 	odb->sources = source;
-	return source->next;
+
+	if (prev_source)
+		*prev_source = source->next;
+
+	return source;
 }
 
 void odb_restore_primary_source(struct object_database *odb,
diff --git a/odb.h b/odb.h
index fca67e8253..bdfcb9509a 100644
--- a/odb.h
+++ b/odb.h
@@ -199,10 +199,12 @@ struct odb_source *odb_find_source_or_die(struct object_database *odb, const cha
 
 /*
  * Replace the current writable object directory with the specified temporary
- * object directory; returns the former primary source.
+ * object directory and return the newly installed primary source. The former
+ * primary source is reported via `prev_source` when non-NULL.
  */
 struct odb_source *odb_set_temporary_primary_source(struct object_database *odb,
-						    const char *dir, int will_destroy);
+						    const char *dir, int will_destroy,
+						    struct odb_source **prev_source);
 
 /*
  * Restore the primary source that was previously replaced by
diff --git a/tmp-objdir.c b/tmp-objdir.c
index d199d39e7c..e633d97e0e 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -327,11 +327,13 @@ void tmp_objdir_add_as_alternate(const struct tmp_objdir *t)
 	odb_add_to_alternates_memory(t->repo->objects, t->path.buf);
 }
 
-void tmp_objdir_replace_primary_odb(struct tmp_objdir *t, int will_destroy)
+struct odb_source *tmp_objdir_replace_primary_odb(struct tmp_objdir *t,
+						  int will_destroy)
 {
 	if (t->prev_source)
 		BUG("the primary object database is already replaced");
-	t->prev_source = odb_set_temporary_primary_source(t->repo->objects,
-							  t->path.buf, will_destroy);
 	t->will_destroy = will_destroy;
+
+	return odb_set_temporary_primary_source(t->repo->objects, t->path.buf,
+						will_destroy, &t->prev_source);
 }
diff --git a/tmp-objdir.h b/tmp-objdir.h
index ccf800faa7..81eb927413 100644
--- a/tmp-objdir.h
+++ b/tmp-objdir.h
@@ -64,8 +64,10 @@ void tmp_objdir_add_as_alternate(const struct tmp_objdir *);
 /*
  * Replaces the writable object store in the current process with the temporary
  * object directory and makes the former main object store an alternate.
- * If will_destroy is nonzero, the object directory may not be migrated.
+ * If will_destroy is nonzero, the object directory may not be migrated. Returns
+ * the newly installed primary source.
  */
-void tmp_objdir_replace_primary_odb(struct tmp_objdir *, int will_destroy);
+struct odb_source *tmp_objdir_replace_primary_odb(struct tmp_objdir *,
+						  int will_destroy);
 
 #endif /* TMP_OBJDIR_H */
-- 
2.55.0.424.g13c7afec21

