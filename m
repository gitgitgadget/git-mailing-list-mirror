Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793910856;
	b=jNB95MXd+sZOqDVKwjEWUW8D1/ZomQ0w+aU6tELT2F0mwciDz+6UAeDrWXLSZG2bf/Hy
	 24MnlvrzHv/A1Rxh1CWrJ9tiPkIWUjQaMXTA4AA1A6PEPnV2PuaFTQ1Tv6OxjQTAHyoYL
	 VLRwoinyPYTVdzb9q/qkEJmrqEkMhgyGI3IaECB3QNZiKHyhVzcIFzq2q20N1KDqH4XWK
	 TgmFpodSK9qetApBGF1Kcj/yjsN9CbznklFzj3B7E5bj7uIz1m+bKXOKXYTgk83ukwKD8
	 bLJt7swLW7Kbpryn4WGxEVcihFV32/YZu/FFwA/wfu11PsfUW+UX1Jl+H9G6NuWnGhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793910856;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9A7UNn6T+CNt8GYt1PniUzHOMMjpCT2bNGUd+dcoYCs=;
	b=Mlxpxgu+64t3QfYQdfgi73z1qij+c9Y/SOSf8M0/yylQxLUedIIYv8vIa+msFfB8bNS8
	 TzIxSP1YMfOPbnt0ZXKgi9ORl+hp6yZGvVF4zvDfxZ6PGRatgKXQn3smHLLdTafG0G77o
	 79YG59T9DsZh2/n6Lb4ofE4bKGGtJbcgv2tdnny/W7w48FnZqWDo3PN2jm7oHc3nWoS8J
	 Bg7eJx+uPyhLFiOJD4GQqVqREFdokXiHLTJYpQJ3y7NxrhhFvmC9kNDmSEZxgdEdjPbXl
	 WULxv6c5oJMhyWkrh1uBU5CIUEgemvTbiAz3y3kjwkskN89zZaWxd4OWjWRF3CyybBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZxuHBQMu;
	arc=none smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B99606A329
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 20:34:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42B99606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZxuHBQMu
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b408f2d936so2971153a12.1
        for <git@vger.kernel.org>; Thu, 05 Nov 2026 12:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793910854; x=1794515654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9A7UNn6T+CNt8GYt1PniUzHOMMjpCT2bNGUd+dcoYCs=;
        b=ZxuHBQMuigWoXxBLOVzWRtNqRdiyqat9ux9s79pzJr16ofGubsYtVsCprKXEBbfoBX
         4n1mec2Wvfa9s+zcJOxc6uLFxlsbciVn1af1j0XQygXdslPNgYpXm28vTlUk4Wh5RhLg
         kEyLFxdMG9ZlHWAswmOPRGgu7OkH4LCHKDWsVGdXVD4Z4hMbk3aluEsWTknvvPnp2GZD
         dYdIjzy8OrhF9Ilw6EGjCuLAH6h2sPfRUM2zZkHF1LWRYkUusbr02QJRov81CoINC1gM
         qk664XBtk1KAwD7Cz0IEKQXFuOuzWyclkHFhnFjKghui7m/gj4GGECAyUH44+YhgyjZN
         Y77A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793910854; x=1794515654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9A7UNn6T+CNt8GYt1PniUzHOMMjpCT2bNGUd+dcoYCs=;
        b=U7yzYp7ckc2iTVV1C1mHMv+fgLsVPIl/IdGI2gMoKm+CAyi9ek+UioImO/Lvi5VTqa
         RWGBUcR0EZaYKHT1Q3en/3SV/buQ5cg/vzR1uEkdtDFPJ79H1k7FY6dtb09/yn5k0Gvq
         RJr+/IoxgvoNiRsURbjLMS+VmCaBh2u2Xz5goH0wtaXehCPjTU9462MJ5JidFA77lLie
         q9D9EZDg9EubVSwXFgLYHWWV7lxkDEfg6L4cMikLqMW83Kt3LKGVaoVeEAVJL9A2AEcE
         pCwBc0Vvcab6N++u+JKpGG2W0VeaOUNyjsdmdg0px70BedoIKd3YpqVm+S9/z4Vj8dbM
         HM4Q==
X-Gm-Message-State: APuU4Z8FnSfG2iKmocrH/Zhk9epay2ZMIHiMHwNqOa2T9lrbMtvWPNTB
	viJU9MXZcwLORZJr1oNzalAv3gmH2NOdZLHMd53pvSktcSqCTIfpwvVDPsxnATroitRCyQ==
