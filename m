Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795644186;
	b=M9fvTkL3K4F5ZWri112o1P3fEXxhgtxGVAKtT6WSN267Q0lCq/4+VwMwa69+6a5DCdIb
	 F8v93U66+tUqsZ8Bn4VbrRmOzUqQ3Pt5vdZV4xONWM8JhfH7Tm3W5w9DRCxSENxu+8NpL
	 y0p8msFIED9W8xMwhhbOSreZsO/aHkz5oiaQ9KdDsVGyRXEDT2rosE3pPv/f6ePBE85vI
	 L6RHXAUCuAoemDfwP+P+lzYKkoOVzvgpQ2Hce78vnpp1pupKBjWU9WESAPP+a/9+VODLe
	 Z5mPd4WKR3+Iidg6bJ93W5QjXSO6AlUvb0LDOSZ/AK4LaPbALvP4lAh8ZxvNjaIGFgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795644186;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=k2PEMUormEjGD5YRY8k4J8gwbBReidjiqrhQUhyzUWI=;
	b=A+wI7XGn9/wrR2Bn6bp9Hnb1pEYStAbR/uYvG/SiAJs+Jnkjl0m1j0/lh2BkI5jqjcVT
	 xVdpXMStVmxjjn7zavOm4wR67T84+YRxGFifNBD42xqmusNnS3egtAyLQK87YSQ9O/79N
	 QHT9xLQovMtdcXLaue7QcmAGqoZ0r0zOSoA3nRiPZrDER59BI7ZZRru4ZUPAZ/em1BDBK
	 lSspeCh/bR+xdKGM/387GvHw1XhEPx8Xs0P8kEF0RXgQP7olF1qbi9lhDmDJqPcgoe+wB
	 xbi1SGpkSXiLQcN8ttFdHKvGpR5ZDnk/idwCM9za37NOZvjEl27/onbQjXjM6OY6ubg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TWV9qwgV;
	arc=none smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05088606A31E
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 22:03:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05088606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TWV9qwgV
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c5126505cb3so821829066b.0
        for <git@vger.kernel.org>; Wed, 25 Nov 2026 14:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795644184; x=1796248984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k2PEMUormEjGD5YRY8k4J8gwbBReidjiqrhQUhyzUWI=;
        b=TWV9qwgV7rx8FkUo70L/zd+xxocDqGe31ENzBVT/LOzr3aduYcujW1IUUMggcBuG4v
         eZ206LdppScQmgXXIogVgjGaBJvUmz+vKcGI1v/8sB3u49h7F5QnzUbZYubQWTeelvkC
         7eXK9PtDIq17OQxxaFcxL0X/omCcHO4W3/LZqk/7r4vXm5Ekp8TlgIny/tqzOsqtIP28
         ZDmGzVivDik4xM7/CUOniy5eBSQ3jNcVibTSfJatZw5M5c9L3gDUeW5FOOhY4fTbgsiY
         6lUmzp3Ay7LrGV0x/oEoRuLWE23uep9GjlhjAtv0HVxDeY0kZFBtvsixHRjykGYTDKjA
         GJjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795644184; x=1796248984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=k2PEMUormEjGD5YRY8k4J8gwbBReidjiqrhQUhyzUWI=;
        b=W8uGMYJBiimcQMIgkasP4zSRKoAp3AJfteIbnC/+wUvTCwCGMzBpXonfp965ks2qBR
         dTuLk8w+Bb9lqzMezCQtj4omChVQ7DOeul1yei/++SLQMZllWitbB+KtFABuNjETJZQ3
         QweSeOQpfxTPxC1uRBhJZXJQ+f2EBN3BpXqKkxF+YusIROCMWIP8qbZVCyCiOxzCGCEH
         4j7n8Q3oYi1GhNgXBA2yF03rD8YzrzK+PBntOAF3NMTXUH4lS4yoUVEUt+E7V7WYZY7x
         bZFFuI6JIg2340mLfHlymGacjesdy4Kpx9waE3AL9cbEKdJljQa7VFH6LtvmroqChHRb
         2R3w==
X-Gm-Message-State: APuU4Z/QxrKJahPZ0dJzyiIs/v3kqNdZvs1Bp6K8YmMWBr3GdTtYiqdB
	kLUiUbto9oVgkA5K0CFhfOQab2xsZJ6lw6cQ2fH0wkUTdmgEi/XduEI1Q+SOW6tkNzA=
