Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC72C07E9D
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 19:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiI0TTG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 15:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiI0TTF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 15:19:05 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667EDEC544
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 12:19:04 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id e18so7191320wmq.3
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 12:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=IiSp5xQV+YTP8afbipf2oPXMCsMihMqeRWM8WFcUq6o=;
        b=gBwrT7Zk8qtCFVslE651/zhVq3LQtT2ty+46/ufDSjZ5lKd1jHftI9uvo17jHqUrHL
         uzPNLH6OHzpwxOeFBzxTfYDtOZx/3+YOZnHkqYagQiOzj+DfytryPRe/i/2S++xj2+Q2
         OFbnbnZOnr1xh/WCa9TBWi1+S4FLwkCP0+2TtN4iBfRiWNPqJIKYszcJKhVYMgbi/prf
         uUWkK2f3a5a4bCGIu3qWb7NHMUSxmu/rjhQ/ruCGBxR+Awyv0lICYnKgke8Yt8h1xaPM
         2a83kDy413NveDdwPsHcLrfFkVSvcbcjleReuNb05pMAOWCGCJ5Ap+1fLSbIbVT0x/Y8
         QKlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=IiSp5xQV+YTP8afbipf2oPXMCsMihMqeRWM8WFcUq6o=;
        b=FL4ftGioQAhiapIy/Sxgxwzo0AwdZShcdkUbBxqbxe64EupSsY58DylBGCKDT85vbP
         3Qt5vCdbUDM4F2BjVC7MFI5oE4FzAPDvNugn5Mfatis89bC2HfL9IYW5BYcOPgSPOmfF
         MLPuK/hJVnuBmxWaNCFn1C48G6LWsZO3wDHGvd9ltQaLgRAmesb8BSgFVTVY+roUWbCb
         tH5lkgyQVFnWASEorncSBT3RkdYiAACeCOQsVH9ovmIJ5uoa3UshaIJbJwtGYJZaKKs/
         Li8LZsRoQnayerkmjZLqBQeqzKlCQJNuegp90Lg7cHRts11o8f+mvmcR1WT8ywu5ngLT
         usgQ==
X-Gm-Message-State: ACrzQf1VoGr+MyPQwyrYlMVUu5S6lFvbJOJi5wz6e/7+D00WNHaQLPBm
        Fj2Z0I8auGxwssr/KN/2nNYf62EZmn4=
X-Google-Smtp-Source: AMsMyM46J1vLsolEN6zpXNMLCVIVhnX8jad5g5E7psKiXXXr2YxlxmdGFWMkt7JyUP65jIxzSkjvVg==
X-Received: by 2002:a05:600c:4fcb:b0:3b4:a4dd:615f with SMTP id o11-20020a05600c4fcb00b003b4a4dd615fmr4122510wmq.160.1664306342723;
        Tue, 27 Sep 2022 12:19:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c4f5400b003b47e75b401sm16113651wmq.37.2022.09.27.12.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 12:19:02 -0700 (PDT)
Message-Id: <pull.1348.v2.git.git.1664306341425.gitgitgadget@gmail.com>
In-Reply-To: <pull.1348.git.git.1664236383785.gitgitgadget@gmail.com>
References: <pull.1348.git.git.1664236383785.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Sep 2022 19:19:01 +0000
Subject: [PATCH v2] tmp-objdir: skip clean up when handling a signal
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, John Cai <johncai86@gmail.com>,
        John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

In the tmp-objdir api, tmp_objdir_create will create a temporary
directory but also register signal handlers responsible for removing
the directory's contents and the directory itself. However, the
function responsible for recursively removing the contents and
directory, remove_dir_recurse() calls opendir(3) and closedir(3).
This can be problematic because these functions allocate and free
memory, which are not async-signal-safe functions. This can lead to
deadlocks.

One place we call tmp_objdir_create() is in git-receive-pack, where
we create a temporary quarantine directory "incoming". Incoming
objects will be written to this directory before they get moved to
the object directory.

We have observed this code leading to a deadlock:

	Thread 1 (Thread 0x7f621ba0b200 (LWP 326305)):
	#0  __lll_lock_wait_private (futex=futex@entry=0x7f621bbf8b80
		<main_arena>) at ./lowlevellock.c:35
	#1  0x00007f621baa635b in __GI___libc_malloc
		(bytes=bytes@entry=32816) at malloc.c:3064
	#2  0x00007f621bae9f49 in __alloc_dir (statp=0x7fff2ea7ed60,
		flags=0, close_fd=true, fd=5)
		at ../sysdeps/posix/opendir.c:118
	#3  opendir_tail (fd=5) at ../sysdeps/posix/opendir.c:69
	#4  __opendir (name=<optimized out>)
		at ../sysdeps/posix/opendir.c:92
	#5  0x0000557c19c77de1 in remove_dir_recurse ()
	git#6  0x0000557c19d81a4f in remove_tmp_objdir_on_signal ()
	#7  <signal handler called>
	git#8  _int_malloc (av=av@entry=0x7f621bbf8b80 <main_arena>,
		bytes=bytes@entry=7160) at malloc.c:4116
	git#9  0x00007f621baa62c9 in __GI___libc_malloc (bytes=7160)
		at malloc.c:3066
	git#10 0x00007f621bd1e987 in inflateInit2_ ()
		from /opt/gitlab/embedded/lib/libz.so.1
	git#11 0x0000557c19dbe5f4 in git_inflate_init ()
	git#12 0x0000557c19cee02a in unpack_compressed_entry ()
	git#13 0x0000557c19cf08cb in unpack_entry ()
	git#14 0x0000557c19cf0f32 in packed_object_info ()
	git#15 0x0000557c19cd68cd in do_oid_object_info_extended ()
	git#16 0x0000557c19cd6e2b in read_object_file_extended ()
	git#17 0x0000557c19cdec2f in parse_object ()
	git#18 0x0000557c19c34977 in lookup_commit_reference_gently ()
	git#19 0x0000557c19d69309 in mark_uninteresting ()
	git#20 0x0000557c19d2d180 in do_for_each_repo_ref_iterator ()
	git#21 0x0000557c19d21678 in for_each_ref ()
	git#22 0x0000557c19d6a94f in assign_shallow_commits_to_refs ()
	git#23 0x0000557c19bc02b2 in cmd_receive_pack ()
	git#24 0x0000557c19b29fdd in handle_builtin ()
	git#25 0x0000557c19b2a526 in cmd_main ()
	git#26 0x0000557c19b28ea2 in main ()

