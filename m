Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5A211F463
	for <e@80x24.org>; Tue, 17 Sep 2019 21:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfIQVur (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Sep 2019 17:50:47 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:55131 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbfIQVur (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Sep 2019 17:50:47 -0400
Received: by mail-pg1-f202.google.com with SMTP id m17so2831139pgh.21
        for <git@vger.kernel.org>; Tue, 17 Sep 2019 14:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=haJXfegwDxgKPBc9Lbzzssn82tbp7vkouOuJhrpb4x4=;
        b=LCJ4pYxVthJGjI+Bhw05uXrE/ugKhRExfSfm0PIG6+BbUaqXFRShvg1ExpfiA/r8Cv
         ZstDHplQL/uBBl+N65MVGwgCvyB+7sw7g0ik42uy9cYhHI7qgwWfh8+cGtwqi4d8n1s1
         mzDX8xBKf3nQ1q2Z+SiwfaXylAP6n/QwKSoWP8mcUEVM2V70RUpf4fIpCbnhmm0PZB/o
         JAIxwnCr0NGSC0IP8QF71bfrzE3k1g7ucLp3LrQU4GCSdppRfQnyOEbuINMlVqTu6DPI
         ibhjMwx2oK8YAfiYJAh7ITUo0NH/7p43w7eAXvYhaxw29Fej4kpiRXDupP4A1OMqGIEt
         Z/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=haJXfegwDxgKPBc9Lbzzssn82tbp7vkouOuJhrpb4x4=;
        b=EF5d4gOb4WugzcnJPiLrij9eYY2x4oCxYloIvNU83AsO3TSr+uBOKYfF/PWoeXYACE
         VmbYHejZ2BtH3zyKiPp46399MQjCWQqkZY9w+01P9cU+Y/21O+40F2ZuCiaw4G7e3bgC
         sHPsXkjA98nyMygg8fqqyEpxdoTYPTVzeJMCrpvN5o+FoJUzl/A37YcgflFO/DqJKKNm
         pZ+cCCMX8Qco0Yi7le2HA9vYFayTwER0dzAf7iLM2NmVxLkPHit1+PL90FlIcwXmcSHZ
         WX2BSMGg72KKLbroZnR2/ud1a/JrlPdEhhI1wm6xynCXbrjogUZV9ps4xtdrP2s0/S+1
         NeKA==
X-Gm-Message-State: APjAAAXAm9oxUIwI1T7x+sh9fF7zGCb5oT1oXXeFXwRthWfz7pUM6XFm
        C59OMXtNG69a8wSgNmcHtqHfexpIBTjwYeG71DkE5TpW1pscsCWjphhZnPICU7odsddtFOCuka/
        ofELmEBWGoy0OxQpRWaTuT/Iht8AoXRhF3zbxJBjljdvFKQtasav2FCXS7ZgsT8nbxG2vwP69h6
        8O
X-Google-Smtp-Source: APXvYqw9RuogSOGVF+3wucE47IZ9hBEBcMzP+zhLZC9OuNJHFnnNA4WDYYrqO1n0LQRfL5aZlrtcW6oY7/Bph3bgxfhm
X-Received: by 2002:a63:4c64:: with SMTP id m36mr885740pgl.229.1568757045884;
 Tue, 17 Sep 2019 14:50:45 -0700 (PDT)
Date:   Tue, 17 Sep 2019 14:50:40 -0700
In-Reply-To: <CABPp-BHpXWF+1hKUTfn8s-y4MJZXz+jUVS_K10eKyD6PGwo=gg@mail.gmail.com>
Message-Id: <20190917215040.132503-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CABPp-BHpXWF+1hKUTfn8s-y4MJZXz+jUVS_K10eKyD6PGwo=gg@mail.gmail.com>
X-Mailer: git-send-email 2.23.0.237.gc6a4ce50a0-goog
Subject: [RFC PATCH] merge-recursive: symlink's descendants not in way
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, newren@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the working tree has:
 - foo (symlink)
 - foo/bar (directory)

and the user merges a commit that deletes the foo symlink and instead
contains:
 - foo (directory)
 - foo/bar (file)

the merge should happen without requiring user intervention. However,
this does not happen.

In merge_trees(), process_entry() will be invoked first for "foo/bar",
then "foo" (in reverse lexicographical order). process_entry() correctly
reaches "Case B: Added in one", but dir_in_way() states that "bar" is
already present as a directory, causing a directory/file conflict at the
wrong point.

Instead, teach dir_in_way() that directories under symlinks are not "in
the way", so that symlinks are treated as regular files instead of
directories containing other directories and files. Thus, the "else"
branch will be followed instead: "foo/bar" will be added to the working
tree, make_room_for_path() being indirectly called to unlink the "foo"
symlink (just like if "foo" were a regular file instead). When
process_entry() is subsequently invoked for "foo", process_entry() will
reach "Case A: Deleted in one", and will handle it as "Add/delete" or
"Modify/delete" appropriately (including reinstatement of the previously
unlinked symlink with a new unique filename if necessary, again, just
like if "foo" were a regular file instead).

Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
Thanks to Elijah for his help. Some of the commit message is based on
his explanation [1].

I'm finding this relatively complicated, so I'm sending this as RFC. My
main concern is that whether all callers of dir_in_way() are OK with its
behavior change, and if yes, how to explain it. I suspect that this is
correct because dir_in_way() should behave consistently for all its
callers, but I might be wrong.

The other thing is whether the commit message is clear enough. In
particular, whether it needs more detail (I didn't mention the index,
for example), or whether it should be more concise (for example, I
thought of just stating that we treat symlinks as regular files and this
would be backed up by the fact that I've updated the only part of
merge-recursive.c that calls lstat() and then S_ISDIR).

[1] https://public-inbox.org/git/CABPp-BHpXWF+1hKUTfn8s-y4MJZXz+jUVS_K10eKyD6PGwo=gg@mail.gmail.com/
---
 merge-recursive.c          | 40 +++++++++++++++++++++++++++++++++-----
 t/t3030-merge-recursive.sh | 27 +++++++++++++++++++++++++
 2 files changed, 62 insertions(+), 5 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 6b812d67e3..a2029a4e94 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -747,7 +747,7 @@ static int dir_in_way(struct index_state *istate, const char *path,
 {
 	int pos;
 	struct strbuf dirpath = STRBUF_INIT;
-	struct stat st;
+	int ret = 0;
 
 	strbuf_addstr(&dirpath, path);
 	strbuf_addch(&dirpath, '/');
@@ -758,13 +758,43 @@ static int dir_in_way(struct index_state *istate, const char *path,
 		pos = -1 - pos;
 	if (pos < istate->cache_nr &&
 	    !strncmp(dirpath.buf, istate->cache[pos]->name, dirpath.len)) {
-		strbuf_release(&dirpath);
-		return 1;
+		ret = 1;
+		goto cleanup;
 	}
 
+	if (check_working_copy) {
+		struct stat st;
+
+		strbuf_trim_trailing_dir_sep(&dirpath);
+		if (lstat(dirpath.buf, &st))
+			goto cleanup; /* doesn't exist, OK */
+		if (!S_ISDIR(st.st_mode))
+			goto cleanup; /* not directory, OK */
+		if (empty_ok && is_empty_dir(dirpath.buf))
+			goto cleanup;
+
+		/*
+		 * The given path is a directory, but this should not
+		 * be treated as "in the way" if one of this
+		 * directory's ancestors is a symlink. Check for this
+		 * case.
+		 */
+		while (1) {
+			char *slash = strrchr(dirpath.buf, '/');
+
+			if (!slash) {
+				ret = 1;
+				goto cleanup;
+			}
+			*slash = '\0';
+			if (!lstat(dirpath.buf, &st) && S_ISLNK(st.st_mode))
+				goto cleanup;
+		}
+	}
+
+cleanup:
 	strbuf_release(&dirpath);
-	return check_working_copy && !lstat(path, &st) && S_ISDIR(st.st_mode) &&
-		!(empty_ok && is_empty_dir(path));
+	return ret;
 }
 
 /*
diff --git a/t/t3030-merge-recursive.sh b/t/t3030-merge-recursive.sh
index ff641b348a..dfd617a845 100755
--- a/t/t3030-merge-recursive.sh
+++ b/t/t3030-merge-recursive.sh
@@ -452,6 +452,33 @@ test_expect_success 'merge-recursive d/f conflict result' '
 
 '
 
+test_expect_success 'dir in working tree with symlink ancestor does not produce d/f conflict' '
+	git init sym &&
+	(
+		cd sym &&
+		ln -s . foo &&
+		mkdir bar &&
+		touch bar/file &&
+		git add foo bar/file &&
+		git commit -m "foo symlink" &&
+
+		git checkout -b branch1 &&
+		git commit --allow-empty -m "empty commit" &&
+
+		git checkout master &&
+		git rm foo &&
+		mkdir foo &&
+		touch foo/bar &&
+		git add foo/bar &&
+		git commit -m "replace foo symlink with real foo dir and foo/bar file" &&
+
+		git checkout branch1 &&
+
+		# Exercise to make sure that this works without errors
+		git cherry-pick master
+	)
+'
+
 test_expect_success 'reset and 3-way merge' '
 
 	git reset --hard "$c2" &&
-- 
2.23.0.237.gc6a4ce50a0-goog

