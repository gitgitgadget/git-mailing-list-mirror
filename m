Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF625C433EF
	for <git@archiver.kernel.org>; Mon, 23 May 2022 20:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbiEWUM6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 16:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbiEWUMw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 16:12:52 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6711F9E9E7
        for <git@vger.kernel.org>; Mon, 23 May 2022 13:12:49 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id h14so22902444wrc.6
        for <git@vger.kernel.org>; Mon, 23 May 2022 13:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3SUgjXjObkU4E8x6G0yuayXGQN/2N3mkBtTW+TsXAH8=;
        b=pVRUV+GmM7/LjTh4+O8PWoD01gOaeUh1WDWSXN5pO3Qt8vCbVXz6avSELRNs0vcKti
         OrGWqy+Qju0rHcs+HoGCSwsVuhXPpohh9fgh/D2SBwaLhm3iVYs21tmTKIexUdJFq7S+
         12cqD0zCwdSMlRoSkDnNy7u217UlthqhJvE73E3tiNoDV3RRagLih4x++IyHc89soo8R
         DEz8MBm1kRT8O6XWdmYGzCHDVmh/67EJKqQ0i54VJSJh2MGSOaVD05Aq7EtfRkoDQF8g
         SZZ5UvopdIVzuwSTnBjE/FCcI+SCS6aPpb739khkqVqImjyZyh0Nbr6CkYzCKBr6yNqJ
         fsGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3SUgjXjObkU4E8x6G0yuayXGQN/2N3mkBtTW+TsXAH8=;
        b=I125UWtDkpCNLwPtwvu2mjB7q5s9vIUvdFWNIbPfkpGuFd12DUJlrfTwWcodY21VCr
         UdgjLzFklC6moXkxHbZIYRFImWKDIjMBg4PXPPKZL/kow/p/JisYp+MjsnkRbebWkpEu
         XLxh/ZiWs9+Z2NzX2x3gzETHZg9ekcwTp2xQ1ZTdcqPUQ3xOq/pT+loH3VlznXZLBgac
         A0c5f30uNwYoIg2Bd2ETloowye3pV7ZBbifY6cwJBMIda0CNGatWlnBlebb8Lo4/ISdy
         ftGGB7CUDjEYyFrC18qFnt0B+iYfTC8K3yzntmWzGtIpbKfdt/T4jwVDAP5fukGQJvNf
         Iq7A==
X-Gm-Message-State: AOAM531acmSOCyRtFt+utxg4eWBGjfO6J7ZLukTWemy27KQsktz4LvI7
        G+IrRnVOygjxFqZ5eEjQtqr5dQ2FPUQ=
X-Google-Smtp-Source: ABdhPJzCixVpev10ATl/VBYXnBc9HNhy4ILp2Mhwpx3u2FTS0x1Irog6wn/M8VyQY3/4t6xrT4Gvxw==
X-Received: by 2002:adf:e505:0:b0:20e:58ce:8cec with SMTP id j5-20020adfe505000000b0020e58ce8cecmr20119663wrm.532.1653336767090;
        Mon, 23 May 2022 13:12:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h1-20020a1ccc01000000b003973a3fe4fasm142078wmb.42.2022.05.23.13.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 13:12:46 -0700 (PDT)
Message-Id: <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
References: <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 May 2022 20:12:15 +0000
Subject: [PATCH v7 00/30] Builtin FSMonitor Part 3
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        rsbecker@nexbridge.com, Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is version 7 of part 3 of FSMonitor.

This version mainly addresses comments received on V6.

 1. A few typos.
 2. Cleanup of some wide-char string manipulations in Windows code.
 3. Fix some coding-style issues in the unit tests: don't capitalize test
    case description and single-quote the descriptions when possible.
 4. Add t/helper/test-hexdump.c and use that in t7527 rather than
    /usr/bin/od in the Unicode/UTF8 compatibility tests for macOS.
 5. Refactor the implicit daemon shutdown tests to retry a few times rather
    than a fixed sleep. This helps avoid races in the CI build runs.

