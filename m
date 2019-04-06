Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8349D20248
	for <e@80x24.org>; Sat,  6 Apr 2019 11:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfDFLfQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Apr 2019 07:35:16 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39682 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfDFLfP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Apr 2019 07:35:15 -0400
Received: by mail-pf1-f196.google.com with SMTP id i17so1631753pfo.6
        for <git@vger.kernel.org>; Sat, 06 Apr 2019 04:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GnTvWyfbbQ8MLWzIQJXXsm22gT1Vkci6ADNrJEPk6wE=;
        b=iwUEW/0lrZ9vbh5BZJS9VSyEO1EaCqt08k3EJ0BUx4pB0yzCAI80Cs+amjYA80Rwap
         sh/5IgCYy0Lg/K7A/MbEVjhUhmHlOTbAaTPqp/CWFgKNixYAOonl/QmCCNJQZJn7R9jx
         GpubuGUux2eQj91e5+Io0PP8u8ZBaiX7619jrZLCcJ9++U+TpXD+VB3cX2d/T3La8Pae
         lF67L+JAHYEMVQl/Z494i2v5qioH+SiI+qJhemnM9Bo3fI2nr9SZWBaV1+Jl95WTH5ly
         WUN5SzJAanqvVH9hUVhwGniTRTnDEWbJAarZr5T5nL2fnFtRGGtywgWscJyPQaNsrtXJ
         fS1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GnTvWyfbbQ8MLWzIQJXXsm22gT1Vkci6ADNrJEPk6wE=;
        b=cmIREgnNeKQDiGBmSGa/J0d3oszddepI9RPu6a0FKAvj/j0XeqB8Bvl7uHoG2F5QNv
         EBCKQiBtZbnckz47mqmcP8NSUsTNAL6g11TBBrNx4rGyqg/1jOngFwWxB5g9SeDnMiE1
         jTPIiqoAjCOPBWW8WwIMEsk1MqeJGTWVXuzGZWR4BlJRfxs2SuqJyhdD2UieCiF0D6Nx
         Q4dAio9PpgHXcQV//a/BYvU15vaUQ0U+xD4LlaN+uTvFpsDzvYN19aQMv0DyKli5552X
         fPzEX/h6fFUp/SWItKR+J9XmVaqWAxui/3VA7Rz4FcQHJB016jo90GcOaiQY2smF3yXd
         ALxw==
X-Gm-Message-State: APjAAAVvpy38yR0qiHcgzLh1JZK8DqsYvdxywWoR7nbKZusTdSiAj7o4
        fUNHxhy0VY8ze9K3EjS98vj9Wysn
X-Google-Smtp-Source: APXvYqye3kyBOP2SPeqpI4jA2UBeDKOfEF7sbM1yNfyjG3H0Nbi7UwUs1ed1iy32gwYi3JQuhAdSRA==
X-Received: by 2002:a63:cc0b:: with SMTP id x11mr13162pgf.35.1554550514816;
        Sat, 06 Apr 2019 04:35:14 -0700 (PDT)
Received: from ash ([116.102.217.71])
        by smtp.gmail.com with ESMTPSA id o5sm83214583pfa.135.2019.04.06.04.35.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 04:35:13 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 06 Apr 2019 18:35:09 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        szeder.dev@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3 00/33] nd/sha1-name-c-wo-the-repository updates
Date:   Sat,  6 Apr 2019 18:34:20 +0700
Message-Id: <20190406113453.5149-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190403113457.20399-1-pclouds@gmail.com>
References: <20190403113457.20399-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hopefully the final fix for commit.cocci in 11/33. Instead of adding
more commit details on 01/33 I replaced it with the two commits from
Szeder, he put more efforts into them anyway.