Since we can't do the cleanup in a portable and signal-safe way, skip
the cleanup when we're handling a signal.

This means that when signal handling, the temporary directory may not
get cleaned up properly. This is mitigated by b3cecf49ea (tmp-objdir: new
API for creating temporary writable databases, 2021-12-06) which changed
the default name and allows gc to clean up these temporary directories.

Signed-off-by: John Cai <johncai86@gmail.com>
---
    tmp-objdir: do not closedir() when handling a signal
    
    We have recently observed a Git process hanging around for weeks. A
    backtrace revealed that a git-receive-pack(1) process was deadlocked
    when trying to remove the quarantine directory "incoming." It turns out
    that the tmp_objdir API calls opendir(3) and closedir(3) to observe a
    directory's contents in order to remove all the contents before removing
    the directory itself. These functions are not async signal save as they
    allocate and free memory.
    
    The fix is to avoid calling these functions when handling a signal in
    order to avoid a deadlock. The implication of such a fix however, is
    that temporary object directories may not get cleaned up properly when a
    signal is being handled. The tradeoff this fix is making is to prevent
    deadlocks at the cost of temporary object directory cleanup.
    
    This is similar to 58d4d7f1c5 (2022-01-07 fetch: fix deadlock when
    cleaning up lockfiles in async signals) The difference being in this
    case, the cleanup of the files will not happen when handling a signal.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1348%2Fjohn-cai%2Fjc%2Ffix-tmp-objdir-signal-handling-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1348/john-cai/jc/fix-tmp-objdir-signal-handling-v2
Pull-Request: https://github.com/git/git/pull/1348

Range-diff vs v1:

 1:  78ee805c5aa < -:  ----------- tmp-objdir: do not opendir() when handling a signal
 -:  ----------- > 1:  ae58df8c938 tmp-objdir: skip clean up when handling a signal


 tmp-objdir.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/tmp-objdir.c b/tmp-objdir.c
index adf6033549e..5d5f15f6d76 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -31,7 +31,7 @@ static void tmp_objdir_free(struct tmp_objdir *t)
 	free(t);
 }
 
-static int tmp_objdir_destroy_1(struct tmp_objdir *t, int on_signal)
+static int tmp_objdir_destroy_1(struct tmp_objdir *t)
 {
 	int err;
 
@@ -41,7 +41,7 @@ static int tmp_objdir_destroy_1(struct tmp_objdir *t, int on_signal)
 	if (t == the_tmp_objdir)
 		the_tmp_objdir = NULL;
 
-	if (!on_signal && t->prev_odb)
+	if (t->prev_odb)
 		restore_primary_odb(t->prev_odb, t->path.buf);
 
 	/*
@@ -51,20 +51,14 @@ static int tmp_objdir_destroy_1(struct tmp_objdir *t, int on_signal)
 	 */
 	err = remove_dir_recursively(&t->path, 0);
 
-	/*
-	 * When we are cleaning up due to a signal, we won't bother
-	 * freeing memory; it may cause a deadlock if the signal
-	 * arrived while libc's allocator lock is held.
-	 */
-	if (!on_signal)
-		tmp_objdir_free(t);
+	tmp_objdir_free(t);
 
 	return err;
 }
 
 int tmp_objdir_destroy(struct tmp_objdir *t)
 {
-	return tmp_objdir_destroy_1(t, 0);
+	return tmp_objdir_destroy_1(t);
 }
 
 static void remove_tmp_objdir(void)
@@ -72,13 +66,6 @@ static void remove_tmp_objdir(void)
 	tmp_objdir_destroy(the_tmp_objdir);
 }
 
-static void remove_tmp_objdir_on_signal(int signo)
-{
-	tmp_objdir_destroy_1(the_tmp_objdir, 1);
-	sigchain_pop(signo);
-	raise(signo);
-}
-
 void tmp_objdir_discard_objects(struct tmp_objdir *t)
 {
 	remove_dir_recursively(&t->path, REMOVE_DIR_KEEP_TOPLEVEL);
@@ -169,7 +156,6 @@ struct tmp_objdir *tmp_objdir_create(const char *prefix)
 	the_tmp_objdir = t;
 	if (!installed_handlers) {
 		atexit(remove_tmp_objdir);
-		sigchain_push_common(remove_tmp_objdir_on_signal);
 		installed_handlers++;
 	}
 

base-commit: 4fd6c5e44459e6444c2cd93383660134c95aabd1
-- 
gitgitgadget
