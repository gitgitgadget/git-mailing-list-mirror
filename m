Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1794AC433F5
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 22:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbiDVWjH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 18:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233908AbiDVWhw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 18:37:52 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C541F9E0C
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 14:29:58 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id o20-20020a05600c511400b0038ebbbb2ad8so6076348wms.0
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 14:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1ClCM7qybM/dqt4tAZrfeoY6QI7qujQC5NKVx2bcV6Y=;
        b=dmDAHIkVgsDbDUx5MXBEzXMF9F15XUd41qnTApD0BMGmeImfxhR8IWhqUI2kwb19Gu
         Kv25QrOdbEoAbGM31UX0mJi6EmKqjVb7Iz/8Ved+jepA9qQGwi0G8ZYVs4P+7zVS6OyC
         UvJpsbL5E5sawFYSVgM75HrvhwT/hHDzFfMppl56Uo0gnr+F43gfaMmcfj5gH2gaX/37
         vnOuCAzdqN9oD3H3Z/44C9sbl4irEkJB/nLFXyD6Yl2Ur27IzleR6F7Bv4pil4LAa/EZ
         /gTXfl+KUVQBFxA65I49Pf7KuQAzGNzqfnRHwNg26sIJeMYue0sVFLFAaYk3VbSVYpAr
         oRiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1ClCM7qybM/dqt4tAZrfeoY6QI7qujQC5NKVx2bcV6Y=;
        b=TCGZKvtsKt/D4xgQbp7+R8BAFwzHB4E0n4bTW1oitocaTfY/PBRuzktFkCnmZCkAvw
         kzm7OvYG+h8cpwIwI65si3PBPIisOR8Iq5KdkhlJYgEqh7Am7XNq4eVZBrdJQQhsTnwG
         5n+Y3PxL8ayCa08S6zdmyPxlPNFyuHeT76J9cwco6LGuntcg0EqYp2MAee0TyKVQ6wNY
         K9gSBHSmqI8HXJ/o/iKeBwSwlqmgMMUZIi4esemRDnJs7KyQ0Wjpw4I9sULeO4AxfIsL
         AvjWx0jg63T+PjuJP4MwrKWX9QyikTqsBJ1yrIEDTwX0AKQeDGdWNLFPdQQDwkL3KLlD
         KBog==
X-Gm-Message-State: AOAM532VUGX6pmtzZcEmLPE6Wwl7f4KDqqTAl9zZDlJGxP3OVxkzmXfM
        fS06Rv3DPOR+Zn81Kgwm1zKCi3TXwjA=
X-Google-Smtp-Source: ABdhPJyimtK9Wn1VF0ItFE+7GPuZM0YTe4ab4upGk1ho869Z4elMhWgtgjLfjZe+uiHixiXec9zl9Q==
X-Received: by 2002:a05:600c:3b8b:b0:392:9897:1edf with SMTP id n11-20020a05600c3b8b00b0039298971edfmr14909921wms.108.1650662995800;
        Fri, 22 Apr 2022 14:29:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e9-20020a056000178900b0020a9f995a3csm2668401wrg.24.2022.04.22.14.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 14:29:55 -0700 (PDT)
Message-Id: <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>
References: <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Apr 2022 21:29:26 +0000
Subject: [PATCH v6 00/28] Builtin FSMonitor Part 3
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
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is version 6 of part 3 of FSMonitor.

This version addresses:

 1. Junio's comments on V5 23/28 WRT shell variable references and quoting
    pathnames in the create_super and create_sub helper functions.

 2. Ævar's comments on V4 4/27 (sorry I didn't see them until after I sent
    V5) WRT somewhat blurry logic around the fsmonitor-settings and
    detecting incompatible worktrees. I simplified things, but not to the
    level that Ævar was suggesting. For example, in builtin/update-index.c
    the suggestion was to detect incompatible FS before taking the lock on
    the index, but the lock is taken before the CL args are parsed (because
    update-index uses a custom version of parse_options_start()), so we
    don't know yet whether the user passed --fsmonitor until much later and
    that is what triggers the error/warning. I did replace the return 1 with
    a die() so hopefully, we'll release the lock on the index like all of
    the other errors in that function. I did try to better document the code
    in update-index.c and in builtin/fsmonitor--daemon.c to explain how
    things are supposed to work. So hopefully it'll be easier to review.

 3. Also, in update-index and fsmonitor--daemon, I redid how the error
    messages are printed, so that I could use die() in the cmd_*() functions
    rather than having calls to error() hidden inside fsmonitor-settings.c.
    I think that helped with the above cleanup.

