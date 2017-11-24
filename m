Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E11B620954
	for <e@80x24.org>; Fri, 24 Nov 2017 11:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753432AbdKXLIf (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Nov 2017 06:08:35 -0500
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:62813 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753456AbdKXLIS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Nov 2017 06:08:18 -0500
Received: from lindisfarne.localdomain ([92.22.34.132])
        by smtp.talktalk.net with SMTP
        id IBq0eNps6Ap17IBqDeb1CN; Fri, 24 Nov 2017 11:08:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1511521697;
        bh=nup1LvNr3b1Syj54EYxAY70+JfiwoQqFKhvFFR+zti0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=KzeQlhsIh3yczylT/9qjWprPsCdLi2dIo61YO+DQehQSZcVuSgcmjGuOi7jOPBVxg
         CuGLdH9NCicP6U1l2iwroNCJYNYxFDisqizEJhqF3EkiPYqcPnVA7/FXX6tZ9QbwzH
         A3NCGwnBNbV9eski4riCk9z8EwwktAeP3tJ20QCY=
X-Originating-IP: [92.22.34.132]
X-Spam: 0
X-OAuthority: v=2.2 cv=EsGilWUA c=1 sm=1 tr=0 a=2gYdyS03q/cwff7SV6P5Ng==:117
 a=2gYdyS03q/cwff7SV6P5Ng==:17 a=evINK-nbAAAA:8 a=A1X0JdhQAAAA:8
 a=YDFH51GLp7YKjXVtbWYA:9 a=yZHd8Vbq-DicxKpS:21 a=NMo6ZmpqHQ8wNkP-:21
 a=RfR_gqz1fSpA9VikTjo0:22 a=Df3jFdWbhGDLdZNm0fyq:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Stefan Beller <sbeller@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v4 9/9] t3512/t3513: remove KNOWN_FAILURE_CHERRY_PICK_SEES_EMPTY_COMMIT=1
Date:   Fri, 24 Nov 2017 11:07:58 +0000
Message-Id: <20171124110758.9406-10-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20171124110758.9406-1-phillip.wood@talktalk.net>
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
 <20171124110758.9406-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfKAWFKIH/leX0PMQWdLQGisd9XPdpAUUELh+0CForo8awQNZfj3RNw9AHOz98r+ZZr0ndoeWSEJM8ROFUOLK0H5F7hXuhAQXXME2kg/ZCrnMNK3OYNOh
 hGA/kWEHSnk8enLC8d6vbFw0tBTiiBZzro5qVEQZcFRX7HUcwzJkOp/5yvPVkSydh6za1g82hPMvscJL7n1fbqu/ull6EhhZjas9hIeTBMao7S2Bo74ZU/Bm
 JWc0WvwiavYPXRio/jbIjgRD0aCmu9BhgX27MxxbBp0jCUuCsmD+NGnj/ZTlLC/vhssh5LxHVe9PpiGFFD7fXM6Wegl7qKr/wURU55M5mPNZIk7FL7TRkF4T
 /33Rf7rPRB6UAi4WCyEzToizBRyFkEIRt+A9MQ2DqLQm0XoOwow=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Now that the sequencer creates commits without forking 'git commit' it
does not see an empty commit in these tests which fixes the known
breakage. Note that logic for handling
KNOWN_FAILURE_CHERRY_PICK_SEES_EMPTY_COMMIT=1 is not removed from
lib-submodule-update.sh as it is still used by other tests.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---

