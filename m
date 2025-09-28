Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43353299959
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 22:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759097309; cv=none; b=blaLP/DE9JoTYPlWyBnow24B+F8bPAxgZD/CujJTNjIloS9dDSz1Hbn1eav9BVCNfR98Mwrm5gYjmQaL7gpkrkfca3DdAS3jbV3mgdIItGIgFelPbRhadXxP5AwApSIl7bpwF/fyN8JkAkq7oZylvWWA+Fur/AVwp4tITMxqfAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759097309; c=relaxed/simple;
	bh=YXSPK0KCsJcJpBpYSmnNO2ah8rGIEsVZpFRhVlqSoNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SSv4RLIK1I1RjgKF3nm+SrylnbVMRE5M9r+WuR5W2nCy/q8pvLE/N7d6dnPlmxOrFDNKoTqRrO4VwHe/yjb25GlnRljv+zS+JHkGp9cG1xmnn3edNtdYsMkEFX/oDkjk7X/iKSJWt20QC7y0pM+nJH2asHqNFNBNi5kfIxuwg6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=T1RdDQsI; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="T1RdDQsI"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-72ce9790aceso39445927b3.3
        for <git@vger.kernel.org>; Sun, 28 Sep 2025 15:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759097306; x=1759702106; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rZp1euKO/Tolx3jXf4Gwd0gTrYHTwAk5jfvHyFLIfIY=;
        b=T1RdDQsIu9dpiosbcqQWVFTy6TAHsH8UC1PQYUEJAueOuxI5sOnd3reJf3wSXPuC6q
         tLePLDveNFNnJ9xJH/4RfEnwJ7NQwCuNGCEiET5gMHAIwlwzMsherd3CyZiUFwAXmqEn
         TCvJJHkoQ8QJghDGQ7DKpaEVFBsTUSLMmD5UaxCJR4EyeP9VwYCM1Ww4Xh2NElHihhwc
         42sufsgWMQoGQ9uPD5Nn4l1DErP8MeHnjLQvSexqlXEnP0nkq7fV0h4YbM+WHZG1sHW0
         lyzZ/vNKLEOgAGISJaRmHRuqnuMlw9cBcDUYNCDK/ZA8I0QuXX6iBykaYSGlNzhohLu5
         OZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759097306; x=1759702106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZp1euKO/Tolx3jXf4Gwd0gTrYHTwAk5jfvHyFLIfIY=;
        b=INxvkhEc0tj8dYg/Nd5CYs1Rp6PZhTA56mf/sE0Ra0HjX17VP10NNR7UVPn/astoZu
         8qbQ3sLMu+d+mRpqALiPDOcT06g33/jdSIXiHtRqGfV+msJnlWzoJ4722CzujIfsKjz4
         YGaYVOwcIq3FlYVwaAfFbph7bEZhshXIM+nO92epLfJItvxK/wo2uNgK3Lk0yIXKdW2o
         yRjEU/WbFbVrLWPTPSSvss/SdO7GAFrNur9SMSZ4/rr88ptju3JteSzfBWKCQUZpgz/W
         wxMjkgZBwFJTqxKXSt1e6Pe9STkS5pHl5aQOfFflPsfhKBp9niseeSk9TnI+WgVrYucY
         YeWQ==
X-Gm-Message-State: AOJu0YxumCHxpDsfLmyqnnfzY1/Pn+qI4jvbeaS0Ym7rzLjB0/fmhWVS
	YKhIRW4RQEyYwdmlPOfyXM40s5oTNPXAnbEqOW/9eDgQOFufHw50YYkh7H86zKXHN/lK3q1AT/4
	gFKl1h68=
