Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E82341F461
	for <e@80x24.org>; Wed, 26 Jun 2019 08:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfFZIlt (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jun 2019 04:41:49 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34845 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfFZIls (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jun 2019 04:41:48 -0400
Received: by mail-pl1-f196.google.com with SMTP id w24so1057719plp.2
        for <git@vger.kernel.org>; Wed, 26 Jun 2019 01:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H9vA/z2ZMb5wxpGqqs6beyfS3TDuNe6vW7IKNgmKhUc=;
        b=UT+pHZw/SnQrETp1fsrzncBTJmMHH30xZgUTL9x3BkHKqOUVibytxjwQLvrQPI6Pgi
         a/wtYKDIL9hr6E3vfp8Kg2Ht7wBc1ZcW7YJ0CxQVkl1RsjBfQh1yKBwLy9ENCwdewiZN
         1MWNM0P0s4XUDOYSRkUoBy60sYp1Izizh+SUlJPgQnJ9Z88OVXE4Yj1Z64KdOhZkgSlq
         iqCZ2tzv1DhEs4Bv/S9hhptLN/LN7GbDiNm97a8bvgZC7RaazRAfx833CQDxQQntWtUI
         IIk/e2k2AAdF9nz3Iz0m6IU0XhMHpwbK/tgq/0EPtiXOuOh9x63za3e7VfmUfNHV3089
         nGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H9vA/z2ZMb5wxpGqqs6beyfS3TDuNe6vW7IKNgmKhUc=;
        b=eqtw+LTjRPnkorDhVCDFsu0aDN3cBNrKvpQNOW6kk610nKGN+DjHOFB30eQfkE8EVO
         jEikMxKG0FUY5POzicadMQAtjHjWUtR0oAmX9k0s+m+4qen41wjzDIJ0rl7yMXwoTRGR
         7aOtxHmHudXuK61avto3DntuehHOB3H1ObbD489GbWy6dc0TrVDFmmgQGajx+710ahzF
         fKkz+Zg1J2neZdBHxXXHdaWjTWGNBQAv/DaEe6OlRRi7bk+YeTT1VLiYP/n/JpaiGvqP
         rb/LElahJyg002NwQaatbe2rmxgHy3J913HftHbUjZoDzOcijTeneZDZrO5f56t+7MY5
         AbSw==
X-Gm-Message-State: APjAAAUp555qmoM48W3KJxhki+OxBj1rR8xx+C6v6jj03oyIwqL/lamG
        ODvDLMXnhwMVUgTR0PhuNAGBwV/u
X-Google-Smtp-Source: APXvYqxjdsR0szPj4yp4OFRjtKNXsziGAFZkdf2GhYhCqmMvGocCc6J4NZPnzoLY/CMaAxO1YdlmgQ==
X-Received: by 2002:a17:902:b603:: with SMTP id b3mr4105600pls.9.1561538507490;
        Wed, 26 Jun 2019 01:41:47 -0700 (PDT)
Received: from ash ([115.76.181.38])
        by smtp.gmail.com with ESMTPSA id b19sm10995475pgh.57.2019.06.26.01.41.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 01:41:46 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 26 Jun 2019 15:41:42 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, kyle@kyleam.com,
        Heiko.Boettger@karlstorz.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH/RFC] get_oid: new extended SHA-1 syntax to control resolution process
Date:   Wed, 26 Jun 2019 15:41:39 +0700
Message-Id: <20190626084139.30246-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.22.0.rc0.322.g2b0371e29a
In-Reply-To: <8C0042D8869AEA4AA334B49AFBBCEF820243C01B6A@TUT-EX01-PV.KSTG.corp>
References: <8C0042D8869AEA4AA334B49AFBBCEF820243C01B6A@TUT-EX01-PV.KSTG.corp>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[I feel like this is something we should do, but I'm not sure. Hence
RFC. The patch is mostly to play with if you're curious. The die() thing
there is definitely wrong. And yeah all the syntax names are
placeholders.]

get_oid() is flexible and accepts multiple SHA-1 sources. Sometimes this
flexibility is actually unwanted, especially for scripts. Let's talk
problems:

- Ambiguity aside, a script may want to check if branch A exists. Of
  course "git rev-parse A" won't cut it. But even "git rev-parse
  refs/heads/A" may fail: if you have refs/heads/refs/heads/A for
  whatever reason and the real branch "A" does not exist, the rev-parse
  rules allow to expand "refs/heads/A" to the long ref.

- And then there's problem with using the wrong rule. 9309ba may look
  like a short hash. But if such short hash does not match any object,
  and there is refs/heads/9309ba, you'll have a little surprise.

- The same for blahblah-g9309ba which could either be expanded to
  refs/heads/blahblah-g9309ba, or interpreted as git-describe output.

- Ambiguation will also cause problems, but I don't think we need to
  get into that. Ambiguation may be addressed separately actually.

There could be existing mitigation (e.g. maybe you can resolve
blahblah-g9309ba and see if it's a ref or not). But it feels like we
work around the problem than addressing it.

The problem is we try every possible way to resolve a rev. Let's have
some annotation to express that we only want to resolve a rev in a
certain way:

- <hash>@{hash} only accepts a full hash or a short hash. If it's a
  short hash, it cannot be ambiguous.

- <ref>@{literal} only accepts full ref. No turning "master" into
  "refs/heads/master".

- <output>@{describe} interprets <output> as git-describe output
  only, not an object name or a reference.

This gives scripts much better control over get_oid(), which
translates to rev-parse and a bunch other commands.

PS. The new syntax can stack with existing ones. E.g. you could write
refs/heads/master@{literal}@{yesterday} or <hash>@{hash}^{tree}.
Perhaps I should allow these tags at the end too, so you can enforce a
variable like "$REV"@{literal} where $REV could be even HEAD~123

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/revisions.txt | 10 ++++++++
 refs.c                      | 41 +++++++++++++++++++++++++++++--
 refs.h                      |  2 ++
 sha1-name.c                 | 48 +++++++++++++++++++++++++++++++++++--
 4 files changed, 97 insertions(+), 4 deletions(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 82c1e5754e..93eb278743 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -86,6 +86,16 @@ some output processing may assume ref names in UTF-8.
   immediately following a ref name and the ref must have an existing
   log ('$GIT_DIR/logs/<refname>').
 
+'<refname>@{literal}'::
+  The ref is not expanded by Git. In other words, if '$GIT_DIR/<refname>'
+  does not exist, the ref is not valid.
+
+'<sha1>@{hash}'::
+  '<sha1>' must be an unambiguous (short or full) object name.
+
+'<describeOutput>@{describe}'::
+  ...
+
 '@{<n>}', e.g. '@\{1\}'::
   You can use the '@' construct with an empty ref part to get at a
   reflog entry of the current branch. For example, if you are on
diff --git a/refs.c b/refs.c
index b8a8430c96..2ee33257fd 100644
--- a/refs.c
+++ b/refs.c
@@ -634,6 +634,27 @@ int repo_dwim_ref(struct repository *r, const char *str, int len,
 	return refs_found;
 }
 
+int repo_dwim_ref_strict(struct repository *r,
+			 const char *str, int len,
+			 struct object_id *oid,
+			 char **ref)
+{
+	char *last_branch = substitute_branch_name(r, &str, &len);
+	struct strbuf sb = STRBUF_INIT;
+	int flag;
+
+	FREE_AND_NULL(last_branch);
+	strbuf_add(&sb, str, len);
+	*ref = xstrdup_or_null(
+		refs_resolve_ref_unsafe(get_main_ref_store(r),
+					sb.buf,
+					RESOLVE_REF_READING,
+					oid,
+					&flag));
+	strbuf_release(&sb);
+	return *ref != NULL;
+}
+
 int dwim_ref(const char *str, int len, struct object_id *oid, char **ref)
 {
 	return repo_dwim_ref(the_repository, str, len, oid, ref);
@@ -673,8 +694,9 @@ int expand_ref(struct repository *repo, const char *str, int len,
 	return refs_found;
 }
 
-int repo_dwim_log(struct repository *r, const char *str, int len,
-		  struct object_id *oid, char **log)
+static int do_dwim_log(struct repository *r, const char *str, int len,
+		       struct object_id *oid, char **log,
+		       int ignore_rev_parse_rules)
 {
 	struct ref_store *refs = get_main_ref_store(r);
 	char *last_branch = substitute_branch_name(r, &str, &len);
@@ -687,6 +709,9 @@ int repo_dwim_log(struct repository *r, const char *str, int len,
 		struct object_id hash;
 		const char *ref, *it;
 
+		if (ignore_rev_parse_rules && p != ref_rev_parse_rules)
+			break;
+
 		strbuf_reset(&path);
 		strbuf_addf(&path, *p, len, str);
 		ref = refs_resolve_ref_unsafe(refs, path.buf,
@@ -713,6 +738,18 @@ int repo_dwim_log(struct repository *r, const char *str, int len,
 	return logs_found;
 }
 
+int repo_dwim_log(struct repository *r, const char *str, int len,
+		  struct object_id *oid, char **log)
+{
+	return do_dwim_log(r, str, len, oid, log, 0);
+}
+
+int repo_dwim_log_strict(struct repository *r, const char *str, int len,
+			 struct object_id *oid, char **log)
+{
+	return do_dwim_log(r, str, len, oid, log, 1);
+}
+
 int dwim_log(const char *str, int len, struct object_id *oid, char **log)
 {
 	return repo_dwim_log(the_repository, str, len, oid, log);
diff --git a/refs.h b/refs.h
index 730d05ad91..9395a2e708 100644
--- a/refs.h
+++ b/refs.h
@@ -151,6 +151,8 @@ void expand_ref_prefix(struct argv_array *prefixes, const char *prefix);
 int expand_ref(struct repository *r, const char *str, int len, struct object_id *oid, char **ref);
 int repo_dwim_ref(struct repository *r, const char *str, int len, struct object_id *oid, char **ref);
 int repo_dwim_log(struct repository *r, const char *str, int len, struct object_id *oid, char **ref);
+int repo_dwim_ref_strict(struct repository *r, const char *str, int len, struct object_id *oid, char **ref);
+int repo_dwim_log_strict(struct repository *r, const char *str, int len, struct object_id *oid, char **ref);
 int dwim_ref(const char *str, int len, struct object_id *oid, char **ref);
 int dwim_log(const char *str, int len, struct object_id *oid, char **ref);
 
diff --git a/sha1-name.c b/sha1-name.c
index 728e6f1f61..2d05414140 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -789,6 +789,25 @@ static inline int push_mark(const char *string, int len)
 	return at_mark(string, len, suffix, ARRAY_SIZE(suffix));
 }
 
+static inline int literal_mark(const char *string, int len)
+{
+	const char *suffix[] = { "@{literal}" };
+	return at_mark(string, len, suffix, ARRAY_SIZE(suffix));
+}
+
+static inline int find_mark(const char *mark, const char *string, int len, int *len_p)
+{
+	int mark_len = strlen(mark);
+
+	if (mark_len <= len &&
+	    !strncasecmp(string + len - mark_len, mark, mark_len)) {
+		if (len_p)
+			*len_p -= mark_len;
+		return 1;
+	}
+	return 0;
+}
+
 static enum get_oid_result get_oid_1(struct repository *r, const char *name, int len, struct object_id *oid, unsigned lookup_flags);
 static int interpret_nth_prior_checkout(struct repository *r, const char *name, int namelen, struct strbuf *buf);
 
@@ -811,6 +830,18 @@ static int get_oid_basic(struct repository *r, const char *str, int len,
 	int refs_found = 0;
 	int at, reflog_len, nth_prior = 0;
 
+	if (find_mark("@{hash}", str, len, &len)) {
+		struct strbuf sb = STRBUF_INIT;
+
+		strbuf_add(&sb, str, len);
+		if (!get_oid_hex(sb.buf, oid) ||
+		    !get_short_oid(r, sb.buf, sb.len, oid, flags)) {
+			strbuf_release(&sb);
+			return 0;
+		}
+		die("Not a hash. Yes I know this should be fatal");
+	}
+
 	if (len == r->hash_algo->hexsz && !get_oid_hex(str, oid)) {
 		if (warn_ambiguous_refs && warn_on_object_refname_ambiguity) {
 			refs_found = repo_dwim_ref(r, str, len, &tmp_oid, &real_ref);
@@ -837,7 +868,8 @@ static int get_oid_basic(struct repository *r, const char *str, int len,
 					continue;
 				}
 				if (!upstream_mark(str + at, len - at) &&
-				    !push_mark(str + at, len - at)) {
+				    !push_mark(str + at, len - at) &&
+				    !literal_mark(str + at, len - at)) {
 					reflog_len = (len-1) - (at+2);
 					len = at;
 				}
@@ -862,7 +894,14 @@ static int get_oid_basic(struct repository *r, const char *str, int len,
 		}
 	}
 
-	if (!len && reflog_len)
+	if (find_mark("@{literal}", str, len, &len)) {
+		if (reflog_len)
+			refs_found = repo_dwim_log_strict(r, str, len, oid, &real_ref);
+		else
+			refs_found = repo_dwim_ref_strict(r, str, len, oid, &real_ref);
+		if (!refs_found)
+			die("bad ref");
+	} else if (!len && reflog_len)
 		/* allow "@{...}" to mean the current branch reflog */
 		refs_found = repo_dwim_ref(r, "HEAD", 4, oid, &real_ref);
 	else if (reflog_len)
@@ -1180,6 +1219,11 @@ static enum get_oid_result get_oid_1(struct repository *r,
 	if (!ret)
 		return FOUND;
 
+	if (find_mark("@{describe}", name, len, &len)) {
+		ret = get_describe_name(r, name, len, oid);
+		return !ret ? FOUND : MISSING_OBJECT;
+	}
+
 	ret = get_oid_basic(r, name, len, oid, lookup_flags);
 	if (!ret)
 		return FOUND;
-- 
2.22.0.rc0.322.g2b0371e29a

