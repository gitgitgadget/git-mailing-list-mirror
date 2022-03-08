Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29664C433FE
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 22:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350654AbiCHWQk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 17:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350537AbiCHWQc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 17:16:32 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAFB5575F
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 14:15:32 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id i8so240175wrr.8
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 14:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bNIIZHoOfYq9mfSFQNCDE9ASqJ+H8ILU7Q7ugdzy9i8=;
        b=R54tSib1O1gaR4FQvSHryW0fMLhNVPNG8UvZ80MUPfpsCa4VMkZkv9pPuKToxJj2/V
         U620C6cLtQvIl81Km+kO0lB5UbJu56PDao+4CQonvyFtopky/3BMwAuLRcx3PrVTkySI
         6dIG7JPnGqo21TLk1lOyCbW73+y1o97xz3/rScr3EZK7FEAmdiyqA3NU6vj4QDZsqedx
         cntgOr6EMiyROIBxSToMVlfQZmN44aeXQ0zdYvD9x8cQOSK+rnwGSqqZEMmj5gJjTO35
         kD04wLZtcskPMGE59Yfn2cYHa+14C7qqFdfvhc9HxTPVBkz55X45aCMb1OaHa3jfk2v3
         4FXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bNIIZHoOfYq9mfSFQNCDE9ASqJ+H8ILU7Q7ugdzy9i8=;
        b=aR8byhyaK8X8ET0BIMUxTC4FJLc+wZ7rGDJMHbU4HkvYnEzDtnqyR3i6YvvShqCBRa
         22do24ix6Rt2kYB/zGbt028sDN11EuH4fCiQn+bOmTQfpOppCHLac4xnp69fZt76Pfzh
         aZbYOjH0RWLjgbRJ+TlHgJODqnSJgPRQ+J0bKKoty0v9cI7FcucJphSHOaxMwbSDZHN9
         3L7Co0umsSLDCFn0Ho2S+j5WEpndUQ99JixxsZpiOs0gjALOiNpIZcIiYSWacIZ5QUjq
         fj9+KAXake7/lJ90FrTEzW8ez7GOfsX46bmRJpi3o76ePs5WMXsBfPj1fXzo4CXV7vg0
         PMWg==
X-Gm-Message-State: AOAM531jSfHuqHsBA/z0L+cWrpyHLZP/aRcfMl1KWl1L7r4brXFXbZjU
        oHPcZO3aW/86sc88Kxb2SQIFiQjamnk=
X-Google-Smtp-Source: ABdhPJxRS1D85nb69z5QVofVLWZGt2QqzuXgUbzmrX8MahtKUDVO11NxbUW/ooccZBc4IqFMWFSWug==
X-Received: by 2002:a05:6000:184e:b0:1f0:3569:ccac with SMTP id c14-20020a056000184e00b001f03569ccacmr14139724wri.680.1646777730452;
        Tue, 08 Mar 2022 14:15:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b3-20020a5d4d83000000b001f1d72a6f97sm93241wru.50.2022.03.08.14.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 14:15:28 -0800 (PST)
Message-Id: <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Mar 2022 22:15:00 +0000
Subject: [PATCH v2 00/27] Builtin FSMonitor Part 3
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
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is V2 of part 3 of my builtin FSMonitor series.

I think I have addressed all of the feedback from V1. This includes:

[] AEvar's suggestion to simplify the API to get the repo incompatibility
message.

[] I updated the daemon on MacOS to report both the NFC and NFD spellings of
a pathname when appropriate. This is a little more general than the
"core.precomposeUnicode" setting, since the daemon does not know how the
client has (or will have) it set when they make a query.

[] I replaced my Unicode NFC/NFD test for MacOS to focus exclusively on
Unicode composition/decomposition sensitivity and to not confuse that with
case sensitivity.

[] Added code on MacOS to mark repos on FAT32 and NTFS volumes as
incompatible with FSMonitor, since they don't support Unix domain sockets.

[] I reordered some of the static functions in the Windows version of the
health monitoring code to reduce the need for forward declarations.

[] Lots of typos and cleanup.

This version has been rebased upon V6 of Part 2 which is currently in
"next".

I'm not going to repeat the perf test results in the V2 version of the cover
letter; interested readers should look at the cover letter for V1.

Jeff Hostetler (27):
  fsm-listen-win32: handle shortnames
  t7527: test FSMonitor on repos with Unicode root paths
  t/helper/fsmonitor-client: create stress test
  fsmonitor-settings: bare repos are incompatible with FSMonitor
  fsmonitor-settings: stub in platform-specific incompatibility checking
  fsmonitor-settings: VFS for Git virtual repos are incompatible
  fsmonitor-settings: stub in macOS-specific incompatibility checking
  fsmonitor-settings: remote repos on macOS are incompatible
  fsmonitor-settings: remote repos on Windows are incompatible
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
  fsmonitor-settings: NTFS and FAT32 on MacOS are incompatible

 Makefile                               |  19 +-
 builtin/fsmonitor--daemon.c            | 107 ++++++-
 builtin/update-index.c                 |   7 +
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
 fsmonitor-settings.c                   |  81 +++++
 fsmonitor-settings.h                   |  29 ++
 fsmonitor.c                            |  73 ++++-
 fsmonitor.h                            |  11 +
 t/helper/test-fsmonitor-client.c       | 106 +++++++
 t/lib-unicode-nfc-nfd.sh               | 159 ++++++++++
 t/perf/p7527-builtin-fsmonitor.sh      | 257 +++++++++++++++
 t/t7519-status-fsmonitor.sh            |  32 ++
 t/t7527-builtin-fsmonitor.sh           | 314 +++++++++++++++++++
 unpack-trees.c                         |   1 +
 24 files changed, 2208 insertions(+), 124 deletions(-)
 create mode 100644 compat/fsmonitor/fsm-health-darwin.c
 create mode 100644 compat/fsmonitor/fsm-health-win32.c
 create mode 100644 compat/fsmonitor/fsm-health.h
 create mode 100644 compat/fsmonitor/fsm-settings-darwin.c
 create mode 100644 compat/fsmonitor/fsm-settings-win32.c
 create mode 100755 t/lib-unicode-nfc-nfd.sh
 create mode 100755 t/perf/p7527-builtin-fsmonitor.sh


base-commit: 1a9241e1fee9d418e436849853f031329e792192
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1143%2Fjeffhostetler%2Fbuiltin-fsmonitor-part3-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1143/jeffhostetler/builtin-fsmonitor-part3-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1143

