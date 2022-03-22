Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B31C433EF
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 18:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239994AbiCVSBu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 14:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237132AbiCVSBs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 14:01:48 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C4C65481
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:00:17 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id v130-20020a1cac88000000b00389d0a5c511so3759867wme.5
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zSKqzWg5/Og0nn61mWaIYweEhmqEAiqCy3h6c3h1LDw=;
        b=QoBCKf0K8/LmFQkiRnZuYZM5SW1WomfnWhST+4UDqE9ieWCRiohuVY7IL2KU/7xgHd
         W2npfFDxLcNpxCPfMal8nq+ZoIzi0HZZO7LnuB6Pk1+HQUUaKXnwP8E35qU3MHE3TR25
         p8BlDQKxTQr5z5iChqUn3qLqj5pypL2iEWRwbQH3x6Ij2nb0onA1KO7pqh2RIUL/cKd5
         PyjTlWed6Idkh4SisXaAFh20xqpiCl5yBcxum/dmV3NHC0un5112vatoGdzTPoRNPFDl
         hzv2duzfnR9j9F1y16bXU1NCTJ5lJjl94VSzY1DBYt96iE9a94tIcWFM3A9GiQcjMw6D
         +y2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zSKqzWg5/Og0nn61mWaIYweEhmqEAiqCy3h6c3h1LDw=;
        b=6E2C74Gq/I1wVE0+kNyF7fyMj3BSigACFkjpPt/FbGTjLILbKjTmoqhRijb9Wr3ITp
         7qexvCng4E2uwyBrP31W0UTxukVPm+IsvzNabwbHaTE04FQ9aTu8FZ6htDgOxKnoYcmY
         6FHiEOOQdyVZsTaHrQWaLeuP6UYJorvoFTp8Js+jlgYo8ynqmMufmbYVcu25G/dheNOt
         bF9xXk0yQ5/vHD+XGfgkSLRPnR8BctMvo8j0kFfvBiio5BO4/5TJbJOclTaW5ihXrQ9n
         yqx3SkVautGHmlWZLZ6A1iZQudQSrnpvU2/au3fRia1U1Z/I/lYuVN6lJZB56Mcu+IqR
         pxoQ==
X-Gm-Message-State: AOAM532nmwdZPjUJsJyoenxOcYgwo0fkQqzNYa4GGLNYwvn601KWhIZP
        m8ZYkhYhvyyfPN1uhY3pxT+rO/DyfYg=
X-Google-Smtp-Source: ABdhPJzNNYWvlHb1C6y/uoORLWW/ny3J0YSkQWrtS51B91WBhSmS5nQOzHGT0PcBL4BHtc4YsigFQA==
X-Received: by 2002:a05:600c:a0a:b0:350:564b:d55e with SMTP id z10-20020a05600c0a0a00b00350564bd55emr5003853wmp.124.1647972014624;
        Tue, 22 Mar 2022 11:00:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f9-20020a05600c154900b0038cb98076d6sm1949860wmg.10.2022.03.22.11.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 11:00:12 -0700 (PDT)
Message-Id: <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
References: <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Mar 2022 17:59:41 +0000
Subject: [PATCH v7 00/29] Builtin FSMonitor Part 2
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tao Klerks <tao@klerks.biz>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is V7 of Part 2 of my builtin FSmonitor series. This version squashes
in the fixups from Part 2.5 and any other last minute suggestions. I'll send
an updated version of Part 3 that builds upon this version.

Here is a range-diff from V6 to V7 relative to 715d08a9e5 (The eighth batch,
2022-02-25). Changes since V6 can be summarized as: (1) Adding/removing
"_()" on die() and error() messages. (2) Splitting GCC-specific declarations
for MacOS FSEvents into a separate header file. (3) Enhancing the
"start_daemon()" function in t7527 to take keyword args and reduce some code
duplication in unit tests. (4) Fixing "&&" chains in the tests. (5) Other
minor style cleanups.

