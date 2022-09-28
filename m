Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FD9C32771
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 14:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbiI1O4D (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 10:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbiI1O4B (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 10:56:01 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D379579685
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 07:55:59 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id bk15so12457998wrb.13
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 07:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=rmW/lzrBfOlmL+ZmOPoglv8bSD6TVK0A+0gp4C1GGME=;
        b=n7u6GCAazzPLFhGSypL/vRPaqFfRjtO65QLVpfLKSVbw1ZQH0jXKddpwytC4pz1orh
         OT5ZYJ6nauM6l3FtWuputCMzaBy4mHJggATG5F+C0+2c2V5H+yIHe3WumrWi2MwvQrhw
         FqIh7oUXkoOnVkg0y7zBcnzOnRwU82AxEJ2TTYGtGI6iRpe3Wv6qaWBmKOwzN6Zo70y2
         d5d1+UotMKadEXueYwGU9pscGGHLMGEooyrDhEgBG/k33Uc/NIiCL76NAvCJSdGNI2ne
         paC5FYt8FfSbd0wp5gDnzDgRKkgHHyQndfpcKcOn74BZZau4Y9qBnrsZRIKYlEbxIc4s
         yNdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=rmW/lzrBfOlmL+ZmOPoglv8bSD6TVK0A+0gp4C1GGME=;
        b=ErHOeGld5LjRsVKFfJcUq4XBF5F+ZkvbM/yIZ/ar0+OhgQ7LIJN+zu+5INBkGnsb1k
         QfjsIoNtKojugT5RoY51Q8fzkJWwRhTTEJGE6vJ3gc6ZohKuF2r4CwuQeVhOz+InfW7C
         mZMz89DivRlGJykjlH6sIxM3Y1VCw4NOtHk4s1ENCrUHOMK96c4TQD6eoKDBV9IELKBI
         hTMtE9sRmUOPKgUGp1thtkzBffo58qjX0OJ8y1cDkFW7M1MQOA+IHyqoNzsBrViLtOEc
         WtrvgMlDle0TPM1kJeUqPZHjUFjpG/zRlqVQb9lpx8/rMOIVe8rMxn93VXCJbitHPqg1
         WlPA==
X-Gm-Message-State: ACrzQf0NxIdTjwN2Cy7c0MRA7OD/u35AtdAXwzLYX5UWsvKVsjtP76lo
        E/a44iVhun7TY0JjTV/kiyv/9LJgXh8=
X-Google-Smtp-Source: AMsMyM6bs614ndD4TFD1UXgAiZDSNLicma7/d1IsI+PDsEMqm774wqFE8ztZBGryyQr2nYad8p5Iug==
X-Received: by 2002:a5d:6da2:0:b0:228:64cb:5333 with SMTP id u2-20020a5d6da2000000b0022864cb5333mr20087079wrs.428.1664376958014;
        Wed, 28 Sep 2022 07:55:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o1-20020a5d62c1000000b0022ccae2fa62sm1073849wrv.22.2022.09.28.07.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 07:55:57 -0700 (PDT)
Message-Id: <pull.1348.v3.git.git.1664376956780.gitgitgadget@gmail.com>
In-Reply-To: <pull.1348.v2.git.git.1664306341425.gitgitgadget@gmail.com>
References: <pull.1348.v2.git.git.1664306341425.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 28 Sep 2022 14:55:56 +0000
Subject: [PATCH v3] tmp-objdir: skip clean up when handling a signal
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1348%2Fjohn-cai%2Fjc%2Ffix-tmp-objdir-signal-handling-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1348/john-cai/jc/fix-tmp-objdir-signal-handling-v3
Pull-Request: https://github.com/git/git/pull/1348

Range-diff vs v2:

 1:  ae58df8c938 ! 1:  d96c44e309f tmp-objdir: skip clean up when handling a signal
     @@ Commit message
          Signed-off-by: John Cai <johncai86@gmail.com>
      
       ## tmp-objdir.c ##
     +@@ tmp-objdir.c: struct tmp_objdir {
     + 
     + /*
     +  * Allow only one tmp_objdir at a time in a running process, which simplifies
     +- * our signal/atexit cleanup routines.  It's doubtful callers will ever need
     ++ * our atexit cleanup routines.  It's doubtful callers will ever need
     +  * more than one, and we can expand later if so.  You can have many such
     +  * tmp_objdirs simultaneously in many processes, of course.
     +  */
      @@ tmp-objdir.c: static void tmp_objdir_free(struct tmp_objdir *t)
       	free(t);
       }
       
      -static int tmp_objdir_destroy_1(struct tmp_objdir *t, int on_signal)
     -+static int tmp_objdir_destroy_1(struct tmp_objdir *t)
     ++int tmp_objdir_destroy(struct tmp_objdir *t)
       {
       	int err;
       
     @@ tmp-objdir.c: static int tmp_objdir_destroy_1(struct tmp_objdir *t, int on_signa
      +	if (t->prev_odb)
       		restore_primary_odb(t->prev_odb, t->path.buf);
       
     - 	/*
     -@@ tmp-objdir.c: static int tmp_objdir_destroy_1(struct tmp_objdir *t, int on_signal)
     - 	 */
     +-	/*
     +-	 * This may use malloc via strbuf_grow(), but we should
     +-	 * have pre-grown t->path sufficiently so that this
     +-	 * doesn't happen in practice.
     +-	 */
       	err = remove_dir_recursively(&t->path, 0);
       
      -	/*
     @@ tmp-objdir.c: static int tmp_objdir_destroy_1(struct tmp_objdir *t, int on_signa
       	return err;
       }
       
     - int tmp_objdir_destroy(struct tmp_objdir *t)
     - {
     +-int tmp_objdir_destroy(struct tmp_objdir *t)
     +-{
      -	return tmp_objdir_destroy_1(t, 0);
     -+	return tmp_objdir_destroy_1(t);
     - }
     - 
     +-}
     +-
       static void remove_tmp_objdir(void)
     -@@ tmp-objdir.c: static void remove_tmp_objdir(void)
     + {
       	tmp_objdir_destroy(the_tmp_objdir);
       }
       
     @@ tmp-objdir.c: static void remove_tmp_objdir(void)
       void tmp_objdir_discard_objects(struct tmp_objdir *t)
       {
       	remove_dir_recursively(&t->path, REMOVE_DIR_KEEP_TOPLEVEL);
     +@@ tmp-objdir.c: struct tmp_objdir *tmp_objdir_create(const char *prefix)
     + 	 */
     + 	strbuf_addf(&t->path, "%s/tmp_objdir-%s-XXXXXX", get_object_directory(), prefix);
     + 
     +-	/*
     +-	 * Grow the strbuf beyond any filename we expect to be placed in it.
     +-	 * If tmp_objdir_destroy() is called by a signal handler, then
     +-	 * we should be able to use the strbuf to remove files without
     +-	 * having to call malloc.
     +-	 */
     +-	strbuf_grow(&t->path, 1024);
     +-
     + 	if (!mkdtemp(t->path.buf)) {
     + 		/* free, not destroy, as we never touched the filesystem */
     + 		tmp_objdir_free(t);
      @@ tmp-objdir.c: struct tmp_objdir *tmp_objdir_create(const char *prefix)
       	the_tmp_objdir = t;
       	if (!installed_handlers) {


 tmp-objdir.c | 40 ++++------------------------------------
 1 file changed, 4 insertions(+), 36 deletions(-)

diff --git a/tmp-objdir.c b/tmp-objdir.c
index adf6033549e..2a2012eb6d0 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -18,7 +18,7 @@ struct tmp_objdir {
 
 /*
  * Allow only one tmp_objdir at a time in a running process, which simplifies
- * our signal/atexit cleanup routines.  It's doubtful callers will ever need
+ * our atexit cleanup routines.  It's doubtful callers will ever need
  * more than one, and we can expand later if so.  You can have many such
  * tmp_objdirs simultaneously in many processes, of course.
  */
@@ -31,7 +31,7 @@ static void tmp_objdir_free(struct tmp_objdir *t)
 	free(t);
 }
 
-static int tmp_objdir_destroy_1(struct tmp_objdir *t, int on_signal)
+int tmp_objdir_destroy(struct tmp_objdir *t)
 {
 	int err;
 
@@ -41,44 +41,21 @@ static int tmp_objdir_destroy_1(struct tmp_objdir *t, int on_signal)
 	if (t == the_tmp_objdir)
 		the_tmp_objdir = NULL;
 
-	if (!on_signal && t->prev_odb)
+	if (t->prev_odb)
 		restore_primary_odb(t->prev_odb, t->path.buf);
 
-	/*
-	 * This may use malloc via strbuf_grow(), but we should
-	 * have pre-grown t->path sufficiently so that this
-	 * doesn't happen in practice.
-	 */
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
 
-int tmp_objdir_destroy(struct tmp_objdir *t)
-{
-	return tmp_objdir_destroy_1(t, 0);
-}
-
 static void remove_tmp_objdir(void)
 {
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
@@ -152,14 +129,6 @@ struct tmp_objdir *tmp_objdir_create(const char *prefix)
 	 */
 	strbuf_addf(&t->path, "%s/tmp_objdir-%s-XXXXXX", get_object_directory(), prefix);
 
-	/*
-	 * Grow the strbuf beyond any filename we expect to be placed in it.
-	 * If tmp_objdir_destroy() is called by a signal handler, then
-	 * we should be able to use the strbuf to remove files without
-	 * having to call malloc.
-	 */
-	strbuf_grow(&t->path, 1024);
-
 	if (!mkdtemp(t->path.buf)) {
 		/* free, not destroy, as we never touched the filesystem */
 		tmp_objdir_free(t);
@@ -169,7 +138,6 @@ struct tmp_objdir *tmp_objdir_create(const char *prefix)
 	the_tmp_objdir = t;
 	if (!installed_handlers) {
 		atexit(remove_tmp_objdir);
-		sigchain_push_common(remove_tmp_objdir_on_signal);
 		installed_handlers++;
 	}
 

base-commit: 4fd6c5e44459e6444c2cd93383660134c95aabd1
-- 
gitgitgadget
