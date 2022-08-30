Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F620ECAAA1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 18:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbiH3SlK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 14:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbiH3SlD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 14:41:03 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0C13C178
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 11:41:00 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id c24so11423647pgg.11
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 11:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :subject:to:from:sender:from:to:cc:subject:date;
        bh=oT7DqQkYLRjdDVjuXOuZPlLKBk4mZJJSiNB5ofKfGVM=;
        b=H+0loiX7FlrBlxQjpQy0ErgjXG2msX5r1iBPt/3X0bcDyXPq8YSJmoJ0Ch0dCarlr3
         VjHW/d7Ahr3vjsL/3s+7u1x9lZEyVIvjPNNg+hGJLYQKSm59e+wAFTOcBTfZPffTvT0L
         PN9CJzSUsl694dY67dj83HIrdbWw6eAu75fH+zPSe7oiipplyrKQu/SAlB5/xJsVXChu
         d0w+UPbpfqvvkN6DWB58nCizS3HXrGMBwQ5TzHM8XpNQikLzmcfIkxqrW/ekusSBt42a
         6OMbRXIOj+cFomdphkwsbtHNWUjpLfyMNqQ6BA4xNJjXeLcNego2NT8tuESp92SBAMoW
         SD9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :subject:to:from:sender:x-gm-message-state:from:to:cc:subject:date;
        bh=oT7DqQkYLRjdDVjuXOuZPlLKBk4mZJJSiNB5ofKfGVM=;
        b=Kak40/DaKqbnKjTU5Sy0vSs+oBtiJR5wGgAlYdV0DruF90lTOeykARTvfCE7a4jsCh
         /NyPncKDz1xyoHx6+qMfyiT01QzOxb3rJyFHxY89v3kd4vqTDsb5xOsxGYdZCH08SbFb
         GfFKOrBLuYlYgbhbxT0A6P5p6EvefSMvM+A/NgJBdmIJ+pzzUhth859WLkrjJuqEabwb
         wchAgwQlfXQK67/pgHD7iYuY9jT7Pt599GChT2H9U2tnGJbPRwbTyt9SFkM6pOiyrSaX
         cZ8R/uj5NZc+6r7VQG2rF2wTEaARYPApnitPrOlNte6MzHhHfNtF3lxakP+52jT3L91B
         iqxA==
X-Gm-Message-State: ACgBeo3SDnPooYLS/2V4izvjfJFwhveXVqHH5rpURkZlI8zlXJHd3iZb
        L53m4tNzV4/vVANErScyMZJwi2q+Iao=
X-Google-Smtp-Source: AA6agR5Beis31uDsN57itXJjdMhJLiLlubscaWE6KWZdZVX6EEPiYnyCRctvBo3wL53eqXsaMWBkUA==
X-Received: by 2002:a05:6a00:15cb:b0:52e:6100:e7a7 with SMTP id o11-20020a056a0015cb00b0052e6100e7a7mr22134905pfu.23.1661884859795;
        Tue, 30 Aug 2022 11:40:59 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id h6-20020aa79f46000000b0052d4b0d0c74sm9667563pfr.70.2022.08.30.11.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 11:40:59 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [ANNOUNCE] Git v2.37.3
Date:   Tue, 30 Aug 2022 11:40:58 -0700
Message-ID: <xmqqzgflk211.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The latest maintenance release Git v2.37.3 is now available at
the usual places.  Updating to this version is not urgent, but
if you were affected by regressions in v2.37.0, it may be worth
your time to do so.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.37.3'
tag and the 'maint' branch that the tag points at:

  url = https://git.kernel.org/pub/scm/git/git
  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://github.com/gitster/git

----------------------------------------------------------------

Git 2.37.3 Release Notes
========================

This primarily is to backport various fixes accumulated on the 'master'
front since 2.37.2.

Fixes since v2.37.2
-------------------

 * The build procedure for Windows that uses CMake has been updated to
   pick up the shell interpreter from local installation location.

 * Conditionally allow building Python interpreter on Windows

 * Fix to lstat() emulation on Windows.

 * Older gcc with -Wall complains about the universal zero initializer
   "struct s = { 0 };" idiom, which makes developers' lives
   inconvenient (as -Werror is enabled by DEVELOPER=YesPlease).  The
   build procedure has been tweaked to help these compilers.

 * Plug memory leaks in the failure code path in the "merge-ort" merge
   strategy backend.

 * Avoid repeatedly running getconf to ask libc version in the test
   suite, and instead just as it once per script.

 * Platform-specific code that determines if a directory is OK to use
   as a repository has been taught to report more details, especially
   on Windows.

 * "vimdiff3" regression has been corrected.

 * "git fsck" reads mode from tree objects but canonicalizes the mode
   before passing it to the logic to check object sanity, which has
   hid broken tree objects from the checking logic.  This has been
   corrected, but to help exiting projects with broken tree objects
   that they cannot fix retroactively, the severity of anomalies this
   code detects has been demoted to "info" for now.

 * Fixes to sparse index compatibility work for "reset" and "checkout"
   commands.

 * Documentation for "git add --renormalize" has been improved.

Also contains other minor documentation updates and code clean-ups.

----------------------------------------------------------------

Changes since v2.37.2 are as follows:

Carlo Marcelo Arenas Belón (1):
      cmake: support local installations of git

Felipe Contreras (7):
      mergetools: vimdiff: fix comment
      mergetools: vimdiff: make vimdiff3 actually work
      mergetools: vimdiff: silence annoying messages
      mergetools: vimdiff: fix for diffopt
      mergetools: vimdiff: rework tab logic
      mergetools: vimdiff: fix single window layouts
      mergetools: vimdiff: simplify tabfirst

Glen Choo (1):
      Documentation/git-reflog: remove unneeded \ from \{

Jeff King (4):
      config.mak.dev: squelch -Wno-missing-braces for older gcc
      tree-walk: add a mechanism for getting non-canonicalized modes
      fsck: actually detect bad file modes in trees
      fsck: downgrade tree badFilemode to "info"

Johannes Schindelin (11):
      windows: include the Python bits when building Git for Windows
      mingw: remove unneeded `NO_GETTEXT` directive
      mingw: remove unneeded `NO_CURL` directive
      lstat(mingw): correctly detect ENOTDIR scenarios
      merge-ort: clean up after failed merge
      merge-ort: do leave trace2 region even if checkout fails
      setup: fix some formatting
      setup: prepare for more detailed "dubious ownership" messages
      mingw: provide details about unsafe directories' ownership
      mingw: be more informative when ownership check fails on FAT32
      mingw: handle a file owned by the Administrators group correctly

Junio C Hamano (2):
      A handful more topics from the 'master' front for 2.37.3
      Git 2.37.3

Philip Oakley (1):
      doc add: renormalize is not idempotent for CRCRLF

Phillip Wood (1):
      tests: cache glibc version check

Victoria Dye (4):
      checkout: fix nested sparse directory diff in sparse index
      oneway_diff: handle removed sparse directories
      cache.h: create 'index_name_pos_sparse()'
      unpack-trees: unpack new trees as sparse directories

Ævar Arnfjörð Bjarmason (1):
      hook API: don't segfault on strbuf_addf() to NULL "out"


