Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52D530F928
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 22:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567334; cv=none; b=sHhPOTEiRRf/q36FUl9+JEG7rw+Ukb2FSRIsBnCUWC0BfIZE+zC2XAuN0lRHBZxGBzUrKIN4Ni6dtq4ByZzyg0YjSy5VkfogN4AbOZBV7OJ+eQPw7bEUZg03VKCAUApRQbgiTfP4uJ+2hkp6xAemLBKA9mjpSB8Xh9qgHWpkZ4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567334; c=relaxed/simple;
	bh=/LaOf8aIjhbwWHdNDvWe9mSJLfVrKLp+QXFFVZQ+Q2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B0DIwm26/bsk47MqZHGfHIY6BIOZJWanqvWuxHyi4KOCHKrie5Wo07zMfn+vjf+iMNAsjvttejrtYu813okGigim5443wkSqNCbZCNVg+rdueHb8BZzEcMJ4G52cfPTpOJn3I6Tu4EnckgsV10XowdAH1WkDPKH23i65CMkcAzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=J0cfUnDA; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="J0cfUnDA"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7815092cd06so928867b3.2
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 15:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760567332; x=1761172132; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6orxmPUgvDUPe3RaOomRGduAX9wxjNsBOYpWNsXPhZc=;
        b=J0cfUnDAfSWsRD7ivrc5oAfbi91OHKqpm24cBs7XwYMXs5pWcBkQI8llvAcihyIf7u
         d084AKYcPPoa1b3oTR369x+WK62SQ018Y+ng+0Q5tJvOtsyA6R0lnxcpfHaXrTm+2TVV
         ip/Yi0JAP4/Mq8JQAapTTVMydAbUMGwbtn7ilAp0FT3zVc38cYzL2+jGMzxnb2xbPvpz
         oK3c+XrSLC5c9YSkJDAb20szyb68y1rgTNEbJYles2NQJNzAicXXhDxTb5lf/087nkAn
         5lf0qBQQuyJcWfrcoK4jp/fOgQjufBfwkrCCmp3mRtnJUBFeJIylJgJWYmWZNxO42dsV
         zV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760567332; x=1761172132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6orxmPUgvDUPe3RaOomRGduAX9wxjNsBOYpWNsXPhZc=;
        b=a4pzPi6jikCBfh7876CwJsDAZj90R9dTcKeSXW+Jc0lctT1dK0vWbNIRhI1JkGDgKJ
         bIcJnu/Z6ZsfRIg4iFC5t/G/U3xelKFXgvMDh+HNLOmAqL3emH8a22M9V0nqDP5o2RV3
         S0AoQ23vuvLcICa2ZKBmevPOOI5r5PjUM4yu3dJ0baIB5zKCJR8sAy+Z9irMFkXxz0yA
         CUDZLSGWNltXI+7LmrDT13z5pYfdei0K4t24a4tYGm5ocoPNBgs/ROG7176boc9ZiS5o
         KSM+sGhsCfSrcNGZofFc7WWomMsDlt/4ftpg9HoW0fPHwxvRS2IlyzhEv9ov6kkRipEN
         Sudw==
X-Gm-Message-State: AOJu0YwCVRDt1wwMrIcvL0ELvBADxzJjVmiuJ/sCPbUGBTAb8L7154cF
	vlbbgJuP/IRuhcaNVyNQD7zKvP7jmk/u4npXCjZ92feSg8/dCOxhXS73hOIc4HmID9x105o+vIo
	BFL0umhHkcg==
X-Gm-Gg: ASbGnctjEOy44T2jcQTJz5PNgcT2uN31doul3m535NIFaXSRswT97cXKVrn0vcmguFX
	qFgeIGJbdJdBU8E5QwzXwEoc6801htvWgBL3pRNGO5ap/w5XQfFWaIz9lGD16Znb04KLMs4bwYs
	KVGcGzUoVdjD8IskedfN0ab+aHxHukQJgesN14D/om0PuNaIGVLwBZE6YaLRa7AZigIaKHyPwNh
	Y+0FtWiuaowUKRzEZ3w2wLDejZ7W7Zqb+bY2zXXm3OfZQJMK0fVHqVFsaCHZJsqhbH6eo0iPGTw
	Iea+J7ejJoY2B8hQPCexcCBbhCp1uIhLWfaliQxzF+gKuPii8Orj6N2ai+UDGzJ39drcEk2bCPz
	2Nk+/OmraFxkbPyKCId7YFNeguew/6dCjaK4Ex/TRziQFavi4V90inLHfrRzf533ukvjJogepHi
	PRG3mOxvdYIkF7g4smB71lc6pEvvbi1BgUexKp1srYyJa1APeoBdWQNBAkrZvowJfMGN1Mqrb/r
	YhTT0g=