X-Gm-Gg: ASbGncuOKPq8bH4Y9oew+SZkPLSwpnD1k7phFB/BL1WaXSauuGz6vZc4SMxKrh5fkqB
	wvEtuw/nIGuIzXtAnge9oSgUv8o3YvZeUu2aE5HBPQti9WRj489ii+BjZimJA73r0G3NlcHdxg0
	0CNIAN4PIU5Je+0ZXMWVVc7LO/yX9SrxlE4wmzuEeL1SzBuRY2F5cUNEMuBJLZqW8ZLkQbwnhlz
	uD6+elcixIRoyApqquXo39cxEDihBhViYxCYjaF2yiH7TSNp61Fxw8pC+pqoobj/co4XzylM1NI
	q/SWCaa8U5ER2e4J8zCV7bwtgukZuqCo9V7HQxJ9buvJSJI4tC0NCy63fZEhMZSXxTimQB5Q6bM
	tY4rzpJH1N8YeoEdZ/kf7K9nwmVEk5pcSymGOEgR68ymTuKZP4tqxge0ztre2Sl0oGeaLqpcqFL
	9oNTqB3sx9ofKQ6Obj+K/2D5SgVA==
X-Google-Smtp-Source: AGHT+IETaqufPlKoK5Y+/9jcmvIxA2zh0zv+zuyPrhJwmXxLD7BBdI61yM2xWwVYgiWVQPrdH7ayGw==
X-Received: by 2002:a05:690c:2702:b0:720:58fd:6433 with SMTP id 00721157ae682-76403423b94mr154271317b3.35.1759097306107;
        Sun, 28 Sep 2025 15:08:26 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-637d39f36a7sm912948d50.1.2025.09.28.15.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 15:08:25 -0700 (PDT)
Date: Sun, 28 Sep 2025 18:08:23 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 19/49] repack: remove 'existing_packs' API from the builtin
Message-ID: <ae267fcc820dc19497f9f897bc5915b2040739e5.1759097191.git.me@ttaylorr.com>
References: <cover.1759097191.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1759097191.git.me@ttaylorr.com>

The repack builtin defines an API for keeping track of which packs
were found in the repository at the beginning of the repack operation.
This is used to classify what state a pack was in (kept, non-kept, or
cruft), and is also used to mark which packs to delete (or keep) at the
end of a repack operation.

Now that the prerequisite refactoring is complete, this API is isolated
enough that it can be moved out to repack.ch and removed from the
builtin entirely.

As a result, some of its functions become static within repack.c,
cleaning up the visible API.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 173 -----------------------------------------------
 repack.c         | 157 ++++++++++++++++++++++++++++++++++++++++++
 repack.h         |  35 ++++++++++
 3 files changed, 192 insertions(+), 173 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index e13943b637..a168c88791 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -3,7 +3,6 @@
 
 #include "builtin.h"
 #include "config.h"
-#include "dir.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
@@ -108,178 +107,6 @@ static int repack_config(const char *var, const char *value,
 	return git_default_config(var, value, ctx, cb);
 }
 