Notes:
    The output of the tests with after the previous patch looks like the
    output of the merge tests (see below), so I'm hopeful that this is a
    genuine fix, but someone who knows about submodules should check that
    things are in fact working properly now.
    
    t3512-cherry-pick-submodule.sh
    
    expecting success:
    		prolog &&
    		reset_work_tree_to add_sub1 &&
    		(
    			cd submodule_update &&
    			git branch -t modify_sub1 origin/modify_sub1 &&
    			$command modify_sub1 &&
    			test_superproject_content origin/modify_sub1 &&
    			test_submodule_content sub1 origin/add_sub1 &&
    			git submodule update &&
    			test_submodule_content sub1 origin/modify_sub1
    		)
    
    Cloning into 'submodule_update'...
    done.
    Switched to a new branch 'add_sub1'
    Branch 'add_sub1' set up to track remote branch 'add_sub1' from 'origin'.
    Submodule 'sub1' (/home/phil/Documents/src/git/t/trash directory.t3512-cherry-pick-submodule/submodule_update_sub1) registered for path 'sub1'
    Cloning into '/home/phil/Documents/src/git/t/trash directory.t3512-cherry-pick-submodule/submodule_update/sub1'...
    done.
    Submodule path 'sub1': checked out 'ce9efb76b6ff5beb56e70d3662695f3ecbd38330'
    Branch 'modify_sub1' set up to track remote branch 'modify_sub1' from 'origin'.
    [add_sub1 e57a25c] Modify sub1
     Author: A U Thor <author@example.com>
     Date: Fri Nov 24 10:48:45 2017 +0000
    Submodule path 'sub1': checked out '7c9cd6d138a7bb3145fc0c7fca1f403cbe89010e'
    ok 11 - git cherry-pick: modified submodule does not update submodule work tree
    
    expecting success:
    		prolog &&
    		reset_work_tree_to add_sub1 &&
    		(
    			cd submodule_update &&
    			git branch -t invalid_sub1 origin/invalid_sub1 &&
    			$command invalid_sub1 &&
    			test_superproject_content origin/invalid_sub1 &&
    			test_submodule_content sub1 origin/add_sub1 &&
    			test_must_fail git submodule update &&
    			test_submodule_content sub1 origin/add_sub1
    		)
    
    Cloning into 'submodule_update'...
    done.
    Switched to a new branch 'add_sub1'
    Branch 'add_sub1' set up to track remote branch 'add_sub1' from 'origin'.
    Submodule 'sub1' (/home/phil/Documents/src/git/t/trash directory.t3512-cherry-pick-submodule/submodule_update_sub1) registered for path 'sub1'
    Cloning into '/home/phil/Documents/src/git/t/trash directory.t3512-cherry-pick-submodule/submodule_update/sub1'...
    done.
    Submodule path 'sub1': checked out 'ce9efb76b6ff5beb56e70d3662695f3ecbd38330'
    Branch 'invalid_sub1' set up to track remote branch 'invalid_sub1' from 'origin'.
    [add_sub1 155695c] Invalid sub1 commit
     Author: A U Thor <author@example.com>
     Date: Fri Nov 24 10:48:45 2017 +0000
    error: Server does not allow request for unadvertised object 0123456789012345678901234567890123456789
    Fetched in submodule path 'sub1', but it did not contain 0123456789012345678901234567890123456789. Direct fetching of that commit failed.
    ok 12 - git cherry-pick: modified submodule does not update submodule work tree to invalid commit
    
    expecting success:
    		prolog &&
    		reset_work_tree_to invalid_sub1 &&
    		(
    			cd submodule_update &&
    			git branch -t valid_sub1 origin/valid_sub1 &&
    			$command valid_sub1 &&
    			test_superproject_content origin/valid_sub1 &&
    			test_dir_is_empty sub1 &&
    			git submodule update --init --recursive &&
    			test_submodule_content sub1 origin/valid_sub1
    		)
    
    Cloning into 'submodule_update'...
    done.
    Switched to a new branch 'invalid_sub1'
    Branch 'invalid_sub1' set up to track remote branch 'invalid_sub1' from 'origin'.
    fatal: Needed a single revision
    Branch 'valid_sub1' set up to track remote branch 'valid_sub1' from 'origin'.
    [invalid_sub1 497299e] Revert "Invalid sub1 commit"
     Author: A U Thor <author@example.com>
     Date: Fri Nov 24 10:48:46 2017 +0000
    Submodule 'sub1' (/home/phil/Documents/src/git/t/trash directory.t3512-cherry-pick-submodule/submodule_update_sub1) registered for path 'sub1'
    Submodule 'uninitialized_sub' (/home/phil/Documents/src/git/t/trash directory.t3512-cherry-pick-submodule/submodule_update_sub1) registered for path 'uninitialized_sub'
    Cloning into '/home/phil/Documents/src/git/t/trash directory.t3512-cherry-pick-submodule/submodule_update/sub1'...
    done.
    Cloning into '/home/phil/Documents/src/git/t/trash directory.t3512-cherry-pick-submodule/submodule_update/uninitialized_sub'...
    done.
    Submodule path 'sub1': checked out 'ce9efb76b6ff5beb56e70d3662695f3ecbd38330'
    Submodule path 'uninitialized_sub': checked out 'ce9efb76b6ff5beb56e70d3662695f3ecbd38330'
    ok 13 - git cherry-pick: modified submodule does not update submodule work tree from invalid commit
    
    t3513-revert-submodule.sh
    
    expecting success:
    		prolog &&
    		reset_work_tree_to add_sub1 &&
    		(
    			cd submodule_update &&
    			git branch -t modify_sub1 origin/modify_sub1 &&
    			$command modify_sub1 &&
    			test_superproject_content origin/modify_sub1 &&
    			test_submodule_content sub1 origin/add_sub1 &&
    			git submodule update &&
    			test_submodule_content sub1 origin/modify_sub1
    		)
    
    Cloning into 'submodule_update'...
    done.
    Switched to a new branch 'add_sub1'
    Branch 'add_sub1' set up to track remote branch 'add_sub1' from 'origin'.
    Submodule 'sub1' (/home/phil/Documents/src/git/t/trash directory.t3513-revert-submodule/submodule_update_sub1) registered for path 'sub1'
    Cloning into '/home/phil/Documents/src/git/t/trash directory.t3513-revert-submodule/submodule_update/sub1'...
    done.
    Submodule path 'sub1': checked out '4497aa8f9341f6e5f178dbb536a7093e8f093d8a'
    Branch 'modify_sub1' set up to track remote branch 'modify_sub1' from 'origin'.
    Switched to branch 'modify_sub1'
    Your branch is up to date with 'origin/modify_sub1'.
    [modify_sub1 1c2c464] Revert "Modify sub1"
     Author: A U Thor <author@example.com>
     Date: Fri Nov 24 10:48:51 2017 +0000
    [modify_sub1 cde56a6] Revert "Revert "Modify sub1""
     Author: A U Thor <author@example.com>
     Date: Fri Nov 24 10:48:51 2017 +0000
    Submodule path 'sub1': checked out 'a66b894bbfed816edf59cf901620978a64419731'
    ok 11 - git_revert: modified submodule does not update submodule work tree
    
    expecting success:
    		prolog &&
    		reset_work_tree_to add_sub1 &&
    		(
    			cd submodule_update &&
    			git branch -t invalid_sub1 origin/invalid_sub1 &&
    			$command invalid_sub1 &&
    			test_superproject_content origin/invalid_sub1 &&
    			test_submodule_content sub1 origin/add_sub1 &&
    			test_must_fail git submodule update &&
    			test_submodule_content sub1 origin/add_sub1
    		)
    
    Cloning into 'submodule_update'...
    done.
    Switched to a new branch 'add_sub1'
    Branch 'add_sub1' set up to track remote branch 'add_sub1' from 'origin'.
    Submodule 'sub1' (/home/phil/Documents/src/git/t/trash directory.t3513-revert-submodule/submodule_update_sub1) registered for path 'sub1'
    Cloning into '/home/phil/Documents/src/git/t/trash directory.t3513-revert-submodule/submodule_update/sub1'...
    done.
    Submodule path 'sub1': checked out '4497aa8f9341f6e5f178dbb536a7093e8f093d8a'
    Branch 'invalid_sub1' set up to track remote branch 'invalid_sub1' from 'origin'.
    Switched to branch 'invalid_sub1'
    Your branch is up to date with 'origin/invalid_sub1'.
    [invalid_sub1 cec26d9] Revert "Invalid sub1 commit"
     Author: A U Thor <author@example.com>
     Date: Fri Nov 24 10:48:51 2017 +0000
    [invalid_sub1 d017764] Revert "Revert "Invalid sub1 commit""
     Author: A U Thor <author@example.com>
     Date: Fri Nov 24 10:48:51 2017 +0000
    error: Server does not allow request for unadvertised object 0123456789012345678901234567890123456789
    Fetched in submodule path 'sub1', but it did not contain 0123456789012345678901234567890123456789. Direct fetching of that commit failed.
    ok 12 - git_revert: modified submodule does not update submodule work tree to invalid commit
    
    expecting success:
    		prolog &&
    		reset_work_tree_to invalid_sub1 &&
    		(
    			cd submodule_update &&
    			git branch -t valid_sub1 origin/valid_sub1 &&
    			$command valid_sub1 &&
    			test_superproject_content origin/valid_sub1 &&
    			test_dir_is_empty sub1 &&
    			git submodule update --init --recursive &&
    			test_submodule_content sub1 origin/valid_sub1
    		)
    
    Cloning into 'submodule_update'...
    done.
    Switched to a new branch 'invalid_sub1'
    Branch 'invalid_sub1' set up to track remote branch 'invalid_sub1' from 'origin'.
    fatal: Needed a single revision
    Branch 'valid_sub1' set up to track remote branch 'valid_sub1' from 'origin'.
    Switched to branch 'valid_sub1'
    Your branch is up to date with 'origin/valid_sub1'.
    [valid_sub1 ca047d9] Revert "Revert "Invalid sub1 commit""
     Author: A U Thor <author@example.com>
     Date: Fri Nov 24 10:48:51 2017 +0000
    [valid_sub1 e1e9178] Revert "Revert "Revert "Invalid sub1 commit"""
     Author: A U Thor <author@example.com>
     Date: Fri Nov 24 10:48:51 2017 +0000
    Submodule 'sub1' (/home/phil/Documents/src/git/t/trash directory.t3513-revert-submodule/submodule_update_sub1) registered for path 'sub1'
    Submodule 'uninitialized_sub' (/home/phil/Documents/src/git/t/trash directory.t3513-revert-submodule/submodule_update_sub1) registered for path 'uninitialized_sub'
    Cloning into '/home/phil/Documents/src/git/t/trash directory.t3513-revert-submodule/submodule_update/sub1'...
    done.
    Cloning into '/home/phil/Documents/src/git/t/trash directory.t3513-revert-submodule/submodule_update/uninitialized_sub'...
    done.
    Submodule path 'sub1': checked out '4497aa8f9341f6e5f178dbb536a7093e8f093d8a'
    Submodule path 'uninitialized_sub': checked out '4497aa8f9341f6e5f178dbb536a7093e8f093d8a'
    ok 13 - git_revert: modified submodule does not update submodule work tree from invalid commit
    
    t7613-merge-submodule.sh
    
    expecting success:
    		prolog &&
    		reset_work_tree_to add_sub1 &&
    		(
    			cd submodule_update &&
    			git branch -t modify_sub1 origin/modify_sub1 &&
    			$command modify_sub1 &&
    			test_superproject_content origin/modify_sub1 &&
    			test_submodule_content sub1 origin/add_sub1 &&
    			git submodule update &&
    			test_submodule_content sub1 origin/modify_sub1
    		)
    
    Cloning into 'submodule_update'...
    done.
    Switched to a new branch 'add_sub1'
    Branch 'add_sub1' set up to track remote branch 'add_sub1' from 'origin'.
    Submodule 'sub1' (/home/phil/Documents/src/git/t/trash directory.t7613-merge-submodule/submodule_update_sub1) registered for path 'sub1'
    Cloning into '/home/phil/Documents/src/git/t/trash directory.t7613-merge-submodule/submodule_update/sub1'...
    done.
    Submodule path 'sub1': checked out 'c97e5093cc535f043494394509e7ad784b5931ce'
    Branch 'modify_sub1' set up to track remote branch 'modify_sub1' from 'origin'.
    Updating ec3f722..c933e8b
    Fast-forward
    Submodule path 'sub1': checked out '614c78931e0df85cee80e90bbf96ed92504cd886'
    ok 11 - git merge: modified submodule does not update submodule work tree
    
    expecting success:
    		prolog &&
    		reset_work_tree_to add_sub1 &&
    		(
    			cd submodule_update &&
    			git branch -t invalid_sub1 origin/invalid_sub1 &&
    			$command invalid_sub1 &&
    			test_superproject_content origin/invalid_sub1 &&
    			test_submodule_content sub1 origin/add_sub1 &&
    			test_must_fail git submodule update &&
    			test_submodule_content sub1 origin/add_sub1
    		)
    
    Cloning into 'submodule_update'...
    done.
    Switched to a new branch 'add_sub1'
    Branch 'add_sub1' set up to track remote branch 'add_sub1' from 'origin'.
    Submodule 'sub1' (/home/phil/Documents/src/git/t/trash directory.t7613-merge-submodule/submodule_update_sub1) registered for path 'sub1'
    Cloning into '/home/phil/Documents/src/git/t/trash directory.t7613-merge-submodule/submodule_update/sub1'...
    done.
    Submodule path 'sub1': checked out 'c97e5093cc535f043494394509e7ad784b5931ce'
    Branch 'invalid_sub1' set up to track remote branch 'invalid_sub1' from 'origin'.
    Updating ec3f722..5c6fb5f
    Fast-forward
    error: Server does not allow request for unadvertised object 0123456789012345678901234567890123456789
    Fetched in submodule path 'sub1', but it did not contain 0123456789012345678901234567890123456789. Direct fetching of that commit failed.
    ok 12 - git merge: modified submodule does not update submodule work tree to invalid commit
    
    expecting success:
    		prolog &&
    		reset_work_tree_to invalid_sub1 &&
    		(
    			cd submodule_update &&
    			git branch -t valid_sub1 origin/valid_sub1 &&
    			$command valid_sub1 &&
    			test_superproject_content origin/valid_sub1 &&
    			test_dir_is_empty sub1 &&
    			git submodule update --init --recursive &&
    			test_submodule_content sub1 origin/valid_sub1
    		)
    
    Cloning into 'submodule_update'...
    done.
    Switched to a new branch 'invalid_sub1'
    Branch 'invalid_sub1' set up to track remote branch 'invalid_sub1' from 'origin'.
    fatal: Needed a single revision
    Branch 'valid_sub1' set up to track remote branch 'valid_sub1' from 'origin'.
    Updating 5c6fb5f..07412aa
    Fast-forward
    Submodule 'sub1' (/home/phil/Documents/src/git/t/trash directory.t7613-merge-submodule/submodule_update_sub1) registered for path 'sub1'
    Submodule 'uninitialized_sub' (/home/phil/Documents/src/git/t/trash directory.t7613-merge-submodule/submodule_update_sub1) registered for path 'uninitialized_sub'
    Cloning into '/home/phil/Documents/src/git/t/trash directory.t7613-merge-submodule/submodule_update/sub1'...
    done.
    Cloning into '/home/phil/Documents/src/git/t/trash directory.t7613-merge-submodule/submodule_update/uninitialized_sub'...
    done.
    Submodule path 'sub1': checked out 'c97e5093cc535f043494394509e7ad784b5931ce'
    Submodule path 'uninitialized_sub': checked out 'c97e5093cc535f043494394509e7ad784b5931ce'
    ok 13 - git merge: modified submodule does not update submodule work tree from invalid commit

 t/t3512-cherry-pick-submodule.sh | 1 -
 t/t3513-revert-submodule.sh      | 1 -
 2 files changed, 2 deletions(-)

