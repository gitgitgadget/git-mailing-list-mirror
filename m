Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2FEECAAD3
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 16:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiISQfA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 12:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiISQe5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 12:34:57 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F80F120A1
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 09:34:54 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id y5so4876806wrh.3
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 09:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=k9NZ9PpICrZIcHmW2jHGyjFNUx4jO6fy1d0dxN5TDTk=;
        b=HMj4m/+4LJuR+PYzRxpYbwJeYMxuVaxOUCQc8jwG9PhhmId9b/IzTR9FbJcwttqcsA
         vg+EHoIRQ/A9DEsfE8adp2YTHlFXogOCFuWVHopX8uMIo2S68C34QWLXbta7aS/kRPjd
         QSF91YPtx8yd7NXkzk0inQwVUkRlhwCEeNTctfeBkjL43qtLVQCPDvIHGTebf+QkXh7F
         b+Wrecmh6QeyXT4MoyGkGnQ4qFTZxWXvj7yk2m9KVU9UWRQ09mGbZTm71OA3ebQweYT6
         cCC6mBWcD+lPR6App1I7oC0/kPBKYE8U/BdaYpWW1MdaCuj5KssehBYqyX8zyZdNPXyf
         gzWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=k9NZ9PpICrZIcHmW2jHGyjFNUx4jO6fy1d0dxN5TDTk=;
        b=fAO23NsDVV5VRcJGHp8o9WHkq6E1bXMgedbMqM8z7+IrdHH4RlfMXmLQr7grrkmUm0
         YSzl5nV7sd3OxOuhtI96NkrfSHdMObeyfUnu7uz8xxvQZa317WxCnd1Xu3HFRXKGA+Ca
         0ldGgBa07ZmSlbCmDZrUApoGDkD0dGYMSLmQKYGvivqB8lPKfDD0tGOl2LRP915s/RpP
         dpBdiJFHOb5Ic2UJBrWscCRhmbeHoiT0Tic3dF4Oq6M4c25cPVS55f3qGKxhhNdIdawO
         4wy8AwO25/tErCh4SLC56GvRRribJrBkaBNRiLKOCidZY/TU2JSBtEFT5kQGG1tsL19H
         j4lw==
X-Gm-Message-State: ACrzQf0iEIIuZBbrWTGj8iQvUASgcQHJmDN9lfT8lghpkYH9x9sPpU+6
        qYKjIrrlwRrK/Cp1ZDEUbK0h3fem8kc=
X-Google-Smtp-Source: AMsMyM5dQPvPgBoHfOo80rCWofmf+tQgFX/OTpnS/71cHAKm9381mn7i+EgTEQEGutyXWpSjZmrFQA==
X-Received: by 2002:adf:ef06:0:b0:228:d60c:cf74 with SMTP id e6-20020adfef06000000b00228d60ccf74mr11110370wro.302.1663605292459;
        Mon, 19 Sep 2022 09:34:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m17-20020adfe951000000b0022afddab5dfsm4469702wrn.7.2022.09.19.09.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 09:34:52 -0700 (PDT)
Message-Id: <pull.1325.v2.git.git.1663605291172.gitgitgadget@gmail.com>
In-Reply-To: <pull.1325.git.git.1663002096207.gitgitgadget@gmail.com>
References: <pull.1325.git.git.1663002096207.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Sep 2022 16:34:50 +0000
Subject: [PATCH v2] refs: unify parse_worktree_ref() and ref_type()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

The logic to handle worktree refs (worktrees/NAME/REF and
main-worktree/REF) existed in two places:

* ref_type() in refs.c

* parse_worktree_ref() in worktree.c

Collapse this logic together in one function parse_worktree_ref():
this avoids having to cross-check the result of parse_worktree_ref()
and ref_type().

Introduce enum ref_worktree_type, which is slightly different from
enum ref_type. The latter is a misleading name (one would think that
'ref_type' would have the symref option).

