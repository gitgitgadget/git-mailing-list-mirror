Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8008930F53D
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 22:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567314; cv=none; b=VmWlscnPp6laXV00IueAC2SeLpKb8NZ1BcmwWn6OcfYBR4c1qNsYhdcrf8ekh6IGWPlaNqI3ty271lmU0LG3A8m1tRuQTt0kof7ifZWfGq5mufzX6GlcqGS2eRO7Wt04A7fd1AvAe9ORUccK21y8NjMlMpP1osjD0vPrmrTpvyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567314; c=relaxed/simple;
	bh=KoXT4NWKYdJUevIJFY2eMEIZon939Unfzgx+LDU0fsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+0XHAEmzQEKvZUHQfzYy3XvLSFD49KeRD7whDFeHlFtFV68XeDhCEOiaQe0ohsnK1RzpdmimOffpNTnTekxC8AfUJ5JLtViV25KEUToDpGjiMCaXvDkDtO9cjx3DATakPbDLvtVLf44bJF4LtBE017hEZrsCDA/iTVDq9DXH6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=I4mow4M0; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="I4mow4M0"
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-72e565bf2f0so791647b3.3
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 15:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760567311; x=1761172111; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=couoFbXj1MgfbVkpsoCCS9QtopbCj0O2Ch7uJUkP6kw=;
        b=I4mow4M0hiwAR1i17/2u2JoRFpqLWgO50eiQ0VisNiP0YT3Ia0c8YowHCJvVRUC3x7
         X8l+bGFga5wVEqyCvtXvs4XX4h+pEulD8cy5qvVYTUI+tMT9uyLc7WO/rwcwdM+L3x5a
         eMf2yey3dQdC+3jR0cX5YEP4PuwpSGagnHKO8LWQ29usbbk7vmLMvN1hZP0mUyBg6tnI
         EdgvYCDG4zt2hBLT26J7okJYgIOuRqGzxPzxrI2HucT1LeUrsYrty5WpKa0UBsP4fVPL
         f+VE0yd2YBrPxAhjUk/T7TEkwOvhnP+JDikdiSiYoYmKAyLR9YCqknsEBlCnfUoD53vt
         EjgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760567311; x=1761172111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=couoFbXj1MgfbVkpsoCCS9QtopbCj0O2Ch7uJUkP6kw=;
        b=ZKmXBuv5wUCiWDEdH/thJefVtgLdquvxuYwdU3sYAz758W3wRHkycj6XYxvBCeVj5K
         sej02ljEIoDtjjw0xbgiHClEuza77ElSCtH7igWTSyfKf+Kk4Mj/I/9X0QVMN1WZIz/O
         +Iq+v5KQ6KGdCbRX7/08IvXzQCQcxF81JmOBDfRaGE4E56H23ybC3J0k1bXJwIFCW6Dh
         2bJGCjeXld6+0cNTNL3f8sEEVhYnPVel5fF7SCZUT1rPDsKKusTd90MS0bAKsnxIbFbU
         31Z3EzWKzxzYTH34rDAyzUEBCgAKB2vIpYGCl3SujVeg9tNMXOSPcQd4IoZrUHR/Xp+F
         PlAg==
X-Gm-Message-State: AOJu0YyAZFXXzuPtbtdHEDCrR9x/duXNQl4dk/IQiGxTx7C2OFwRdO3D
	C9n3oUjdJpPlDdXdtS8YlNJNC/ziD+2w79kPGIx/64Z180Uk/hHBvwp/w1gwh6kYpQNDY8GP8yf
	iix3cxX0aFFff
X-Gm-Gg: ASbGncuxwYUd80VfkoWH6/jNoLKUlLOfxYkLPd1fv5UE0zjErAp418KXNtFZkpvGFAE
	2jbtJSk6eDFt6E8vJ0kLvhdCCuqnlWES+WPO2tFAj7cbQAwY3ac318W5rqo0yRNj8KMUyzIEgze
	XknqBZNZBDQRnrwOkMrM9En2cBQLgpvzi+x6u/FQkkZayOsoRQhkgOgBa1WklcDeZkddqFT+3pj
	YXnXeMZvZfkIrO7QMQBDxqHpW8nQz9by+L+G6LTCDv6emeBsggokI8lZALvpmXRVi2tJ8ajdLO2
	GEnttpQ4QPqoTMM+9JjZf6WCmrWoPMZeYRtflu7DZiinmT2qRTL5Ixkffd14FDwz05Dx6y3mKJA
	dkVkSRM/hImK0LEvX/OY+aKSntKf22WyDUlvka93eFDN0csOVmdG2J50QTOqjQiU/Id3rgU6Hix
	gnIT3Tl2R7asjfUr0gFlV0MT5rlMBL81nFy8SfB0b85y4ngAX3GIrMHhKgTO6RutWG2RugLRB7z
	KHHlr0=
