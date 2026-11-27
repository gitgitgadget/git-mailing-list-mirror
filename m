Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795817130;
	b=eTKrR9xdWVDvgdFbr+kGQc7K6YWxxCWzWgdLLk9Pdi1xyrrOj09/Rz0b0+rFk0yTioQF
	 Edbt/yJ4nDH6qoTgt7MaSegAgy6uJ7j9L8hKZtVwkbwqW+d+2v5/m0kDhx0UTMkU5jpZF
	 ooCfy4QvwxeYmmqcFEV2Ameu5YCJ8lLsb9Qh6TKzg2aaDXXRIUxk11tlL7sMJ1zpNLzzT
	 PiCuXWMa2NCXC0JscZnxfeTN1V5lbniCIK7+oFR62Cxfp3+wmykmW74WEq1z63NcrV2BO
	 67v3lFP0G/ADE0LHszoIDH29LYAiAMsyIpT11dORF86XATb2WxfAKIC6nPhZixs2Jzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795817130;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=k2PEMUormEjGD5YRY8k4J8gwbBReidjiqrhQUhyzUWI=;
	b=fH4yHwMkjOwWo+je0Mnbok7SEBfKFcGDx9S4QNg5zH5hV4Pdh3EgMfHwzNYQgozNiqI6
	 em+OlxhHhD7ceFoKWupgVi8oBo9OQaDczAm44qTyLxRrK3GH1iJG0FXRlhzYTCcQC4dp3
	 dn3uZ6D7x33EYldxBiN6YfSPKk8nky9B2+HBPbTKoaMAx1YAMBNJBUEl1ZtEeY5VcgIp0
	 VpsAsiANrG++c6vEVI+QvavIsMIVvIEVIwv0WoKQqs6jaclu0yB/F4cqGjbeHgSl27vyw
	 qPh3BFsrJ+tTjkaimaKzEA6Ts32Li4i8ib9Dc7QoFXlA6Sdnfd0F9n2xnzQcHLn5Ufw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wPgtsVte;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066CC606A32E
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 22:05:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 066CC606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wPgtsVte
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-49412eb1474so5635754f8f.3
        for <git@vger.kernel.org>; Fri, 27 Nov 2026 14:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795817128; x=1796421928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k2PEMUormEjGD5YRY8k4J8gwbBReidjiqrhQUhyzUWI=;
        b=wPgtsVtePr1KZ12mTTzKvFm03O51EmydvYwds1jzSn817G2ipWDhIadQPJg3scOTuI
         arngAo1YYnBPvHkD6Y0SZft3KoURRUVOzdGEtmIZ3LYyLu0N8iAZDUsxYgsJUxUAdGcw
         eB5/bqw+ksN2fL5RzS7XO8zNwfit47vy7Hi+BP8eizzzEBOMen8cKxjZ8zIOBRFoo3fD
         +w93mWUCmR3A/nKJDyutGMmjqC0HbYvOkJzTCbocAmZtBnXfNOf9jecUgtN63Le3VEWd
         qiRAB+yetQUiRskgPazc2utcryCSOZoQQvuZ1nF25w/wACrxSwlfGSBGMo0s+JHM/+pW
         BmPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795817128; x=1796421928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=k2PEMUormEjGD5YRY8k4J8gwbBReidjiqrhQUhyzUWI=;
        b=f8yIr46ASwNFhURBv50lBVBuDgcOkgIRqdsW/9MN3f2UcEbgIIbUK3GRAidZNtcF4k
         2aY84bPg6VkOVbw5BerzbRfH0WIIMW14s1JZwB/emdF7j4xQo55ZGWERcM9uL1QPIvlu
         h8y8Rdw/xGE61VryLh5gmVDmj180ht0Xnwz8LbMChz2P/LCt9UofIFn+ZFFycPeGJDBc
         ovv2T9+S+BcCKb1Ovxzb5hGTCkPK0k97cIYlPZ8DQM6me5xSKRH28+BEF0G+N7Fc8SZZ
         HJtfyKfsVSw3ZOSioMjlZEwEfuCpwaoN4mGmhPKWYIsjR/U/NbTprqFPfeNpYgQYMhp1
         ElqQ==
X-Gm-Message-State: APuU4Z+v/NvmQJPi88Vrr0yweeu78Fg/5B6WOtwC5sHLFh8x1Aqm2U8y
	zcOtIPyC2OP6GvWTm1wfHGwOEcQQ2BZvG4uCm9KtlhAABqUnJxa7SkdzYAtwoNlUaog=
X-Gm-Gg: AZFdTZexijGT/Klw/OgOV8O6CnztR0L3QrOyii/MLlTk8XsTfTOL5FzGxNaiqt6tPgA
	xOVWkZx0OfxBs8EIye9ucPPrVecGD7voJ6BwnGGpPNy19X/UfxGJhFon3cmE7cCtohdTrf8v0zq
	rsw1hYd7oTR0IgZCr7V5NXCiDDkWs9CwxtTrWTx6ZywJsZWNWwnIo2uk8/U7DnipMQYlooZtp7i
	xv+8gYUq4susDvFJ+zuq+CnavqGklkYi+9vyYzFFzW9pyXIFQz82ejkl1BRwnRoN+IJEylPm2/Y
	8XG9AwKb2QSo1uQZp7qIWCIu5DSW4BijaWstoqzNxjK2uSDnD4aqzYUkhNkEdTxd2Ik254fFc9u
	JcVPbEcN/bbSWKlyEZrlQKh8pORJBIDweim5S0T1Aher7CqBqw3a1f2rVVdJD5376rXaKB0z0As
	7ae59AJtDQoAC7WoV+/gCETJxCbriXcAGOozbTe66ZOrABIavhRPIv7dsG9QpvzR8nsob7pYxWS
	R0nMuE9BckUlpiHVp/p3rvehiXTJXS2/BJWkNWB1Vc5JFwHaVOW4I2MWzdhXH5e3YIax0bkpnnn
	Q7Je3e/uXDEZIv4HnotGo6FqWZkeeXZWnBOsOixu/sCgbBXYsiNM/r3GrjxgeEvBlwRTrW3p+g7
	WG7i/Y7V/2yr95hOsh4nYp+ynFPWCSaix60NMGNo6o7Y8lJlMWzYG0KsJKMGuLn9rZLsbo/EuFO
	BAvGTWSSfi8JEeArKooEa1p3TcQZdC
X-Received: by 2002:a05:6000:4812:b0:4a7:b8ab:df86 with SMTP id ffacd0b85a97d-4abb5db73bcmr47201185f8f.38.1795817128371;
        Fri, 27 Nov 2026 14:05:28 -0800 (PST)
Received: from localhost.localdomain ([104.28.251.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab658e2d1bsm51467422f8f.8.2026.11.27.14.05.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 27 Nov 2026 14:05:27 -0800 (PST)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	ps@pks.im,
	gitster@pobox.com,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	okhuomonajayi54@gmail.com
Subject: [PATCH v7 5/6] notes: pass the repository to the ref glob helpers
Date: Fri, 27 Nov 2026 23:04:44 +0100
Message-ID: <20261127220445.45639-6-okhuomonajayi54@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261127220445.45639-1-okhuomonajayi54@gmail.com>
References: <20261126213306.87466-1-okhuomonajayi54@gmail.com>
 <20261127220445.45639-1-okhuomonajayi54@gmail.com>
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

