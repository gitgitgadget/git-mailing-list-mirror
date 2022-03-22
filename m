Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E58C433FE
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 18:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240270AbiCVSYk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 14:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235042AbiCVSYh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 14:24:37 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AD7FD3D
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:23:06 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id r7so11862030wmq.2
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=d+au2m0RbVvfI6qdDoXEcMyPTSxlpgZVKQYtNiB26sE=;
        b=Zs9mxGl4KHyPZhBPIUNvHYQrVTpLifGDcJRMqGR0i3QJw5m6d3cXhwPEd2FDq9jL22
         Cjx1R9E6DiuCFJ1fmgnfO0X6JbvJ04RZ7jZMq8Z5QbymQCsDvZb6NGTm1DI7oAVuSbkF
         KWXzQCHsqL2x/2cuw6EufaxH5YnDonwsxfXE2XF7ItZgh33m2ZDLCsPtAsfttpInewJ8
         hyR2MnbxEltEg/5Iiu219e/OByASFYhIWsDAMJy4giuFuqaU/N15gmdYjUf3VF8b4Cis
         fvmckeVnQywdzFp5LBx5voLXi7tIYJpqB7SSwz5Vyj1T2SwbUstLDWm6pg1hxUEygUuB
         +tww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=d+au2m0RbVvfI6qdDoXEcMyPTSxlpgZVKQYtNiB26sE=;
        b=Rltmly2sh9e7obmdy/+xYfug/p0uN2VuO/ZoH/62jtpgfxV791uy90MqtM0opd/Juq
         XKcPTCiouOCiGQRHb26Jb0KPENrCZ27Qhcf6IfXtQ8kZRtg236llWfquVOFjQ8iF84oY
         lneRMsweWqIhwDuFvW4Rh81LiKC0E5ewHdSzqn+KnspuQIQtnxFHt2tVS8HcZ0h3gNvo
         chK6QvVzFhClUugJAwpZ6LEbie67sCXGMgxE1DiJEHszxOI3qb+s7swb4LZowvZKNSS7
         X9dem688ntx2PcE6WTZZOafXohX7GRDH1nHmguHPSK9UVUj5MQ8nPKgkST3p8Fxb3Zpy
         foLA==
X-Gm-Message-State: AOAM533c7yMJuRW/WsyiAZo+A75f2knq5zvkfoji1LlYfMFVB48gUyz5
        9LopitAZeUh67xb8ugNq7QQfJhqjxr0=
X-Google-Smtp-Source: ABdhPJw4C3qab6sRlkXBDNV6Bl/4p1k+IoDuGRvjesKd6lgWwGMsa6OfWJ8qhqUJrTCgW5l5kPhh0Q==
X-Received: by 2002:a05:600c:3b15:b0:38c:6cae:ff2 with SMTP id m21-20020a05600c3b1500b0038c6cae0ff2mr5156398wms.175.1647973383648;
        Tue, 22 Mar 2022 11:23:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bg42-20020a05600c3caa00b00380deeaae72sm2580650wmb.1.2022.03.22.11.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 11:23:02 -0700 (PDT)
Message-Id: <pull.1143.v3.git.1647973380.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
References: <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Mar 2022 18:22:33 +0000
Subject: [PATCH v3 00/27] Builtin FSMonitor Part 3
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
        rsbecker@nexbridge.com, Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is V3 of Part 3 of my builtin FSMonitor series.

I have addressed all of the feedback from Part 3 V2 and the mess that was
Part 2.5 (now obsolete). This version builds upon the new V7 of Part 2
(which includes 2.5).

This version includes: (1) fixup a few more "_()" calls in die() and error()
messages. (2) refactor how fsmonitor incompatibility error messages are
formatted (3) make use of new "start_daemon()" function t7527 to reduce
duplicated code. (4) improve documentation around Unicode/UTF8 testing on
MacOS.

