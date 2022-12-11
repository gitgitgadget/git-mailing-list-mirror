Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD73C4332F
	for <git@archiver.kernel.org>; Sun, 11 Dec 2022 05:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiLKFTe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Dec 2022 00:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiLKFSz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Dec 2022 00:18:55 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2B713F69;
        Sat, 10 Dec 2022 21:18:14 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id n3so6417714pfq.10;
        Sat, 10 Dec 2022 21:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :subject:to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=jz6qCC0WeszODQXc0BxUkdSxfYyDa+OIT67g2yIzbyA=;
        b=m+HIbG/zh4DkPhygTTQPAVMX6yyMAhG2RSHgHc/upbb/CNS38xrfLVAecxvdRG6n8J
         +6U9SaZXBtYeXvmaeg/ioD+UgicSzR3tsu8Q0blJ61XuFXeJQfQXCLfnbOlyCzWnlflY
         P722ZTB/XouO5sq7rQr/+hDVmaqSwqqn3RD57mpfFdzSb1cN0VNcC4TT3Cx0FV3ow/VZ
         oJFT4LKFQNnmFnSlKqomMMTGauvRvgoAqjVZt+6FVMSnExXtQUH9KIj3h1Ah0I6SFhT/
         Zme2kbvzEQemx3TyQgPt+GU72HEsc+RanvoAA3VbnFU3yXvIs1Lj4W1LMbQrdD3U1C6A
         5bLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :subject:to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jz6qCC0WeszODQXc0BxUkdSxfYyDa+OIT67g2yIzbyA=;
        b=1eabI+6ps6G8oPAIdATUbx0kh0lvjezvBaYwz5X4drW85wWJ+67ACVAysOqPlmVGsd
         nq06L/3MTHDSXEv92hlx32vXdwpmSiCa1gxEoscXHpCqGLzPykq8RtYuC68/JKOXWLQs
         NUC/KRFuuJEtRd4TGJ5M02NCRY21Po7/5d1tQtnLujPzlvsZrV+JlC9YrFlZkS6erNd/
         nQmtUWTiQ4d4ZVdoSekLzsADKU9SO1lLMudNDcvdlj/2EARG9cpLJJfxEFv6czNFfFKI
         E2x4GDd+87Tp0TLMigYW5hh0wJDnVtLLFJI6Uk7Vz50CQALLMhd4Lp4zCywK1vEOBqnp
         X7Ww==
X-Gm-Message-State: ANoB5pmeWYyfPNrt2nwwg1ARYOj63oaxQowjm0azbAagnhzGT5+6V0+Y
        DRrb0kGqfww1L9rqMU07q/yImzLKP4zceA==
X-Google-Smtp-Source: AA0mqf5cMjIQ/l5uztwB+PsRGQDlk+rxTMQOIY+/kdkUExZDiYHJm0UcQh9Tg19QroAV4C0pgg0XUw==
X-Received: by 2002:a05:6a00:bd8:b0:576:65f5:c60a with SMTP id x24-20020a056a000bd800b0057665f5c60amr10166562pfu.27.1670735893908;
        Sat, 10 Dec 2022 21:18:13 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id a15-20020aa7970f000000b005768b4f2d0dsm3473937pfg.64.2022.12.10.21.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 21:18:13 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [ANNOUNCE] Git v2.38.2
Date:   Sun, 11 Dec 2022 14:18:12 +0900
Message-ID: <xmqqv8miv7qj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The latest maintenance release Git v2.38.2 is now available at the
usual places.  There is nothing exciting here, it mostly is to
backport/backmerge the accumulated fixes, including GitHub CI
integration, made during 2.39 development cycle to the 2.38
maintenance track.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.38.2'
tag and the 'maint' branch that the tag points at:

  url = https://git.kernel.org/pub/scm/git/git
  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://github.com/gitster/git

----------------------------------------------------------------

Git 2.38.2 Release Notes
========================

This is to backport various fixes accumulated during the development
towards Git 2.39, the next feature release.


Fixes since v2.38.1
-------------------

 * Update CodingGuidelines to clarify what features to use and avoid
   in C99.

 * The codepath that reads from the index v4 had unaligned memory
   accesses, which has been corrected.

 * "git remote rename" failed to rename a remote without fetch
   refspec, which has been corrected.

 * "git clone" did not like to see the "--bare" and the "--origin"
   options used together without a good reason.

 * Fix messages incorrectly marked for translation.

 * "git fsck" failed to release contents of tree objects already used
   from the memory, which has been fixed.

 * "git rebase -i" can mistakenly attempt to apply a fixup to a commit
   itself, which has been corrected.

 * In read-only repositories, "git merge-tree" tried to come up with a
   merge result tree object, which it failed (which is not wrong) and
   led to a segfault (which is bad), which has been corrected.

 * Force C locale while running tests around httpd to make sure we can
   find expected error messages in the log.

 * Fix a logic in "mailinfo -b" that miscomputed the length of a
   substring, which lead to an out-of-bounds access.

 * The codepath to sign learned to report errors when it fails to read
   from "ssh-keygen".

 * "GIT_EDITOR=: git branch --edit-description" resulted in failure,
   which has been corrected.

 * Documentation on various Boolean GIT_* environment variables have
   been clarified.

 * "git multi-pack-index repack/expire" used to repack unreachable
   cruft into a new pack, which have been corrected.

 * The code to clean temporary object directories (used for
   quarantine) tried to remove them inside its signal handler, which
   was a no-no.

 * "git branch --edit-description" on an unborh branch misleadingly
   said that no such branch exists, which has been corrected.

 * GitHub CI settings have been adjusted to recent reality, merging
   and cherry-picking necessary topics that have been prepared for Git
   2.39.

 * `git rebase --update-refs` would delete references when all `update-ref`
   commands in the sequencer were removed, which has been corrected.

