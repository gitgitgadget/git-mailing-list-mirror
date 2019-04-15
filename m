Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9292A20248
	for <e@80x24.org>; Mon, 15 Apr 2019 18:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbfDOSY5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 14:24:57 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34529 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbfDOSY5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 14:24:57 -0400
Received: by mail-pg1-f195.google.com with SMTP id v12so8998242pgq.1
        for <git@vger.kernel.org>; Mon, 15 Apr 2019 11:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1fq8QBA+JmJgeuIiolNL9IzImRV+EmbfXcWM4sQVmHY=;
        b=b3M5qHHAELvxGgySIHp3zuyyUVPR7WvN9wV9ArS4pp6z0pfXzKe09Oc9i6arI5m141
         FPqn5rBDnAvYjJ+E8Mp/7bf/TAtu2PK4ZdFrjLaYszJI3/e3VrJLPxhvbo4enlLrg6+Q
         3pJQsVpoM0Iw4sGD3fhioG7J/UhrkCrOskVeJY8pQhIcGrN44tKo2iBln6/tvvpwG9SR
         Fm2z2olz3calflwqY7KoiUVMYkLI/o5lMJk1D06jpNI2E6IxlDtYRB3Y9DxpPyadGlB6
         jUWKYZ2oSy6Ab4ahVgG992PDVvs7RWkAQ+iF55K9wzdG6uJQZmIO9GPmGiz7ryDmIZ6X
         xBVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1fq8QBA+JmJgeuIiolNL9IzImRV+EmbfXcWM4sQVmHY=;
        b=Quc47bJk0d26kguEivVBl1OHOG6uyZ+uqxLbdcplUfvIBe0dpqriEivNipqCPhJ08i
         0zLMxfO8SlYcGfu0zt6u2TPv2j3w5siMaiaaFHeX0iGnkNw7/1f6rGKnsiPXvV9x5eOu
         nXn7gmggew3tTy6OY/fYv5e2gHP+wDUembqT0B4qEeMNzG+XwbwRPejsUL7pO59KBlx/
         FP4xKEwQVD7idSsI8d2ORVujK0HhLyBkakfDzWnLZAFgkwwcD7mrjxAJKsl0SlXBSti5
         33KMg0w/dqmdkIamckAQSXH/jHGsf9fcu2RDGZ77ABKZJVomG6+DJbgq70k3yzG4Ryee
         sJMA==
X-Gm-Message-State: APjAAAV32wuaf1Qo4ld8k2TKMfe+4Mbo9fAbqLDgXYOw5AWmYwpOUsU4
        6D5Q4KWOCQ5wrpz0/tJLtgvCE9Nx
X-Google-Smtp-Source: APXvYqw4jRya+OfJ2pwo3X+P5jKNBNcpcaX4AWAXSriY34/9TnIcemG/jjGWQyy2+vz++K8+ogFOmA==
X-Received: by 2002:a65:53cb:: with SMTP id z11mr70342585pgr.139.1555352695983;
        Mon, 15 Apr 2019 11:24:55 -0700 (PDT)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id t5sm63011618pfh.141.2019.04.15.11.24.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 11:24:54 -0700 (PDT)
Date:   Mon, 15 Apr 2019 11:24:53 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: [PATCH v2 0/3] remove extern from function declarations
Message-ID: <cover.1555352526.git.liu.denton@gmail.com>
References: <3e3b9d6c8e54b326809b95adabd3be39d2d0770f.1555111963.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e3b9d6c8e54b326809b95adabd3be39d2d0770f.1555111963.git.liu.denton@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all, thanks for the feedback.

I didn't realise that Coccinelle could be used to remove modifiers but
turns out I was wrong. However, Coccinelle seems to choke whenever
there's an __attribute__ or when there are varargs and I couldn't figure
out how to work around that. As a result, this patchset is written in
two parts: one using spatch and another using sed to get the rest.

Hopefully the sed patch is more easily digestable now.

Change since v1:

* Use spatch with sed instead of sed alone
* Fix sed expression to ignore function variables