Here is a range diff from V5. It is a little noisy because of the untangling
within fsmonitor-settings.c and moving the error messages.

 1:  8b7c5f4e23 =  1:  8b7c5f4e23 fsm-listen-win32: handle shortnames
 2:  5b246bec24 =  2:  5b246bec24 t7527: test FSMonitor on repos with Unicode root paths
 3:  8a474d6999 =  3:  8a474d6999 t/helper/fsmonitor-client: create stress test
 4:  004b67b62e <  -:  ---------- fsmonitor-settings: bare repos are incompatible with FSMonitor
 -:  ---------- >  4:  72b94acd5f fsmonitor-settings: bare repos are incompatible with FSMonitor
 5:  e1e55550c1 !  5:  2e225c3f4f fsmonitor-settings: stub in Win32-specific incompatibility checking
    @@ contrib/buildsystems/CMakeLists.txt: if(SUPPORTS_SIMPLE_IPC)
              list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-darwin.c)
     
      ## fsmonitor-settings.c ##
    -@@ fsmonitor-settings.c: static int check_for_incompatible(struct repository *r)
    - 		return 1;
    +@@ fsmonitor-settings.c: static enum fsmonitor_reason check_for_incompatible(struct repository *r)
    + 		return FSMONITOR_REASON_BARE;
          }
      
     +#ifdef HAVE_FSMONITOR_OS_SETTINGS
    @@ fsmonitor-settings.c: static int check_for_incompatible(struct repository *r)
     +		enum fsmonitor_reason reason;
     +
     +		reason = fsm_os__incompatible(r);
    -+		if (reason != FSMONITOR_REASON_OK) {
    -+			set_incompatible(r, reason);
    -+			return 1;
    -+		}
    ++		if (reason != FSMONITOR_REASON_OK)
    ++			return reason;
     +	}
     +#endif
     +
    - 	return 0;
    + 	return FSMONITOR_REASON_OK;
      }
      
     
      ## fsmonitor-settings.h ##
    -@@ fsmonitor-settings.h: int fsm_settings__error_if_incompatible(struct repository *r);
    +@@ fsmonitor-settings.h: char *fsm_settings__get_incompatible_msg(const struct repository *r,
      
      struct fsmonitor_settings;
      
 6:  2d68fc9a46 !  6:  e0d3bdf755 fsmonitor-settings: VFS for Git virtual repos are incompatible
    @@ compat/fsmonitor/fsm-settings-win32.c
      }
     
      ## fsmonitor-settings.c ##
    -@@ fsmonitor-settings.c: int fsm_settings__error_if_incompatible(struct repository *r)
    - 		error(_("bare repository '%s' is incompatible with fsmonitor"),
    - 		      xgetcwd());
    - 		return 1;
    +@@ fsmonitor-settings.c: char *fsm_settings__get_incompatible_msg(const struct repository *r,
    + 			    _("bare repository '%s' is incompatible with fsmonitor"),
    + 			    xgetcwd());
    + 		goto done;
     +
     +	case FSMONITOR_REASON_VFS4GIT:
    -+		error(_("virtual repository '%s' is incompatible with fsmonitor"),
    -+		      r->worktree);
    -+		return 1;
    ++		strbuf_addf(&msg,
    ++			    _("virtual repository '%s' is incompatible with fsmonitor"),
    ++			    r->worktree);
    ++		goto done;
          }
      
    - 	BUG("Unhandled case in fsm_settings__error_if_incompatible: '%d'",
    + 	BUG("Unhandled case in fsm_settings__get_incompatible_msg: '%d'",
     
      ## fsmonitor-settings.h ##
    -@@ fsmonitor-settings.h: enum fsmonitor_mode {
    - enum fsmonitor_reason {
    - 	FSMONITOR_REASON_OK = 0, /* no incompatibility or when disbled */
    +@@ fsmonitor-settings.h: enum fsmonitor_reason {
    + 	FSMONITOR_REASON_UNTESTED = 0,
    + 	FSMONITOR_REASON_OK, /* no incompatibility or when disbled */
          FSMONITOR_REASON_BARE,
     +	FSMONITOR_REASON_VFS4GIT, /* VFS for Git virtualization */
      };
 7:  94ae2e424f =  7:  c50ed29a31 fsmonitor-settings: stub in macOS-specific incompatibility checking
 8:  b2ca6c1b20 !  8:  1f5b772d42 fsmonitor-settings: remote repos on macOS are incompatible
    @@ compat/fsmonitor/fsm-settings-darwin.c
      }
     
      ## fsmonitor-settings.c ##
    -@@ fsmonitor-settings.c: int fsm_settings__error_if_incompatible(struct repository *r)
    - 		      xgetcwd());
    - 		return 1;
    +@@ fsmonitor-settings.c: char *fsm_settings__get_incompatible_msg(const struct repository *r,
    + 			    xgetcwd());
    + 		goto done;
      
     +	case FSMONITOR_REASON_ERROR:
    -+		error(_("repository '%s' is incompatible with fsmonitor due to errors"),
    -+		      r->worktree);
    -+		return 1;
    ++		strbuf_addf(&msg,
    ++			    _("repository '%s' is incompatible with fsmonitor due to errors"),
    ++			    r->worktree);
    ++		goto done;
     +
     +	case FSMONITOR_REASON_REMOTE:
    -+		error(_("remote repository '%s' is incompatible with fsmonitor"),
    -+		      r->worktree);
    -+		return 1;
    ++		strbuf_addf(&msg,
    ++			    _("remote repository '%s' is incompatible with fsmonitor"),
    ++			    r->worktree);
    ++		goto done;
     +
          case FSMONITOR_REASON_VFS4GIT:
    - 		error(_("virtual repository '%s' is incompatible with fsmonitor"),
    - 		      r->worktree);
    + 		strbuf_addf(&msg,
    + 			    _("virtual repository '%s' is incompatible with fsmonitor"),
     
      ## fsmonitor-settings.h ##
    -@@ fsmonitor-settings.h: enum fsmonitor_mode {
    - enum fsmonitor_reason {
    - 	FSMONITOR_REASON_OK = 0, /* no incompatibility or when disbled */
    +@@ fsmonitor-settings.h: enum fsmonitor_reason {
    + 	FSMONITOR_REASON_UNTESTED = 0,
    + 	FSMONITOR_REASON_OK, /* no incompatibility or when disbled */
          FSMONITOR_REASON_BARE,
     +	FSMONITOR_REASON_ERROR, /* FS error probing for compatibility */
     +	FSMONITOR_REASON_REMOTE,
 9:  a3cc4b3b16 =  9:  495e54049b fsmonitor-settings: remote repos on Windows are incompatible
10:  8f1f484075 ! 10:  4b52083698 fsmonitor-settings: NTFS and FAT32 on MacOS are incompatible
    @@ compat/fsmonitor/fsm-settings-darwin.c: enum fsmonitor_reason fsm_os__incompatib
      
     
      ## fsmonitor-settings.c ##
    -@@ fsmonitor-settings.c: int fsm_settings__error_if_incompatible(struct repository *r)
    - 		error(_("virtual repository '%s' is incompatible with fsmonitor"),
    - 		      r->worktree);
    - 		return 1;
    +@@ fsmonitor-settings.c: char *fsm_settings__get_incompatible_msg(const struct repository *r,
    + 			    _("virtual repository '%s' is incompatible with fsmonitor"),
    + 			    r->worktree);
    + 		goto done;
     +
     +	case FSMONITOR_REASON_NOSOCKETS:
    -+		error(_("repository '%s' is incompatible with fsmonitor due to lack of Unix sockets"),
    -+		      r->worktree);
    -+		return 1;
    ++		strbuf_addf(&msg,
    ++			    _("repository '%s' is incompatible with fsmonitor due to lack of Unix sockets"),
    ++			    r->worktree);
    ++		goto done;
          }
      
    - 	BUG("Unhandled case in fsm_settings__error_if_incompatible: '%d'",
    + 	BUG("Unhandled case in fsm_settings__get_incompatible_msg: '%d'",
     
      ## fsmonitor-settings.h ##
     @@ fsmonitor-settings.h: enum fsmonitor_reason {
11:  8d48d9c562 = 11:  d4a4263d37 unpack-trees: initialize fsmonitor_has_run_once in o->result
12:  088c7b3334 = 12:  f4feb00ec2 fsm-listen-darwin: ignore FSEvents caused by xattr changes on macOS
13:  00fab62666 = 13:  dbb983fd9d fsmonitor--daemon: cd out of worktree root
14:  6552f51802 = 14:  ae90b99ea9 fsmonitor--daemon: prepare for adding health thread
15:  f2bf07cd73 = 15:  b6c5800095 fsmonitor--daemon: rename listener thread related variables
16:  2a44f2eded = 16:  32fc6ba743 fsmonitor--daemon: stub in health thread
17:  854fb5e365 = 17:  77bc037481 fsm-health-win32: add polling framework to monitor daemon health
18:  3af1fe0d61 = 18:  b06edd995e fsm-health-win32: force shutdown daemon if worktree root moves
19:  f1365cdd40 = 19:  1bd5f34624 fsm-listen-darwin: shutdown daemon if worktree root is moved/renamed
20:  15698d64ed = 20:  48af0813de fsmonitor: optimize processing of directory events
21:  9d0da8fc22 = 21:  a9b35e770f t7527: FSMonitor tests for directory moves
22:  040c00cfd6 = 22:  26308936af t/perf/p7527: add perf test for builtin FSMonitor
23:  5db241f7d2 ! 23:  d0e25f6bac fsmonitor: never set CE_FSMONITOR_VALID on submodules
    @@ t/t7527-builtin-fsmonitor.sh: do
     +# submodule.
     +
     +create_super () {
    -+	super=$1 &&
    -+
    -+	git init "${super}" &&
    -+	echo x >${super}/file_1 &&
    -+	echo y >${super}/file_2 &&
    -+	echo z >${super}/file_3 &&
    -+	mkdir ${super}/dir_1 &&
    -+	echo a >${super}/dir_1/file_11 &&
    -+	echo b >${super}/dir_1/file_12 &&
    -+	mkdir ${super}/dir_1/dir_2 &&
    -+	echo a >${super}/dir_1/dir_2/file_21 &&
    -+	echo b >${super}/dir_1/dir_2/file_22 &&
    -+	git -C ${super} add . &&
    -+	git -C ${super} commit -m "initial ${super} commit"
    ++	super="$1" &&
    ++
    ++	git init "$super" &&
    ++	echo x >"$super/file_1" &&
    ++	echo y >"$super/file_2" &&
    ++	echo z >"$super/file_3" &&
    ++	mkdir "$super/dir_1" &&
    ++	echo a >"$super/dir_1/file_11" &&
    ++	echo b >"$super/dir_1/file_12" &&
    ++	mkdir "$super/dir_1/dir_2" &&
    ++	echo a >"$super/dir_1/dir_2/file_21" &&
    ++	echo b >"$super/dir_1/dir_2/file_22" &&
    ++	git -C "$super" add . &&
    ++	git -C "$super" commit -m "initial $super commit"
     +}
     +
     +create_sub () {
    -+	sub=$1 &&
    -+
    -+	git init "${sub}" &&
    -+	echo x >${sub}/file_x &&
    -+	echo y >${sub}/file_y &&
    -+	echo z >${sub}/file_z &&
    -+	mkdir ${sub}/dir_x &&
    -+	echo a >${sub}/dir_x/file_a &&
    -+	echo b >${sub}/dir_x/file_b &&
    -+	mkdir ${sub}/dir_x/dir_y &&
    -+	echo a >${sub}/dir_x/dir_y/file_a &&
    -+	echo b >${sub}/dir_x/dir_y/file_b &&
    -+	git -C ${sub} add . &&
    -+	git -C ${sub} commit -m "initial ${sub} commit"
    ++	sub="$1" &&
    ++
    ++	git init "$sub" &&
    ++	echo x >"$sub/file_x" &&
    ++	echo y >"$sub/file_y" &&
    ++	echo z >"$sub/file_z" &&
    ++	mkdir "$sub/dir_x" &&
    ++	echo a >"$sub/dir_x/file_a" &&
    ++	echo b >"$sub/dir_x/file_b" &&
    ++	mkdir "$sub/dir_x/dir_y" &&
    ++	echo a >"$sub/dir_x/dir_y/file_a" &&
    ++	echo b >"$sub/dir_x/dir_y/file_b" &&
    ++	git -C "$sub" add . &&
    ++	git -C "$sub" commit -m "initial $sub commit"
     +}
     +
     +my_match_and_clean () {
    @@ t/t7527-builtin-fsmonitor.sh: do
     +			    rm -rf super; \
     +			    rm -rf sub" &&
     +
    -+	create_super "super" &&
    -+	create_sub "sub" &&
    ++	create_super super &&
    ++	create_sub sub &&
     +
     +	git -C super submodule add ../sub ./dir_1/dir_2/sub &&
     +	git -C super commit -m "add sub" &&
24:  93de3707d2 = 24:  410dd2d292 t7527: test FSMonitor on case insensitive+preserving file system
25:  d890c2e2d9 = 25:  cd7c55b0d3 fsmonitor: on macOS also emit NFC spelling for NFD pathname
26:  7c60623555 = 26:  8278f32c4d t/lib-unicode-nfc-nfd: helper prereqs for testing unicode nfc/nfd
27:  9724c41d18 = 27:  4efb3a4383 t7527: test Unicode NFC/NFD handling on MacOS
28:  b8325fb7c7 ! 28:  df1b4f3a80 fsmonitor--daemon: allow --super-prefix argument
    @@ t/t7527-builtin-fsmonitor.sh: test_expect_success "Submodule always visited" '
     +			    rm -rf sub;   \
     +			    rm super-sub.trace" &&
     +
    -+	create_super "super" &&
    -+	create_sub "sub" &&
    ++	create_super super &&
    ++	create_sub sub &&
     +
     +	# Copy rather than submodule add so that we get a .git dir.
     +	cp -R ./sub ./super/dir_1/dir_2/sub &&


Jeff Hostetler (28):
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
  fsmonitor--daemon: allow --super-prefix argument

 Makefile                               |  19 +-
 builtin/fsmonitor--daemon.c            | 116 ++++++-
 builtin/update-index.c                 |  16 +
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
 fsmonitor-settings.c                   | 167 ++++++++--
 fsmonitor-settings.h                   |  33 ++
 fsmonitor.c                            |  73 ++++-
 fsmonitor.h                            |  11 +
 git.c                                  |   2 +-
 t/helper/test-fsmonitor-client.c       | 106 +++++++
 t/lib-unicode-nfc-nfd.sh               | 167 ++++++++++
 t/perf/p7527-builtin-fsmonitor.sh      | 257 +++++++++++++++
 t/t7519-status-fsmonitor.sh            |  32 ++
 t/t7527-builtin-fsmonitor.sh           | 367 ++++++++++++++++++++++
 unpack-trees.c                         |   1 +
 25 files changed, 2358 insertions(+), 145 deletions(-)
 create mode 100644 compat/fsmonitor/fsm-health-darwin.c
 create mode 100644 compat/fsmonitor/fsm-health-win32.c
 create mode 100644 compat/fsmonitor/fsm-health.h
 create mode 100644 compat/fsmonitor/fsm-settings-darwin.c
 create mode 100644 compat/fsmonitor/fsm-settings-win32.c
 create mode 100755 t/lib-unicode-nfc-nfd.sh
 create mode 100755 t/perf/p7527-builtin-fsmonitor.sh


base-commit: 5eb696daba2fe108d4d9ba2ccf4b357447ef9946
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1143%2Fjeffhostetler%2Fbuiltin-fsmonitor-part3-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1143/jeffhostetler/builtin-fsmonitor-part3-v6
Pull-Request: https://github.com/gitgitgadget/git/pull/1143

Range-diff vs v5:

  1:  8b7c5f4e234 =  1:  8b7c5f4e234 fsm-listen-win32: handle shortnames
  2:  5b246bec247 =  2:  5b246bec247 t7527: test FSMonitor on repos with Unicode root paths
  3:  8a474d69999 =  3:  8a474d69999 t/helper/fsmonitor-client: create stress test
  4:  004b67b62e3 !  4:  72b94acd5fe fsmonitor-settings: bare repos are incompatible with FSMonitor
     @@ Commit message
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
      
       ## builtin/fsmonitor--daemon.c ##
     +@@ builtin/fsmonitor--daemon.c: static int try_to_start_background_daemon(void)
     + int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
     + {
     + 	const char *subcmd;
     ++	enum fsmonitor_reason reason;
     + 	int detach_console = 0;
     + 
     + 	struct option options[] = {
      @@ builtin/fsmonitor--daemon.c: int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
       		die(_("invalid 'ipc-threads' value (%d)"),
       		    fsmonitor__ipc_threads);
       
      +	prepare_repo_settings(the_repository);
     ++	/*
     ++	 * If the repo is fsmonitor-compatible, explicitly set IPC-mode
     ++	 * (without bothering to load the `core.fsmonitor` config settings).
     ++	 *
     ++	 * If the repo is not compatible, the repo-settings will be set to
     ++	 * incompatible rather than IPC, so we can use one of the __get
     ++	 * routines to detect the discrepancy.
     ++	 */
      +	fsm_settings__set_ipc(the_repository);
      +
     -+	if (fsm_settings__error_if_incompatible(the_repository))
     -+		return 1;
     ++	reason = fsm_settings__get_reason(the_repository);
     ++	if (reason > FSMONITOR_REASON_OK)
     ++		die("%s",
     ++		    fsm_settings__get_incompatible_msg(the_repository,
     ++						       reason));
      +
       	if (!strcmp(subcmd, "start"))
       		return !!try_to_start_background_daemon();
     @@ builtin/update-index.c: int cmd_update_index(int argc, const char **argv, const
       
       	if (fsmonitor > 0) {
       		enum fsmonitor_mode fsm_mode = fsm_settings__get_mode(r);
     ++		enum fsmonitor_reason reason = fsm_settings__get_reason(r);
      +
     -+		if (fsm_settings__error_if_incompatible(the_repository))
     -+			return 1;
     ++		/*
     ++		 * The user wants to turn on FSMonitor using the command
     ++		 * line argument.  (We don't know (or care) whether that
     ++		 * is the IPC or HOOK version.)
     ++		 *
     ++		 * Use one of the __get routines to force load the FSMonitor
     ++		 * config settings into the repo-settings.  That will detect
     ++		 * whether the file system is compatible so that we can stop
     ++		 * here with a nice error message.
     ++		 */
     ++		if (reason > FSMONITOR_REASON_OK)
     ++			die("%s",
     ++			    fsm_settings__get_incompatible_msg(r, reason));
      +
       		if (fsm_mode == FSMONITOR_MODE_DISABLED) {
       			warning(_("core.fsmonitor is unset; "
     @@ fsmonitor-settings.c
       	char *hook_path;
       };
       
     -+static void set_incompatible(struct repository *r,
     -+			     enum fsmonitor_reason reason)
     -+{
     -+	struct fsmonitor_settings *s = r->settings.fsmonitor;
     -+
     -+	s->mode = FSMONITOR_MODE_INCOMPATIBLE;
     -+	s->reason = reason;
     -+}
     -+
     -+static int check_for_incompatible(struct repository *r)
     +-static void lookup_fsmonitor_settings(struct repository *r)
     ++static enum fsmonitor_reason check_for_incompatible(struct repository *r)
      +{
      +	if (!r->worktree) {
      +		/*
      +		 * Bare repositories don't have a working directory and
      +		 * therefore have nothing to watch.
      +		 */
     -+		set_incompatible(r, FSMONITOR_REASON_BARE);
     -+		return 1;
     ++		return FSMONITOR_REASON_BARE;
      +	}
      +
     -+	return 0;
     ++	return FSMONITOR_REASON_OK;
      +}
      +
     - static void lookup_fsmonitor_settings(struct repository *r)
     ++static struct fsmonitor_settings *alloc_settings(void)
       {
       	struct fsmonitor_settings *s;
     ++
     ++	CALLOC_ARRAY(s, 1);
     ++	s->mode = FSMONITOR_MODE_DISABLED;
     ++	s->reason = FSMONITOR_REASON_UNTESTED;
     ++
     ++	return s;
     ++}
     ++
     ++static void lookup_fsmonitor_settings(struct repository *r)
     ++{
     + 	const char *const_str;
     + 	int bool_value;
     + 
     + 	if (r->settings.fsmonitor)
     + 		return;
     + 
     +-	CALLOC_ARRAY(s, 1);
     +-	s->mode = FSMONITOR_MODE_DISABLED;
     +-
     +-	r->settings.fsmonitor = s;
     +-
     + 	/*
     + 	 * Overload the existing "core.fsmonitor" config setting (which
     + 	 * has historically been either unset or a hook pathname) to
      @@ fsmonitor-settings.c: static void lookup_fsmonitor_settings(struct repository *r)
     + 	case 0: /* config value was set to <bool> */
     + 		if (bool_value)
     + 			fsm_settings__set_ipc(r);
     ++		else
     ++			fsm_settings__set_disabled(r);
     + 		return;
       
     - 	CALLOC_ARRAY(s, 1);
     - 	s->mode = FSMONITOR_MODE_DISABLED;
     -+	s->reason = FSMONITOR_REASON_OK;
     + 	case 1: /* config value was unset */
     +@@ fsmonitor-settings.c: static void lookup_fsmonitor_settings(struct repository *r)
     + 		return;
     + 	}
       
     - 	r->settings.fsmonitor = s;
     +-	if (!const_str || !*const_str)
     +-		return;
     +-
     +-	fsm_settings__set_hook(r, const_str);
     ++	if (const_str && *const_str)
     ++		fsm_settings__set_hook(r, const_str);
     ++	else
     ++		fsm_settings__set_disabled(r);
     + }
       
     -@@ fsmonitor-settings.c: void fsm_settings__set_ipc(struct repository *r)
     + enum fsmonitor_mode fsm_settings__get_mode(struct repository *r)
     + {
     + 	if (!r)
     + 		r = the_repository;
     +-
     +-	lookup_fsmonitor_settings(r);
     ++	if (!r->settings.fsmonitor)
     ++		lookup_fsmonitor_settings(r);
       
     - 	lookup_fsmonitor_settings(r);
     + 	return r->settings.fsmonitor->mode;
     + }
     +@@ fsmonitor-settings.c: const char *fsm_settings__get_hook_path(struct repository *r)
     + {
     + 	if (!r)
     + 		r = the_repository;
     +-
     +-	lookup_fsmonitor_settings(r);
     ++	if (!r->settings.fsmonitor)
     ++		lookup_fsmonitor_settings(r);
       
     -+	if (check_for_incompatible(r))
     + 	return r->settings.fsmonitor->hook_path;
     + }
     + 
     + void fsm_settings__set_ipc(struct repository *r)
     + {
     ++	enum fsmonitor_reason reason = check_for_incompatible(r);
     ++
     ++	if (reason != FSMONITOR_REASON_OK) {
     ++		fsm_settings__set_incompatible(r, reason);
      +		return;
     ++	}
      +
     ++	/*
     ++	 * Caller requested IPC explicitly, so avoid (possibly
     ++	 * recursive) config lookup.
     ++	 */
     + 	if (!r)
     + 		r = the_repository;
     +-
     +-	lookup_fsmonitor_settings(r);
     ++	if (!r->settings.fsmonitor)
     ++		r->settings.fsmonitor = alloc_settings();
     + 
       	r->settings.fsmonitor->mode = FSMONITOR_MODE_IPC;
     ++	r->settings.fsmonitor->reason = reason;
       	FREE_AND_NULL(r->settings.fsmonitor->hook_path);
       }
     -@@ fsmonitor-settings.c: void fsm_settings__set_hook(struct repository *r, const char *path)
     - 
     - 	lookup_fsmonitor_settings(r);
       
     -+	if (check_for_incompatible(r))
     + void fsm_settings__set_hook(struct repository *r, const char *path)
     + {
     ++	enum fsmonitor_reason reason = check_for_incompatible(r);
     ++
     ++	if (reason != FSMONITOR_REASON_OK) {
     ++		fsm_settings__set_incompatible(r, reason);
      +		return;
     ++	}
      +
     ++	/*
     ++	 * Caller requested hook explicitly, so avoid (possibly
     ++	 * recursive) config lookup.
     ++	 */
     + 	if (!r)
     + 		r = the_repository;
     +-
     +-	lookup_fsmonitor_settings(r);
     ++	if (!r->settings.fsmonitor)
     ++		r->settings.fsmonitor = alloc_settings();
     + 
       	r->settings.fsmonitor->mode = FSMONITOR_MODE_HOOK;
     ++	r->settings.fsmonitor->reason = reason;
       	FREE_AND_NULL(r->settings.fsmonitor->hook_path);
       	r->settings.fsmonitor->hook_path = strdup(path);
     + }
      @@ fsmonitor-settings.c: void fsm_settings__set_disabled(struct repository *r)
     - 	lookup_fsmonitor_settings(r);
     + {
     + 	if (!r)
     + 		r = the_repository;
     +-
     +-	lookup_fsmonitor_settings(r);
     ++	if (!r->settings.fsmonitor)
     ++		r->settings.fsmonitor = alloc_settings();
       
       	r->settings.fsmonitor->mode = FSMONITOR_MODE_DISABLED;
      +	r->settings.fsmonitor->reason = FSMONITOR_REASON_OK;
     ++	FREE_AND_NULL(r->settings.fsmonitor->hook_path);
     ++}
     ++
     ++void fsm_settings__set_incompatible(struct repository *r,
     ++				    enum fsmonitor_reason reason)
     ++{
     ++	if (!r)
     ++		r = the_repository;
     ++	if (!r->settings.fsmonitor)
     ++		r->settings.fsmonitor = alloc_settings();
     ++
     ++	r->settings.fsmonitor->mode = FSMONITOR_MODE_INCOMPATIBLE;
     ++	r->settings.fsmonitor->reason = reason;
       	FREE_AND_NULL(r->settings.fsmonitor->hook_path);
       }
      +
     @@ fsmonitor-settings.c: void fsm_settings__set_disabled(struct repository *r)
      +{
      +	if (!r)
      +		r = the_repository;
     -+
     -+	lookup_fsmonitor_settings(r);
     ++	if (!r->settings.fsmonitor)
     ++		lookup_fsmonitor_settings(r);
      +
      +	return r->settings.fsmonitor->reason;
      +}
      +
     -+int fsm_settings__error_if_incompatible(struct repository *r)
     ++char *fsm_settings__get_incompatible_msg(const struct repository *r,
     ++					 enum fsmonitor_reason reason)
      +{
     -+	enum fsmonitor_reason reason = fsm_settings__get_reason(r);
     ++	struct strbuf msg = STRBUF_INIT;
      +
      +	switch (reason) {
     ++	case FSMONITOR_REASON_UNTESTED:
      +	case FSMONITOR_REASON_OK:
     -+		return 0;
     ++		goto done;
      +
      +	case FSMONITOR_REASON_BARE:
     -+		error(_("bare repository '%s' is incompatible with fsmonitor"),
     -+		      xgetcwd());
     -+		return 1;
     ++		strbuf_addf(&msg,
     ++			    _("bare repository '%s' is incompatible with fsmonitor"),
     ++			    xgetcwd());
     ++		goto done;
      +	}
      +
     -+	BUG("Unhandled case in fsm_settings__error_if_incompatible: '%d'",
     ++	BUG("Unhandled case in fsm_settings__get_incompatible_msg: '%d'",
      +	    reason);
     ++
     ++done:
     ++	return strbuf_detach(&msg, NULL);
      +}
      
       ## fsmonitor-settings.h ##
     @@ fsmonitor-settings.h
      + * Incompatibility reasons.
      + */
      +enum fsmonitor_reason {
     -+	FSMONITOR_REASON_OK = 0, /* no incompatibility or when disbled */
     ++	FSMONITOR_REASON_UNTESTED = 0,
     ++	FSMONITOR_REASON_OK, /* no incompatibility or when disbled */
      +	FSMONITOR_REASON_BARE,
      +};
      +
       void fsm_settings__set_ipc(struct repository *r);
       void fsm_settings__set_hook(struct repository *r, const char *path);
       void fsm_settings__set_disabled(struct repository *r);
     -@@ fsmonitor-settings.h: void fsm_settings__set_disabled(struct repository *r);
     ++void fsm_settings__set_incompatible(struct repository *r,
     ++				    enum fsmonitor_reason reason);
     + 
       enum fsmonitor_mode fsm_settings__get_mode(struct repository *r);
       const char *fsm_settings__get_hook_path(struct repository *r);
       
      +enum fsmonitor_reason fsm_settings__get_reason(struct repository *r);
     -+int fsm_settings__error_if_incompatible(struct repository *r);
     ++char *fsm_settings__get_incompatible_msg(const struct repository *r,
     ++					 enum fsmonitor_reason reason);
      +
       struct fsmonitor_settings;
       
  5:  e1e55550c10 !  5:  2e225c3f4f2 fsmonitor-settings: stub in Win32-specific incompatibility checking
     @@ contrib/buildsystems/CMakeLists.txt: if(SUPPORTS_SIMPLE_IPC)
       		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-darwin.c)
      
       ## fsmonitor-settings.c ##
     -@@ fsmonitor-settings.c: static int check_for_incompatible(struct repository *r)
     - 		return 1;
     +@@ fsmonitor-settings.c: static enum fsmonitor_reason check_for_incompatible(struct repository *r)
     + 		return FSMONITOR_REASON_BARE;
       	}
       
      +#ifdef HAVE_FSMONITOR_OS_SETTINGS
     @@ fsmonitor-settings.c: static int check_for_incompatible(struct repository *r)
      +		enum fsmonitor_reason reason;
      +
      +		reason = fsm_os__incompatible(r);
     -+		if (reason != FSMONITOR_REASON_OK) {
     -+			set_incompatible(r, reason);
     -+			return 1;
     -+		}
     ++		if (reason != FSMONITOR_REASON_OK)
     ++			return reason;
      +	}
      +#endif
      +
     - 	return 0;
     + 	return FSMONITOR_REASON_OK;
       }
       
      
       ## fsmonitor-settings.h ##
     -@@ fsmonitor-settings.h: int fsm_settings__error_if_incompatible(struct repository *r);
     +@@ fsmonitor-settings.h: char *fsm_settings__get_incompatible_msg(const struct repository *r,
       
       struct fsmonitor_settings;
       
  6:  2d68fc9a46a !  6:  e0d3bdf7556 fsmonitor-settings: VFS for Git virtual repos are incompatible
     @@ compat/fsmonitor/fsm-settings-win32.c
       }
      
       ## fsmonitor-settings.c ##
     -@@ fsmonitor-settings.c: int fsm_settings__error_if_incompatible(struct repository *r)
     - 		error(_("bare repository '%s' is incompatible with fsmonitor"),
     - 		      xgetcwd());
     - 		return 1;
     +@@ fsmonitor-settings.c: char *fsm_settings__get_incompatible_msg(const struct repository *r,
     + 			    _("bare repository '%s' is incompatible with fsmonitor"),
     + 			    xgetcwd());
     + 		goto done;
      +
      +	case FSMONITOR_REASON_VFS4GIT:
     -+		error(_("virtual repository '%s' is incompatible with fsmonitor"),
     -+		      r->worktree);
     -+		return 1;
     ++		strbuf_addf(&msg,
     ++			    _("virtual repository '%s' is incompatible with fsmonitor"),
     ++			    r->worktree);
     ++		goto done;
       	}
       
     - 	BUG("Unhandled case in fsm_settings__error_if_incompatible: '%d'",
     + 	BUG("Unhandled case in fsm_settings__get_incompatible_msg: '%d'",
      
       ## fsmonitor-settings.h ##
     -@@ fsmonitor-settings.h: enum fsmonitor_mode {
     - enum fsmonitor_reason {
     - 	FSMONITOR_REASON_OK = 0, /* no incompatibility or when disbled */
     +@@ fsmonitor-settings.h: enum fsmonitor_reason {
     + 	FSMONITOR_REASON_UNTESTED = 0,
     + 	FSMONITOR_REASON_OK, /* no incompatibility or when disbled */
       	FSMONITOR_REASON_BARE,
      +	FSMONITOR_REASON_VFS4GIT, /* VFS for Git virtualization */
       };
  7:  94ae2e424f1 =  7:  c50ed29a310 fsmonitor-settings: stub in macOS-specific incompatibility checking
  8:  b2ca6c1b201 !  8:  1f5b772d42a fsmonitor-settings: remote repos on macOS are incompatible
     @@ compat/fsmonitor/fsm-settings-darwin.c
       }
      
       ## fsmonitor-settings.c ##
     -@@ fsmonitor-settings.c: int fsm_settings__error_if_incompatible(struct repository *r)
     - 		      xgetcwd());
     - 		return 1;
     +@@ fsmonitor-settings.c: char *fsm_settings__get_incompatible_msg(const struct repository *r,
     + 			    xgetcwd());
     + 		goto done;
       
      +	case FSMONITOR_REASON_ERROR:
     -+		error(_("repository '%s' is incompatible with fsmonitor due to errors"),
     -+		      r->worktree);
     -+		return 1;
     ++		strbuf_addf(&msg,
     ++			    _("repository '%s' is incompatible with fsmonitor due to errors"),
     ++			    r->worktree);
     ++		goto done;
      +
      +	case FSMONITOR_REASON_REMOTE:
     -+		error(_("remote repository '%s' is incompatible with fsmonitor"),
     -+		      r->worktree);
     -+		return 1;
     ++		strbuf_addf(&msg,
     ++			    _("remote repository '%s' is incompatible with fsmonitor"),
     ++			    r->worktree);
     ++		goto done;
      +
       	case FSMONITOR_REASON_VFS4GIT:
     - 		error(_("virtual repository '%s' is incompatible with fsmonitor"),
     - 		      r->worktree);
     + 		strbuf_addf(&msg,
     + 			    _("virtual repository '%s' is incompatible with fsmonitor"),
      
       ## fsmonitor-settings.h ##
     -@@ fsmonitor-settings.h: enum fsmonitor_mode {
     - enum fsmonitor_reason {
     - 	FSMONITOR_REASON_OK = 0, /* no incompatibility or when disbled */
     +@@ fsmonitor-settings.h: enum fsmonitor_reason {
     + 	FSMONITOR_REASON_UNTESTED = 0,
     + 	FSMONITOR_REASON_OK, /* no incompatibility or when disbled */
       	FSMONITOR_REASON_BARE,
      +	FSMONITOR_REASON_ERROR, /* FS error probing for compatibility */
      +	FSMONITOR_REASON_REMOTE,
  9:  a3cc4b3b16d =  9:  495e54049b4 fsmonitor-settings: remote repos on Windows are incompatible
 10:  8f1f4840751 ! 10:  4b52083698c fsmonitor-settings: NTFS and FAT32 on MacOS are incompatible
     @@ compat/fsmonitor/fsm-settings-darwin.c: enum fsmonitor_reason fsm_os__incompatib
       
      
       ## fsmonitor-settings.c ##
     -@@ fsmonitor-settings.c: int fsm_settings__error_if_incompatible(struct repository *r)
     - 		error(_("virtual repository '%s' is incompatible with fsmonitor"),
     - 		      r->worktree);
     - 		return 1;
     +@@ fsmonitor-settings.c: char *fsm_settings__get_incompatible_msg(const struct repository *r,
     + 			    _("virtual repository '%s' is incompatible with fsmonitor"),
     + 			    r->worktree);
     + 		goto done;
      +
      +	case FSMONITOR_REASON_NOSOCKETS:
     -+		error(_("repository '%s' is incompatible with fsmonitor due to lack of Unix sockets"),
     -+		      r->worktree);
     -+		return 1;
     ++		strbuf_addf(&msg,
     ++			    _("repository '%s' is incompatible with fsmonitor due to lack of Unix sockets"),
     ++			    r->worktree);
     ++		goto done;
       	}
       
     - 	BUG("Unhandled case in fsm_settings__error_if_incompatible: '%d'",
     + 	BUG("Unhandled case in fsm_settings__get_incompatible_msg: '%d'",
      
       ## fsmonitor-settings.h ##
      @@ fsmonitor-settings.h: enum fsmonitor_reason {
 11:  8d48d9c5623 = 11:  d4a4263d379 unpack-trees: initialize fsmonitor_has_run_once in o->result
 12:  088c7b3334c = 12:  f4feb00ec2b fsm-listen-darwin: ignore FSEvents caused by xattr changes on macOS
 13:  00fab626663 = 13:  dbb983fd9d0 fsmonitor--daemon: cd out of worktree root
 14:  6552f51802b = 14:  ae90b99ea9b fsmonitor--daemon: prepare for adding health thread
 15:  f2bf07cd739 = 15:  b6c5800095f fsmonitor--daemon: rename listener thread related variables
 16:  2a44f2eded1 = 16:  32fc6ba7437 fsmonitor--daemon: stub in health thread
 17:  854fb5e3658 = 17:  77bc037481a fsm-health-win32: add polling framework to monitor daemon health
 18:  3af1fe0d61d = 18:  b06edd995ea fsm-health-win32: force shutdown daemon if worktree root moves
 19:  f1365cdd40c = 19:  1bd5f346248 fsm-listen-darwin: shutdown daemon if worktree root is moved/renamed
 20:  15698d64edd = 20:  48af0813dec fsmonitor: optimize processing of directory events
 21:  9d0da8fc22b = 21:  a9b35e770f3 t7527: FSMonitor tests for directory moves
 22:  040c00cfd6f = 22:  26308936af9 t/perf/p7527: add perf test for builtin FSMonitor
 23:  5db241f7d2f ! 23:  d0e25f6bac6 fsmonitor: never set CE_FSMONITOR_VALID on submodules
     @@ t/t7527-builtin-fsmonitor.sh: do
      +# submodule.
      +
      +create_super () {
     -+	super=$1 &&
     -+
     -+	git init "${super}" &&
     -+	echo x >${super}/file_1 &&
     -+	echo y >${super}/file_2 &&
     -+	echo z >${super}/file_3 &&
     -+	mkdir ${super}/dir_1 &&
     -+	echo a >${super}/dir_1/file_11 &&
     -+	echo b >${super}/dir_1/file_12 &&
     -+	mkdir ${super}/dir_1/dir_2 &&
     -+	echo a >${super}/dir_1/dir_2/file_21 &&
     -+	echo b >${super}/dir_1/dir_2/file_22 &&
     -+	git -C ${super} add . &&
     -+	git -C ${super} commit -m "initial ${super} commit"
     ++	super="$1" &&
     ++
     ++	git init "$super" &&
     ++	echo x >"$super/file_1" &&
     ++	echo y >"$super/file_2" &&
     ++	echo z >"$super/file_3" &&
     ++	mkdir "$super/dir_1" &&
     ++	echo a >"$super/dir_1/file_11" &&
     ++	echo b >"$super/dir_1/file_12" &&
     ++	mkdir "$super/dir_1/dir_2" &&
     ++	echo a >"$super/dir_1/dir_2/file_21" &&
     ++	echo b >"$super/dir_1/dir_2/file_22" &&
     ++	git -C "$super" add . &&
     ++	git -C "$super" commit -m "initial $super commit"
      +}
      +
      +create_sub () {
     -+	sub=$1 &&
     -+
     -+	git init "${sub}" &&
     -+	echo x >${sub}/file_x &&
     -+	echo y >${sub}/file_y &&
     -+	echo z >${sub}/file_z &&
     -+	mkdir ${sub}/dir_x &&
     -+	echo a >${sub}/dir_x/file_a &&
     -+	echo b >${sub}/dir_x/file_b &&
     -+	mkdir ${sub}/dir_x/dir_y &&
     -+	echo a >${sub}/dir_x/dir_y/file_a &&
     -+	echo b >${sub}/dir_x/dir_y/file_b &&
     -+	git -C ${sub} add . &&
     -+	git -C ${sub} commit -m "initial ${sub} commit"
     ++	sub="$1" &&
     ++
     ++	git init "$sub" &&
     ++	echo x >"$sub/file_x" &&
     ++	echo y >"$sub/file_y" &&
     ++	echo z >"$sub/file_z" &&
     ++	mkdir "$sub/dir_x" &&
     ++	echo a >"$sub/dir_x/file_a" &&
     ++	echo b >"$sub/dir_x/file_b" &&
     ++	mkdir "$sub/dir_x/dir_y" &&
     ++	echo a >"$sub/dir_x/dir_y/file_a" &&
     ++	echo b >"$sub/dir_x/dir_y/file_b" &&
     ++	git -C "$sub" add . &&
     ++	git -C "$sub" commit -m "initial $sub commit"
      +}
      +
      +my_match_and_clean () {
     @@ t/t7527-builtin-fsmonitor.sh: do
      +			    rm -rf super; \
      +			    rm -rf sub" &&
      +
     -+	create_super "super" &&
     -+	create_sub "sub" &&
     ++	create_super super &&
     ++	create_sub sub &&
      +
      +	git -C super submodule add ../sub ./dir_1/dir_2/sub &&
      +	git -C super commit -m "add sub" &&
 24:  93de3707d26 = 24:  410dd2d2920 t7527: test FSMonitor on case insensitive+preserving file system
 25:  d890c2e2d97 = 25:  cd7c55b0d38 fsmonitor: on macOS also emit NFC spelling for NFD pathname
 26:  7c606235557 = 26:  8278f32c4d8 t/lib-unicode-nfc-nfd: helper prereqs for testing unicode nfc/nfd
 27:  9724c41d18d = 27:  4efb3a43838 t7527: test Unicode NFC/NFD handling on MacOS
 28:  b8325fb7c78 ! 28:  df1b4f3a80f fsmonitor--daemon: allow --super-prefix argument
     @@ t/t7527-builtin-fsmonitor.sh: test_expect_success "Submodule always visited" '
      +			    rm -rf sub;   \
      +			    rm super-sub.trace" &&
      +
     -+	create_super "super" &&
     -+	create_sub "sub" &&
     ++	create_super super &&
     ++	create_sub sub &&
      +
      +	# Copy rather than submodule add so that we get a .git dir.
      +	cp -R ./sub ./super/dir_1/dir_2/sub &&

-- 
gitgitgadget
