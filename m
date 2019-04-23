Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91ABD1F453
	for <e@80x24.org>; Tue, 23 Apr 2019 23:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbfDWXko (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Apr 2019 19:40:44 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36268 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfDWXko (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Apr 2019 19:40:44 -0400
Received: by mail-pf1-f194.google.com with SMTP id z5so8281029pfn.3
        for <git@vger.kernel.org>; Tue, 23 Apr 2019 16:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R5pE27Fo0mrcO52uVZ8DhNI4EzN12fdwL+Ywn451Zmc=;
        b=GLVR3Mlx6NWySAtuCM5yQLIuLRvtffWp4a0vsWQ4WaQ3CckHQQZ/uPzfH98OFGPxbE
         q55DlKrkyMGltNUMUHkzgj54XU7e03ODriuh3BVpz2I2JDzJTiU+vSaDE1Kemz6iy1Se
         s4ULuahZFUbiNnHU20INIXgq2ePsj5B+Phb0mjj2+vuyUfEvia7CnhgFf5dsOmNdqihr
         X4Vk6ZhByBau5BGL1+Vyj1uKGIVaxY6BgNNrXSEDK/ipCLbFB4PUBFnXs0k866a0RZoH
         F1nCyqdg+XatixpMSOQiM9keW9V9dB18h3qhNAShCqtkiGRZ5r+itV1StRIDyB2lGsFc
         6y1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R5pE27Fo0mrcO52uVZ8DhNI4EzN12fdwL+Ywn451Zmc=;
        b=R53se6se4bv8hvJUdLbLai+nY+uHBXWm/V9cj/ZyUEn0+m1miXSoIyQRhoMj3FCghU
         V7xi703h2cNc9cblJeLeEXls7weNJKRwFMRj8XycOaa23eXcMc5g7i1vhSkFE0QEDlsf
         wmqXi06ij3jsYg/Yem4/W1giEuzX08Ya6cYe6KRRNLuyH8MwgwuE2xQVDlzNm8p9G3QE
         g7srCYEI8mcgW8Hk+tUjZVkFZtA9t3w1hfxXCgzsNcGX7EgbCXf40dDT3RYkBv8MQgBo
         9mWFBuZNcA0ctFc6sAsAHA/NJd9ZAVZ+l4v/gML1yQRwvmkMXh6z0t5A3YV9zLGV5nLF
         a+xA==
X-Gm-Message-State: APjAAAW4uBP/IVP4HK0hctes0gySmZIIzWY+pqe5bIoeAI8jD47U9OEe
        A8r/koAvfhumvfDl7WBycSsSe7ai
X-Google-Smtp-Source: APXvYqxbIU3VOpFv3Yhzg/Kc7VFZnURDX2ixZcGX7pWj9MDw6sv6kYhsVWsD5+r5gveIqPvS6PJP5Q==
X-Received: by 2002:a63:720c:: with SMTP id n12mr26993230pgc.348.1556062842931;
        Tue, 23 Apr 2019 16:40:42 -0700 (PDT)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id j12sm20835092pgg.79.2019.04.23.16.40.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 16:40:41 -0700 (PDT)
Date:   Tue, 23 Apr 2019 16:40:41 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 0/4] remove extern from function declarations
Message-ID: <cover.1556062365.git.liu.denton@gmail.com>
References: <cover.1555352526.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1555352526.git.liu.denton@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the review, Peff.

I've excluded all the files under compat/ from being changed as it's
easier this way. After this patchset is merged, I'll probably get around
to removing the externs from compat/ files later (the ones that aren't
copied from some external source) but for now, this patchset is big
enough as it is so we can leave those for now.

I also opted not to remove the noextern.cocci since we can probably do
this in the future but it's probably beneficial to leave it in for now
for the reasons that you've mentioned.

---

Changes since v1:

* Used spatch with sed instead of sed alone
* Fixed sed expression to ignore function variables

Changes since v2:

* Rebased on latest master (since last patchset hasn't been picked up
  yet)
* Manually aligned parameter lists that were mangled by the tools

Changes since v3:

* Excluded compat/ from cleanup

Denton Liu (4):
  *.[ch]: remove extern from function declarations using spatch
  *.[ch]: remove extern from function declarations using sed
  *.[ch]: manually align parameter lists
  cocci: prevent extern function declarations

 advice.h                          |   2 +-
 archive.h                         |  24 +-
 bisect.h                          |  26 +-
 blame.h                           |   2 +-
 branch.h                          |  14 +-
 builtin.h                         | 254 ++++++++++----------
 bulk-checkin.h                    |  10 +-
 cache.h                           | 386 +++++++++++++++---------------
 checkout.h                        |   6 +-
 column.h                          |  16 +-
 commit.h                          | 116 ++++-----
 config.h                          | 226 ++++++++---------
 connect.h                         |  22 +-
 contrib/coccinelle/noextern.cocci |   6 +
 csum-file.h                       |  20 +-
 decorate.h                        |   4 +-
 delta.h                           |  14 +-
 dir.h                             | 144 +++++------
 exec-cmd.h                        |  16 +-
 fmt-merge-msg.h                   |   2 +-
 fsmonitor.h                       |  14 +-
 gettext.h                         |   8 +-
 git-compat-util.h                 | 132 +++++-----
 grep.h                            |  22 +-
 hashmap.h                         |  30 +--
 help.h                            |  36 +--
 http.h                            |  62 ++---
 khash.h                           |  16 +-
 kwset.h                           |  10 +-
 line-log.h                        |  16 +-
 lockfile.h                        |  12 +-
 ls-refs.h                         |   4 +-
 mailinfo.h                        |   6 +-
 merge-blobs.h                     |   6 +-
 object-store.h                    |  32 +--
 object.h                          |  12 +-
 oidmap.h                          |  12 +-
 pack.h                            |  26 +-
 packfile.h                        |  82 +++----
 path.h                            |  42 ++--
 pkt-line.h                        |  10 +-
 ppc/sha1.c                        |   4 +-
 prio-queue.h                      |  10 +-
 protocol.h                        |   6 +-
 quote.h                           |  34 +--
 reachable.h                       |   8 +-
 reflog-walk.h                     |  28 +--
 refs.h                            |   2 +-
 remote.h                          |  24 +-
 replace-object.h                  |   4 +-
 resolve-undo.h                    |  14 +-
 run-command.h                     |   8 +-
 serve.h                           |   6 +-
 sha1-lookup.h                     |   8 +-
 streaming.h                       |   8 +-
 string-list.h                     |   4 +-
 sub-process.h                     |   8 +-
 submodule-config.h                |  22 +-
 tag.h                             |  16 +-
 tempfile.h                        |  30 +--
 trace.h                           |  44 ++--
 transport.h                       |   4 +-
 tree-walk.h                       |   4 +-
 upload-pack.h                     |   8 +-
 url.h                             |  16 +-
 urlmatch.h                        |   4 +-
 utf8.h                            |   2 +-
 varint.h                          |   4 +-
 vcs-svn/sliding_window.h          |   2 +-
 vcs-svn/svndiff.h                 |   4 +-
 worktree.h                        |  36 +--
 xdiff-interface.h                 |  12 +-
 72 files changed, 1145 insertions(+), 1139 deletions(-)
 create mode 100644 contrib/coccinelle/noextern.cocci

Range-diff against v3:
1:  2ed74c5e5b ! 1:  720d50aea7 *.[ch]: remove extern from function declarations using spatch
    @@ -19,7 +19,13 @@
     
         and it was run with:
     
    -            $ spatch --sp-file contrib/coccinelle/noextern.cocci --dir . --include-headers --in-place
    +            $ git ls-files \*.{c,h} | \
    +                    grep -v ^compat/ | \
    +                    xargs spatch --sp-file contrib/coccinelle/noextern.cocci --in-place
    +
    +    Files under `compat/` are intentionally excluded as some are directly
    +    copied from external sources and we should avoid churning them as much
    +    as possible.
     
         Signed-off-by: Denton Liu <liu.denton@gmail.com>
     
    @@ -1388,242 +1394,6 @@
      /* record author-date for each commit object */
      struct author_date_slab;
     
    - diff --git a/compat/mingw.c b/compat/mingw.c
    - --- a/compat/mingw.c
    - +++ b/compat/mingw.c
    -@@
    - 	int newmode;
    - } _startupinfo;
    - 
    --extern int __wgetmainargs(int *argc, wchar_t ***argv, wchar_t ***env, int glob,
    -+int __wgetmainargs(int *argc, wchar_t ***argv, wchar_t ***env, int glob,
    - 		_startupinfo *si);
    - 
    - static NORETURN void die_startup(void)
    -
    - diff --git a/compat/mingw.h b/compat/mingw.h
    - --- a/compat/mingw.h
    - +++ b/compat/mingw.h
    -@@
    - #undef _POSIX_THREAD_SAFE_FUNCTIONS
    - #endif
    - 
    --extern int mingw_core_config(const char *var, const char *value, void *cb);
    -+int mingw_core_config(const char *var, const char *value, void *cb);
    - #define platform_core_config mingw_core_config
    - 
    - /*
    -@@
    - 			*path = '/';
    - }
    - #define PATH_SEP ';'
    --extern char *mingw_query_user_email(void);
    -+char *mingw_query_user_email(void);
    - #define query_user_email mingw_query_user_email
    - #if !defined(__MINGW64_VERSION_MAJOR) && (!defined(_MSC_VER) || _MSC_VER < 1800)
    - #define PRIuMAX "I64u"
    -@@
    - /*
    -  * Used by Pthread API implementation for Windows
    -  */
    --extern int err_win_to_posix(DWORD winerr);
    -+int err_win_to_posix(DWORD winerr);
    -
    - diff --git a/compat/nedmalloc/malloc.c.h b/compat/nedmalloc/malloc.c.h
    - --- a/compat/nedmalloc/malloc.c.h
    - +++ b/compat/nedmalloc/malloc.c.h
    -@@
    - #include <unistd.h>     /* for sbrk, sysconf */
    - #else /* LACKS_UNISTD_H */
    - #if !defined(__FreeBSD__) && !defined(__OpenBSD__) && !defined(__NetBSD__)
    --extern void*     sbrk(ptrdiff_t);
    -+void*     sbrk(ptrdiff_t);
    - #endif /* FreeBSD etc */
    - #endif /* LACKS_UNISTD_H */
    - 
    -@@
    - #    define malloc_getpagesize sysconf(_SC_PAGE_SIZE)
    - #  else
    - #    if defined(BSD) || defined(DGUX) || defined(HAVE_GETPAGESIZE)
    --       extern size_t getpagesize();
    -+       size_t getpagesize();
    - #      define malloc_getpagesize getpagesize()
    - #    else
    - #      ifdef WIN32 /* use supplied emulation of getpagesize */
    -@@
    - /* skipped internal declaration from pthread.h */
    - #ifdef linux
    - #ifndef PTHREAD_MUTEX_RECURSIVE
    --extern int pthread_mutexattr_setkind_np __P ((pthread_mutexattr_t *__attr,
    -+int pthread_mutexattr_setkind_np __P ((pthread_mutexattr_t *__attr,
    - 					   int __kind));
    - #define PTHREAD_MUTEX_RECURSIVE PTHREAD_MUTEX_RECURSIVE_NP
    - #define pthread_mutexattr_settype(x,y) pthread_mutexattr_setkind_np(x,y)
    -
    - diff --git a/compat/obstack.h b/compat/obstack.h
    - --- a/compat/obstack.h
    - +++ b/compat/obstack.h
    -@@
    - 
    - /* Declare the external functions we use; they are in obstack.c.  */
    - 
    --extern void _obstack_newchunk (struct obstack *, int);
    --extern int _obstack_begin (struct obstack *, int, int,
    -+void _obstack_newchunk (struct obstack *, int);
    -+int _obstack_begin (struct obstack *, int, int,
    - 			    void *(*) (long), void (*) (void *));
    --extern int _obstack_begin_1 (struct obstack *, int, int,
    -+int _obstack_begin_1 (struct obstack *, int, int,
    - 			     void *(*) (void *, long),
    - 			     void (*) (void *, void *), void *);
    --extern int _obstack_memory_used (struct obstack *);
    -+int _obstack_memory_used (struct obstack *);
    - 
    - void obstack_free (struct obstack *, void *);
    - 
    -
    - diff --git a/compat/poll/poll.h b/compat/poll/poll.h
    - --- a/compat/poll/poll.h
    - +++ b/compat/poll/poll.h
    -@@
    - 
    - typedef unsigned long nfds_t;
    - 
    --extern int poll (struct pollfd *pfd, nfds_t nfd, int timeout);
    -+int poll (struct pollfd *pfd, nfds_t nfd, int timeout);
    - 
    - /* Define INFTIM only if doing so conforms to POSIX.  */
    - #if !defined (_POSIX_C_SOURCE) && !defined (_XOPEN_SOURCE)
    -
    - diff --git a/compat/regex/regex.h b/compat/regex/regex.h
    - --- a/compat/regex/regex.h
    - +++ b/compat/regex/regex.h
    -@@
    - #ifdef __USE_GNU
    - /* Sets the current default syntax to SYNTAX, and return the old syntax.
    -    You can also simply assign to the `re_syntax_options' variable.  */
    --extern reg_syntax_t re_set_syntax (reg_syntax_t __syntax);
    -+reg_syntax_t re_set_syntax (reg_syntax_t __syntax);
    - 
    - /* Compile the regular expression PATTERN, with length LENGTH
    -    and syntax given by the global `re_syntax_options', into the buffer
    -    BUFFER.  Return NULL if successful, and an error string if not.  */
    --extern const char *re_compile_pattern (const char *__pattern, size_t __length,
    -+const char *re_compile_pattern (const char *__pattern, size_t __length,
    - 				       struct re_pattern_buffer *__buffer);
    - 
    - 
    - /* Compile a fastmap for the compiled pattern in BUFFER; used to
    -    accelerate searches.  Return 0 if successful and -2 if was an
    -    internal error.  */
    --extern int re_compile_fastmap (struct re_pattern_buffer *__buffer);
    -+int re_compile_fastmap (struct re_pattern_buffer *__buffer);
    - 
    - 
    - /* Search in the string STRING (with length LENGTH) for the pattern
    -@@
    -    characters.  Return the starting position of the match, -1 for no
    -    match, or -2 for an internal error.  Also return register
    -    information in REGS (if REGS and BUFFER->no_sub are nonzero).  */
    --extern int re_search (struct re_pattern_buffer *__buffer, const char *__cstring,
    -+int re_search (struct re_pattern_buffer *__buffer, const char *__cstring,
    - 		      int __length, int __start, int __range,
    - 		      struct re_registers *__regs);
    - 
    - 
    - /* Like `re_search', but search in the concatenation of STRING1 and
    -    STRING2.  Also, stop searching at index START + STOP.  */
    --extern int re_search_2 (struct re_pattern_buffer *__buffer,
    -+int re_search_2 (struct re_pattern_buffer *__buffer,
    - 			const char *__string1, int __length1,
    - 			const char *__string2, int __length2, int __start,
    - 			int __range, struct re_registers *__regs, int __stop);
    -@@
    - 
    - /* Like `re_search', but return how many characters in STRING the regexp
    -    in BUFFER matched, starting at position START.  */
    --extern int re_match (struct re_pattern_buffer *__buffer, const char *__cstring,
    -+int re_match (struct re_pattern_buffer *__buffer, const char *__cstring,
    - 		     int __length, int __start, struct re_registers *__regs);
    - 
    - 
    - /* Relates to `re_match' as `re_search_2' relates to `re_search'.  */
    --extern int re_match_2 (struct re_pattern_buffer *__buffer,
    -+int re_match_2 (struct re_pattern_buffer *__buffer,
    - 		       const char *__string1, int __length1,
    - 		       const char *__string2, int __length2, int __start,
    - 		       struct re_registers *__regs, int __stop);
    -@@
    -    Unless this function is called, the first search or match using
    -    PATTERN_BUFFER will allocate its own register data, without
    -    freeing the old data.  */
    --extern void re_set_registers (struct re_pattern_buffer *__buffer,
    -+void re_set_registers (struct re_pattern_buffer *__buffer,
    - 			      struct re_registers *__regs,
    - 			      unsigned int __num_regs,
    - 			      regoff_t *__starts, regoff_t *__ends);
    -@@
    - #if defined _REGEX_RE_COMP || (defined _LIBC && defined __USE_BSD)
    - # ifndef _CRAY
    - /* 4.2 bsd compatibility.  */
    --extern char *re_comp (const char *);
    --extern int re_exec (const char *);
    -+char *re_comp (const char *);
    -+int re_exec (const char *);
    - # endif
    - #endif
    - 
    -@@
    - #endif
    - 
    - /* POSIX compatibility.  */
    --extern int regcomp (regex_t *__restrict __preg,
    -+int regcomp (regex_t *__restrict __preg,
    - 		    const char *__restrict __pattern,
    - 		    int __cflags);
    - 
    --extern int regexec (const regex_t *__restrict __preg,
    -+int regexec (const regex_t *__restrict __preg,
    - 		    const char *__restrict __cstring, size_t __nmatch,
    - 		    regmatch_t __pmatch[__restrict_arr],
    - 		    int __eflags);
    - 
    --extern size_t regerror (int __errcode, const regex_t *__restrict __preg,
    -+size_t regerror (int __errcode, const regex_t *__restrict __preg,
    - 			char *__restrict __errbuf, size_t __errbuf_size);
    - 
    --extern void regfree (regex_t *__preg);
    -+void regfree (regex_t *__preg);
    - 
    - 
    - #ifdef __cplusplus
    -
    - diff --git a/compat/win32/pthread.h b/compat/win32/pthread.h
    - --- a/compat/win32/pthread.h
    - +++ b/compat/win32/pthread.h
    -@@
    - 	DWORD tid;
    - } pthread_t;
    - 
    --extern int pthread_create(pthread_t *thread, const void *unused,
    -+int pthread_create(pthread_t *thread, const void *unused,
    - 			  void *(*start_routine)(void*), void *arg);
    - 
    - /*
    -@@
    -  */
    - #define pthread_join(a, b) win32_pthread_join(&(a), (b))
    - 
    --extern int win32_pthread_join(pthread_t *thread, void **value_ptr);
    -+int win32_pthread_join(pthread_t *thread, void **value_ptr);
    - 
    - #define pthread_equal(t1, t2) ((t1).tid == (t2).tid)
    --extern pthread_t pthread_self(void);
    -+pthread_t pthread_self(void);
    - 
    - static inline void NORETURN pthread_exit(void *ret)
    - {
    -
      diff --git a/config.h b/config.h
      --- a/config.h
      +++ b/config.h
2:  7d35a052a6 ! 2:  0ebda47252 *.[ch]: remove extern from function declarations using sed
    @@ -8,7 +8,13 @@
     
         This was done by running the following on my system with sed 4.2.2:
     
    -        $ git ls-files \*.{c,h} | xargs sed -i'' -e 's/^\(\s*\)extern \([^(]*([^*]\)/\1\2/'
    +        $ git ls-files \*.{c,h} | \
    +            grep -v ^compat/ | \
    +            xargs sed -i'' -e 's/^\(\s*\)extern \([^(]*([^*]\)/\1\2/'
    +
    +    Files under `compat/` are intentionally excluded as some are directly
    +    copied from external sources and we should avoid churning them as much
    +    as possible.
     
         Then, leftover instances of extern were found by running
     
3:  916c34450f ! 3:  a813c36cab *.[ch]: manually align parameter lists
    @@ -391,125 +391,6 @@
      
      /*
     
    - diff --git a/compat/obstack.h b/compat/obstack.h
    - --- a/compat/obstack.h
    - +++ b/compat/obstack.h
    -@@
    - 
    - void _obstack_newchunk (struct obstack *, int);
    - int _obstack_begin (struct obstack *, int, int,
    --			    void *(*) (long), void (*) (void *));
    -+		    void *(*) (long), void (*) (void *));
    - int _obstack_begin_1 (struct obstack *, int, int,
    --			     void *(*) (void *, long),
    --			     void (*) (void *, void *), void *);
    -+		      void *(*) (void *, long),
    -+		      void (*) (void *, void *), void *);
    - int _obstack_memory_used (struct obstack *);
    - 
    - void obstack_free (struct obstack *, void *);
    -
    - diff --git a/compat/regex/regex.h b/compat/regex/regex.h
    - --- a/compat/regex/regex.h
    - +++ b/compat/regex/regex.h
    -@@
    -    and syntax given by the global `re_syntax_options', into the buffer
    -    BUFFER.  Return NULL if successful, and an error string if not.  */
    - const char *re_compile_pattern (const char *__pattern, size_t __length,
    --				       struct re_pattern_buffer *__buffer);
    -+				struct re_pattern_buffer *__buffer);
    - 
    - 
    - /* Compile a fastmap for the compiled pattern in BUFFER; used to
    -@@
    -    match, or -2 for an internal error.  Also return register
    -    information in REGS (if REGS and BUFFER->no_sub are nonzero).  */
    - int re_search (struct re_pattern_buffer *__buffer, const char *__cstring,
    --		      int __length, int __start, int __range,
    --		      struct re_registers *__regs);
    -+	       int __length, int __start, int __range,
    -+	       struct re_registers *__regs);
    - 
    - 
    - /* Like `re_search', but search in the concatenation of STRING1 and
    -    STRING2.  Also, stop searching at index START + STOP.  */
    - int re_search_2 (struct re_pattern_buffer *__buffer,
    --			const char *__string1, int __length1,
    --			const char *__string2, int __length2, int __start,
    --			int __range, struct re_registers *__regs, int __stop);
    -+		 const char *__string1, int __length1,
    -+		 const char *__string2, int __length2, int __start,
    -+		 int __range, struct re_registers *__regs, int __stop);
    - 
    - 
    - /* Like `re_search', but return how many characters in STRING the regexp
    -    in BUFFER matched, starting at position START.  */
    - int re_match (struct re_pattern_buffer *__buffer, const char *__cstring,
    --		     int __length, int __start, struct re_registers *__regs);
    -+	      int __length, int __start, struct re_registers *__regs);
    - 
    - 
    - /* Relates to `re_match' as `re_search_2' relates to `re_search'.  */
    - int re_match_2 (struct re_pattern_buffer *__buffer,
    --		       const char *__string1, int __length1,
    --		       const char *__string2, int __length2, int __start,
    --		       struct re_registers *__regs, int __stop);
    -+		const char *__string1, int __length1,
    -+		const char *__string2, int __length2, int __start,
    -+		struct re_registers *__regs, int __stop);
    - 
    - 
    - /* Set REGS to hold NUM_REGS registers, storing them in STARTS and
    -@@
    -    PATTERN_BUFFER will allocate its own register data, without
    -    freeing the old data.  */
    - void re_set_registers (struct re_pattern_buffer *__buffer,
    --			      struct re_registers *__regs,
    --			      unsigned int __num_regs,
    --			      regoff_t *__starts, regoff_t *__ends);
    -+		       struct re_registers *__regs,
    -+		       unsigned int __num_regs,
    -+		       regoff_t *__starts, regoff_t *__ends);
    - #endif	/* Use GNU */
    - 
    - #if defined _REGEX_RE_COMP || (defined _LIBC && defined __USE_BSD)
    -@@
    - 
    - /* POSIX compatibility.  */
    - int regcomp (regex_t *__restrict __preg,
    --		    const char *__restrict __pattern,
    --		    int __cflags);
    -+	     const char *__restrict __pattern,
    -+	     int __cflags);
    - 
    - int regexec (const regex_t *__restrict __preg,
    --		    const char *__restrict __cstring, size_t __nmatch,
    --		    regmatch_t __pmatch[__restrict_arr],
    --		    int __eflags);
    -+	     const char *__restrict __cstring, size_t __nmatch,
    -+	     regmatch_t __pmatch[__restrict_arr],
    -+	     int __eflags);
    - 
    - size_t regerror (int __errcode, const regex_t *__restrict __preg,
    --			char *__restrict __errbuf, size_t __errbuf_size);
    -+		 char *__restrict __errbuf, size_t __errbuf_size);
    - 
    - void regfree (regex_t *__preg);
    - 
    -
    - diff --git a/compat/win32/pthread.h b/compat/win32/pthread.h
    - --- a/compat/win32/pthread.h
    - +++ b/compat/win32/pthread.h
    -@@
    - } pthread_t;
    - 
    - int pthread_create(pthread_t *thread, const void *unused,
    --			  void *(*start_routine)(void*), void *arg);
    -+		   void *(*start_routine)(void*), void *arg);
    - 
    - /*
    -  * To avoid the need of copying a struct, we use small macro wrapper to pass
    -
      diff --git a/config.h b/config.h
      --- a/config.h
      +++ b/config.h
4:  d5a1663048 = 4:  23ed6ad679 cocci: prevent extern function declarations
-- 
2.21.0.1000.g7817e26e80