Denton Liu (3):
  *.[ch]: remove extern from function declarations using spatch
  *.[ch]: remove extern from function declarations using sed
  cocci: prevent extern function declarations

 advice.h                          |   2 +-
 archive.h                         |  14 +-
 bisect.h                          |  12 +-
 blame.h                           |   2 +-
 branch.h                          |  12 +-
 builtin.h                         | 252 +++++++++++-----------
 bulk-checkin.h                    |   6 +-
 cache.h                           | 344 +++++++++++++++---------------
 checkout.h                        |   2 +-
 column.h                          |  12 +-
 commit.h                          |  72 +++----
 compat/mingw.c                    |   2 +-
 compat/mingw.h                    |   6 +-
 compat/nedmalloc/malloc.c.h       |   6 +-
 compat/obstack.h                  |   8 +-
 compat/poll/poll.h                |   2 +-
 compat/regex/regex.h              |  28 +--
 compat/win32/pthread.h            |   6 +-
 config.h                          | 184 ++++++++--------
 connect.h                         |  20 +-
 contrib/coccinelle/noextern.cocci |   6 +
 csum-file.h                       |  20 +-
 decorate.h                        |   4 +-
 delta.h                           |  10 +-
 dir.h                             |  70 +++---
 exec-cmd.h                        |  16 +-
 fmt-merge-msg.h                   |   2 +-
 fsmonitor.h                       |  14 +-
 gettext.h                         |   8 +-
 git-compat-util.h                 | 128 +++++------
 grep.h                            |  22 +-
 hashmap.h                         |  30 +--
 help.h                            |  30 +--
 http.h                            |  52 ++---
 khash.h                           |  14 +-
 kwset.h                           |  10 +-
 line-log.h                        |  16 +-
 lockfile.h                        |  10 +-
 ls-refs.h                         |   2 +-
 mailinfo.h                        |   6 +-
 merge-blobs.h                     |   2 +-
 object-store.h                    |  16 +-
 object.h                          |  12 +-
 oidmap.h                          |  10 +-
 pack.h                            |  24 +--
 packfile.h                        |  74 +++----
 path.h                            |  32 +--
 pkt-line.h                        |   6 +-
 ppc/sha1.c                        |   2 +-
 prio-queue.h                      |  10 +-
 protocol.h                        |   6 +-
 quote.h                           |  32 +--
 reachable.h                       |   4 +-
 reflog-walk.h                     |  16 +-
 refs.h                            |   2 +-
 remote.h                          |  12 +-
 replace-object.h                  |   2 +-
 resolve-undo.h                    |  14 +-
 run-command.h                     |   8 +-
 serve.h                           |   4 +-
 sha1-lookup.h                     |   2 +-
 streaming.h                       |   8 +-
 string-list.h                     |   2 +-
 sub-process.h                     |   2 +-
 submodule-config.h                |  20 +-
 tag.h                             |  14 +-
 tempfile.h                        |  26 +--
 trace.h                           |  34 +--
 transport.h                       |   4 +-
 tree-walk.h                       |   4 +-
 upload-pack.h                     |   4 +-
 url.h                             |  16 +-
 urlmatch.h                        |   4 +-
 utf8.h                            |   2 +-
 varint.h                          |   4 +-
 vcs-svn/sliding_window.h          |   2 +-
 vcs-svn/svndiff.h                 |   2 +-
 worktree.h                        |  22 +-
 xdiff-interface.h                 |  10 +-
 79 files changed, 969 insertions(+), 963 deletions(-)
 create mode 100644 contrib/coccinelle/noextern.cocci

Interdiff against v1:
diff --git a/compat/mingw.c b/compat/mingw.c
index 6b04514cdc..8e1ab3129e 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2483,7 +2483,7 @@ typedef struct {
 	int newmode;
 } _startupinfo;
 