X-Gm-Gg: AZFdTZc969+K6fY0rBhZDodqXA0sDJxH8ls3Ku37esTwo7lSXkhcuXIeHrV9l4ApeyN
	NjH6YE/2H6zsjjtqgIxCXbebLtJX6tCoZeoVyt++1YYoOR8kkNXXBlciDp0pMUgVmMKxJD1rG69
	GyjAJWlOagpazUUAJBkcqzLA85Th1dkktvWslj84Suag/RDIpXjR46KpiEOpAuEvgQXVqxppGFp
	E57F8xTQZH1hC3ixWvqoq2az0/e/hK4sw9qYY88EMhpgxweQS9CsfN6wOAXkqb7xu9893C9FUz7
	IUq+76pK9MPn4aOmM5FSLLrPtolfWs1FoFK9L9nvpn3Kb1Py9onHmrauQa15UHNVNRt9Q1BPfCV
	YEm6vJjAXvVx5uyZlrypzBXDSHhM0UH7cuCb2iz4wZ4OP0GkU0oBtre1RRK6PfUUaVRcu8fyXTH
	4F/IGkroL8X5mDHXv/2huWNkGEHop2XOQb3HxjZgWyA7N52ytw2uNqqYbk8ebCq8CBbbfmwT/lI
	wdTvaJ9wChMzG4lX47OeICgvKZYicQgpixBarmGFLuy7VAuW3izNitYI8om+82ALrZnA2XTDU7n
	w5/zaV7iYiTDjddjdSDjne0RG8OoYBruESBYTeYKxOd+1782HyAiOw9DPd2PlV6eqIQFxThHE0Z
	lsQYO9Tc/xxY4ahH6CEoTGus79uz1BwyZspDAiMnFSjG4zNQiu8jJDC6Kds7pn48VQJN/JySONJ
	XwuAkIQlTCY306Omhhq1/QBeX+FILS
X-Received: by 2002:a17:906:3b04:b0:c29:3c97:c994 with SMTP id a640c23a62f3a-c513ab47f35mr1226084966b.35.1795644184222;
        Wed, 25 Nov 2026 14:03:04 -0800 (PST)
