Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 877801F45F
	for <e@80x24.org>; Thu,  9 May 2019 14:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfEIOWd (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 10:22:33 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33932 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbfEIOWd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 10:22:33 -0400
Received: by mail-ed1-f68.google.com with SMTP id p27so2227303eda.1
        for <git@vger.kernel.org>; Thu, 09 May 2019 07:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=J+rqtHCT7DVukxEEv1PvsAqXqzyZ7lM2u0Fry3NU7hw=;
        b=NfLe1bE9yXnnuBl4Co+2QdKrUrNjxO4kMCNTnPsJ3EyhPUT0KNwWMkuGkgGmQq5o1P
         On7mZYujz/89cNxCnGdNWvClapZ7rewlQOrlgOuFQCVBLYw86pJiJNVckVi0+R/pjBw9
         5ynnXzJ/mYvNtJ76Ww1O3eePP7WI4vzjauK67MSc6EodR6j79IM3uEAmHPFSRAC4LSgq
         wpWBLMVeShRLHMltjWAsTfyaUshL2livALR1tcGAYcSrxnOUB/MZgjrHG7nujpo1RV+j
         Udr0riTCW4N25eETGj1KrZ4Unw0Xm5Zl03imGuyAdyYxgcghmEk1E4tq5A1QnKkalZz5
         acsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=J+rqtHCT7DVukxEEv1PvsAqXqzyZ7lM2u0Fry3NU7hw=;
        b=m4IMnNVX0V/Ow2uPhDAlSwhxG6KqsgJBoC0RoN2RDL/e7S0iNzy9XTB3CpZWOXDcuc
         EouGuYqLHVc2SBtxga0pZhHrEA9jjIk9Uut+mwmZqPfuHpgxOQ1TbzSaBXbqbPwHjLBv
         e0YRe4Bmr5udGh53SllBIo+lPR0vg5kFbQGJpxwNHoL/OmR7urSU2ava1iDgM4UzYi0A
         w4Cq8EIwpSRE14zuvFXJrdle3nWwIjFAYx5vsiy0LagCAsigYz2qO35yMZKfUgJ5VYZH
         d2221B2jIkWQgOosMa04ZaEZfY/OaztF5DWAulifLt7Eh1FSIA3w2v48wXXU01LHL99H
         A0Bg==
X-Gm-Message-State: APjAAAXGFx7zacP446TVRO6Xka125LUYH+oyVYE8aydszDjU4GEK5/0z
        M5/b7ft/z7vF1seT3RlWzTmy2HQq
X-Google-Smtp-Source: APXvYqwpGaF+bhQ9PJVFjN7mLrZICKSV1aqMBNMGXd6I9bW0sXT3yIzynL8Qp0fQk+JFdINda04AXw==
X-Received: by 2002:a17:906:1e0f:: with SMTP id g15mr3502262ejj.241.1557411750985;
        Thu, 09 May 2019 07:22:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i33sm631812ede.47.2019.05.09.07.22.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 07:22:30 -0700 (PDT)
Date:   Thu, 09 May 2019 07:22:30 -0700 (PDT)
X-Google-Original-Date: Thu, 09 May 2019 14:22:18 GMT
Message-Id: <pull.112.v4.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.112.v3.git.gitgitgadget@gmail.com>
References: <pull.112.v3.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 00/11] Commit-graph write refactor (was: Create commit-graph file format v2)
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, avarab@gmail.com, peff@peff.net,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series replaces ds/commit-graph-file-v2, and I'm using the same
gitgitgadget PR to continue the version numbers and hopefully make that
clear. This is a slight modification on patches 1-11 from the incremental
file format RFC [0].

The commit-graph feature is growing, thanks to all of the contributions by
several community members. This also means that the write_commit_graph()
method is a bit unwieldy now. This series refactors that method to use a
write_commit_graph_context struct that is passed between several smaller
methods. The final result should be a write_commit_graph() method that has a
clear set of steps. Future changes should then be easier to understand.

 * Patches 1-4: these are small changes which either fix issues or just
   provide clean-up. These are mostly borrowed from
   ds/commit-graph-format-v2. 
   
   
 * Patches 5-11: these provide a non-functional refactor of
   write_commit_graph() into several methods using a "struct
   write_commit_graph_context" to share across the methods.
   
   

Updates to commits previously in this thread:

 * "commit-graph: remove Future Work section" no longer says that 'verify'
   takes as long as 'write'. [1]
   
   
 * "commit-graph: return with errors during write" now has a test to check
   we don't die(). [2]
   
   

