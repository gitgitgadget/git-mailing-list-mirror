Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B3A91F461
	for <e@80x24.org>; Mon, 26 Aug 2019 23:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbfHZX5w (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 19:57:52 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43803 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbfHZX5w (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 19:57:52 -0400
Received: by mail-qt1-f194.google.com with SMTP id b11so19668987qtp.10
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 16:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cqagIIb7s5YsmtkDV4AgOkDQ6OSE458iqoJrJNLmmZo=;
        b=Ge5EO34jHVmILrzW+Ojw4O6NKWtHc6j8X52mS3XE5iYF3mechX1Uo3cEWlNeLmlyZn
         mzPxS/cRIOnEOoi8j4Ysk3u52zCzya3SaRmS5pKCnskLpipj3qkZfXTjnpq8/RDtFSDj
         HqqUvYcoQCzCOex0Br6+IMhehLqoGGQzWXPDAq0BFRNm2B0D3GOTgIW4cjdchE48Ndsq
         FdOcXnq+dANjUVIO8WlQuvkz4Afeh2NEhnJZ9WdFt8Rl6WN6AU+ugtwzNgqI/bgOaW5v
         0mrkZN8mjtjBzirYolIDbvVyt8LNHlb+fLsS1HZIohBHAuyhp+spOOiYYN49AVS1Undv
         Pohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cqagIIb7s5YsmtkDV4AgOkDQ6OSE458iqoJrJNLmmZo=;
        b=BCkl0XzLVC/ZFZxf6AFAr3c8VU3BNAoGeT/5Yg9Wv7b3EQe5EgR2DSxBKDAicSVTHQ
         Tmfka69wdkGn3YthQ6Aml7ZXjncFBevtWrpMRK09gosPbY9IRPGIU7v2ylh1GyWdv2LG
         DiULQbvocCBYwUqc0qFrLqTFPUIlseOCjAgOiuG8kMlUUEIVFoF7d2JCALK53d0jXTU5
         JJ+oCdhPllTAioVg+xgR/6n/XMGJSFNjZCzzoc2l6nm9foLI+Ke9LeGlI9XzTAurf/Uf
         G+clwwPOymTwgPL/jAJwrPim+9zInalb2eC3DjnS+dxC3oNRXVPyvZyFoLy9PhN5Ihom
         sdfw==
X-Gm-Message-State: APjAAAXWwZt6tzxmHZY7C/izf0ZCLv+Gk4iXHxBdnXgZMVbyFbAO6wMO
        ImyIAuUlhL0LD2xmyADRw7uVx1x5OxQ=
X-Google-Smtp-Source: APXvYqz0ivItDRFKQz0L2ysOiVqARh6KrMmCZyDldq6Eg6AJF8zk4oWXlyLJDqizLYXvbee8344BOg==
X-Received: by 2002:ac8:157:: with SMTP id f23mr20156759qtg.152.1566863870463;
        Mon, 26 Aug 2019 16:57:50 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id i62sm7192883qke.52.2019.08.26.16.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 16:57:49 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bwilliams.eng@gmail.com>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 1/2] config: allow config_with_options() to handle any repo
Date:   Mon, 26 Aug 2019 20:57:27 -0300
Message-Id: <4920d3c474375abb39ed163c5ed6138a5e5dccc6.1566863604.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1566863604.git.matheus.bernardino@usp.br>
References: <cover.1566863604.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, config_with_options() relies on the global the_repository
when it has to configure from a blob. A possible way to bypass this
limitation, when working with arbitrary repos, is to add their object
directories into the in-memory alternates list. That's what
submodule-config.c::config_from_gitmodules() does, for example. But this
approach can negatively affect performance and memory. So introduce
repo_config_with_options() which takes a struct repository as an
additional parameter and pass it down in the call stack. Also, leave the
original config_with_options() as a macro behind
NO_THE_REPOSITORY_COMPATIBILITY_MACROS.

Finally, adjust documentation and add a rule to coccinelle to reflect
the change.

Note: the following patch will take care of actually using the added
function in place of config_with_options() at config_from_gitmodules().

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 Documentation/technical/api-config.txt        |  5 +++-
 config.c                                      | 26 +++++++++----------
 config.h                                      | 16 ++++++++----
 .../coccinelle/the_repository.pending.cocci   | 11 ++++++++
 submodule-config.c                            |  2 +-
 5 files changed, 39 insertions(+), 21 deletions(-)

diff --git a/Documentation/technical/api-config.txt b/Documentation/technical/api-config.txt
index 7d20716c32..ad99353df8 100644
--- a/Documentation/technical/api-config.txt
+++ b/Documentation/technical/api-config.txt
@@ -47,7 +47,7 @@ will first feed the user-wide one to the callback, and then the
 repo-specific one; by overwriting, the higher-priority repo-specific
 value is left at the end).
 
-The `config_with_options` function lets the caller examine config
+The `repo_config_with_options` function lets the caller examine config
 while adjusting some of the default behavior of `git_config`. It should
 almost never be used by "regular" Git code that is looking up
 configuration variables. It is intended for advanced callers like
@@ -65,6 +65,9 @@ Specify options to adjust the behavior of parsing config files. See `struct
 config_options` in `config.h` for details. As an example: regular `git_config`
 sets `opts.respect_includes` to `1` by default.
 
