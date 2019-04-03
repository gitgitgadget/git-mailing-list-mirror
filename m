Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CC61202BB
	for <e@80x24.org>; Wed,  3 Apr 2019 11:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfDCLfK (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 07:35:10 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38913 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfDCLfJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 07:35:09 -0400
Received: by mail-pf1-f196.google.com with SMTP id i17so8022224pfo.6
        for <git@vger.kernel.org>; Wed, 03 Apr 2019 04:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ILeinmlRplDb1zMTMul+n+ZMDhLf7RXQRAF4ZPAeq1k=;
        b=nbynhjzf40roebPNP/9imJ3t0TppVA7Jeb0NvKG6PctoAw8cd7ByPh35bmrpBx0Lu3
         zB6QkeFANNDM/zGJne/SnirY1rAjvY732PjYMwAeoi164hB/pbVh5c+qfQcOdYkqjzmI
         YzT5nzbpqB0d5h7tJzBI0kAqBFIDzx9RHqBkIXYlb9HVDCtoayWvj5wN+HSOxRSbfi2g
         RQgtqrpc2h496i1BLgxXYjTCI3o6AvT530Jn7ojORVarUBVmVLEnZtZgcE3qwBWfSqDl
         0oFoOqnhyIs8Q7VFDnq7MKB/sHgMNsOcbccvjbRLCr6OqgXeKpjJGJwtuACRBE1+3yx0
         3Jyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ILeinmlRplDb1zMTMul+n+ZMDhLf7RXQRAF4ZPAeq1k=;
        b=p/Eysmzbm9yh6GKzzoflPah6FSalLSj6vwLmwossy/R73/vLD8pp1rwOWO5ISqf/3N
         X4UKzzTeHo3dCCuFnxTCOyK+fBlf1RvvPlq70pw/oHzLj/GfDlCiXXKf9C+SYZHtJCK+
         uLOZgCgYpfRT2D+IF2JbRB8Wpm7LzB9aufS2pKe4zFMpLW20qYWYR2lryHXWdmcZyxA9
         gX4IsovX0qYzkqPVCqyBehdJ2G8r6Y163KWu8NKth2dZMlnkb2Rp1e1tyuIAGSUqfgi2
         zzhYqtd5QH13eOplVZPJNRTVrNUzWWH/oSHW/2RZPlmvVmd4PFv2WWnMfaZDF4USrQRX
         snIQ==
X-Gm-Message-State: APjAAAUlJeLunhnurBDQyxWgw5fve0wRukHYAKD3a5f4jSYAHQVdFsoL
        UzU3gi+XUkXd58tGazU8daR9MuNY
X-Google-Smtp-Source: APXvYqwlWlk8TO7/X5ak/pNhFDsNNIajspUgUsWfYRrZ9+jfjV+hiezwxBEnefY70lgjfF2VpOaH8Q==
X-Received: by 2002:a63:6142:: with SMTP id v63mr72288282pgb.342.1554291309136;
        Wed, 03 Apr 2019 04:35:09 -0700 (PDT)
Received: from ash ([27.75.136.26])
        by smtp.gmail.com with ESMTPSA id c18sm48670200pfc.0.2019.04.03.04.35.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 04:35:08 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 03 Apr 2019 18:35:03 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 00/32] nd/sha1-name-c-wo-the-repository updates
Date:   Wed,  3 Apr 2019 18:34:25 +0700
Message-Id: <20190403113457.20399-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190330111927.18645-1-pclouds@gmail.com>
References: <20190330111927.18645-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2 fixes commit.cocci, found by Szeder. While at there I see there are
two other changes suggested by cocci that haven't made it to 'pu' so I
added them in the new 01/32.

Nguyễn Thái Ngọc Duy (32):
  rebase: 'make coccicheck' cleanup
  packfile.c: add repo_approximate_object_count()
  refs.c: add refs_ref_exists()
  refs.c: add refs_shorten_unambiguous_ref()
  refs.c: remove the_repo from substitute_branch_name()
  refs.c: remove the_repo from expand_ref()
  refs.c: add repo_dwim_ref()
  refs.c: add repo_dwim_log()
  refs.c: remove the_repo from read_ref_at()
  commit.c: add repo_get_commit_tree()
  sha1-name.c: remove the_repo from sort_ambiguous()
  sha1-name.c: remove the_repo from find_abbrev_len_packed()
  sha1-name.c: add repo_find_unique_abbrev_r()
  sha1-name.c: store and use repo in struct disambiguate_state
  sha1-name.c: add repo_for_each_abbrev()
  sha1-name.c: remove the_repo from get_short_oid()
  sha1-name.c: remove the_repo from interpret_nth_prior_checkout()
  sha1-name.c: remove the_repo from interpret_branch_mark()
  sha1-name.c: add repo_interpret_branch_name()
  sha1-name.c: remove the_repo from get_oid_oneline()
  sha1-name.c: remove the_repo from get_describe_name()
  sha1-name.c: remove the_repo from get_oid_basic()
  sha1-name.c: remove the_repo from get_oid_1()
  sha1-name.c: remove the_repo from handle_one_ref()
  sha1-name.c: remove the_repo from diagnose_invalid_index_path()
  sha1-name.c: remove the_repo from resolve_relative_path()
  sha1-name.c: remove the_repo from get_oid_with_context_1()
  sha1-name.c: add repo_get_oid()
  submodule-config.c: use repo_get_oid for reading .gitmodules
  sha1-name.c: remove the_repo from maybe_die_on_misspelt_object_name
  sha1-name.c: remove the_repo from other get_oid_*
  sha1-name.c: remove the_repo from get_oid_mb()

 builtin/rebase.c                   |   5 +-
 builtin/show-branch.c              |   6 +-
 cache.h                            |  50 ++--
 commit.c                           |   5 +-
 commit.h                           |   3 +-
 contrib/coccinelle/commit.cocci    |   4 +-
 dir.c                              |   8 +
 dir.h                              |   4 +-
 packfile.c                         |  14 +-
 packfile.h                         |   3 +-
 refs.c                             |  71 ++++--
 refs.h                             |   9 +-
 setup.c                            |   7 +-
 sha1-name.c                        | 388 ++++++++++++++++++-----------
 submodule-config.c                 |  20 +-
 t/t7814-grep-recurse-submodules.sh |   6 +-
 upload-pack.c                      |   2 +-
 17 files changed, 375 insertions(+), 230 deletions(-)

