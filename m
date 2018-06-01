Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA7CB1F42D
	for <e@80x24.org>; Fri,  1 Jun 2018 21:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750830AbeFAVKb (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 17:10:31 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:32918 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750732AbeFAVK3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 17:10:29 -0400
Received: by mail-wr0-f193.google.com with SMTP id k16-v6so10267040wro.0
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 14:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rcxgWScLWvmMZiylvVg5yaVwuOiJrnukNtychzSCGXU=;
        b=IsbrKq2HvWYdix6knL5qX4u3S2pEvcS4TC/bed1ibu5ve0Au6b1pF5L8aPkjO2KRRk
         cw7oK/nxY6tQ0Gc2dFDSwUMoes0yF9JmdEvySDfiZjuci34GZPHgAI1I70t7NVRpTVAw
         SRY3Ldp5Exb3jYxEO3Hkfj9zRRE6RuPLqIsTLPlV5Nix4ljD3JEXUl2vDvhIZdx5kBLw
         mZ5bBSJHBMrya93YVOwBu6FiGoH7MnFGWHd4nBpxZEGhzxe5YKlZ2cdtcBjeGM5/6/h8
         H2lSWKRG1sff0NCCL8mUXZva0zhJHsNdA2Abd9SqG+FJ7dSGztrNU8CKnS7wUgSb/yhD
         lGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rcxgWScLWvmMZiylvVg5yaVwuOiJrnukNtychzSCGXU=;
        b=JVAeD5z7VzKGsizec9grRyIDU8qu/FrKU5wfokFXI5UJRECZ96C4EtU2ePTE9a6FEa
         sA9KdxMhs7ruYpjAkP+9FIZM6vxDPaGDiDrT450NG8TgdObohCxn72El8LunOUWfTNmB
         0WUdqy2p/1Z6IsehnspvphDLFLzKaa+qlIzgO7i6cBw5qkoEyjY3cRovvknTNoab2TON
         iunLE+M3ceT60bqrK/uvzAf8QgkmcExKcfelqbXK6ttPf8llGfJARjCdsykxB9pbwjlW
         lTTZsjRzKVm8T5b7j1eV+Mg/3fMNljz+YPg6eOX76ZQiWvkXEyVRLEmE1vZwkFNocBVn
         TK6A==
X-Gm-Message-State: ALKqPwcbiGrEgAZY3OcWVlUQn9iNAjhc8SNRQMA93JUDmC+KR+VBVoS+
        7l14phYRmtM2doMVfqq5x5aE4J/5
X-Google-Smtp-Source: ADUXVKJwLRqUQfEE39BIFB2MFEu3CbD1byLsgAT0ppo3R3+lzYmrnwf99e8mV/LAApbJB8SaKNsLiA==
X-Received: by 2002:a5d:45cb:: with SMTP id b11-v6mr3363672wrs.106.1527887427831;
        Fri, 01 Jun 2018 14:10:27 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k126-v6sm3516235wmd.45.2018.06.01.14.10.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Jun 2018 14:10:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 0/8] ambiguous checkout UI & checkout.defaultRemote
Date:   Fri,  1 Jun 2018 21:10:07 +0000
Message-Id: <20180601211015.11919-1-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180531195252.29173-1-avarab@gmail.com>
References: <20180531195252.29173-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This v5 should address all the comments to v4. Thanks all! It's one
patch less because the struct isn't being moved around anymore.

