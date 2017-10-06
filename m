Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3615620372
	for <e@80x24.org>; Fri,  6 Oct 2017 20:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752765AbdJFUNA (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 16:13:00 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:56571 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751980AbdJFUM6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 16:12:58 -0400
Received: by mail-wm0-f66.google.com with SMTP id l68so10034518wmd.5
        for <git@vger.kernel.org>; Fri, 06 Oct 2017 13:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rbSjIk86ELaxW6kuFHg65WHA1AxBP5IOow2UjHObBEc=;
        b=oC4gBn0AsMxJ2c0zfqY9VJDiND+SG/eDiXvn2J2rGO+daDkLaB7hnlBhbsZzan+XxZ
         JZ8xmYVds6mES601Lx262lmDSgdsJMkA6zIjltLc++9+3fXfgAHIPZ2KaPaJKxGaveM5
         JN+UUauAPDnRVYRNvixrll1YZImsweS1AvrkBDiJJuCXAtozcO/wzuV/SbhGgeBV5hCK
         bw0ktrz1RPZq+GH+huiv2uKB4QZGk4OeHJPZV9JcWWNj9u+m7BhU09Eqq0l1cqY2MAMq
         qyVXY941r0tapf8Ukkr+Q45/RhJnArUilViY+nEouD6Z8MLNkJEDAl2FY8RG/EtDo014
         sJYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rbSjIk86ELaxW6kuFHg65WHA1AxBP5IOow2UjHObBEc=;
        b=if3LupvWHgpbH0RIxMs7rlF5I39PmuPnoMAjBNLixILyZQZ0YQ79656OuIZZv0u+Cx
         iFHrTashV/vDHbkxL+fMecDXZGHdynwIVNmFKU2tXXbyZyiLluMHAHbkOZxHrmYPnxqh
         QO5/PglU6LPNxnGWAyQxDdLnmIwnf6VUdh+v8ruDdmETn754Kokdo9eLd8txMw07QA5g
         ZJXYVibA77tdz7p8UtAKk0Ida3p/C1JOHoMCnFDc4Xd7R3GukKES1z4Weki8PFPildLt
         om13M8sVtYZ3nIqi4zdmvx4E7576Eo9sK+dhbBNRf69DA0T9i0h3xYqJC8YW+Z8LxVCr
         vxpA==
X-Gm-Message-State: AMCzsaX++1warDJELMlNLM+MAjLHIxXjupuAnhebb3QOAbvl+h67Mpir
        Wh3pfWvzAp8hEmbIRsoRmIegGozRhLI=
X-Google-Smtp-Source: AOwi7QCBS3xpw8wBH0KHaXiO4lSkFeYEFGUOyLtMXoJlBxh72oC96G4aC4e0yAvsDz2hYYek9v27wQ==
X-Received: by 10.28.67.133 with SMTP id q127mr2847659wma.71.1507320777165;
        Fri, 06 Oct 2017 13:12:57 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id h45sm2906522wrf.36.2017.10.06.13.12.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Oct 2017 13:12:56 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
        Paul Tan <pyokagan@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 11/12] read-cache: leave lock in right state in `write_locked_index()`
Date:   Fri,  6 Oct 2017 22:12:13 +0200
Message-Id: <ac3c5dd103de8364b0289a240d38782eafca2739.1507320376.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.15.0.rc0
In-Reply-To: <cover.1507320376.git.martin.agren@gmail.com>
References: <CAN0heSqr77dptPG2mixnLdNKKcgD36aPnEFtnTB6Oyip6WfQBA@mail.gmail.com> <cover.1507320376.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the original version of `write_locked_index()` returned with an
error, it didn't roll back the lockfile unless the error occured at the
very end, during closing/committing. See commit 03b866477 (read-cache:
new API write_locked_index instead of write_index/write_cache,
2014-06-13).

In commit 9f41c7a6b (read-cache: close index.lock in do_write_index,
2017-04-26), we learned to close the lock slightly earlier in the
callstack. That was mostly a side-effect of lockfiles being implemented
using temporary files, but didn't cause any real harm.

Recently, commit 076aa2cbd (tempfile: auto-allocate tempfiles on heap,
2017-09-05) introduced a subtle bug. If the temporary file is deleted
(i.e., the lockfile is rolled back), the tempfile-pointer in the `struct
lock_file` will be left dangling. Thus, an attempt to reuse the
lockfile, or even just to roll it back, will induce undefined behavior
-- most likely a crash.

Besides not crashing, we clearly want to make things consistent. The
guarantees which the lockfile-machinery itself provides is A) if we ask
to commit and it fails, roll back, and B) if we ask to close and it
fails, do _not_ roll back. Let's do the same for consistency.