Here is a range-diff against V6:

 1:  8b7c5f4e23 !  1:  26144c5865 fsm-listen-win32: handle shortnames
    @@ compat/fsmonitor/fsm-listen-win32.c: struct one_watch
     +   * clients.)
     +   */
     +  BOOL has_shortnames;
    -+  BOOL has_tilda;
    ++  BOOL has_tilde;
     +  wchar_t dotgit_shortname[16]; /* for 8.3 name */
      };
      
    @@ compat/fsmonitor/fsm-listen-win32.c: static int normalize_path_in_utf8(FILE_NOTI
     +{
     +  wchar_t buf_in[MAX_PATH + 1];
     +  wchar_t buf_out[MAX_PATH + 1];
    -+  wchar_t *last_slash = NULL;
    -+  wchar_t *last_bslash = NULL;
     +  wchar_t *last;
    ++  wchar_t *p;
     +
     +  /* build L"<wt-root-path>/.git" */
    -+  wcscpy(buf_in, watch->wpath_longname);
    -+  wcscpy(buf_in + watch->wpath_longname_len, L".git");
    ++  swprintf(buf_in, ARRAY_SIZE(buf_in) - 1, L"%s.git",
    ++           watch->wpath_longname);
     +
    -+  if (!GetShortPathNameW(buf_in, buf_out, MAX_PATH))
    ++  if (!GetShortPathNameW(buf_in, buf_out, ARRAY_SIZE(buf_out)))
     +          return;
     +
    -+  last_slash = wcsrchr(buf_out, L'/');
    -+  last_bslash = wcsrchr(buf_out, L'\\');
    -+  if (last_slash > last_bslash)
    -+          last = last_slash + 1;
    -+  else if (last_bslash)
    -+          last = last_bslash + 1;
    -+  else
    -+          last = buf_out;
    ++  /*
    ++   * Get the final filename component of the shortpath.
    ++   * We know that the path does not have a final slash.
    ++   */
    ++  for (last = p = buf_out; *p; p++)
    ++          if (*p == L'/' || *p == '\\')
    ++                  last = p + 1;
     +
     +  if (!wcscmp(last, L".git"))
     +          return;
    @@ compat/fsmonitor/fsm-listen-win32.c: static int normalize_path_in_utf8(FILE_NOTI
     +   * Lets test this.
     +   */
     +  if (wcschr(watch->dotgit_shortname, L'~'))
    -+          watch->has_tilda = 1;
    ++          watch->has_tilde = 1;
     +}
     +
     +enum get_relative_result {
    @@ compat/fsmonitor/fsm-listen-win32.c: static int normalize_path_in_utf8(FILE_NOTI
     +static enum get_relative_result get_relative_longname(
     +  struct one_watch *watch,
     +  const wchar_t *wpath, DWORD wpath_len,
    -+  wchar_t *wpath_longname)
    ++  wchar_t *wpath_longname, size_t bufsize_wpath_longname)
     +{
     +  wchar_t buf_in[2 * MAX_PATH + 1];
     +  wchar_t buf_out[MAX_PATH + 1];
     +  DWORD root_len;
    ++  DWORD out_len;
     +
    -+  /* Build L"<wt-root-path>/<event-rel-path>" */
    ++  /*
    ++   * Build L"<wt-root-path>/<event-rel-path>"
    ++   * Note that the <event-rel-path> might not be null terminated
    ++   * so we avoid swprintf() constructions.
    ++   */
     +  root_len = watch->wpath_longname_len;
    ++  if (root_len + wpath_len >= ARRAY_SIZE(buf_in)) {
    ++          /*
    ++           * This should not happen.  We cannot append the observed
    ++           * relative path onto the end of the worktree root path
    ++           * without overflowing the buffer.  Just give up.
    ++           */
    ++          return GRR_SHUTDOWN;
    ++  }
     +  wcsncpy(buf_in, watch->wpath_longname, root_len);
     +  wcsncpy(buf_in + root_len, wpath, wpath_len);
     +  buf_in[root_len + wpath_len] = 0;
     +
     +  /*
     +   * We don't actually know if the source pathname is a
    -+   * shortname or a longname.  This routine allows either to be
    -+   * given as input.
    ++   * shortname or a longname.  This Windows routine allows
    ++   * either to be given as input.
     +   */
    -+  if (!GetLongPathNameW(buf_in, buf_out, MAX_PATH)) {
    ++  out_len = GetLongPathNameW(buf_in, buf_out, ARRAY_SIZE(buf_out));
    ++  if (!out_len) {
     +          /*
     +           * The shortname to longname conversion can fail for
     +           * various reasons, for example if the file has been
    @@ compat/fsmonitor/fsm-listen-win32.c: static int normalize_path_in_utf8(FILE_NOTI
     +          return GRR_SHUTDOWN;
     +  }
     +
    ++  if (out_len - root_len >= bufsize_wpath_longname) {
    ++          /*
    ++           * This should not happen.  We cannot copy the root-relative
    ++           * portion of the path into the provided buffer without an
    ++           * overrun.  Just give up.
    ++           */
    ++          return GRR_SHUTDOWN;
    ++  }
    ++
     +  /* Return the worktree root-relative portion of the longname. */
     +
     +  wcscpy(wpath_longname, buf_out + root_len);
    @@ compat/fsmonitor/fsm-listen-win32.c: static struct one_watch *create_watch(struc
                return NULL;
        }
      
    -+  if (!GetLongPathNameW(wpath, wpath_longname, MAX_PATH)) {
    ++  len_longname = GetLongPathNameW(wpath, wpath_longname,
    ++                                  ARRAY_SIZE(wpath_longname));
    ++  if (!len_longname) {
     +          error(_("[GLE %ld] could not get longname of '%s'"),
     +                GetLastError(), path);
     +          CloseHandle(hDir);
     +          return NULL;
     +  }
     +
    -+  len_longname = wcslen(wpath_longname);
     +  if (wpath_longname[len_longname - 1] != L'/' &&
     +      wpath_longname[len_longname - 1] != L'\\') {
     +          wpath_longname[len_longname++] = L'/';
    @@ compat/fsmonitor/fsm-listen-win32.c: static int process_worktree_events(struct f
     -          case IS_INSIDE_DOT_GIT:
     -                  /* ignore everything inside of "<worktree>/.git/" */
     -                  break;
    -+                  if (watch->has_tilda && !wcschr(wpath, L'~')) {
    ++                  if (watch->has_tilde && !wcschr(wpath, L'~')) {
     +                          /*
    -+                           * Shortnames on this filesystem have tildas
    ++                           * Shortnames on this filesystem have tildes
     +                           * and the notification path does not have
     +                           * one, so we assume that it is a longname.
     +                           */
    @@ compat/fsmonitor/fsm-listen-win32.c: static int process_worktree_events(struct f
     -                                             "fsm-listen/dotgit",
     -                                             "removed");
     +                  grr = get_relative_longname(watch, wpath, wpath_len,
    -+                                              wpath_longname);
    ++                                              wpath_longname,
    ++                                              ARRAY_SIZE(wpath_longname));
     +                  switch (grr) {
     +                  case GRR_NO_CONVERSION_NEEDED: /* use info buffer as is */
     +                          break;
 2:  5b246bec24 !  2:  1bf2e36b6a t7527: test FSMonitor on repos with Unicode root paths
    @@ t/t7527-builtin-fsmonitor.sh: do
     +u_values="$u1 $u2"
     +for u in $u_values
     +do
    -+  test_expect_success "Unicode in repo root path: $u" '
    ++  test_expect_success "unicode in repo root path: $u" '
     +          test_when_finished "stop_daemon_delete_repo $u" &&
     +
     +          git init "$u" &&
 3:  8a474d6999 =  3:  4bca494bb2 t/helper/fsmonitor-client: create stress test
 4:  72b94acd5f !  4:  663deabc3f fsmonitor-settings: bare repos are incompatible with FSMonitor
    @@ fsmonitor-settings.h
     + */
     +enum fsmonitor_reason {
     +  FSMONITOR_REASON_UNTESTED = 0,
    -+  FSMONITOR_REASON_OK, /* no incompatibility or when disbled */
    ++  FSMONITOR_REASON_OK, /* no incompatibility or when disabled */
     +  FSMONITOR_REASON_BARE,
     +};
     +
 5:  2e225c3f4f =  5:  7cb0180a1e fsmonitor-settings: stub in Win32-specific incompatibility checking
 6:  e0d3bdf755 !  6:  9774faddc4 fsmonitor-settings: VFS for Git virtual repos are incompatible
    @@ fsmonitor-settings.c: char *fsm_settings__get_incompatible_msg(const struct repo
      ## fsmonitor-settings.h ##
     @@ fsmonitor-settings.h: enum fsmonitor_reason {
        FSMONITOR_REASON_UNTESTED = 0,
    -   FSMONITOR_REASON_OK, /* no incompatibility or when disbled */
    +   FSMONITOR_REASON_OK, /* no incompatibility or when disabled */
        FSMONITOR_REASON_BARE,
     +  FSMONITOR_REASON_VFS4GIT, /* VFS for Git virtualization */
      };
 7:  c50ed29a31 =  7:  f7ef7dcffc fsmonitor-settings: stub in macOS-specific incompatibility checking
 8:  1f5b772d42 !  8:  dc2dfd6793 fsmonitor-settings: remote repos on macOS are incompatible
    @@ fsmonitor-settings.c: char *fsm_settings__get_incompatible_msg(const struct repo
      ## fsmonitor-settings.h ##
     @@ fsmonitor-settings.h: enum fsmonitor_reason {
        FSMONITOR_REASON_UNTESTED = 0,
    -   FSMONITOR_REASON_OK, /* no incompatibility or when disbled */
    +   FSMONITOR_REASON_OK, /* no incompatibility or when disabled */
        FSMONITOR_REASON_BARE,
     +  FSMONITOR_REASON_ERROR, /* FS error probing for compatibility */
     +  FSMONITOR_REASON_REMOTE,
 9:  495e54049b =  9:  5627038aaa fsmonitor-settings: remote repos on Windows are incompatible
10:  4b52083698 = 10:  9a12cc78b5 fsmonitor-settings: NTFS and FAT32 on MacOS are incompatible
11:  d4a4263d37 = 11:  aaff000cec unpack-trees: initialize fsmonitor_has_run_once in o->result
12:  f4feb00ec2 = 12:  4f2b15d3d1 fsm-listen-darwin: ignore FSEvents caused by xattr changes on macOS
13:  dbb983fd9d = 13:  427dec412a fsmonitor--daemon: cd out of worktree root
14:  ae90b99ea9 = 14:  51b266b06e fsmonitor--daemon: prepare for adding health thread
15:  b6c5800095 = 15:  594e0ae243 fsmonitor--daemon: rename listener thread related variables
16:  32fc6ba743 = 16:  c2b5c02ed3 fsmonitor--daemon: stub in health thread
17:  77bc037481 = 17:  46a5ae2a63 fsm-health-win32: add polling framework to monitor daemon health
18:  b06edd995e = 18:  7cf1be5f8e fsm-health-win32: force shutdown daemon if worktree root moves
19:  1bd5f34624 = 19:  95cf1299d4 fsm-listen-darwin: shutdown daemon if worktree root is moved/renamed
20:  48af0813de = 20:  b020bfb456 fsmonitor: optimize processing of directory events
21:  a9b35e770f = 21:  d058d7e0c0 t7527: FSMonitor tests for directory moves
22:  26308936af = 22:  f5dac28681 t/perf/p7527: add perf test for builtin FSMonitor
23:  d0e25f6bac ! 23:  92f5c0d2c8 fsmonitor: never set CE_FSMONITOR_VALID on submodules
    @@ t/t7527-builtin-fsmonitor.sh: do
     +  git -C super/dir_1/dir_2/sub clean -d -f
     +}
     +
    -+test_expect_success "Submodule always visited" '
    ++test_expect_success 'submodule always visited' '
     +  test_when_finished "git -C super fsmonitor--daemon stop; \
     +                      rm -rf super; \
     +                      rm -rf sub" &&
24:  410dd2d292 ! 24:  40b80adbb3 t7527: test FSMonitor on case insensitive+preserving file system
    @@ Commit message
         Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
     
      ## t/t7527-builtin-fsmonitor.sh ##
    -@@ t/t7527-builtin-fsmonitor.sh: test_expect_success "Submodule always visited" '
    +@@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'submodule always visited' '
        my_match_and_clean
      '
      
25:  cd7c55b0d3 = 25:  b93f064269 fsmonitor: on macOS also emit NFC spelling for NFD pathname
 -:  ---------- > 26:  6f2e935f14 t/helper/hexdump: add helper to print hexdump of stdin
26:  8278f32c4d ! 27:  6a83086995 t/lib-unicode-nfc-nfd: helper prereqs for testing unicode nfc/nfd
    @@ t/lib-unicode-nfc-nfd.sh (new)
     +# and on APFS, NFC paths are preserved.  As we have established
     +# above, this is independent of "composition sensitivity".
     +#
    -+# 0000000 63 5f c3 a9
    -+#
    -+# (/usr/bin/od output contains different amount of whitespace
    -+# on different platforms, so we need the wildcards here.)
    -+#
     +test_lazy_prereq UNICODE_NFC_PRESERVED '
     +  mkdir c_${utf8_nfc} &&
    -+  ls | od -t x1 | grep "63 *5f *c3 *a9"
    ++  ls | test-tool hexdump | grep "63 5f c3 a9"
     +'
     +
     +# Is the spelling of an NFD pathname preserved on disk?
     +#
    -+# 0000000 64 5f 65 cc 81
    -+#
     +test_lazy_prereq UNICODE_NFD_PRESERVED '
     +  mkdir d_${utf8_nfd} &&
    -+  ls | od -t x1 | grep "64 *5f *65 *cc *81"
    ++  ls | test-tool hexdump | grep "64 5f 65 cc 81"
     +'
    -+  mkdir c_${utf8_nfc} &&
    -+  mkdir d_${utf8_nfd} &&
     +
     +# The following _DOUBLE_ forms are more for my curiosity,
     +# but there may be quirks lurking when there are multiple
    @@ t/lib-unicode-nfc-nfd.sh (new)
     +#
     +test_lazy_prereq UNICODE_DOUBLE_NFC_PRESERVED '
     +  mkdir c_${greek_nfc} &&
    -+  ls | od -t x1 | grep "63 *5f *e1 *bd *a7"
    ++  ls | test-tool hexdump | grep "63 5f e1 bd a7"
     +'
     +
     +# See if the NFD spelling appears on the disk.
     +#
     +test_lazy_prereq UNICODE_DOUBLE_NFD_PRESERVED '
     +  mkdir d_${greek_nfd2} &&
    -+  ls | od -t x1 | grep "64 *5f *cf *89 *cc *94 *cd *82"
    ++  ls | test-tool hexdump | grep "64 5f cf 89 cc 94 cd 82"
     +'
     +
     +# The following is for debugging. I found it useful when
27:  4efb3a4383 = 28:  f9a7869d20 t7527: test Unicode NFC/NFD handling on MacOS
28:  df1b4f3a80 ! 29:  9fc7c97092 fsmonitor--daemon: allow --super-prefix argument
    @@ git.c: static struct cmd_struct commands[] = {
        { "grep", cmd_grep, RUN_SETUP_GENTLY },
     
      ## t/t7527-builtin-fsmonitor.sh ##
    -@@ t/t7527-builtin-fsmonitor.sh: test_expect_success "Submodule always visited" '
    +@@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'submodule always visited' '
        my_match_and_clean
      '
      
    @@ t/t7527-builtin-fsmonitor.sh: test_expect_success "Submodule always visited" '
     +  tr '\047' Q <$1 | grep -e "$msg"
     +}
     +
    -+test_expect_success "Stray Submodule super-prefix warning" '
    ++test_expect_success "stray submodule super-prefix warning" '
     +  test_when_finished "rm -rf super; \
     +                      rm -rf sub;   \
     +                      rm super-sub.trace" &&
 -:  ---------- > 30:  ca833ecc7a t7527: improve implicit shutdown testing in fsmonitor--daemon


Jeff Hostetler (30):
  fsm-listen-win32: handle shortnames
  t7527: test FSMonitor on repos with Unicode root paths
  t/helper/fsmonitor-client: create stress test
  fsmonitor-settings: bare repos are incompatible with FSMonitor
  fsmonitor-settings: stub in Win32-specific incompatibility checking
  fsmonitor-settings: VFS for Git virtual repos are incompatible
  fsmonitor-settings: stub in macOS-specific incompatibility checking
  fsmonitor-settings: remote repos on macOS are incompatible
  fsmonitor-settings: remote repos on Windows are incompatible
  fsmonitor-settings: NTFS and FAT32 on MacOS are incompatible
  unpack-trees: initialize fsmonitor_has_run_once in o->result
  fsm-listen-darwin: ignore FSEvents caused by xattr changes on macOS
  fsmonitor--daemon: cd out of worktree root
  fsmonitor--daemon: prepare for adding health thread
  fsmonitor--daemon: rename listener thread related variables
  fsmonitor--daemon: stub in health thread
  fsm-health-win32: add polling framework to monitor daemon health
  fsm-health-win32: force shutdown daemon if worktree root moves
  fsm-listen-darwin: shutdown daemon if worktree root is moved/renamed
  fsmonitor: optimize processing of directory events
  t7527: FSMonitor tests for directory moves
  t/perf/p7527: add perf test for builtin FSMonitor
  fsmonitor: never set CE_FSMONITOR_VALID on submodules
  t7527: test FSMonitor on case insensitive+preserving file system
  fsmonitor: on macOS also emit NFC spelling for NFD pathname
  t/helper/hexdump: add helper to print hexdump of stdin
  t/lib-unicode-nfc-nfd: helper prereqs for testing unicode nfc/nfd
  t7527: test Unicode NFC/NFD handling on MacOS
  fsmonitor--daemon: allow --super-prefix argument
  t7527: improve implicit shutdown testing in fsmonitor--daemon

 Makefile                               |  20 +-
 builtin/fsmonitor--daemon.c            | 116 ++++++-
 builtin/update-index.c                 |  16 +
 compat/fsmonitor/fsm-health-darwin.c   |  24 ++
 compat/fsmonitor/fsm-health-win32.c    | 278 ++++++++++++++++
 compat/fsmonitor/fsm-health.h          |  47 +++
 compat/fsmonitor/fsm-listen-darwin.c   | 122 ++++++-
 compat/fsmonitor/fsm-listen-win32.c    | 436 ++++++++++++++++++++-----
 compat/fsmonitor/fsm-listen.h          |   2 +-
 compat/fsmonitor/fsm-settings-darwin.c |  89 +++++
 compat/fsmonitor/fsm-settings-win32.c  | 137 ++++++++
 config.mak.uname                       |   5 +
 contrib/buildsystems/CMakeLists.txt    |   8 +
 fsmonitor--daemon.h                    |  11 +-
 fsmonitor-settings.c                   | 167 ++++++++--
 fsmonitor-settings.h                   |  33 ++
 fsmonitor.c                            |  73 ++++-
 fsmonitor.h                            |  11 +
 git.c                                  |   2 +-
 t/helper/test-fsmonitor-client.c       | 106 ++++++
 t/helper/test-hexdump.c                |  24 ++
 t/helper/test-tool.c                   |   1 +
 t/helper/test-tool.h                   |   1 +
 t/lib-unicode-nfc-nfd.sh               | 158 +++++++++
 t/perf/p7527-builtin-fsmonitor.sh      | 257 +++++++++++++++
 t/t7519-status-fsmonitor.sh            |  32 ++
 t/t7527-builtin-fsmonitor.sh           | 401 ++++++++++++++++++++++-
 unpack-trees.c                         |   1 +
 28 files changed, 2429 insertions(+), 149 deletions(-)
 create mode 100644 compat/fsmonitor/fsm-health-darwin.c
 create mode 100644 compat/fsmonitor/fsm-health-win32.c
 create mode 100644 compat/fsmonitor/fsm-health.h
 create mode 100644 compat/fsmonitor/fsm-settings-darwin.c
 create mode 100644 compat/fsmonitor/fsm-settings-win32.c
 create mode 100644 t/helper/test-hexdump.c
 create mode 100755 t/lib-unicode-nfc-nfd.sh
 create mode 100755 t/perf/p7527-builtin-fsmonitor.sh


base-commit: 5eb696daba2fe108d4d9ba2ccf4b357447ef9946
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1143%2Fjeffhostetler%2Fbuiltin-fsmonitor-part3-v7
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1143/jeffhostetler/builtin-fsmonitor-part3-v7
Pull-Request: https://github.com/gitgitgadget/git/pull/1143

Range-diff vs v6:

  1:  8b7c5f4e234 !  1:  26144c58659 fsm-listen-win32: handle shortnames
     @@ compat/fsmonitor/fsm-listen-win32.c: struct one_watch
      +	 * clients.)
      +	 */
      +	BOOL has_shortnames;
     -+	BOOL has_tilda;
     ++	BOOL has_tilde;
      +	wchar_t dotgit_shortname[16]; /* for 8.3 name */
       };
       
     @@ compat/fsmonitor/fsm-listen-win32.c: normalize:
      +{
      +	wchar_t buf_in[MAX_PATH + 1];
      +	wchar_t buf_out[MAX_PATH + 1];
     -+	wchar_t *last_slash = NULL;
     -+	wchar_t *last_bslash = NULL;
      +	wchar_t *last;
     ++	wchar_t *p;
      +
      +	/* build L"<wt-root-path>/.git" */
     -+	wcscpy(buf_in, watch->wpath_longname);
     -+	wcscpy(buf_in + watch->wpath_longname_len, L".git");
     ++	swprintf(buf_in, ARRAY_SIZE(buf_in) - 1, L"%s.git",
     ++		 watch->wpath_longname);
      +
     -+	if (!GetShortPathNameW(buf_in, buf_out, MAX_PATH))
     ++	if (!GetShortPathNameW(buf_in, buf_out, ARRAY_SIZE(buf_out)))
      +		return;
      +
     -+	last_slash = wcsrchr(buf_out, L'/');
     -+	last_bslash = wcsrchr(buf_out, L'\\');
     -+	if (last_slash > last_bslash)
     -+		last = last_slash + 1;
     -+	else if (last_bslash)
     -+		last = last_bslash + 1;
     -+	else
     -+		last = buf_out;
     ++	/*
     ++	 * Get the final filename component of the shortpath.
     ++	 * We know that the path does not have a final slash.
     ++	 */
     ++	for (last = p = buf_out; *p; p++)
     ++		if (*p == L'/' || *p == '\\')
     ++			last = p + 1;
      +
      +	if (!wcscmp(last, L".git"))
      +		return;
     @@ compat/fsmonitor/fsm-listen-win32.c: normalize:
      +	 * Lets test this.
      +	 */
      +	if (wcschr(watch->dotgit_shortname, L'~'))
     -+		watch->has_tilda = 1;
     ++		watch->has_tilde = 1;
      +}
      +
      +enum get_relative_result {
     @@ compat/fsmonitor/fsm-listen-win32.c: normalize:
      +static enum get_relative_result get_relative_longname(
      +	struct one_watch *watch,
      +	const wchar_t *wpath, DWORD wpath_len,
     -+	wchar_t *wpath_longname)
     ++	wchar_t *wpath_longname, size_t bufsize_wpath_longname)
      +{
      +	wchar_t buf_in[2 * MAX_PATH + 1];
      +	wchar_t buf_out[MAX_PATH + 1];
      +	DWORD root_len;
     ++	DWORD out_len;
      +
     -+	/* Build L"<wt-root-path>/<event-rel-path>" */
     ++	/*
     ++	 * Build L"<wt-root-path>/<event-rel-path>"
     ++	 * Note that the <event-rel-path> might not be null terminated
     ++	 * so we avoid swprintf() constructions.
     ++	 */
      +	root_len = watch->wpath_longname_len;
     ++	if (root_len + wpath_len >= ARRAY_SIZE(buf_in)) {
     ++		/*
     ++		 * This should not happen.  We cannot append the observed
     ++		 * relative path onto the end of the worktree root path
     ++		 * without overflowing the buffer.  Just give up.
     ++		 */
     ++		return GRR_SHUTDOWN;
     ++	}
      +	wcsncpy(buf_in, watch->wpath_longname, root_len);
      +	wcsncpy(buf_in + root_len, wpath, wpath_len);
      +	buf_in[root_len + wpath_len] = 0;
      +
      +	/*
      +	 * We don't actually know if the source pathname is a
     -+	 * shortname or a longname.  This routine allows either to be
     -+	 * given as input.
     ++	 * shortname or a longname.  This Windows routine allows
     ++	 * either to be given as input.
      +	 */
     -+	if (!GetLongPathNameW(buf_in, buf_out, MAX_PATH)) {
     ++	out_len = GetLongPathNameW(buf_in, buf_out, ARRAY_SIZE(buf_out));
     ++	if (!out_len) {
      +		/*
      +		 * The shortname to longname conversion can fail for
      +		 * various reasons, for example if the file has been
     @@ compat/fsmonitor/fsm-listen-win32.c: normalize:
      +		return GRR_SHUTDOWN;
      +	}
      +
     ++	if (out_len - root_len >= bufsize_wpath_longname) {
     ++		/*
     ++		 * This should not happen.  We cannot copy the root-relative
     ++		 * portion of the path into the provided buffer without an
     ++		 * overrun.  Just give up.
     ++		 */
     ++		return GRR_SHUTDOWN;
     ++	}
     ++
      +	/* Return the worktree root-relative portion of the longname. */
      +
      +	wcscpy(wpath_longname, buf_out + root_len);
     @@ compat/fsmonitor/fsm-listen-win32.c: static struct one_watch *create_watch(struc
       		return NULL;
       	}
       
     -+	if (!GetLongPathNameW(wpath, wpath_longname, MAX_PATH)) {
     ++	len_longname = GetLongPathNameW(wpath, wpath_longname,
     ++					ARRAY_SIZE(wpath_longname));
     ++	if (!len_longname) {
      +		error(_("[GLE %ld] could not get longname of '%s'"),
      +		      GetLastError(), path);
      +		CloseHandle(hDir);
      +		return NULL;
      +	}
      +
     -+	len_longname = wcslen(wpath_longname);
      +	if (wpath_longname[len_longname - 1] != L'/' &&
      +	    wpath_longname[len_longname - 1] != L'\\') {
      +		wpath_longname[len_longname++] = L'/';
     @@ compat/fsmonitor/fsm-listen-win32.c: static int process_worktree_events(struct f
      -		case IS_INSIDE_DOT_GIT:
      -			/* ignore everything inside of "<worktree>/.git/" */
      -			break;
     -+			if (watch->has_tilda && !wcschr(wpath, L'~')) {
     ++			if (watch->has_tilde && !wcschr(wpath, L'~')) {
      +				/*
     -+				 * Shortnames on this filesystem have tildas
     ++				 * Shortnames on this filesystem have tildes
      +				 * and the notification path does not have
      +				 * one, so we assume that it is a longname.
      +				 */
     @@ compat/fsmonitor/fsm-listen-win32.c: static int process_worktree_events(struct f
      -						   "fsm-listen/dotgit",
      -						   "removed");
      +			grr = get_relative_longname(watch, wpath, wpath_len,
     -+						    wpath_longname);
     ++						    wpath_longname,
     ++						    ARRAY_SIZE(wpath_longname));
      +			switch (grr) {
      +			case GRR_NO_CONVERSION_NEEDED: /* use info buffer as is */
      +				break;
  2:  5b246bec247 !  2:  1bf2e36b6ad t7527: test FSMonitor on repos with Unicode root paths
     @@ t/t7527-builtin-fsmonitor.sh: do
      +u_values="$u1 $u2"
      +for u in $u_values
      +do
     -+	test_expect_success "Unicode in repo root path: $u" '
     ++	test_expect_success "unicode in repo root path: $u" '
      +		test_when_finished "stop_daemon_delete_repo $u" &&
      +
      +		git init "$u" &&
  3:  8a474d69999 =  3:  4bca494bb22 t/helper/fsmonitor-client: create stress test
  4:  72b94acd5fe !  4:  663deabc3f6 fsmonitor-settings: bare repos are incompatible with FSMonitor
     @@ fsmonitor-settings.h
      + */
      +enum fsmonitor_reason {
      +	FSMONITOR_REASON_UNTESTED = 0,
     -+	FSMONITOR_REASON_OK, /* no incompatibility or when disbled */
     ++	FSMONITOR_REASON_OK, /* no incompatibility or when disabled */
      +	FSMONITOR_REASON_BARE,
      +};
      +
  5:  2e225c3f4f2 =  5:  7cb0180a1ed fsmonitor-settings: stub in Win32-specific incompatibility checking
  6:  e0d3bdf7556 !  6:  9774faddc45 fsmonitor-settings: VFS for Git virtual repos are incompatible
     @@ fsmonitor-settings.c: char *fsm_settings__get_incompatible_msg(const struct repo
       ## fsmonitor-settings.h ##
      @@ fsmonitor-settings.h: enum fsmonitor_reason {
       	FSMONITOR_REASON_UNTESTED = 0,
     - 	FSMONITOR_REASON_OK, /* no incompatibility or when disbled */
     + 	FSMONITOR_REASON_OK, /* no incompatibility or when disabled */
       	FSMONITOR_REASON_BARE,
      +	FSMONITOR_REASON_VFS4GIT, /* VFS for Git virtualization */
       };
  7:  c50ed29a310 =  7:  f7ef7dcffc8 fsmonitor-settings: stub in macOS-specific incompatibility checking
  8:  1f5b772d42a !  8:  dc2dfd67931 fsmonitor-settings: remote repos on macOS are incompatible
     @@ fsmonitor-settings.c: char *fsm_settings__get_incompatible_msg(const struct repo
       ## fsmonitor-settings.h ##
      @@ fsmonitor-settings.h: enum fsmonitor_reason {
       	FSMONITOR_REASON_UNTESTED = 0,
     - 	FSMONITOR_REASON_OK, /* no incompatibility or when disbled */
     + 	FSMONITOR_REASON_OK, /* no incompatibility or when disabled */
       	FSMONITOR_REASON_BARE,
      +	FSMONITOR_REASON_ERROR, /* FS error probing for compatibility */
      +	FSMONITOR_REASON_REMOTE,
  9:  495e54049b4 =  9:  5627038aaa3 fsmonitor-settings: remote repos on Windows are incompatible
 10:  4b52083698c = 10:  9a12cc78b5d fsmonitor-settings: NTFS and FAT32 on MacOS are incompatible
 11:  d4a4263d379 = 11:  aaff000cecb unpack-trees: initialize fsmonitor_has_run_once in o->result
 12:  f4feb00ec2b = 12:  4f2b15d3d1f fsm-listen-darwin: ignore FSEvents caused by xattr changes on macOS
 13:  dbb983fd9d0 = 13:  427dec412a5 fsmonitor--daemon: cd out of worktree root
 14:  ae90b99ea9b = 14:  51b266b06e1 fsmonitor--daemon: prepare for adding health thread
 15:  b6c5800095f = 15:  594e0ae243d fsmonitor--daemon: rename listener thread related variables
 16:  32fc6ba7437 = 16:  c2b5c02ed38 fsmonitor--daemon: stub in health thread
 17:  77bc037481a = 17:  46a5ae2a635 fsm-health-win32: add polling framework to monitor daemon health
 18:  b06edd995ea = 18:  7cf1be5f8e2 fsm-health-win32: force shutdown daemon if worktree root moves
 19:  1bd5f346248 = 19:  95cf1299d44 fsm-listen-darwin: shutdown daemon if worktree root is moved/renamed
 20:  48af0813dec = 20:  b020bfb4568 fsmonitor: optimize processing of directory events
 21:  a9b35e770f3 = 21:  d058d7e0c08 t7527: FSMonitor tests for directory moves
 22:  26308936af9 = 22:  f5dac286812 t/perf/p7527: add perf test for builtin FSMonitor
 23:  d0e25f6bac6 ! 23:  92f5c0d2c8b fsmonitor: never set CE_FSMONITOR_VALID on submodules
     @@ t/t7527-builtin-fsmonitor.sh: do
      +	git -C super/dir_1/dir_2/sub clean -d -f
      +}
      +
     -+test_expect_success "Submodule always visited" '
     ++test_expect_success 'submodule always visited' '
      +	test_when_finished "git -C super fsmonitor--daemon stop; \
      +			    rm -rf super; \
      +			    rm -rf sub" &&
 24:  410dd2d2920 ! 24:  40b80adbb31 t7527: test FSMonitor on case insensitive+preserving file system
     @@ Commit message
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
      
       ## t/t7527-builtin-fsmonitor.sh ##
     -@@ t/t7527-builtin-fsmonitor.sh: test_expect_success "Submodule always visited" '
     +@@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'submodule always visited' '
       	my_match_and_clean
       '
       
 25:  cd7c55b0d38 = 25:  b93f0642699 fsmonitor: on macOS also emit NFC spelling for NFD pathname
  -:  ----------- > 26:  6f2e935f148 t/helper/hexdump: add helper to print hexdump of stdin
 26:  8278f32c4d8 ! 27:  6a830869954 t/lib-unicode-nfc-nfd: helper prereqs for testing unicode nfc/nfd
     @@ t/lib-unicode-nfc-nfd.sh (new)
      +# and on APFS, NFC paths are preserved.  As we have established
      +# above, this is independent of "composition sensitivity".
      +#
     -+# 0000000 63 5f c3 a9
     -+#
     -+# (/usr/bin/od output contains different amount of whitespace
     -+# on different platforms, so we need the wildcards here.)
     -+#
      +test_lazy_prereq UNICODE_NFC_PRESERVED '
      +	mkdir c_${utf8_nfc} &&
     -+	ls | od -t x1 | grep "63 *5f *c3 *a9"
     ++	ls | test-tool hexdump | grep "63 5f c3 a9"
      +'
      +
      +# Is the spelling of an NFD pathname preserved on disk?
      +#
     -+# 0000000 64 5f 65 cc 81
     -+#
      +test_lazy_prereq UNICODE_NFD_PRESERVED '
      +	mkdir d_${utf8_nfd} &&
     -+	ls | od -t x1 | grep "64 *5f *65 *cc *81"
     ++	ls | test-tool hexdump | grep "64 5f 65 cc 81"
      +'
     -+	mkdir c_${utf8_nfc} &&
     -+	mkdir d_${utf8_nfd} &&
      +
      +# The following _DOUBLE_ forms are more for my curiosity,
      +# but there may be quirks lurking when there are multiple
     @@ t/lib-unicode-nfc-nfd.sh (new)
      +#
      +test_lazy_prereq UNICODE_DOUBLE_NFC_PRESERVED '
      +	mkdir c_${greek_nfc} &&
     -+	ls | od -t x1 | grep "63 *5f *e1 *bd *a7"
     ++	ls | test-tool hexdump | grep "63 5f e1 bd a7"
      +'
      +
      +# See if the NFD spelling appears on the disk.
      +#
      +test_lazy_prereq UNICODE_DOUBLE_NFD_PRESERVED '
      +	mkdir d_${greek_nfd2} &&
     -+	ls | od -t x1 | grep "64 *5f *cf *89 *cc *94 *cd *82"
     ++	ls | test-tool hexdump | grep "64 5f cf 89 cc 94 cd 82"
      +'
      +
      +# The following is for debugging. I found it useful when
 27:  4efb3a43838 = 28:  f9a7869d202 t7527: test Unicode NFC/NFD handling on MacOS
 28:  df1b4f3a80f ! 29:  9fc7c970929 fsmonitor--daemon: allow --super-prefix argument
     @@ git.c: static struct cmd_struct commands[] = {
       	{ "grep", cmd_grep, RUN_SETUP_GENTLY },
      
       ## t/t7527-builtin-fsmonitor.sh ##
     -@@ t/t7527-builtin-fsmonitor.sh: test_expect_success "Submodule always visited" '
     +@@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'submodule always visited' '
       	my_match_and_clean
       '
       
     @@ t/t7527-builtin-fsmonitor.sh: test_expect_success "Submodule always visited" '
      +	tr '\047' Q <$1 | grep -e "$msg"
      +}
      +
     -+test_expect_success "Stray Submodule super-prefix warning" '
     ++test_expect_success "stray submodule super-prefix warning" '
      +	test_when_finished "rm -rf super; \
      +			    rm -rf sub;   \
      +			    rm super-sub.trace" &&
  -:  ----------- > 30:  ca833ecc7a1 t7527: improve implicit shutdown testing in fsmonitor--daemon

-- 
gitgitgadget