X-Gm-Gg: AYBFou2TocpW1fzV16EwiDJow0v2fTVa1jRBYVuSeEVWNQpQEuUlZh8Ly71rdIyRioh
	OM+Y/dJsgKXW2luxGDEXcF/NUZL8l3emh0/cgy/yjQmejXdd7AgBHZRVEcslLOK0u1x1XfQPLVy
	X+re0RMiJM/xuisrzp3Sd168ql2iQ+ndqwb6/p2DuTBJFkFh+aFKBa+o4jwKgkNahZ7855mI2od
	naTBYbKpyHdd3hjYh91fVIjE5irUDlC3m12yzo/ETnCr/8dx+EMqIksZIOgWhLgOm1zDk8nYQ6J
	Wt4OD9/wRNz4g/lb27+/yxZ4Bkkhv3XCBdGWzeYCgJ6GC4qcBgiuCBLh7zcjBRqm6xltZWCtsof
	mY5ObwaZc9H2OqpKyww9otUTVQn/pVnx3stmuugaL8ulzJuaDjO81EjWxGk8UgvcDn7OjE9Efsu
	elMPlYQUMCTPVJoXxKscebn+0nbrkY8m+q5QyGTIWvwp5PCQ6ZJa/5u1kbHomNhgsiy5x3gXvIK
	xpyBPeFFfCtthcQugr/QwT9H4AlTEtKZ6Jsc226JLQ6VTssupwcEz5xnji4KUk/VoMHYf1GXfIs
	bl6j/j+FsXI1UwrLBj43yALX8Td49SXy3onCX3otVai2hhlXPEv2aIJW/jIp2zU4ovq/Z9FtHb+
	4CaDTs3N68TKg6zDmvt9fWzxEQ8pmlAyIaCY2Owj0re+xWirjerNLHj3F8Sl85F6FNH7ve4njrB
	8Ps3cuuFj7GFy1yJ7AIzu18L0mykxe
X-Received: by 2002:a05:6402:1ed5:b0:6b5:7037:eacf with SMTP id 4fb4d7f45d1cf-6b59783040dmr271634a12.42.1793910854483;
        Thu, 05 Nov 2026 12:34:14 -0800 (PST)
Received: from localhost.localdomain ([104.28.219.97])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b5853e0536sm702689a12.31.2026.11.05.12.34.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Nov 2026 12:34:13 -0800 (PST)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	ps@pks.im,
	gitster@pobox.com,
	karthik.188@gmail.com
Subject: [Outreachy PATCH 4/6] notes: pass the repository to the ref glob helpers
Date: Thu,  5 Nov 2026 21:33:42 +0100
Message-ID: <20261105203344.48513-5-okhuomonajayi54@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105203344.48513-1-okhuomonajayi54@gmail.com>
References: <xmqq1p8zw49g.fsf@gitster.g>
 <20261105203344.48513-1-okhuomonajayi54@gmail.com>
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
index 404e9a5eea..70c619269e 100644
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
index c83bcc29ad..cff63a4410 100644
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
@@ -1132,7 +1135,8 @@ void load_display_notes(struct display_notes_opt *opt)
 		string_list_append_nodup(&display_notes_refs, default_notes_ref(the_repository));
 		display_ref_env = getenv(GIT_NOTES_DISPLAY_REF_ENVIRONMENT);
 		if (display_ref_env) {
-			string_list_add_refs_from_colon_sep(&display_notes_refs,
+			string_list_add_refs_from_colon_sep(the_repository,
+							    &display_notes_refs,
 							    display_ref_env);
 			load_config_refs = 0;
 		} else
@@ -1144,7 +1148,8 @@ void load_display_notes(struct display_notes_opt *opt)
 	if (opt) {
 		struct string_list_item *item;
 		for_each_string_list_item(item, &opt->extra_notes_refs)
-			string_list_add_refs_by_glob(&display_notes_refs,
+			string_list_add_refs_by_glob(the_repository,
+						     &display_notes_refs,
 						     item->string);
 	}
 
diff --git a/notes.h b/notes.h
index 0f50020816..b571ecede4 100644
--- a/notes.h
+++ b/notes.h
@@ -327,14 +327,16 @@ struct notes_tree **load_notes_trees(struct repository *r,
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