Range-diff dựa trên v2:
 1:  b992f6c799 !  1:  aa603ea09e rebase: 'make coccicheck' cleanup
    @@ -1,6 +1,14 @@
    -Author: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
    +Author: SZEDER Gábor <szeder.dev@gmail.com>
     
    -    rebase: 'make coccicheck' cleanup
    +    builtin rebase: use FREE_AND_NULL
    +
    +    Use the macro FREE_AND_NULL to release memory allocated for
    +    'head_name' and clear its pointer.
    +
    +    Patch generated with 'contrib/coccinelle/free.cocci' and Coccinelle
    +    v1.0.7 (previous Coccinelle versions don't notice this).
    +
    +    Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
     
      diff --git a/builtin/rebase.c b/builtin/rebase.c
      --- a/builtin/rebase.c
    @@ -15,12 +23,3 @@
      			branch_name = "HEAD";
      		}
      		if (get_oid("HEAD", &options.orig_head))
    -@@
    - 	 * we just fast-forwarded.
    - 	 */
    - 	strbuf_reset(&msg);
    --	if (!oidcmp(&merge_base, &options.orig_head)) {
    -+	if (oideq(&merge_base, &options.orig_head)) {
    - 		printf(_("Fast-forwarded %s to %s.\n"),
    - 			branch_name, options.onto_name);
    - 		strbuf_addf(&msg, "rebase finished: %s onto %s",
 -:  ---------- >  2:  b03cd28a4e builtin rebase: use oideq()
 2:  e76c73a75a =  3:  3a68454479 packfile.c: add repo_approximate_object_count()
 3:  962a168516 =  4:  9738ab8797 refs.c: add refs_ref_exists()
 4:  d06bea7909 =  5:  1a2cb46fe9 refs.c: add refs_shorten_unambiguous_ref()
 5:  fb880154e6 =  6:  ffdf9ad9bf refs.c: remove the_repo from substitute_branch_name()
 6:  6fd7960522 =  7:  697daf317f refs.c: remove the_repo from expand_ref()
 7:  f5ad3133bc =  8:  fac41b3b1c refs.c: add repo_dwim_ref()
 8:  7552a4085a =  9:  db528690fd refs.c: add repo_dwim_log()
 9:  962fff4c9c = 10:  9318416f94 refs.c: remove the_repo from read_ref_at()
10:  68876a150f ! 11:  848456f59c commit.c: add repo_get_commit_tree()
    @@ -2,6 +2,11 @@
     
         commit.c: add repo_get_commit_tree()
     
    +    Remove the implicit dependency on the_repository in this function.
    +    It will be used in sha1-name.c functions when they are updated to take
    +    any 'struct repository'. get_commit_tree() remains as a compat wrapper,
    +    to be slowly replaced later.
    +
      diff --git a/commit.c b/commit.c
      --- a/commit.c
      +++ b/commit.c
    @@ -29,6 +34,15 @@
      --- a/commit.h
      +++ b/commit.h
     @@
    + 
    + 	/*
    + 	 * If the commit is loaded from the commit-graph file, then this
    +-	 * member may be NULL. Only access it through get_commit_tree()
    ++	 * member may be NULL. Only access it through repo_get_commit_tree()
    + 	 * or get_commit_tree_oid().
    + 	 */
    + 	struct tree *maybe_tree;
    +@@
       */
      void free_commit_buffer(struct parsed_object_pool *pool, struct commit *);
      
    @@ -57,3 +71,10 @@
        ...>}
      
      @@
    + expression c;
    ++expression r;
    + expression s;
    + @@
    +-- get_commit_tree(c) = s
    ++- repo_get_commit_tree(r, c) = s
    + + c->maybe_tree = s
11:  9817d150b2 = 12:  a60c06b63a sha1-name.c: remove the_repo from sort_ambiguous()
12:  7ce23aaeb5 = 13:  3cbbe5de4a sha1-name.c: remove the_repo from find_abbrev_len_packed()
13:  2d99af106f = 14:  a79bf276bd sha1-name.c: add repo_find_unique_abbrev_r()
14:  f63626e937 = 15:  aa0fa191d9 sha1-name.c: store and use repo in struct disambiguate_state
15:  ce9f7ebab8 = 16:  ad00c19d30 sha1-name.c: add repo_for_each_abbrev()
16:  8cb8278d6e = 17:  d9ff762461 sha1-name.c: remove the_repo from get_short_oid()
17:  9210dd01b8 = 18:  46b8a05d8c sha1-name.c: remove the_repo from interpret_nth_prior_checkout()
18:  a161ed33d2 = 19:  52ec37f2d7 sha1-name.c: remove the_repo from interpret_branch_mark()
19:  6bf4df0131 = 20:  f50562b480 sha1-name.c: add repo_interpret_branch_name()
20:  94f707cb7f = 21:  66619e37cb sha1-name.c: remove the_repo from get_oid_oneline()
21:  2a1dd6368c = 22:  d960f47821 sha1-name.c: remove the_repo from get_describe_name()
22:  f958b565db = 23:  f38960304d sha1-name.c: remove the_repo from get_oid_basic()
23:  ec821007b2 = 24:  3b69cfcd8b sha1-name.c: remove the_repo from get_oid_1()
24:  317a365f30 = 25:  e889ae729a sha1-name.c: remove the_repo from handle_one_ref()
25:  3a46ea22b2 = 26:  386b6f4654 sha1-name.c: remove the_repo from diagnose_invalid_index_path()
26:  59a8cb9749 = 27:  d3ff3ee163 sha1-name.c: remove the_repo from resolve_relative_path()
27:  d1f4df1915 = 28:  226a30e6f6 sha1-name.c: remove the_repo from get_oid_with_context_1()
28:  3034e9cf1e = 29:  5d0aed2f70 sha1-name.c: add repo_get_oid()
29:  9c72941ec9 = 30:  72ab26a247 submodule-config.c: use repo_get_oid for reading .gitmodules
30:  40acfb6b82 = 31:  53dc11463d sha1-name.c: remove the_repo from maybe_die_on_misspelt_object_name
31:  3b8be75e77 = 32:  01b4deaa8a sha1-name.c: remove the_repo from other get_oid_*
32:  59cadc5deb = 33:  03a7283ef3 sha1-name.c: remove the_repo from get_oid_mb()

Nguyễn Thái Ngọc Duy (31):
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

SZEDER Gábor (2):
  builtin rebase: use FREE_AND_NULL
  builtin rebase: use oideq()

 builtin/rebase.c                   |   5 +-
 builtin/show-branch.c              |   6 +-
 cache.h                            |  50 ++--
 commit.c                           |   5 +-
 commit.h                           |   5 +-
 contrib/coccinelle/commit.cocci    |   7 +-
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
 17 files changed, 378 insertions(+), 232 deletions(-)
-- 
2.21.0.479.g47ac719cd3

