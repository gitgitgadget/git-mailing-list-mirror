Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D3351F4C0
	for <e@80x24.org>; Wed, 16 Oct 2019 12:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389474AbfJPMG7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Oct 2019 08:06:59 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52463 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733022AbfJPMG6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Oct 2019 08:06:58 -0400
Received: by mail-wm1-f65.google.com with SMTP id r19so2647924wmh.2
        for <git@vger.kernel.org>; Wed, 16 Oct 2019 05:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=4m7X1C/O84yjcZrIJqT0RwFJlnglVNixMooy1PiTfmU=;
        b=pzURkUoTj69R++ho+0+UnB4vGbwXdjLoI83zO12WsN7UwcMuY0EqVYMW+GQ1vo+2ZC
         NmQTOROg060jmObUyBxotNWZLoO2l/aAXptjtCpYfs7jPzV+E/z1O5rYW2R+miVKIb/q
         VG9HUD4PDhwL6tItiPgcOnNnutyHCoYVo9YqEEZoIqm6XZzceoFIoFQUWpgAz8jWCGhG
         rJ3CtualcOVclsWlB96GjS5BCJsNxz5X2jJOFvBZd8e04ThoDFRzpl71GEOogNzGCXpC
         s8seUDl6JLTlVa+9RwYFnGO5MpWYBzS0QhV/Jy+TCSdGLdOlijA8WNRXjkKZedXixQK4
         EjLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=4m7X1C/O84yjcZrIJqT0RwFJlnglVNixMooy1PiTfmU=;
        b=sJ1v2hLtDoGq/40tGaRJ9lH7qHkUaad83lbiNHur2AzgDjgIYLy8UWXwU42MhDokmj
         DafwLssFg9VBdVeEecaCb/NWqkGkVe80u65m5mVgudQbts38N+38ZbLF4lhSi+idB3AF
         Gw6eJWexNgYmde95zi/bJODpra7a8k8gk26jm2zajSIk//+XSMeXGQKlPEtglPsrdQNU
         4Ds+dKg54PsZXWR4aW/wcY9yOlaBt5QUpjfFUAn3189eYVmfLf8lnBZdABaI2RrLA2Ig
         Umgxg/+UoGcqoc96rAxcLLVu6NyfEBWQPb0lQNcNkpumQfDAYUmctsufzpV5UKXO+G63
         o1mw==
X-Gm-Message-State: APjAAAWpdzr9z9UrQH1hVF/SzSqNiAMQo9tgYSH0YQ3bAW0qSlRNXMhM
        dhKPK0MLTNPpTylojg0OvHnCLOSR
X-Google-Smtp-Source: APXvYqy2JxblE1Lz814Va0fPKxjbNnluAkMYLPp6UCaJfupImCm1YNUk0ZpOkbcpIVB7BlFY/1t8EQ==
X-Received: by 2002:a05:600c:29a:: with SMTP id 26mr3295871wmk.127.1571227614941;
        Wed, 16 Oct 2019 05:06:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e18sm34255491wrv.63.2019.10.16.05.06.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 05:06:54 -0700 (PDT)
Message-Id: <pull.402.git.1571227613.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Oct 2019 12:06:50 +0000
Subject: [PATCH 0/3] Revive 'pcre2-chartables-leakfix'
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As I had stated several times, I was really unhappy how the original fix
harped on nedmalloc and totally ignored runtime-configured custom
allocators.

So this is, at long last, my attempt to give this a new life. It is based
off of maint and needs trivial merge conflict resolutions relative to master
.

Range-diff relative to cb/pcre2-chartables-leakfix:

