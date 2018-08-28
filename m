Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D58B1F404
	for <e@80x24.org>; Tue, 28 Aug 2018 09:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbeH1NnZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 09:43:25 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53333 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbeH1NnY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 09:43:24 -0400
Received: by mail-wm0-f65.google.com with SMTP id b19-v6so1242554wme.3
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 02:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d6OQHh5O0XP49/StTh7irIkQn5rPtH/MILkse0Zs3gE=;
        b=tqf/ta5PhfIyiC1CYfXtjnZSlyo5K4lFOrsiGPa/EZohsZ7gXpxs0/QQ2HIBYNtOFS
         +Fnk1dBTX7aUcaG7or0q7cv5H/il76ymepW7bJ3S9Y9ZtZBd7325eh3CsR2tmwOdgED8
         9PBr6dsADpU+ndx9VnFeuGBCZiBP3TmrlgOqELeJwMVk4RUiv8Hs2QovEVkhpNESxJgU
         gJS4zeooZmfpj6FVrSCQYdTCBGiWS8z2xCyfZpU0PknXytz/MK8S9W4oW2Sf/lmRCQh8
         6sjFofcXAqq79uySGbqVJYrUtj18vMWsZB/6VGwoSUwwaJviGu7CZYh0b8nDc2NPrGae
         dFPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d6OQHh5O0XP49/StTh7irIkQn5rPtH/MILkse0Zs3gE=;
        b=GeZcD1S2mfllvlPNqd19xN4Vwgv/eku3/tw4KkK+H9h97Xsm5w1Cj9saeuWB/wPMcT
         h6gPFS274nhWkIve8yZ7/Sz5f13vER9+hIQLPIAOYUGymE/6ZPe/VLHTOrIux0Khl9pK
         AqBASIRgbKAQDf6Hny0nNTR7eYbRsK8DYy0fNGKcS1goP7jU0i8utTuXfRWsq1kTk7PX
         4S5TgVGJcUuE+VufHjIrK9ySijUw70ZrjAkEfMiXxX9mgnZPvZj6YBzYmXpuzi9r00+S
         H5VSTz1r4+MOwTMvtnAX/RV466Dmjb9pisp6MCloW/ozJMFhlqTMq2pXfp4Uop+G4t1W
         7WNA==
X-Gm-Message-State: APzg51CmcEbGr972UEtfY0xY5oyedzrrGKMW2BbjR7BOeBbONuLAVwap
        f3hDZOG970c15DGgk9dpjOuNcSsqiH8=
X-Google-Smtp-Source: ANB0VdaLsfCX+dspayrCp4WaeEtJ7/B2HwUCsEDBfDlwYN/Uf9+BtJZURZs961ynZ97K6SL4o4iWUA==
X-Received: by 2002:a1c:3a92:: with SMTP id h140-v6mr897070wma.41.1535449951056;
        Tue, 28 Aug 2018 02:52:31 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id a37-v6sm1572238wrc.21.2018.08.28.02.52.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 02:52:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 0/8] use oidset for skiplist + docs + tests + comment support
Date:   Tue, 28 Aug 2018 09:52:11 +0000
Message-Id: <20180828095219.23296-1-avarab@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0
In-Reply-To: <87lg8refcr.fsf@evledraar.gmail.com>
References: <87lg8refcr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 27 2018, Ævar Arnfjörð Bjarmason wrote:

> On Mon, Aug 27 2018, Ævar Arnfjörð Bjarmason wrote:
> Does that just mean that when cloning with --recursive with
> transfer.fsckObjects=true we'll re-read the file for each "clone"
> invocation, both for the main project and everything listed in
> .gitmodules?
>
> If so, I think something like this commit message would be clearer:

Here's a version that does that, I also integrated the perf test René
wrote and used it in the commit messages. The range-diff with v3
follows:

