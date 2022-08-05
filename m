Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956C1C25B08
	for <git@archiver.kernel.org>; Fri,  5 Aug 2022 17:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241598AbiHER7V (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Aug 2022 13:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241341AbiHER7B (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Aug 2022 13:59:01 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7B911A28
        for <git@vger.kernel.org>; Fri,  5 Aug 2022 10:58:58 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id i128-20020a1c3b86000000b003a3a22178beso4295385wma.3
        for <git@vger.kernel.org>; Fri, 05 Aug 2022 10:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=KKnyNzwAD9eDmWcpT7sL0qxY8v2q73FGux6hnRLJGR8=;
        b=oWUpNC3emZwlooqJdkGI5yeS18PE/I+7rpkStMgdUbD9m5vohFfDOBoiMDXg3wufst
         unp5PAYzJfCT8OelPBV2gixZD1C0C1kCEjZvXpFraJhVIGkhHkqQRtLQIMW2f+HUxmO0
         IRl01J++BbNWCYpgptXNOTZAo8p/pzTew62cY1zRh6kGmfNeKiEQGkb+y6x1NnpG+ovV
         wOv2HU5YpbnXb3wI1QsegGo/qSL5G8L4W/cmdpgTQbW3cfQ/k2g1Kx2D9hU6Jdz2pL2J
         LchKKbyXQPl3Qm4WIx8IfSRuz3+VPaaxDTvfgAeSuxdXZAn2OPp8osHXkk9WHewprTXq
         lqeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=KKnyNzwAD9eDmWcpT7sL0qxY8v2q73FGux6hnRLJGR8=;
        b=5W1AIdnxwy7NCXUeq5tSuBVHjz+VOgcVzFbrGaNq1cLXV59Pye0fCYAd3O2liTJGln
         sqsVF5jO0T3sQCDjU8m9yudn4m7+Y+8B6sUvq3GGchny+AIP8A2BgL49echDWyThmtN9
         HxTiTQYHOHLIuqTEL+hYmJXLoZD5QSqpFF5UsGSrD7ClL2J71eV+ANZAFA6NKJmfEvwA
         +rXVUCUQzh7JmQw4sRXAFbFL6dLfhIw2Yux7dJ58xP9yKAPLErmHf5A8B4b22AJDozw9
         so/Nd0nMICPvkophUrT0rPkIyjKP1I2l/4OnMfCtH36DLBk1VCKFBVB/9G/mv1Prcx3Y
         djXg==
X-Gm-Message-State: ACgBeo0JpnBzlVESonahLW6yse2tCAblReYscP8IUUncldLuu8RrC9/L
        68Zdp0r+eScmYEIYJhLj81L50gc5qHI=
X-Google-Smtp-Source: AA6agR7wycJBgldoxN+QEmNqTW7I7bXY9XX3nCZTrdXt37woE34qWtrEI4wx1a8DSZftJ4+gJn9V5A==
X-Received: by 2002:a05:600c:19cc:b0:3a3:10bd:9211 with SMTP id u12-20020a05600c19cc00b003a310bd9211mr5393550wmq.106.1659722337117;
        Fri, 05 Aug 2022 10:58:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l8-20020a05600c4f0800b003a17ab4e7c8sm11217977wmq.39.2022.08.05.10.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 10:58:56 -0700 (PDT)
Message-Id: <45e3ce94d0dac9ff935a01d936c2c9638fe9d364.1659722324.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1301.v3.git.1659722323.gitgitgadget@gmail.com>
References: <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
        <pull.1301.v3.git.1659722323.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Aug 2022 17:58:37 +0000
Subject: [PATCH v3 05/11] refs: use ref_namespaces for replace refs base
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        steadmon@google.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <derrickstolee@github.com>,
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
 log-tree.c        | 1 +
 refs.c            | 1 +
 5 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index 583702a0980..a29e911d309 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -106,6 +106,7 @@ static int for_each_replace_name(const char **argv, each_replace_name_fn fn)
 	size_t base_len;
 	int had_error = 0;
 	struct object_id oid;
+	const char *git_replace_ref_base = ref_namespace[NAMESPACE_REPLACE].ref;
 
 	strbuf_addstr(&ref, git_replace_ref_base);
 	base_len = ref.len;
@@ -147,6 +148,8 @@ static int check_ref_valid(struct object_id *object,
 			    struct strbuf *ref,
 			    int force)
 {
+	const char *git_replace_ref_base = ref_namespace[NAMESPACE_REPLACE].ref;
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
index d0ac0a6327a..1b2c76c5bb9 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -141,6 +141,7 @@ static int add_ref_decoration(const char *refname, const struct object_id *oid,
 	enum object_type objtype;
 	enum decoration_type deco_type = DECORATION_NONE;
 	struct decoration_filter *filter = (struct decoration_filter *)cb_data;
+	const char *git_replace_ref_base = ref_namespace[NAMESPACE_REPLACE].ref;
 
 	if (filter && !ref_filter_match(refname, filter))
 		return 0;
diff --git a/refs.c b/refs.c
index 65decf25d09..92819732ab7 100644
--- a/refs.c
+++ b/refs.c
@@ -1612,6 +1612,7 @@ int refs_for_each_fullref_in(struct ref_store *refs, const char *prefix,
 
 int for_each_replace_ref(struct repository *r, each_repo_ref_fn fn, void *cb_data)
 {
+	const char *git_replace_ref_base = ref_namespace[NAMESPACE_REPLACE].ref;
 	return do_for_each_repo_ref(r, git_replace_ref_base, fn,
 				    strlen(git_replace_ref_base),
 				    DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
-- 
gitgitgadget

