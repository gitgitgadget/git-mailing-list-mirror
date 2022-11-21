Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D81C4332F
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 23:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbiKUXtX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 18:49:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbiKUXtW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 18:49:22 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2B3221
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 15:49:20 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id cl5so22300091wrb.9
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 15:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QXWKndd0jloGstTsQzTIiWkQg6PQgEIP64D2qnBRzso=;
        b=Ixr4rJLtuziBY08wwZwgnxFrC1zWJr/Vp1HUPZCERa8vahqBcLRII2Vi5TxpeCFs4n
         t8Q7Tl1iMsLew3G3+l4N+WBj3id8+qI4P/TngBL2+N4D5d7uwpC/jtt2veFH4SnZK9x3
         +sEnRF4w+ctQRnHCMLDNqmslfxCMDEBjwrceap//Da9MWFbwyiWxliayCzfPdhP/8kng
         ugW7OGQau3lw2lwmC3N88F3gfNOO/RF8N/mqJ4+ST9EuqO4fwfgtsjyPJ6v2FUthDacF
         V4DhZA66ckkkF3jIBbw91wxPKnZf+FODIzm6XHMbL2rpZKCKZpApUVHVSDZjY/qHpl89
         HFBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QXWKndd0jloGstTsQzTIiWkQg6PQgEIP64D2qnBRzso=;
        b=KbpUxsvn0Uygwm/937vygy9N8//8/WRdbjzY/xbFR+AB5v24gFDpyCQS7d2dQCCG/X
         t25eCadRLv27THf1N83pqAHWmjVfBBq4gtmkxefKibEab7efJIwfLlXpKHgK69vo598R
         2fV8avBzNBfv5EeeXjw7lGo8Mi4KiKqNoTDK8/0bYtSnBeLgfn9raTKMDv9Q4Vu5OVT7
         WNRqBFDXafng6PV+rGbACbT8jrK95vKiYrgCOfLBTL5oGkBLzadjdm/eRumaaBE7ZxF0
         6n7csrbzxCjM8Rto0BR86f7gMyWlke84rsGxYPCKgSPiKpO7NYJdXRlZsMwW9XnBCwvr
         zt6w==
X-Gm-Message-State: ANoB5pm0veIuGtljbDny9rOT4hNQB2eqrIw/sTR68BvZq9LyjR3W9dm+
        XH7ee2jYlkezmQSl/NrFLEJFPQ2rdOE=
X-Google-Smtp-Source: AA0mqf6GSlVBSEhIp6oJez+O9QlzJCg+jOzWo9InwC9/GU7vuPR9Jlr0FcJPlTpuOYqXE40WLOVw1g==
X-Received: by 2002:adf:fb12:0:b0:236:60e8:3cca with SMTP id c18-20020adffb12000000b0023660e83ccamr6278887wrr.471.1669074559023;
        Mon, 21 Nov 2022 15:49:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e16-20020adffd10000000b00241b933f8cesm12497385wrr.74.2022.11.21.15.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 15:49:18 -0800 (PST)
Message-Id: <pull.1382.v2.git.git.1669074557348.gitgitgadget@gmail.com>
In-Reply-To: <pull.1382.git.git.1668706274099.gitgitgadget@gmail.com>
References: <pull.1382.git.git.1668706274099.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Nov 2022 23:49:17 +0000
Subject: [PATCH v2] object-file: use real paths when adding alternates
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

When adding an alternate ODB, we check if the alternate has the same
path as the object dir, and if so, we do nothing. However, that
comparison does not resolve symlinks. This makes it possible to add the
object dir as an alternate, which may result in bad behavior. For
example, it can trick "git repack -a -l -d" (possibly run by "git gc")
into thinking that all packs come from an alternate and delete all
objects.

	rm -rf test &&
	git clone https://github.com/git/git test &&
	(
	cd test &&
	ln -s objects .git/alt-objects &&
	# -c repack.updateserverinfo=false silences a warning about not
	# being able to update "info/refs", it isn't needed to show the
	# bad behavior
	GIT_ALTERNATE_OBJECT_DIRECTORIES=".git/alt-objects" git \
		-c repack.updateserverinfo=false repack -a -l -d  &&
	# It's broken!
	git status
	# Because there are no more objects!
	ls .git/objects/pack
	)

Fix this by resolving symlinks and relative paths before comparing the
alternate and object dir. This lets us clean up a number of issues noted
in 37a95862c6 (alternates: re-allow relative paths from environment,
2016-11-07):

- Now that we compare the real paths, duplicate detection is no longer
  foiled by relative paths.
