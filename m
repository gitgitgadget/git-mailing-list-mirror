Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB1657CAC
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 03:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718766034; cv=none; b=aK5y0Bp7zSJUP4jqa/q4EOiaTmiliRe227P6Iq5KHfxsjTW8CXoIPq8hNcDmAamEHiQJ52mH22DKIwB+4n39HxBMd+5JnBgksJetRFmEUnDZZ/U3H5bG0Xij+XWZAGvGc77tJ7r5SLlWFvc7RQ82JiAEa7USp2hv2hHMPToR8mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718766034; c=relaxed/simple;
	bh=KeZ+lF2i85IQ10NuNm8X7oFz8AX/wN4pg6t3AlQch7g=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=aMES521LFfibwmirFRL+CGFuJo8u9wiZ1DD1d3MSHThZGuwrxJBi+HAmD2t85adZ4rTaEgxtWoyTym1cE+o/4c6yX+omzXVTVmmIQc4/m/6xy/OZmL/Q1Bjqtl0LJke1gSFfNKym9YMmw76DjN+zuvpc1PBSXY7bZ2k4wfwRw0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ltw6XKQ2; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltw6XKQ2"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-424720e73e0so11182735e9.0
        for <git@vger.kernel.org>; Tue, 18 Jun 2024 20:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718766030; x=1719370830; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7kdoI+8QhUjtqoKbyy/tMgx0gjM9+4DotxjdiXk1cK4=;
        b=ltw6XKQ2FY0NHyxDn0iaCYoCpB8988KqaPLpA+tBqLiYEIlPQuF3BteOyhS1ufC9XH
         IIaPiqyPLZ9qZj37OG+xhHaqXoDn8LvJmi4Bo6uZyv+LlIJYbXklUboucBqxFI5Nn45w
         wViVZ4MT4wbqCxD1ccBBzny6mIg7WWIPQYpFXXVVbY9C8KXayepadgsB46vmVGtKqwpS
         IfhuXJ8BNXMT4vPctLu8cWh9jeqoq9cDLSjoeZGa2R9QIDI8L1ycXqRGmgG3NuLPVOjf
         N36/LEqGQQW0dxnLqRCOF3LXU8TeS0pVjPp+lPSVjKM3eFsvKbzEbjxmUXQXEuBAH1L2
         792A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718766030; x=1719370830;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7kdoI+8QhUjtqoKbyy/tMgx0gjM9+4DotxjdiXk1cK4=;
        b=OMAZLIl3hR8vVXngQXspdomcswzjdDZPTH6cg+5atO4Gsu4q247OQ+HMgfFNxztRSB
         Bb11VZEBA3qmiNlWk0DvsZZVeMJ7tpkhMyy+9Fsv43PayPpgEo/ftOvjKfcDi0bkdGnC
         uxl3zPL8POGN9Z3ltfIDThnnWz1ijGYF6fPfP0yCBjJxu4HuLSCfpY03WsjQjtvYnLx1
         px80peb0RlO7i6PHJM1AbP1sKEJrUZf/s/zoW+ZHekxDUVX0fhcSM7I9GgogfZaOq1U5
         Jw81LRWoQjgPlHKUrpA2a39KfASvkL4HoVQEXfEh8EIkx4dNNbLmHjQDvlA1qP6WbN4w
         5e6g==
X-Gm-Message-State: AOJu0YwKoeDw/bB3sB8d5HnVCay5wz/h7TSsOaJzSEg9KM0nFsLrp4p7
	asIU8yaXuuUlNM44U6f0RMRvtjybL2mYXx2xydUpQVXEU8d6J8yPSeQFRg==
X-Google-Smtp-Source: AGHT+IEg5cj+OPVcE39GXrFNA21Uczb9a2SnflWHemVocRyYmoJDlNfyOCgwwSOab4D5eL3Qp6BboQ==
X-Received: by 2002:a05:600c:212:b0:41f:b0e7:f299 with SMTP id 5b1f17b1804b1-424751762e5mr7015055e9.9.1718766030425;
        Tue, 18 Jun 2024 20:00:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607509c890sm15803755f8f.28.2024.06.18.20.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 20:00:29 -0700 (PDT)
Message-Id: <500433edf49a4df448b330e4ed9201cfac83cecf.1718766019.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1748.v2.git.1718766019.gitgitgadget@gmail.com>
References: <pull.1748.git.1718310307.gitgitgadget@gmail.com>
	<pull.1748.v2.git.1718766019.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 19 Jun 2024 03:00:19 +0000
Subject: [PATCH v2 7/7] merge-ort: convert more error() cases to path_msg()
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

merge_submodule() stores errors using path_msg(), whereas other call
sites make use of the error() function.  This is inconsistent, and
moving towards path_msg() seems more friendly for libification efforts
since it will allow the caller to determine whether the error messages
need to be printed.

Note that this deferred handling of error messages changes the error
message in a recursive merge from
  error: failed to execute internal merge
to
  From inner merge:  error: failed to execute internal merge