-struct existing_packs {
-	struct repository *repo;
-	struct string_list kept_packs;
-	struct string_list non_kept_packs;
-	struct string_list cruft_packs;
-};
-
-#define EXISTING_PACKS_INIT { \
-	.kept_packs = STRING_LIST_INIT_DUP, \
-	.non_kept_packs = STRING_LIST_INIT_DUP, \
-	.cruft_packs = STRING_LIST_INIT_DUP, \
-}
-
-static int existing_packs_has_non_kept(const struct existing_packs *existing)
-{
-	return existing->non_kept_packs.nr || existing->cruft_packs.nr;
-}
-
-static void existing_pack_mark_for_deletion(struct string_list_item *item)
-{
-	item->util = (void*)((uintptr_t)item->util | DELETE_PACK);
-}
-
-static void existing_pack_unmark_for_deletion(struct string_list_item *item)
-{
-	item->util = (void*)((uintptr_t)item->util & ~DELETE_PACK);
-}
-
-static int existing_pack_is_marked_for_deletion(struct string_list_item *item)
-{
-	return (uintptr_t)item->util & DELETE_PACK;
-}
-
-static void existing_packs_mark_retained(struct string_list_item *item)
-{
-	item->util = (void*)((uintptr_t)item->util | RETAIN_PACK);
-}
-
-static int existing_pack_is_retained(struct string_list_item *item)
-{
-	return (uintptr_t)item->util & RETAIN_PACK;
-}
-
-static void existing_packs_mark_for_deletion_1(const struct git_hash_algo *algop,
-					       struct string_list *names,
-					       struct string_list *list)
-{
-	struct string_list_item *item;
-	const size_t hexsz = algop->hexsz;
-
-	for_each_string_list_item(item, list) {
-		char *sha1;
-		size_t len = strlen(item->string);
-		if (len < hexsz)
-			continue;
-		sha1 = item->string + len - hexsz;
-
-		if (existing_pack_is_retained(item)) {
-			existing_pack_unmark_for_deletion(item);
-		} else if (!string_list_has_string(names, sha1)) {
-			/*
-			 * Mark this pack for deletion, which ensures
-			 * that this pack won't be included in a MIDX
-			 * (if `--write-midx` was given) and that we
-			 * will actually delete this pack (if `-d` was
-			 * given).
-			 */
-			existing_pack_mark_for_deletion(item);
-		}
-	}
-}
-
-static void existing_packs_retain_cruft(struct existing_packs *existing,
-					struct packed_git *cruft)
-{
-	struct strbuf buf = STRBUF_INIT;
-	struct string_list_item *item;
-
-	strbuf_addstr(&buf, pack_basename(cruft));
-	strbuf_strip_suffix(&buf, ".pack");
-
-	item = string_list_lookup(&existing->cruft_packs, buf.buf);
-	if (!item)
-		BUG("could not find cruft pack '%s'", pack_basename(cruft));
-
-	existing_packs_mark_retained(item);
-	strbuf_release(&buf);
-}
-
-static void existing_packs_mark_for_deletion(struct existing_packs *existing,
-					     struct string_list *names)
-
-{
-	const struct git_hash_algo *algop = existing->repo->hash_algo;
-	existing_packs_mark_for_deletion_1(algop, names,
-					   &existing->non_kept_packs);
-	existing_packs_mark_for_deletion_1(algop, names,
-					   &existing->cruft_packs);
-}
-
-static void remove_redundant_packs_1(struct repository *repo,
-				     struct string_list *packs,
-				     const char *packdir)
-{
-	struct string_list_item *item;
-	for_each_string_list_item(item, packs) {
-		if (!existing_pack_is_marked_for_deletion(item))
-			continue;
-		repack_remove_redundant_pack(repo, packdir, item->string);
-	}
-}
-
-static void existing_packs_remove_redundant(struct existing_packs *existing,
-					    const char *packdir)
-{
-	remove_redundant_packs_1(existing->repo, &existing->non_kept_packs,
-				 packdir);
-	remove_redundant_packs_1(existing->repo, &existing->cruft_packs,
-				 packdir);
-}
-
-static void existing_packs_release(struct existing_packs *existing)
-{
-	string_list_clear(&existing->kept_packs, 0);
-	string_list_clear(&existing->non_kept_packs, 0);
-	string_list_clear(&existing->cruft_packs, 0);
-}
-
-/*
- * Adds all packs hex strings (pack-$HASH) to either packs->non_kept
- * or packs->kept based on whether each pack has a corresponding
- * .keep file or not.  Packs without a .keep file are not to be kept
- * if we are going to pack everything into one file.
- */
-static void existing_packs_collect(struct existing_packs *existing,
-				   const struct string_list *extra_keep)
-{
-	struct packfile_store *packs = existing->repo->objects->packfiles;
-	struct packed_git *p;
-	struct strbuf buf = STRBUF_INIT;
-
-	for (p = packfile_store_get_all_packs(packs); p; p = p->next) {
-		size_t i;
-		const char *base;
-
-		if (!p->pack_local)
-			continue;
-
-		base = pack_basename(p);
-
-		for (i = 0; i < extra_keep->nr; i++)
-			if (!fspathcmp(base, extra_keep->items[i].string))
-				break;
-
-		strbuf_reset(&buf);
-		strbuf_addstr(&buf, base);
-		strbuf_strip_suffix(&buf, ".pack");
-
-		if ((extra_keep->nr > 0 && i < extra_keep->nr) || p->pack_keep)
-			string_list_append(&existing->kept_packs, buf.buf);
-		else if (p->is_cruft)
-			string_list_append(&existing->cruft_packs, buf.buf);
-		else
-			string_list_append(&existing->non_kept_packs, buf.buf);
-	}
-
-	string_list_sort(&existing->kept_packs);
-	string_list_sort(&existing->non_kept_packs);
-	string_list_sort(&existing->cruft_packs);
-	strbuf_release(&buf);
-}
-
 struct write_oid_context {
 	struct child_process *cmd;
 	const struct git_hash_algo *algop;
diff --git a/repack.c b/repack.c
index 3aaa351b5b..9182e1c50b 100644
--- a/repack.c
+++ b/repack.c
@@ -1,4 +1,5 @@
 #include "git-compat-util.h"
+#include "dir.h"
 #include "midx.h"
 #include "odb.h"
 #include "packfile.h"
@@ -62,3 +63,159 @@ void repack_remove_redundant_pack(struct repository *repo, const char *dir_name,
 	unlink_pack_path(buf.buf, 1);
 	strbuf_release(&buf);
 }
+
+#define DELETE_PACK 1
+#define RETAIN_PACK 2
+
+void existing_packs_collect(struct existing_packs *existing,
+			    const struct string_list *extra_keep)
+{
+	struct packfile_store *packs = existing->repo->objects->packfiles;
+	struct packed_git *p;
+	struct strbuf buf = STRBUF_INIT;
+
+	for (p = packfile_store_get_all_packs(packs); p; p = p->next) {
+		size_t i;
+		const char *base;
+
+		if (!p->pack_local)
+			continue;
+
+		base = pack_basename(p);
+
+		for (i = 0; i < extra_keep->nr; i++)
+			if (!fspathcmp(base, extra_keep->items[i].string))
+				break;
+
+		strbuf_reset(&buf);
+		strbuf_addstr(&buf, base);
+		strbuf_strip_suffix(&buf, ".pack");
+
+		if ((extra_keep->nr > 0 && i < extra_keep->nr) || p->pack_keep)
+			string_list_append(&existing->kept_packs, buf.buf);
+		else if (p->is_cruft)
+			string_list_append(&existing->cruft_packs, buf.buf);
+		else
+			string_list_append(&existing->non_kept_packs, buf.buf);
+	}
+
+	string_list_sort(&existing->kept_packs);
+	string_list_sort(&existing->non_kept_packs);
+	string_list_sort(&existing->cruft_packs);
+	strbuf_release(&buf);
+}
+
+int existing_packs_has_non_kept(const struct existing_packs *existing)
+{
+	return existing->non_kept_packs.nr || existing->cruft_packs.nr;
+}
+
+static void existing_pack_mark_for_deletion(struct string_list_item *item)
+{
+	item->util = (void*)((uintptr_t)item->util | DELETE_PACK);
+}
+
+static void existing_pack_unmark_for_deletion(struct string_list_item *item)
+{
+	item->util = (void*)((uintptr_t)item->util & ~DELETE_PACK);
+}
+
+int existing_pack_is_marked_for_deletion(struct string_list_item *item)
+{
+	return (uintptr_t)item->util & DELETE_PACK;
+}
+
+static void existing_packs_mark_retained(struct string_list_item *item)
+{
+	item->util = (void*)((uintptr_t)item->util | RETAIN_PACK);
+}
+
+static int existing_pack_is_retained(struct string_list_item *item)
+{
+	return (uintptr_t)item->util & RETAIN_PACK;
+}
+
+static void existing_packs_mark_for_deletion_1(const struct git_hash_algo *algop,
+					       struct string_list *names,
+					       struct string_list *list)
+{
+	struct string_list_item *item;
+	const size_t hexsz = algop->hexsz;
+
+	for_each_string_list_item(item, list) {
+		char *sha1;
+		size_t len = strlen(item->string);
+		if (len < hexsz)
+			continue;
+		sha1 = item->string + len - hexsz;
+
+		if (existing_pack_is_retained(item)) {
+			existing_pack_unmark_for_deletion(item);
+		} else if (!string_list_has_string(names, sha1)) {
+			/*
+			 * Mark this pack for deletion, which ensures
+			 * that this pack won't be included in a MIDX
+			 * (if `--write-midx` was given) and that we
+			 * will actually delete this pack (if `-d` was
+			 * given).
+			 */
+			existing_pack_mark_for_deletion(item);
+		}
+	}
+}
+
+void existing_packs_retain_cruft(struct existing_packs *existing,
+				 struct packed_git *cruft)
+{
+	struct strbuf buf = STRBUF_INIT;
+	struct string_list_item *item;
+
+	strbuf_addstr(&buf, pack_basename(cruft));
+	strbuf_strip_suffix(&buf, ".pack");
+
+	item = string_list_lookup(&existing->cruft_packs, buf.buf);
+	if (!item)
+		BUG("could not find cruft pack '%s'", pack_basename(cruft));
+
+	existing_packs_mark_retained(item);
+	strbuf_release(&buf);
+}
+
+void existing_packs_mark_for_deletion(struct existing_packs *existing,
+				      struct string_list *names)
+
+{
+	const struct git_hash_algo *algop = existing->repo->hash_algo;
+	existing_packs_mark_for_deletion_1(algop, names,
+					   &existing->non_kept_packs);
+	existing_packs_mark_for_deletion_1(algop, names,
+					   &existing->cruft_packs);
+}
+
+static void remove_redundant_packs_1(struct repository *repo,
+				     struct string_list *packs,
+				     const char *packdir)
+{
+	struct string_list_item *item;
+	for_each_string_list_item(item, packs) {
+		if (!existing_pack_is_marked_for_deletion(item))
+			continue;
+		repack_remove_redundant_pack(repo, packdir, item->string);
+	}
+}
+
+void existing_packs_remove_redundant(struct existing_packs *existing,
+				     const char *packdir)
+{
+	remove_redundant_packs_1(existing->repo, &existing->non_kept_packs,
+				 packdir);
+	remove_redundant_packs_1(existing->repo, &existing->cruft_packs,
+				 packdir);
+}
+
+void existing_packs_release(struct existing_packs *existing)
+{
+	string_list_clear(&existing->kept_packs, 0);
+	string_list_clear(&existing->non_kept_packs, 0);
+	string_list_clear(&existing->cruft_packs, 0);
+}
diff --git a/repack.h b/repack.h
index a62bfa2ff9..19796e2243 100644
--- a/repack.h
+++ b/repack.h
@@ -2,6 +2,7 @@
 #define REPACK_H
 
 #include "list-objects-filter-options.h"
+#include "string-list.h"
 
 struct pack_objects_args {
 	char *window;
@@ -31,4 +32,38 @@ void pack_objects_args_release(struct pack_objects_args *args);
 void repack_remove_redundant_pack(struct repository *repo, const char *dir_name,
 				  const char *base_name);
 
+struct repository;
+struct packed_git;
+
+struct existing_packs {
+	struct repository *repo;
+	struct string_list kept_packs;
+	struct string_list non_kept_packs;
+	struct string_list cruft_packs;
+};
+
+#define EXISTING_PACKS_INIT { \
+	.kept_packs = STRING_LIST_INIT_DUP, \
+	.non_kept_packs = STRING_LIST_INIT_DUP, \
+	.cruft_packs = STRING_LIST_INIT_DUP, \
+}
+
+/*
+ * Adds all packs hex strings (pack-$HASH) to either packs->non_kept
+ * or packs->kept based on whether each pack has a corresponding
+ * .keep file or not.  Packs without a .keep file are not to be kept
+ * if we are going to pack everything into one file.
+ */
+void existing_packs_collect(struct existing_packs *existing,
+			    const struct string_list *extra_keep);
+int existing_packs_has_non_kept(const struct existing_packs *existing);
+int existing_pack_is_marked_for_deletion(struct string_list_item *item);
+void existing_packs_retain_cruft(struct existing_packs *existing,
+				 struct packed_git *cruft);
+void existing_packs_mark_for_deletion(struct existing_packs *existing,
+				      struct string_list *names);
+void existing_packs_remove_redundant(struct existing_packs *existing,
+				     const char *packdir);
+void existing_packs_release(struct existing_packs *existing);
+
 #endif /* REPACK_H */
-- 
2.51.0.243.g16eca91f2c0