Ævar: Looking at the old thread, I only saw two comments that still apply to
this series [1] [2]. Please point me to any comments I have missed.

Thanks, -Stolee

[0] https://public-inbox.org/git/pull.184.git.gitgitgadget@gmail.com/

[1] https://public-inbox.org/git/87o94mql0a.fsf@evledraar.gmail.com/

[2] https://public-inbox.org/git/87pnp2qlkv.fsf@evledraar.gmail.com/

Derrick Stolee (11):
  commit-graph: fix the_repository reference
  commit-graph: return with errors during write
  commit-graph: collapse parameters into flags
  commit-graph: remove Future Work section
  commit-graph: create write_commit_graph_context
  commit-graph: extract fill_oids_from_packs()
  commit-graph: extract fill_oids_from_commit_hex()
  commit-graph: extract fill_oids_from_all_packs()
  commit-graph: extract count_distinct_commits()
  commit-graph: extract copy_oids_to_commits()
  commit-graph: extract write_commit_graph_file()

 Documentation/technical/commit-graph.txt |  17 -
 builtin/commit-graph.c                   |  21 +-
 builtin/commit.c                         |   5 +-
 builtin/gc.c                             |   7 +-
 commit-graph.c                           | 607 +++++++++++++----------
 commit-graph.h                           |  14 +-
 commit.c                                 |   2 +-
 t/t5318-commit-graph.sh                  |   8 +
 8 files changed, 371 insertions(+), 310 deletions(-)


base-commit: 93b4405ffe4ad9308740e7c1c71383bfc369baaa
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-112%2Fderrickstolee%2Fgraph%2Fv2-head-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-112/derrickstolee/graph/v2-head-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/112

Range-diff vs v3:

  -:  ---------- >  1:  0be7713a25 commit-graph: fix the_repository reference
  1:  91f300ec0a !  2:  a4082b827e commit-graph: return with errors during write
     @@ -253,3 +253,22 @@
       
       int verify_commit_graph(struct repository *r, struct commit_graph *g);
       
     +
     + diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
     + --- a/t/t5318-commit-graph.sh
     + +++ b/t/t5318-commit-graph.sh
     +@@
     + 	test_path_is_file info/commit-graph
     + '
     + 
     ++test_expect_success 'close with correct error on bad input' '
     ++	cd "$TRASH_DIRECTORY/full" &&
     ++	echo doesnotexist >in &&
     ++	{ git commit-graph write --stdin-packs <in 2>stderr; ret=$?; } &&
     ++	test "$ret" = 1 &&
     ++	test_i18ngrep "error adding pack" stderr
     ++'
     ++
     + test_expect_success 'create commits and repack' '
     + 	cd "$TRASH_DIRECTORY/full" &&
     + 	for i in $(test_seq 3)
  2:  924b22f990 =  3:  469d0c9a32 commit-graph: collapse parameters into flags
  3:  8446011a43 <  -:  ---------- commit-graph: create new version parameter
  4:  6a0e99f9f9 <  -:  ---------- commit-graph: add --version=<n> option
  5:  cca8267dfe <  -:  ---------- commit-graph: implement file format version 2
  6:  e72bca6c78 !  4:  130007d0e1 commit-graph: remove Future Work section
     @@ -12,9 +12,8 @@
      
          It is unlikely that we will ever send a commit-graph file
          as part of the protocol, since we would need to verify the
     -    data, and that is as expensive as writing a commit-graph from
     -    scratch. If we want to start trusting remote content, then
     -    that item can be investigated again.
     +    data, and that is expensive. If we want to start trusting
     +    remote content, then that item can be investigated again.
      
          While there is more work to be done on the feature, having
          a section of the docs devoted to a TODO list is wasteful and
  -:  ---------- >  5:  0ca4e18e98 commit-graph: create write_commit_graph_context
  -:  ---------- >  6:  30c1b618b1 commit-graph: extract fill_oids_from_packs()
  -:  ---------- >  7:  8cb2613dfa commit-graph: extract fill_oids_from_commit_hex()
  -:  ---------- >  8:  8f7129672a commit-graph: extract fill_oids_from_all_packs()
  -:  ---------- >  9:  a37548745b commit-graph: extract count_distinct_commits()
  -:  ---------- > 10:  57366ffdaa commit-graph: extract copy_oids_to_commits()
  -:  ---------- > 11:  fc81c8946d commit-graph: extract write_commit_graph_file()

-- 
gitgitgadget