$ git range-diff eight..builtin-fsmonitor-part2-v6 eight..builtin-fsmonitor-part2
 1:  10a34082fc =  1:  e98373f997 fsmonitor: enhance existing comments, clarify trivial response handling
 2:  e1c946af2c !  2:  ab68b94417 fsmonitor-ipc: create client routines for git-fsmonitor--daemon
    @@ fsmonitor-ipc.c (new)
     +    state = ipc_client_try_connect(fsmonitor_ipc__get_path(), &options,
     +                       &connection);
     +    if (state != IPC_STATE__LISTENING) {
    -+        die("fsmonitor--daemon is not running");
    ++        die(_("fsmonitor--daemon is not running"));
     +        return -1;
     +    }
     +
    @@ fsmonitor-ipc.c (new)
     +    ipc_client_close_connection(connection);
     +
     +    if (ret == -1) {
    -+        die("could not send '%s' command to fsmonitor--daemon", c);
    ++        die(_("could not send '%s' command to fsmonitor--daemon"), c);
     +        return -1;
     +    }
     +
 3:  ae622a517c !  3:  e04c7301f2 fsmonitor: config settings are repository-specific
    @@ fsmonitor-settings.c (new)
     +        return;
     +
     +    CALLOC_ARRAY(s, 1);
    ++    s->mode = FSMONITOR_MODE_DISABLED;
     +
     +    r->settings.fsmonitor = s;
     +
    -+    fsm_settings__set_disabled(r);
    -+
     +    /*
     +     * Overload the existing "core.fsmonitor" config setting (which
     +     * has historically been either unset or a hook pathname) to
 4:  55974867da =  4:  ea02ba25d8 fsmonitor: use IPC to query the builtin FSMonitor daemon
 5:  ce42d5bbaf =  5:  6ab7db9cb7 fsmonitor: document builtin fsmonitor
 6:  9ce938c69b =  6:  0ce8ae3f2c fsmonitor--daemon: add a built-in fsmonitor daemon
 7:  3bd7e6a051 =  7:  4624ce2fa4 fsmonitor--daemon: implement 'stop' and 'status' commands
 8:  92d3e54da7 =  8:  a29fe7266a compat/fsmonitor/fsm-listen-win32: stub in backend for Windows
 9:  f121922127 =  9:  2f8a42fdb9 compat/fsmonitor/fsm-listen-darwin: stub in backend for Darwin
10:  a3f94627cf ! 10:  f07800690e fsmonitor--daemon: implement 'run' command
    @@ builtin/fsmonitor--daemon.c: static int do_as_client__status(void)
     +     * common error case.
     +     */
     +    if (fsmonitor_ipc__get_state() == IPC_STATE__LISTENING)
    -+        die("fsmonitor--daemon is already running '%s'",
    ++        die(_("fsmonitor--daemon is already running '%s'"),
     +            the_repository->worktree);
     +
     +    if (fsmonitor__announce_startup) {
11:  8de40b0fe8 ! 11:  a6a39a3306 fsmonitor--daemon: implement 'start' command
    @@ builtin/fsmonitor--daemon.c: static int try_to_run_foreground_daemon(void)
     +     * immediately exited).
     +     */
     +    if (fsmonitor_ipc__get_state() == IPC_STATE__LISTENING)
    -+        die("fsmonitor--daemon is already running '%s'",
    ++        die(_("fsmonitor--daemon is already running '%s'"),
     +            the_repository->worktree);
     +
     +    if (fsmonitor__announce_startup) {
    @@ builtin/fsmonitor--daemon.c: static int try_to_run_foreground_daemon(void)
     +    default:
     +    case SBGR_ERROR:
     +    case SBGR_CB_ERROR:
    -+        return error("daemon failed to start");
    ++        return error(_("daemon failed to start"));
     +
     +    case SBGR_TIMEOUT:
    -+        return error("daemon not online yet");
    ++        return error(_("daemon not online yet"));
     +
     +    case SBGR_DIED:
    -+        return error("daemon terminated");
    ++        return error(_("daemon terminated"));
     +    }
     +}
     +
12:  e5d419b1ea = 12:  d62e338d00 fsmonitor--daemon: add pathname classification
13:  c2f3668a86 = 13:  53e06b4ae5 fsmonitor--daemon: define token-ids
14:  bd492d13fb = 14:  39f43fabe0 fsmonitor--daemon: create token-based changed path cache
15:  6b5b3d0822 ! 15:  239558e34f compat/fsmonitor/fsm-listen-win32: implement FSMonitor backend on Windows
    @@ compat/fsmonitor/fsm-listen-win32.c
     +        if (len > 0)
     +            goto normalize;
     +        if (GetLastError() != ERROR_INSUFFICIENT_BUFFER) {
    -+            error("[GLE %ld] could not convert path to UTF-8: '%.*ls'",
    ++            error(_("[GLE %ld] could not convert path to UTF-8: '%.*ls'"),
     +                  GetLastError(),
     +                  (int)(info->FileNameLength / sizeof(WCHAR)),
     +                  info->FileName);
    @@ compat/fsmonitor/fsm-listen-win32.c
     +    if (watch->is_active)
     +        return 0;
     +
    -+    error("ReadDirectoryChangedW failed on '%s' [GLE %ld]",
    ++    error(_("ReadDirectoryChangedW failed on '%s' [GLE %ld]"),
     +          watch->path.buf, GetLastError());
     +    return -1;
     +}
    @@ compat/fsmonitor/fsm-listen-win32.c
     +     * sure it is worth it.
     +     */
     +
    -+    error("GetOverlappedResult failed on '%s' [GLE %ld]",
    ++    error(_("GetOverlappedResult failed on '%s' [GLE %ld]"),
     +          watch->path.buf, gle);
     +    return -1;
     +}
16:  cdef9730b3 ! 16:  14b775e9d8 compat/fsmonitor/fsm-listen-darwin: add MacOS header files for FSEvent
    @@ Commit message
         Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
    - ## compat/fsmonitor/fsm-listen-darwin.c ##
    + ## compat/fsmonitor/fsm-darwin-gcc.h (new) ##
     @@
    ++#ifndef FSM_DARWIN_GCC_H
    ++#define FSM_DARWIN_GCC_H
    ++
     +#ifndef __clang__
     +/*
     + * It is possible to #include CoreFoundation/CoreFoundation.h when compiling
    @@ compat/fsmonitor/fsm-listen-darwin.c
     +void FSEventStreamStop(FSEventStreamRef stream);
     +void FSEventStreamInvalidate(FSEventStreamRef stream);
     +void FSEventStreamRelease(FSEventStreamRef stream);
    ++
    ++#endif /* !clang */
    ++#endif /* FSM_DARWIN_GCC_H */
    +
    + ## compat/fsmonitor/fsm-listen-darwin.c ##
    +@@
    ++#ifndef __clang__
    ++#include "fsm-darwin-gcc.h"
     +#else
    -+/*
    -+ * Let Apple's headers declare `isalnum()` first, before
    -+ * Git's headers override it via a constant
    -+ */
    -+#include <string.h>
     +#include <CoreFoundation/CoreFoundation.h>
     +#include <CoreServices/CoreServices.h>
    ++
    ++#ifndef AVAILABLE_MAC_OS_X_VERSION_10_13_AND_LATER
    ++/*
    ++ * This enum value was added in 10.13 to:
    ++ *
    ++ * /Applications/Xcode.app/Contents/Developer/Platforms/ \
    ++ *    MacOSX.platform/Developer/SDKs/MacOSX.sdk/System/ \
    ++ *    Library/Frameworks/CoreServices.framework/Frameworks/ \
    ++ *    FSEvents.framework/Versions/Current/Headers/FSEvents.h
    ++ *
    ++ * If we're compiling against an older SDK, this symbol won't be
    ++ * present.  Silently define it here so that we don't have to ifdef
    ++ * the logging or masking below.  This should be harmless since older
    ++ * versions of macOS won't ever emit this FS event anyway.
    ++ */
    ++#define kFSEventStreamEventFlagItemCloned         0x00400000
    ++#endif
     +#endif
     +
      #include "cache.h"
17:  aabfebd3a4 ! 17:  55bd7aee06 compat/fsmonitor/fsm-listen-darwin: implement FSEvent listener on MacOS
    @@ Commit message
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## compat/fsmonitor/fsm-listen-darwin.c ##
    -@@ compat/fsmonitor/fsm-listen-darwin.c: void FSEventStreamRelease(FSEventStreamRef stream);
    +@@
      #include "cache.h"
      #include "fsmonitor.h"
      #include "fsm-listen.h"
    @@ compat/fsmonitor/fsm-listen-darwin.c: void FSEventStreamRelease(FSEventStreamRef
     +    return 0;
     +
     +failed:
    -+    error("Unable to create FSEventStream.");
    ++    error(_("Unable to create FSEventStream."));
     +
     +    FREE_AND_NULL(state->backend_data);
          return -1;
    @@ compat/fsmonitor/fsm-listen-darwin.c: void FSEventStreamRelease(FSEventStreamRef
     +    data->stream_scheduled = 1;
     +
     +    if (!FSEventStreamStart(data->stream)) {
    -+        error("Failed to start the FSEventStream");
    ++        error(_("Failed to start the FSEventStream"));
     +        goto force_error_stop_without_loop;
     +    }
     +    data->stream_started = 1;
18:  0896e72e2b = 18:  1f4b5209bf fsmonitor--daemon: implement handle_client callback
19:  bc240a9e66 ! 19:  8cf62c9fc6 help: include fsmonitor--daemon feature flag in version info
    @@ t/test-lib.sh: test_lazy_prereq SHA1 '
     +# Does this platform support `git fsmonitor--daemon`
     +#
     +test_lazy_prereq FSMONITOR_DAEMON '
    -+    git version --build-options | grep "feature:" | grep "fsmonitor--daemon"
    ++    git version --build-options >output &&
    ++    grep "feature: fsmonitor--daemon" output
     +'
20:  2b563c240e ! 20:  1bd74a8159 t/helper/fsmonitor-client: create IPC client to talk to FSMonitor Daemon
    @@ t/helper/test-fsmonitor-client.c (new)
     +
     +    ret = fsmonitor_ipc__send_query(token, &answer);
     +    if (ret < 0)
    -+        die(_("could not query fsmonitor--daemon"));
    ++        die("could not query fsmonitor--daemon");
     +
     +    write_in_full(1, answer.buf, answer.len);
     +    strbuf_release(&answer);
    @@ t/helper/test-fsmonitor-client.c (new)
     +    const char *token = NULL;
     +
     +    const char * const fsmonitor_client_usage[] = {
    -+        N_("test-helper fsmonitor-client query [<token>]"),
    -+        N_("test-helper fsmonitor-client flush"),
    ++        "test-tool fsmonitor-client query [<token>]",
    ++        "test-tool fsmonitor-client flush",
     +        NULL,
     +    };
     +
     +    struct option options[] = {
    -+        OPT_STRING(0, "token", &token, N_("token"),
    -+               N_("command token to send to the server")),
    ++        OPT_STRING(0, "token", &token, "token",
    ++               "command token to send to the server"),
     +        OPT_END()
     +    };
     +
    -+    if (argc < 2)
    -+        usage_with_options(fsmonitor_client_usage, options);
    ++    argc = parse_options(argc, argv, NULL, options, fsmonitor_client_usage, 0);
     +
    -+    if (argc == 2 && !strcmp(argv[1], "-h"))
    ++    if (argc != 1)
     +        usage_with_options(fsmonitor_client_usage, options);
     +
    -+    subcmd = argv[1];
    -+    argv--;
    -+    argc++;
    -+
    -+    argc = parse_options(argc, argv, NULL, options, fsmonitor_client_usage, 0);
    ++    subcmd = argv[0];
     +
     +    setup_git_directory();
     +
21:  db8809da08 ! 21:  4a920d0b54 t7527: create test for fsmonitor--daemon
    @@ t/t7527-builtin-fsmonitor.sh (new)
     +fi
     +
     +stop_daemon_delete_repo () {
    -+    r=$1
    -+    git -C $r fsmonitor--daemon stop >/dev/null 2>/dev/null
    ++    r=$1 &&
    ++    test_might_fail git -C $r fsmonitor--daemon stop &&
     +    rm -rf $1
    -+    return 0
     +}
     +
     +start_daemon () {
    -+    case "$#" in
    -+        1) r="-C $1";;
    -+        *) r="";
    -+    esac
    ++    r= &&
    ++    tf= &&
    ++    t2= &&
    ++    tk= &&
    ++
    ++    while test "$#" -ne 0
    ++    do
    ++        case "$1" in
    ++        -C)
    ++            shift;
    ++            test "$#" -ne 0 || BUG "error: -C requires arg"
    ++            r="-C $1"
    ++            shift
    ++            ;;
    ++        -tf)
    ++            shift;
    ++            test "$#" -ne 0 || BUG "error: -tf requires arg"
    ++            tf="$1"
    ++            shift
    ++            ;;
    ++        -t2)
    ++            shift;
    ++            test "$#" -ne 0 || BUG "error: -t2 requires arg"
    ++            t2="$1"
    ++            shift
    ++            ;;
    ++        -tk)
    ++            shift;
    ++            test "$#" -ne 0 || BUG "error: -tk requires arg"
    ++            tk="$1"
    ++            shift
    ++            ;;
    ++        *)
    ++            BUG "error: unknown option: '$1'"
    ++            ;;
    ++        esac
    ++    done &&
     +
    -+    git $r fsmonitor--daemon start || return $?
    -+    git $r fsmonitor--daemon status || return $?
    -+
    -+    return 0
    ++    (
    ++        if test -n "$tf"
    ++        then
    ++            GIT_TRACE_FSMONITOR="$tf"
    ++            export GIT_TRACE_FSMONITOR
    ++        fi &&
    ++
    ++        if test -n "$t2"
    ++        then
    ++            GIT_TRACE2_PERF="$t2"
    ++            export GIT_TRACE2_PERF
    ++        fi &&
    ++
    ++        if test -n "$tk"
    ++        then
    ++            GIT_TEST_FSMONITOR_TOKEN="$tk"
    ++            export GIT_TEST_FSMONITOR_TOKEN
    ++        fi &&
    ++
    ++        git $r fsmonitor--daemon start &&
    ++        git $r fsmonitor--daemon status
    ++    )
     +}
     +
     +# Is a Trace2 data event present with the given catetory and key?
     +# We do not care what the value is.
     +#
     +have_t2_data_event () {
    -+    c=$1
    -+    k=$2
    ++    c=$1 &&
    ++    k=$2 &&
     +
     +    grep -e '"event":"data".*"category":"'"$c"'".*"key":"'"$k"'"'
     +}
    @@ t/t7527-builtin-fsmonitor.sh (new)
     +    test_when_finished "stop_daemon_delete_repo test_explicit" &&
     +
     +    git init test_explicit &&
    -+    start_daemon test_explicit &&
    ++    start_daemon -C test_explicit &&
     +
     +    git -C test_explicit fsmonitor--daemon stop &&
     +    test_must_fail git -C test_explicit fsmonitor--daemon status
    @@ t/t7527-builtin-fsmonitor.sh (new)
     +    # but this test case is only concerned with whether the daemon was
     +    # implicitly started.)
     +
    -+    GIT_TRACE2_EVENT="$(pwd)/.git/trace" \
    ++    GIT_TRACE2_EVENT="$PWD/.git/trace" \
     +        test-tool -C test_implicit fsmonitor-client query --token 0 >actual &&
     +    nul_to_q <actual >actual.filtered &&
     +    grep "builtin:" actual.filtered &&
    @@ t/t7527-builtin-fsmonitor.sh (new)
     +
     +    git init test_implicit_1 &&
     +
    -+    start_daemon test_implicit_1 &&
    ++    start_daemon -C test_implicit_1 &&
     +
     +    # deleting the .git directory will implicitly stop the daemon.
     +    rm -rf test_implicit_1/.git &&
    @@ t/t7527-builtin-fsmonitor.sh (new)
     +
     +    git init test_implicit_2 &&
     +
    -+    start_daemon test_implicit_2 &&
    ++    start_daemon -C test_implicit_2 &&
     +
     +    # renaming the .git directory will implicitly stop the daemon.
     +    mv test_implicit_2/.git test_implicit_2/.xxx &&
    @@ t/t7527-builtin-fsmonitor.sh (new)
     +
     +    git init test_multiple &&
     +
    -+    start_daemon test_multiple &&
    ++    start_daemon -C test_multiple &&
     +
     +    test_must_fail git -C test_multiple fsmonitor--daemon start 2>actual &&
     +    grep "fsmonitor--daemon is already running" actual &&
    @@ t/t7527-builtin-fsmonitor.sh (new)
     +# This is here in case something else fails first.
     +#
     +redundant_stop_daemon () {
    -+    git fsmonitor--daemon stop
    -+    return 0
    ++    test_might_fail git fsmonitor--daemon stop
     +}
     +
     +test_expect_success 'update-index implicitly starts daemon' '
    @@ t/t7527-builtin-fsmonitor.sh (new)
     +
     +    test_must_fail git fsmonitor--daemon status &&
     +
    -+    GIT_TRACE2_EVENT="$(pwd)/.git/trace_implicit_1" \
    ++    GIT_TRACE2_EVENT="$PWD/.git/trace_implicit_1" \
     +        git update-index --fsmonitor &&
     +
     +    git fsmonitor--daemon status &&
    @@ t/t7527-builtin-fsmonitor.sh (new)
     +
     +    test_must_fail git fsmonitor--daemon status &&
     +
    -+    GIT_TRACE2_EVENT="$(pwd)/.git/trace_implicit_2" \
    ++    GIT_TRACE2_EVENT="$PWD/.git/trace_implicit_2" \
     +        git status >actual &&
     +
     +    git fsmonitor--daemon status &&
    @@ t/t7527-builtin-fsmonitor.sh (new)
     +'
     +
     +edit_files () {
    -+    echo 1 >modified
    -+    echo 2 >dir1/modified
    -+    echo 3 >dir2/modified
    ++    echo 1 >modified &&
    ++    echo 2 >dir1/modified &&
    ++    echo 3 >dir2/modified &&
     +    >dir1/untracked
     +}
     +
     +delete_files () {
    -+    rm -f delete
    -+    rm -f dir1/delete
    ++    rm -f delete &&
    ++    rm -f dir1/delete &&
     +    rm -f dir2/delete
     +}
     +
     +create_files () {
    -+    echo 1 >new
    -+    echo 2 >dir1/new
    ++    echo 1 >new &&
    ++    echo 2 >dir1/new &&
     +    echo 3 >dir2/new
     +}
     +
     +rename_files () {
    -+    mv rename renamed
    -+    mv dir1/rename dir1/renamed
    ++    mv rename renamed &&
    ++    mv dir1/rename dir1/renamed &&
     +    mv dir2/rename dir2/renamed
     +}
     +
     +file_to_directory () {
    -+    rm -f delete
    -+    mkdir delete
    ++    rm -f delete &&
    ++    mkdir delete &&
     +    echo 1 >delete/new
     +}
     +
     +directory_to_file () {
    -+    rm -rf dir1
    ++    rm -rf dir1 &&
     +    echo 1 >dir1
     +}
     +
    -+verify_status () {
    -+    git status >actual &&
    -+    GIT_INDEX_FILE=.git/fresh-index git read-tree master &&
    -+    GIT_INDEX_FILE=.git/fresh-index git -c core.fsmonitor=false status >expect &&
    -+    test_cmp expect actual &&
    -+    echo HELLO AFTER &&
    -+    cat .git/trace &&
    -+    echo HELLO AFTER
    -+}
    -+
     +# The next few test cases confirm that our fsmonitor daemon sees each type
     +# of OS filesystem notification that we care about.  At this layer we just
     +# ensure we are getting the OS notifications and do not try to confirm what
    @@ t/t7527-builtin-fsmonitor.sh (new)
     +# daemon) because these commands might implicitly restart the daemon.
     +
     +clean_up_repo_and_stop_daemon () {
    -+    git reset --hard HEAD
    -+    git clean -fd
    -+    git fsmonitor--daemon stop
    ++    git reset --hard HEAD &&
    ++    git clean -fd &&
    ++    test_might_fail git fsmonitor--daemon stop &&
     +    rm -f .git/trace
     +}
     +
     +test_expect_success 'edit some files' '
     +    test_when_finished clean_up_repo_and_stop_daemon &&
     +
    -+    (
    -+        GIT_TRACE_FSMONITOR="$(pwd)/.git/trace" &&
    -+        export GIT_TRACE_FSMONITOR &&
    -+
    -+        start_daemon
    -+    ) &&
    ++    start_daemon -tf "$PWD/.git/trace" &&
     +
     +    edit_files &&
     +
    -+    test-tool fsmonitor-client query --token 0 >/dev/null 2>&1 &&
    ++    test-tool fsmonitor-client query --token 0 &&
     +
     +    grep "^event: dir1/modified$"  .git/trace &&
     +    grep "^event: dir2/modified$"  .git/trace &&
    @@ t/t7527-builtin-fsmonitor.sh (new)
     +test_expect_success 'create some files' '
     +    test_when_finished clean_up_repo_and_stop_daemon &&
     +
    -+    (
    -+        GIT_TRACE_FSMONITOR="$(pwd)/.git/trace" &&
    -+        export GIT_TRACE_FSMONITOR &&
    -+
    -+        start_daemon
    -+    ) &&
    ++    start_daemon -tf "$PWD/.git/trace" &&
     +
     +    create_files &&
     +
    -+    test-tool fsmonitor-client query --token 0 >/dev/null 2>&1 &&
    ++    test-tool fsmonitor-client query --token 0 &&
     +
     +    grep "^event: dir1/new$" .git/trace &&
     +    grep "^event: dir2/new$" .git/trace &&
    @@ t/t7527-builtin-fsmonitor.sh (new)
     +test_expect_success 'delete some files' '
     +    test_when_finished clean_up_repo_and_stop_daemon &&
     +
    -+    (
    -+        GIT_TRACE_FSMONITOR="$(pwd)/.git/trace" &&
    -+        export GIT_TRACE_FSMONITOR &&
    -+
    -+        start_daemon
    -+    ) &&
    ++    start_daemon -tf "$PWD/.git/trace" &&
     +
     +    delete_files &&
     +
    -+    test-tool fsmonitor-client query --token 0 >/dev/null 2>&1 &&
    ++    test-tool fsmonitor-client query --token 0 &&
     +
     +    grep "^event: dir1/delete$" .git/trace &&
     +    grep "^event: dir2/delete$" .git/trace &&
    @@ t/t7527-builtin-fsmonitor.sh (new)
     +test_expect_success 'rename some files' '
     +    test_when_finished clean_up_repo_and_stop_daemon &&
     +
    -+    (
    -+        GIT_TRACE_FSMONITOR="$(pwd)/.git/trace" &&
    -+        export GIT_TRACE_FSMONITOR &&
    -+
    -+        start_daemon
    -+    ) &&
    ++    start_daemon -tf "$PWD/.git/trace" &&
     +
     +    rename_files &&
     +
    -+    test-tool fsmonitor-client query --token 0 >/dev/null 2>&1 &&
    ++    test-tool fsmonitor-client query --token 0 &&
     +
     +    grep "^event: dir1/rename$"  .git/trace &&
     +    grep "^event: dir2/rename$"  .git/trace &&
    @@ t/t7527-builtin-fsmonitor.sh (new)
     +test_expect_success 'rename directory' '
     +    test_when_finished clean_up_repo_and_stop_daemon &&
     +
    -+    (
    -+        GIT_TRACE_FSMONITOR="$(pwd)/.git/trace" &&
    -+        export GIT_TRACE_FSMONITOR &&
    -+
    -+        start_daemon
    -+    ) &&
    ++    start_daemon -tf "$PWD/.git/trace" &&
     +
     +    mv dirtorename dirrenamed &&
     +
    -+    test-tool fsmonitor-client query --token 0 >/dev/null 2>&1 &&
    ++    test-tool fsmonitor-client query --token 0 &&
     +
     +    grep "^event: dirtorename/*$" .git/trace &&
     +    grep "^event: dirrenamed/*$"  .git/trace
    @@ t/t7527-builtin-fsmonitor.sh (new)
     +test_expect_success 'file changes to directory' '
     +    test_when_finished clean_up_repo_and_stop_daemon &&
     +
    -+    (
    -+        GIT_TRACE_FSMONITOR="$(pwd)/.git/trace" &&
    -+        export GIT_TRACE_FSMONITOR &&
    -+
    -+        start_daemon
    -+    ) &&
    ++    start_daemon -tf "$PWD/.git/trace" &&
     +
     +    file_to_directory &&
     +
    -+    test-tool fsmonitor-client query --token 0 >/dev/null 2>&1 &&
    ++    test-tool fsmonitor-client query --token 0 &&
     +
     +    grep "^event: delete$"     .git/trace &&
     +    grep "^event: delete/new$" .git/trace
    @@ t/t7527-builtin-fsmonitor.sh (new)
     +test_expect_success 'directory changes to a file' '
     +    test_when_finished clean_up_repo_and_stop_daemon &&
     +
    -+    (
    -+        GIT_TRACE_FSMONITOR="$(pwd)/.git/trace" &&
    -+        export GIT_TRACE_FSMONITOR &&
    -+
    -+        start_daemon
    -+    ) &&
    ++    start_daemon -tf "$PWD/.git/trace" &&
     +
     +    directory_to_file &&
     +
    -+    test-tool fsmonitor-client query --token 0 >/dev/null 2>&1 &&
    ++    test-tool fsmonitor-client query --token 0 &&
     +
     +    grep "^event: dir1$" .git/trace
     +'
    @@ t/t7527-builtin-fsmonitor.sh (new)
     +
     +    git init test_flush &&
     +
    -+    (
    -+        GIT_TEST_FSMONITOR_TOKEN=true &&
    -+        export GIT_TEST_FSMONITOR_TOKEN &&
    -+
    -+        GIT_TRACE_FSMONITOR="$(pwd)/.git/trace_daemon" &&
    -+        export GIT_TRACE_FSMONITOR &&
    -+
    -+        start_daemon test_flush
    -+    ) &&
    ++    start_daemon -C test_flush -tf "$PWD/.git/trace_daemon" -tk true &&
     +
     +    # The daemon should have an initial token with no events in _0 and
     +    # then a few (probably platform-specific number of) events in _1.
    @@ t/t7527-builtin-fsmonitor.sh (new)
     +    test-tool -C test_flush fsmonitor-client query --token "builtin:test_00000001:0" >actual_0 &&
     +    nul_to_q <actual_0 >actual_q0 &&
     +
    -+    touch test_flush/file_1 &&
    -+    touch test_flush/file_2 &&
    ++    >test_flush/file_1 &&
    ++    >test_flush/file_2 &&
     +
     +    test-tool -C test_flush fsmonitor-client query --token "builtin:test_00000001:0" >actual_1 &&
     +    nul_to_q <actual_1 >actual_q1 &&
    @@ t/t7527-builtin-fsmonitor.sh (new)
     +
     +    grep "^builtin:test_00000002:0Q$" actual_q2 &&
     +
    -+    touch test_flush/file_3 &&
    ++    >test_flush/file_3 &&
     +
     +    test-tool -C test_flush fsmonitor-client query --token "builtin:test_00000002:0" >actual_3 &&
     +    nul_to_q <actual_3 >actual_q3 &&
    @@ t/t7527-builtin-fsmonitor.sh (new)
     +test_expect_success 'worktree with .git file' '
     +    git -C wt-base worktree add ../wt-secondary &&
     +
    -+    (
    -+        GIT_TRACE2_PERF="$(pwd)/trace2_wt_secondary" &&
    -+        export GIT_TRACE2_PERF &&
    -+
    -+        GIT_TRACE_FSMONITOR="$(pwd)/trace_wt_secondary" &&
    -+        export GIT_TRACE_FSMONITOR &&
    -+
    -+        start_daemon wt-secondary
    -+    ) &&
    ++    start_daemon -C wt-secondary \
    ++        -tf "$PWD/trace_wt_secondary" \
    ++        -t2 "$PWD/trace2_wt_secondary" &&
     +
     +    git -C wt-secondary fsmonitor--daemon stop &&
     +    test_must_fail git -C wt-secondary fsmonitor--daemon status