diff --git a/t/t3512-cherry-pick-submodule.sh b/t/t3512-cherry-pick-submodule.sh
index 6863b7bb6fd94cbbd3fcc8f29ab02e344cac23c9..059213767e089e69ad61d14c329930ef097813e7 100755
--- a/t/t3512-cherry-pick-submodule.sh
+++ b/t/t3512-cherry-pick-submodule.sh
@@ -5,7 +5,6 @@ test_description='cherry-pick can handle submodules'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
 
-KNOWN_FAILURE_CHERRY_PICK_SEES_EMPTY_COMMIT=1
 KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
 KNOWN_FAILURE_NOFF_MERGE_ATTEMPTS_TO_MERGE_REMOVED_SUBMODULE_FILES=1
 test_submodule_switch "git cherry-pick"
diff --git a/t/t3513-revert-submodule.sh b/t/t3513-revert-submodule.sh
index db9378142a93338d2988f40e2748bc476490bcd5..5e39fcdb66c0c7c4b112c1bbe941d886db237693 100755
--- a/t/t3513-revert-submodule.sh
+++ b/t/t3513-revert-submodule.sh
@@ -25,7 +25,6 @@ git_revert () {
 	git revert HEAD
 }
 
-KNOWN_FAILURE_CHERRY_PICK_SEES_EMPTY_COMMIT=1
 KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
 test_submodule_switch "git_revert"
 
-- 
2.15.0

