Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795541018;
	b=x+g47qqPU7CqGAqeUyY6rUUbCuHZrO+d71Hap0xDiO4DzJV9tKjZnnWbwOfZVlmwDMt5
	 /Zkygn8TsSgXv7zwp3WxuDmyiCiWbkgncu7WAuRE4kyM+ftQihdi/FDRrosoHWbYKcTZy
	 blVap/mXqGomOyQ9vQuiU5/rKKYEiYH/YMgARjWPhb3Wyr6Pji/QhMpLY16p47diwLRsv
	 b6jo+oSCdCsJ2az78jZGjSRjudEv043YR69Xg2LNXKRoV4RglR7jZ8A8ZpREGKKRvH0iu
	 BrnOmCVKD49Bk1Aqy/FLZ78ljZ+vKqlExIaQoTo1QumH6CQKLUqgLPxjtq4DKQRbd+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795541018;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3Lqinj5lflroN7fs+EF52cJma0EJdMu3yWjlW5Eg+0Q=;
	b=qQCXJmn7/V0476P4KD8vRt1HbaAViPKi/uhrr1W8Y/c9KfJ6Gple6QGkn+dhVwwz8gnY
	 VaTpdUHI0v1H6FYArTkk8rdDR8LqfuTQtP3hMYGsy7DYBMBoLOnqD0v51WdyaT3avOXIc
	 QiTuyrnpVSMUBG+UwbxzqD07o17UuaX/l9wsCx8o/L/y1yNv2dG6/La1oONE7kuIn25k4
	 kf7hto3+Y4ySLWS9HMYGiP6CtbITFKri2pAr4d2PDZeIc1SEd0aRGRXphoCyx6adrPYrp
	 1KHnj8wBX1QuB6KzsSiY+QRS3NC6QxpFXMPRsYn5GSmWX1fLC9LfnkpCAem9+NYYuAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BbWSwumZ;
	arc=none smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B822F606A329
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 17:23:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B822F606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BbWSwumZ
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c4395d31228so817449466b.1
        for <git@vger.kernel.org>; Tue, 24 Nov 2026 09:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795541016; x=1796145816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3Lqinj5lflroN7fs+EF52cJma0EJdMu3yWjlW5Eg+0Q=;
        b=BbWSwumZ+YQ4ZNld+egTclqLqGDCw1K6VrAVb2xoXi7m6hp189/WUvxEg/aRxNbdqk
         N7/GkvRZmOGV/D66RSsO0HPWjNy7fKmsYzAFFaqhtKINBDHgDibnGzuuFY3KEoal1QF3
         IKf3LrvssIP7PwpQpjYR+LzTGi6TdPgJgCYIdjBN26rcGcJYJFaU15A2PjohSE4ewz7G
         3AFlCMKVZnRdGZ2Fw2u0Kdde1voJM8BaTXofE7QAdAR/A59+wI5P2xA1KaXP9lgjH4i1
         szJK8VkYhDyua/Sj9VZxrxV3vzrUX0q6ks2nzA/xaoEiXsQNQ0el5Y9Ux4+t56x1giu0
         m0Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795541016; x=1796145816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3Lqinj5lflroN7fs+EF52cJma0EJdMu3yWjlW5Eg+0Q=;
        b=vjL9oFcywtferW6q03T9j3H6UONGY4Y90ShgRwrfJiXjWTplcJ3LRi+AREtgGFFGo1
         MqMp78IE5qI8PhSvULn1J0mKWG5JFBGNvIhCpBOoFTBx7RxxfActrSj6J9yvPE4ItieK
         U85c1lYRzHOkfcNb9pR94eAVHk9DpTExx5NU0cUIXzCw2hnmqgDwCBUmXUA0oYtOPQbc
         N59RhTWz2TY/WJRbj++UXSy3gxw8Z9CaS5T/Ffx4LIMII4m99ECjp7EcrE59Sc8hyE3S
         7oq9ut1INZOBsG2xd9Z7bL7KKO1N19YALK16rI+6vIw7KULauxSDrphyjcpm+vtR6jOT
         YP7w==
X-Gm-Message-State: APuU4Z9VhD22Gtowl8MwRtmX/vfqrlu/Gn/BEb2dhXfwwNeBYV9nxpmX
	kIgyg8PSGOjCNiG3M/TSKRsoxwToGvE66SWzIAnRb+l0dVyiXTfNSfrqjQMwhjO8kVE=
X-Gm-Gg: AZFdTZd4Qh7CvEW/YPEyqlcPnEfO7ux1EdPjnalj1NbTI6tJCWT5SgWlsdrWS4CDULj
	zzVZ+2xu1gmE3HtEf8hMtM+PkZCVK+cTCZQELEFQ/TiGpJK8is96JqlVYDYwXKToltIwByeteYP
	jGL0lm8/z9YszHMCc8Q8AOEN8eIXYS09eZg1GvECEU3tM/ezQlcAQscE7QC8VmYkV/Qt1zsYdKy
	JjyTwOwIDjnUB9jMV/yRgIw/IIekhyIlZp2kLd7Doh+AWcuzHRR83m0+F5Sl+w7uv5/0M0+sRA9
	OsudDDQzZfWTlcutRl17Yer+Z3NE60s1VLEyDwABw3JGKbb9kchh1wL/HrjdT+q+P7cE0hzQhGt
	YI6oyB1Fm4eKQ/x7uqMIp3nvncILuEejWArzICyPEhuYMaAiDQsYX5iO5Ahp9wm5pqn+U1oKZnc
	kO7DEVpKe6nwpf4UKaL1iPQYM2UVTyH3qCy1vI6hk3hQMv7UrWVluss6BzuciFfrsoCV9b93R0I
	1jZSnZjzBJiI6Gi9llHE2u2oce6/e3/tVCp001lReCtXhkR3Tvaqd2RVkEQKAl1B1JbkLE/b8F5
	rl+TN7UI72Ef2N/2Iv1mFmrwow11QwqjDpHGNskEkIp/YVTpAsrdvQxzzPcO9UZUKe8uHYXNXf9
	WeIPy4czq+xH7BHh367CcQctJSRfOc0jk1wkBvuzoa/DOs7xxhjfzVIj8vikHI21mbUBdnyXxVU
	gJnGPEjqA6c7vPEZA6R6fBljXH086x
X-Received: by 2002:a17:906:27cb:b0:c51:3acc:9f86 with SMTP id a640c23a62f3a-c513acca092mr1063013766b.39.1795541016060;
        Tue, 24 Nov 2026 09:23:36 -0800 (PST)
Received: from localhost.localdomain ([104.28.251.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afe01a0sm547394466b.68.2026.11.24.09.23.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Nov 2026 09:23:35 -0800 (PST)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	ps@pks.im,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	okhuomonajayi54@gmail.com
Subject: [PATCH v2 4/5] notes: pass the repository to the ref glob helpers
Date: Tue, 24 Nov 2026 18:21:45 +0100
Message-ID: <20261124172146.18330-5-okhuomonajayi54@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261124172146.18330-1-okhuomonajayi54@gmail.com>
References: <20261105203344.48513-1-okhuomonajayi54@gmail.com>
 <20261124172146.18330-1-okhuomonajayi54@gmail.com>
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
index 9d653c757a..ed6fc9a1c2 100644
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
index c81bc99446..520a816714 100644
--- a/notes.h
+++ b/notes.h
@@ -327,14 +327,16 @@ struct notes_tree **notes_tree_load(struct repository *r,
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