1:  770584d697e ! 1:  4feb8cc83a6 grep: make PCRE1 aware of custom allocator
    @@ Commit message
         to override the system alocator, and so it is incompatible with
         USE_NED_ALLOCATOR as reported by Dscho[1] (in similar code from PCRE2)

    +    Note that nedmalloc, as well as other custom allocators like jemalloc
    +    and mi-malloc, can be configured at runtime (via `LD_PRELOAD`),
    +    therefore we cannot know at compile time whether a custom allocator is
    +    used or not.
    +
         Make the minimum change possible to ensure this combination is supported
    -    by extending grep_init to set the PCRE1 specific functions to the NED
    -    versions (using the aliased names though) and therefore making sure all
    -    alocations are done inside PCRE1 with the same allocator than the rest
    -    of git.
    +    by extending `grep_init()` to set the PCRE1 specific functions to Git's
    +    idea of `malloc()` and `free()` and therefore making sure all
    +    allocations are done inside PCRE1 with the same allocator than the rest
    +    of Git.

    -    This change might have performance impact (hopefully for the best) and
    -    so will be good idea to test it in a platform where NED might have a
    -    positive impact (ex: Windows 7)
    +    This change has negligible performance impact: PCRE needs to allocate
    +    memory once per program run for the character table and for each pattern
    +    compilation. These are both rare events compared to matching patterns
    +    against lines. Actual measurements[2] show that the impact is lost in
    +    the noise.

         [1] https://public-inbox.org/git/pull.306.git.gitgitgadget@gmail.com
    +    [2] https://public-inbox.org/git/7f42007f-911b-c570-17f6-1c6af0429586@web.de

         Signed-off-by: Carlo Marcelo Arenas Bel├│n <carenas@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    -
    - ## Makefile ##
    -@@ Makefile: ifdef NATIVE_CRLF
    - endif
    - 
    - ifdef USE_NED_ALLOCATOR
    --    COMPAT_CFLAGS += -Icompat/nedmalloc
    -+    COMPAT_CFLAGS += -DUSE_NED_ALLOCATOR -Icompat/nedmalloc
    -     COMPAT_OBJS += compat/nedmalloc/nedmalloc.o
    -     OVERRIDE_STRDUP = YesPlease
    - endif
    +    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

      ## grep.c ##
     @@ grep.c: int grep_config(const char *var, const char *value, void *cb)
    @@ grep.c: int grep_config(const char *var, const char *value, void *cb)
       * default values from the template we read the configuration
       * information in an earlier call to git_config(grep_config).
     + *
    -+ * If using PCRE make sure that the library is configured
    -+ * to use the right allocator (ex: NED)
    ++ * If using PCRE, make sure that the library is configured
    ++ * to use the same allocator as Git (e.g. nedmalloc on Windows).
       */
      void grep_init(struct grep_opt *opt, struct repository *repo, const char *prefix)
      {
          struct grep_opt *def = &grep_defaults;
          int i;

    -+#ifdef USE_NED_ALLOCATOR
     +#ifdef USE_LIBPCRE1
     +    pcre_malloc = malloc;
     +    pcre_free = free;
     +#endif
    -+#endif
     +
          memset(opt, 0, sizeof(*opt));
          opt->repo = repo;
2:  cf8d36f34a2 ! 2:  39ad220c18b grep: make PCRE2 aware of custom allocator
    @@
      ## Metadata ##
    -Author: Carlo Marcelo Arenas Bel├│n <carenas@gmail.com>
    +Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>

      ## Commit message ##
         grep: make PCRE2 aware of custom allocator

         94da9193a6 (grep: add support for PCRE v2, 2017-06-01) didn't include
         a way to override the system allocator, and so it is incompatible with
    -    USE_NED_ALLOCATOR.  The problem was made visible when an attempt to
    -    avoid a leak in a data structure that is created by the library was
    -    passed to NED's free for disposal triggering a segfault in Windows.
    +    custom allocators (e.g. nedmalloc). This problem became obvious when we
    +    tried to plug a memory leak by `free()`ing a data structure allocated by
    +    PCRE2, triggering a segfault in Windows (where we use nedmalloc by
    +    default).

         PCRE2 requires the use of a general context to override the allocator
         and therefore, there is a lot more code needed than in PCRE1, including
    @@ Commit message
         Extend the grep API with a "destructor" that could be called to cleanup
         any objects that were created and used globally.

    -    Update builtin/grep to use that new API, but any other future
    -    users should make sure to have matching grep_init/grep_destroy calls
    -    if they are using the pattern matching functionality (currently only
    -    relevant when using both NED and PCRE2)
    +    Update `builtin/grep.c` to use that new API, but any other future users
    +    should make sure to have matching `grep_init()`/`grep_destroy()` calls
    +    if they are using the pattern matching functionality.

         Move some of the logic that was before done per thread (in the workers)
    -    into an earlier phase to avoid degrading performance, but as the use
    -    of PCRE2 with NED is better understood it is expected more of its
    -    functions will be instructed to use the custom allocator as well as
    +    into an earlier phase to avoid degrading performance, but as the use of
    +    PCRE2 with custom allocators is better understood it is expected more of
    +    its functions will be instructed to use the custom allocator as well as
         was done in the original code[1] this work was based on.

         [1] https://public-inbox.org/git/3397e6797f872aedd18c6d795f4976e1c579514b.1565005867.git.gitgitgadget@gmail.com/

         Reported-by: Johannes Schindelin <johannes.schindelin@gmx.de>
         Signed-off-by: Carlo Marcelo Arenas Bel├│n <carenas@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

      ## builtin/grep.c ##
     @@ builtin/grep.c: int cmd_grep(int argc, const char **argv, const char *prefix)
    @@ grep.c: static int grep_source_is_binary(struct grep_source *gs,
     +#ifdef USE_LIBPCRE2
     +static pcre2_general_context *pcre2_global_context;
     +
    -+#ifdef USE_NED_ALLOCATOR
     +static void *pcre2_malloc(PCRE2_SIZE size, MAYBE_UNUSED void *memory_data)
     +{
     +    return malloc(size);
    @@ grep.c: static int grep_source_is_binary(struct grep_source *gs,
     +    return free(pointer);
     +}
     +#endif
    -+#endif
     +
      static const char *color_grep_slots[] = {
          [GREP_COLOR_CONTEXT]        = "context",
          [GREP_COLOR_FILENAME]        = "filename",
     @@ grep.c: int grep_config(const char *var, const char *value, void *cb)
       *
    -  * If using PCRE make sure that the library is configured
    -  * to use the right allocator (ex: NED)
    -+ * if any object is created it should be cleaned up in grep_destroy()
    +  * If using PCRE, make sure that the library is configured
    +  * to use the same allocator as Git (e.g. nedmalloc on Windows).
    ++ *
    ++ * Any allocated memory needs to be released in grep_destroy().
       */
      void grep_init(struct grep_opt *opt, struct repository *repo, const char *prefix)
      {
    +     struct grep_opt *def = &grep_defaults;
    +     int i;
    + 
    ++#if defined(USE_LIBPCRE2)
    ++    if (!pcre2_global_context)
    ++        pcre2_global_context = pcre2_general_context_create(
    ++                    pcre2_malloc, pcre2_free, NULL);
    ++#endif
    ++
    + #ifdef USE_LIBPCRE1
    +     pcre_malloc = malloc;
    +     pcre_free = free;
     @@ grep.c: void grep_init(struct grep_opt *opt, struct repository *repo, const char *prefix
              color_set(opt->colors[i], def->colors[i]);
      }
    @@ grep.c: void grep_init(struct grep_opt *opt, struct repository *repo, const char
      static void grep_set_pattern_type_option(enum grep_pattern_type pattern_type, struct grep_opt *opt)
      {
          /*
    -@@ grep.c: void append_header_grep_pattern(struct grep_opt *opt,
    - void append_grep_pattern(struct grep_opt *opt, const char *pat,
    -              const char *origin, int no, enum grep_pat_token t)
    - {
    -+#if defined(USE_LIBPCRE2) && defined(USE_NED_ALLOCATOR)
    -+    if (!pcre2_global_context && opt->ignore_case && has_non_ascii(pat))
    -+        pcre2_global_context = pcre2_general_context_create(
    -+                    pcre2_malloc, pcre2_free, NULL);
    -+#endif
    -     append_grep_pat(opt, pat, strlen(pat), origin, no, t);
    - }
    - 
     @@ grep.c: static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt

          p->pcre2_compile_context = NULL;
    @@ grep.c: static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_
          if (opt->ignore_case) {
              if (has_non_ascii(p->pattern)) {
     -            character_tables = pcre2_maketables(NULL);
    -+#ifdef USE_NED_ALLOCATOR
     +            if (!pcre2_global_context)
     +                BUG("pcre2_global_context uninitialized");
    -+#endif
     +            character_tables = pcre2_maketables(pcre2_global_context);
                  p->pcre2_compile_context = pcre2_compile_context_create(NULL);
                  pcre2_set_character_tables(p->pcre2_compile_context, character_tables);
3:  54aef142151 ! 3:  3ced7c386a0 grep: avoid leak of chartables in PCRE2
    @@
      ## Metadata ##
    -Author: Carlo Marcelo Arenas Bel├│n <carenas@gmail.com>
    +Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>

      ## Commit message ##
         grep: avoid leak of chartables in PCRE2
    @@ Commit message
         for PCRE1.

         Signed-off-by: Carlo Marcelo Arenas Bel├│n <carenas@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

      ## grep.c ##
     @@ grep.c: static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
    @@ grep.c: static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_
          int patinforet;
          size_t jitsizearg;
     @@ grep.c: static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
    +         if (has_non_ascii(p->pattern)) {
                  if (!pcre2_global_context)
                      BUG("pcre2_global_context uninitialized");
    - #endif
     -            character_tables = pcre2_maketables(pcre2_global_context);
     +            p->pcre2_tables = pcre2_maketables(pcre2_global_context);
                  p->pcre2_compile_context = pcre2_compile_context_create(NULL);

My merge conflict resolution with master
[https://github.com/dscho/git/commit/pcre2-chartables-leakfix-merge-with-master]
:

diff --cc grep.c
index 9556d13dc1d,0bb4cbd3d82..b7ae5a442a6
--- a/grep.c
+++ b/grep.c
@@@ -533,15 -470,11 +506,15 @@@ static void compile_pcre2_pattern(struc

      p->pcre2_compile_context = NULL;

 +    /* pcre2_global_context is initialized in append_grep_pattern */
      if (opt->ignore_case) {
-         if (has_non_ascii(p->pattern)) {
+         if (!opt->ignore_locale && has_non_ascii(p->pattern)) {
 -            character_tables = pcre2_maketables(NULL);
 +            if (!pcre2_global_context)
 +                BUG("pcre2_global_context uninitialized");
 +            p->pcre2_tables = pcre2_maketables(pcre2_global_context);
              p->pcre2_compile_context = pcre2_compile_context_create(NULL);
 -            pcre2_set_character_tables(p->pcre2_compile_context, character_tables);
 +            pcre2_set_character_tables(p->pcre2_compile_context,
 +                            p->pcre2_tables);
          }
          options |= PCRE2_CASELESS;
      }
@@@ -643,9 -571,6 +611,7 @@@ static void free_pcre2_pattern(struct g
      pcre2_compile_context_free(p->pcre2_compile_context);
      pcre2_code_free(p->pcre2_pattern);
      pcre2_match_data_free(p->pcre2_match_data);
-     pcre2_jit_stack_free(p->pcre2_jit_stack);
-     pcre2_match_context_free(p->pcre2_match_context);
 +    free((void *)p->pcre2_tables);
  }
  #else /* !USE_LIBPCRE2 */
  static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt)
diff --cc grep.h
index 533165c21a5,05dc1bb98e5..811fd274c95
--- a/grep.h
+++ b/grep.h
@@@ -94,12 -78,9 +78,10 @@@ struct grep_pat 
      pcre2_code *pcre2_pattern;
      pcre2_match_data *pcre2_match_data;
      pcre2_compile_context *pcre2_compile_context;
-     pcre2_match_context *pcre2_match_context;
-     pcre2_jit_stack *pcre2_jit_stack;
 +    const uint8_t *pcre2_tables;
      uint32_t pcre2_jit_on;
-     kwset_t kws;
      unsigned fixed:1;
+     unsigned is_fixed:1;
      unsigned ignore_case:1;
      unsigned word_regexp:1;
  };

Carlo Marcelo Arenas Belón (2):
  grep: make PCRE1 aware of custom allocator
  grep: make PCRE2 aware of custom allocator

Johannes Schindelin (1):
  grep: avoid leak of chartables in PCRE2

 builtin/grep.c |  1 +
 grep.c         | 47 ++++++++++++++++++++++++++++++++++++++++++++---
 grep.h         |  2 ++
 3 files changed, 47 insertions(+), 3 deletions(-)


base-commit: 51cf315870bbb7254ddf06c84fe03b41bc48eebd
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-402%2Fdscho%2Fpcre2-chartables-leakfix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-402/dscho/pcre2-chartables-leakfix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/402
-- 
gitgitgadget