X-Google-Smtp-Source: AGHT+IH6YMBgKywa0sK1+BI0hp85j5BLoWXezlHR51e/nXLbrgeib+ZIlQ3tgg3JfLIIWfggrUTSpw==
X-Received: by 2002:a05:690c:3381:b0:77f:b51f:6dd7 with SMTP id 00721157ae682-780e14490e1mr320607027b3.21.1760567311317;
        Wed, 15 Oct 2025 15:28:31 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78294aefca5sm2524027b3.36.2025.10.15.15.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 15:28:31 -0700 (PDT)
Date: Wed, 15 Oct 2025 18:28:29 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 24/49] repack: remove 'generated_pack' API from the builtin
Message-ID: <69003f45612ca282f18ca5ad70768bae5fd60fa0.1760567210.git.me@ttaylorr.com>
References: <cover.1759097191.git.me@ttaylorr.com>
 <cover.1760567210.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1760567210.git.me@ttaylorr.com>

Now that we have factored the "generated_pack" API, we can move it to
repack.ch, further slimming down builtin/repack.c.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 83 ------------------------------------------------
 repack.c         | 83 ++++++++++++++++++++++++++++++++++++++++++++++++
 repack.h         |  8 +++++
 3 files changed, 91 insertions(+), 83 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 966db27613..0e11c3b2c9 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -134,89 +134,6 @@ static int write_oid(const struct object_id *oid,
 	return 0;
 }
 
-static struct {
-	const char *name;
-	unsigned optional:1;
-} exts[] = {
-	{".pack"},
-	{".rev", 1},
-	{".mtimes", 1},
-	{".bitmap", 1},
-	{".promisor", 1},
-	{".idx"},
-};
-
-struct generated_pack {
-	struct tempfile *tempfiles[ARRAY_SIZE(exts)];
-};
-
-static struct generated_pack *generated_pack_populate(const char *name,
-						      const char *packtmp)
-{
-	struct stat statbuf;
-	struct strbuf path = STRBUF_INIT;
-	struct generated_pack *pack = xcalloc(1, sizeof(*pack));
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(exts); i++) {
-		strbuf_reset(&path);
-		strbuf_addf(&path, "%s-%s%s", packtmp, name, exts[i].name);
-
-		if (stat(path.buf, &statbuf))
-			continue;
-
-		pack->tempfiles[i] = register_tempfile(path.buf);
-	}
-
-	strbuf_release(&path);
-	return pack;
-}
-
-static int generated_pack_has_ext(const struct generated_pack *pack,
-				  const char *ext)
-{
-	int i;
-	for (i = 0; i < ARRAY_SIZE(exts); i++) {
-		if (strcmp(exts[i].name, ext))
-			continue;
-		return !!pack->tempfiles[i];
-	}
-	BUG("unknown pack extension: '%s'", ext);
-}
-
-static void generated_pack_install(struct generated_pack *pack,
-				   const char *name,
-				   const char *packdir, const char *packtmp)
-{
-	int ext;
-	for (ext = 0; ext < ARRAY_SIZE(exts); ext++) {
-		char *fname;
-
-		fname = mkpathdup("%s/pack-%s%s", packdir, name,
-				  exts[ext].name);
-
-		if (pack->tempfiles[ext]) {
-			const char *fname_old = get_tempfile_path(pack->tempfiles[ext]);
-			struct stat statbuffer;
-
-			if (!stat(fname_old, &statbuffer)) {
-				statbuffer.st_mode &= ~(S_IWUSR | S_IWGRP | S_IWOTH);
-				chmod(fname_old, statbuffer.st_mode);
-			}
-
-			if (rename_tempfile(&pack->tempfiles[ext], fname))
-				die_errno(_("renaming pack to '%s' failed"),
-					  fname);
-		} else if (!exts[ext].optional)
-			die(_("pack-objects did not write a '%s' file for pack %s-%s"),
-			    exts[ext].name, packtmp, name);
-		else if (unlink(fname) < 0 && errno != ENOENT)
-			die_errno(_("could not unlink: %s"), fname);
-
-		free(fname);
-	}
-}
-
 static void repack_promisor_objects(struct repository *repo,
 				    const struct pack_objects_args *args,
 				    struct string_list *names)
