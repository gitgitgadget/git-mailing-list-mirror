Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B35B3A7590
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 21:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787176403; cv=none; b=gT6NN5zDpzAYuBd4zn3cCNkKwDnU8XWijqcAxtCSU9GbxKoy0A/STQOXkUGtLsGidxcjCAFCX4WSRTqNaX0Teq1JHwlHdwvrP6Xo9COn7x6iwA6h1a/X+ZOZkFm4Ex20f2xGEECSKUqxaf7cCH/XUXSI1bjo4V8xAvA10GYdOyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787176403; c=relaxed/simple;
	bh=hp7hL9GUO92/tuyKC18WbeZrEg8SBY1JEoT/czKR/As=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tPM6Gdzb4TDSmYIDmYo3XNtqTzJXAstl9jcy+oq8L10osbdMZEBdSjDpZFbc7xVzQ5fc64GeDZlFjI7yotfrOBJT/FXLFUv/V05W+IcvNZMgLDLy9hLqLmvVC5SYvW+MXEIggC445nif2IZBXjHjNjUgNC+QoMJ0FVMJTh+jA+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gPuHXHq5; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPuHXHq5"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7f0167e59a3so1038943a34.0
        for <git@vger.kernel.org>; Wed, 19 Aug 2026 14:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787176400; x=1787781200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jrten55U9ibjP+63dt73FqGe9Ka9VRkz9SFsCtTd2tw=;
        b=gPuHXHq5yPtVwpxT9swFYPwws/Bh5icUgcruaOgR4HGRypwFbntTleEu8QmZ+Nm5+A
         iU62Ek41kDoI3ur+BDGF3KDhvsK7NJzklXuWf3HcSB6PEX3dC7SoWdNN/TMOHvkQ/Cl6
         0ohaJj7jFC0Z6NrdKkF5X/jfFweImI+teSstasZy4oO+PXOz2mXwkjYxe5wvEklNvbIP
         yfdt27Tg0ATMIKs22qIcWQGy/Sy19QqL0kE0dB42ulUQj+X3ezmuI+XO21JsmL/tA3z+
         I/nnYMsk/Q91Yr7xtD1eIUo5rhxvUq2LOaHrSRbBTZ1R/Z2gk1RuVfRTCiZU704Un4fL
         2X4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787176400; x=1787781200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jrten55U9ibjP+63dt73FqGe9Ka9VRkz9SFsCtTd2tw=;
        b=DFVUdoVcL813x+oRjHdKyNBIvY7dNQLpRlhGSk0O+hTUQF8ggW4F3O9r9MQ5qZGmHV
         e3UvORkyx1tT/3g6orV+q/cuu1Sc1qPUOd0wWtJ8DS4zCCle6zSE13y3Q8o5NVKOWLeA
         ZreFoI3pqKNvOWUikhwtSC08wOlh9yOxSye/yzEV+UY5fE6cB5pv1Vu75SAiscTH3bZS
         G5/fxG7CHmenXVQ/J7aFbOteajsGzBuY6Q86NduP3F4IIcC7qiTK8bHAUiEXfloBmLqS
         xGGDgZAODVizfhvIXVEMHK9yEn3HZdn+CQUOSzEnyW7djqtUfEAB/4tiEWRNUbulLlIs
         lgmg==
X-Gm-Message-State: AOJu0YzxjxyixNmx9yTcI6Y9zJFjXztiJTSIAljbxVZWGtgUlZxPiNSC
	hmtt0+uB0/og8btVUzT/bxGoSZbMozYG0DNjRJr96qZxRaNwjrr8tuOXXcSxaw==
X-Gm-Gg: AR+sD12HI5cScC2J03rDZDMj3CMLYZZYC8YlDYpVgAQy/CU0lEdXdUnwtbpKn91iAtQ
	vBv78eJ6/iW6w5pP4GHAIC9G17O44RYUvR958jUb+DQVcHFkAfxyetjN//Xm0cNuOw0/KRQ5LSF
	xuK/KnuEGkbfdusjKFoNIOy8NVPHXo4pZCI0x2+pLsFIfrcFaUFi7UPb+JsLLf29l7i+DFO7FY2
	WpyhNbmHIATRlBUOv9wTaor03lacdyAxdavvW+hArLd/okSTlU7ntdtBI5ZwekZue6+VTGCb8T2
	7qlYIpT6M+gst6S6zV0rIUJhEBSWV9UchLPuRaIJ4SRTHx2rA0Ac637F2uOH2PzwDscjDO4xH/D
	x6lGb1GIUKMTmIF7egvFIxo12Kmw03QlYsQA12EEiHcAntHdJ/S2d0QVALUWY+ADm6CspM7mNGe
	4Y7pHaCCS4/Y6fZ0XXPl5bq3QB1ug2yh87FZjwjEs4fPOK7IC0R6bs+ifV16n2wiG8uUKr
X-Received: by 2002:a05:6830:650c:b0:7e6:cfd0:42de with SMTP id 46e09a7af769-7f43fad68fdmr7817584a34.15.1787176399948;
        Wed, 19 Aug 2026 14:53:19 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f43fe7029dsm2718026a34.2.2026.08.19.14.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 14:53:19 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 8/9] odb: return temporary ODB source when set
Date: Wed, 19 Aug 2026 16:53:10 -0500
Message-ID: <20260819215311.3880274-9-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.424.g13c7afec21
In-Reply-To: <20260819215311.3880274-1-jltobler@gmail.com>
References: <20260811175415.2044235-1-jltobler@gmail.com>
 <20260819215311.3880274-1-jltobler@gmail.com>
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