Also contains various documentation updates and code clean-ups.

----------------------------------------------------------------

Changes since v2.38.1 are as follows:

Alejandro R. Sedeño (1):
      git-compat-util.h: GCC deprecated message arg only in GCC 4.5+

Alex Henrie (1):
      fsmonitor--daemon: don't translate literal commands

Derrick Stolee (1):
      bundle-uri: fix technical doc issues

Jeff Hostetler (1):
      config.mak.dev: disable suggest braces error on old clang versions

Jeff King (12):
      fsck: free tree buffers after walking unreachable objects
      fsck: turn off save_commit_buffer
      parse_object_buffer(): respect save_commit_buffer
      clone: allow "--bare" with "-o"
      remote: handle rename of remote without fetch refspec
      sequencer: detect author name errors in read_author_script()
      test-submodule: inline resolve_relative_url() function
      multi-pack-index: avoid writing to global in option callback
      commit: avoid writing to global in option callback
      attr: drop DEBUG_ATTR code
      dir: use fspathncmp() in pl_hashmap_cmp()
      Makefile: force -O0 when compiling with SANITIZE=leak

Jiang Xin (4):
      github-actions: run gcc-8 on ubuntu-20.04 image
      ci: remove the pipe after "p4 -V" to catch errors
      ci: use the same version of p4 on both Linux and macOS
      ci: install python on ubuntu

Johannes Altmanninger (1):
      sequencer: avoid dropping fixup commit that targets self via commit-ish

Johannes Schindelin (4):
      merge-ort: fix segmentation fault in read-only repositories
      merge-ort: return early when failing to write a blob
      ci: avoid using deprecated {up,down}load-artifacts Action
      ci: use a newer `github-script` version

John Cai (1):
      tmp-objdir: skip clean up when handling a signal

Junio C Hamano (10):
      environ: document GIT_SSL_NO_VERIFY
      environ: explain Boolean environment variables
      environ: GIT_FLUSH should be made a usual Boolean
      environ: simplify description of GIT_INDEX_FILE
      environ: GIT_INDEX_VERSION affects not just a new repository
      branch: do not fail a no-op --edit-desc
      SubmittingPatches: use usual capitalization in the log message body
      Downmerge a handful of topics for 2.38.2
      Downmerge a bit more for 2.38.2
      Git 2.38.2

Noah Betzen (1):
      mergetool.txt: typofix 'overwriten' -> 'overwritten'

Oscar Dominguez (1):
      ci(main): upgrade actions/checkout to v3

Phillip Wood (3):
      mailinfo -b: fix an out of bounds access
      ssh signing: return an error when signature cannot be read
      t3435: remove redundant test case

René Scharfe (4):
      gc: simplify maintenance_task_pack_refs()
      t/lib-httpd: pass LANG and LC_ALL to Apache
      bisect--helper: plug strvec leak
      archive: deduplicate verbose printing

Rubén Justo (2):
      ref-filter.c: fix a leak in get_head_description
      branch: description for non-existent branch errors

Sergey Organov (3):
      diff-merges: cleanup func_by_opt()
      diff-merges: cleanup set_diff_merges()
      diff-merges: clarify log.diffMerges documentation

Taylor Blau (7):
      Documentation/git-multi-pack-index.txt: fix typo
      Documentation/git-multi-pack-index.txt: clarify expire behavior
      midx.c: prevent `expire` from removing the cruft pack
      midx.c: avoid cruft packs with `repack --batch-size=0`
      midx.c: replace `xcalloc()` with `CALLOC_ARRAY()`
      midx.c: remove unnecessary loop condition
      midx.c: avoid cruft packs with non-zero `repack --batch-size`

Victoria Dye (2):
      read-cache: avoid misaligned reads in index v4
      rebase --update-refs: avoid unintended ref deletion

Ævar Arnfjörð Bjarmason (9):
      test-lib: have SANITIZE=leak imply TEST_NO_MALLOC_CHECK
      CodingGuidelines: update for C99
      CodingGuidelines: mention dynamic C99 initializer elements
      CodingGuidelines: allow declaring variables in for loops
      CodingGuidelines: mention C99 features we can't use
      CodingGuidelines: recommend against unportable C99 struct syntax
      CI: upgrade to macos-12, and pin OSX version
      CI: don't explicitly pick "bash" shell outside of Windows, fix regression
      CI: migrate away from deprecated "set-output" syntax

Đoàn Trần Công Danh (1):
      Makefile: clarify runtime relative gitexecdir