diff --git a/repack.c b/repack.c
index 9182e1c50b..d8afdd352d 100644
--- a/repack.c
+++ b/repack.c
@@ -3,9 +3,11 @@
 #include "midx.h"
 #include "odb.h"
 #include "packfile.h"
+#include "path.h"
 #include "repack.h"
 #include "repository.h"
 #include "run-command.h"
+#include "tempfile.h"
 
 void prepare_pack_objects(struct child_process *cmd,
 			  const struct pack_objects_args *args,
@@ -219,3 +221,84 @@ void existing_packs_release(struct existing_packs *existing)
 	string_list_clear(&existing->non_kept_packs, 0);
 	string_list_clear(&existing->cruft_packs, 0);
 }
+
+static struct {
+	const char *name;
+	unsigned optional:1;
+} exts[] = {
+	{".pack"},
+	{".rev", 1},
+	{".mtimes", 1},
+	{".bitmap", 1},
+	{".promisor", 1},
+	{".idx"},
+};
+
+struct generated_pack {
+	struct tempfile *tempfiles[ARRAY_SIZE(exts)];
+};
+
+struct generated_pack *generated_pack_populate(const char *name,
+					       const char *packtmp)
+{
+	struct stat statbuf;
+	struct strbuf path = STRBUF_INIT;
+	struct generated_pack *pack = xcalloc(1, sizeof(*pack));
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(exts); i++) {
+		strbuf_reset(&path);
+		strbuf_addf(&path, "%s-%s%s", packtmp, name, exts[i].name);
+
+		if (stat(path.buf, &statbuf))
+			continue;
+
+		pack->tempfiles[i] = register_tempfile(path.buf);
+	}
+
+	strbuf_release(&path);
+	return pack;
+}
+
+int generated_pack_has_ext(const struct generated_pack *pack, const char *ext)
+{
+	size_t i;
+	for (i = 0; i < ARRAY_SIZE(exts); i++) {
+		if (strcmp(exts[i].name, ext))
+			continue;
+		return !!pack->tempfiles[i];
+	}
+	BUG("unknown pack extension: '%s'", ext);
+}
+
+void generated_pack_install(struct generated_pack *pack, const char *name,
+			    const char *packdir, const char *packtmp)
+{
+	size_t ext;
+	for (ext = 0; ext < ARRAY_SIZE(exts); ext++) {
+		char *fname;
+
+		fname = mkpathdup("%s/pack-%s%s", packdir, name,
+				  exts[ext].name);
+
+		if (pack->tempfiles[ext]) {
+			const char *fname_old = get_tempfile_path(pack->tempfiles[ext]);
+			struct stat statbuffer;
+
+			if (!stat(fname_old, &statbuffer)) {
+				statbuffer.st_mode &= ~(S_IWUSR | S_IWGRP | S_IWOTH);
+				chmod(fname_old, statbuffer.st_mode);
+			}
+
+			if (rename_tempfile(&pack->tempfiles[ext], fname))
+				die_errno(_("renaming pack to '%s' failed"),
+					  fname);
+		} else if (!exts[ext].optional)
+			die(_("pack-objects did not write a '%s' file for pack %s-%s"),
+			    exts[ext].name, packtmp, name);
+		else if (unlink(fname) < 0 && errno != ENOENT)
+			die_errno(_("could not unlink: %s"), fname);
+
+		free(fname);
+	}
+}
diff --git a/repack.h b/repack.h
index 19796e2243..f37eb49524 100644
--- a/repack.h
+++ b/repack.h
@@ -66,4 +66,12 @@ void existing_packs_remove_redundant(struct existing_packs *existing,
 				     const char *packdir);
 void existing_packs_release(struct existing_packs *existing);
 
+struct generated_pack;
+
+struct generated_pack *generated_pack_populate(const char *name,
+					       const char *packtmp);
+int generated_pack_has_ext(const struct generated_pack *pack, const char *ext);
+void generated_pack_install(struct generated_pack *pack, const char *name,
+			    const char *packdir, const char *packtmp);
+
 #endif /* REPACK_H */
-- 
2.51.0.540.ga7423965ad8