-extern int __wgetmainargs(int *argc, wchar_t ***argv, wchar_t ***env, int glob,
+int __wgetmainargs(int *argc, wchar_t ***argv, wchar_t ***env, int glob,
 		_startupinfo *si);
 
 static NORETURN void die_startup(void)
diff --git a/compat/obstack.h b/compat/obstack.h
index 1ff8f3fc1e..168d1d8b38 100644
--- a/compat/obstack.h
+++ b/compat/obstack.h
@@ -197,7 +197,7 @@ void obstack_free (struct obstack *, void *);
    more memory.  This can be set to a user defined function which
    should either abort gracefully or use longjump - but shouldn't
    return.  The default action is to print a message and abort.  */
-void (*obstack_alloc_failed_handler) (void);
+extern void (*obstack_alloc_failed_handler) (void);
 
 /* Pointer to beginning of object being allocated or to be allocated next.
    Note that this might not be the final address of the object
diff --git a/contrib/coccinelle/noextern.cocci b/contrib/coccinelle/noextern.cocci
new file mode 100644
index 0000000000..8cb39ac947
--- /dev/null
+++ b/contrib/coccinelle/noextern.cocci
@@ -0,0 +1,6 @@
+@@
+type T;
+identifier f;
+@@
+- extern
+  T f(...);
diff --git a/delta.h b/delta.h
index 592bd9c27e..0fc3659633 100644
--- a/delta.h
+++ b/delta.h
@@ -13,7 +13,7 @@ struct delta_index;
  * before free_delta_index() is called.  The returned pointer must be freed
  * using free_delta_index().
  */
-extern struct delta_index *
+struct delta_index *
 create_delta_index(const void *buf, unsigned long bufsize);
 
 /*
@@ -40,7 +40,7 @@ unsigned long sizeof_delta_index(struct delta_index *index);
  * returned and *delta_size is updated with its size.  The returned buffer
  * must be freed by the caller.
  */
-extern void *
+void *
 create_delta(const struct delta_index *index,
 	     const void *buf, unsigned long bufsize,
 	     unsigned long *delta_size, unsigned long max_delta_size);
diff --git a/git-compat-util.h b/git-compat-util.h
index fbfc53df4b..cc2cd27f30 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -484,9 +484,9 @@ static inline int const_error(void)
 
 void set_die_routine(NORETURN_PTR void (*routine)(const char *err, va_list params));
 void set_error_routine(void (*routine)(const char *err, va_list params));
-void (*get_error_routine(void))(const char *err, va_list params);
+extern void (*get_error_routine(void))(const char *err, va_list params);
 void set_warn_routine(void (*routine)(const char *warn, va_list params));
-void (*get_warn_routine(void))(const char *warn, va_list params);
+extern void (*get_warn_routine(void))(const char *warn, va_list params);
 void set_die_is_recursing_routine(int (*routine)(void));
 
 int starts_with(const char *str, const char *prefix);
diff --git a/packfile.h b/packfile.h
index dab50405e0..4eb4d5f521 100644
--- a/packfile.h
+++ b/packfile.h
@@ -43,7 +43,7 @@ void for_each_file_in_pack_dir(const char *objdir,
 #define PACKDIR_FILE_PACK 1
 #define PACKDIR_FILE_IDX 2
 #define PACKDIR_FILE_GARBAGE 4
-void (*report_garbage)(unsigned seen_bits, const char *path);
+extern void (*report_garbage)(unsigned seen_bits, const char *path);
 
 void reprepare_packed_git(struct repository *r);
 void install_packed_git(struct repository *r, struct packed_git *pack);
diff --git a/ppc/sha1.c b/ppc/sha1.c
index ec6a1926d4..b5d8af4551 100644
--- a/ppc/sha1.c
+++ b/ppc/sha1.c
@@ -10,7 +10,7 @@
 #include <string.h>
 #include "sha1.h"
 
-extern void ppc_sha1_core(uint32_t *hash, const unsigned char *p,
+void ppc_sha1_core(uint32_t *hash, const unsigned char *p,
 			  unsigned int nblocks);
 
 int ppc_SHA1_Init(ppc_SHA_CTX *c)
-- 
2.21.0.921.gb27c68c4e9