X-Google-Smtp-Source: AGHT+IF57+Gm/3L3f+2L1sY3r/VdXdSUlAnviwegbpn3Y26+VpETMWTwRFfuxS1sxKxOY2gMOua/JA==
X-Received: by 2002:a53:de4d:0:b0:636:1fd9:1bd with SMTP id 956f58d0204a3-63ccb865448mr19789494d50.2.1760567331599;
        Wed, 15 Oct 2025 15:28:51 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-63cd9524284sm6021853d50.10.2025.10.15.15.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 15:28:51 -0700 (PDT)
Date: Wed, 15 Oct 2025 18:28:50 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 31/49] builtin/repack.c: remove ref snapshotting from
 builtin
Message-ID: <5b15d83e65b1de52cfa4fad6f39ca707aae72da6.1760567210.git.me@ttaylorr.com>
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

When writing a MIDX, 'git repack' takes a snapshot of the repository's
references and writes the result out to a file, which it then passes to
'git multi-pack-index write' via the '--refs-snapshot'.

This is done in order to make bitmap selections with respect to what we
are packing, thus avoiding a race where an incoming reference update
causes us to try and write a bitmap for a commit not present in the
MIDX.

Extract this functionality out into a new repack-midx.c compilation
unit, and expose the necessary functions via the repack.h API.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Makefile         |  1 +
 builtin/repack.c | 68 ------------------------------------------
 meson.build      |  1 +
 repack-midx.c    | 77 ++++++++++++++++++++++++++++++++++++++++++++++++
 repack.h         |  4 +++
 5 files changed, 83 insertions(+), 68 deletions(-)
 create mode 100644 repack-midx.c

diff --git a/Makefile b/Makefile
index a1ccac235d..4b0a122428 100644
--- a/Makefile
+++ b/Makefile
@@ -1251,6 +1251,7 @@ LIB_OBJS += refspec.o
 LIB_OBJS += remote.o
 LIB_OBJS += repack.o
 LIB_OBJS += repack-geometry.o
+LIB_OBJS += repack-midx.o
 LIB_OBJS += repack-promisor.o
 LIB_OBJS += replace-object.o
 LIB_OBJS += repo-settings.o
diff --git a/builtin/repack.c b/builtin/repack.c
index e2313c80c3..7713721826 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -178,74 +178,6 @@ static int midx_has_unknown_packs(char **midx_pack_names,
 	return 0;
 }
 
