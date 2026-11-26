Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795728827;
	b=s+L3gaxi7SL4aRZ6IOCE6e+Ii/zX5H1RNv12807+Mit9/1XNlvLB98NsMo0WomSnkxgt
	 igBBAM+9f6rw4leWVdTCtslJRqIbXzX7AOZEX3D/aaxiuCHbNmSV+lEWCCN43WzmGqThS
	 8Xj8SMp5XXk97RZhxHOHG6T8gZ/bOSlfLAM378rV3OIWz6zpT7eURQvcIlwAzMmygQiZN
	 7lNDxUEqk4n88s+a7KkLsbbRdrrOuTwyttBRLK3KDdsVJJfLtJluDa9tvpq/2ZeC2Jrfy
	 30tWeVAiCHex9UZsQsoAInMqHEBTfd/ZYHidpHQ/NVUhlAQKe0BWK+8jw3Lc++lyoUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795728827;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=k2PEMUormEjGD5YRY8k4J8gwbBReidjiqrhQUhyzUWI=;
	b=kNCp9ooakQLTw1XGQmLL9/FFbmGrgEQcXHdOSEyb2E9vC9RewWWfLEB4rdIAoFsdwjqI
	 xrApgw3n2pHZ4NWh7OXQ2MlS9jl4xcXAB0zTCCUofAI7fQ1Pf4yI4IRHaPWEa7trvRrF+
	 q2FZ7Ek4MBnSMGIGpHEKJ111YibFqiNDd1ikRxNnnUbeNA+TIgyvOnXnEprhzUmZwzTO0
	 e0K3IBQOknvyYnK+xcyIJgCaY/sIHTAhEqf0FIln1rEPW9jvXTtLn16d+peYfQ8VEztNo
	 I3HsFwNoZepXLKLKQ3UBOAbGj7VTjDbOsDO4DNBwzML1gLsJ3+vtEpoT9w1Xo5XCYFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c1o2ZLKr;
	arc=none smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF240606A31C
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 21:33:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF240606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c1o2ZLKr
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c4cb6834eaaso346397866b.2
        for <git@vger.kernel.org>; Thu, 26 Nov 2026 13:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795728825; x=1796333625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k2PEMUormEjGD5YRY8k4J8gwbBReidjiqrhQUhyzUWI=;
        b=c1o2ZLKr2Cel1msl/nVV0xlQSaUryGRRcTjAx09xcITN5b7S6wdmpNdPBq0aIFg6n9
         Vy1dymUEhVODK5Ka85Tg4AkLUiCXt6XNUbTMKT/CZ8Bw99tG+XU78nbH8Whd93DipbTd
         JrYIWuKYAROfgJA3tmZ0zxhb+GAwBWERYpp3vZnY+b9NtmovugBhqgOODjA621ZlbwH2
         DBdefCMRCe2/6ruPOrRGw2RmpREGQMi8n8xebv3AVnPuHFRhlYQkc8fpwtDXdAjoPJ5s
         Av6A/Rcf6QSKKBtsdIe/z20cVx9Cg9B0YGuVbDJaENsiLbSPWab79+AjM4+HY/iGnQ3X
         QO7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795728825; x=1796333625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=k2PEMUormEjGD5YRY8k4J8gwbBReidjiqrhQUhyzUWI=;
        b=Rf90lnkLjbdBmbdEFnFL8/RKfWNQ2QTnFxeKPMi5VY33iAaXU22d5KmRnOmDqiw+tL
         11TNlLAIxGbYoJTVjOuiTrFeF+AT/yyfmYJAjBrArZrMAzj9Lj80B/x4bIexR/27tiLH
         6Atr9j/5RUbWAuAI9ZrEY+U5/J4YgVUg4ckKm2mI/hELp0TJSj+A3ygw/RDQdeVTgcEw
         P6egFT51yrqygl0DSilb9bXVPdOGtaHf69QCDI/GuBTWNRT1NLm9B7xW3BNwWkBx2UiO
         t2q6a5W7FOyC7fKZLDASL9MKsOCurF4amnGBooij64f/mAbn1pBxq+8UA3DVMdq9Qj8m
         dQXQ==
X-Gm-Message-State: APuU4Z+HMU5bIUswFIzwmoCA5gfFYGkVPvRmIsLNmr7VJXN+tIGPg7Fc
	ETvCcME5++UYBxJr5E+5hbj+CLv0x03yjqaTN227RtR4QeYvykJ5kon30XftU96tViMO6A==
X-Gm-Gg: AZFdTZdw9KjFcV7O028SSJTN1vS6cwz8yAwUrXl1gBKmD2oPoqmza8siHQicH82OyN9
	ZAlasBhAX8wfq/s393rwMhko+n1tjTUufKI1TJN55L7tx3FcqNa8Pu2QmgzqBLu/rvM+sZTTylr
	APNJrUM2s1SjAGaTxheC0hJFHzLEvJCoNCo0TCxZcCMZNmgJv7e7uRCaCKWXgU0diAl2bbXiZew
	be5UOxaXRG2VyO0lHlwYaIVN/qhuJ4Szif05TjH2fOXmdJlaoI5+b4Kh883HWw633aWaffSKa8t
	6Wyp365Un/GpM0902VXZvRImSdtUHUhJt8SrJocH2MJHHPHSw4BIO0n/NoHr94ow0SgpzuAhehF
	oOyeBjoNMlYoYLulsQRxp53VpDT6fEK44m+gTe/621c6LkDHNrlPTI675vvc/GhHfnUtnARJKYO
	1ZsjjBXR/3dGN6dlfYS/bEfH4UTMIF5JezL+M6LYMuERA+usoRZLTmcqb222MZYVNWzM/m9jvCe
	ElKRdz3zof2zN4nzzwHhCI4j9Szazn3gFYmkP7E19VNp00jJ2utjUWfNF1hOYlkNCRl5dACwOIv
	7m1qesTxs1WTijZnPe+jVyXqIhKAOwnbfEs0N0idmXYLWdXLH/j4X031zjxVOc9tX918Un71pMy
	cAarZ7tAFJ30Yn6OmLeFbq8oDhpj6baDBsBJ/PaZBd0R8Z9EjPB6OO8zJm+MiltQmNdsNj6vSt0
	yrz4JTRNVvbpbcNjx789OlGMxRhuYQ
X-Received: by 2002:a17:907:7295:b0:c51:c6e1:3cf4 with SMTP id a640c23a62f3a-c51c6e14021mr257181666b.6.1795728825268;
        Thu, 26 Nov 2026 13:33:45 -0800 (PST)
Received: from localhost.localdomain ([104.28.251.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513b030ed9sm805237066b.86.2026.11.26.13.33.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 26 Nov 2026 13:33:44 -0800 (PST)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	ps@pks.im,
	gitster@pobox.com,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	okhuomonajayi54@gmail.com
Subject: [PATCH v6 5/6] notes: pass the repository to the ref glob helpers
Date: Thu, 26 Nov 2026 22:33:05 +0100
Message-ID: <20261126213306.87466-6-okhuomonajayi54@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261126213306.87466-1-okhuomonajayi54@gmail.com>
References: <20261124172146.18330-1-okhuomonajayi54@gmail.com>
 <20261126213306.87466-1-okhuomonajayi54@gmail.com>
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

