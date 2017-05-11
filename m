Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7C542018D
	for <e@80x24.org>; Thu, 11 May 2017 17:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932376AbdEKRva (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 13:51:30 -0400
Received: from mail-qt0-f176.google.com ([209.85.216.176]:35043 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932136AbdEKRv2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 13:51:28 -0400
Received: by mail-qt0-f176.google.com with SMTP id v27so11137837qtg.2
        for <git@vger.kernel.org>; Thu, 11 May 2017 10:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=slpiI+IuToVhI0jekZo6HenaLvAMQjmHWxftIBmjGL8=;
        b=RGuDoXS1r3Fyl5t+X/YiidkpwvVTo7YYqhlBboiGWbe34d7zEWJGLOzN+Cwz/NrwED
         GEsKVSWSsJATMYHw6uAvA2ZSuFIYlHdMVTq5LZ5sxeaHpDfV3V/7ZeahbKng5u3vLeau
         OLR11U2jWx99blOLFugUvNoJib1hCnCdJWejMXbuzy2X1uGBKSc8+DSQLJR0t+jseJ9V
         9B9e6pI1dD690zr6QVFFNbqTbI7pHiQwNBzIEdLnYB61oawxCQXo/kNgBXj3FHjn9eCu
         E7Abb9g0YV9Yw1fFAkCs4yJm3Ea8cIJAHs4gNHMuEAw6q/KM/uZhD4aSm6YBpVUzpojE
         xKIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=slpiI+IuToVhI0jekZo6HenaLvAMQjmHWxftIBmjGL8=;
        b=QqRd3TLgsgUbKIvCR08w8JEK5lukRBJB4S5Xj3HdarojBopW2YaiLpNbbMxzRbAkyR
         3DmFE9dTgDZ+rvPEXDObEEa6kC2IxUsI+QarDXRd8AcSLSF9VjUmsjs1ZsOzsh3GqZCd
         +9sNfDELKwaqek88ayN3TEaI+/4MW2CBkezfgxC5VnDcVfpdfOspc8CxQsiaQ9h89rZ9
         lfzUxV0DX22eKS5Ewvz18lkgQDqMZCOhUTw2T/VAUJnSv24DNtxiDpa5a8QUPFhNv4Y1
         UbOHwrpL80LQ528ZLJbo8FtpzJGzsGBViaKikJPUM54YzMRWgw4l2SdTkyr3OK5i2kZ7
         auNw==
X-Gm-Message-State: AODbwcDjlv6ubgQiMFaK0cTXql7Gjo63pno8g+vSVzVFd5ZAGArRxa9E
        MI7o+x3z0TtCrQ==
X-Received: by 10.200.3.103 with SMTP id w39mr43206qtg.230.1494525087010;
        Thu, 11 May 2017 10:51:27 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id g3sm561483qte.66.2017.05.11.10.51.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 May 2017 10:51:25 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH/RFC 0/6] Speed up git-grep by using PCRE v2 as a backend
Date:   Thu, 11 May 2017 17:51:09 +0000
Message-Id: <20170511175115.648-1-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thought I'd send this to the list too. This is first of my WIP
post-PCRE v2 inclusion series's.

In addition to the huge speed improvements for grep -P noted in the
culmination of that series[1], this speeds up all other types of grep
invocations (fixed string & POSIX basic/extended) by using an
experimental PCRE API to translate those patterns to PCRE syntax.

Fixed string grep is sped up by ~15-50%, and any greps containing
regexes by 40-70%, with 50% seeming to be the average for most normal
patterns.

It isn't ready for the reasons noted in the last patch in the series,
and currently brings most of PCRE into git in compat/pcre2 since it
uses an experimental API.

The 5/6 patch is pretty much ready though and works on stock PCRE, it
fixes TODO tests for patterns that contain a \0, and enables regex
metacharacters in such patterns (right now they're all implicitly
fixed strings), see the discussion in that patch for some of the
caveats.

That patch will most likely be dropped by the list, it can be
retrieved from https://github.com/avar/git
avar/grep-and-pcre-and-more, or the whole series viewed at
https://github.com/git/git/compare/master...avar:avar/grep-and-pcre-and-more.

1. <20170511170142.15934-8-avarab@gmail.com>
   (https://public-inbox.org/git/20170511170142.15934-8-avarab@gmail.com/)

Ævar Arnfjörð Bjarmason (6):
  Makefile & compat/pcre2: add ability to build an embedded PCRE
  Makefile & compat/pcre2: add dependency on pcre2_convert.c
  compat/pcre2: import pcre2 from svn trunk
  test-lib: add LIBPCRE1 & LIBPCRE2 prerequisites
  grep: support regex patterns containing \0 via PCRE v2
  grep: use PCRE v2 under the hood for -G & -E for amazing speedup

 Makefile                                           |    53 +
 compat/pcre2/get-pcre2.sh                          |    68 +
 compat/pcre2/src/pcre2.h                           |   832 ++
 compat/pcre2/src/pcre2_auto_possess.c              |  1291 ++
 compat/pcre2/src/pcre2_chartables.c                |     1 +
 compat/pcre2/src/pcre2_chartables.c.dist           |   198 +
 compat/pcre2/src/pcre2_compile.c                   |  9626 +++++++++++++++
 compat/pcre2/src/pcre2_config.c                    |   222 +
 compat/pcre2/src/pcre2_context.c                   |   450 +
 compat/pcre2/src/pcre2_convert.c                   |   724 ++
 compat/pcre2/src/pcre2_error.c                     |   327 +
 compat/pcre2/src/pcre2_find_bracket.c              |   218 +
 compat/pcre2/src/pcre2_internal.h                  |  1967 +++
 compat/pcre2/src/pcre2_intmodedep.h                |   884 ++
 compat/pcre2/src/pcre2_jit_compile.c               | 12307 +++++++++++++++++++
 compat/pcre2/src/pcre2_jit_match.c                 |   189 +
 compat/pcre2/src/pcre2_jit_misc.c                  |   227 +
 compat/pcre2/src/pcre2_maketables.c                |   157 +
 compat/pcre2/src/pcre2_match.c                     |  6826 ++++++++++
 compat/pcre2/src/pcre2_match_data.c                |   147 +
 compat/pcre2/src/pcre2_newline.c                   |   243 +
 compat/pcre2/src/pcre2_ord2utf.c                   |   120 +
 compat/pcre2/src/pcre2_string_utils.c              |   201 +
 compat/pcre2/src/pcre2_study.c                     |  1624 +++
 compat/pcre2/src/pcre2_tables.c                    |   765 ++
 compat/pcre2/src/pcre2_ucd.c                       |  3761 ++++++
 compat/pcre2/src/pcre2_ucp.h                       |   268 +
 compat/pcre2/src/pcre2_valid_utf.c                 |   398 +
 compat/pcre2/src/pcre2_xclass.c                    |   271 +
 compat/pcre2/src/sljit/sljitConfig.h               |   145 +
 compat/pcre2/src/sljit/sljitConfigInternal.h       |   725 ++
 compat/pcre2/src/sljit/sljitExecAllocator.c        |   312 +
 compat/pcre2/src/sljit/sljitLir.c                  |  2224 ++++
 compat/pcre2/src/sljit/sljitLir.h                  |  1392 +++
 compat/pcre2/src/sljit/sljitNativeARM_32.c         |  2326 ++++
 compat/pcre2/src/sljit/sljitNativeARM_64.c         |  2104 ++++
 compat/pcre2/src/sljit/sljitNativeARM_T2_32.c      |  1987 +++
 compat/pcre2/src/sljit/sljitNativeMIPS_32.c        |   437 +
 compat/pcre2/src/sljit/sljitNativeMIPS_64.c        |   539 +
 compat/pcre2/src/sljit/sljitNativeMIPS_common.c    |  2110 ++++
 compat/pcre2/src/sljit/sljitNativePPC_32.c         |   276 +
 compat/pcre2/src/sljit/sljitNativePPC_64.c         |   447 +
 compat/pcre2/src/sljit/sljitNativePPC_common.c     |  2421 ++++
 compat/pcre2/src/sljit/sljitNativeSPARC_32.c       |   165 +
 compat/pcre2/src/sljit/sljitNativeSPARC_common.c   |  1471 +++
 compat/pcre2/src/sljit/sljitNativeTILEGX-encoder.c | 10159 +++++++++++++++
 compat/pcre2/src/sljit/sljitNativeTILEGX_64.c      |  2555 ++++
 compat/pcre2/src/sljit/sljitNativeX86_32.c         |   602 +
 compat/pcre2/src/sljit/sljitNativeX86_64.c         |   742 ++
 compat/pcre2/src/sljit/sljitNativeX86_common.c     |  2921 +++++
 compat/pcre2/src/sljit/sljitProtExecAllocator.c    |   421 +
 compat/pcre2/src/sljit/sljitUtils.c                |   334 +
 grep.c                                             |    73 +-
 grep.h                                             |     5 +
 t/README                                           |    18 +
 t/t7008-grep-binary.sh                             |    87 +-
 t/test-lib.sh                                      |     3 +
 57 files changed, 81335 insertions(+), 31 deletions(-)
 create mode 100755 compat/pcre2/get-pcre2.sh
 create mode 100644 compat/pcre2/src/pcre2.h
 create mode 100644 compat/pcre2/src/pcre2_auto_possess.c
 create mode 120000 compat/pcre2/src/pcre2_chartables.c
 create mode 100644 compat/pcre2/src/pcre2_chartables.c.dist
 create mode 100644 compat/pcre2/src/pcre2_compile.c
 create mode 100644 compat/pcre2/src/pcre2_config.c
 create mode 100644 compat/pcre2/src/pcre2_context.c
 create mode 100644 compat/pcre2/src/pcre2_convert.c
 create mode 100644 compat/pcre2/src/pcre2_error.c
 create mode 100644 compat/pcre2/src/pcre2_find_bracket.c
 create mode 100644 compat/pcre2/src/pcre2_internal.h
 create mode 100644 compat/pcre2/src/pcre2_intmodedep.h
 create mode 100644 compat/pcre2/src/pcre2_jit_compile.c
 create mode 100644 compat/pcre2/src/pcre2_jit_match.c
 create mode 100644 compat/pcre2/src/pcre2_jit_misc.c
 create mode 100644 compat/pcre2/src/pcre2_maketables.c
 create mode 100644 compat/pcre2/src/pcre2_match.c
 create mode 100644 compat/pcre2/src/pcre2_match_data.c
 create mode 100644 compat/pcre2/src/pcre2_newline.c
 create mode 100644 compat/pcre2/src/pcre2_ord2utf.c
 create mode 100644 compat/pcre2/src/pcre2_string_utils.c
 create mode 100644 compat/pcre2/src/pcre2_study.c
 create mode 100644 compat/pcre2/src/pcre2_tables.c
 create mode 100644 compat/pcre2/src/pcre2_ucd.c
 create mode 100644 compat/pcre2/src/pcre2_ucp.h
 create mode 100644 compat/pcre2/src/pcre2_valid_utf.c
 create mode 100644 compat/pcre2/src/pcre2_xclass.c
 create mode 100644 compat/pcre2/src/sljit/sljitConfig.h
 create mode 100644 compat/pcre2/src/sljit/sljitConfigInternal.h
 create mode 100644 compat/pcre2/src/sljit/sljitExecAllocator.c
 create mode 100644 compat/pcre2/src/sljit/sljitLir.c
 create mode 100644 compat/pcre2/src/sljit/sljitLir.h
 create mode 100644 compat/pcre2/src/sljit/sljitNativeARM_32.c
 create mode 100644 compat/pcre2/src/sljit/sljitNativeARM_64.c
 create mode 100644 compat/pcre2/src/sljit/sljitNativeARM_T2_32.c
 create mode 100644 compat/pcre2/src/sljit/sljitNativeMIPS_32.c
 create mode 100644 compat/pcre2/src/sljit/sljitNativeMIPS_64.c
 create mode 100644 compat/pcre2/src/sljit/sljitNativeMIPS_common.c
 create mode 100644 compat/pcre2/src/sljit/sljitNativePPC_32.c
 create mode 100644 compat/pcre2/src/sljit/sljitNativePPC_64.c
 create mode 100644 compat/pcre2/src/sljit/sljitNativePPC_common.c
 create mode 100644 compat/pcre2/src/sljit/sljitNativeSPARC_32.c
 create mode 100644 compat/pcre2/src/sljit/sljitNativeSPARC_common.c
 create mode 100644 compat/pcre2/src/sljit/sljitNativeTILEGX-encoder.c
 create mode 100644 compat/pcre2/src/sljit/sljitNativeTILEGX_64.c
 create mode 100644 compat/pcre2/src/sljit/sljitNativeX86_32.c
 create mode 100644 compat/pcre2/src/sljit/sljitNativeX86_64.c
 create mode 100644 compat/pcre2/src/sljit/sljitNativeX86_common.c
 create mode 100644 compat/pcre2/src/sljit/sljitProtExecAllocator.c
 create mode 100644 compat/pcre2/src/sljit/sljitUtils.c

-- 
2.11.0