Here is the range-diff from V2 to V3:

 1:  34619e0652 !  1:  779a15b38e fsm-listen-win32: handle shortnames
    @@ compat/fsmonitor/fsm-listen-win32.c: static int normalize_path_in_utf8(FILE_NOTI
     @@ compat/fsmonitor/fsm-listen-win32.c: static int normalize_path_in_utf8(FILE_NOTIFY_INFORMATION *info,
                  goto normalize;
              if (GetLastError() != ERROR_INSUFFICIENT_BUFFER) {
    -             error("[GLE %ld] could not convert path to UTF-8: '%.*ls'",
    +             error(_("[GLE %ld] could not convert path to UTF-8: '%.*ls'"),
     -                  GetLastError(),
     -                  (int)(info->FileNameLength / sizeof(WCHAR)),
     -                  info->FileName);
    @@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'implicit daemon stop (rename
     +
     +    git init test_implicit_1s &&
     +
    -+    start_daemon test_implicit_1s &&
    ++    start_daemon -C test_implicit_1s &&
     +
     +    # renaming the .git directory will implicitly stop the daemon.
     +    # this moves {.git, GIT~1} to {.gitxyz, GITXYZ~1}.
    @@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'implicit daemon stop (rename
     +    test_path_is_file test_implicit_1s2/GIT~1 &&
     +    test_path_is_dir  test_implicit_1s2/GIT~2 &&
     +
    -+    start_daemon test_implicit_1s2 &&
    ++    start_daemon -C test_implicit_1s2 &&
     +
     +    # renaming the .git directory will implicitly stop the daemon.
     +    # the rename-from FS Event will contain the shortname.
 2:  3a0f30b849 !  2:  11d4a17b69 t7527: test FSMonitor on repos with Unicode root paths
    @@ t/t7527-builtin-fsmonitor.sh: do
     +        git -C "$u" add file1 &&
     +        git -C "$u" config core.fsmonitor true &&
     +
    -+        start_daemon "$u" &&
    ++        start_daemon -C "$u" &&
     +        git -C "$u" status >actual &&
     +        grep "new file:   file1" actual
     +    '
 3:  87d1c0b6f2 !  3:  901fa32f6e t/helper/fsmonitor-client: create stress test
    @@ t/helper/test-fsmonitor-client.c: static int do_send_flush(void)
     +    int nr_requests = 1;
      
          const char * const fsmonitor_client_usage[] = {
    -         N_("test-helper fsmonitor-client query [<token>]"),
    -         N_("test-helper fsmonitor-client flush"),
    -+        N_("test-helper fsmonitor-client hammer [<token>] [<threads>] [<requests>]"),
    +         "test-tool fsmonitor-client query [<token>]",
    +         "test-tool fsmonitor-client flush",
    ++        "test-tool fsmonitor-client hammer [<token>] [<threads>] [<requests>]",
              NULL,
          };
      
          struct option options[] = {
    -         OPT_STRING(0, "token", &token, N_("token"),
    -                N_("command token to send to the server")),
    +         OPT_STRING(0, "token", &token, "token",
    +                "command token to send to the server"),
     +
    -+        OPT_INTEGER(0, "threads", &nr_threads, N_("number of client threads")),
    -+        OPT_INTEGER(0, "requests", &nr_requests, N_("number of requests per thread")),
    ++        OPT_INTEGER(0, "threads", &nr_threads, "number of client threads"),
    ++        OPT_INTEGER(0, "requests", &nr_requests, "number of requests per thread"),
     +
              OPT_END()
          };
 4:  8c4f90ae4f !  4:  a8f0b2a525 fsmonitor-settings: bare repos are incompatible with FSMonitor
    @@ builtin/fsmonitor--daemon.c: int cmd_fsmonitor__daemon(int argc, const char **ar
     +    prepare_repo_settings(the_repository);
     +    fsm_settings__set_ipc(the_repository);
     +
    -+    if (fsm_settings__get_mode(the_repository) == FSMONITOR_MODE_INCOMPATIBLE) {
    -+        const char *msg = fsm_settings__get_reason_msg(the_repository);
    -+
    -+        return error("%s '%s'", msg ? msg : "???", xgetcwd());
    -+    }
    ++    if (fsm_settings__error_if_incompatible(the_repository))
    ++        return 1;
     +
          if (!strcmp(subcmd, "start"))
              return !!try_to_start_background_daemon();
    @@ builtin/update-index.c: int cmd_update_index(int argc, const char **argv, const
          if (fsmonitor > 0) {
              enum fsmonitor_mode fsm_mode = fsm_settings__get_mode(r);
     +
    -+        if (fsm_mode == FSMONITOR_MODE_INCOMPATIBLE) {
    -+            const char *msg = fsm_settings__get_reason_msg(r);
    -+
    -+            return error("%s '%s'", msg ? msg : "???", xgetcwd());
    -+        }
    ++        if (fsm_settings__error_if_incompatible(the_repository))
    ++            return 1;
     +
              if (fsm_mode == FSMONITOR_MODE_DISABLED) {
    -             advise(_("core.fsmonitor is unset; "
    -                  "set it if you really want to "
    +             warning(_("core.fsmonitor is unset; "
    +                 "set it if you really want to "
     
      ## fsmonitor-settings.c ##
     @@
    @@ fsmonitor-settings.c
      static void lookup_fsmonitor_settings(struct repository *r)
      {
          struct fsmonitor_settings *s;
    +@@ fsmonitor-settings.c: static void lookup_fsmonitor_settings(struct repository *r)
    + 
    +     CALLOC_ARRAY(s, 1);
    +     s->mode = FSMONITOR_MODE_DISABLED;
    ++    s->reason = FSMONITOR_REASON_OK;
    + 
    +     r->settings.fsmonitor = s;
    + 
     @@ fsmonitor-settings.c: void fsm_settings__set_ipc(struct repository *r)
      
          lookup_fsmonitor_settings(r);
    @@ fsmonitor-settings.c: void fsm_settings__set_disabled(struct repository *r)
     +    return r->settings.fsmonitor->reason;
     +}
     +
    -+const char *fsm_settings__get_reason_msg(struct repository *r)
    ++int fsm_settings__error_if_incompatible(struct repository *r)
     +{
     +    enum fsmonitor_reason reason = fsm_settings__get_reason(r);
     +
     +    switch (reason) {
     +    case FSMONITOR_REASON_OK:
    -+        return NULL;
    ++        return 0;
     +
     +    case FSMONITOR_REASON_BARE:
    -+        return _("bare repos are incompatible with fsmonitor");
    ++        error(_("bare repository '%s' is incompatible with fsmonitor"),
    ++              xgetcwd());
    ++        return 1;
     +    }
     +
    -+    BUG("Unhandled case in fsm_settings__get_reason_msg '%d'",
    ++    BUG("Unhandled case in fsm_settings__error_if_incompatible: '%d'",
     +        reason);
     +}
     
    @@ fsmonitor-settings.h: void fsm_settings__set_disabled(struct repository *r);
      const char *fsm_settings__get_hook_path(struct repository *r);
      
     +enum fsmonitor_reason fsm_settings__get_reason(struct repository *r);
    -+const char *fsm_settings__get_reason_msg(struct repository *r);
    ++int fsm_settings__error_if_incompatible(struct repository *r);
     +
      struct fsmonitor_settings;
      
    @@ t/t7519-status-fsmonitor.sh: test_lazy_prereq UNTRACKED_CACHE '
     +    test_must_fail \
     +        git -C ./bare-clone -c core.fsmonitor=foo \
     +            update-index --fsmonitor 2>actual &&
    -+    grep "bare repos are incompatible with fsmonitor" actual &&
    ++    grep "bare repository .* is incompatible with fsmonitor" actual &&
     +
     +    test_must_fail \
     +        git -C ./bare-clone -c core.fsmonitor=true \
     +            update-index --fsmonitor 2>actual &&
    -+    grep "bare repos are incompatible with fsmonitor" actual
    ++    grep "bare repository .* is incompatible with fsmonitor" actual
     +'
     +
     +test_expect_success FSMONITOR_DAEMON 'run fsmonitor-daemon in bare repo' '
     +    test_when_finished "rm -rf ./bare-clone actual" &&
     +    git init --bare bare-clone &&
     +    test_must_fail git -C ./bare-clone fsmonitor--daemon run 2>actual &&
    -+    grep "bare repos are incompatible with fsmonitor" actual
    ++    grep "bare repository .* is incompatible with fsmonitor" actual
     +'
     +
      test_expect_success 'setup' '
 5:  6329328d18 !  5:  e32a8a7ea7 fsmonitor-settings: stub in platform-specific incompatibility checking
    @@ Metadata
     Author: Jeff Hostetler <jeffhost@microsoft.com>
     
      ## Commit message ##
    -    fsmonitor-settings: stub in platform-specific incompatibility checking
    +    fsmonitor-settings: stub in Win32-specific incompatibility checking
     
         Extend generic incompatibility checkout with platform-specific
         mechanism.  Stub in Win32 version.
    @@ fsmonitor-settings.c: static int check_for_incompatible(struct repository *r)
      
     
      ## fsmonitor-settings.h ##
    -@@ fsmonitor-settings.h: const char *fsm_settings__get_reason_msg(struct repository *r);
    +@@ fsmonitor-settings.h: int fsm_settings__error_if_incompatible(struct repository *r);
      
      struct fsmonitor_settings;
      
 6:  fa9e86e7de !  6:  5546339d96 fsmonitor-settings: VFS for Git virtual repos are incompatible
    @@ compat/fsmonitor/fsm-settings-win32.c
      }
     
      ## fsmonitor-settings.c ##
    -@@ fsmonitor-settings.c: const char *fsm_settings__get_reason_msg(struct repository *r)
    - 
    -     case FSMONITOR_REASON_BARE:
    -         return _("bare repos are incompatible with fsmonitor");
    +@@ fsmonitor-settings.c: int fsm_settings__error_if_incompatible(struct repository *r)
    +         error(_("bare repository '%s' is incompatible with fsmonitor"),
    +               xgetcwd());
    +         return 1;
     +
     +    case FSMONITOR_REASON_VFS4GIT:
    -+        return _("virtual repos are incompatible with fsmonitor");
    ++        error(_("virtual repository '%s' is incompatible with fsmonitor"),
    ++              r->worktree);
    ++        return 1;
          }
      
    -     BUG("Unhandled case in fsm_settings__get_reason_msg '%d'",
    +     BUG("Unhandled case in fsm_settings__error_if_incompatible: '%d'",
     
      ## fsmonitor-settings.h ##
     @@ fsmonitor-settings.h: enum fsmonitor_mode {
    @@ fsmonitor-settings.h: enum fsmonitor_mode {
     
      ## t/t7519-status-fsmonitor.sh ##
     @@ t/t7519-status-fsmonitor.sh: test_expect_success FSMONITOR_DAEMON 'run fsmonitor-daemon in bare repo' '
    -     grep "bare repos are incompatible with fsmonitor" actual
    +     grep "bare repository .* is incompatible with fsmonitor" actual
      '
      
     +test_expect_success MINGW,FSMONITOR_DAEMON 'run fsmonitor-daemon in virtual repo' '
    @@ t/t7519-status-fsmonitor.sh: test_expect_success FSMONITOR_DAEMON 'run fsmonitor
     +    test_must_fail git -C ./fake-virtual-clone \
     +               -c core.virtualfilesystem=true \
     +               fsmonitor--daemon run 2>actual &&
    -+    grep "virtual repos are incompatible with fsmonitor" actual
    ++    grep "virtual repository .* is incompatible with fsmonitor" actual
     +'
     +
      test_expect_success 'setup' '
 7:  c180241041 =  7:  1d2877efda fsmonitor-settings: stub in macOS-specific incompatibility checking
 8:  e3bfa0bd69 !  8:  06d7f18676 fsmonitor-settings: remote repos on macOS are incompatible
    @@ compat/fsmonitor/fsm-settings-darwin.c
      }
     
      ## fsmonitor-settings.c ##
    -@@ fsmonitor-settings.c: const char *fsm_settings__get_reason_msg(struct repository *r)
    -     case FSMONITOR_REASON_BARE:
    -         return _("bare repos are incompatible with fsmonitor");
    +@@ fsmonitor-settings.c: int fsm_settings__error_if_incompatible(struct repository *r)
    +               xgetcwd());
    +         return 1;
      
     +    case FSMONITOR_REASON_ERROR:
    -+        return _("repo incompatible with fsmonitor due to errors");
    ++        error(_("repository '%s' is incompatible with fsmonitor due to errors"),
    ++              r->worktree);
    ++        return 1;
     +
     +    case FSMONITOR_REASON_REMOTE:
    -+        return _("remote repos are incompatible with fsmonitor");
    ++        error(_("remote repository '%s' is incompatible with fsmonitor"),
    ++              r->worktree);
    ++        return 1;
     +
          case FSMONITOR_REASON_VFS4GIT:
    -         return _("virtual repos are incompatible with fsmonitor");
    -     }
    +         error(_("virtual repository '%s' is incompatible with fsmonitor"),
    +               r->worktree);
     
      ## fsmonitor-settings.h ##
     @@ fsmonitor-settings.h: enum fsmonitor_mode {
 9:  e32da3118f =  9:  5ca97f482d fsmonitor-settings: remote repos on Windows are incompatible
27:  e3e01677d9 ! 10:  6715143724 fsmonitor-settings: NTFS and FAT32 on MacOS are incompatible
    @@ compat/fsmonitor/fsm-settings-darwin.c: enum fsmonitor_reason fsm_os__incompatib
      
     
      ## fsmonitor-settings.c ##
    -@@ fsmonitor-settings.c: const char *fsm_settings__get_reason_msg(struct repository *r)
    - 
    -     case FSMONITOR_REASON_VFS4GIT:
    -         return _("virtual repos are incompatible with fsmonitor");
    +@@ fsmonitor-settings.c: int fsm_settings__error_if_incompatible(struct repository *r)
    +         error(_("virtual repository '%s' is incompatible with fsmonitor"),
    +               r->worktree);
    +         return 1;
     +
     +    case FSMONITOR_REASON_NOSOCKETS:
    -+        return _("repo filesystem does not support Unix sockets");
    ++        error(_("repository '%s' is incompatible with fsmonitor due to lack of Unix sockets"),
    ++              r->worktree);
    ++        return 1;
          }
      
    -     BUG("Unhandled case in fsm_settings__get_reason_msg '%d'",
    +     BUG("Unhandled case in fsm_settings__error_if_incompatible: '%d'",
     
      ## fsmonitor-settings.h ##
     @@ fsmonitor-settings.h: enum fsmonitor_reason {
10:  f63de4eda3 = 11:  ed1f723130 unpack-trees: initialize fsmonitor_has_run_once in o->result
11:  fe305f5f28 = 12:  35c77b854b fsm-listen-darwin: ignore FSEvents caused by xattr changes on macOS
12:  c8f3e251b1 ! 13:  a5affb359c fsmonitor--daemon: cd out of worktree root
    @@ builtin/fsmonitor--daemon.c: static int fsmonitor_run_daemon(void)
     +     */
     +    home = getenv("HOME");
     +    if (home && *home && chdir(home))
    -+        die_errno("could not cd home '%s'", home);
    ++        die_errno(_("could not cd home '%s'"), home);
     +
          err = fsmonitor_run_daemon_1(&state);
      
    @@ compat/fsmonitor/fsm-listen-win32.c: static int recv_rdcw_watch(struct one_watch
     +     * Shutdown if we get any error.
           */
      
    -     error("GetOverlappedResult failed on '%s' [GLE %ld]",
    +     error(_("GetOverlappedResult failed on '%s' [GLE %ld]"),
     
      ## fsmonitor--daemon.h ##
     @@ fsmonitor--daemon.h: struct fsmonitor_daemon_state {
13:  71673be2da = 14:  087af5dfb6 fsmonitor--daemon: prepare for adding health thread
14:  5387baaf5d ! 15:  e78eb20c1b fsmonitor--daemon: rename listener thread related variables
    @@ builtin/fsmonitor--daemon.c: static int fsmonitor_run_daemon(void)
          /* Prepare to (recursively) watch the <worktree-root> directory. */
     
      ## compat/fsmonitor/fsm-listen-darwin.c ##
    -@@ compat/fsmonitor/fsm-listen-darwin.c: void FSEventStreamRelease(FSEventStreamRef stream);
    +@@
      #include "fsm-listen.h"
      #include "fsmonitor--daemon.h"
      
    @@ compat/fsmonitor/fsm-listen-darwin.c: int fsm_listen__ctor(struct fsmonitor_daem
              NULL, state->path_worktree_watch.buf, kCFStringEncodingUTF8);
     @@ compat/fsmonitor/fsm-listen-darwin.c: int fsm_listen__ctor(struct fsmonitor_daemon_state *state)
      failed:
    -     error("Unable to create FSEventStream.");
    +     error(_("Unable to create FSEventStream."));
      
     -    FREE_AND_NULL(state->backend_data);
     +    FREE_AND_NULL(state->listen_data);
15:  f78e4ad87c = 16:  301fff5296 fsmonitor--daemon: stub in health thread
16:  bb72f911a0 = 17:  c6b5bdd25e fsm-health-win32: add polling framework to monitor daemon health
17:  baf8c031a9 ! 18:  13d11713a8 fsm-health-win32: force shutdown daemon if worktree root moves
    @@ compat/fsmonitor/fsm-health-win32.c: struct fsm_health_data
     +        return 0;
     +
     +    default:
    -+        die("unhandled case in 'has_worktree_moved': %d",
    ++        die(_("unhandled case in 'has_worktree_moved': %d"),
     +            (int)ctx);
     +    }
     +
18:  796b659139 = 19:  01c1a38c46 fsm-listen-darwin: shutdown daemon if worktree root is moved/renamed
19:  2459192087 = 20:  0f0a5b5ca1 fsmonitor: optimize processing of directory events
20:  06a3241385 ! 21:  d8218d197a t7527: FSMonitor tests for directory moves
    @@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'setup' '
          git -c core.fsmonitor=false add . &&
          test_tick &&
          git -c core.fsmonitor=false commit -m initial &&
    -@@ t/t7527-builtin-fsmonitor.sh: verify_status () {
    -     echo HELLO AFTER
    +@@ t/t7527-builtin-fsmonitor.sh: directory_to_file () {
    +     echo 1 >dir1
      }
      
     +move_directory_contents_deeper() {
    -+    mkdir T1/_new_
    ++    mkdir T1/_new_ &&
     +    mv T1/[A-Z]* T1/_new_
     +}
     +
21:  4b59013cad = 22:  79da369dcc t/perf/p7527: add perf test for builtin FSMonitor
22:  524d449ed6 ! 23:  4ab4306ada fsmonitor: never set CE_FSMONITOR_VALID on submodules
    @@ t/t7527-builtin-fsmonitor.sh: do
     +    git -C super submodule add ../sub ./dir_1/dir_2/sub &&
     +    git -C super commit -m "add sub" &&
     +
    -+    start_daemon super &&
    ++    start_daemon -C super &&
     +    git -C super config core.fsmonitor true &&
     +    git -C super update-index --fsmonitor &&
     +    git -C super status &&
23:  c7264decaf ! 24:  5d0fa19929 t7527: test FSMonitor on case insensitive+preserving file system
    @@ t/t7527-builtin-fsmonitor.sh: test_expect_success "Submodule" '
     +#    test_when_finished "stop_daemon_delete_repo test_insensitive" &&
     +
     +    git init test_insensitive &&
    -+    (
    -+        GIT_TRACE_FSMONITOR="$(pwd)/insensitive.trace" &&
    -+        export GIT_TRACE_FSMONITOR &&
     +
    -+        start_daemon test_insensitive
    -+    ) &&
    ++    start_daemon -C test_insensitive -tf "$PWD/insensitive.trace" &&
     +
     +    mkdir -p test_insensitive/abc/def &&
     +    echo xyz >test_insensitive/ABC/DEF/xyz &&
24:  95b9d4210d = 25:  264397e8bd fsmonitor: on macOS also emit NFC spelling for NFD pathname
25:  5a0c1b7a28 ! 26:  e6b621fb76 t/lib-unicode-nfc-nfd: helper prereqs for testing unicode nfc/nfd
    @@ t/lib-unicode-nfc-nfd.sh (new)
     +    ls | od -t x1 | grep "64 *5f *cf *89 *cc *94 *cd *82"
     +'
     +
    -+if test $unicode_debug = 1
    ++# The following is for debugging. I found it useful when
    ++# trying to understand the various (OS, FS) quirks WRT
    ++# Unicode and how composition/decomposition is handled.
    ++# For example, when trying to understand how (macOS, APFS)
    ++# and (macOS, HFS) and (macOS, FAT32) compare.
    ++#
    ++# It is rather noisy, so it is disabled by default.
    ++#
    ++if test "$unicode_debug" = "true"
     +then
     +    if test_have_prereq UNICODE_COMPOSITION_SENSITIVE
     +    then
26:  a45c1fd300 ! 27:  aa96a849ce t7527: test Unicode NFC/NFD handling on MacOS
    @@ t/t7527-builtin-fsmonitor.sh: test_expect_success CASE_INSENSITIVE_FS 'case inse
          egrep "^event: abc/def/xyz$" ./insensitive.trace
      '
      
    -+unicode_debug=0
    ++# The variable "unicode_debug" is defined in the following library
    ++# script to dump information about how the (OS, FS) handles Unicode
    ++# composition.  Uncomment the following line if you want to enable it.
    ++#
    ++# unicode_debug=true
    ++
     +. "$TEST_DIRECTORY/lib-unicode-nfc-nfd.sh"
     +
     +# See if the OS or filesystem does NFC/NFD aliasing/munging.
    @@ t/t7527-builtin-fsmonitor.sh: test_expect_success CASE_INSENSITIVE_FS 'case inse
     +    test_when_finished "stop_daemon_delete_repo test_unicode" &&
     +
     +    git init test_unicode &&
    -+    (
    -+        GIT_TRACE_FSMONITOR="$(pwd)/unicode.trace" &&
    -+        export GIT_TRACE_FSMONITOR &&
     +
    -+        start_daemon test_unicode
    -+    ) &&
    ++    start_daemon -C test_unicode -tf "$PWD/unicode.trace" &&
     +
     +    # Create a directory using an NFC spelling.
     +    #


Jeff Hostetler (27):
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
  t/lib-unicode-nfc-nfd: helper prereqs for testing unicode nfc/nfd
  t7527: test Unicode NFC/NFD handling on MacOS

 Makefile                               |  19 +-
 builtin/fsmonitor--daemon.c            | 104 ++++++-
 builtin/update-index.c                 |   4 +
 compat/fsmonitor/fsm-health-darwin.c   |  24 ++
 compat/fsmonitor/fsm-health-win32.c    | 278 +++++++++++++++++
 compat/fsmonitor/fsm-health.h          |  47 +++
 compat/fsmonitor/fsm-listen-darwin.c   | 122 ++++++--
 compat/fsmonitor/fsm-listen-win32.c    | 413 ++++++++++++++++++++-----
 compat/fsmonitor/fsm-listen.h          |   2 +-
 compat/fsmonitor/fsm-settings-darwin.c |  89 ++++++
 compat/fsmonitor/fsm-settings-win32.c  | 137 ++++++++
 config.mak.uname                       |   5 +
 contrib/buildsystems/CMakeLists.txt    |   8 +
 fsmonitor--daemon.h                    |  11 +-
 fsmonitor-settings.c                   |  92 ++++++
 fsmonitor-settings.h                   |  29 ++
 fsmonitor.c                            |  73 ++++-
 fsmonitor.h                            |  11 +
 t/helper/test-fsmonitor-client.c       | 106 +++++++
 t/lib-unicode-nfc-nfd.sh               | 167 ++++++++++
 t/perf/p7527-builtin-fsmonitor.sh      | 257 +++++++++++++++
 t/t7519-status-fsmonitor.sh            |  32 ++
 t/t7527-builtin-fsmonitor.sh           | 311 +++++++++++++++++++
 unpack-trees.c                         |   1 +
 24 files changed, 2218 insertions(+), 124 deletions(-)
 create mode 100644 compat/fsmonitor/fsm-health-darwin.c
 create mode 100644 compat/fsmonitor/fsm-health-win32.c
 create mode 100644 compat/fsmonitor/fsm-health.h
 create mode 100644 compat/fsmonitor/fsm-settings-darwin.c
 create mode 100644 compat/fsmonitor/fsm-settings-win32.c
 create mode 100755 t/lib-unicode-nfc-nfd.sh
 create mode 100755 t/perf/p7527-builtin-fsmonitor.sh


base-commit: e6cf84dc8eb4933220187849b84e5cb96cda185f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1143%2Fjeffhostetler%2Fbuiltin-fsmonitor-part3-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1143/jeffhostetler/builtin-fsmonitor-part3-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1143

Range-diff vs v2:

  1:  34619e0652b !  1:  779a15b38e8 fsm-listen-win32: handle shortnames
     @@ compat/fsmonitor/fsm-listen-win32.c: static int normalize_path_in_utf8(FILE_NOTI
      @@ compat/fsmonitor/fsm-listen-win32.c: static int normalize_path_in_utf8(FILE_NOTIFY_INFORMATION *info,
       			goto normalize;
       		if (GetLastError() != ERROR_INSUFFICIENT_BUFFER) {
     - 			error("[GLE %ld] could not convert path to UTF-8: '%.*ls'",
     + 			error(_("[GLE %ld] could not convert path to UTF-8: '%.*ls'"),
      -			      GetLastError(),
      -			      (int)(info->FileNameLength / sizeof(WCHAR)),
      -			      info->FileName);
     @@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'implicit daemon stop (rename
      +
      +	git init test_implicit_1s &&
      +
     -+	start_daemon test_implicit_1s &&
     ++	start_daemon -C test_implicit_1s &&
      +
      +	# renaming the .git directory will implicitly stop the daemon.
      +	# this moves {.git, GIT~1} to {.gitxyz, GITXYZ~1}.
     @@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'implicit daemon stop (rename
      +	test_path_is_file test_implicit_1s2/GIT~1 &&
      +	test_path_is_dir  test_implicit_1s2/GIT~2 &&
      +
     -+	start_daemon test_implicit_1s2 &&
     ++	start_daemon -C test_implicit_1s2 &&
      +
      +	# renaming the .git directory will implicitly stop the daemon.
      +	# the rename-from FS Event will contain the shortname.
  2:  3a0f30b849a !  2:  11d4a17b692 t7527: test FSMonitor on repos with Unicode root paths
     @@ t/t7527-builtin-fsmonitor.sh: do
      +		git -C "$u" add file1 &&
      +		git -C "$u" config core.fsmonitor true &&
      +
     -+		start_daemon "$u" &&
     ++		start_daemon -C "$u" &&
      +		git -C "$u" status >actual &&
      +		grep "new file:   file1" actual
      +	'
  3:  87d1c0b6f2a !  3:  901fa32f6ea t/helper/fsmonitor-client: create stress test
     @@ t/helper/test-fsmonitor-client.c: static int do_send_flush(void)
      +	int nr_requests = 1;
       
       	const char * const fsmonitor_client_usage[] = {
     - 		N_("test-helper fsmonitor-client query [<token>]"),
     - 		N_("test-helper fsmonitor-client flush"),
     -+		N_("test-helper fsmonitor-client hammer [<token>] [<threads>] [<requests>]"),
     + 		"test-tool fsmonitor-client query [<token>]",
     + 		"test-tool fsmonitor-client flush",
     ++		"test-tool fsmonitor-client hammer [<token>] [<threads>] [<requests>]",
       		NULL,
       	};
       
       	struct option options[] = {
     - 		OPT_STRING(0, "token", &token, N_("token"),
     - 			   N_("command token to send to the server")),
     + 		OPT_STRING(0, "token", &token, "token",
     + 			   "command token to send to the server"),
      +
     -+		OPT_INTEGER(0, "threads", &nr_threads, N_("number of client threads")),
     -+		OPT_INTEGER(0, "requests", &nr_requests, N_("number of requests per thread")),
     ++		OPT_INTEGER(0, "threads", &nr_threads, "number of client threads"),
     ++		OPT_INTEGER(0, "requests", &nr_requests, "number of requests per thread"),
      +
       		OPT_END()
       	};
  4:  8c4f90ae4fd !  4:  a8f0b2a5256 fsmonitor-settings: bare repos are incompatible with FSMonitor
     @@ builtin/fsmonitor--daemon.c: int cmd_fsmonitor__daemon(int argc, const char **ar
      +	prepare_repo_settings(the_repository);
      +	fsm_settings__set_ipc(the_repository);
      +
     -+	if (fsm_settings__get_mode(the_repository) == FSMONITOR_MODE_INCOMPATIBLE) {
     -+		const char *msg = fsm_settings__get_reason_msg(the_repository);
     -+
     -+		return error("%s '%s'", msg ? msg : "???", xgetcwd());
     -+	}
     ++	if (fsm_settings__error_if_incompatible(the_repository))
     ++		return 1;
      +
       	if (!strcmp(subcmd, "start"))
       		return !!try_to_start_background_daemon();
     @@ builtin/update-index.c: int cmd_update_index(int argc, const char **argv, const
       	if (fsmonitor > 0) {
       		enum fsmonitor_mode fsm_mode = fsm_settings__get_mode(r);
      +
     -+		if (fsm_mode == FSMONITOR_MODE_INCOMPATIBLE) {
     -+			const char *msg = fsm_settings__get_reason_msg(r);
     -+
     -+			return error("%s '%s'", msg ? msg : "???", xgetcwd());
     -+		}
     ++		if (fsm_settings__error_if_incompatible(the_repository))
     ++			return 1;
      +
       		if (fsm_mode == FSMONITOR_MODE_DISABLED) {
     - 			advise(_("core.fsmonitor is unset; "
     - 				 "set it if you really want to "
     + 			warning(_("core.fsmonitor is unset; "
     + 				"set it if you really want to "
      
       ## fsmonitor-settings.c ##
      @@
     @@ fsmonitor-settings.c
       static void lookup_fsmonitor_settings(struct repository *r)
       {
       	struct fsmonitor_settings *s;
     +@@ fsmonitor-settings.c: static void lookup_fsmonitor_settings(struct repository *r)
     + 
     + 	CALLOC_ARRAY(s, 1);
     + 	s->mode = FSMONITOR_MODE_DISABLED;
     ++	s->reason = FSMONITOR_REASON_OK;
     + 
     + 	r->settings.fsmonitor = s;
     + 
      @@ fsmonitor-settings.c: void fsm_settings__set_ipc(struct repository *r)
       
       	lookup_fsmonitor_settings(r);
     @@ fsmonitor-settings.c: void fsm_settings__set_disabled(struct repository *r)
      +	return r->settings.fsmonitor->reason;
      +}
      +
     -+const char *fsm_settings__get_reason_msg(struct repository *r)
     ++int fsm_settings__error_if_incompatible(struct repository *r)
      +{
      +	enum fsmonitor_reason reason = fsm_settings__get_reason(r);
      +
      +	switch (reason) {
      +	case FSMONITOR_REASON_OK:
     -+		return NULL;
     ++		return 0;
      +
      +	case FSMONITOR_REASON_BARE:
     -+		return _("bare repos are incompatible with fsmonitor");
     ++		error(_("bare repository '%s' is incompatible with fsmonitor"),
     ++		      xgetcwd());
     ++		return 1;
      +	}
      +
     -+	BUG("Unhandled case in fsm_settings__get_reason_msg '%d'",
     ++	BUG("Unhandled case in fsm_settings__error_if_incompatible: '%d'",
      +	    reason);
      +}
      
     @@ fsmonitor-settings.h: void fsm_settings__set_disabled(struct repository *r);
       const char *fsm_settings__get_hook_path(struct repository *r);
       
      +enum fsmonitor_reason fsm_settings__get_reason(struct repository *r);
     -+const char *fsm_settings__get_reason_msg(struct repository *r);
     ++int fsm_settings__error_if_incompatible(struct repository *r);
      +
       struct fsmonitor_settings;
       
     @@ t/t7519-status-fsmonitor.sh: test_lazy_prereq UNTRACKED_CACHE '
      +	test_must_fail \
      +		git -C ./bare-clone -c core.fsmonitor=foo \
      +			update-index --fsmonitor 2>actual &&
     -+	grep "bare repos are incompatible with fsmonitor" actual &&
     ++	grep "bare repository .* is incompatible with fsmonitor" actual &&
      +
      +	test_must_fail \
      +		git -C ./bare-clone -c core.fsmonitor=true \
      +			update-index --fsmonitor 2>actual &&
     -+	grep "bare repos are incompatible with fsmonitor" actual
     ++	grep "bare repository .* is incompatible with fsmonitor" actual
      +'
      +
      +test_expect_success FSMONITOR_DAEMON 'run fsmonitor-daemon in bare repo' '
      +	test_when_finished "rm -rf ./bare-clone actual" &&
      +	git init --bare bare-clone &&
      +	test_must_fail git -C ./bare-clone fsmonitor--daemon run 2>actual &&
     -+	grep "bare repos are incompatible with fsmonitor" actual
     ++	grep "bare repository .* is incompatible with fsmonitor" actual
      +'
      +
       test_expect_success 'setup' '
  5:  6329328d185 !  5:  e32a8a7ea7a fsmonitor-settings: stub in platform-specific incompatibility checking
     @@ Metadata
      Author: Jeff Hostetler <jeffhost@microsoft.com>
      
       ## Commit message ##
     -    fsmonitor-settings: stub in platform-specific incompatibility checking
     +    fsmonitor-settings: stub in Win32-specific incompatibility checking
      
          Extend generic incompatibility checkout with platform-specific
          mechanism.  Stub in Win32 version.
     @@ fsmonitor-settings.c: static int check_for_incompatible(struct repository *r)
       
      
       ## fsmonitor-settings.h ##
     -@@ fsmonitor-settings.h: const char *fsm_settings__get_reason_msg(struct repository *r);
     +@@ fsmonitor-settings.h: int fsm_settings__error_if_incompatible(struct repository *r);
       
       struct fsmonitor_settings;
       
  6:  fa9e86e7de7 !  6:  5546339d963 fsmonitor-settings: VFS for Git virtual repos are incompatible
     @@ compat/fsmonitor/fsm-settings-win32.c
       }
      
       ## fsmonitor-settings.c ##
     -@@ fsmonitor-settings.c: const char *fsm_settings__get_reason_msg(struct repository *r)
     - 
     - 	case FSMONITOR_REASON_BARE:
     - 		return _("bare repos are incompatible with fsmonitor");
     +@@ fsmonitor-settings.c: int fsm_settings__error_if_incompatible(struct repository *r)
     + 		error(_("bare repository '%s' is incompatible with fsmonitor"),
     + 		      xgetcwd());
     + 		return 1;
      +
      +	case FSMONITOR_REASON_VFS4GIT:
     -+		return _("virtual repos are incompatible with fsmonitor");
     ++		error(_("virtual repository '%s' is incompatible with fsmonitor"),
     ++		      r->worktree);
     ++		return 1;
       	}
       
     - 	BUG("Unhandled case in fsm_settings__get_reason_msg '%d'",
     + 	BUG("Unhandled case in fsm_settings__error_if_incompatible: '%d'",
      
       ## fsmonitor-settings.h ##
      @@ fsmonitor-settings.h: enum fsmonitor_mode {
     @@ fsmonitor-settings.h: enum fsmonitor_mode {
      
       ## t/t7519-status-fsmonitor.sh ##
      @@ t/t7519-status-fsmonitor.sh: test_expect_success FSMONITOR_DAEMON 'run fsmonitor-daemon in bare repo' '
     - 	grep "bare repos are incompatible with fsmonitor" actual
     + 	grep "bare repository .* is incompatible with fsmonitor" actual
       '
       
      +test_expect_success MINGW,FSMONITOR_DAEMON 'run fsmonitor-daemon in virtual repo' '
     @@ t/t7519-status-fsmonitor.sh: test_expect_success FSMONITOR_DAEMON 'run fsmonitor
      +	test_must_fail git -C ./fake-virtual-clone \
      +			   -c core.virtualfilesystem=true \
      +			   fsmonitor--daemon run 2>actual &&
     -+	grep "virtual repos are incompatible with fsmonitor" actual
     ++	grep "virtual repository .* is incompatible with fsmonitor" actual
      +'
      +
       test_expect_success 'setup' '
  7:  c1802410410 =  7:  1d2877efda0 fsmonitor-settings: stub in macOS-specific incompatibility checking
  8:  e3bfa0bd69d !  8:  06d7f18676d fsmonitor-settings: remote repos on macOS are incompatible
     @@ compat/fsmonitor/fsm-settings-darwin.c
       }
      
       ## fsmonitor-settings.c ##
     -@@ fsmonitor-settings.c: const char *fsm_settings__get_reason_msg(struct repository *r)
     - 	case FSMONITOR_REASON_BARE:
     - 		return _("bare repos are incompatible with fsmonitor");
     +@@ fsmonitor-settings.c: int fsm_settings__error_if_incompatible(struct repository *r)
     + 		      xgetcwd());
     + 		return 1;
       
      +	case FSMONITOR_REASON_ERROR:
     -+		return _("repo incompatible with fsmonitor due to errors");
     ++		error(_("repository '%s' is incompatible with fsmonitor due to errors"),
     ++		      r->worktree);
     ++		return 1;
      +
      +	case FSMONITOR_REASON_REMOTE:
     -+		return _("remote repos are incompatible with fsmonitor");
     ++		error(_("remote repository '%s' is incompatible with fsmonitor"),
     ++		      r->worktree);
     ++		return 1;
      +
       	case FSMONITOR_REASON_VFS4GIT:
     - 		return _("virtual repos are incompatible with fsmonitor");
     - 	}
     + 		error(_("virtual repository '%s' is incompatible with fsmonitor"),
     + 		      r->worktree);
      
       ## fsmonitor-settings.h ##
      @@ fsmonitor-settings.h: enum fsmonitor_mode {
  9:  e32da3118fb =  9:  5ca97f482d0 fsmonitor-settings: remote repos on Windows are incompatible
 27:  e3e01677d93 ! 10:  67151437245 fsmonitor-settings: NTFS and FAT32 on MacOS are incompatible
     @@ compat/fsmonitor/fsm-settings-darwin.c: enum fsmonitor_reason fsm_os__incompatib
       
      
       ## fsmonitor-settings.c ##
     -@@ fsmonitor-settings.c: const char *fsm_settings__get_reason_msg(struct repository *r)
     - 
     - 	case FSMONITOR_REASON_VFS4GIT:
     - 		return _("virtual repos are incompatible with fsmonitor");
     +@@ fsmonitor-settings.c: int fsm_settings__error_if_incompatible(struct repository *r)
     + 		error(_("virtual repository '%s' is incompatible with fsmonitor"),
     + 		      r->worktree);
     + 		return 1;
      +
      +	case FSMONITOR_REASON_NOSOCKETS:
     -+		return _("repo filesystem does not support Unix sockets");
     ++		error(_("repository '%s' is incompatible with fsmonitor due to lack of Unix sockets"),
     ++		      r->worktree);
     ++		return 1;
       	}
       
     - 	BUG("Unhandled case in fsm_settings__get_reason_msg '%d'",
     + 	BUG("Unhandled case in fsm_settings__error_if_incompatible: '%d'",
      
       ## fsmonitor-settings.h ##
      @@ fsmonitor-settings.h: enum fsmonitor_reason {
 10:  f63de4eda31 = 11:  ed1f7231309 unpack-trees: initialize fsmonitor_has_run_once in o->result
 11:  fe305f5f287 = 12:  35c77b854bd fsm-listen-darwin: ignore FSEvents caused by xattr changes on macOS
 12:  c8f3e251b1f ! 13:  a5affb359c4 fsmonitor--daemon: cd out of worktree root
     @@ builtin/fsmonitor--daemon.c: static int fsmonitor_run_daemon(void)
      +	 */
      +	home = getenv("HOME");
      +	if (home && *home && chdir(home))
     -+		die_errno("could not cd home '%s'", home);
     ++		die_errno(_("could not cd home '%s'"), home);
      +
       	err = fsmonitor_run_daemon_1(&state);
       
     @@ compat/fsmonitor/fsm-listen-win32.c: static int recv_rdcw_watch(struct one_watch
      +	 * Shutdown if we get any error.
       	 */
       
     - 	error("GetOverlappedResult failed on '%s' [GLE %ld]",
     + 	error(_("GetOverlappedResult failed on '%s' [GLE %ld]"),
      
       ## fsmonitor--daemon.h ##
      @@ fsmonitor--daemon.h: struct fsmonitor_daemon_state {
 13:  71673be2da5 = 14:  087af5dfb63 fsmonitor--daemon: prepare for adding health thread
 14:  5387baaf5d7 ! 15:  e78eb20c1bf fsmonitor--daemon: rename listener thread related variables
     @@ builtin/fsmonitor--daemon.c: static int fsmonitor_run_daemon(void)
       	/* Prepare to (recursively) watch the <worktree-root> directory. */
      
       ## compat/fsmonitor/fsm-listen-darwin.c ##
     -@@ compat/fsmonitor/fsm-listen-darwin.c: void FSEventStreamRelease(FSEventStreamRef stream);
     +@@
       #include "fsm-listen.h"
       #include "fsmonitor--daemon.h"
       
     @@ compat/fsmonitor/fsm-listen-darwin.c: int fsm_listen__ctor(struct fsmonitor_daem
       		NULL, state->path_worktree_watch.buf, kCFStringEncodingUTF8);
      @@ compat/fsmonitor/fsm-listen-darwin.c: int fsm_listen__ctor(struct fsmonitor_daemon_state *state)
       failed:
     - 	error("Unable to create FSEventStream.");
     + 	error(_("Unable to create FSEventStream."));
       
      -	FREE_AND_NULL(state->backend_data);
      +	FREE_AND_NULL(state->listen_data);
 15:  f78e4ad87c0 = 16:  301fff5296a fsmonitor--daemon: stub in health thread
 16:  bb72f911a05 = 17:  c6b5bdd25e4 fsm-health-win32: add polling framework to monitor daemon health
 17:  baf8c031a97 ! 18:  13d11713a86 fsm-health-win32: force shutdown daemon if worktree root moves
     @@ compat/fsmonitor/fsm-health-win32.c: struct fsm_health_data
      +		return 0;
      +
      +	default:
     -+		die("unhandled case in 'has_worktree_moved': %d",
     ++		die(_("unhandled case in 'has_worktree_moved': %d"),
      +		    (int)ctx);
      +	}
      +
 18:  796b6591393 = 19:  01c1a38c462 fsm-listen-darwin: shutdown daemon if worktree root is moved/renamed
 19:  24591920878 = 20:  0f0a5b5ca16 fsmonitor: optimize processing of directory events
 20:  06a32413854 ! 21:  d8218d197ad t7527: FSMonitor tests for directory moves
     @@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'setup' '
       	git -c core.fsmonitor=false add . &&
       	test_tick &&
       	git -c core.fsmonitor=false commit -m initial &&
     -@@ t/t7527-builtin-fsmonitor.sh: verify_status () {
     - 	echo HELLO AFTER
     +@@ t/t7527-builtin-fsmonitor.sh: directory_to_file () {
     + 	echo 1 >dir1
       }
       
      +move_directory_contents_deeper() {
     -+	mkdir T1/_new_
     ++	mkdir T1/_new_ &&
      +	mv T1/[A-Z]* T1/_new_
      +}
      +
 21:  4b59013cadd = 22:  79da369dcce t/perf/p7527: add perf test for builtin FSMonitor
 22:  524d449ed64 ! 23:  4ab4306adab fsmonitor: never set CE_FSMONITOR_VALID on submodules
     @@ t/t7527-builtin-fsmonitor.sh: do
      +	git -C super submodule add ../sub ./dir_1/dir_2/sub &&
      +	git -C super commit -m "add sub" &&
      +
     -+	start_daemon super &&
     ++	start_daemon -C super &&
      +	git -C super config core.fsmonitor true &&
      +	git -C super update-index --fsmonitor &&
      +	git -C super status &&
 23:  c7264decaf6 ! 24:  5d0fa19929d t7527: test FSMonitor on case insensitive+preserving file system
     @@ t/t7527-builtin-fsmonitor.sh: test_expect_success "Submodule" '
      +#	test_when_finished "stop_daemon_delete_repo test_insensitive" &&
      +
      +	git init test_insensitive &&
     -+	(
     -+		GIT_TRACE_FSMONITOR="$(pwd)/insensitive.trace" &&
     -+		export GIT_TRACE_FSMONITOR &&
      +
     -+		start_daemon test_insensitive
     -+	) &&
     ++	start_daemon -C test_insensitive -tf "$PWD/insensitive.trace" &&
      +
      +	mkdir -p test_insensitive/abc/def &&
      +	echo xyz >test_insensitive/ABC/DEF/xyz &&
 24:  95b9d4210d2 = 25:  264397e8bd4 fsmonitor: on macOS also emit NFC spelling for NFD pathname
 25:  5a0c1b7a287 ! 26:  e6b621fb766 t/lib-unicode-nfc-nfd: helper prereqs for testing unicode nfc/nfd
     @@ t/lib-unicode-nfc-nfd.sh (new)
      +	ls | od -t x1 | grep "64 *5f *cf *89 *cc *94 *cd *82"
      +'
      +
     -+if test $unicode_debug = 1
     ++# The following is for debugging. I found it useful when
     ++# trying to understand the various (OS, FS) quirks WRT
     ++# Unicode and how composition/decomposition is handled.
     ++# For example, when trying to understand how (macOS, APFS)
     ++# and (macOS, HFS) and (macOS, FAT32) compare.
     ++#
     ++# It is rather noisy, so it is disabled by default.
     ++#
     ++if test "$unicode_debug" = "true"
      +then
      +	if test_have_prereq UNICODE_COMPOSITION_SENSITIVE
      +	then
 26:  a45c1fd3000 ! 27:  aa96a849ce4 t7527: test Unicode NFC/NFD handling on MacOS
     @@ t/t7527-builtin-fsmonitor.sh: test_expect_success CASE_INSENSITIVE_FS 'case inse
       	egrep "^event: abc/def/xyz$" ./insensitive.trace
       '
       
     -+unicode_debug=0
     ++# The variable "unicode_debug" is defined in the following library
     ++# script to dump information about how the (OS, FS) handles Unicode
     ++# composition.  Uncomment the following line if you want to enable it.
     ++#
     ++# unicode_debug=true
     ++
      +. "$TEST_DIRECTORY/lib-unicode-nfc-nfd.sh"
      +
      +# See if the OS or filesystem does NFC/NFD aliasing/munging.
     @@ t/t7527-builtin-fsmonitor.sh: test_expect_success CASE_INSENSITIVE_FS 'case inse
      +	test_when_finished "stop_daemon_delete_repo test_unicode" &&
      +
      +	git init test_unicode &&
     -+	(
     -+		GIT_TRACE_FSMONITOR="$(pwd)/unicode.trace" &&
     -+		export GIT_TRACE_FSMONITOR &&
      +
     -+		start_daemon test_unicode
     -+	) &&
     ++	start_daemon -C test_unicode -tf "$PWD/unicode.trace" &&
      +
      +	# Create a directory using an NFC spelling.
      +	#

-- 
gitgitgadget