- Using strbuf_realpath() allows us to "normalize" paths that
  strbuf_normalize_path() can't, so we can stop silently ignoring errors
  when "normalizing" paths from the environment.
- We now store an absolute path based on getcwd() (the "future
  direction" named in 37a95862c6), so chdir()-ing in the process no
  longer changes the directory pointed to by the alternate. This is a
  change in behavior, but a desirable one.

Signed-off-by: Glen Choo <chooglen@google.com>
---
    object-file: use real paths when adding alternates
    
    Thanks for the feedback on v1. This version takes nearly all of Peff's
    patch [1] except for the comment about making an exception for relative
    paths in the environment. My reading of the commit [2] is that it was a
    workaround for strbuf_normalize_path() not being able to handle relative
    paths, so the only reason to special-case the environment is to preserve
    the behavior of respecting broken paths, which (unlike relative paths) I
    don't think will be missed.
    
    Changes in v2:
    
     * Do realpath when storing the alternate's directory entry instead of
       only during the usability check.
     * Update commit message to reflect the relationship to [2]
    
    [1] https://lore.kernel.org/git/Y3aBzbzub7flQyca@coredump.intra.peff.net
    [2] 37a95862c6 (alternates: re-allow relative paths from environment,
    2016-11-07)

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1382%2Fchooglen%2Fobject-file%2Fcheck-alternate-real-path-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1382/chooglen/object-file/check-alternate-real-path-v2
Pull-Request: https://github.com/git/git/pull/1382

Range-diff vs v1:

 1:  9392725ad01 ! 1:  ed9e12c0051 object-file: use real paths when adding alternates
     @@ Commit message
                  ls .git/objects/pack
                  )
      
     -    Fix this by resolving symlinks before comparing the alternate and object
     -    dir.
     +    Fix this by resolving symlinks and relative paths before comparing the
     +    alternate and object dir. This lets us clean up a number of issues noted
     +    in 37a95862c6 (alternates: re-allow relative paths from environment,
     +    2016-11-07):
     +
     +    - Now that we compare the real paths, duplicate detection is no longer
     +      foiled by relative paths.
     +    - Using strbuf_realpath() allows us to "normalize" paths that
     +      strbuf_normalize_path() can't, so we can stop silently ignoring errors
     +      when "normalizing" paths from the environment.
     +    - We now store an absolute path based on getcwd() (the "future
     +      direction" named in 37a95862c6), so chdir()-ing in the process no
     +      longer changes the directory pointed to by the alternate. This is a
     +      change in behavior, but a desirable one.
      
          Signed-off-by: Glen Choo <chooglen@google.com>
      
       ## object-file.c ##
     -@@ object-file.c: static int alt_odb_usable(struct raw_object_store *o,
     - 			  struct strbuf *path,
     - 			  const char *normalized_objdir, khiter_t *pos)
     +@@ object-file.c: static int link_alt_odb_entry(struct repository *r, const struct strbuf *entry,
       {
     -+	int ret = 0;
     - 	int r;
     -+	struct strbuf real_path = STRBUF_INIT;
     + 	struct object_directory *ent;
     + 	struct strbuf pathbuf = STRBUF_INIT;
     ++	struct strbuf tmp = STRBUF_INIT;
     + 	khiter_t pos;
       
     - 	/* Detect cases where alternate disappeared */
     - 	if (!is_directory(path->buf)) {
     - 		error(_("object directory %s does not exist; "
     - 			"check .git/objects/info/alternates"),
     - 		      path->buf);
     --		return 0;
     -+		goto cleanup;
     + 	if (!is_absolute_path(entry->buf) && relative_base) {
     +@@ object-file.c: static int link_alt_odb_entry(struct repository *r, const struct strbuf *entry,
       	}
     + 	strbuf_addbuf(&pathbuf, entry);
       
     - 	/*
     -@@ object-file.c: static int alt_odb_usable(struct raw_object_store *o,
     - 		assert(r == 1); /* never used */
     - 		kh_value(o->odb_by_path, p) = o->odb;
     +-	if (strbuf_normalize_path(&pathbuf) < 0 && relative_base) {
     ++	if (!strbuf_realpath(&tmp, pathbuf.buf, 0)) {
     + 		error(_("unable to normalize alternate object path: %s"),
     +-		      pathbuf.buf);
     ++			pathbuf.buf);
     + 		strbuf_release(&pathbuf);
     + 		return -1;
       	}
     --	if (fspatheq(path->buf, normalized_objdir))
     --		return 0;
     -+
     -+	strbuf_realpath(&real_path, path->buf, 1);
     -+	if (fspatheq(real_path.buf, normalized_objdir))
     -+		goto cleanup;
     - 	*pos = kh_put_odb_path_map(o->odb_by_path, path->buf, &r);
     - 	/* r: 0 = exists, 1 = never used, 2 = deleted */
     --	return r == 0 ? 0 : 1;
     -+	ret = r == 0 ? 0 : 1;
     -+ cleanup:
     -+	strbuf_release(&real_path);
     -+	return ret;
     - }
     ++	strbuf_swap(&pathbuf, &tmp);
     ++	strbuf_release(&tmp);
       
     - /*
     + 	/*
     + 	 * The trailing slash after the directory name is given by
      @@ object-file.c: static void link_alt_odb_entries(struct repository *r, const char *alt,
       		return;
       	}
       
      -	strbuf_add_absolute_path(&objdirbuf, r->objects->odb->path);
     +-	if (strbuf_normalize_path(&objdirbuf) < 0)
     +-		die(_("unable to normalize object directory: %s"),
     +-		    objdirbuf.buf);
      +	strbuf_realpath(&objdirbuf, r->objects->odb->path, 1);
     - 	if (strbuf_normalize_path(&objdirbuf) < 0)
     - 		die(_("unable to normalize object directory: %s"),
     - 		    objdirbuf.buf);
     + 
     + 	while (*alt) {
     + 		alt = parse_alt_odb_entry(alt, sep, &entry);
      
       ## t/t7700-repack.sh ##
      @@ t/t7700-repack.sh: test_expect_success 'loose objects in alternate ODB are not repacked' '


 object-file.c     | 12 ++++++------
 t/t7700-repack.sh | 18 ++++++++++++++++++
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/object-file.c b/object-file.c
index 957790098fa..ef2b762234d 100644
--- a/object-file.c
+++ b/object-file.c
@@ -508,6 +508,7 @@ static int link_alt_odb_entry(struct repository *r, const struct strbuf *entry,
 {
 	struct object_directory *ent;
 	struct strbuf pathbuf = STRBUF_INIT;
+	struct strbuf tmp = STRBUF_INIT;
 	khiter_t pos;
 
 	if (!is_absolute_path(entry->buf) && relative_base) {
@@ -516,12 +517,14 @@ static int link_alt_odb_entry(struct repository *r, const struct strbuf *entry,
 	}
 	strbuf_addbuf(&pathbuf, entry);
 
-	if (strbuf_normalize_path(&pathbuf) < 0 && relative_base) {
+	if (!strbuf_realpath(&tmp, pathbuf.buf, 0)) {
 		error(_("unable to normalize alternate object path: %s"),
-		      pathbuf.buf);
+			pathbuf.buf);
 		strbuf_release(&pathbuf);
 		return -1;
 	}
+	strbuf_swap(&pathbuf, &tmp);
+	strbuf_release(&tmp);
 
 	/*
 	 * The trailing slash after the directory name is given by
@@ -596,10 +599,7 @@ static void link_alt_odb_entries(struct repository *r, const char *alt,
 		return;
 	}
 
-	strbuf_add_absolute_path(&objdirbuf, r->objects->odb->path);
-	if (strbuf_normalize_path(&objdirbuf) < 0)
-		die(_("unable to normalize object directory: %s"),
-		    objdirbuf.buf);
+	strbuf_realpath(&objdirbuf, r->objects->odb->path, 1);
 
 	while (*alt) {
 		alt = parse_alt_odb_entry(alt, sep, &entry);
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 5be483bf887..ce1954d0977 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -90,6 +90,24 @@ test_expect_success 'loose objects in alternate ODB are not repacked' '
 	test_has_duplicate_object false
 '
 
+test_expect_success '--local keeps packs when alternate is objectdir ' '
+	git init alt_symlink &&
+	(
+		cd alt_symlink &&
+		git init &&
+		echo content >file4 &&
+		git add file4 &&
+		git commit -m commit_file4 &&
+		git repack -a &&
+		ls .git/objects/pack/*.pack >../expect &&
+		ln -s objects .git/alt_objects &&
+		echo "$(pwd)/.git/alt_objects" >.git/objects/info/alternates &&
+		git repack -a -d -l &&
+		ls .git/objects/pack/*.pack >../actual
+	) &&
+	test_cmp expect actual
+'
+
 test_expect_success 'packed obs in alt ODB are repacked even when local repo is packless' '
 	mkdir alt_objects/pack &&
 	mv .git/objects/pack/* alt_objects/pack &&

base-commit: 319605f8f00e402f3ea758a02c63534ff800a711
-- 
gitgitgadget
