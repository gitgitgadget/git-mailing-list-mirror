Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2E8E2070F
	for <e@80x24.org>; Mon, 19 Sep 2016 13:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936520AbcISNJi (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 09:09:38 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:47496 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S936419AbcISNJg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 09:09:36 -0400
Received: (qmail 31895 invoked from network); 19 Sep 2016 13:09:34 -0000
Received: (qmail 1721 invoked from network); 19 Sep 2016 13:09:31 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 19 Sep 2016 13:09:26 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:   Vasco Almeida <vascomalmeida@sapo.pt>
To:     git@vger.kernel.org
Cc:     Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20AVILA?= <jn.avila@free.fr>
Subject: [PATCH 6/6] i18n: stash: mark messages for translation
Date:   Mon, 19 Sep 2016 13:08:21 +0000
Message-Id: <1474290501-2743-6-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1474290501-2743-1-git-send-email-vascomalmeida@sapo.pt>
References: <1474290501-2743-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 git-stash.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 826af18..90d63f2 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -100,7 +100,7 @@ create_stash () {
 				u_tree=$(git write-tree) &&
 				printf 'untracked files on %s\n' "$msg" | git commit-tree $u_tree  &&
 				rm -f "$TMPindex"
-		) ) || die "Cannot save the untracked files"
+		) ) || die "$(gettext "Cannot save the untracked files")"
 
 		untracked_commit_option="-p $u_commit";
 	else
@@ -248,7 +248,7 @@ save_stash () {
 
 	if test -n "$patch_mode" && test -n "$untracked"
 	then
-	    die "Can't use --patch and --include-untracked or --all at the same time"
+		die "$(gettext "Can't use --patch and --include-untracked or --all at the same time")"
 	fi
 
 	stash_msg="$*"
@@ -494,7 +494,7 @@ apply_stash () {
 		GIT_INDEX_FILE="$TMPindex" git-read-tree "$u_tree" &&
 		GIT_INDEX_FILE="$TMPindex" git checkout-index --all &&
 		rm -f "$TMPindex" ||
-		die 'Could not restore untracked files from stash'
+		die "$(gettext "Could not restore untracked files from stash")"
 	fi
 
 	eval "
-- 
2.7.4