Instead, enum ref_worktree_type only makes explicit how a refname
relates to a worktree. From this point of view, HEAD and
refs/bisect/abc are the same: they specify the current worktree
implicitly.

The files-backend must avoid packing refs/bisect/* and friends into
packed-refs, so expose is_per_worktree_ref() separately.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
    refs: unify parse_worktree_ref() and ref_type()
    
    The logic to handle worktree refs (worktrees/NAME/REF and
    main-worktree/REF) existed in two places:
    
     * ref_type() in refs.c
    
     * parse_worktree_ref() in worktree.c
    
    Collapse this logic together in one function parse_worktree_ref(): this
    avoids having to cross-check the result of parse_worktree_ref() and
    ref_type().
    
    Introduce enum ref_worktree_type, which is slightly different from enum
    ref_type. The latter is a misleading name (one would think that
    'ref_type' would have the symref option).
    
    Instead, enum ref_worktree_type only makes explicit how a refname
    relates to a worktree. From this point of view, HEAD and refs/bisect/abc
    are the same: they specify the current worktree implicitly.
    
    The files-backend must avoid packing refs/bisect/* and friends into
    packed-refs, so expose is_per_worktree_ref() separately.
    
    Signed-off-by: Han-Wen Nienhuys hanwen@google.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1325%2Fhanwen%2Fparse-worktree-ref-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1325/hanwen/parse-worktree-ref-v2
Pull-Request: https://github.com/git/git/pull/1325

Range-diff vs v1:

 1:  e2d19b80f76 ! 1:  b1e6dc0edc7 refs: unify parse_worktree_ref() and ref_type()
     @@ refs.c: static int is_pseudoref_syntax(const char *refname)
       			return 0;
       	}
       
     -+	/* HEAD is not a pseudoref, but it certainly uses the
     -+	 * pseudoref syntax. */
     ++	/*
     ++	 * HEAD is not a pseudoref, but it certainly uses the
     ++	 * pseudoref syntax.
     ++	 */
       	return 1;
       }
       
      -static int is_main_pseudoref_syntax(const char *refname)
     -+enum ref_worktree_type parse_worktree_ref(const char *worktree_ref,
     -+					  const char **name, int *name_length,
     -+					  const char **ref)
     - {
     +-{
      -	return skip_prefix(refname, "main-worktree/", &refname) &&
      -		*refname &&
      -		is_pseudoref_syntax(refname);
     --}
     -+	const char *name_dummy;
     -+	int name_length_dummy;
     -+	const char *ref_dummy;
     -+	if (!name)
     -+		name = &name_dummy;
     -+	if (!name_length)
     -+		name_length = &name_length_dummy;
     -+	if (!ref)
     -+		ref = &ref_dummy;
     ++static int is_current_worktree_ref(const char *ref) {
     ++	return is_pseudoref_syntax(ref) || is_per_worktree_ref(ref);
     + }
       
      -static int is_other_pseudoref_syntax(const char *refname)
     --{
     ++enum ref_worktree_type parse_worktree_ref(const char *maybe_worktree_ref,
     ++					  const char **worktree_name, int *worktree_name_length,
     ++					  const char **bare_refname)
     + {
      -	if (!skip_prefix(refname, "worktrees/", &refname))
      -		return 0;
      -	refname = strchr(refname, '/');
     @@ refs.c: static int is_pseudoref_syntax(const char *refname)
      -		return 0;
      -	return is_pseudoref_syntax(refname + 1);
      -}
     -+	*ref = worktree_ref;
     -+	if (is_pseudoref_syntax(worktree_ref)) {
     -+		return REF_WORKTREE_CURRENT;
     -+	}
     ++	const char *name_dummy;
     ++	int name_length_dummy;
     ++	const char *ref_dummy;
       
      -enum ref_type ref_type(const char *refname)
      -{
     @@ refs.c: static int is_pseudoref_syntax(const char *refname)
      -	if (is_other_pseudoref_syntax(refname))
      -		return REF_TYPE_OTHER_PSEUDOREF;
      -	return REF_TYPE_NORMAL;
     -+	if (is_per_worktree_ref(worktree_ref)) {
     -+		return REF_WORKTREE_CURRENT;
     -+	}
     ++	if (!worktree_name)
     ++		worktree_name = &name_dummy;
     ++	if (!worktree_name_length)
     ++		worktree_name_length = &name_length_dummy;
     ++	if (!bare_refname)
     ++		bare_refname = &ref_dummy;
      +
     -+	if (skip_prefix(worktree_ref, "main-worktree/", &worktree_ref)) {
     -+		if (!*worktree_ref)
     -+			return -1;
     -+		*name = NULL;
     -+		*name_length = 0;
     -+		*ref = worktree_ref;
     ++	if (skip_prefix(maybe_worktree_ref, "worktrees/", bare_refname)) {
     ++		const char *slash = strchr(*bare_refname, '/');
      +
     -+		if (parse_worktree_ref(*ref, NULL, NULL, NULL) ==
     -+		    REF_WORKTREE_CURRENT)
     -+			return REF_WORKTREE_MAIN;
     -+	}
     -+	if (skip_prefix(worktree_ref, "worktrees/", &worktree_ref)) {
     -+		const char *slash = strchr(worktree_ref, '/');
     ++		*worktree_name = *bare_refname;
     ++		if (!slash) {
     ++			*worktree_name_length = strlen(*worktree_name);
      +
     -+		if (!slash || slash == worktree_ref || !slash[1])
     -+			return -1;
     -+		*name = worktree_ref;
     -+		*name_length = slash - worktree_ref;
     -+		*ref = slash + 1;
     ++			/* This is an error condition, and the caller tell because the bare_refname is "" */
     ++			*bare_refname = *worktree_name + *worktree_name_length;
     ++			return REF_WORKTREE_OTHER;
     ++		}
     ++
     ++		*worktree_name_length = slash - *bare_refname;
     ++		*bare_refname = slash + 1;
      +
     -+		if (parse_worktree_ref(*ref, NULL, NULL, NULL) ==
     -+		    REF_WORKTREE_CURRENT)
     ++		if (is_current_worktree_ref(*bare_refname))
      +			return REF_WORKTREE_OTHER;
      +	}
      +
     ++	*worktree_name = NULL;
     ++	*worktree_name_length = 0;
     ++
     ++	if (skip_prefix(maybe_worktree_ref, "main-worktree/", bare_refname)
     ++	    && is_current_worktree_ref(*bare_refname))
     ++		return REF_WORKTREE_MAIN;
     ++
     ++	*bare_refname = maybe_worktree_ref;
     ++	if (is_current_worktree_ref(maybe_worktree_ref))
     ++		return REF_WORKTREE_CURRENT;
     ++
      +	return REF_WORKTREE_SHARED;
       }
       
     @@ refs.h: int parse_hide_refs_config(const char *var, const char *value, const cha
      +	REF_WORKTREE_CURRENT, /* implicitly per worktree, eg. HEAD or
      +				 refs/bisect/SOMETHING */
      +	REF_WORKTREE_MAIN, /* explicitly in main worktree, eg.
     -+			      refs/main-worktree/HEAD */
     ++			      main-worktree/HEAD */
      +	REF_WORKTREE_OTHER, /* explicitly in named worktree, eg.
     -+			       refs/worktrees/bla/HEAD */
     ++			       worktrees/bla/HEAD */
      +	REF_WORKTREE_SHARED, /* the default, eg. refs/heads/main */
       };
       
      -enum ref_type ref_type(const char *refname);
     -+/* Parse a ref that possibly explicitly refers to a worktree ref
     -+ * (ie. either REFNAME, main-worktree/REFNAME or
     -+ * worktree/WORKTREE/REFNAME). If the name references a worktree
     -+ * implicitly or explicitly, return what kind it was. The
     -+ * worktree_name, worktree_name_length and refname argument maybe NULL.
     ++/*
     ++ * Parse a `maybe_worktree_ref` as a ref that possibly refers to a worktree ref
     ++ * (ie. either REFNAME, main-worktree/REFNAME or worktree/WORKTREE/REFNAME). It
     ++ * returns what kind of ref was found, and in case of REF_WORKTREE_OTHER, the
     ++ * worktree name is returned in `worktree_name` (pointing into
     ++ * `maybe_worktree_ref`) and `worktree_name_length`. The bare refname (the
     ++ * refname stripped of prefixes) is returned in `bare_refname`. The
     ++ * `worktree_name`, `worktree_name_length` and `bare_refname` arguments may be
     ++ * NULL.
      + */
      +enum ref_worktree_type parse_worktree_ref(const char *maybe_worktree_ref,
      +					  const char **worktree_name,
      +					  int *worktree_name_length,
     -+					  const char **refname);
     ++					  const char **bare_refname);
       
       enum expire_reflog_flags {
       	EXPIRE_REFLOGS_DRY_RUN = 1 << 0,


 builtin/reflog.c      |  3 +-
 reflog.c              | 13 ++-----
 refs.c                | 76 ++++++++++++++++++++++++++--------------
 refs.h                | 33 ++++++++++++++----
 refs/files-backend.c  | 80 +++++++++++++++++++------------------------
 refs/packed-backend.c |  2 +-
 worktree.c            | 59 ++++---------------------------
 worktree.h            | 10 ------
 8 files changed, 126 insertions(+), 150 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 9407f835cb6..bd568d2d931 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -26,7 +26,8 @@ static int collect_reflog(const char *ref, const struct object_id *oid, int unus
 	 * Avoid collecting the same shared ref multiple times because
 	 * they are available via all worktrees.
 	 */
-	if (!worktree->is_current && ref_type(ref) == REF_TYPE_NORMAL)
+	if (!worktree->is_current &&
+	    parse_worktree_ref(ref, NULL, NULL, NULL) == REF_WORKTREE_SHARED)
 		return 0;
 
 	strbuf_worktree_ref(worktree, &newref, ref);
diff --git a/reflog.c b/reflog.c
index 47ba8620c56..0b8b767f97c 100644
--- a/reflog.c
+++ b/reflog.c
@@ -310,16 +310,9 @@ static int push_tip_to_list(const char *refname, const struct object_id *oid,
 
 static int is_head(const char *refname)
 {
-	switch (ref_type(refname)) {
-	case REF_TYPE_OTHER_PSEUDOREF:
-	case REF_TYPE_MAIN_PSEUDOREF:
-		if (parse_worktree_ref(refname, NULL, NULL, &refname))
-			BUG("not a worktree ref: %s", refname);
-		break;
-	default:
-		break;
-	}
-	return !strcmp(refname, "HEAD");
+	const char *stripped_refname;
+	parse_worktree_ref(refname, NULL, NULL, &stripped_refname);
+	return !strcmp(stripped_refname, "HEAD");
 }
 
 void reflog_expiry_prepare(const char *refname,
diff --git a/refs.c b/refs.c
index 1a964505f92..6e86607f3bb 100644
--- a/refs.c
+++ b/refs.c
@@ -722,7 +722,7 @@ int dwim_log(const char *str, int len, struct object_id *oid, char **log)
 	return repo_dwim_log(the_repository, str, len, oid, log);
 }
 
-static int is_per_worktree_ref(const char *refname)
+int is_per_worktree_ref(const char *refname)
 {
 	return starts_with(refname, "refs/worktree/") ||
 	       starts_with(refname, "refs/bisect/") ||
@@ -738,37 +738,63 @@ static int is_pseudoref_syntax(const char *refname)
 			return 0;
 	}
 
+	/*
+	 * HEAD is not a pseudoref, but it certainly uses the
+	 * pseudoref syntax.
+	 */
 	return 1;
 }
 
-static int is_main_pseudoref_syntax(const char *refname)
-{
-	return skip_prefix(refname, "main-worktree/", &refname) &&
-		*refname &&
-		is_pseudoref_syntax(refname);
+static int is_current_worktree_ref(const char *ref) {
+	return is_pseudoref_syntax(ref) || is_per_worktree_ref(ref);
 }
 
-static int is_other_pseudoref_syntax(const char *refname)
+enum ref_worktree_type parse_worktree_ref(const char *maybe_worktree_ref,
+					  const char **worktree_name, int *worktree_name_length,
+					  const char **bare_refname)
 {
-	if (!skip_prefix(refname, "worktrees/", &refname))
-		return 0;
-	refname = strchr(refname, '/');
-	if (!refname || !refname[1])
-		return 0;
-	return is_pseudoref_syntax(refname + 1);
-}
+	const char *name_dummy;
+	int name_length_dummy;
+	const char *ref_dummy;
 
-enum ref_type ref_type(const char *refname)
-{
-	if (is_per_worktree_ref(refname))
-		return REF_TYPE_PER_WORKTREE;
-	if (is_pseudoref_syntax(refname))
-		return REF_TYPE_PSEUDOREF;
-	if (is_main_pseudoref_syntax(refname))
-		return REF_TYPE_MAIN_PSEUDOREF;
-	if (is_other_pseudoref_syntax(refname))
-		return REF_TYPE_OTHER_PSEUDOREF;
-	return REF_TYPE_NORMAL;
+	if (!worktree_name)
+		worktree_name = &name_dummy;
+	if (!worktree_name_length)
+		worktree_name_length = &name_length_dummy;
+	if (!bare_refname)
+		bare_refname = &ref_dummy;
+
+	if (skip_prefix(maybe_worktree_ref, "worktrees/", bare_refname)) {
+		const char *slash = strchr(*bare_refname, '/');
+
+		*worktree_name = *bare_refname;
+		if (!slash) {
+			*worktree_name_length = strlen(*worktree_name);
+
+			/* This is an error condition, and the caller tell because the bare_refname is "" */
+			*bare_refname = *worktree_name + *worktree_name_length;
+			return REF_WORKTREE_OTHER;
+		}
+
+		*worktree_name_length = slash - *bare_refname;
+		*bare_refname = slash + 1;
+
+		if (is_current_worktree_ref(*bare_refname))
+			return REF_WORKTREE_OTHER;
+	}
+
+	*worktree_name = NULL;
+	*worktree_name_length = 0;
+
+	if (skip_prefix(maybe_worktree_ref, "main-worktree/", bare_refname)
+	    && is_current_worktree_ref(*bare_refname))
+		return REF_WORKTREE_MAIN;
+
+	*bare_refname = maybe_worktree_ref;
+	if (is_current_worktree_ref(maybe_worktree_ref))
+		return REF_WORKTREE_CURRENT;
+
+	return REF_WORKTREE_SHARED;
 }
 
 long get_files_ref_lock_timeout_ms(void)
diff --git a/refs.h b/refs.h
index 23479c7ee09..a42957a7917 100644
--- a/refs.h
+++ b/refs.h
@@ -825,15 +825,34 @@ int parse_hide_refs_config(const char *var, const char *value, const char *);
  */
 int ref_is_hidden(const char *, const char *);
 
-enum ref_type {
-	REF_TYPE_PER_WORKTREE,	  /* refs inside refs/ but not shared       */
-	REF_TYPE_PSEUDOREF,	  /* refs outside refs/ in current worktree */
-	REF_TYPE_MAIN_PSEUDOREF,  /* pseudo refs from the main worktree     */
-	REF_TYPE_OTHER_PSEUDOREF, /* pseudo refs from other worktrees       */
-	REF_TYPE_NORMAL,	  /* normal/shared refs inside refs/        */
+/* Is this a per-worktree ref living in the refs/ namespace? */
+int is_per_worktree_ref(const char *refname);
+
+/* Describes how a refname relates to worktrees */
+enum ref_worktree_type {
+	REF_WORKTREE_CURRENT, /* implicitly per worktree, eg. HEAD or
+				 refs/bisect/SOMETHING */
+	REF_WORKTREE_MAIN, /* explicitly in main worktree, eg.
+			      main-worktree/HEAD */
+	REF_WORKTREE_OTHER, /* explicitly in named worktree, eg.
+			       worktrees/bla/HEAD */
+	REF_WORKTREE_SHARED, /* the default, eg. refs/heads/main */
 };
 
-enum ref_type ref_type(const char *refname);
+/*
+ * Parse a `maybe_worktree_ref` as a ref that possibly refers to a worktree ref
+ * (ie. either REFNAME, main-worktree/REFNAME or worktree/WORKTREE/REFNAME). It
+ * returns what kind of ref was found, and in case of REF_WORKTREE_OTHER, the
+ * worktree name is returned in `worktree_name` (pointing into
+ * `maybe_worktree_ref`) and `worktree_name_length`. The bare refname (the
+ * refname stripped of prefixes) is returned in `bare_refname`. The
+ * `worktree_name`, `worktree_name_length` and `bare_refname` arguments may be
+ * NULL.
+ */
+enum ref_worktree_type parse_worktree_ref(const char *maybe_worktree_ref,
+					  const char **worktree_name,
+					  int *worktree_name_length,
+					  const char **bare_refname);
 
 enum expire_reflog_flags {
 	EXPIRE_REFLOGS_DRY_RUN = 1 << 0,
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 95acab78eef..f230704229e 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -138,44 +138,30 @@ static struct files_ref_store *files_downcast(struct ref_store *ref_store,
 	return refs;
 }
 
-static void files_reflog_path_other_worktrees(struct files_ref_store *refs,
-					      struct strbuf *sb,
-					      const char *refname)
-{
-	const char *real_ref;
-	const char *worktree_name;
-	int length;
-
-	if (parse_worktree_ref(refname, &worktree_name, &length, &real_ref))
-		BUG("refname %s is not a other-worktree ref", refname);
-
-	if (worktree_name)
-		strbuf_addf(sb, "%s/worktrees/%.*s/logs/%s", refs->gitcommondir,
-			    length, worktree_name, real_ref);
-	else
-		strbuf_addf(sb, "%s/logs/%s", refs->gitcommondir,
-			    real_ref);
-}
-
 static void files_reflog_path(struct files_ref_store *refs,
 			      struct strbuf *sb,
 			      const char *refname)
 {
-	switch (ref_type(refname)) {
-	case REF_TYPE_PER_WORKTREE:
-	case REF_TYPE_PSEUDOREF:
+	const char *bare_refname;
+	const char *wtname;
+	int wtname_len;
+	enum ref_worktree_type wt_type = parse_worktree_ref(
+		refname, &wtname, &wtname_len, &bare_refname);
+
+	switch (wt_type) {
+	case REF_WORKTREE_CURRENT:
 		strbuf_addf(sb, "%s/logs/%s", refs->base.gitdir, refname);
 		break;
-	case REF_TYPE_OTHER_PSEUDOREF:
-	case REF_TYPE_MAIN_PSEUDOREF:
-		files_reflog_path_other_worktrees(refs, sb, refname);
+	case REF_WORKTREE_SHARED:
+	case REF_WORKTREE_MAIN:
+		strbuf_addf(sb, "%s/logs/%s", refs->gitcommondir, bare_refname);
 		break;
-	case REF_TYPE_NORMAL:
-		strbuf_addf(sb, "%s/logs/%s", refs->gitcommondir, refname);
+	case REF_WORKTREE_OTHER:
+		strbuf_addf(sb, "%s/worktrees/%.*s/logs/%s", refs->gitcommondir,
+			    wtname_len, wtname, bare_refname);
 		break;
 	default:
-		BUG("unknown ref type %d of ref %s",
-		    ref_type(refname), refname);
+		BUG("unknown ref type %d of ref %s", wt_type, refname);
 	}
 }
 
@@ -183,22 +169,25 @@ static void files_ref_path(struct files_ref_store *refs,
 			   struct strbuf *sb,
 			   const char *refname)
 {
-	switch (ref_type(refname)) {
-	case REF_TYPE_PER_WORKTREE:
-	case REF_TYPE_PSEUDOREF:
+	const char *bare_refname;
+	const char *wtname;
+	int wtname_len;
+	enum ref_worktree_type wt_type = parse_worktree_ref(
+		refname, &wtname, &wtname_len, &bare_refname);
+	switch (wt_type) {
+	case REF_WORKTREE_CURRENT:
 		strbuf_addf(sb, "%s/%s", refs->base.gitdir, refname);
 		break;
-	case REF_TYPE_MAIN_PSEUDOREF:
-		if (!skip_prefix(refname, "main-worktree/", &refname))
-			BUG("ref %s is not a main pseudoref", refname);
-		/* fallthrough */
-	case REF_TYPE_OTHER_PSEUDOREF:
-	case REF_TYPE_NORMAL:
-		strbuf_addf(sb, "%s/%s", refs->gitcommondir, refname);
+	case REF_WORKTREE_OTHER:
+		strbuf_addf(sb, "%s/worktrees/%.*s/%s", refs->gitcommondir,
+			    wtname_len, wtname, bare_refname);
+		break;
+	case REF_WORKTREE_SHARED:
+	case REF_WORKTREE_MAIN:
+		strbuf_addf(sb, "%s/%s", refs->gitcommondir, bare_refname);
 		break;
 	default:
-		BUG("unknown ref type %d of ref %s",
-		    ref_type(refname), refname);
+		BUG("unknown ref type %d of ref %s", wt_type, refname);
 	}
 }
 
@@ -771,7 +760,8 @@ static int files_ref_iterator_advance(struct ref_iterator *ref_iterator)
 
 	while ((ok = ref_iterator_advance(iter->iter0)) == ITER_OK) {
 		if (iter->flags & DO_FOR_EACH_PER_WORKTREE_ONLY &&
-		    ref_type(iter->iter0->refname) != REF_TYPE_PER_WORKTREE)
+		    parse_worktree_ref(iter->iter0->refname, NULL, NULL,
+				       NULL) != REF_WORKTREE_CURRENT)
 			continue;
 
 		if ((iter->flags & DO_FOR_EACH_OMIT_DANGLING_SYMREFS) &&
@@ -1179,7 +1169,8 @@ static int should_pack_ref(const char *refname,
 			   unsigned int pack_flags)
 {
 	/* Do not pack per-worktree refs: */
-	if (ref_type(refname) != REF_TYPE_NORMAL)
+	if (parse_worktree_ref(refname, NULL, NULL, NULL) !=
+	    REF_WORKTREE_SHARED)
 		return 0;
 
 	/* Do not pack non-tags unless PACK_REFS_ALL is set: */
@@ -2277,7 +2268,8 @@ static enum iterator_selection reflog_iterator_select(
 		 */
 		return ITER_SELECT_0;
 	} else if (iter_common) {
-		if (ref_type(iter_common->refname) == REF_TYPE_NORMAL)
+		if (parse_worktree_ref(iter_common->refname, NULL, NULL,
+				       NULL) == REF_WORKTREE_SHARED)
 			return ITER_SELECT_1;
 
 		/*
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 66c4574c99d..bf0e63ae70c 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -862,7 +862,7 @@ static int packed_ref_iterator_advance(struct ref_iterator *ref_iterator)
 
 	while ((ok = next_record(iter)) == ITER_OK) {
 		if (iter->flags & DO_FOR_EACH_PER_WORKTREE_ONLY &&
-		    ref_type(iter->base.refname) != REF_TYPE_PER_WORKTREE)
+		    !is_per_worktree_ref(iter->base.refname))
 			continue;
 
 		if (!(iter->flags & DO_FOR_EACH_INCLUDE_BROKEN) &&
diff --git a/worktree.c b/worktree.c
index 90fc085f76b..bb7873c72d1 100644
--- a/worktree.c
+++ b/worktree.c
@@ -489,62 +489,17 @@ int submodule_uses_worktrees(const char *path)
 	return ret;
 }
 
-int parse_worktree_ref(const char *worktree_ref, const char **name,
-		       int *name_length, const char **ref)
-{
-	if (skip_prefix(worktree_ref, "main-worktree/", &worktree_ref)) {
-		if (!*worktree_ref)
-			return -1;
-		if (name)
-			*name = NULL;
-		if (name_length)
-			*name_length = 0;
-		if (ref)
-			*ref = worktree_ref;
-		return 0;
-	}
-	if (skip_prefix(worktree_ref, "worktrees/", &worktree_ref)) {
-		const char *slash = strchr(worktree_ref, '/');
-
-		if (!slash || slash == worktree_ref || !slash[1])
-			return -1;
-		if (name)
-			*name = worktree_ref;
-		if (name_length)
-			*name_length = slash - worktree_ref;
-		if (ref)
-			*ref = slash + 1;
-		return 0;
-	}
-	return -1;
-}
-
 void strbuf_worktree_ref(const struct worktree *wt,
 			 struct strbuf *sb,
 			 const char *refname)
 {
-	switch (ref_type(refname)) {
-	case REF_TYPE_PSEUDOREF:
-	case REF_TYPE_PER_WORKTREE:
-		if (wt && !wt->is_current) {
-			if (is_main_worktree(wt))
-				strbuf_addstr(sb, "main-worktree/");
-			else
-				strbuf_addf(sb, "worktrees/%s/", wt->id);
-		}
-		break;
-
-	case REF_TYPE_MAIN_PSEUDOREF:
-	case REF_TYPE_OTHER_PSEUDOREF:
-		break;
-
-	case REF_TYPE_NORMAL:
-		/*
-		 * For shared refs, don't prefix worktrees/ or
-		 * main-worktree/. It's not necessary and
-		 * files-backend.c can't handle it anyway.
-		 */
-		break;
+	if (parse_worktree_ref(refname, NULL, NULL, NULL) ==
+		    REF_WORKTREE_CURRENT &&
+	    wt && !wt->is_current) {
+		if (is_main_worktree(wt))
+			strbuf_addstr(sb, "main-worktree/");
+		else
+			strbuf_addf(sb, "worktrees/%s/", wt->id);
 	}
 	strbuf_addstr(sb, refname);
 }
diff --git a/worktree.h b/worktree.h
index e9e839926b0..9dcea6fc8c1 100644
--- a/worktree.h
+++ b/worktree.h
@@ -166,16 +166,6 @@ const char *worktree_git_path(const struct worktree *wt,
 			      const char *fmt, ...)
 	__attribute__((format (printf, 2, 3)));
 
-/*
- * Parse a worktree ref (i.e. with prefix main-worktree/ or
- * worktrees/) and return the position of the worktree's name and
- * length (or NULL and zero if it's main worktree), and ref.
- *
- * All name, name_length and ref arguments could be NULL.
- */
-int parse_worktree_ref(const char *worktree_ref, const char **name,
-		       int *name_length, const char **ref);
-
 /*
  * Return a refname suitable for access from the current ref store.
  */

base-commit: 805e0a68082a217f0112db9ee86a022227a9c81b
-- 
gitgitgadget
