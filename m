Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68981C433F5
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 23:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BC7A604DB
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 23:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbhIXXzG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 19:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbhIXXzF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 19:55:05 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13A4C061571
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 16:53:31 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id i23so32160856wrb.2
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 16:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fHb/m+dq3YeaeEfhkzbAoTnwtr1ewcIMfsCLWRRa+NY=;
        b=BLV3S70n0zYYB3W9P501rOXvpby9RUMikUjxEAbhTQ1uwo6dxF0edCLfcEHdMMVin5
         BwWhVJWCtSg3Vtcs7Ite5K8/bWZcpqq+WbqSTrho0WRw/uOfeYlneTrw/vRv6Jrk0RtX
         85CKscpxoT3bbhxNMYQePsKCuzAcP+u6m3ZMHA2UkY+gl6mklRAM2A/PbDDe8vo9Jr/f
         ML9pxJCpb8ggK/1BysZ92lk1fA0nx05NyFJICbCIj6Vqj0yUFmpGaI0uhG7k17+u1PcW
         iXPxYJy8aKTltmt8bL1jtpsWoIPRvn1rPklFs4jtL2kSyDDYihJanCjNmKN6nYkgkPoJ
         QeuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fHb/m+dq3YeaeEfhkzbAoTnwtr1ewcIMfsCLWRRa+NY=;
        b=lcaAJk5w2Rkz+8uuKOLwlmy6f1MKa+PZqTDtBPgR9q38/Eq4PPRLwJ9QNXf7DkMOZr
         u2d7oxiwwRf7O/03gbaUAlFT25LmFtI1Vlcm7rOVTnhunjaEIY0IOcDOGAXykhp10CHn
         kvaLvvsys5WjrhbYJAuUV8Mg9cBZfK0QWa99mT6MyZ85nUKd/7Pux9RR6FpdpBmhq3kO
         jE9k40P5l/mneug3NZlJ4DweDov13QXCSOjE/+/tWsXkg2+h+eE4Z+DUto6JNJ33doYM
         saVLXOMaKdj3I2KO0RzPyD5gZdDHDpP+w/CeB9n79Fq90PqVxLC/Izmi2WoOknXD2LFJ
         LMbA==
X-Gm-Message-State: AOAM532aYDd69iiV26dEw6IT4yCKn7/DlQXTtdcVcJ9FQ242MGeTqk05
        3Irr7WXrmOq/WmXWzNnKLHGGeLWN8W8=
X-Google-Smtp-Source: ABdhPJzjX2cROu7SD0CBY5jowCp3i0+IWNQFqXMp3zjfH2qFczzWVRIFFo+8NE6VZy80HXFD1Cbszg==
X-Received: by 2002:adf:ec4d:: with SMTP id w13mr10177959wrn.412.1632527610319;
        Fri, 24 Sep 2021 16:53:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o1sm9764018wmq.26.2021.09.24.16.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 16:53:29 -0700 (PDT)
Message-Id: <pull.1076.v6.git.git.1632527609.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v5.git.git.1632514331.gitgitgadget@gmail.com>
References: <pull.1076.v5.git.git.1632514331.gitgitgadget@gmail.com>
From:   "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Sep 2021 23:53:21 +0000
Subject: [PATCH v6 0/8] Implement a batched fsync option for core.fsyncObjectFiles
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Neeraj-Personal <nksingh85@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks to everyone for review so far!

v5 was a bit of a dud, with some issues that I only noticed after
submitting. v6 changes:

 * re-add Windows support
 * fix minor formatting issues
 * reset git author and commit dates which got messed up

Changes since v4, all in response to review feedback from Ævar Arnfjörð
Bjarmason:

 * Update core.fsyncobjectfiles documentation to specify 'loose' objects and
   to add a statement about not fsyncing parent directories.
   
   * I still don't want to make any promises on behalf of the Linux FS developers
     in the documentation. However, according to [v4.1] and my understanding
     of how XFS journals are documented to work, it looks like recent versions
     of Linux running on XFS should be as safe as Windows or macOS in 'batch'
     mode. I don't know about ext4, since it's not clear to me when metadata
     updates are made visible to the journal.
   

 * Rewrite the core batched fsync change to use the tmp-objdir lib. As Ævar
   pointed out, this lets us access the added loose objects immediately,
   rather than only after unplugging the bulk checkin. This is a hard
   requirement in unpack-objects for resolving OBJ_REF_DELTA packed objects.
   
   * As a preparatory patch, the object-file code now doesn't do a rename if it's in a
     tmp objdir (as determined by the quarantine environment variable).
   
   * I added support to the tmp-objdir lib to replace the 'main' writable odb.
   
   * Instead of using a lockfile for the final full fsync, we now use a new dummy
     temp file. Doing that makes the below unpack-objects change easier.
   

 * Add bulk-checkin support to unpack-objects, which is used in fetch and
   push. In addition to making those operations faster, it allows us to
   directly compare performance of packfiles against loose objects. Please
   see [v4.2] for a measurement of 'git push' to a local upstream with
   different numbers of unique new files.

 * Rename FSYNC_OBJECT_FILES_MODE to fsync_object_files_mode.

 * Remove comment with link to NtFlushBuffersFileEx documentation.

 * Make t/lib-unique-files.sh a bit cleaner. We are still creating unique
   contents, but now this uses test_tick, so it should be deterministic from
   run to run.

 * Ensure there are tests for all of the modified commands. Make the
   unpack-objects tests validate that the unpacked objects are really
   available in the ODB.