which provides a little more information about the error which may be
useful.  Since the recursive merge strategy still only shows the older
error, we had to adjust the new testcase introduced a few commits ago to
just search for the older message somewhere in the output.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c           | 53 +++++++++++++++++++++++++++++++++----------
 t/t6406-merge-attr.sh |  2 +-
 2 files changed, 42 insertions(+), 13 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index b337e4d74ef..8dfe80f1009 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -558,6 +558,10 @@ enum conflict_and_info_types {
 	 * Keep this group _last_ other than NB_TOTAL_TYPES
 	 */
 	ERROR_SUBMODULE_CORRUPT,
+	ERROR_THREEWAY_CONTENT_MERGE_FAILED,
+	ERROR_OBJECT_WRITE_FAILED,
+	ERROR_OBJECT_READ_FAILED,
+	ERROR_OBJECT_NOT_A_BLOB,
 
 	/* Keep this entry _last_ in the list */
 	NB_TOTAL_TYPES,
@@ -615,6 +619,14 @@ static const char *type_short_descriptions[] = {
 	/* Something is seriously wrong; cannot even perform merge */
 	[ERROR_SUBMODULE_CORRUPT] =
 		"ERROR (submodule corrupt)",
+	[ERROR_THREEWAY_CONTENT_MERGE_FAILED] =
+		"ERROR (three-way content merge failed)",
+	[ERROR_OBJECT_WRITE_FAILED] =
+		"ERROR (object write failed)",
+	[ERROR_OBJECT_READ_FAILED] =
+		"ERROR (object read failed)",
+	[ERROR_OBJECT_NOT_A_BLOB] =
+		"ERROR (object is not a blob)",
 };
 
 struct logical_conflict_info {
@@ -2190,15 +2202,24 @@ static int handle_content_merge(struct merge_options *opt,
 					  pathnames, extra_marker_size,
 					  &result_buf);
 
-		if ((merge_status < 0) || !result_buf.ptr)
-			ret = error(_("failed to execute internal merge"));
+		if ((merge_status < 0) || !result_buf.ptr) {
+			path_msg(opt, ERROR_THREEWAY_CONTENT_MERGE_FAILED, 0,
+				 pathnames[0], pathnames[1], pathnames[2], NULL,
+				 _("error: failed to execute internal merge for %s"),
+				 path);
+			ret = -1;
+		}
 
 		if (!ret &&
 		    write_object_file(result_buf.ptr, result_buf.size,
-				      OBJ_BLOB, &result->oid))
-			ret = error(_("unable to add %s to database"), path);
-
+				      OBJ_BLOB, &result->oid)) {
+			path_msg(opt, ERROR_OBJECT_WRITE_FAILED, 0,
+				 pathnames[0], pathnames[1], pathnames[2], NULL,
+				 _("error: unable to add %s to database"), path);
+			ret = -1;
+		}
 		free(result_buf.ptr);
+
 		if (ret)
 			return -1;
 		if (merge_status > 0)
@@ -3577,18 +3598,26 @@ static int sort_dirs_next_to_their_children(const char *one, const char *two)
 		return c1 - c2;
 }
 
-static int read_oid_strbuf(const struct object_id *oid,
-			   struct strbuf *dst)
+static int read_oid_strbuf(struct merge_options *opt,
+			   const struct object_id *oid,
+			   struct strbuf *dst,
+			   const char *path)
 {
 	void *buf;
 	enum object_type type;
 	unsigned long size;
 	buf = repo_read_object_file(the_repository, oid, &type, &size);
-	if (!buf)
-		return error(_("cannot read object %s"), oid_to_hex(oid));
+	if (!buf) {
+		path_msg(opt, ERROR_OBJECT_READ_FAILED, 0,
+			 path, NULL, NULL, NULL,
+			 _("error: cannot read object %s"), oid_to_hex(oid));
+		return -1;
+	}
 	if (type != OBJ_BLOB) {
 		free(buf);
-		return error(_("object %s is not a blob"), oid_to_hex(oid));
+		path_msg(opt, ERROR_OBJECT_NOT_A_BLOB, 0,
+			 path, NULL, NULL, NULL,
+			 _("error: object %s is not a blob"), oid_to_hex(oid));
 	}
 	strbuf_attach(dst, buf, size, size + 1);
 	return 0;
@@ -3612,8 +3641,8 @@ static int blob_unchanged(struct merge_options *opt,
 	if (oideq(&base->oid, &side->oid))
 		return 1;
 
-	if (read_oid_strbuf(&base->oid, &basebuf) ||
-	    read_oid_strbuf(&side->oid, &sidebuf))
+	if (read_oid_strbuf(opt, &base->oid, &basebuf, path) ||
+	    read_oid_strbuf(opt, &side->oid, &sidebuf, path))
 		goto error_return;
 	/*
 	 * Note: binary | is used so that both renormalizations are
diff --git a/t/t6406-merge-attr.sh b/t/t6406-merge-attr.sh
index b6db5c2cc36..9bf95249347 100755
--- a/t/t6406-merge-attr.sh
+++ b/t/t6406-merge-attr.sh
@@ -295,7 +295,7 @@ test_expect_success !WINDOWS 'custom merge driver that is killed with a signal o
 	>./please-abort &&
 	echo "* merge=custom" >.gitattributes &&
 	test_expect_code 2 git merge recursive-a 2>err &&
-	grep "^error: failed to execute internal merge" err &&
+	grep "error: failed to execute internal merge" err &&
 	git ls-files -u >output &&
 	git diff --name-only HEAD >>output &&
 	test_must_be_empty output
-- 
gitgitgadget
