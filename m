Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE08C1F403
	for <e@80x24.org>; Fri,  8 Jun 2018 22:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752910AbeFHWlw (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 18:41:52 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:40326 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752898AbeFHWlu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 18:41:50 -0400
Received: by mail-wr0-f194.google.com with SMTP id l41-v6so14772455wre.7
        for <git@vger.kernel.org>; Fri, 08 Jun 2018 15:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GFEgbOBVJ53u/1ZqtHI51Xi7QhEoNZ3Zvb+Wq4kxL/M=;
        b=Dok4xYDhdiG9hrFormFX/UgMQd6IHcrm+2FZgsBnJzqLw0tJ1PZEdrlF57QKcztPt9
         S+VFf981d2F94AJoCRqIWBGktGI+nvEzQZuGT6nJ7/Bwp8u0jtpJ5eQdMU853BYRQn78
         PFNPPtlhlL3iubd1WIrwibSsAd1tSwLhl7qPRrXKwv5viPSQwk5NZwbxf34N5lj0Z5iZ
         GazbJuGdiWTqbaDL17jgiUM/Rl6J2jFagUVVpjjj3Ce30x1y7alg5P66b+ai11+MiuYv
         V035w+QxUilYZy9ibNKAPttfTY9jtGNiTGV6TdMMMIaU/C2EmEpRw8l1pX3/nZoPt3+g
         5Ugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GFEgbOBVJ53u/1ZqtHI51Xi7QhEoNZ3Zvb+Wq4kxL/M=;
        b=uEYAHsZ7qtQ1wTwsMgBaH+2dLnygneB0gUOGpKIYljU8MTZ6TEtcvmdVHbIDAE66U8
         beyloKminOGAn3guyNYab7fr+9KgrTRusa1aRejaKgc9Ga5WNGbHqxa62gXAeu59nYaS
         1JPlaVpVGuVaE2DDhCuTAByPYUnY4H3ER30G1vr8m+ABvKVyHruCAfD0Pf9Y6W+9LbxI
         Z8F+ooxaZ2iVrqVzYpm9V8dfqezXdiIaW8B+Sa3QZtAQ2G/piBLvq5Jhr6/SRCm+5HjW
         znPzRHsdDh4jVj9qUjNUVRRlnQGUMe1hiRZsCNiO7vAQIDVR2PT/f+vx08ueAcvVXBs1
         +5jg==
X-Gm-Message-State: APt69E0TGlse+HyNWyesYqgV5aidZSZkOSAtikv4MXPCfE4deH1bsMqg
        Sz5edIf673JcAnZhCpvkS+4G4jjq
X-Google-Smtp-Source: ADUXVKJK1kd7c5EuvcZvS8xvB9z2gjIDMVcKvZLMmrs/K5LrRZVN1Wr7QwokD5cHvGUekxi8XOWSFQ==
X-Received: by 2002:adf:f090:: with SMTP id n16-v6mr6733771wro.49.1528497709268;
        Fri, 08 Jun 2018 15:41:49 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id w15-v6sm36350010wro.52.2018.06.08.15.41.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 15:41:48 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, dstolee@microsoft.com,
        git@jeffhostetler.com, peff@peff.net, johannes.schindelin@gmx.de,
        jrnieder@gmail.com, Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 00/20] unconditional O(1) SHA-1 abbreviation
Date:   Fri,  8 Jun 2018 22:41:16 +0000
Message-Id: <20180608224136.20220-1-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series implements an entirely alternate method of achieving
some of the same ends as the MIDX, using the approach suggested by
Jeff King from the RFC thread back in January[1]. You can now do:

    core.abbrev = 20
    core.validateAbbrev = false

Or:

    core.abbrev = +2
    core.validateAbbrev = false

On linux.git `git log --oneline --raw --parents` with 64MB packs gives
this improvement with core.abbrev=15 & core.validateAbbrev=false
(v.s. true):

    Test                                        HEAD~               HEAD
    ----------------------------------------------------------------------------------------
    0014.1: git log --oneline --raw --parents   95.68(95.07+0.53)   42.74(42.33+0.39) -55.3%

While cleaning up the RFC version of this which I sent in [2] I
discovered that almost none of the existing functionality was tested
for, and was very inconsistent since we have 4 different places where
the abbrev config is parsed.

See 19/20 and 20/20 for what this whole thing is building towards, the
rest is all tests, cleanup, and preparatory work.

(There's still other long-standing issues with the existing behavior
which this doesn't change, but I had to stop somewhere to make this
digestible).

1. https://public-inbox.org/git/20180108102029.GA21232@sigill.intra.peff.net/
2. https://public-inbox.org/git/20180606102719.27145-1-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (20):
  t/README: clarify the description of test_line_count
  test library: add a test_byte_count
  blame doc: explicitly note how --abbrev=40 gives 39 chars
  abbrev tests: add tests for core.abbrev and --abbrev
  abbrev tests: test "git-blame" behavior
  blame: fix a bug, core.abbrev should work like --abbrev
  abbrev tests: test "git branch" behavior
  abbrev tests: test for "git-describe" behavior
  abbrev tests: test for "git-log" behavior
  abbrev tests: test for "git-diff" behavior
  abbrev tests: test for plumbing behavior
  abbrev tests: test for --abbrev and core.abbrev=[+-]N
  parse-options-cb.c: convert uses of 40 to GIT_SHA1_HEXSZ
  config.c: use braces on multiple conditional arms
  parse-options-cb.c: use braces on multiple conditional arms
  abbrev: unify the handling of non-numeric values
  abbrev: unify the handling of empty values
  abbrev parsing: use braces on multiple conditional arms
  abbrev: support relative abbrev values
  abbrev: add a core.validateAbbrev setting

 Documentation/config.txt            |  49 +++
 Documentation/diff-options.txt      |   3 +
 Documentation/git-blame.txt         |  14 +
 Documentation/git-branch.txt        |   3 +
 Documentation/git-describe.txt      |   3 +
 Documentation/git-ls-files.txt      |   3 +
 Documentation/git-ls-tree.txt       |   3 +
 Documentation/git-show-ref.txt      |   3 +
 builtin/blame.c                     |   2 +
 cache.h                             |   2 +
 config.c                            |  22 +-
 diff.c                              |  24 +-
 environment.c                       |   2 +
 parse-options-cb.c                  |  19 +-
 revision.c                          |  24 +-
 sha1-name.c                         |  15 +
 t/README                            |   6 +-
 t/perf/p0014-abbrev.sh              |  13 +
 t/t0014-abbrev.sh                   | 452 ++++++++++++++++++++++++++++
 t/t1512-rev-parse-disambiguation.sh |  47 +++
 t/t6006-rev-list-format.sh          |   6 +-
 t/test-lib-functions.sh             |  23 ++
 22 files changed, 722 insertions(+), 16 deletions(-)
 create mode 100755 t/perf/p0014-abbrev.sh
 create mode 100755 t/t0014-abbrev.sh

-- 
2.17.0.290.gded63e768a