References for v4: [v4.1]
https://lore.kernel.org/linux-fsdevel/20190419072938.31320-1-amir73il@gmail.com/#t

[v4.2]
https://docs.google.com/spreadsheets/d/1uxMBkEXFFnQ1Y3lXKqcKpw6Mq44BzhpCAcPex14T-QQ/edit#gid=1898936117

Changes since v3:

 * Fix core.fsyncobjectfiles option parsing as suggested by Junio: We now
   accept no value to mean "true" and we require 'batch' to be lowercase.

 * Leave the default fsync mode as 'false'. Git for windows can change its
   default when this series makes it over to that fork.

 * Use a switch statement in git_fsync, as suggested by Junio.

 * Add regression test cases for core.fsyncobjectfiles=batch. This should
   keep the batch functionality basically working in upstream git even if
   few users adopt batch mode initially. I expect git-for-windows will
   provide a good baking area for the new mode.

Neeraj Singh (8):
  object-file.c: do not rename in a temp odb
  bulk-checkin: rename 'state' variable and separate 'plugged' boolean
  core.fsyncobjectfiles: batched disk flushes
  core.fsyncobjectfiles: add windows support for batch mode
  update-index: use the bulk-checkin infrastructure
  unpack-objects: use the bulk-checkin infrastructure
  core.fsyncobjectfiles: tests for batch mode
  core.fsyncobjectfiles: performance tests for add and stash

 Documentation/config/core.txt       |  29 +++++--
 Makefile                            |   6 ++
 builtin/unpack-objects.c            |   3 +
 builtin/update-index.c              |   6 ++
 bulk-checkin.c                      |  92 +++++++++++++++++++---
 bulk-checkin.h                      |   2 +
 cache.h                             |   8 +-
 compat/mingw.h                      |   3 +
 compat/win32/flush.c                |  28 +++++++
 config.c                            |   7 +-
 config.mak.uname                    |   3 +
 configure.ac                        |   8 ++
 contrib/buildsystems/CMakeLists.txt |   3 +-
 environment.c                       |   6 +-
 git-compat-util.h                   |   7 ++
 object-file.c                       | 118 ++++++++++++++++++++++++----
 object-store.h                      |  22 ++++++
 object.c                            |   2 +-
 repository.c                        |   2 +
 repository.h                        |   1 +
 t/lib-unique-files.sh               |  36 +++++++++
 t/perf/p3700-add.sh                 |  43 ++++++++++
 t/perf/p3900-stash.sh               |  46 +++++++++++
 t/t3700-add.sh                      |  20 +++++
 t/t3903-stash.sh                    |  14 ++++
 t/t5300-pack-object.sh              |  30 ++++---
 tmp-objdir.c                        |  20 ++++-
 tmp-objdir.h                        |   6 ++
 wrapper.c                           |  48 +++++++++++
 write-or-die.c                      |   2 +-
 30 files changed, 570 insertions(+), 51 deletions(-)
 create mode 100644 compat/win32/flush.c
 create mode 100644 t/lib-unique-files.sh
 create mode 100755 t/perf/p3700-add.sh
 create mode 100755 t/perf/p3900-stash.sh


base-commit: 8b7c11b8668b4e774f81a9f0b4c30144b818f1d1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1076%2Fneerajsi-msft%2Fneerajsi%2Fbulk-fsync-object-files-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1076/neerajsi-msft/neerajsi/bulk-fsync-object-files-v6
Pull-Request: https://github.com/git/git/pull/1076

Range-diff vs v5:

 1:  95315f35a28 = 1:  e4081f81f6a object-file.c: do not rename in a temp odb
 2:  df6fab94d67 = 2:  ebba65e040c bulk-checkin: rename 'state' variable and separate 'plugged' boolean
 3:  fe19cdfc930 ! 3:  543ea356934 core.fsyncobjectfiles: batched disk flushes
     @@ Makefile: ifdef HAVE_CLOCK_MONOTONIC
       	EXTLIBS += -lrt
       endif
      
     - ## builtin/add.c ##
     -@@ builtin/add.c: int cmd_add(int argc, const char **argv, const char *prefix)
     - 
     - 	if (chmod_arg && pathspec.nr)
     - 		exit_status |= chmod_pathspec(&pathspec, chmod_arg[0], show_only);
     -+
     - 	unplug_bulk_checkin();
     - 
     - finish:
     -
       ## bulk-checkin.c ##
      @@
        */
 -:  ----------- > 4:  bdb99822f8c core.fsyncobjectfiles: add windows support for batch mode
 4:  485b4a767df ! 5:  92e18cedab0 update-index: use the bulk-checkin infrastructure
     @@ Commit message
      
          This change enables bulk-checkin for update-index infrastructure to
          speed up adding new objects to the object database by leveraging the
     -    pack functionality and the new bulk-fsync functionality. This mode
     -    is enabled when passing paths to update-index via the --stdin flag,
     -    as is done by 'git stash'.
     +    pack functionality and the new bulk-fsync functionality.
      
          There is some risk with this change, since under batch fsync, the object
          files will not be available until the update-index is entirely complete.
 5:  889e7668760 = 6:  e3c5a11f225 unpack-objects: use the bulk-checkin infrastructure
 6:  0f2e3b25759 = 7:  385199354fa core.fsyncobjectfiles: tests for batch mode
 7:  6543564376a = 8:  504bcc95c56 core.fsyncobjectfiles: performance tests for add and stash

-- 
gitgitgadget