tbdiff:
    
    1: 16d656ee3b ! 1: ab4529d9f5 checkout tests: index should be clean after dwim checkout
        @@ -29,6 +29,10 @@
             "checkout", that's being done with "-uno" because there's going to be
             some untracked files related to the test itself which we don't care
             about.
        +    
        +    In all these tests (DWIM or otherwise) we start with a clean index, so
        +    these tests are asserting that that's still the case after the
        +    "checkout", failed or otherwise.
             
             Then if we ever run into this sort of regression, either in the
             existing code or with a new feature, we'll know.
        @@ -65,12 +69,8 @@
          	test_must_fail git checkout foo &&
         +	status_uno_is_clean &&
          	test_must_fail git rev-parse --verify refs/heads/foo &&
        --	test_branch master
        -+	test_branch master &&
        -+	status_uno_is_clean
        - '
        - 
        - test_expect_success 'checkout of branch from a single remote succeeds #1' '
        + 	test_branch master
        + '
         @@
          	test_might_fail git branch -D bar &&
          
    2: 159cc0634b = 2: c8bbece403 checkout.h: wrap the arguments to unique_tracking_name()
    3: 3df4594e2d < -:  ------- checkout.[ch]: move struct declaration into *.h
    4: 35c6481208 < -:  ------- checkout.[ch]: introduce an *_INIT macro
    -:  ------- > 3: 4fc5ab27fa checkout.[ch]: introduce an *_INIT macro
    5: 69a834f010 ! 4: fbce6df584 checkout.[ch]: change "unique" member to "num_matches"
        @@ -11,6 +11,19 @@
         diff --git a/checkout.c b/checkout.c
         --- a/checkout.c
         +++ b/checkout.c
        +@@
        + 	/* const */ char *src_ref;
        + 	char *dst_ref;
        + 	struct object_id *dst_oid;
        +-	int unique;
        ++	int num_matches;
        + };
        + 
        +-#define TRACKING_NAME_DATA_INIT { NULL, NULL, NULL, 1 }
        ++#define TRACKING_NAME_DATA_INIT { NULL, NULL, NULL, 0 }
        + 
        + static int check_tracking_name(struct remote *remote, void *cb_data)
        + {
         @@
          		free(query.dst);
          		return 0;
        @@ -31,20 +44,3 @@
          		return cb_data.dst_ref;
          	free(cb_data.dst_ref);
          	return NULL;
        -
        -diff --git a/checkout.h b/checkout.h
        ---- a/checkout.h
        -+++ b/checkout.h
        -@@
        - 	/* const */ char *src_ref;
        - 	char *dst_ref;
        - 	struct object_id *dst_oid;
        --	int unique;
        -+	int num_matches;
        - };
        - 
        --#define TRACKING_NAME_DATA_INIT { NULL, NULL, NULL, 1 }
        -+#define TRACKING_NAME_DATA_INIT { NULL, NULL, NULL, 0 }
        - 
        - /*
        -  * Check if the branch name uniquely matches a branch name on a remote
    6: 13547824dc ! 5: 6e016d43d7 checkout: pass the "num_matches" up to callers
        @@ -11,16 +11,6 @@
         diff --git a/builtin/checkout.c b/builtin/checkout.c
         --- a/builtin/checkout.c
         +++ b/builtin/checkout.c
        -@@
        - }
        - 
        - static int checkout_paths(const struct checkout_opts *opts,
        --			  const char *revision)
        -+			  const char *revision,
        -+			  int *dwim_remotes_matched)
        - {
        - 	int pos;
        - 	struct checkout state = CHECKOUT_INIT;
         @@
          				int dwim_new_local_branch_ok,
          				struct branch_info *new_branch_info,
        @@ -59,16 +49,6 @@
          		argv += n;
          		argc -= n;
          	}
        -@@
        - 
        - 	UNLEAK(opts);
        - 	if (opts.patch_mode || opts.pathspec.nr)
        --		return checkout_paths(&opts, new_branch_info.name);
        -+		return checkout_paths(&opts, new_branch_info.name,
        -+				      &dwim_remotes_matched);
        - 	else
        - 		return checkout_branch(&opts, &new_branch_info);
        - }
         
         diff --git a/builtin/worktree.c b/builtin/worktree.c
         --- a/builtin/worktree.c
    7: 6895b5c903 ! 6: 07b11b133d builtin/checkout.c: use "ret" variable for return
        @@ -16,12 +16,10 @@
          
          	UNLEAK(opts);
         -	if (opts.patch_mode || opts.pathspec.nr)
        --		return checkout_paths(&opts, new_branch_info.name,
        --				      &dwim_remotes_matched);
        +-		return checkout_paths(&opts, new_branch_info.name);
         -	else
         +	if (opts.patch_mode || opts.pathspec.nr) {
        -+		int ret = checkout_paths(&opts, new_branch_info.name,
        -+					 &dwim_remotes_matched);
        ++		int ret = checkout_paths(&opts, new_branch_info.name);
         +		return ret;
         +	} else {
          		return checkout_branch(&opts, &new_branch_info);
    8: 5cfc0896e5 ! 7: 97e84f6e1c checkout: add advice for ambiguous "checkout <branch>"
        @@ -8,9 +8,9 @@
                 exactly one remote (call it <remote>) with a matching name, treat
                 as equivalent to [...] <remote>/<branch.
             
        -    This is a really useful feature, the problem is that when you another
        -    remote (e.g. a fork) git won't find a unique branch name anymore, and
        -    will instead print this nondescript message:
        +    This is a really useful feature. The problem is that when you and
        +    another remote (e.g. a fork) git won't find a unique branch name
        +    anymore, and will instead print this nondescript message:
             
                 $ git checkout master
                 error: pathspec 'master' did not match any file(s) known to git
        @@ -23,8 +23,10 @@
                 hint: We found 26 remotes with a reference that matched. So we fell back
                 hint: on trying to resolve the argument as a path, but failed there too!
                 hint:
        -        hint: Perhaps you meant fully qualify the branch name? E.g. origin/<name>
        -        hint: instead of <name>?
        +        hint: If you meant to check out a remote tracking branch on e.g. 'origin'
        +        hint: you can do so by fully-qualifying the name with the --track option:
        +        hint:
        +        hint:     git checkout --track origin/<name>
             
             Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
         
        @@ -90,17 +92,19 @@
          static const char * const checkout_usage[] = {
          	N_("git checkout [<options>] <branch>"),
         @@
        + 	UNLEAK(opts);
          	if (opts.patch_mode || opts.pathspec.nr) {
        - 		int ret = checkout_paths(&opts, new_branch_info.name,
        - 					 &dwim_remotes_matched);
        + 		int ret = checkout_paths(&opts, new_branch_info.name);
         +		if (ret && dwim_remotes_matched > 1 &&
         +		    advice_checkout_ambiguous_remote_branch_name)
         +			advise(_("The argument '%s' matched more than one remote tracking branch.\n"
         +				 "We found %d remotes with a reference that matched. So we fell back\n"
         +				 "on trying to resolve the argument as a path, but failed there too!\n"
         +				 "\n"
        -+				 "Perhaps you meant fully qualify the branch name? E.g. origin/<name>\n"
        -+				 "instead of <name>?"),
        ++				 "If you meant to check out a remote tracking branch on e.g. 'origin'\n"
        ++				 "you can do so by fully-qualifying the name with the --track option:\n"
        ++				 "\n"
        ++				 "    git checkout --track origin/<name>"),
         +			       argv[0],
         +			       dwim_remotes_matched);
          		return ret;
        @@ -111,7 +115,7 @@
         --- a/t/t2024-checkout-dwim.sh
         +++ b/t/t2024-checkout-dwim.sh
         @@
        - 	status_uno_is_clean
        + 	test_branch master
          '
          
         +test_expect_success 'checkout of branch from multiple remotes fails with advice' '
    9: fad1df1edd ! 8: a5cc070ebf checkout & worktree: introduce checkout.defaultRemote
        @@ -57,12 +57,14 @@
                 hint: We found 26 remotes with a reference that matched. So we fell back
                 hint: on trying to resolve the argument as a path, but failed there too!
                 hint:
        -        hint: Perhaps you meant fully qualify the branch name? E.g. origin/<name>
        -        hint: instead of <name>?
        +        hint: If you meant to check out a remote tracking branch on e.g. 'origin'
        +        hint: you can do so by fully-qualifying the name with the --track option:
                 hint:
        -        hint: If you'd like to always have checkouts of 'master' prefer one remote,
        -        hint: e.g. the 'origin' remote, consider setting checkout.defaultRemote=origin
        -        hint: in your config. See the 'git-config' manual page for details.
        +        hint:     git checkout --track origin/<name>
        +        hint:
        +        hint: If you'd like to always have checkouts of an ambiguous <name> prefer
        +        hint: one remote, e.g. the 'origin' remote, consider setting
        +        hint: checkout.defaultRemote=origin in your config.
             
             I considered splitting this into checkout.defaultRemote and
             worktree.defaultRemote, but it's probably less confusing to break our
        @@ -128,7 +130,7 @@
         +one for the purposes of disambiguation, even if the `<branch>` isn't
         +unique across all remotes. Set it to
         +e.g. `checkout.defaultRemote=origin` to always checkout remote
        -+branches from there if `<branch> is ambiguous but exists on the
        ++branches from there if `<branch>` is ambiguous but exists on the
         +'origin' remote. See also `checkout.defaultRemote` in
         +linkgit:git-config[1].
         ++
        @@ -148,7 +150,7 @@
         +one for the purposes of disambiguation, even if the `<branch>` isn't
         +unique across all remotes. Set it to
         +e.g. `checkout.defaultRemote=origin` to always checkout remote
        -+branches from there if `<branch> is ambiguous but exists on the
        ++branches from there if `<branch>` is ambiguous but exists on the
         +'origin' remote. See also `checkout.defaultRemote` in
         +linkgit:git-config[1].
         ++
        @@ -173,22 +175,18 @@
          	 *   (c) Otherwise, if "--" is present, treat it like case (1).
          	 *
         @@
        - 				 "on trying to resolve the argument as a path, but failed there too!\n"
        + 				 "If you meant to check out a remote tracking branch on e.g. 'origin'\n"
        + 				 "you can do so by fully-qualifying the name with the --track option:\n"
          				 "\n"
        - 				 "Perhaps you meant fully qualify the branch name? E.g. origin/<name>\n"
        --				 "instead of <name>?"),
        -+				 "instead of <name>?\n"
        +-				 "    git checkout --track origin/<name>"),
        ++				 "    git checkout --track origin/<name>\n"
         +				 "\n"
        -+				 "If you'd like to always have checkouts of '%s' prefer one remote,\n"
        -+				 "e.g. the 'origin' remote, consider setting checkout.defaultRemote=origin\n"
        -+				 "in your config. See the 'git-config' manual page for details."),
        ++				 "If you'd like to always have checkouts of an ambiguous <name> prefer\n"
        ++				 "one remote, e.g. the 'origin' remote, consider setting\n"
        ++				 "checkout.defaultRemote=origin in your config."),
          			       argv[0],
        --			       dwim_remotes_matched);
        -+			       dwim_remotes_matched,
        -+			       argv[0]);
        + 			       dwim_remotes_matched);
          		return ret;
        - 	} else {
        - 		return checkout_branch(&opts, &new_branch_info);
         
         diff --git a/checkout.c b/checkout.c
         --- a/checkout.c
        @@ -198,6 +196,19 @@
          #include "refspec.h"
          #include "checkout.h"
         +#include "config.h"
        + 
        + struct tracking_name_data {
        + 	/* const */ char *src_ref;
        + 	char *dst_ref;
        + 	struct object_id *dst_oid;
        + 	int num_matches;
        ++	const char *default_remote;
        ++	char *default_dst_ref;
        ++	struct object_id *default_dst_oid;
        + };
        + 
        +-#define TRACKING_NAME_DATA_INIT { NULL, NULL, NULL, 0 }
        ++#define TRACKING_NAME_DATA_INIT { NULL, NULL, NULL, 0, NULL, NULL, NULL }
          
          static int check_tracking_name(struct remote *remote, void *cb_data)
          {
        @@ -243,31 +254,21 @@
          	return NULL;
          }
         
        -diff --git a/checkout.h b/checkout.h
        ---- a/checkout.h
        -+++ b/checkout.h
        -@@
        - 	char *dst_ref;
        - 	struct object_id *dst_oid;
        - 	int num_matches;
        -+	const char *default_remote;
        -+	char *default_dst_ref;
        -+	struct object_id *default_dst_oid;
        - };
        - 
        --#define TRACKING_NAME_DATA_INIT { NULL, NULL, NULL, 0 }
        -+#define TRACKING_NAME_DATA_INIT { NULL, NULL, NULL, 0, NULL, NULL, NULL }
        - 
        - /*
        -  * Check if the branch name uniquely matches a branch name on a remote
        -
         diff --git a/t/t2024-checkout-dwim.sh b/t/t2024-checkout-dwim.sh
         --- a/t/t2024-checkout-dwim.sh
         +++ b/t/t2024-checkout-dwim.sh
         @@
        - 	test_i18ngrep ! "^hint: " stderr
        - '
        - 
        + 		checkout foo 2>stderr &&
        + 	test_branch master &&
        + 	status_uno_is_clean &&
        +-	test_i18ngrep ! "^hint: " stderr
        ++	test_i18ngrep ! "^hint: " stderr &&
        ++	# Make sure the likes of checkout -p don not print this hint
        ++	git checkout -p foo 2>stderr &&
        ++	test_i18ngrep ! "^hint: " stderr &&
        ++	status_uno_is_clean
        ++'
        ++
         +test_expect_success 'checkout of branch from multiple remotes succeeds with checkout.defaultRemote #1' '
         +	git checkout -B master &&
         +	status_uno_is_clean &&
        @@ -278,11 +279,9 @@
         +	test_branch foo &&
         +	test_cmp_rev remotes/repo_a/foo HEAD &&
         +	test_branch_upstream foo repo_a foo
        -+'
        -+
        + '
        + 
          test_expect_success 'checkout of branch from a single remote succeeds #1' '
        - 	git checkout -B master &&
        - 	test_might_fail git branch -D bar &&
         
         diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
         --- a/t/t2025-worktree-add.sh

Ævar Arnfjörð Bjarmason (8):
  checkout tests: index should be clean after dwim checkout
  checkout.h: wrap the arguments to unique_tracking_name()
  checkout.[ch]: introduce an *_INIT macro
  checkout.[ch]: change "unique" member to "num_matches"
  checkout: pass the "num_matches" up to callers
  builtin/checkout.c: use "ret" variable for return
  checkout: add advice for ambiguous "checkout <branch>"
  checkout & worktree: introduce checkout.defaultRemote

 Documentation/config.txt       | 26 +++++++++++++++
 Documentation/git-checkout.txt |  9 ++++++
 Documentation/git-worktree.txt |  9 ++++++
 advice.c                       |  2 ++
 advice.h                       |  1 +
 builtin/checkout.c             | 41 ++++++++++++++++++-----
 builtin/worktree.c             |  4 +--
 checkout.c                     | 37 ++++++++++++++++++---
 checkout.h                     |  4 ++-
 t/t2024-checkout-dwim.sh       | 59 ++++++++++++++++++++++++++++++++++
 t/t2025-worktree-add.sh        | 21 ++++++++++++
 11 files changed, 197 insertions(+), 16 deletions(-)

-- 
2.17.0.290.gded63e768a

