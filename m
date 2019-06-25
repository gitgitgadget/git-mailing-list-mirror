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
	by dcvr.yhbt.net (Postfix) with ESMTP id AE2921F461
	for <e@80x24.org>; Tue, 25 Jun 2019 14:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731251AbfFYOtb (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 10:49:31 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:38718 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731171AbfFYOtb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 10:49:31 -0400
Received: by mail-ed1-f52.google.com with SMTP id r12so27587832edo.5
        for <git@vger.kernel.org>; Tue, 25 Jun 2019 07:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/Ujp3HFrfFcTFry69M4lgLP6JlH9PVEwA7gZQqNcoWM=;
        b=tJnYdX7TlFsrkCdLcXuNPnN5Ofv/fNPyR+ELhD6kK+RFoevxYRBgdxEusF5d68iy3H
         udDQcTMggzGrDL9bf9wNbaS2uwLeDGnRQuUPhFT0+OrBmi3jNn667WPNpAHS3pU0sv7n
         6ebAjtwCTe1X9awu+6HOpDG5ngV5rR/XiToJzH2rvbCnGOA7irEq5jdeHnHcG9Mgb9RF
         ZB+lCK9IsJAng8yBnyLCQZllD9i4RsWaeMq3kEaUWF/f7/qOokUljJje8iat5Wn8hMxI
         898ExQXDqa0kiqBmlNBYBRQX2xFeAsO+CmtzI3VfQfW7hFxUMYYKz587hza+BW9eVcwt
         60xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/Ujp3HFrfFcTFry69M4lgLP6JlH9PVEwA7gZQqNcoWM=;
        b=MmGjJST628xf3o31uqmKbybBcvr4umMXobY4O305vdCp7WcmtOBPZUT+VGmcqCt6KW
         eISPdJf8tYwThJOpAiEA+vaLLI2yjYcQOYOBKgmrig7x47GvMDq+ASAjlr4tfUBGVgyb
         1wJ3+waksTlF68SHmp5QM+EmMkUW4yd4Rzx8iuhqfYo/2kbFv2571aLC6E+J1GRwhxAg
         HXqfDhNVwBJtgTuKlq9JMMEpkCtkMJnf9ipfvnnQT7TredZBRi4vbStGPDhebMn8U3Tt
         UObap6EzsmeQTe3FQuuHIIgJwn8+HjQXBCUxOWXjhHoJt4TYm14GpXrhSeoLFywmuOqR
         9Yvw==
X-Gm-Message-State: APjAAAVXpKl/JL3UHzkE6ZFnZ2c7H1CAKHOXj6OfmPhnKgX2DXjpJLk9
        PC8RDN4W/nJ78hbcAbGhTF2cFy4Z
X-Google-Smtp-Source: APXvYqzFkeel85dXQsPUpP3huTayxp/KzuMe6iwdCM6vbDFYx98VTFQqvavEZK+PsDG/hKjRNNqxUA==
X-Received: by 2002:a17:906:27c7:: with SMTP id k7mr19824670ejc.91.1561474168561;
        Tue, 25 Jun 2019 07:49:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v12sm2504160ejj.52.2019.06.25.07.49.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 07:49:28 -0700 (PDT)
Date:   Tue, 25 Jun 2019 07:49:28 -0700 (PDT)
X-Google-Original-Date: Tue, 25 Jun 2019 14:49:06 GMT
Message-Id: <pull.149.v3.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.149.v2.git.gitgitgadget@gmail.com>
References: <pull.149.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 00/20] Fix MSVC support, at long last
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Carlo Arenas <carenas@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley and Jeff Hostetler worked quite a bit on getting Git to
compile with MS Visual C again, and this patch series is the culmination of
those efforts. With these patches, it is as easy as

make MSVC=1