Received: from localhost.localdomain ([104.28.251.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513aec3c60sm676998366b.50.2026.11.25.14.03.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Nov 2026 14:03:03 -0800 (PST)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	ps@pks.im,
	gitster@pobox.com,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	okhuomonajayi54@gmail.com
Subject: [PATCH v5 5/6] notes: pass the repository to the ref glob helpers
Date: Wed, 25 Nov 2026 23:02:13 +0100
Message-ID: <20261125220214.35881-6-okhuomonajayi54@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261125220214.35881-1-okhuomonajayi54@gmail.com>
References: <20261124172146.18330-1-okhuomonajayi54@gmail.com>
 <20261125220214.35881-1-okhuomonajayi54@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

string_list_add_refs_by_glob() and
string_list_add_refs_from_colon_sep() walk refs in
the_repository. The caller already knows which repository
that is.

Take the repository as their first argument. Callers pass
the_repository for now.

Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
---
 notes-utils.c |  6 ++++--
 notes.c       | 21 +++++++++++++--------
 notes.h       |  6 ++++--
 3 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/notes-utils.c b/notes-utils.c
index ea43fedd43..9f70366aa9 100644
--- a/notes-utils.c
+++ b/notes-utils.c
@@ -123,7 +123,8 @@ static int notes_rewrite_config(const char *k, const char *v,
 		/* note that a refs/ prefix is implied in the
 		 * underlying for_each_glob_ref */
 		if (starts_with(v, "refs/notes/"))
-			string_list_add_refs_by_glob(c->refs, v);
+			string_list_add_refs_by_glob(the_repository,
+						     c->refs, v);
 		else
 			warning(_("Refusing to rewrite notes in %s"
 				" (outside of refs/notes/)"), v);
@@ -160,7 +161,8 @@ struct notes_rewrite_cfg *init_copy_notes_for_rewrite(const char *cmd)
 	}
 	if (rewrite_refs_env) {
 		c->refs_from_env = 1;
-		string_list_add_refs_from_colon_sep(c->refs, rewrite_refs_env);
+		string_list_add_refs_from_colon_sep(the_repository, c->refs,
+						    rewrite_refs_env);
 	}
 	repo_config(the_repository, notes_rewrite_config, c);
 	if (!c->enabled || !c->refs->nr) {
diff --git a/notes.c b/notes.c
index 1cdf09c81c..f327652994 100644
--- a/notes.c
+++ b/notes.c
@@ -958,25 +958,27 @@ static int string_list_add_one_ref(const struct reference *ref, void *cb)
 /*
  * The list argument must have strdup_strings set on it.
  */
-void string_list_add_refs_by_glob(struct string_list *list, const char *glob)
+void string_list_add_refs_by_glob(struct repository *r,
+				  struct string_list *list, const char *glob)
 {
 	assert(list->strdup_strings);
 	if (has_glob_specials(glob)) {
 		struct refs_for_each_ref_options opts = {
 			.pattern = glob,
 		};
-		refs_for_each_ref_ext(get_main_ref_store(the_repository),
+		refs_for_each_ref_ext(get_main_ref_store(r),
 				      string_list_add_one_ref, list, &opts);
 	} else {
 		struct object_id oid;
-		if (repo_get_oid(the_repository, glob, &oid))
+		if (repo_get_oid(r, glob, &oid))
 			warning("notes ref %s is invalid", glob);
 		if (!unsorted_string_list_has_string(list, glob))
 			string_list_append(list, glob);
 	}
 }
 
-void string_list_add_refs_from_colon_sep(struct string_list *list,
+void string_list_add_refs_from_colon_sep(struct repository *r,
+					 struct string_list *list,
 					 const char *globs)
 {
 	struct string_list split = STRING_LIST_INIT_NODUP;
@@ -987,7 +989,7 @@ void string_list_add_refs_from_colon_sep(struct string_list *list,
 				     STRING_LIST_SPLIT_NONEMPTY);
 
 	for (i = 0; i < split.nr; i++)
-		string_list_add_refs_by_glob(list, split.items[i].string);
+		string_list_add_refs_by_glob(r, list, split.items[i].string);
 
 	string_list_clear(&split, 0);
 	free(globs_copy);
@@ -1002,7 +1004,8 @@ static int notes_display_config(const char *k, const char *v,
 	if (*load_refs && !strcmp(k, "notes.displayref")) {
 		if (!v)
 			return config_error_nonbool(k);
-		string_list_add_refs_by_glob(&display_notes_refs, v);
+		string_list_add_refs_by_glob(the_repository,
+					     &display_notes_refs, v);
 	}
 
 	return 0;
@@ -1133,7 +1136,8 @@ void load_display_notes(struct display_notes_opt *opt)
 		string_list_append_nodup(&display_notes_refs, default_notes_ref(the_repository));
 		display_ref_env = getenv(GIT_NOTES_DISPLAY_REF_ENVIRONMENT);
 		if (display_ref_env) {
-			string_list_add_refs_from_colon_sep(&display_notes_refs,
+			string_list_add_refs_from_colon_sep(the_repository,
+							    &display_notes_refs,
 							    display_ref_env);
 			load_config_refs = 0;
 		} else
@@ -1145,7 +1149,8 @@ void load_display_notes(struct display_notes_opt *opt)
 	if (opt) {
 		struct string_list_item *item;
 		for_each_string_list_item(item, &opt->extra_notes_refs)
-			string_list_add_refs_by_glob(&display_notes_refs,
+			string_list_add_refs_by_glob(the_repository,
+						     &display_notes_refs,
 						     item->string);
 	}
 
diff --git a/notes.h b/notes.h
index f4d1e31cd8..30adf0c197 100644
--- a/notes.h
+++ b/notes.h
@@ -331,14 +331,16 @@ struct notes_tree **notes_tree_load(struct repository *r,
 /*
  * Add all refs that match 'glob' to the 'list'.
  */
-void string_list_add_refs_by_glob(struct string_list *list, const char *glob);
+void string_list_add_refs_by_glob(struct repository *r,
+				  struct string_list *list, const char *glob);
 
 /*
  * Add all refs from a colon-separated glob list 'globs' to the end of
  * 'list'.  Empty components are ignored.  This helper is used to
  * parse GIT_NOTES_DISPLAY_REF style environment variables.
  */
-void string_list_add_refs_from_colon_sep(struct string_list *list,
+void string_list_add_refs_from_colon_sep(struct repository *r,
+					 struct string_list *list,
 					 const char *globs);
 
 /* Expand inplace a note ref like "foo" or "notes/foo" into "refs/notes/foo" */
-- 
2.56.0