22:  15bd5aaff3 = 22:  c925a9a745 t/perf: avoid copying builtin fsmonitor files into test repo
23:  4cb97918d2 = 23:  5b3381c223 t/helper/test-chmtime: skip directories on Windows
24:  a70748b464 ! 24:  803a540cc0 t/perf/p7519: speed up test on Windows
    @@ t/perf/p7519-fsmonitor.sh: test_fsmonitor_suite() {
                  head -100000 | \
                  grep -v \" | \
     -            sed '\''s/\(.\)/\\\1/g'\'' | \
    -+            egrep -v " ." | \
    ++            grep -v " ." | \
                  xargs test-tool chmtime -300 &&
              git status
          '
25:  b0c9c9c7a4 ! 25:  d5ca2df31c t/perf/p7519: add fsmonitor--daemon test cases
    @@ Commit message
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## t/perf/p7519-fsmonitor.sh ##
    +@@ t/perf/p7519-fsmonitor.sh: test_expect_success "one time repo setup" '
    +     fi
    + '
    + 
    +-setup_for_fsmonitor () {
    ++setup_for_fsmonitor_hook () {
    +     # set INTEGRATION_SCRIPT depending on the environment
    +     if test -n "$INTEGRATION_PATH"
    +     then
     @@ t/perf/p7519-fsmonitor.sh: test_perf_w_drop_caches () {
      }
      
    @@ t/perf/p7519-fsmonitor.sh: test_perf_w_drop_caches () {
     +    if test -n "$USE_FSMONITOR_DAEMON"
     +    then
     +        DESC="builtin fsmonitor--daemon"
    -+    elif test -n "$INTEGRATION_SCRIPT"; then
    ++    elif test -n "$INTEGRATION_SCRIPT"
    ++    then
              DESC="fsmonitor=$(basename $INTEGRATION_SCRIPT)"
          else
              DESC="fsmonitor=disabled"
    +@@ t/perf/p7519-fsmonitor.sh: test_fsmonitor_suite () {
    + trace_start fsmonitor-watchman
    + if test -n "$GIT_PERF_7519_FSMONITOR"; then
    +     for INTEGRATION_PATH in $GIT_PERF_7519_FSMONITOR; do
    +-        test_expect_success "setup for fsmonitor $INTEGRATION_PATH" 'setup_for_fsmonitor'
    ++        test_expect_success "setup for fsmonitor $INTEGRATION_PATH" 'setup_for_fsmonitor_hook'
    +         test_fsmonitor_suite
    +     done
    + else
    +-    test_expect_success "setup for fsmonitor" 'setup_for_fsmonitor'
    ++    test_expect_success "setup for fsmonitor hook" 'setup_for_fsmonitor_hook'
    +     test_fsmonitor_suite
    + fi
    + 
     @@ t/perf/p7519-fsmonitor.sh: test_expect_success "setup without fsmonitor" '
      test_fsmonitor_suite
      trace_stop
    @@ t/perf/p7519-fsmonitor.sh: test_expect_success "setup without fsmonitor" '
     +then
     +    USE_FSMONITOR_DAEMON=t
     +
    -+    trace_start fsmonitor--daemon--server
    -+    git fsmonitor--daemon start
    ++    test_expect_success "setup for builtin fsmonitor" '
    ++        trace_start fsmonitor--daemon--server &&
    ++        git fsmonitor--daemon start &&
     +
    -+    trace_start fsmonitor--daemon--client
    ++        trace_start fsmonitor--daemon--client &&
     +
    -+    git config core.fsmonitor true
    -+    git update-index --fsmonitor
    ++        git config core.fsmonitor true &&
    ++        git update-index --fsmonitor
    ++    '
     +
     +    test_fsmonitor_suite
     +
26:  64a5b74167 = 26:  42631259e8 fsmonitor--daemon: periodically truncate list of modified files
27:  5b06eb5d0e ! 27:  f256c3cbe8 fsmonitor--daemon: use a cookie file to sync with file system
    @@ builtin/fsmonitor--daemon.c: static int do_as_client__status(void)
      
     +enum fsmonitor_cookie_item_result {
     +    FCIR_ERROR = -1, /* could not create cookie file ? */
    -+    FCIR_INIT = 0,
    ++    FCIR_INIT,
     +    FCIR_SEEN,
     +    FCIR_ABORT,
     +};
     +
     +struct fsmonitor_cookie_item {
     +    struct hashmap_entry entry;
    -+    const char *name;
    ++    char *name;
     +    enum fsmonitor_cookie_item_result result;
     +};
     +
    @@ builtin/fsmonitor--daemon.c: static int do_as_client__status(void)
     +     * that the listener thread has seen it.
     +     */
     +    fd = open(cookie_pathname.buf, O_WRONLY | O_CREAT | O_EXCL, 0600);
    -+    if (fd >= 0) {
    -+        close(fd);
    -+        unlink(cookie_pathname.buf);
    -+
    -+        /*
    -+         * Technically, this is an infinite wait (well, unless another
    -+         * thread sends us an abort).  I'd like to change this to
    -+         * use `pthread_cond_timedwait()` and return an error/timeout
    -+         * and let the caller do the trivial response thing, but we
    -+         * don't have that routine in our thread-utils.
    -+         *
    -+         * After extensive beta testing I'm not really worried about
    -+         * this.  Also note that the above open() and unlink() calls
    -+         * will cause at least two FS events on that path, so the odds
    -+         * of getting stuck are pretty slim.
    -+         */
    -+        while (cookie->result == FCIR_INIT)
    -+            pthread_cond_wait(&state->cookies_cond,
    -+                      &state->main_lock);
    -+    } else {
    ++    if (fd < 0) {
     +        error_errno(_("could not create fsmonitor cookie '%s'"),
     +                cookie->name);
     +
     +        cookie->result = FCIR_ERROR;
    ++        goto done;
     +    }
     +
    ++    /*
    ++     * Technically, close() and unlink() can fail, but we don't
    ++     * care here.  We only created the file to trigger a watch
    ++     * event from the FS to know that when we're up to date.
    ++     */
    ++    close(fd);
    ++    unlink(cookie_pathname.buf);
    ++
    ++    /*
    ++     * Technically, this is an infinite wait (well, unless another
    ++     * thread sends us an abort).  I'd like to change this to
    ++     * use `pthread_cond_timedwait()` and return an error/timeout
    ++     * and let the caller do the trivial response thing, but we
    ++     * don't have that routine in our thread-utils.
    ++     *
    ++     * After extensive beta testing I'm not really worried about
    ++     * this.  Also note that the above open() and unlink() calls
    ++     * will cause at least two FS events on that path, so the odds
    ++     * of getting stuck are pretty slim.
    ++     */
    ++    while (cookie->result == FCIR_INIT)
    ++        pthread_cond_wait(&state->cookies_cond,
    ++                  &state->main_lock);
    ++
    ++done:
     +    hashmap_remove(&state->cookies, &cookie->entry, NULL);
     +
     +    result = cookie->result;
     +
    -+    free((char*)cookie->name);
    ++    free(cookie->name);
     +    free(cookie);
     +    strbuf_release(&cookie_pathname);
     +
28:  1fd5439de0 = 28:  08af8296f9 fsmonitor: force update index after large responses
29:  6fc1430285 ! 29:  e6cf84dc8e t7527: test status with untracked-cache and fsmonitor--daemon
    @@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'cleanup worktrees' '
     +}
     +
     +matrix_try () {
    -+    uc=$1
    -+    fsm=$2
    -+    fn=$3
    ++    uc=$1 &&
    ++    fsm=$2 &&
    ++    fn=$3 &&
     +
     +    test_expect_success "Matrix[uc:$uc][fsm:$fsm] $fn" '
     +        matrix_clean_up_repo &&
30:  b915b95cc2 <  -:  ---------- update-index: convert fsmonitor warnings to advise


Jeff Hostetler (29):
  fsmonitor: enhance existing comments, clarify trivial response
    handling
  fsmonitor-ipc: create client routines for git-fsmonitor--daemon
  fsmonitor: config settings are repository-specific
  fsmonitor: use IPC to query the builtin FSMonitor daemon
  fsmonitor: document builtin fsmonitor
  fsmonitor--daemon: add a built-in fsmonitor daemon
  fsmonitor--daemon: implement 'stop' and 'status' commands
  compat/fsmonitor/fsm-listen-win32: stub in backend for Windows
  compat/fsmonitor/fsm-listen-darwin: stub in backend for Darwin
  fsmonitor--daemon: implement 'run' command
  fsmonitor--daemon: implement 'start' command
  fsmonitor--daemon: add pathname classification
  fsmonitor--daemon: define token-ids
  fsmonitor--daemon: create token-based changed path cache
  compat/fsmonitor/fsm-listen-win32: implement FSMonitor backend on
    Windows
  compat/fsmonitor/fsm-listen-darwin: add MacOS header files for FSEvent
  compat/fsmonitor/fsm-listen-darwin: implement FSEvent listener on
    MacOS
  fsmonitor--daemon: implement handle_client callback
  help: include fsmonitor--daemon feature flag in version info
  t/helper/fsmonitor-client: create IPC client to talk to FSMonitor
    Daemon
  t7527: create test for fsmonitor--daemon
  t/perf: avoid copying builtin fsmonitor files into test repo
  t/helper/test-chmtime: skip directories on Windows
  t/perf/p7519: speed up test on Windows
  t/perf/p7519: add fsmonitor--daemon test cases
  fsmonitor--daemon: periodically truncate list of modified files
  fsmonitor--daemon: use a cookie file to sync with file system
  fsmonitor: force update index after large responses
  t7527: test status with untracked-cache and fsmonitor--daemon

 .gitignore                              |    1 +
 Documentation/config/core.txt           |   60 +-
 Documentation/git-fsmonitor--daemon.txt |   75 ++
 Documentation/git-update-index.txt      |    8 +-
 Makefile                                |   17 +
 builtin.h                               |    1 +
 builtin/fsmonitor--daemon.c             | 1480 +++++++++++++++++++++++
 builtin/update-index.c                  |    7 +-
 cache.h                                 |    1 -
 compat/fsmonitor/fsm-darwin-gcc.h       |   92 ++
 compat/fsmonitor/fsm-listen-darwin.c    |  427 +++++++
 compat/fsmonitor/fsm-listen-win32.c     |  586 +++++++++
 compat/fsmonitor/fsm-listen.h           |   49 +
 config.c                                |   14 -
 config.h                                |    1 -
 config.mak.uname                        |   20 +
 contrib/buildsystems/CMakeLists.txt     |   10 +
 environment.c                           |    1 -
 fsmonitor--daemon.h                     |  166 +++
 fsmonitor-ipc.c                         |  171 +++
 fsmonitor-ipc.h                         |   48 +
 fsmonitor-settings.c                    |  114 ++
 fsmonitor-settings.h                    |   21 +
 fsmonitor.c                             |  216 +++-
 fsmonitor.h                             |   15 +-
 git.c                                   |    1 +
 help.c                                  |    4 +
 repo-settings.c                         |    1 +
 repository.h                            |    3 +
 t/README                                |    4 +-
 t/helper/test-chmtime.c                 |   15 +
 t/helper/test-fsmonitor-client.c        |  116 ++
 t/helper/test-tool.c                    |    1 +
 t/helper/test-tool.h                    |    1 +
 t/perf/p7519-fsmonitor.sh               |   68 +-
 t/perf/perf-lib.sh                      |    2 +-
 t/t7527-builtin-fsmonitor.sh            |  594 +++++++++
 t/test-lib.sh                           |    7 +
 38 files changed, 4312 insertions(+), 106 deletions(-)
 create mode 100644 Documentation/git-fsmonitor--daemon.txt
 create mode 100644 builtin/fsmonitor--daemon.c
 create mode 100644 compat/fsmonitor/fsm-darwin-gcc.h
 create mode 100644 compat/fsmonitor/fsm-listen-darwin.c
 create mode 100644 compat/fsmonitor/fsm-listen-win32.c
 create mode 100644 compat/fsmonitor/fsm-listen.h
 create mode 100644 fsmonitor--daemon.h
 create mode 100644 fsmonitor-ipc.c
 create mode 100644 fsmonitor-ipc.h
 create mode 100644 fsmonitor-settings.c
 create mode 100644 fsmonitor-settings.h
 create mode 100644 t/helper/test-fsmonitor-client.c
 create mode 100755 t/t7527-builtin-fsmonitor.sh


base-commit: 715d08a9e51251ad8290b181b6ac3b9e1f9719d7
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1041%2Fjeffhostetler%2Fbuiltin-fsmonitor-part2-v7
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1041/jeffhostetler/builtin-fsmonitor-part2-v7
Pull-Request: https://github.com/gitgitgadget/git/pull/1041

Range-diff vs v6:

  1:  10a34082fcc =  1:  e98373f997f fsmonitor: enhance existing comments, clarify trivial response handling
  2:  e1c946af2c5 !  2:  ab68b944173 fsmonitor-ipc: create client routines for git-fsmonitor--daemon
     @@ fsmonitor-ipc.c (new)
      +	state = ipc_client_try_connect(fsmonitor_ipc__get_path(), &options,
      +				       &connection);
      +	if (state != IPC_STATE__LISTENING) {
     -+		die("fsmonitor--daemon is not running");
     ++		die(_("fsmonitor--daemon is not running"));
      +		return -1;
      +	}
      +
     @@ fsmonitor-ipc.c (new)
      +	ipc_client_close_connection(connection);
      +
      +	if (ret == -1) {
     -+		die("could not send '%s' command to fsmonitor--daemon", c);
     ++		die(_("could not send '%s' command to fsmonitor--daemon"), c);
      +		return -1;
      +	}
      +
  3:  ae622a517cf !  3:  e04c7301f24 fsmonitor: config settings are repository-specific
     @@ fsmonitor-settings.c (new)
      +		return;
      +
      +	CALLOC_ARRAY(s, 1);
     ++	s->mode = FSMONITOR_MODE_DISABLED;
      +
      +	r->settings.fsmonitor = s;
      +
     -+	fsm_settings__set_disabled(r);
     -+
      +	/*
      +	 * Overload the existing "core.fsmonitor" config setting (which
      +	 * has historically been either unset or a hook pathname) to
  4:  55974867da5 =  4:  ea02ba25d8f fsmonitor: use IPC to query the builtin FSMonitor daemon
  5:  ce42d5bbaf6 =  5:  6ab7db9cb76 fsmonitor: document builtin fsmonitor
  6:  9ce938c69b5 =  6:  0ce8ae3f2cf fsmonitor--daemon: add a built-in fsmonitor daemon
  7:  3bd7e6a051e =  7:  4624ce2fa47 fsmonitor--daemon: implement 'stop' and 'status' commands
  8:  92d3e54da7f =  8:  a29fe7266a4 compat/fsmonitor/fsm-listen-win32: stub in backend for Windows
  9:  f1219221270 =  9:  2f8a42fdb93 compat/fsmonitor/fsm-listen-darwin: stub in backend for Darwin
 10:  a3f94627cf6 ! 10:  f07800690ee fsmonitor--daemon: implement 'run' command
     @@ builtin/fsmonitor--daemon.c: static int do_as_client__status(void)
      +	 * common error case.
      +	 */
      +	if (fsmonitor_ipc__get_state() == IPC_STATE__LISTENING)
     -+		die("fsmonitor--daemon is already running '%s'",
     ++		die(_("fsmonitor--daemon is already running '%s'"),
      +		    the_repository->worktree);
      +
      +	if (fsmonitor__announce_startup) {
 11:  8de40b0fe8b ! 11:  a6a39a3306d fsmonitor--daemon: implement 'start' command
     @@ builtin/fsmonitor--daemon.c: static int try_to_run_foreground_daemon(void)
      +	 * immediately exited).
      +	 */
      +	if (fsmonitor_ipc__get_state() == IPC_STATE__LISTENING)
     -+		die("fsmonitor--daemon is already running '%s'",
     ++		die(_("fsmonitor--daemon is already running '%s'"),
      +		    the_repository->worktree);
      +
      +	if (fsmonitor__announce_startup) {
     @@ builtin/fsmonitor--daemon.c: static int try_to_run_foreground_daemon(void)
      +	default:
      +	case SBGR_ERROR:
      +	case SBGR_CB_ERROR:
     -+		return error("daemon failed to start");
     ++		return error(_("daemon failed to start"));
      +
      +	case SBGR_TIMEOUT:
     -+		return error("daemon not online yet");
     ++		return error(_("daemon not online yet"));
      +
      +	case SBGR_DIED:
     -+		return error("daemon terminated");
     ++		return error(_("daemon terminated"));
      +	}
      +}
      +
 12:  e5d419b1ea0 = 12:  d62e338d008 fsmonitor--daemon: add pathname classification
 13:  c2f3668a866 = 13:  53e06b4ae5d fsmonitor--daemon: define token-ids
 14:  bd492d13fb1 = 14:  39f43fabe02 fsmonitor--daemon: create token-based changed path cache
 15:  6b5b3d08227 ! 15:  239558e34ff compat/fsmonitor/fsm-listen-win32: implement FSMonitor backend on Windows
     @@ compat/fsmonitor/fsm-listen-win32.c
      +		if (len > 0)
      +			goto normalize;
      +		if (GetLastError() != ERROR_INSUFFICIENT_BUFFER) {
     -+			error("[GLE %ld] could not convert path to UTF-8: '%.*ls'",
     ++			error(_("[GLE %ld] could not convert path to UTF-8: '%.*ls'"),
      +			      GetLastError(),
      +			      (int)(info->FileNameLength / sizeof(WCHAR)),
      +			      info->FileName);
     @@ compat/fsmonitor/fsm-listen-win32.c
      +	if (watch->is_active)
      +		return 0;
      +
     -+	error("ReadDirectoryChangedW failed on '%s' [GLE %ld]",
     ++	error(_("ReadDirectoryChangedW failed on '%s' [GLE %ld]"),
      +	      watch->path.buf, GetLastError());
      +	return -1;
      +}
     @@ compat/fsmonitor/fsm-listen-win32.c
      +	 * sure it is worth it.
      +	 */
      +
     -+	error("GetOverlappedResult failed on '%s' [GLE %ld]",
     ++	error(_("GetOverlappedResult failed on '%s' [GLE %ld]"),
      +	      watch->path.buf, gle);
      +	return -1;
      +}
 16:  cdef9730b3f ! 16:  14b775e9d8b compat/fsmonitor/fsm-listen-darwin: add MacOS header files for FSEvent
     @@ Commit message
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
          Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
     - ## compat/fsmonitor/fsm-listen-darwin.c ##
     + ## compat/fsmonitor/fsm-darwin-gcc.h (new) ##
      @@
     ++#ifndef FSM_DARWIN_GCC_H
     ++#define FSM_DARWIN_GCC_H
     ++
      +#ifndef __clang__
      +/*
      + * It is possible to #include CoreFoundation/CoreFoundation.h when compiling
     @@ compat/fsmonitor/fsm-listen-darwin.c
      +void FSEventStreamStop(FSEventStreamRef stream);
      +void FSEventStreamInvalidate(FSEventStreamRef stream);
      +void FSEventStreamRelease(FSEventStreamRef stream);
     ++
     ++#endif /* !clang */
     ++#endif /* FSM_DARWIN_GCC_H */
     +
     + ## compat/fsmonitor/fsm-listen-darwin.c ##
     +@@
     ++#ifndef __clang__
     ++#include "fsm-darwin-gcc.h"
      +#else
     -+/*
     -+ * Let Apple's headers declare `isalnum()` first, before
     -+ * Git's headers override it via a constant
     -+ */
     -+#include <string.h>
      +#include <CoreFoundation/CoreFoundation.h>
      +#include <CoreServices/CoreServices.h>
     ++
     ++#ifndef AVAILABLE_MAC_OS_X_VERSION_10_13_AND_LATER
     ++/*
     ++ * This enum value was added in 10.13 to:
     ++ *
     ++ * /Applications/Xcode.app/Contents/Developer/Platforms/ \
     ++ *    MacOSX.platform/Developer/SDKs/MacOSX.sdk/System/ \
     ++ *    Library/Frameworks/CoreServices.framework/Frameworks/ \
     ++ *    FSEvents.framework/Versions/Current/Headers/FSEvents.h
     ++ *
     ++ * If we're compiling against an older SDK, this symbol won't be
     ++ * present.  Silently define it here so that we don't have to ifdef
     ++ * the logging or masking below.  This should be harmless since older
     ++ * versions of macOS won't ever emit this FS event anyway.
     ++ */
     ++#define kFSEventStreamEventFlagItemCloned         0x00400000
     ++#endif
      +#endif
      +
       #include "cache.h"
 17:  aabfebd3a41 ! 17:  55bd7aee06c compat/fsmonitor/fsm-listen-darwin: implement FSEvent listener on MacOS
     @@ Commit message
          Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       ## compat/fsmonitor/fsm-listen-darwin.c ##
     -@@ compat/fsmonitor/fsm-listen-darwin.c: void FSEventStreamRelease(FSEventStreamRef stream);
     +@@
       #include "cache.h"
       #include "fsmonitor.h"
       #include "fsm-listen.h"
     @@ compat/fsmonitor/fsm-listen-darwin.c: void FSEventStreamRelease(FSEventStreamRef
      +	return 0;
      +
      +failed:
     -+	error("Unable to create FSEventStream.");
     ++	error(_("Unable to create FSEventStream."));
      +
      +	FREE_AND_NULL(state->backend_data);
       	return -1;
     @@ compat/fsmonitor/fsm-listen-darwin.c: void FSEventStreamRelease(FSEventStreamRef
      +	data->stream_scheduled = 1;
      +
      +	if (!FSEventStreamStart(data->stream)) {
     -+		error("Failed to start the FSEventStream");
     ++		error(_("Failed to start the FSEventStream"));
      +		goto force_error_stop_without_loop;
      +	}
      +	data->stream_started = 1;
 18:  0896e72e2b8 = 18:  1f4b5209bf6 fsmonitor--daemon: implement handle_client callback
 19:  bc240a9e665 ! 19:  8cf62c9fc6f help: include fsmonitor--daemon feature flag in version info
     @@ t/test-lib.sh: test_lazy_prereq SHA1 '
      +# Does this platform support `git fsmonitor--daemon`
      +#
      +test_lazy_prereq FSMONITOR_DAEMON '
     -+	git version --build-options | grep "feature:" | grep "fsmonitor--daemon"
     ++	git version --build-options >output &&
     ++	grep "feature: fsmonitor--daemon" output
      +'
 20:  2b563c240eb ! 20:  1bd74a81593 t/helper/fsmonitor-client: create IPC client to talk to FSMonitor Daemon
     @@ t/helper/test-fsmonitor-client.c (new)
      +
      +	ret = fsmonitor_ipc__send_query(token, &answer);
      +	if (ret < 0)
     -+		die(_("could not query fsmonitor--daemon"));
     ++		die("could not query fsmonitor--daemon");
      +
      +	write_in_full(1, answer.buf, answer.len);
      +	strbuf_release(&answer);
     @@ t/helper/test-fsmonitor-client.c (new)
      +	const char *token = NULL;
      +
      +	const char * const fsmonitor_client_usage[] = {
     -+		N_("test-helper fsmonitor-client query [<token>]"),
     -+		N_("test-helper fsmonitor-client flush"),
     ++		"test-tool fsmonitor-client query [<token>]",
     ++		"test-tool fsmonitor-client flush",
      +		NULL,
      +	};
      +
      +	struct option options[] = {
     -+		OPT_STRING(0, "token", &token, N_("token"),
     -+			   N_("command token to send to the server")),
     ++		OPT_STRING(0, "token", &token, "token",
     ++			   "command token to send to the server"),
      +		OPT_END()
      +	};
      +
     -+	if (argc < 2)
     -+		usage_with_options(fsmonitor_client_usage, options);
     ++	argc = parse_options(argc, argv, NULL, options, fsmonitor_client_usage, 0);
      +
     -+	if (argc == 2 && !strcmp(argv[1], "-h"))
     ++	if (argc != 1)
      +		usage_with_options(fsmonitor_client_usage, options);
      +
     -+	subcmd = argv[1];
     -+	argv--;
     -+	argc++;
     -+
     -+	argc = parse_options(argc, argv, NULL, options, fsmonitor_client_usage, 0);
     ++	subcmd = argv[0];
      +
      +	setup_git_directory();
      +
 21:  db8809da089 ! 21:  4a920d0b54a t7527: create test for fsmonitor--daemon
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +fi
      +
      +stop_daemon_delete_repo () {
     -+	r=$1
     -+	git -C $r fsmonitor--daemon stop >/dev/null 2>/dev/null
     ++	r=$1 &&
     ++	test_might_fail git -C $r fsmonitor--daemon stop &&
      +	rm -rf $1
     -+	return 0
      +}
      +
      +start_daemon () {
     -+	case "$#" in
     -+		1) r="-C $1";;
     -+		*) r="";
     -+	esac
     ++	r= &&
     ++	tf= &&
     ++	t2= &&
     ++	tk= &&
     ++
     ++	while test "$#" -ne 0
     ++	do
     ++		case "$1" in
     ++		-C)
     ++			shift;
     ++			test "$#" -ne 0 || BUG "error: -C requires arg"
     ++			r="-C $1"
     ++			shift
     ++			;;
     ++		-tf)
     ++			shift;
     ++			test "$#" -ne 0 || BUG "error: -tf requires arg"
     ++			tf="$1"
     ++			shift
     ++			;;
     ++		-t2)
     ++			shift;
     ++			test "$#" -ne 0 || BUG "error: -t2 requires arg"
     ++			t2="$1"
     ++			shift
     ++			;;
     ++		-tk)
     ++			shift;
     ++			test "$#" -ne 0 || BUG "error: -tk requires arg"
     ++			tk="$1"
     ++			shift
     ++			;;
     ++		*)
     ++			BUG "error: unknown option: '$1'"
     ++			;;
     ++		esac
     ++	done &&
      +
     -+	git $r fsmonitor--daemon start || return $?
     -+	git $r fsmonitor--daemon status || return $?
     -+
     -+	return 0
     ++	(
     ++		if test -n "$tf"
     ++		then
     ++			GIT_TRACE_FSMONITOR="$tf"
     ++			export GIT_TRACE_FSMONITOR
     ++		fi &&
     ++
     ++		if test -n "$t2"
     ++		then
     ++			GIT_TRACE2_PERF="$t2"
     ++			export GIT_TRACE2_PERF
     ++		fi &&
     ++
     ++		if test -n "$tk"
     ++		then
     ++			GIT_TEST_FSMONITOR_TOKEN="$tk"
     ++			export GIT_TEST_FSMONITOR_TOKEN
     ++		fi &&
     ++
     ++		git $r fsmonitor--daemon start &&
     ++		git $r fsmonitor--daemon status
     ++	)
      +}
      +
      +# Is a Trace2 data event present with the given catetory and key?
      +# We do not care what the value is.
      +#
      +have_t2_data_event () {
     -+	c=$1
     -+	k=$2
     ++	c=$1 &&
     ++	k=$2 &&
      +
      +	grep -e '"event":"data".*"category":"'"$c"'".*"key":"'"$k"'"'
      +}
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +	test_when_finished "stop_daemon_delete_repo test_explicit" &&
      +
      +	git init test_explicit &&
     -+	start_daemon test_explicit &&
     ++	start_daemon -C test_explicit &&
      +
      +	git -C test_explicit fsmonitor--daemon stop &&
      +	test_must_fail git -C test_explicit fsmonitor--daemon status
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +	# but this test case is only concerned with whether the daemon was
      +	# implicitly started.)
      +
     -+	GIT_TRACE2_EVENT="$(pwd)/.git/trace" \
     ++	GIT_TRACE2_EVENT="$PWD/.git/trace" \
      +		test-tool -C test_implicit fsmonitor-client query --token 0 >actual &&
      +	nul_to_q <actual >actual.filtered &&
      +	grep "builtin:" actual.filtered &&
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +
      +	git init test_implicit_1 &&
      +
     -+	start_daemon test_implicit_1 &&
     ++	start_daemon -C test_implicit_1 &&
      +
      +	# deleting the .git directory will implicitly stop the daemon.
      +	rm -rf test_implicit_1/.git &&
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +
      +	git init test_implicit_2 &&
      +
     -+	start_daemon test_implicit_2 &&
     ++	start_daemon -C test_implicit_2 &&
      +
      +	# renaming the .git directory will implicitly stop the daemon.
      +	mv test_implicit_2/.git test_implicit_2/.xxx &&
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +
      +	git init test_multiple &&
      +
     -+	start_daemon test_multiple &&
     ++	start_daemon -C test_multiple &&
      +
      +	test_must_fail git -C test_multiple fsmonitor--daemon start 2>actual &&
      +	grep "fsmonitor--daemon is already running" actual &&
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +# This is here in case something else fails first.
      +#
      +redundant_stop_daemon () {
     -+	git fsmonitor--daemon stop
     -+	return 0
     ++	test_might_fail git fsmonitor--daemon stop
      +}
      +
      +test_expect_success 'update-index implicitly starts daemon' '
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +
      +	test_must_fail git fsmonitor--daemon status &&
      +
     -+	GIT_TRACE2_EVENT="$(pwd)/.git/trace_implicit_1" \
     ++	GIT_TRACE2_EVENT="$PWD/.git/trace_implicit_1" \
      +		git update-index --fsmonitor &&
      +
      +	git fsmonitor--daemon status &&
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +
      +	test_must_fail git fsmonitor--daemon status &&
      +
     -+	GIT_TRACE2_EVENT="$(pwd)/.git/trace_implicit_2" \
     ++	GIT_TRACE2_EVENT="$PWD/.git/trace_implicit_2" \
      +		git status >actual &&
      +
      +	git fsmonitor--daemon status &&
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +'
      +
      +edit_files () {
     -+	echo 1 >modified
     -+	echo 2 >dir1/modified
     -+	echo 3 >dir2/modified
     ++	echo 1 >modified &&
     ++	echo 2 >dir1/modified &&
     ++	echo 3 >dir2/modified &&
      +	>dir1/untracked
      +}
      +
      +delete_files () {
     -+	rm -f delete
     -+	rm -f dir1/delete
     ++	rm -f delete &&
     ++	rm -f dir1/delete &&
      +	rm -f dir2/delete
      +}
      +
      +create_files () {
     -+	echo 1 >new
     -+	echo 2 >dir1/new
     ++	echo 1 >new &&
     ++	echo 2 >dir1/new &&
      +	echo 3 >dir2/new
      +}
      +
      +rename_files () {
     -+	mv rename renamed
     -+	mv dir1/rename dir1/renamed
     ++	mv rename renamed &&
     ++	mv dir1/rename dir1/renamed &&
      +	mv dir2/rename dir2/renamed
      +}
      +
      +file_to_directory () {
     -+	rm -f delete
     -+	mkdir delete
     ++	rm -f delete &&
     ++	mkdir delete &&
      +	echo 1 >delete/new
      +}
      +
      +directory_to_file () {
     -+	rm -rf dir1
     ++	rm -rf dir1 &&
      +	echo 1 >dir1
      +}
      +
     -+verify_status () {
     -+	git status >actual &&
     -+	GIT_INDEX_FILE=.git/fresh-index git read-tree master &&
     -+	GIT_INDEX_FILE=.git/fresh-index git -c core.fsmonitor=false status >expect &&
     -+	test_cmp expect actual &&
     -+	echo HELLO AFTER &&
     -+	cat .git/trace &&
     -+	echo HELLO AFTER
     -+}
     -+
      +# The next few test cases confirm that our fsmonitor daemon sees each type
      +# of OS filesystem notification that we care about.  At this layer we just
      +# ensure we are getting the OS notifications and do not try to confirm what
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +# daemon) because these commands might implicitly restart the daemon.
      +
      +clean_up_repo_and_stop_daemon () {
     -+	git reset --hard HEAD
     -+	git clean -fd
     -+	git fsmonitor--daemon stop
     ++	git reset --hard HEAD &&
     ++	git clean -fd &&
     ++	test_might_fail git fsmonitor--daemon stop &&
      +	rm -f .git/trace
      +}
      +
      +test_expect_success 'edit some files' '
      +	test_when_finished clean_up_repo_and_stop_daemon &&
      +
     -+	(
     -+		GIT_TRACE_FSMONITOR="$(pwd)/.git/trace" &&
     -+		export GIT_TRACE_FSMONITOR &&
     -+
     -+		start_daemon
     -+	) &&
     ++	start_daemon -tf "$PWD/.git/trace" &&
      +
      +	edit_files &&
      +
     -+	test-tool fsmonitor-client query --token 0 >/dev/null 2>&1 &&
     ++	test-tool fsmonitor-client query --token 0 &&
      +
      +	grep "^event: dir1/modified$"  .git/trace &&
      +	grep "^event: dir2/modified$"  .git/trace &&
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +test_expect_success 'create some files' '
      +	test_when_finished clean_up_repo_and_stop_daemon &&
      +
     -+	(
     -+		GIT_TRACE_FSMONITOR="$(pwd)/.git/trace" &&
     -+		export GIT_TRACE_FSMONITOR &&
     -+
     -+		start_daemon
     -+	) &&
     ++	start_daemon -tf "$PWD/.git/trace" &&
      +
      +	create_files &&
      +
     -+	test-tool fsmonitor-client query --token 0 >/dev/null 2>&1 &&
     ++	test-tool fsmonitor-client query --token 0 &&
      +
      +	grep "^event: dir1/new$" .git/trace &&
      +	grep "^event: dir2/new$" .git/trace &&
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +test_expect_success 'delete some files' '
      +	test_when_finished clean_up_repo_and_stop_daemon &&
      +
     -+	(
     -+		GIT_TRACE_FSMONITOR="$(pwd)/.git/trace" &&
     -+		export GIT_TRACE_FSMONITOR &&
     -+
     -+		start_daemon
     -+	) &&
     ++	start_daemon -tf "$PWD/.git/trace" &&
      +
      +	delete_files &&
      +
     -+	test-tool fsmonitor-client query --token 0 >/dev/null 2>&1 &&
     ++	test-tool fsmonitor-client query --token 0 &&
      +
      +	grep "^event: dir1/delete$" .git/trace &&
      +	grep "^event: dir2/delete$" .git/trace &&
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +test_expect_success 'rename some files' '
      +	test_when_finished clean_up_repo_and_stop_daemon &&
      +
     -+	(
     -+		GIT_TRACE_FSMONITOR="$(pwd)/.git/trace" &&
     -+		export GIT_TRACE_FSMONITOR &&
     -+
     -+		start_daemon
     -+	) &&
     ++	start_daemon -tf "$PWD/.git/trace" &&
      +
      +	rename_files &&
      +
     -+	test-tool fsmonitor-client query --token 0 >/dev/null 2>&1 &&
     ++	test-tool fsmonitor-client query --token 0 &&
      +
      +	grep "^event: dir1/rename$"  .git/trace &&
      +	grep "^event: dir2/rename$"  .git/trace &&
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +test_expect_success 'rename directory' '
      +	test_when_finished clean_up_repo_and_stop_daemon &&
      +
     -+	(
     -+		GIT_TRACE_FSMONITOR="$(pwd)/.git/trace" &&
     -+		export GIT_TRACE_FSMONITOR &&
     -+
     -+		start_daemon
     -+	) &&
     ++	start_daemon -tf "$PWD/.git/trace" &&
      +
      +	mv dirtorename dirrenamed &&
      +
     -+	test-tool fsmonitor-client query --token 0 >/dev/null 2>&1 &&
     ++	test-tool fsmonitor-client query --token 0 &&
      +
      +	grep "^event: dirtorename/*$" .git/trace &&
      +	grep "^event: dirrenamed/*$"  .git/trace
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +test_expect_success 'file changes to directory' '
      +	test_when_finished clean_up_repo_and_stop_daemon &&
      +
     -+	(
     -+		GIT_TRACE_FSMONITOR="$(pwd)/.git/trace" &&
     -+		export GIT_TRACE_FSMONITOR &&
     -+
     -+		start_daemon
     -+	) &&
     ++	start_daemon -tf "$PWD/.git/trace" &&
      +
      +	file_to_directory &&
      +
     -+	test-tool fsmonitor-client query --token 0 >/dev/null 2>&1 &&
     ++	test-tool fsmonitor-client query --token 0 &&
      +
      +	grep "^event: delete$"     .git/trace &&
      +	grep "^event: delete/new$" .git/trace
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +test_expect_success 'directory changes to a file' '
      +	test_when_finished clean_up_repo_and_stop_daemon &&
      +
     -+	(
     -+		GIT_TRACE_FSMONITOR="$(pwd)/.git/trace" &&
     -+		export GIT_TRACE_FSMONITOR &&
     -+
     -+		start_daemon
     -+	) &&
     ++	start_daemon -tf "$PWD/.git/trace" &&
      +
      +	directory_to_file &&
      +
     -+	test-tool fsmonitor-client query --token 0 >/dev/null 2>&1 &&
     ++	test-tool fsmonitor-client query --token 0 &&
      +
      +	grep "^event: dir1$" .git/trace
      +'
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +
      +	git init test_flush &&
      +
     -+	(
     -+		GIT_TEST_FSMONITOR_TOKEN=true &&
     -+		export GIT_TEST_FSMONITOR_TOKEN &&
     -+
     -+		GIT_TRACE_FSMONITOR="$(pwd)/.git/trace_daemon" &&
     -+		export GIT_TRACE_FSMONITOR &&
     -+
     -+		start_daemon test_flush
     -+	) &&
     ++	start_daemon -C test_flush -tf "$PWD/.git/trace_daemon" -tk true &&
      +
      +	# The daemon should have an initial token with no events in _0 and
      +	# then a few (probably platform-specific number of) events in _1.
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +	test-tool -C test_flush fsmonitor-client query --token "builtin:test_00000001:0" >actual_0 &&
      +	nul_to_q <actual_0 >actual_q0 &&
      +
     -+	touch test_flush/file_1 &&
     -+	touch test_flush/file_2 &&
     ++	>test_flush/file_1 &&
     ++	>test_flush/file_2 &&
      +
      +	test-tool -C test_flush fsmonitor-client query --token "builtin:test_00000001:0" >actual_1 &&
      +	nul_to_q <actual_1 >actual_q1 &&
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +
      +	grep "^builtin:test_00000002:0Q$" actual_q2 &&
      +
     -+	touch test_flush/file_3 &&
     ++	>test_flush/file_3 &&
      +
      +	test-tool -C test_flush fsmonitor-client query --token "builtin:test_00000002:0" >actual_3 &&
      +	nul_to_q <actual_3 >actual_q3 &&
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +test_expect_success 'worktree with .git file' '
      +	git -C wt-base worktree add ../wt-secondary &&
      +
     -+	(
     -+		GIT_TRACE2_PERF="$(pwd)/trace2_wt_secondary" &&
     -+		export GIT_TRACE2_PERF &&
     -+
     -+		GIT_TRACE_FSMONITOR="$(pwd)/trace_wt_secondary" &&
     -+		export GIT_TRACE_FSMONITOR &&
     -+
     -+		start_daemon wt-secondary
     -+	) &&
     ++	start_daemon -C wt-secondary \
     ++		-tf "$PWD/trace_wt_secondary" \
     ++		-t2 "$PWD/trace2_wt_secondary" &&
      +
      +	git -C wt-secondary fsmonitor--daemon stop &&
      +	test_must_fail git -C wt-secondary fsmonitor--daemon status
 22:  15bd5aaff36 = 22:  c925a9a7459 t/perf: avoid copying builtin fsmonitor files into test repo
 23:  4cb97918d20 = 23:  5b3381c223e t/helper/test-chmtime: skip directories on Windows
 24:  a70748b4640 ! 24:  803a540cc00 t/perf/p7519: speed up test on Windows
     @@ t/perf/p7519-fsmonitor.sh: test_fsmonitor_suite() {
       			head -100000 | \
       			grep -v \" | \
      -			sed '\''s/\(.\)/\\\1/g'\'' | \
     -+			egrep -v " ." | \
     ++			grep -v " ." | \
       			xargs test-tool chmtime -300 &&
       		git status
       	'
 25:  b0c9c9c7a40 ! 25:  d5ca2df31c8 t/perf/p7519: add fsmonitor--daemon test cases
     @@ Commit message
          Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       ## t/perf/p7519-fsmonitor.sh ##
     +@@ t/perf/p7519-fsmonitor.sh: test_expect_success "one time repo setup" '
     + 	fi
     + '
     + 
     +-setup_for_fsmonitor () {
     ++setup_for_fsmonitor_hook () {
     + 	# set INTEGRATION_SCRIPT depending on the environment
     + 	if test -n "$INTEGRATION_PATH"
     + 	then
      @@ t/perf/p7519-fsmonitor.sh: test_perf_w_drop_caches () {
       }
       
     @@ t/perf/p7519-fsmonitor.sh: test_perf_w_drop_caches () {
      +	if test -n "$USE_FSMONITOR_DAEMON"
      +	then
      +		DESC="builtin fsmonitor--daemon"
     -+	elif test -n "$INTEGRATION_SCRIPT"; then
     ++	elif test -n "$INTEGRATION_SCRIPT"
     ++	then
       		DESC="fsmonitor=$(basename $INTEGRATION_SCRIPT)"
       	else
       		DESC="fsmonitor=disabled"
     +@@ t/perf/p7519-fsmonitor.sh: test_fsmonitor_suite () {
     + trace_start fsmonitor-watchman
     + if test -n "$GIT_PERF_7519_FSMONITOR"; then
     + 	for INTEGRATION_PATH in $GIT_PERF_7519_FSMONITOR; do
     +-		test_expect_success "setup for fsmonitor $INTEGRATION_PATH" 'setup_for_fsmonitor'
     ++		test_expect_success "setup for fsmonitor $INTEGRATION_PATH" 'setup_for_fsmonitor_hook'
     + 		test_fsmonitor_suite
     + 	done
     + else
     +-	test_expect_success "setup for fsmonitor" 'setup_for_fsmonitor'
     ++	test_expect_success "setup for fsmonitor hook" 'setup_for_fsmonitor_hook'
     + 	test_fsmonitor_suite
     + fi
     + 
      @@ t/perf/p7519-fsmonitor.sh: test_expect_success "setup without fsmonitor" '
       test_fsmonitor_suite
       trace_stop
     @@ t/perf/p7519-fsmonitor.sh: test_expect_success "setup without fsmonitor" '
      +then
      +	USE_FSMONITOR_DAEMON=t
      +
     -+	trace_start fsmonitor--daemon--server
     -+	git fsmonitor--daemon start
     ++	test_expect_success "setup for builtin fsmonitor" '
     ++		trace_start fsmonitor--daemon--server &&
     ++		git fsmonitor--daemon start &&
      +
     -+	trace_start fsmonitor--daemon--client
     ++		trace_start fsmonitor--daemon--client &&
      +
     -+	git config core.fsmonitor true
     -+	git update-index --fsmonitor
     ++		git config core.fsmonitor true &&
     ++		git update-index --fsmonitor
     ++	'
      +
      +	test_fsmonitor_suite
      +
 26:  64a5b741670 = 26:  42631259e89 fsmonitor--daemon: periodically truncate list of modified files
 27:  5b06eb5d0e6 ! 27:  f256c3cbe8b fsmonitor--daemon: use a cookie file to sync with file system
     @@ builtin/fsmonitor--daemon.c: static int do_as_client__status(void)
       
      +enum fsmonitor_cookie_item_result {
      +	FCIR_ERROR = -1, /* could not create cookie file ? */
     -+	FCIR_INIT = 0,
     ++	FCIR_INIT,
      +	FCIR_SEEN,
      +	FCIR_ABORT,
      +};
      +
      +struct fsmonitor_cookie_item {
      +	struct hashmap_entry entry;
     -+	const char *name;
     ++	char *name;
      +	enum fsmonitor_cookie_item_result result;
      +};
      +
     @@ builtin/fsmonitor--daemon.c: static int do_as_client__status(void)
      +	 * that the listener thread has seen it.
      +	 */
      +	fd = open(cookie_pathname.buf, O_WRONLY | O_CREAT | O_EXCL, 0600);
     -+	if (fd >= 0) {
     -+		close(fd);
     -+		unlink(cookie_pathname.buf);
     -+
     -+		/*
     -+		 * Technically, this is an infinite wait (well, unless another
     -+		 * thread sends us an abort).  I'd like to change this to
     -+		 * use `pthread_cond_timedwait()` and return an error/timeout
     -+		 * and let the caller do the trivial response thing, but we
     -+		 * don't have that routine in our thread-utils.
     -+		 *
     -+		 * After extensive beta testing I'm not really worried about
     -+		 * this.  Also note that the above open() and unlink() calls
     -+		 * will cause at least two FS events on that path, so the odds
     -+		 * of getting stuck are pretty slim.
     -+		 */
     -+		while (cookie->result == FCIR_INIT)
     -+			pthread_cond_wait(&state->cookies_cond,
     -+					  &state->main_lock);
     -+	} else {
     ++	if (fd < 0) {
      +		error_errno(_("could not create fsmonitor cookie '%s'"),
      +			    cookie->name);
      +
      +		cookie->result = FCIR_ERROR;
     ++		goto done;
      +	}
      +
     ++	/*
     ++	 * Technically, close() and unlink() can fail, but we don't
     ++	 * care here.  We only created the file to trigger a watch
     ++	 * event from the FS to know that when we're up to date.
     ++	 */
     ++	close(fd);
     ++	unlink(cookie_pathname.buf);
     ++
     ++	/*
     ++	 * Technically, this is an infinite wait (well, unless another
     ++	 * thread sends us an abort).  I'd like to change this to
     ++	 * use `pthread_cond_timedwait()` and return an error/timeout
     ++	 * and let the caller do the trivial response thing, but we
     ++	 * don't have that routine in our thread-utils.
     ++	 *
     ++	 * After extensive beta testing I'm not really worried about
     ++	 * this.  Also note that the above open() and unlink() calls
     ++	 * will cause at least two FS events on that path, so the odds
     ++	 * of getting stuck are pretty slim.
     ++	 */
     ++	while (cookie->result == FCIR_INIT)
     ++		pthread_cond_wait(&state->cookies_cond,
     ++				  &state->main_lock);
     ++
     ++done:
      +	hashmap_remove(&state->cookies, &cookie->entry, NULL);
      +
      +	result = cookie->result;
      +
     -+	free((char*)cookie->name);
     ++	free(cookie->name);
      +	free(cookie);
      +	strbuf_release(&cookie_pathname);
      +
 28:  1fd5439de03 = 28:  08af8296f96 fsmonitor: force update index after large responses
 29:  6fc1430285f ! 29:  e6cf84dc8eb t7527: test status with untracked-cache and fsmonitor--daemon
     @@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'cleanup worktrees' '
      +}
      +
      +matrix_try () {
     -+	uc=$1
     -+	fsm=$2
     -+	fn=$3
     ++	uc=$1 &&
     ++	fsm=$2 &&
     ++	fn=$3 &&
      +
      +	test_expect_success "Matrix[uc:$uc][fsm:$fsm] $fn" '
      +		matrix_clean_up_repo &&
 30:  b915b95cc2f <  -:  ----------- update-index: convert fsmonitor warnings to advise

-- 
gitgitgadget