Note: the patches went through quite the number of iterations. For example,
for a long time we targeted Visual Studio 2015, and used NuGet packages for
the dependencies (such as OpenSSL, cURL, etc), while the current iteration
targets Visual Studio 2017 and uses vcpkg
[https://docs.microsoft.com/en-us/cpp/vcpkg?view=vs-2017] for dependencies.
Hopefully I did not forget to remove any remnants of those previous
versions.

Please also note that this patch series is part 1 of 3 in a bigger story:
the next patch series will add support to build Git in Microsoft Visual
Studio, and the third patch series will add Continuous Testing by adding an
MSVC build and a corresponding parallelized test job to our Azure Pipeline.

Changes since v2:

 * Fixed the incorrect split-out of the "msvc: update Makefile to allow for
   spaces in the compiler path" patch: I had accidentally reverted that
   change in a later patch in the series.

Changes since v1:

 * The BASIC_CLFAGS typo was fixed.
 * Instead of sorting the output of stdout/stderr, the fixed test case in 
   t0001 now greps for the tell-tales it wants to be present.
 * In addition to cache-tree.c's DEBUG constant, now also builtin/blame.c's
   is renamed.
 * Two changes were factored out of the patch titled "msvc: support building
   Git using MS Visual C++": the support for spaces in SANE_TOOL_PATH, and
   the support for the compile time flag to enable CrtDbg's detailed heap
   diagnostics.
 * A comment about the vcxproj target has been dropped; The corresponding
   change is slated for a future patch series.
 * A left-over "TODO" comment was replaced by stating the final decision
   that only Visual Studio 2015 or later are supported for now.
 * A left-over, commented-out SIGINT case label was removed, and an adjacent
   comment was moved so that its indentation no longer looks strange.

Jeff Hostetler (10):
  cache-tree/blame: avoid reusing the DEBUG constant
  msvc: mark a variable as non-const
  msvc: do not re-declare the timespec struct
  msvc: define ftello()
  msvc: fix detect_msys_tty()
  msvc: update Makefile to allow for spaces in the compiler path
  msvc: support building Git using MS Visual C++
  msvc: add a compile-time flag to allow detailed heap debugging
  msvc: do not pretend to support all signals
  msvc: ignore .dll and incremental compile output

Johannes Schindelin (7):
  mingw: fix a typo in the msysGit-specific section
  Mark .bat files as requiring CR/LF endings
  t0001 (mingw): do not expect a specific order of stdout/stderr
  obstack: fix compiler warning
  mingw: replace mingw_startup() hack
  msvc: fix dependencies of compat/msvc.c
  msvc: avoid debug assertion windows in Debug Mode

Philip Oakley (3):
  msvc: include sigset_t definition
  msvc: define O_ACCMODE
  msvc: add pragmas for common warnings

 .gitattributes                     |   1 +
 .gitignore                         |   5 +
 Makefile                           |  42 +++++++-
 builtin/blame.c                    |   6 +-
 cache-tree.c                       |  14 +--
 compat/mingw.c                     |  99 +++++++++++++----
 compat/mingw.h                     |  24 +++--
 compat/msvc.h                      |  10 ++
 compat/obstack.h                   |   2 +-
 compat/vcbuild/.gitignore          |   3 +
 compat/vcbuild/README              |  39 +++++++
 compat/vcbuild/find_vs_env.bat     | 168 +++++++++++++++++++++++++++++
 compat/vcbuild/scripts/clink.pl    |  41 ++++++-
 compat/vcbuild/vcpkg_copy_dlls.bat |  39 +++++++
 compat/vcbuild/vcpkg_install.bat   |  80 ++++++++++++++
 compat/winansi.c                   |  13 +++
 config.mak.uname                   |  83 +++++++++++---
 git-compat-util.h                  |   9 ++
 t/t0001-init.sh                    |   4 +-
 19 files changed, 620 insertions(+), 62 deletions(-)
 create mode 100644 compat/vcbuild/.gitignore
 create mode 100644 compat/vcbuild/find_vs_env.bat
 create mode 100644 compat/vcbuild/vcpkg_copy_dlls.bat
 create mode 100644 compat/vcbuild/vcpkg_install.bat


base-commit: b697d92f56511e804b8ba20ccbe7bdc85dc66810
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-149%2Fdscho%2Fmsvc-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-149/dscho/msvc-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/149

Range-diff vs v2:

  1:  9d4d6ae7db =  1:  9d4d6ae7db mingw: fix a typo in the msysGit-specific section
  2:  aa27e7f9cb =  2:  aa27e7f9cb Mark .bat files as requiring CR/LF endings
  3:  3e108cfb02 =  3:  3e108cfb02 t0001 (mingw): do not expect a specific order of stdout/stderr
  4:  90ac088d22 =  4:  90ac088d22 cache-tree/blame: avoid reusing the DEBUG constant
  5:  71d85b58b6 =  5:  71d85b58b6 obstack: fix compiler warning
  6:  02f618464f =  6:  02f618464f mingw: replace mingw_startup() hack
  7:  5c383985a1 =  7:  5c383985a1 msvc: fix dependencies of compat/msvc.c
  8:  0a2985dc3c =  8:  0a2985dc3c msvc: include sigset_t definition
  9:  99a2939cc2 =  9:  99a2939cc2 msvc: define O_ACCMODE
 10:  1542e8abe5 = 10:  1542e8abe5 msvc: mark a variable as non-const
 11:  51d73c61d3 = 11:  51d73c61d3 msvc: do not re-declare the timespec struct
 12:  7cfd0fc9b4 = 12:  7cfd0fc9b4 msvc: define ftello()
 13:  f528883d97 = 13:  f528883d97 msvc: fix detect_msys_tty()
 14:  63bf9f1f92 = 14:  63bf9f1f92 msvc: update Makefile to allow for spaces in the compiler path
 15:  245f28ac3b ! 15:  fee0ad048e msvc: support building Git using MS Visual C++
     @@ -43,15 +43,6 @@
       --- a/Makefile
       +++ b/Makefile
      @@
     - 
     - ifdef SANE_TOOL_PATH
     - SANE_TOOL_PATH_SQ = $(subst ','\'',$(SANE_TOOL_PATH))
     --BROKEN_PATH_FIX = 's|^\# @@BROKEN_PATH_FIX@@$$|git_broken_path_fix "$(SANE_TOOL_PATH_SQ)"|'
     -+BROKEN_PATH_FIX = 's|^\# @@BROKEN_PATH_FIX@@$$|git_broken_path_fix $(SANE_TOOL_PATH_SQ)|'
     - PATH := $(SANE_TOOL_PATH):${PATH}
     - else
     - BROKEN_PATH_FIX = '/^\# @@BROKEN_PATH_FIX@@$$/d'
     -@@
       	$(INSTALL) $(ALL_PROGRAMS) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
       	$(INSTALL) -m 644 $(SCRIPT_LIB) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
       	$(INSTALL) $(install_bindir_programs) '$(DESTDIR_SQ)$(bindir_SQ)'
 16:  e7888bedbd = 16:  993b6bcd0a msvc: add a compile-time flag to allow detailed heap debugging
 17:  d9668558dd = 17:  42f5b8cee8 msvc: add pragmas for common warnings
 18:  c883f037e0 = 18:  c9a6f6892c msvc: do not pretend to support all signals
 19:  51a20ff2df = 19:  7cb0434fac msvc: avoid debug assertion windows in Debug Mode
 20:  4d44d1fab1 = 20:  4a7ceb2172 msvc: ignore .dll and incremental compile output

-- 
gitgitgadget
