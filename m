Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADDA61F404
	for <e@80x24.org>; Sun, 28 Jan 2018 00:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752052AbeA1AN1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Jan 2018 19:13:27 -0500
Received: from mail-lf0-f41.google.com ([209.85.215.41]:41758 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751785AbeA1AN0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Jan 2018 19:13:26 -0500
Received: by mail-lf0-f41.google.com with SMTP id f136so5011225lff.8
        for <git@vger.kernel.org>; Sat, 27 Jan 2018 16:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=EHBcHREJCmut46+N6MDEsMjMbdK+Dj8FF/S5500o4hs=;
        b=ZCiW08pOJy079N/bTsolHYKEQByk+r1nagYhqyl3WTauoZ3UcAcUn2Bf3mwFK2zMDY
         OaofHUgPUJGf/iHSU9xC+rLaadOYGuUpbMzp+Z2mo6Odxzy/NAalLUvbKzClS+IeAi81
         9oATIQ2894CrtuE5bYeRmPLTV22QJTKf3CywRg7xERSNRgKo3BS+ZcKFADyoKq9OmP1P
         rB4Ysx8B3XIWXz9ZTwDqAZZ1WYul+W1Mz19do6o0Od/plEoH+5T6rH1W0SPGhn4yF+K7
         rT/bfirUqOZ03mii9zk4e747IpAhBoWL7ItMXiyopikwIPF4ZwU+RLY0AJAaIkZCx1GD
         e2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=EHBcHREJCmut46+N6MDEsMjMbdK+Dj8FF/S5500o4hs=;
        b=BdxdycW0t802QNMA0tUHLgVujHVnoETBfoCOX9K7VWCFcgCK0lUIxFlJ4Ptp9TBiaX
         DQA+Qk3UjzdjZaIFFghPlTTzwgrYZ2FX0+pieeECfSJWrPuuzjkjO8jtxHvX/AnjU6L2
         KUTOPWoeEhS7eIlRhhSZZJPi836rlGkqB1Von4ePxHNAlavY6AlOG9LL8nzPlVDtMtdz
         ceLfTmwfiw3IOLl+PduptAJj0ZlRYIdC001xLhm8wm5BaPZEXpYyJUhyjpEycKzoeD5/
         +uIZ7j2Z954iQ30npxpFyUuhPVf8RAxOc2EOmvM/PtOR6wsTr0wpBsADylBSx91R56p5
         ytoA==
X-Gm-Message-State: AKwxytcViUeTuD8esgiQSGLSKv3WmxOhcPyR7XnOrrwOOBal88Cu+9ti
        iaRupFzbJRgrKlX8CSn/2VK8wJak
X-Google-Smtp-Source: AH8x226xJFmjAhiKmMdnxLMe/77s/WXY+HHEwTNlNWK/ikOu79pHNQqrdp5xdXTCRmNIo6hS+cu0Qw==
X-Received: by 10.46.74.1 with SMTP id x1mr10899651lja.84.1517098404339;
        Sat, 27 Jan 2018 16:13:24 -0800 (PST)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id y26sm2144695lfk.30.2018.01.27.16.13.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Jan 2018 16:13:23 -0800 (PST)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 00/12] A bunch of object_id conversions
Date:   Sun, 28 Jan 2018 01:13:10 +0100
Message-Id: <cover.1517097306.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <cover.1516790478.git.patryk.obara@gmail.com>
References: <cover.1516790478.git.patryk.obara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you, everyone, for review and thanks, Junio for queueing two
first patches - I removed them from v4, as there were no more comments
to them anyway.

Compared to v3:

Patch 2 (formerly 4)
- renamed all parameter names sha1_stat to oid_stat
- renamed static function load sha1_stat to load_oid_stat
- adjusted a comment, that included "sha1_stat" in text

Patch 11 (formerly 13)
- fixed a typo in the commit message

Hopefully, this will be the last iteration on this batch of object_id
conversions; I already have next batch prepared (I just need to clean
it up before sending).

Patryk Obara (12):
  sha1_file: convert pretend_sha1_file to object_id
  dir: convert struct sha1_stat to use object_id
  sha1_file: convert hash_sha1_file to object_id
  cache: clear whole hash buffer with oidclr
  match-trees: convert splice_tree to object_id
  commit: convert commit_tree* to object_id
  notes: convert combine_notes_* to object_id
  notes: convert write_notes_tree to object_id
  sha1_file: convert write_sha1_file to object_id
  sha1_file: convert force_object_loose to object_id
  sha1_file: convert write_loose_object to object_id
  sha1_file: rename hash_sha1_file_literally

 Documentation/technical/api-object-access.txt |   2 +-
 apply.c                                       |  12 +--
 blame.c                                       |   2 +-
 builtin/am.c                                  |   4 +-
 builtin/checkout.c                            |   3 +-
 builtin/commit-tree.c                         |   4 +-
 builtin/commit.c                              |   5 +-
 builtin/hash-object.c                         |   3 +-
 builtin/index-pack.c                          |   5 +-
 builtin/merge.c                               |   8 +-
 builtin/mktag.c                               |   6 +-
 builtin/mktree.c                              |  10 +--
 builtin/notes.c                               |   8 +-
 builtin/pack-objects.c                        |   2 +-
 builtin/receive-pack.c                        |  11 +--
 builtin/replace.c                             |   4 +-
 builtin/tag.c                                 |   2 +-
 builtin/unpack-objects.c                      |  11 ++-
 cache-tree.c                                  |  16 ++--
 cache.h                                       |  25 +++++--
 commit.c                                      |  15 ++--
 commit.h                                      |  11 +--
 convert.c                                     |   6 +-
 diffcore-rename.c                             |   4 +-
 dir.c                                         | 104 +++++++++++++-------------
 dir.h                                         |  12 +--
 log-tree.c                                    |   2 +-
 match-trees.c                                 |  46 ++++++------
 merge-recursive.c                             |   5 +-
 notes-cache.c                                 |   8 +-
 notes-merge.c                                 |   9 +--
 notes-utils.c                                 |   9 ++-
 notes-utils.h                                 |   3 +-
 notes.c                                       |  63 ++++++++--------
 notes.h                                       |  29 ++++---
 read-cache.c                                  |   6 +-
 sha1_file.c                                   | 100 +++++++++++++------------
 t/helper/test-dump-untracked-cache.c          |   4 +-
 38 files changed, 300 insertions(+), 279 deletions(-)


base-commit: 5be1f00a9a701532232f57958efab4be8c959a29
-- 
2.14.3

