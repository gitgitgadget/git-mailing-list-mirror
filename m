Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0ECD21F516
	for <e@80x24.org>; Thu, 21 Jun 2018 14:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933219AbeFUOgI (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 10:36:08 -0400
Received: from mail.vm.ouaza.com ([212.83.178.2]:55242 "EHLO mail.vm.ouaza.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933002AbeFUOgH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 10:36:07 -0400
Received: from x260-buxy.home.ouaza.com (133-218-190-109.isp.overthebox.ovh [109.190.218.133])
        by mail.vm.ouaza.com (Postfix) with ESMTPSA id DDF5020F3C;
        Thu, 21 Jun 2018 16:27:15 +0200 (CEST)
Received: by x260-buxy.home.ouaza.com (Postfix, from userid 1000)
        id D60E98A2BD8; Thu, 21 Jun 2018 16:28:13 +0200 (CEST)
From:   =?UTF-8?q?Rapha=C3=ABl=20Hertzog?= <hertzog@debian.org>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        =?UTF-8?q?Rapha=C3=ABl=20Hertzog?= <hertzog@debian.org>
Subject: [PATCH 2/2] i18n: bisect: mark two supplementary strings for translation
Date:   Thu, 21 Jun 2018 16:27:42 +0200
Message-Id: <20180621142742.28575-3-hertzog@debian.org>
X-Mailer: git-send-email 2.18.0.rc2
In-Reply-To: <20180621142742.28575-1-hertzog@debian.org>
References: <20180621142742.28575-1-hertzog@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.99.4 at mail
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The whole bisect procedure is translated but the last message
that the user will see in the process is not translated. Let's fix this.

Signed-off-by: Raphaël Hertzog <hertzog@debian.org>
---
 bisect.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/bisect.c b/bisect.c
index a579b5088..8edc7a7a6 100644
--- a/bisect.c
+++ b/bisect.c
@@ -658,8 +658,8 @@ static void exit_if_skipped_commits(struct commit_list *tried,
 	if (!tried)
 		return;
 
-	printf("There are only 'skip'ped commits left to test.\n"
-	       "The first %s commit could be any of:\n", term_bad);
+	printf(_("There are only 'skip'ped commits left to test.\n"
+		 "The first %s commit could be any of:\n"), term_bad);
 
 	for ( ; tried; tried = tried->next)
 		printf("%s\n", oid_to_hex(&tried->item->object.oid));
@@ -984,7 +984,7 @@ int bisect_next_all(const char *prefix, int no_checkout)
 
 	if (!oidcmp(bisect_rev, current_bad_oid)) {
 		exit_if_skipped_commits(tried, current_bad_oid);
-		printf("%s is the first %s commit\n", oid_to_hex(bisect_rev),
+		printf(_("%s is the first %s commit\n"), oid_to_hex(bisect_rev),
 			term_bad);
 		show_diff_tree(prefix, revs.commits->item);
 		/* This means the bisection process succeeded. */
-- 
2.18.0.rc2

