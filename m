Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B60C19F2A
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 19:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238824AbiG2T3z (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 15:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238715AbiG2T3t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 15:29:49 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADE25FACB
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 12:29:47 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id x23-20020a05600c179700b003a30e3e7989so2933678wmo.0
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 12:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SaPL8Oci9QgOPfLUSeQl8NMVH0gyPAwGHimYdcNV2Ng=;
        b=aD9LksJUOGbi3XqKnr3A0qzvk3klCs4J8gZbnsJ2+BijWOgiWrvNRv9avWMnYsX0kI
         NydG1HKDAvZfytH2E1nFOHFE2Xx5RvU48WMy09Qm/k0W+81LdoFsxiOpt573FxhSKIxx
         4hNcfijqic2mSzjoyLzAZptW8pomm5USXj3IzJephx0CWJab+xmNJNOd1A9VcjFFlzZ1
         0x1E+SfaLvNflqG8GHVDzwpkR4GQcUkC/2D3MWtxAHVnqpEyKcTFdOvyeiYNIxHQvppb
         Ztl67PBrJdMUN9bhqhd+CJWULfZjPGsQQ2qtIkLmX5ycZq5stWsgMEsvrLg7oi0Vbp++
         tGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SaPL8Oci9QgOPfLUSeQl8NMVH0gyPAwGHimYdcNV2Ng=;
        b=2Gu8L8zjFTP8u3AJSprzVxCi6LB94Kfcw/igbOvdyU7Q4IGoystLf+Zmw6sdUmmc0U
         sPDsJlSO8s02bO5L7qoXSn4dMRmG1/ezerdXbDHtAgqgbugwO0SDg0eKQBCevqyDtr6y
         OkU3UzTAxbwjzxN9V8keFfqKX6fwP70BwBiPuXV8D7XxiyX6QgL8CpKVxd6V4VW2MCki
         IRdTL5wpVgIyWe+I1y61vjd3UtttQVJ4bePAoAG6YbrNwJ9DNMIGTYXu7ZSGuY8rRn5J
         tRArpKhCRY5Xh+xlijRTqML0IIB0uyV4nn8mv5BqVDgzlDEW51Pc00qjZVISw9EkfWNC
         VcHQ==
X-Gm-Message-State: AJIora9C6ikEZ73CgtfgZZFwZa6QFOrM6MlzmMdT63h+FahB7oDW7GHK
        M9DRt6CyML440B1k6zWgGxTvdgx6z14=
X-Google-Smtp-Source: AGRyM1suE94Caj5Nh77h9CKYc1Cav8w2yxFn1pPNZiFeiihyRCjXzQr6nk09zY+jGKUco3qcS7o/1A==
X-Received: by 2002:a05:600c:358d:b0:3a3:3819:c07 with SMTP id p13-20020a05600c358d00b003a338190c07mr4010425wmq.76.1659122985334;
        Fri, 29 Jul 2022 12:29:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g9-20020a05600c4ec900b003a3199c243bsm12331942wmq.0.2022.07.29.12.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 12:29:44 -0700 (PDT)
Message-Id: <8da0b0a31810c8221ad3ab13b8c41cf1a266c2c0.1659122979.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
References: <pull.1301.git.1658844250.gitgitgadget@gmail.com>
        <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Jul 2022 19:29:33 +0000
Subject: [PATCH v2 04/10] refs: use ref_namespaces for replace refs base
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        steadmon@google.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The git_replace_ref_base global is used to store the value of the
GIT_REPLACE_REF_BASE environment variable or the default of
"refs/replace/". This is initialized within setup_git_env().

The ref_namespaces array is a new centralized location for information
such as the ref namespace used for replace refs. Instead of having this
namespace stored in two places, use the ref_namespaces array instead.

For simplicity, create a local git_replace_ref_base variable wherever
the global was previously used.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/replace.c | 3 +++
 cache.h           | 1 -
 environment.c     | 3 +--
 log-tree.c        | 2 ++
 refs.c            | 1 +
 5 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index 583702a0980..6b97ef2348b 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -106,6 +106,7 @@ static int for_each_replace_name(const char **argv, each_replace_name_fn fn)
 	size_t base_len;
 	int had_error = 0;
 	struct object_id oid;
+	const char *git_replace_ref_base = ref_namespaces[NAMESPACE_REPLACE].ref;
 
 	strbuf_addstr(&ref, git_replace_ref_base);
 	base_len = ref.len;
@@ -147,6 +148,8 @@ static int check_ref_valid(struct object_id *object,
 			    struct strbuf *ref,
 			    int force)
 {
+	const char *git_replace_ref_base = ref_namespaces[NAMESPACE_REPLACE].ref;
+
 	strbuf_reset(ref);
 	strbuf_addf(ref, "%s%s", git_replace_ref_base, oid_to_hex(object));
 	if (check_refname_format(ref->buf, 0))
diff --git a/cache.h b/cache.h
index ac5ab4ef9d3..631a4f388d6 100644
--- a/cache.h
+++ b/cache.h
@@ -1008,7 +1008,6 @@ void reset_shared_repository(void);
  * commands that do not want replace references to be active.
  */
 extern int read_replace_refs;
-extern char *git_replace_ref_base;
 
 /*
  * These values are used to help identify parts of a repository to fsync.
diff --git a/environment.c b/environment.c
index 9eb22f975c7..b2004437dce 100644
--- a/environment.c
+++ b/environment.c
@@ -56,7 +56,6 @@ const char *askpass_program;
 const char *excludes_file;
 enum auto_crlf auto_crlf = AUTO_CRLF_FALSE;
 int read_replace_refs = 1;
-char *git_replace_ref_base;
 enum eol core_eol = EOL_UNSET;
 int global_conv_flags_eol = CONV_EOL_RNDTRP_WARN;
 char *check_roundtrip_encoding = "SHIFT-JIS";
@@ -162,6 +161,7 @@ const char *getenv_safe(struct strvec *argv, const char *name)
 
 void setup_git_env(const char *git_dir)
 {
+	char *git_replace_ref_base;
 	const char *shallow_file;
 	const char *replace_ref_base;
 	struct set_gitdir_args args = { NULL };
@@ -182,7 +182,6 @@ void setup_git_env(const char *git_dir)
 	if (getenv(NO_REPLACE_OBJECTS_ENVIRONMENT))
 		read_replace_refs = 0;
 	replace_ref_base = getenv(GIT_REPLACE_REF_BASE_ENVIRONMENT);
-	free(git_replace_ref_base);
 	git_replace_ref_base = xstrdup(replace_ref_base ? replace_ref_base
 							  : "refs/replace/");
 	update_ref_namespace(NAMESPACE_REPLACE, git_replace_ref_base);
diff --git a/log-tree.c b/log-tree.c
index d0ac0a6327a..bb80f1a94d2 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -141,10 +141,12 @@ static int add_ref_decoration(const char *refname, const struct object_id *oid,
 	enum object_type objtype;
 	enum decoration_type deco_type = DECORATION_NONE;
 	struct decoration_filter *filter = (struct decoration_filter *)cb_data;
+	const char *git_replace_ref_base;
 
 	if (filter && !ref_filter_match(refname, filter))
 		return 0;
 
+	git_replace_ref_base = ref_namespaces[NAMESPACE_REPLACE].ref;
 	if (starts_with(refname, git_replace_ref_base)) {
 		struct object_id original_oid;
 		if (!read_replace_refs)
diff --git a/refs.c b/refs.c
index 8e87cc7efb0..0da089d760b 100644
--- a/refs.c
+++ b/refs.c
@@ -1607,6 +1607,7 @@ int refs_for_each_fullref_in(struct ref_store *refs, const char *prefix,
 
 int for_each_replace_ref(struct repository *r, each_repo_ref_fn fn, void *cb_data)
 {
+	const char *git_replace_ref_base = ref_namespaces[NAMESPACE_REPLACE].ref;
 	return do_for_each_repo_ref(r, git_replace_ref_base, fn,
 				    strlen(git_replace_ref_base),
 				    DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
-- 
gitgitgadget