Do not delete the temporary file in `do_write_index()`. One of its
callers, `write_locked_index()` will thereby avoid rolling back the
lock. The other caller, `write_shared_index()`, will delete its
temporary file anyway. Both of these callers will avoid undefined
behavior (crashing).

Teach `write_locked_index(..., COMMIT_LOCK)` to roll back the lock
before returning. If we have already succeeded and committed, it will be
a noop. Simplify the existing callers where we now have a superfluous
call to `rollback_lockfile()`. That should keep future readers from
wondering why the callers are inconsistent.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
v3: Maybe the commit message wasn't too long, but it was loong. For
example, some of it just duplicated stuff from the previous patch.

 builtin/difftool.c |  1 -
 cache.h            |  4 ++++
 merge.c            |  4 +---
 read-cache.c       | 14 ++++++++------
 sequencer.c        |  1 -
 5 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index b2d3ba753..bcc79d188 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -616,7 +616,6 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 			if (hold_lock_file_for_update(&lock, buf.buf, 0) < 0 ||
 			    write_locked_index(&wtindex, &lock, COMMIT_LOCK)) {
 				ret = error("could not write %s", buf.buf);
-				rollback_lock_file(&lock);
 				goto finish;
 			}
 			changed_files(&wt_modified, buf.buf, workdir);
diff --git a/cache.h b/cache.h
index 21a6856c5..0e26224b9 100644
--- a/cache.h
+++ b/cache.h
@@ -616,6 +616,10 @@ extern int read_index_unmerged(struct index_state *);
  * split index to the lockfile. If the temporary file for the shared
  * index cannot be created, fall back to the behavior described in
  * the previous paragraph.
+ *
+ * With `COMMIT_LOCK`, the lock is always committed or rolled back.
+ * Without it, the lock is closed, but neither committed nor rolled
+ * back.
  */
 extern int write_locked_index(struct index_state *, struct lock_file *lock, unsigned flags);
 
diff --git a/merge.c b/merge.c
index a18a452b5..e5d796c9f 100644
--- a/merge.c
+++ b/merge.c
@@ -91,9 +91,7 @@ int checkout_fast_forward(const struct object_id *head,
 	}
 	if (unpack_trees(nr_trees, t, &opts))
 		return -1;
-	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK)) {
-		rollback_lock_file(&lock_file);
+	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 		return error(_("unable to write new index file"));
-	}
 	return 0;
 }
diff --git a/read-cache.c b/read-cache.c
index c7aa3632a..0d8d2dede 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2182,9 +2182,8 @@ static int has_racy_timestamp(struct index_state *istate)
 void update_index_if_able(struct index_state *istate, struct lock_file *lockfile)
 {
 	if ((istate->cache_changed || has_racy_timestamp(istate)) &&
-	    verify_index(istate) &&
-	    write_locked_index(istate, lockfile, COMMIT_LOCK))
-		rollback_lock_file(lockfile);
+	    verify_index(istate))
+		write_locked_index(istate, lockfile, COMMIT_LOCK);
 }
 
 /*
@@ -2321,7 +2320,6 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 		return -1;
 	if (close_tempfile_gently(tempfile)) {
 		error(_("could not close '%s'"), tempfile->filename.buf);
-		delete_tempfile(&tempfile);
 		return -1;
 	}
 	if (stat(tempfile->filename.buf, &st))
@@ -2501,7 +2499,8 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
 	    (istate->cache_changed & ~EXTMASK)) {
 		if (si)
 			hashclr(si->base_sha1);
-		return do_write_locked_index(istate, lock, flags);
+		ret = do_write_locked_index(istate, lock, flags);
+		goto out;
 	}
 
 	if (getenv("GIT_TEST_SPLIT_INDEX")) {
@@ -2517,7 +2516,7 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
 	if (new_shared_index) {
 		ret = write_shared_index(istate, lock, flags);
 		if (ret)
-			return ret;
+			goto out;
 	}
 
 	ret = write_split_index(istate, lock, flags);
@@ -2526,6 +2525,9 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
 	if (!ret && !new_shared_index)
 		freshen_shared_index(sha1_to_hex(si->base_sha1), 1);
 
+out:
+	if (flags & COMMIT_LOCK)
+		rollback_lock_file(lock);
 	return ret;
 }
 
diff --git a/sequencer.c b/sequencer.c
index 60636ce54..d56c38081 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1183,7 +1183,6 @@ static int read_and_refresh_cache(struct replay_opts *opts)
 	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, NULL, NULL, NULL);
 	if (the_index.cache_changed && index_fd >= 0) {
 		if (write_locked_index(&the_index, &index_lock, COMMIT_LOCK)) {
-			rollback_lock_file(&index_lock);
 			return error(_("git %s: failed to refresh the index"),
 				_(action_name(opts)));
 		}
-- 
2.15.0.rc0