Range-diff vs v1:

  1:  23f38338cec !  1:  34619e0652b fsm-listen-win32: handle shortnames
     @@ compat/fsmonitor/fsm-listen-win32.c: normalize:
      + * to longname conversion on every notification event.
      + *
      + * We do not want to create a file to test this, so we assume that the
     -+ * root directory contains a ".git" file or directory.  (Out caller
     ++ * root directory contains a ".git" file or directory.  (Our caller
      + * only calls us for the worktree root, so this should be fine.)
      + *
      + * Remember the spelling of the shortname for ".git" if it exists.
     @@ compat/fsmonitor/fsm-listen-win32.c: normalize:
      +		 * lookup the longname for it.  Likewise, for moves
      +		 * and renames where we are given the old name.)
      +		 *
     -+		 * NEEDSWORK: Since deleting or moving a file or
     -+		 * directory by shortname is rather obscure, I'm going
     -+		 * ignore the failure and ask the caller to report the
     -+		 * original relative path.  This seemds kinder than
     -+		 * failing here and forcing a resync.
     ++		 * Since deleting or moving a file or directory by its
     ++		 * shortname is rather obscure, I'm going ignore the
     ++		 * failure and ask the caller to report the original
     ++		 * relative path.  This seems kinder than failing here
     ++		 * and forcing a resync.  Besides, forcing a resync on
     ++		 * every file/directory delete would effectively
     ++		 * cripple monitoring.
     ++		 *
     ++		 * We might revisit this in the future.
      +		 */
      +		return GRR_NO_CONVERSION_NEEDED;
      +	}
  3:  9af952e4d17 !  2:  3a0f30b849a t7527: test builtin FSMonitor watching repos with unicode paths
     @@ Metadata
      Author: Jeff Hostetler <jeffhost@microsoft.com>
      
       ## Commit message ##
     -    t7527: test builtin FSMonitor watching repos with unicode paths
     +    t7527: test FSMonitor on repos with Unicode root paths
      
     -    Create some test repos with UTF8 pathnames and verify that
     -    the builtin FSMonitor can watch them.  This test is mainly
     -    for Windows where we need to avoid `*A()` routines.
     +    Create some test repos with UTF8 characters in the pathname of the
     +    root directory and verify that the builtin FSMonitor can watch them.
     +
     +    This test is mainly for Windows where we need to avoid `*A()`
     +    routines.
      
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
      
     @@ t/t7527-builtin-fsmonitor.sh: do
       done
       
      +# Test Unicode UTF-8 characters in the pathname of the working
     -+# directory.  Use of "*A()" routines rather than "*W()" routines
     ++# directory root.  Use of "*A()" routines rather than "*W()" routines
      +# on Windows can sometimes lead to odd failures.
      +#
      +u1=$(printf "u_c3_a6__\xC3\xA6")
     @@ t/t7527-builtin-fsmonitor.sh: do
      +u_values="$u1 $u2"
      +for u in $u_values
      +do
     -+	test_expect_success "Unicode path: $u" '
     ++	test_expect_success "Unicode in repo root path: $u" '
      +		test_when_finished "stop_daemon_delete_repo $u" &&
      +
      +		git init "$u" &&
  4:  9efdbe28223 !  3:  87d1c0b6f2a t/helper/fsmonitor-client: create stress test
     @@ Commit message
          Create a client-side thread pool of n threads and have
          each of them make m requests as fast as they can.
      
     -    NEEDSWORK: This is just the client-side thread pool and
     -    is useful for interactive testing and experimentation.
     -    We need to add a script test to drive this.
     +    We do not currently inspect the contents of the response.
     +    We're only interested in placing a heavy request load on
     +    the daemon.
     +
     +    This test is useful for interactive testing and various
     +    experimentation.  For example, to place additional load
     +    on the daemon while another test is running.  We currently
     +    do not have a test script that actually uses this helper.
     +    We might add such a test in the future.
      
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
      
     @@ t/helper/test-fsmonitor-client.c: static int do_send_flush(void)
      +	free(data);
      +
      +	/*
     -+	 * TODO Decide if/when to return an error or call die().
     ++	 * Return an error if any of the _send_query requests failed.
     ++	 * We don't care about thread create/join errors.
      +	 */
     -+	return 0;
     ++	return sum_errors > 0;
      +}
      +
       int cmd__fsmonitor_client(int argc, const char **argv)
  5:  44cc61e186c !  4:  8c4f90ae4fd fsmonitor-settings: bare repos are incompatible with FSMonitor
     @@ builtin/fsmonitor--daemon.c: int cmd_fsmonitor__daemon(int argc, const char **ar
      +	fsm_settings__set_ipc(the_repository);
      +
      +	if (fsm_settings__get_mode(the_repository) == FSMONITOR_MODE_INCOMPATIBLE) {
     -+		struct strbuf buf_reason = STRBUF_INIT;
     -+		fsm_settings__get_reason(the_repository, &buf_reason);
     -+		error("%s '%s'", buf_reason.buf, xgetcwd());
     -+		strbuf_release(&buf_reason);
     -+		return -1;
     ++		const char *msg = fsm_settings__get_reason_msg(the_repository);
     ++
     ++		return error("%s '%s'", msg ? msg : "???", xgetcwd());
      +	}
      +
       	if (!strcmp(subcmd, "start"))
     @@ builtin/update-index.c: int cmd_update_index(int argc, const char **argv, const
       		enum fsmonitor_mode fsm_mode = fsm_settings__get_mode(r);
      +
      +		if (fsm_mode == FSMONITOR_MODE_INCOMPATIBLE) {
     -+			struct strbuf buf_reason = STRBUF_INIT;
     -+			fsm_settings__get_reason(r, &buf_reason);
     -+			error("%s", buf_reason.buf);
     -+			strbuf_release(&buf_reason);
     -+			return -1;
     ++			const char *msg = fsm_settings__get_reason_msg(r);
     ++
     ++			return error("%s '%s'", msg ? msg : "???", xgetcwd());
      +		}
      +
       		if (fsm_mode == FSMONITOR_MODE_DISABLED) {
     @@ fsmonitor-settings.c
       {
       	struct fsmonitor_settings *s;
      @@ fsmonitor-settings.c: void fsm_settings__set_ipc(struct repository *r)
     - {
     + 
       	lookup_fsmonitor_settings(r);
       
      +	if (check_for_incompatible(r))
     @@ fsmonitor-settings.c: void fsm_settings__set_ipc(struct repository *r)
       	FREE_AND_NULL(r->settings.fsmonitor->hook_path);
       }
      @@ fsmonitor-settings.c: void fsm_settings__set_hook(struct repository *r, const char *path)
     - {
     + 
       	lookup_fsmonitor_settings(r);
       
      +	if (check_for_incompatible(r))
     @@ fsmonitor-settings.c: void fsm_settings__set_disabled(struct repository *r)
       	lookup_fsmonitor_settings(r);
       
       	r->settings.fsmonitor->mode = FSMONITOR_MODE_DISABLED;
     -+	r->settings.fsmonitor->reason = FSMONITOR_REASON_ZERO;
     ++	r->settings.fsmonitor->reason = FSMONITOR_REASON_OK;
       	FREE_AND_NULL(r->settings.fsmonitor->hook_path);
       }
      +
     -+static void create_reason_message(struct repository *r,
     -+				  struct strbuf *buf_reason)
     ++enum fsmonitor_reason fsm_settings__get_reason(struct repository *r)
      +{
     -+	struct fsmonitor_settings *s = r->settings.fsmonitor;
     -+
     -+	switch (s->reason) {
     -+	case FSMONITOR_REASON_ZERO:
     -+		return;
     ++	if (!r)
     ++		r = the_repository;
      +
     -+	case FSMONITOR_REASON_BARE:
     -+		strbuf_addstr(buf_reason,
     -+			      _("bare repos are incompatible with fsmonitor"));
     -+		return;
     ++	lookup_fsmonitor_settings(r);
      +
     -+	default:
     -+		BUG("Unhandled case in create_reason_message '%d'", s->reason);
     -+	}
     ++	return r->settings.fsmonitor->reason;
      +}
      +
     -+enum fsmonitor_reason fsm_settings__get_reason(struct repository *r,
     -+					       struct strbuf *buf_reason)
     ++const char *fsm_settings__get_reason_msg(struct repository *r)
      +{
     -+	lookup_fsmonitor_settings(r);
     ++	enum fsmonitor_reason reason = fsm_settings__get_reason(r);
      +
     -+	strbuf_reset(buf_reason);
     -+	if (r->settings.fsmonitor->mode == FSMONITOR_MODE_INCOMPATIBLE)
     -+		create_reason_message(r, buf_reason);
     ++	switch (reason) {
     ++	case FSMONITOR_REASON_OK:
     ++		return NULL;
      +
     -+	return r->settings.fsmonitor->reason;
     ++	case FSMONITOR_REASON_BARE:
     ++		return _("bare repos are incompatible with fsmonitor");
     ++	}
     ++
     ++	BUG("Unhandled case in fsm_settings__get_reason_msg '%d'",
     ++	    reason);
      +}
      
       ## fsmonitor-settings.h ##
     @@ fsmonitor-settings.h
      + * Incompatibility reasons.
      + */
      +enum fsmonitor_reason {
     -+	FSMONITOR_REASON_ZERO = 0,
     -+	FSMONITOR_REASON_BARE = 1,
     ++	FSMONITOR_REASON_OK = 0, /* no incompatibility or when disbled */
     ++	FSMONITOR_REASON_BARE,
      +};
      +
       void fsm_settings__set_ipc(struct repository *r);
       void fsm_settings__set_hook(struct repository *r, const char *path);
       void fsm_settings__set_disabled(struct repository *r);
     - 
     +@@ fsmonitor-settings.h: void fsm_settings__set_disabled(struct repository *r);
       enum fsmonitor_mode fsm_settings__get_mode(struct repository *r);
       const char *fsm_settings__get_hook_path(struct repository *r);
     -+enum fsmonitor_reason fsm_settings__get_reason(struct repository *r,
     -+					       struct strbuf *buf_reason);
       
     ++enum fsmonitor_reason fsm_settings__get_reason(struct repository *r);
     ++const char *fsm_settings__get_reason_msg(struct repository *r);
     ++
       struct fsmonitor_settings;
       
     + #endif /* FSMONITOR_SETTINGS_H */
      
       ## t/t7519-status-fsmonitor.sh ##
      @@ t/t7519-status-fsmonitor.sh: test_lazy_prereq UNTRACKED_CACHE '
     @@ t/t7519-status-fsmonitor.sh: test_lazy_prereq UNTRACKED_CACHE '
      +test_expect_success 'incompatible bare repo' '
      +	test_when_finished "rm -rf ./bare-clone actual expect" &&
      +	git init --bare bare-clone &&
     -+	cat >expect <<-\EOF &&
     -+	error: bare repos are incompatible with fsmonitor
     -+	EOF
      +
      +	test_must_fail \
      +		git -C ./bare-clone -c core.fsmonitor=foo \
      +			update-index --fsmonitor 2>actual &&
     -+	test_cmp expect actual &&
     ++	grep "bare repos are incompatible with fsmonitor" actual &&
      +
      +	test_must_fail \
      +		git -C ./bare-clone -c core.fsmonitor=true \
      +			update-index --fsmonitor 2>actual &&
     -+	test_cmp expect actual
     ++	grep "bare repos are incompatible with fsmonitor" actual
      +'
      +
      +test_expect_success FSMONITOR_DAEMON 'run fsmonitor-daemon in bare repo' '
  6:  4715677f85f !  5:  6329328d185 fsmonitor-settings: stub in platform-specific incompatibility checking
     @@ Commit message
      
          In the existing fsmonitor-settings code we have a way to mark
          types of repos as incompatible with fsmonitor (whether via the
     -    hook and ipc APIs).  For example, we do this for bare repos,
     +    hook and IPC APIs).  For example, we do this for bare repos,
          since there are no files to watch.
      
     -    Extend this exclusion mechanism for platfor-specific reasons.
     +    Extend this exclusion mechanism for platform-specific reasons.
          This commit just creates the framework and adds a stub for Win32.
      
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
     @@ Makefile: all::
       # `compat/fsmonitor/fsm-listen-<name>.c` that implements the
       # `fsm_listen__*()` routines.
       #
     -+# If your platform has os-specific ways to tell if a repo is incompatible with
     -+# fsmonitor (whether the hook or ipc daemon version), set FSMONITOR_OS_SETTINGS
     ++# If your platform has OS-specific ways to tell if a repo is incompatible with
     ++# fsmonitor (whether the hook or IPC daemon version), set FSMONITOR_OS_SETTINGS
      +# to the "<name>" of the corresponding `compat/fsmonitor/fsm-settings-<name>.c`
      +# that implements the `fsm_os_settings__*()` routines.
      +#
     @@ compat/fsmonitor/fsm-settings-win32.c (new)
      +
      +enum fsmonitor_reason fsm_os__incompatible(struct repository *r)
      +{
     -+	return FSMONITOR_REASON_ZERO;
     ++	return FSMONITOR_REASON_OK;
      +}
      
       ## config.mak.uname ##
     @@ fsmonitor-settings.c: static int check_for_incompatible(struct repository *r)
      +		enum fsmonitor_reason reason;
      +
      +		reason = fsm_os__incompatible(r);
     -+		if (reason != FSMONITOR_REASON_ZERO) {
     ++		if (reason != FSMONITOR_REASON_OK) {
      +			set_incompatible(r, reason);
      +			return 1;
      +		}
     @@ fsmonitor-settings.c: static int check_for_incompatible(struct repository *r)
       
      
       ## fsmonitor-settings.h ##
     -@@ fsmonitor-settings.h: enum fsmonitor_reason fsm_settings__get_reason(struct repository *r,
     +@@ fsmonitor-settings.h: const char *fsm_settings__get_reason_msg(struct repository *r);
       
       struct fsmonitor_settings;
       
     @@ fsmonitor-settings.h: enum fsmonitor_reason fsm_settings__get_reason(struct repo
      + * Ask platform-specific code whether the repository is incompatible
      + * with fsmonitor (both hook and ipc modes).  For example, if the working
      + * directory is on a remote volume and mounted via a technology that does
     -+ * not support notification events.
     ++ * not support notification events, then we should not pretend to watch it.
      + *
      + * fsm_os__* routines should considered private to fsm_settings__
      + * routines.
  7:  4e856d60e38 !  6:  fa9e86e7de7 fsmonitor-settings: virtual repos are incompatible with FSMonitor
     @@ Metadata
      Author: Jeff Hostetler <jeffhost@microsoft.com>
      
       ## Commit message ##
     -    fsmonitor-settings: virtual repos are incompatible with FSMonitor
     +    fsmonitor-settings: VFS for Git virtual repos are incompatible
      
     -    Virtual repos, such as GVFS (aka VFS for Git), are incompatible
     -    with FSMonitor.
     +    VFS for Git virtual repositories are incompatible with FSMonitor.
     +
     +    VFS for Git is a downstream fork of Git.  It contains its own custom
     +    file system watcher that is aware of the virtualization.  If a working
     +    directory is being managed by VFS for Git, we should not try to watch
     +    it because we may get incomplete results.
     +
     +    We do not know anything about how VFS for Git works, but we do
     +    know that VFS for Git working directories contain a well-defined
     +    config setting.  If it is set, mark the working directory as
     +    incompatible.
      
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
      
     @@ compat/fsmonitor/fsm-settings-win32.c
       #include "fsmonitor-settings.h"
       
      +/*
     -+ * GVFS (aka VFS for Git) is incompatible with FSMonitor.
     ++ * VFS for Git is incompatible with FSMonitor.
      + *
     -+ * Granted, core Git does not know anything about GVFS and we
     ++ * Granted, core Git does not know anything about VFS for Git and we
      + * shouldn't make assumptions about a downstream feature, but users
      + * can install both versions.  And this can lead to incorrect results
     -+ * from core Git commands.  So, without bringing in any of the GVFS
     -+ * code, do a simple config test for a published config setting.  (We
     -+ * do not look at the various *_TEST_* environment variables.)
     ++ * from core Git commands.  So, without bringing in any of the VFS for
     ++ * Git code, do a simple config test for a published config setting.
     ++ * (We do not look at the various *_TEST_* environment variables.)
      + */
     -+static enum fsmonitor_reason is_virtual(struct repository *r)
     ++static enum fsmonitor_reason check_vfs4git(struct repository *r)
      +{
      +	const char *const_str;
      +
      +	if (!repo_config_get_value(r, "core.virtualfilesystem", &const_str))
     -+		return FSMONITOR_REASON_VIRTUAL;
     ++		return FSMONITOR_REASON_VFS4GIT;
      +
     -+	return FSMONITOR_REASON_ZERO;
     ++	return FSMONITOR_REASON_OK;
      +}
      +
       enum fsmonitor_reason fsm_os__incompatible(struct repository *r)
       {
      +	enum fsmonitor_reason reason;
      +
     -+	reason = is_virtual(r);
     -+	if (reason)
     ++	reason = check_vfs4git(r);
     ++	if (reason != FSMONITOR_REASON_OK)
      +		return reason;
      +
     - 	return FSMONITOR_REASON_ZERO;
     + 	return FSMONITOR_REASON_OK;
       }
      
       ## fsmonitor-settings.c ##
     -@@ fsmonitor-settings.c: static void create_reason_message(struct repository *r,
     - 			      _("bare repos are incompatible with fsmonitor"));
     - 		return;
     +@@ fsmonitor-settings.c: const char *fsm_settings__get_reason_msg(struct repository *r)
       
     -+	case FSMONITOR_REASON_VIRTUAL:
     -+		strbuf_addstr(buf_reason,
     -+			      _("virtual repos are incompatible with fsmonitor"));
     -+		return;
     + 	case FSMONITOR_REASON_BARE:
     + 		return _("bare repos are incompatible with fsmonitor");
      +
     - 	default:
     - 		BUG("Unhandled case in create_reason_message '%d'", s->reason);
     ++	case FSMONITOR_REASON_VFS4GIT:
     ++		return _("virtual repos are incompatible with fsmonitor");
       	}
     + 
     + 	BUG("Unhandled case in fsm_settings__get_reason_msg '%d'",
      
       ## fsmonitor-settings.h ##
      @@ fsmonitor-settings.h: enum fsmonitor_mode {
       enum fsmonitor_reason {
     - 	FSMONITOR_REASON_ZERO = 0,
     - 	FSMONITOR_REASON_BARE = 1,
     -+	FSMONITOR_REASON_VIRTUAL = 2,
     + 	FSMONITOR_REASON_OK = 0, /* no incompatibility or when disbled */
     + 	FSMONITOR_REASON_BARE,
     ++	FSMONITOR_REASON_VFS4GIT, /* VFS for Git virtualization */
       };
       
       void fsm_settings__set_ipc(struct repository *r);
  8:  e5511ef0f8b !  7:  c1802410410 fsmonitor-settings: stub in macOS-specific incompatibility checking
     @@ compat/fsmonitor/fsm-settings-darwin.c (new)
      +
      +enum fsmonitor_reason fsm_os__incompatible(struct repository *r)
      +{
     -+	return FSMONITOR_REASON_ZERO;
     ++	return FSMONITOR_REASON_OK;
      +}
      
       ## config.mak.uname ##
  9:  412fbc45868 !  8:  e3bfa0bd69d fsmonitor-settings: remote repos on macOS are incompatible with FSMonitor
     @@ Metadata
      Author: Jeff Hostetler <jeffhost@microsoft.com>
      
       ## Commit message ##
     -    fsmonitor-settings: remote repos on macOS are incompatible with FSMonitor
     +    fsmonitor-settings: remote repos on macOS are incompatible
      
          Teach Git to detect remote working directories on macOS and mark them as
          incompatible with FSMonitor.
     @@ compat/fsmonitor/fsm-settings-darwin.c
      + * So (for now at least), mark remote working directories as
      + * incompatible.
      + */
     -+static enum fsmonitor_reason is_remote(struct repository *r)
     ++static enum fsmonitor_reason check_remote(struct repository *r)
      +{
      +	struct statfs fs;
      +
     @@ compat/fsmonitor/fsm-settings-darwin.c
      +		trace_printf_key(&trace_fsmonitor, "statfs('%s') failed: %s",
      +				 r->worktree, strerror(saved_errno));
      +		errno = saved_errno;
     -+		return FSMONITOR_REASON_ZERO;
     ++		return FSMONITOR_REASON_ERROR;
      +	}
      +
      +	trace_printf_key(&trace_fsmonitor,
     @@ compat/fsmonitor/fsm-settings-darwin.c
      +	if (!(fs.f_flags & MNT_LOCAL))
      +		return FSMONITOR_REASON_REMOTE;
      +
     -+	return FSMONITOR_REASON_ZERO;
     ++	return FSMONITOR_REASON_OK;
      +}
       
       enum fsmonitor_reason fsm_os__incompatible(struct repository *r)
       {
      +	enum fsmonitor_reason reason;
      +
     -+	reason = is_remote(r);
     -+	if (reason)
     ++	reason = check_remote(r);
     ++	if (reason != FSMONITOR_REASON_OK)
      +		return reason;
      +
     - 	return FSMONITOR_REASON_ZERO;
     + 	return FSMONITOR_REASON_OK;
       }
      
       ## fsmonitor-settings.c ##
     -@@ fsmonitor-settings.c: static void create_reason_message(struct repository *r,
     - 			      _("virtual repos are incompatible with fsmonitor"));
     - 		return;
     +@@ fsmonitor-settings.c: const char *fsm_settings__get_reason_msg(struct repository *r)
     + 	case FSMONITOR_REASON_BARE:
     + 		return _("bare repos are incompatible with fsmonitor");
       
     ++	case FSMONITOR_REASON_ERROR:
     ++		return _("repo incompatible with fsmonitor due to errors");
     ++
      +	case FSMONITOR_REASON_REMOTE:
     -+		strbuf_addstr(buf_reason,
     -+			      _("remote repos are incompatible with fsmonitor"));
     -+		return;
     ++		return _("remote repos are incompatible with fsmonitor");
      +
     - 	default:
     - 		BUG("Unhandled case in create_reason_message '%d'", s->reason);
     + 	case FSMONITOR_REASON_VFS4GIT:
     + 		return _("virtual repos are incompatible with fsmonitor");
       	}
      
       ## fsmonitor-settings.h ##
     -@@ fsmonitor-settings.h: enum fsmonitor_reason {
     - 	FSMONITOR_REASON_ZERO = 0,
     - 	FSMONITOR_REASON_BARE = 1,
     - 	FSMONITOR_REASON_VIRTUAL = 2,
     -+	FSMONITOR_REASON_REMOTE = 3,
     +@@ fsmonitor-settings.h: enum fsmonitor_mode {
     + enum fsmonitor_reason {
     + 	FSMONITOR_REASON_OK = 0, /* no incompatibility or when disbled */
     + 	FSMONITOR_REASON_BARE,
     ++	FSMONITOR_REASON_ERROR, /* FS error probing for compatibility */
     ++	FSMONITOR_REASON_REMOTE,
     + 	FSMONITOR_REASON_VFS4GIT, /* VFS for Git virtualization */
       };
       
     - void fsm_settings__set_ipc(struct repository *r);
 10:  ae09fb10c3a !  9:  e32da3118fb fsmonitor-settings: remote repos on Windows are incompatible with FSMonitor
     @@ Metadata
      Author: Jeff Hostetler <jeffhost@microsoft.com>
      
       ## Commit message ##
     -    fsmonitor-settings: remote repos on Windows are incompatible with FSMonitor
     +    fsmonitor-settings: remote repos on Windows are incompatible
      
          Teach Git to detect remote working directories on Windows and mark them as
          incompatible with FSMonitor.
     @@ compat/fsmonitor/fsm-settings-win32.c
      +#include "fsmonitor.h"
       
       /*
     -  * GVFS (aka VFS for Git) is incompatible with FSMonitor.
     -@@ compat/fsmonitor/fsm-settings-win32.c: static enum fsmonitor_reason is_virtual(struct repository *r)
     - 	return FSMONITOR_REASON_ZERO;
     +  * VFS for Git is incompatible with FSMonitor.
     +@@ compat/fsmonitor/fsm-settings-win32.c: static enum fsmonitor_reason check_vfs4git(struct repository *r)
     + 	return FSMONITOR_REASON_OK;
       }
       
      +/*
     @@ compat/fsmonitor/fsm-settings-win32.c: static enum fsmonitor_reason is_virtual(s
      + *     $ mklink /d ./link //server/share/repo
      + *     $ git -C ./link status
      + */
     -+static enum fsmonitor_reason is_remote(struct repository *r)
     ++static enum fsmonitor_reason check_remote(struct repository *r)
      +{
      +	wchar_t wpath[MAX_PATH];
      +	wchar_t wfullpath[MAX_PATH];
     @@ compat/fsmonitor/fsm-settings-win32.c: static enum fsmonitor_reason is_virtual(s
      +	 * a multi-byte sequence.  See win32_has_dos_drive_prefix().
      +	 */
      +	if (xutftowcs_path(wpath, r->worktree) < 0)
     -+		return FSMONITOR_REASON_ZERO;
     ++		return FSMONITOR_REASON_ERROR;
      +
      +	/*
      +	 * GetDriveTypeW() requires a final slash.  We assume that the
     @@ compat/fsmonitor/fsm-settings-win32.c: static enum fsmonitor_reason is_virtual(s
      +	 * correctly handle some UNC "\\server\share\..." paths.
      +	 */
      +	if (!GetFullPathNameW(wpath, MAX_PATH, wfullpath, NULL))
     -+		return FSMONITOR_REASON_ZERO;
     ++		return FSMONITOR_REASON_ERROR;
      +
      +	driveType = GetDriveTypeW(wfullpath);
      +	trace_printf_key(&trace_fsmonitor,
     @@ compat/fsmonitor/fsm-settings-win32.c: static enum fsmonitor_reason is_virtual(s
      +
      +	if (driveType == DRIVE_REMOTE) {
      +		trace_printf_key(&trace_fsmonitor,
     -+				 "is_remote('%s') true",
     ++				 "check_remote('%s') true",
      +				 r->worktree);
      +		return FSMONITOR_REASON_REMOTE;
      +	}
      +
     -+	return FSMONITOR_REASON_ZERO;
     ++	return FSMONITOR_REASON_OK;
      +}
      +
       enum fsmonitor_reason fsm_os__incompatible(struct repository *r)
       {
       	enum fsmonitor_reason reason;
      @@ compat/fsmonitor/fsm-settings-win32.c: enum fsmonitor_reason fsm_os__incompatible(struct repository *r)
     - 	if (reason)
     + 	if (reason != FSMONITOR_REASON_OK)
       		return reason;
       
     -+	reason = is_remote(r);
     -+	if (reason)
     ++	reason = check_remote(r);
     ++	if (reason != FSMONITOR_REASON_OK)
      +		return reason;
      +
     - 	return FSMONITOR_REASON_ZERO;
     + 	return FSMONITOR_REASON_OK;
       }
 11:  be1672e32b2 = 10:  f63de4eda31 unpack-trees: initialize fsmonitor_has_run_once in o->result
 12:  71babe7243a = 11:  fe305f5f287 fsm-listen-darwin: ignore FSEvents caused by xattr changes on macOS
 14:  95cdff22be0 ! 12:  c8f3e251b1f fsmonitor--daemon: cd out of worktree root
     @@ builtin/fsmonitor--daemon.c: done:
       	strbuf_release(&state.path_cookie_prefix);
      +	strbuf_release(&state.path_ipc);
       
     - 	/*
     - 	 * NEEDSWORK: Consider "rm -rf <gitdir>/<fsmonitor-dir>"
     + 	return err;
     + }
      
       ## compat/fsmonitor/fsm-listen-win32.c ##
      @@ compat/fsmonitor/fsm-listen-win32.c: static int recv_rdcw_watch(struct one_watch *watch)
 15:  6b5642f7770 = 13:  71673be2da5 fsmonitor--daemon: prepare for adding health thread
 16:  63c502c20bd = 14:  5387baaf5d7 fsmonitor--daemon: rename listener thread related variables
 17:  4a77f5b1fde ! 15:  f78e4ad87c0 fsmonitor--daemon: stub in health thread
     @@ Commit message
          file system events outside of the watched worktree root or if
          we want to have an idle-timeout auto-shutdown feature.
      
     +    This commit creates the health thread itself, defines the thread-proc
     +    and sets up the thread's event loop.  It integrates this new thread
     +    into the existing IPC and Listener thread models.
     +
     +    This commit defines the API to the platform-specific code where all of
     +    the monitoring will actually happen.
     +
     +    The platform-specific code for MacOS is just stubs.  Meaning that the
     +    health thread will immediately exit on MacOS, but that is OK and
     +    expected.  Future work can define MacOS-specific monitoring.
     +
     +    The platform-specific code for Windows sets up enough of the
     +    WaitForMultipleObjects() machinery to watch for system and/or custom
     +    events.  Currently, the set of wait handles only includes our custom
     +    shutdown event (sent from our other theads).  Later commits in this
     +    series will extend the set of wait handles to monitor other
     +    conditions.
     +
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
      
       ## Makefile ##
     @@ Makefile: all::
      +# `compat/fsmonitor/fsm-health-<name>.c` files
      +# that implement the `fsm_listen__*()` and `fsm_health__*()` routines.
       #
     - # If your platform has os-specific ways to tell if a repo is incompatible with
     - # fsmonitor (whether the hook or ipc daemon version), set FSMONITOR_OS_SETTINGS
     + # If your platform has OS-specific ways to tell if a repo is incompatible with
     + # fsmonitor (whether the hook or IPC daemon version), set FSMONITOR_OS_SETTINGS
      @@ Makefile: endif
       ifdef FSMONITOR_DAEMON_BACKEND
       	COMPAT_CFLAGS += -DHAVE_FSMONITOR_DAEMON_BACKEND
 18:  a398cdb8a04 ! 16:  bb72f911a05 fsm-health-win32: add framework to monitor daemon health
     @@ Metadata
      Author: Jeff Hostetler <jeffhost@microsoft.com>
      
       ## Commit message ##
     -    fsm-health-win32: add framework to monitor daemon health
     +    fsm-health-win32: add polling framework to monitor daemon health
      
     -    Create framework in Win32 version of the "health" thread to
     -    periodically inspect the system and shutdown if warranted.
     +    Extend the Windows version of the "health" thread to periodically
     +    inspect the system and shutdown if warranted.
      
     -    This version just includes the setup for the timeout in
     -    WaitForMultipleObjects() and calls the (currently empty) table
     -    of functions.
     +    This commit updates the thread's wait loop to use a timeout and
     +    defines a (currently empty) table of functions to poll the system.
      
          A later commit will add functions to the table to actually
          inspect the system.
     @@ compat/fsmonitor/fsm-health-win32.c
      + */
      +#define WAIT_FREQ_MS (60 * 1000)
      +
     -+enum interval_fn_ctx { CTX_INIT = 0, CTX_TERM, CTX_TIMER };
     ++/*
     ++ * State machine states for each of the interval functions
     ++ * used for polling our health.
     ++ */
     ++enum interval_fn_ctx {
     ++	CTX_INIT = 0,
     ++	CTX_TERM,
     ++	CTX_TIMER
     ++};
      +
      +typedef int (interval_fn)(struct fsmonitor_daemon_state *state,
      +			  enum interval_fn_ctx ctx);
      +
     + struct fsm_health_data
     + {
     + 	HANDLE hEventShutdown;
     +@@ compat/fsmonitor/fsm-health-win32.c: void fsm_health__dtor(struct fsmonitor_daemon_state *state)
     + 	FREE_AND_NULL(state->health_data);
     + }
     + 
     ++/*
     ++ * A table of the polling functions.
     ++ */
      +static interval_fn *table[] = {
      +	NULL, /* must be last */
      +};
      +
      +/*
     -+ * Call all of the functions in the table.
     ++ * Call all of the polling functions in the table.
      + * Shortcut and return first error.
      + *
      + * Return 0 if all succeeded.
     @@ compat/fsmonitor/fsm-health-win32.c
      +	return 0;
      +}
      +
     - struct fsm_health_data
     - {
     - 	HANDLE hEventShutdown;
     -@@ compat/fsmonitor/fsm-health-win32.c: void fsm_health__dtor(struct fsmonitor_daemon_state *state)
       void fsm_health__loop(struct fsmonitor_daemon_state *state)
       {
       	struct fsm_health_data *data = state->health_data;
 19:  023fcd6e2b1 ! 17:  baf8c031a97 fsm-health-win32: force shutdown daemon if worktree root moves
     @@ Commit message
          Force shutdown fsmonitor daemon if the worktree root directory
          is moved, renamed, or deleted.
      
     +    Use Windows low-level GetFileInformationByHandle() to get and
     +    compare the Windows system unique ID for the directory with a
     +    cached version when we started up.  This lets us detect the
     +    case where someone renames the directory that we are watching
     +    and then creates a new directory with the original pathname.
     +
     +    This is important because we are listening to a named pipe for
     +    requests and they are stored in the Named Pipe File System (NPFS)
     +    which a kernel-resident pseudo filesystem not associated with
     +    the actual NTFS directory.
     +
     +    For example, if the daemon was watching "~/foo/", it would have
     +    a directory-watch handle on that directory and a named-pipe
     +    handle for "//./pipe/...foo".  Moving the directory to "~/bar/"
     +    does not invalidate the directory handle.  (So the daemon would
     +    actually be watching "~/bar" but listening on "//./pipe/...foo".
     +    If the user then does "git init ~/foo" and causes another daemon
     +    to start, the first daemon will still have ownership of the pipe
     +    and the second daemon instance will fail to start.  "git status"
     +    clients in "~/foo" will ask "//./pipe/...foo" about changes and
     +    the first daemon instance will tell them about "~/bar".
     +
     +    This commit causes the first daemon to shutdown if the system unique
     +    ID for "~/foo" changes (changes from what it was when the daemon
     +    started).  Shutdown occurs after a periodic poll.  After the
     +    first daemon exits and releases the lock on the named pipe,
     +    subsequent Git commands may cause another daemon to be started
     +    on "~/foo".  Similarly, a subsequent Git command may cause another
     +    daemon to be started on "~/bar".
     +
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
      
       ## compat/fsmonitor/fsm-health-win32.c ##
     -@@ compat/fsmonitor/fsm-health-win32.c: enum interval_fn_ctx { CTX_INIT = 0, CTX_TERM, CTX_TIMER };
     - typedef int (interval_fn)(struct fsmonitor_daemon_state *state,
     - 			  enum interval_fn_ctx ctx);
     - 
     -+static interval_fn has_worktree_moved;
     -+
     - static interval_fn *table[] = {
     -+	has_worktree_moved,
     - 	NULL, /* must be last */
     - };
     - 
      @@ compat/fsmonitor/fsm-health-win32.c: struct fsm_health_data
       	HANDLE hHandles[1]; /* the array does not own these handles */
       #define HEALTH_SHUTDOWN 0
     @@ compat/fsmonitor/fsm-health-win32.c: struct fsm_health_data
      +	} wt_moved;
       };
       
     - int fsm_health__ctor(struct fsmonitor_daemon_state *state)
     -@@ compat/fsmonitor/fsm-health-win32.c: void fsm_health__dtor(struct fsmonitor_daemon_state *state)
     - 	FREE_AND_NULL(state->health_data);
     - }
     - 
     ++/*
     ++ * Lookup the system unique ID for the path.  This is as close as
     ++ * we get to an inode number, but this also contains volume info,
     ++ * so it is a little stronger.
     ++ */
      +static int lookup_bhfi(wchar_t *wpath,
      +		       BY_HANDLE_FILE_INFORMATION *bhfi)
      +{
     @@ compat/fsmonitor/fsm-health-win32.c: void fsm_health__dtor(struct fsmonitor_daem
      +	return 0;
      +}
      +
     ++/*
     ++ * Compare the relevant fields from two system unique IDs.
     ++ * We use this to see if two different handles to the same
     ++ * path actually refer to the same *instance* of the file
     ++ * or directory.
     ++ */
      +static int bhfi_eq(const BY_HANDLE_FILE_INFORMATION *bhfi_1,
      +		   const BY_HANDLE_FILE_INFORMATION *bhfi_2)
      +{
     @@ compat/fsmonitor/fsm-health-win32.c: void fsm_health__dtor(struct fsmonitor_daem
      +	return 0;
      +}
      +
     - void fsm_health__loop(struct fsmonitor_daemon_state *state)
     ++
     + int fsm_health__ctor(struct fsmonitor_daemon_state *state)
       {
     - 	struct fsm_health_data *data = state->health_data;
     + 	struct fsm_health_data *data;
     +@@ compat/fsmonitor/fsm-health-win32.c: void fsm_health__dtor(struct fsmonitor_daemon_state *state)
     +  * A table of the polling functions.
     +  */
     + static interval_fn *table[] = {
     ++	has_worktree_moved,
     + 	NULL, /* must be last */
     + };
     + 
 20:  496b3da35d0 ! 18:  796b6591393 fsm-listen-darwin: shutdown daemon if worktree root is moved/renamed
     @@ compat/fsmonitor/fsm-listen-darwin.c: static void fsevent_callback(ConstFSEventS
      +			/*
      +			 * The spelling of the pathname of the root directory
      +			 * has changed.  This includes the name of the root
     -+			 * directory itself of of any parent directory in the
     ++			 * directory itself or of any parent directory in the
      +			 * path.
      +			 *
      +			 * (There may be other conditions that throw this,
 21:  07a9c7542be = 19:  24591920878 fsmonitor: optimize processing of directory events
 22:  f065e8c9a90 = 20:  06a32413854 t7527: FSMonitor tests for directory moves
 23:  e5a12832afa = 21:  4b59013cadd t/perf/p7527: add perf test for builtin FSMonitor
  -:  ----------- > 22:  524d449ed64 fsmonitor: never set CE_FSMONITOR_VALID on submodules
  2:  ad8cf6d9a47 ! 23:  c7264decaf6 t7527: test FS event reporing on macOS WRT case and Unicode
     @@ Metadata
      Author: Jeff Hostetler <jeffhost@microsoft.com>
      
       ## Commit message ##
     -    t7527: test FS event reporing on macOS WRT case and Unicode
     +    t7527: test FSMonitor on case insensitive+preserving file system
      
     -    Confirm that macOS FS events are reported with a normalized spelling.
     -
     -    APFS (and/or HFS+) is case-insensitive.  This means that case-independent
     -    lookups ( [ -d .git ] and [ -d .GIT ] ) should both succeed.  But that
     -    doesn't tell us how FS events are reported if we try "rm -rf .git" versus
     -    "rm -rf .GIT".  Are the events reported using the on-disk spelling of the
     -    pathname or in the spelling used by the command.
     -
     -    NEEDSWORK: I was only able to test case.  It would be nice to add tests
     -    that use different Unicode spellings/normalizations and understand the
     -    differences between APFS and HFS+ in this area.  We should confirm that
     -    the spelling of the workdir paths that the daemon sends to clients are
     -    always properly normalized.
     +    Test that FS events from the OS are received using the preserved,
     +    on-disk spelling of files/directories rather than spelling used
     +    to make the change.
      
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
      
       ## t/t7527-builtin-fsmonitor.sh ##
     -@@ t/t7527-builtin-fsmonitor.sh: test_expect_success MINGW,SHORTNAMES 'implicit daemon stop (rename GIT~2)' '
     - 	test_must_fail git -C test_implicit_1s2 fsmonitor--daemon status
     +@@ t/t7527-builtin-fsmonitor.sh: test_expect_success "Submodule" '
     + 	my_match_and_clean
       '
       
     -+# Confirm that MacOS hides all of the Unicode normalization and/or
     -+# case folding from the FS events.  That is, are the pathnames in the
     -+# FS events reported using the spelling on the disk or in the spelling
     -+# used by the other process.
     -+#
     -+# Note that we assume that the filesystem is set to case insensitive.
     -+#
     -+# NEEDSWORK: APFS handles Unicode and Unicode normalization
     -+# differently than HFS+.  I only have an APFS partition, so
     -+# more testing here would be helpful.
     ++# On a case-insensitive file system, confirm that the daemon
     ++# notices when the .git directory is moved/renamed/deleted
     ++# regardless of how it is spelled in the the FS event.
     ++# That is, does the FS event receive the spelling of the
     ++# operation or does it receive the spelling preserved with
     ++# the file/directory.
      +#
     ++test_expect_success CASE_INSENSITIVE_FS 'case insensitive+preserving' '
     ++#	test_when_finished "stop_daemon_delete_repo test_insensitive" &&
     ++
     ++	git init test_insensitive &&
     ++	(
     ++		GIT_TRACE_FSMONITOR="$(pwd)/insensitive.trace" &&
     ++		export GIT_TRACE_FSMONITOR &&
      +
     -+# Rename .git using alternate spelling and confirm that the daemon
     -+# sees the event using the correct spelling and shutdown.
     -+test_expect_success UTF8_NFD_TO_NFC 'MacOS event spelling (rename .GIT)' '
     -+	test_when_finished "stop_daemon_delete_repo test_apfs" &&
     ++		start_daemon test_insensitive
     ++	) &&
      +
     -+	git init test_apfs &&
     -+	start_daemon test_apfs &&
     ++	mkdir -p test_insensitive/abc/def &&
     ++	echo xyz >test_insensitive/ABC/DEF/xyz &&
      +
     -+	test_path_is_dir test_apfs/.git &&
     -+	test_path_is_dir test_apfs/.GIT &&
     ++	test_path_is_dir test_insensitive/.git &&
     ++	test_path_is_dir test_insensitive/.GIT &&
      +
     -+	mv test_apfs/.GIT test_apfs/.FOO &&
     ++	# Rename .git using an alternate spelling to verify that that
     ++	# daemon detects it and automatically shuts down.
     ++	mv test_insensitive/.GIT test_insensitive/.FOO &&
      +	sleep 1 &&
     -+	mv test_apfs/.FOO test_apfs/.git &&
     ++	mv test_insensitive/.FOO test_insensitive/.git &&
     ++	test_must_fail git -C test_insensitive fsmonitor--daemon status &&
      +
     -+	test_must_fail git -C test_apfs fsmonitor--daemon status
     ++	# Verify that events were reported using on-disk spellings of the
     ++	# directories and files that we touched.  We may or may not get a
     ++	# trailing slash on modified directories.
     ++	#
     ++	egrep "^event: abc/?$"       ./insensitive.trace &&
     ++	egrep "^event: abc/def/?$"   ./insensitive.trace &&
     ++	egrep "^event: abc/def/xyz$" ./insensitive.trace
      +'
      +
     - test_expect_success 'cannot start multiple daemons' '
     - 	test_when_finished "stop_daemon_delete_repo test_multiple" &&
     - 
     + test_done
 13:  f19671f7def <  -:  ----------- fsmonitor--daemon: print start message only if fsmonitor.announceStartup
  -:  ----------- > 24:  95b9d4210d2 fsmonitor: on macOS also emit NFC spelling for NFD pathname
  -:  ----------- > 25:  5a0c1b7a287 t/lib-unicode-nfc-nfd: helper prereqs for testing unicode nfc/nfd
  -:  ----------- > 26:  a45c1fd3000 t7527: test Unicode NFC/NFD handling on MacOS
  -:  ----------- > 27:  e3e01677d93 fsmonitor-settings: NTFS and FAT32 on MacOS are incompatible

-- 
gitgitgadget
