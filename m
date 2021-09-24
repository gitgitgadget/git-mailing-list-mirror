Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813C4C433EF
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 15:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66FC061242
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 15:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347235AbhIXPlA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 11:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347190AbhIXPkw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 11:40:52 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B098BC0614ED
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 08:39:18 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id w29so28657087wra.8
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 08:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=+WMCKwrabJt26VhQfSQ85nboExspuZ/m1PAYcfVaGMw=;
        b=msfBoSmLoBswdP9v4HNj8WKVxP7P/+5YRftoE9N2bm+EyhdmT5kjZNrFj9+K7Ds+sE
         UUO8JNaqF43Ji+tDDGqc1UBoEmIBugm3/94q43dexvog+5V1t3pTCQKDwTnrPfYBsTNy
         sdDOOX22h0hxFm/TmSPGlozAtz9sasP92CdT22KCLqMKBuzSPdct/E/lBvu4RjSZsP4Z
         xQurfL7i4dOH7mwNsSKtndUUOwF8Zb/PLbCeTgzyVMzQqoz49ff75OyCyaBxKDdM2bht
         zlN3+CzfDQnWOF0Cfrr1g05F+x/UuLnvFKm1s5qx6J+G3NEFlXnZ3B8QMre5v5YXMntH
         rkOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=+WMCKwrabJt26VhQfSQ85nboExspuZ/m1PAYcfVaGMw=;
        b=dxxb8VaRvhui7+gpg0fQJ9ddeXoDAAg/TDTrK9Lkad6OICW3UPByJdlZu74EkyhAQL
         kMBg4MJMQHsB/LNIx5pMZk9K8kZRik5NlpytVF6bPF9hqiehPCiZcmdhaWG9nkZ9+VVV
         4b6LYfezLoiRrDq/BKL0DrSIWBy97bPW/rL+VqZStwRGFowARQ0aAjzvTvvoCpncRoFH
         rt+gCniRoy5fnthxrGZYGXxH/Qn5XQcx6CYbpkZ4rv1Vz8DP6/bK1D1+Pg5JjnEUe2xd
         YG8whMlYO3PqN2Crflz4NWqAyEsjEcdfIuEbQvF7puTJH5UCHRv0+CWASrVRBZHrUwq+
         19SQ==
X-Gm-Message-State: AOAM5339R/I7YswXYpiES2WCZfaiRlGs5NXQ1yq+BVYShFWsnJT0AcRO
        eglWkWJ77Gscnh2lSf/Ngb5vQl+mBs0=
X-Google-Smtp-Source: ABdhPJzXl2exXrle50fA3vF6Q3xF8vpyEs4Bw1fe4WsFtnbE/NHjjxU6mprQs2zExM5K1LwP84nq1A==
X-Received: by 2002:a05:600c:3b97:: with SMTP id n23mr2819385wms.93.1632497957311;
        Fri, 24 Sep 2021 08:39:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c30sm8546243wrb.74.2021.09.24.08.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 08:39:17 -0700 (PDT)
Message-Id: <2ebaf8e68c2c46f700f7523d96e7494ebe3fb8cb.1632497954.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1018.v4.git.1632497954.gitgitgadget@gmail.com>
References: <pull.1018.v3.git.1632159937.gitgitgadget@gmail.com>
        <pull.1018.v4.git.1632497954.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Sep 2021 15:39:04 +0000
Subject: [PATCH v4 03/13] dir: select directories correctly
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, matheus.bernardino@usp.br,
        stolee@gmail.com, vdye@github.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When matching a path against a list of patterns, the ones that require a
directory match previously did not work when a filename is specified.
This was fine when all pattern-matching was done within methods such as
unpack_trees() that check a directory before recursing into the
contained files. However, other commands will start matching individual
files against pattern lists without that recursive approach.

The last_matching_pattern_from_list() logic performs some checks on the
filetype of a path within the index when the PATTERN_FLAG_MUSTBEDIR flag
is set. This works great when setting SKIP_WORKTREE bits within
unpack_trees(), but doesn't work well when passing an arbitrary path
such as a file within a matching directory.