+The `config_with_options` macro is provided as an alias for
+`repo_config_with_options`, using 'the_repository' by default.
+
 Reading Specific Files
 ----------------------
 
diff --git a/config.c b/config.c
index 3900e4947b..dc116f2582 100644
--- a/config.c
+++ b/config.c
@@ -1624,17 +1624,16 @@ int git_config_from_mem(config_fn_t fn,
 	return do_config_from(&top, fn, data, opts);
 }
 
-int git_config_from_blob_oid(config_fn_t fn,
-			      const char *name,
-			      const struct object_id *oid,
-			      void *data)
+int git_config_from_blob_oid(struct repository *r, config_fn_t fn,
+			     const char *name, const struct object_id *oid,
+			     void *data)
 {
 	enum object_type type;
 	char *buf;
 	unsigned long size;
 	int ret;
 
-	buf = read_object_file(oid, &type, &size);
+	buf = repo_read_object_file(r, oid, &type, &size);
 	if (!buf)
 		return error(_("unable to load config blob object '%s'"), name);
 	if (type != OBJ_BLOB) {
@@ -1649,15 +1648,14 @@ int git_config_from_blob_oid(config_fn_t fn,
 	return ret;
 }
 
-static int git_config_from_blob_ref(config_fn_t fn,
-				    const char *name,
-				    void *data)
+static int git_config_from_blob_ref(struct repository *r, config_fn_t fn,
+				    const char *name, void *data)
 {
 	struct object_id oid;
 
-	if (get_oid(name, &oid) < 0)
+	if (repo_get_oid(r, name, &oid) < 0)
 		return error(_("unable to resolve config blob '%s'"), name);
-	return git_config_from_blob_oid(fn, name, &oid, data);
+	return git_config_from_blob_oid(r, fn, name, &oid, data);
 }
 
 const char *git_etc_gitconfig(void)
@@ -1751,9 +1749,9 @@ static int do_git_config_sequence(const struct config_options *opts,
 	return ret;
 }
 
-int config_with_options(config_fn_t fn, void *data,
-			struct git_config_source *config_source,
-			const struct config_options *opts)
+int repo_config_with_options(struct repository *r, config_fn_t fn, void *data,
+			     struct git_config_source *config_source,
+			     const struct config_options *opts)
 {
 	struct config_include_data inc = CONFIG_INCLUDE_INIT;
 
@@ -1774,7 +1772,7 @@ int config_with_options(config_fn_t fn, void *data,
 	else if (config_source && config_source->file)
 		return git_config_from_file(fn, config_source->file, data);
 	else if (config_source && config_source->blob)
-		return git_config_from_blob_ref(fn, config_source->blob, data);
+		return git_config_from_blob_ref(r, fn, config_source->blob, data);
 
 	return do_git_config_sequence(opts, fn, data);
 }
diff --git a/config.h b/config.h
index f0ed464004..33ce46ecc3 100644
--- a/config.h
+++ b/config.h
@@ -82,16 +82,22 @@ int git_config_from_mem(config_fn_t fn,
 			const char *name,
 			const char *buf, size_t len,
 			void *data, const struct config_options *opts);
-int git_config_from_blob_oid(config_fn_t fn, const char *name,
-			     const struct object_id *oid, void *data);
+int git_config_from_blob_oid(struct repository *r, config_fn_t fn,
+			     const char *name, const struct object_id *oid,
+			     void *data);
 void git_config_push_parameter(const char *text);
 int git_config_from_parameters(config_fn_t fn, void *data);
 void read_early_config(config_fn_t cb, void *data);
 void read_very_early_config(config_fn_t cb, void *data);
 void git_config(config_fn_t fn, void *);
-int config_with_options(config_fn_t fn, void *,
-			struct git_config_source *config_source,
-			const struct config_options *opts);
+int repo_config_with_options(struct repository *r, config_fn_t fn, void *data,
+			     struct git_config_source *config_source,
+			     const struct config_options *opts);
+#ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
+#define config_with_options(fn, data, config_source, opts) \
+	repo_config_with_options(the_repository, fn, data, config_source, opts)
+#endif
+
 int git_parse_ssize_t(const char *, ssize_t *);
 int git_parse_ulong(const char *, unsigned long *);
 int git_parse_maybe_bool(const char *);
diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/coccinelle/the_repository.pending.cocci
index 2ee702ecf7..53ecc975bf 100644
--- a/contrib/coccinelle/the_repository.pending.cocci
+++ b/contrib/coccinelle/the_repository.pending.cocci
@@ -142,3 +142,14 @@ expression H;
 - format_commit_message(
 + repo_format_commit_message(the_repository,
   E, F, G, H);
+
+@@
+expression E;
+expression F;
+expression G;
+expression H;
+@@
+- config_with_options(
++ repo_config_with_options(the_repository,
+  E, F, G, H);
+
diff --git a/submodule-config.c b/submodule-config.c
index 4264ee216f..1d28b17071 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -681,7 +681,7 @@ void gitmodules_config_oid(const struct object_id *commit_oid)
 	submodule_cache_check_init(the_repository);
 
 	if (gitmodule_oid_from_commit(commit_oid, &oid, &rev)) {
-		git_config_from_blob_oid(gitmodules_cb, rev.buf,
+		git_config_from_blob_oid(the_repository, gitmodules_cb, rev.buf,
 					 &oid, the_repository);
 	}
 	strbuf_release(&rev);
-- 
2.22.0

