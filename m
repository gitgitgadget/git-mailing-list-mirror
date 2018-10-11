Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F4E71F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 18:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729227AbeJLCCa (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 22:02:30 -0400
Received: from mail.weplayciv.com ([162.221.200.53]:55332 "EHLO
        mail.weplayciv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728092AbeJLCC3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 22:02:29 -0400
Received: from localhost.localdomain (c-3985e555.02-149-6c6b7013.bbcust.telenor.se [85.229.133.57])
        by mail.weplayciv.com (Postfix) with ESMTPSA id D35D094EC03;
        Thu, 11 Oct 2018 11:34:03 -0700 (PDT)
From:   Daniels Umanovskis <daniels@umanovskis.se>
To:     git@vger.kernel.org
Cc:     Daniels Umanovskis <daniels@umanovskis.se>
Subject: [PATCH] doc: move git-cherry to plumbing
Date:   Thu, 11 Oct 2018 20:33:50 +0200
Message-Id: <20181011183350.14584-1-daniels@umanovskis.se>
X-Mailer: git-send-email 2.19.1.330.g93276587c.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Also remove git-cherry from Bash completion because plumbing
commands do not belong there.

Signed-off-by: Daniels Umanovskis <daniels@umanovskis.se>
---

Up to discussion whether cherry should be considered plumbing.
I lean towards considering it a rarely-used porcelain command, but
a case could be made either way so let's see what the list thinks.

 command-list.txt                       |  2 +-
 contrib/completion/git-completion.bash | 11 -----------
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/command-list.txt b/command-list.txt
index c36ea3c18..bdca6e3d3 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -62,7 +62,7 @@ git-check-mailmap                       purehelpers
 git-checkout                            mainporcelain           history
 git-checkout-index                      plumbingmanipulators
 git-check-ref-format                    purehelpers
-git-cherry                              ancillaryinterrogators          complete
+git-cherry                              plumbinginterrogators          complete
 git-cherry-pick                         mainporcelain
 git-citool                              mainporcelain
 git-clean                               mainporcelain
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index d63d2dffd..12f7ce0c5 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1340,17 +1340,6 @@ _git_checkout ()
 	esac
 }
 
-_git_cherry ()
-{
-	case "$cur" in
-	--*)
-		__gitcomp_builtin cherry
-		return
-	esac
-
-	__git_complete_refs
-}
-
 __git_cherry_pick_inprogress_options="--continue --quit --abort"
 
 _git_cherry_pick ()
-- 
2.19.1.330.g93276587c.dirty

