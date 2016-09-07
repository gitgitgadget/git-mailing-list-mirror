Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBB3D1F859
	for <e@80x24.org>; Wed,  7 Sep 2016 14:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757443AbcIGOvJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 10:51:09 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:39548 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757337AbcIGOvD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 10:51:03 -0400
Received: (qmail 16654 invoked from network); 7 Sep 2016 14:51:01 -0000
Received: (qmail 7360 invoked from network); 7 Sep 2016 14:50:59 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 7 Sep 2016 14:50:57 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:   Vasco Almeida <vascomalmeida@sapo.pt>
To:     git@vger.kernel.org
Cc:     Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 12/13] i18n: show-branch: mark error messages for translation
Date:   Wed,  7 Sep 2016 14:49:16 +0000
Message-Id: <1473259758-11836-12-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1473259758-11836-1-git-send-email-vascomalmeida@sapo.pt>
References: <1473259758-11836-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lowercase some messages first word to match style of the others.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 builtin/show-branch.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 2566935..8a5097d 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -701,8 +701,8 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 			 *
 			 * Also --all and --remotes do not make sense either.
 			 */
-			die("--reflog is incompatible with --all, --remotes, "
-			    "--independent or --merge-base");
+			die(_("--reflog is incompatible with --all, --remotes, "
+			      "--independent or --merge-base"));
 	}
 
 	/* If nothing is specified, show all branches by default */
@@ -725,16 +725,16 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 			av = fake_av;
 			ac = 1;
 			if (!*av)
-				die("no branches given, and HEAD is not valid");
+				die(_("no branches given, and HEAD is not valid"));
 		}
 		if (ac != 1)
-			die("--reflog option needs one branch name");
+			die(_("--reflog option needs one branch name"));
 
 		if (MAX_REVS < reflog)
-			die("Only %d entries can be shown at one time.",
+			die(_("only %d entries can be shown at one time."),
 			    MAX_REVS);
 		if (!dwim_ref(*av, strlen(*av), oid.hash, &ref))
-			die("No such ref %s", *av);
+			die(_("no such ref %s"), *av);
 
 		/* Has the base been specified? */
 		if (reflog_base) {
@@ -826,12 +826,12 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 		unsigned int flag = 1u << (num_rev + REV_SHIFT);
 
 		if (MAX_REVS <= num_rev)
-			die("cannot handle more than %d revs.", MAX_REVS);
+			die(_("cannot handle more than %d revs."), MAX_REVS);
 		if (get_sha1(ref_name[num_rev], revkey.hash))
-			die("'%s' is not a valid ref.", ref_name[num_rev]);
+			die(_("'%s' is not a valid ref."), ref_name[num_rev]);
 		commit = lookup_commit_reference(revkey.hash);
 		if (!commit)
-			die("cannot find commit %s (%s)",
+			die(_("cannot find commit %s (%s)"),
 			    ref_name[num_rev], oid_to_hex(&revkey));
 		parse_commit(commit);
 		mark_seen(commit, &seen);
-- 
2.7.4