We extract the logic around determining the file type, but attempt to
avoid checking the filesystem if the parent directory already matches
the sparse-checkout patterns. The new path_matches_dir_pattern() method
includes a 'path_parent' parameter that is used to store the parent
directory of 'pathname' between multiple pattern matching tests. This is
loaded lazily, only on the first pattern it finds that has the
PATTERN_FLAG_MUSTBEDIR flag.

If we find that a path has a parent directory, we start by checking to
see if that parent directory matches the pattern. If so, then we do not
need to query the index for the type (which can be expensive). If we
find that the parent does not match, then we still must check the type
from the index for the given pathname.

Note that this does not affect cone mode pattern matching, but instead
the more general -- and slower -- full pattern set. Thus, this does not
affect the sparse index.

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 dir.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 49 insertions(+), 5 deletions(-)

diff --git a/dir.c b/dir.c
index 86afa2eae00..9ea6cfe61cb 100644
--- a/dir.c
+++ b/dir.c
@@ -1303,6 +1303,44 @@ int match_pathname(const char *pathname, int pathlen,
 				 WM_PATHNAME) == 0;
 }
 
+static int path_matches_dir_pattern(const char *pathname,
+				    int pathlen,
+				    struct strbuf **path_parent,
+				    int *dtype,
+				    struct path_pattern *pattern,
+				    struct index_state *istate)
+{
+	if (!*path_parent) {
+		char *slash;
+		CALLOC_ARRAY(*path_parent, 1);
+		strbuf_add(*path_parent, pathname, pathlen);
+		slash = find_last_dir_sep((*path_parent)->buf);
+
+		if (slash)
+			strbuf_setlen(*path_parent, slash - (*path_parent)->buf);
+		else
+			strbuf_setlen(*path_parent, 0);
+	}
+
+	/*
+	 * If the parent directory matches the pattern, then we do not
+	 * need to check for dtype.
+	 */
+	if ((*path_parent)->len &&
+	    match_pathname((*path_parent)->buf, (*path_parent)->len,
+			   pattern->base,
+			   pattern->baselen ? pattern->baselen - 1 : 0,
+			   pattern->pattern, pattern->nowildcardlen,
+			   pattern->patternlen, pattern->flags))
+		return 1;
+
+	*dtype = resolve_dtype(*dtype, istate, pathname, pathlen);
+	if (*dtype != DT_DIR)
+		return 0;
+
+	return 1;
+}
+
 /*
  * Scan the given exclude list in reverse to see whether pathname
  * should be ignored.  The first match (i.e. the last on the list), if
@@ -1318,6 +1356,7 @@ static struct path_pattern *last_matching_pattern_from_list(const char *pathname
 {
 	struct path_pattern *res = NULL; /* undecided */
 	int i;
+	struct strbuf *path_parent = NULL;
 
 	if (!pl->nr)
 		return NULL;	/* undefined */
@@ -1327,11 +1366,10 @@ static struct path_pattern *last_matching_pattern_from_list(const char *pathname
 		const char *exclude = pattern->pattern;
 		int prefix = pattern->nowildcardlen;
 
-		if (pattern->flags & PATTERN_FLAG_MUSTBEDIR) {
-			*dtype = resolve_dtype(*dtype, istate, pathname, pathlen);
-			if (*dtype != DT_DIR)
-				continue;
-		}
+		if (pattern->flags & PATTERN_FLAG_MUSTBEDIR &&
+		    !path_matches_dir_pattern(pathname, pathlen, &path_parent,
+					      dtype, pattern, istate))
+			continue;
 
 		if (pattern->flags & PATTERN_FLAG_NODIR) {
 			if (match_basename(basename,
@@ -1355,6 +1393,12 @@ static struct path_pattern *last_matching_pattern_from_list(const char *pathname
 			break;
 		}
 	}
+
+	if (path_parent) {
+		strbuf_release(path_parent);
+		free(path_parent);
+	}
+
 	return res;
 }
 
-- 
gitgitgadget

