Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 310371F4F8
	for <e@80x24.org>; Mon, 17 Oct 2016 13:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756457AbcJQNSD (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Oct 2016 09:18:03 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:34293 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753509AbcJQNQO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2016 09:16:14 -0400
Received: (qmail 16727 invoked from network); 17 Oct 2016 13:16:11 -0000
Received: (qmail 12239 invoked from network); 17 Oct 2016 13:16:08 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 17 Oct 2016 13:16:03 -0000
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
Subject: [PATCH 1/4] i18n: apply: mark error message for translation
Date:   Mon, 17 Oct 2016 13:15:26 +0000
Message-Id: <20161017131529.27856-1-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.10.1.459.g5fd885d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Update test to reflect changes.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 apply.c               | 4 ++--
 t/t4254-am-corrupt.sh | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/apply.c b/apply.c
index 8215874..705cf56 100644
--- a/apply.c
+++ b/apply.c
@@ -1586,8 +1586,8 @@ static int find_header(struct apply_state *state,
 				patch->new_name = xstrdup(patch->def_name);
 			}
 			if (!patch->is_delete && !patch->new_name) {
-				error("git diff header lacks filename information "
-					     "(line %d)", state->linenr);
+				error(_("git diff header lacks filename information "
+					     "(line %d)"), state->linenr);
 				return -128;
 			}
 			patch->is_toplevel_relative = 1;
diff --git a/t/t4254-am-corrupt.sh b/t/t4254-am-corrupt.sh
index 9bd7dd2..168739c 100755
--- a/t/t4254-am-corrupt.sh
+++ b/t/t4254-am-corrupt.sh
@@ -31,7 +31,7 @@ test_expect_success 'try to apply corrupted patch' '
 test_expect_success 'compare diagnostic; ensure file is still here' '
 	echo "error: git diff header lacks filename information (line 4)" >expected &&
 	test_path_is_file f &&
-	test_cmp expected actual
+	test_i18ncmp expected actual
 '
 
 test_done
-- 
2.10.1.459.g5fd885d