1:  09b52b0eae = 1:  ba9ef73304 fsck tests: setup of bogus commit object
2:  294a4dfd69 = 2:  1d20e37d3f fsck tests: add a test for no skipList input
3:  15a6e16dc1 = 3:  953ad29f6d fsck: document and test sorted skipList input
4:  b93fe502c3 = 4:  c8a0bd1555 fsck: document and test commented & empty line skipList input
-:  ---------- > 5:  cbbb0326d3 fsck: add a performance test for skipList
5:  3cf7d4e9eb ! 6:  ca6aca2994 fsck: use strbuf_getline() to read skiplist file
    @@ -2,14 +2,33 @@
     
         fsck: use strbuf_getline() to read skiplist file
     
    -    buffer is unlikely to contain a NUL character, so printing its contents
    -    using %s in a die() format is unsafe (detected with ASan).
    +    The buffer is unlikely to contain a NUL character, so printing its
    +    contents using %s in a die() format is unsafe (detected with ASan).
     
         Use an idiomatic strbuf_getline() loop instead, which ensures the buffer
         is always NUL-terminated, supports CRLF files as well, accepts files
         without a newline after the last line, supports any hash length
         automatically, and is shorter.
     
    +    This fixes a bug where emitting an error about an invalid line on say
    +    line 1 would continue printing subsequent lines, and usually continue
    +    into uninitialized memory.
    +
    +    The performance impact of this, on a CentOS 7 box with RedHat GCC
    +    4.8.5-28:
    +
    +        $ GIT_PERF_REPEAT_COUNT=5 GIT_PERF_MAKE_OPTS='-j56 CFLAGS="-O3"' ./run HEAD~ HEAD p1450-fsck-skip-list.sh
    +        Test                                             HEAD~             HEAD
    +        ----------------------------------------------------------------------------------------
    +        1450.3: fsck with 0 skipped bad commits          7.75(7.39+0.35)   7.68(7.29+0.39) -0.9%
    +        1450.5: fsck with 1 skipped bad commits          7.70(7.30+0.40)   7.80(7.42+0.37) +1.3%
    +        1450.7: fsck with 10 skipped bad commits         7.77(7.37+0.40)   7.87(7.47+0.40) +1.3%
    +        1450.9: fsck with 100 skipped bad commits        7.82(7.41+0.40)   7.88(7.43+0.44) +0.8%
    +        1450.11: fsck with 1000 skipped bad commits      7.88(7.49+0.39)   7.84(7.43+0.40) -0.5%
    +        1450.13: fsck with 10000 skipped bad commits     8.02(7.63+0.39)   8.07(7.67+0.39) +0.6%
    +        1450.15: fsck with 100000 skipped bad commits    8.01(7.60+0.41)   8.08(7.70+0.38) +0.9%
    +        1450.17: fsck with 1000000 skipped bad commits   7.60(7.10+0.50)   7.37(7.18+0.19) -3.0%
    +
         Helped-by: Jeff King <peff@peff.net>
         Signed-off-by: Rene Scharfe <l.s.r@web.de>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
6:  bd51de7c14 ! 7:  58bfd04d96 fsck: use oidset for skiplist
    @@ -1,22 +1,33 @@
     Author: René Scharfe <l.s.r@web.de>
     
    -    fsck: use oidset for skiplist
    +    fsck: use oidset instead of oid_array for skipList
     
    -    Object IDs to skip are stored in a shared static oid_array.  Lookups do
    -    a binary search on the sorted array.  The code checks if the object IDs
    -    are already in the correct order while loading and skips sorting in that
    -    case.  Lookups are done before reporting a (non-fatal) corruption and
    -    before checking .gitmodules files.
    +    Change the implementation of the skipList feature to use oidset
    +    instead of oid_array to store SHA-1s for later lookup.
     
    -    Simplify the code by using an oidset instead.  Memory usage is a bit
    -    higher, but we don't need to worry about any sort order anymore.  Embed
    -    the oidset into struct fsck_options to make its ownership clear (no
    -    hidden sharing) and avoid unnecessary pointer indirection.
    +    This list is parsed once on startup by fsck, fetch-pack or
    +    receive-pack depending on the *.skipList config in use. I.e. only once
    +    per invocation, but note that for "clone --recurse-submodules" each
    +    submodule will re-parse the list, in addition to the main project.
     
    -    Performance on repositories with a low number of reported issues and
    -    .gitmodules files (i.e. the usual case) won't be affected much.  The
    -    oidset should be a bit quicker with higher numbers of bad objects in
    -    the skipList.
    +    Memory usage is a bit higher, but we don't need to keep track of the
    +    sort order anymore. Embed the oidset into struct fsck_options to make
    +    its ownership clear (no hidden sharing) and avoid unnecessary pointer
    +    indirection.
    +
    +    The cumulative impact on performance of this & the preceding change,
    +    using the test setup described in the previous commit:
    +
    +        Test                                             HEAD~2            HEAD~                   HEAD
    +        ----------------------------------------------------------------------------------------------------------------
    +        1450.3: fsck with 0 skipped bad commits          7.70(7.31+0.38)   7.72(7.33+0.38) +0.3%   7.70(7.30+0.40) +0.0%
    +        1450.5: fsck with 1 skipped bad commits          7.84(7.47+0.37)   7.69(7.32+0.36) -1.9%   7.71(7.29+0.41) -1.7%
    +        1450.7: fsck with 10 skipped bad commits         7.81(7.40+0.40)   7.94(7.57+0.36) +1.7%   7.92(7.55+0.37) +1.4%
    +        1450.9: fsck with 100 skipped bad commits        7.81(7.42+0.38)   7.95(7.53+0.41) +1.8%   7.83(7.42+0.41) +0.3%
    +        1450.11: fsck with 1000 skipped bad commits      7.99(7.62+0.36)   7.90(7.50+0.40) -1.1%   7.86(7.49+0.37) -1.6%
    +        1450.13: fsck with 10000 skipped bad commits     7.98(7.57+0.40)   7.94(7.53+0.40) -0.5%   7.90(7.45+0.44) -1.0%
    +        1450.15: fsck with 100000 skipped bad commits    7.97(7.57+0.39)   8.03(7.67+0.36) +0.8%   7.84(7.43+0.41) -1.6%
    +        1450.17: fsck with 1000000 skipped bad commits   7.72(7.22+0.50)   7.28(7.07+0.20) -5.7%   7.13(6.87+0.25) -7.6%
     
         Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
         Signed-off-by: Rene Scharfe <l.s.r@web.de>
