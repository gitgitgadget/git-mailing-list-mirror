Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC512209AA
	for <e@80x24.org>; Thu, 15 Sep 2016 15:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752673AbcIOPBH (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 11:01:07 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:48050 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752577AbcIOPBE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 11:01:04 -0400
Received: (qmail 9868 invoked from network); 15 Sep 2016 15:01:02 -0000
Received: (qmail 24912 invoked from network); 15 Sep 2016 15:01:00 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 15 Sep 2016 15:00:58 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:   Vasco Almeida <vascomalmeida@sapo.pt>
To:     git@vger.kernel.org
Cc:     Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20AVILA?= <jn.avila@free.fr>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 12/14] i18n: show-branch: mark error messages for translation
Date:   Thu, 15 Sep 2016 14:59:06 +0000
Message-Id: <1473951548-31733-12-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1473951548-31733-1-git-send-email-vascomalmeida@sapo.pt>
References: <1473951548-31733-1-git-send-email-vascomalmeida@sapo.pt>
In-Reply-To: <1473259758-11836-1-git-send-email-vascomalmeida@sapo.pt>
References: <1473259758-11836-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lowercase some messages first word to match style of the others.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 builtin/show-branch.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 2566935..5809371 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -538,7 +538,7 @@ static void append_one_rev(const char *av)
 		for_each_ref(append_matching_ref, NULL);
 		if (saved_matches == ref_name_cnt &&
 		    ref_name_cnt < MAX_REVS)
-			error("no matching refs with %s", av);
+			error(_("no matching refs with %s"), av);
 		if (saved_matches + 1 < ref_name_cnt)
 			sort_ref_range(saved_matches, ref_name_cnt);
 		return;
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
 			die("Only %d entries can be shown at one time.",
 			    MAX_REVS);
 		if (!dwim_ref(*av, strlen(*av), oid.hash, &ref))
-			die("No such ref %s", *av);
+			die(_("no such ref %s"), *av);
 
 		/* Has the base been specified? */
 		if (reflog_base) {
@@ -828,10 +828,10 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 		if (MAX_REVS <= num_rev)
 			die("cannot handle more than %d revs.", MAX_REVS);
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