Range-diff dựa trên v1:
 -:  ---------- >  1:  b992f6c799 rebase: 'make coccicheck' cleanup
 1:  0988bf416e =  2:  e76c73a75a packfile.c: add repo_approximate_object_count()
 2:  d55d5a044d =  3:  962a168516 refs.c: add refs_ref_exists()
 3:  a01ebfaa28 =  4:  d06bea7909 refs.c: add refs_shorten_unambiguous_ref()
 4:  6bf6bdb358 =  5:  fb880154e6 refs.c: remove the_repo from substitute_branch_name()
 5:  7db71d20f0 =  6:  6fd7960522 refs.c: remove the_repo from expand_ref()
 6:  c0bbe2ea45 =  7:  f5ad3133bc refs.c: add repo_dwim_ref()
 7:  c7b5e8d9fe =  8:  7552a4085a refs.c: add repo_dwim_log()
 8:  91229dad66 =  9:  962fff4c9c refs.c: remove the_repo from read_ref_at()
 9:  ae7d2bfcee ! 10:  68876a150f commit.c: add repo_get_commit_tree()
    @@ -38,3 +38,22 @@
      struct object_id *get_commit_tree_oid(const struct commit *);
      
      /*
    +
    + diff --git a/contrib/coccinelle/commit.cocci b/contrib/coccinelle/commit.cocci
    + --- a/contrib/coccinelle/commit.cocci
    + +++ b/contrib/coccinelle/commit.cocci
    +@@
    + 
    + // These excluded functions must access c->maybe_tree direcly.
    + @@
    +-identifier f !~ "^(get_commit_tree|get_commit_tree_in_graph_one|load_tree_for_commit)$";
    ++identifier f !~ "^(repo_get_commit_tree|get_commit_tree_in_graph_one|load_tree_for_commit)$";
    + expression c;
    + @@
    +   f(...) {<...
    + - c->maybe_tree
    +-+ get_commit_tree(c)
    +++ repo_get_commit_tree(the_repository, c)
    +   ...>}
    + 
    + @@
10:  b6bd4c86e3 = 11:  9817d150b2 sha1-name.c: remove the_repo from sort_ambiguous()
11:  8aaaf14786 = 12:  7ce23aaeb5 sha1-name.c: remove the_repo from find_abbrev_len_packed()
12:  76305c1faa = 13:  2d99af106f sha1-name.c: add repo_find_unique_abbrev_r()
13:  f07d196f41 = 14:  f63626e937 sha1-name.c: store and use repo in struct disambiguate_state
14:  0e6ef61f31 = 15:  ce9f7ebab8 sha1-name.c: add repo_for_each_abbrev()
15:  0e74d78d74 = 16:  8cb8278d6e sha1-name.c: remove the_repo from get_short_oid()
16:  a5d0f20892 = 17:  9210dd01b8 sha1-name.c: remove the_repo from interpret_nth_prior_checkout()
17:  15dd2005b4 = 18:  a161ed33d2 sha1-name.c: remove the_repo from interpret_branch_mark()
18:  23627fd251 = 19:  6bf4df0131 sha1-name.c: add repo_interpret_branch_name()
19:  167ac516e8 = 20:  94f707cb7f sha1-name.c: remove the_repo from get_oid_oneline()
20:  57bfc2f7f6 = 21:  2a1dd6368c sha1-name.c: remove the_repo from get_describe_name()
21:  1134a0c34e = 22:  f958b565db sha1-name.c: remove the_repo from get_oid_basic()
22:  c04c381031 = 23:  ec821007b2 sha1-name.c: remove the_repo from get_oid_1()
23:  c9a33014f6 = 24:  317a365f30 sha1-name.c: remove the_repo from handle_one_ref()
24:  2f8bd84d50 = 25:  3a46ea22b2 sha1-name.c: remove the_repo from diagnose_invalid_index_path()
25:  c2924466da = 26:  59a8cb9749 sha1-name.c: remove the_repo from resolve_relative_path()
26:  3b9545a48c = 27:  d1f4df1915 sha1-name.c: remove the_repo from get_oid_with_context_1()
27:  333dc19eae = 28:  3034e9cf1e sha1-name.c: add repo_get_oid()
28:  a6b08a7a2d = 29:  9c72941ec9 submodule-config.c: use repo_get_oid for reading .gitmodules
29:  42a0ce718e = 30:  40acfb6b82 sha1-name.c: remove the_repo from maybe_die_on_misspelt_object_name
30:  39aab4331a = 31:  3b8be75e77 sha1-name.c: remove the_repo from other get_oid_*
31:  1d1c4a0d5f = 32:  59cadc5deb sha1-name.c: remove the_repo from get_oid_mb()
-- 
2.21.0.479.g47ac719cd3