-struct midx_snapshot_ref_data {
-	struct repository *repo;
-	struct tempfile *f;
-	struct oidset seen;
-	int preferred;
-};
-
-static int midx_snapshot_ref_one(const char *refname UNUSED,
-				 const char *referent UNUSED,
-				 const struct object_id *oid,
-				 int flag UNUSED, void *_data)
-{
-	struct midx_snapshot_ref_data *data = _data;
-	struct object_id peeled;
-
-	if (!peel_iterated_oid(data->repo, oid, &peeled))
-		oid = &peeled;
-
-	if (oidset_insert(&data->seen, oid))
-		return 0; /* already seen */
-
-	if (odb_read_object_info(data->repo->objects, oid, NULL) != OBJ_COMMIT)
-		return 0;
-
-	fprintf(data->f->fp, "%s%s\n", data->preferred ? "+" : "",
-		oid_to_hex(oid));
-
-	return 0;
-}
-
-static void midx_snapshot_refs(struct repository *repo, struct tempfile *f)
-{
-	struct midx_snapshot_ref_data data;
-	const struct string_list *preferred = bitmap_preferred_tips(repo);
-
-	data.repo = repo;
-	data.f = f;
-	data.preferred = 0;
-	oidset_init(&data.seen, 0);
-
-	if (!fdopen_tempfile(f, "w"))
-		 die(_("could not open tempfile %s for writing"),
-		     get_tempfile_path(f));
-
-	if (preferred) {
-		struct string_list_item *item;
-
-		data.preferred = 1;
-		for_each_string_list_item(item, preferred)
-			refs_for_each_ref_in(get_main_ref_store(repo),
-					     item->string,
-					     midx_snapshot_ref_one, &data);
-		data.preferred = 0;
-	}
-
-	refs_for_each_ref(get_main_ref_store(repo),
-			  midx_snapshot_ref_one, &data);
-
-	if (close_tempfile_gently(f)) {
-		int save_errno = errno;
-		delete_tempfile(&f);
-		errno = save_errno;
-		die_errno(_("could not close refs snapshot tempfile"));
-	}
-
-	oidset_clear(&data.seen);
-}
-
 static void midx_included_packs(struct string_list *include,
 				struct existing_packs *existing,
 				char **midx_pack_names,
diff --git a/meson.build b/meson.build
index 9afd45ea45..0373d5c454 100644
--- a/meson.build
+++ b/meson.build
@@ -464,6 +464,7 @@ libgit_sources = [
   'remote.c',
   'repack.c',
   'repack-geometry.c',
+  'repack-midx.c',
   'repack-promisor.c',
   'replace-object.c',
   'repo-settings.c',
diff --git a/repack-midx.c b/repack-midx.c
new file mode 100644
index 0000000000..354df729a5
--- /dev/null
+++ b/repack-midx.c
@@ -0,0 +1,77 @@
+#include "git-compat-util.h"
+#include "repack.h"
+#include "hash.h"
+#include "hex.h"
+#include "odb.h"
+#include "oidset.h"
+#include "pack-bitmap.h"
+#include "refs.h"
+#include "tempfile.h"
+
+struct midx_snapshot_ref_data {
+	struct repository *repo;
+	struct tempfile *f;
+	struct oidset seen;
+	int preferred;
+};
+
+static int midx_snapshot_ref_one(const char *refname UNUSED,
+				 const char *referent UNUSED,
+				 const struct object_id *oid,
+				 int flag UNUSED, void *_data)
+{
+	struct midx_snapshot_ref_data *data = _data;
+	struct object_id peeled;
+
+	if (!peel_iterated_oid(data->repo, oid, &peeled))
+		oid = &peeled;
+
+	if (oidset_insert(&data->seen, oid))
+		return 0; /* already seen */
+
+	if (odb_read_object_info(data->repo->objects, oid, NULL) != OBJ_COMMIT)
+		return 0;
+
+	fprintf(data->f->fp, "%s%s\n", data->preferred ? "+" : "",
+		oid_to_hex(oid));
+
+	return 0;
+}
+
+void midx_snapshot_refs(struct repository *repo, struct tempfile *f)
+{
+	struct midx_snapshot_ref_data data;
+	const struct string_list *preferred = bitmap_preferred_tips(repo);
+
+	data.repo = repo;
+	data.f = f;
+	data.preferred = 0;
+	oidset_init(&data.seen, 0);
+
+	if (!fdopen_tempfile(f, "w"))
+		 die(_("could not open tempfile %s for writing"),
+		     get_tempfile_path(f));
+
+	if (preferred) {
+		struct string_list_item *item;
+
+		data.preferred = 1;
+		for_each_string_list_item(item, preferred)
+			refs_for_each_ref_in(get_main_ref_store(repo),
+					     item->string,
+					     midx_snapshot_ref_one, &data);
+		data.preferred = 0;
+	}
+
+	refs_for_each_ref(get_main_ref_store(repo),
+			  midx_snapshot_ref_one, &data);
+
+	if (close_tempfile_gently(f)) {
+		int save_errno = errno;
+		delete_tempfile(&f);
+		errno = save_errno;
+		die_errno(_("could not close refs snapshot tempfile"));
+	}
+
+	oidset_clear(&data.seen);
+}
diff --git a/repack.h b/repack.h
index cea7969ae4..803e129224 100644
--- a/repack.h
+++ b/repack.h
@@ -98,4 +98,8 @@ void pack_geometry_remove_redundant(struct pack_geometry *geometry,
 				    const char *packdir);
 void pack_geometry_release(struct pack_geometry *geometry);
 
+struct tempfile;
+
+void midx_snapshot_refs(struct repository *repo, struct tempfile *f);
+
 #endif /* REPACK_H */
-- 
2.51.0.540.ga7423965ad8