7:  17838cf68c ! 8:  0125461f13 fsck: support comments & empty lines in skipList
    @@ -11,6 +11,20 @@
         since this on-disk format can be expected to be used by multiple
         versions of git.
     
    +    There is no notable performance impact from this change, using the
    +    test setup described a couple of commist back:
    +
    +        Test                                             HEAD~             HEAD
    +        ----------------------------------------------------------------------------------------
    +        1450.3: fsck with 0 skipped bad commits          7.81(7.42+0.39)   7.72(7.34+0.38) -1.2%
    +        1450.5: fsck with 1 skipped bad commits          7.75(7.36+0.38)   7.66(7.26+0.39) -1.2%
    +        1450.7: fsck with 10 skipped bad commits         7.81(7.43+0.38)   7.70(7.30+0.39) -1.4%
    +        1450.9: fsck with 100 skipped bad commits        7.85(7.42+0.42)   7.73(7.31+0.41) -1.5%
    +        1450.11: fsck with 1000 skipped bad commits      7.81(7.43+0.38)   7.84(7.46+0.38) +0.4%
    +        1450.13: fsck with 10000 skipped bad commits     7.87(7.47+0.40)   7.86(7.46+0.40) -0.1%
    +        1450.15: fsck with 100000 skipped bad commits    7.77(7.39+0.38)   7.83(7.48+0.34) +0.8%
    +        1450.17: fsck with 1000000 skipped bad commits   7.17(6.92+0.24)   7.11(6.85+0.26) -0.8%
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
     diff --git a/Documentation/config.txt b/Documentation/config.txt

René Scharfe (3):
  fsck: add a performance test for skipList
  fsck: use strbuf_getline() to read skiplist file
  fsck: use oidset instead of oid_array for skipList

Ævar Arnfjörð Bjarmason (5):
  fsck tests: setup of bogus commit object
  fsck tests: add a test for no skipList input
  fsck: document and test sorted skipList input
  fsck: document and test commented & empty line skipList input
  fsck: support comments & empty lines in skipList

 Documentation/config.txt        | 22 ++++++++++----
 fsck.c                          | 48 ++++++++++-------------------
 fsck.h                          |  8 +++--
 t/perf/p1450-fsck-skip-list.sh  | 40 +++++++++++++++++++++++++
 t/t5504-fetch-receive-strict.sh | 53 ++++++++++++++++++++++++++++++---
 5 files changed, 126 insertions(+), 45 deletions(-)
 create mode 100755 t/perf/p1450-fsck-skip-list.sh

-- 
2.19.0.rc0.228.g281dcd1b4d0

