Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FA0D20985
	for <e@80x24.org>; Sun, 11 Sep 2016 10:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755983AbcIKK4A (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 06:56:00 -0400
Received: from mout.gmx.net ([212.227.17.22]:50114 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755972AbcIKKz6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 06:55:58 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MADqP-1btij40Nz7-00BPKo; Sun, 11 Sep 2016 12:55:55
 +0200
Date:   Sun, 11 Sep 2016 12:55:54 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v2 23/25] sequencer: mark action_name() for translation
In-Reply-To: <cover.1473590966.git.johannes.schindelin@gmx.de>
Message-ID: <379463a47285b3e59fc4b0894fd74b939c399483.1473590966.git.johannes.schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <cover.1473590966.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:9gT2sJD7jVOtXgHkWts1WnKZarH74dV54HKfFuRySbocicbPSoS
 g74vXbJvxb1nunVk4r5cifTtoqTtyUEd9TG57Og3fBNjBW17XLJqWOLJIvo1vjXJp6auDnb
 vkiRV2MP1V1ebCOetCB1CMaNSXnOsxgAPEFTW00pOYTm+bbd5G2huFpjNL+m1+rBtAsyLAb
 3GbB6laudMcipmD/+yUYw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VP6PsUUbJzU=:zhfumI3sesiOQ+FtYfdFPP
 Z1IxhmGGEbiO/ZSKn99KsPlbK5/+xzLGsxdBp++6a619ZAXh9uCM8WLG8TIyPis9Wpm9YCq46
 lkNtZ6g+vgBYbuJp2NQcYnivtaUq8mCSO+/jEr63Om8CCHComDjB6Tu/mEb6icvMSklZHQa3T
 C1qlfxLA1M+UgeB86JSERUFBiyA1zEKDZVQ3yHN/jJJpPmb1q5uStbcVn3jmgH4LDDacNZ7Xv
 SILImM6S9nh0RmCnDwEahfGbzjd8AStxcafZzPBOF7DF4b5V0L0v3pWDHwX1dKcrdvvBDSddQ
 TU/bHn5LS0sYBI/eorNyy+lfCgxk1goeVJgbiF3pjaZPkEe2vUYWNNvAZlHrODg1yyst1VeTY
 ONeGQqKbIffceeshWK8nCHSuexqIHB9YL0/Ov935RQ32arZtsYy9+C97pwNLZiuUXIeGWHpzn
 Oiz8UUbvQnDGBDwqjPHmLE3hRUQVLvJdJHRUyF0Z2ffl/DhHRAc8l1zH1CF2aezn9pAQ4ovkD
 GrL5Zg/r3iPmbj0tg30O28tjQWT6o3FvRtgwbum+8N7haADD9FRgylMy3RDoJwvxKPW2Gvy2f
 U3qeXX+duXYR+tY90Uq2NyUtdINNx3KbRgEPyKQ+jfR9WzEltdX+iKLcJfuBMcsMjhnTrkwmZ
 ZtBEQUmwOYOydDTe+xphBg/nEx8QYkT/T9GAy9ToBOj3xq+bU9li/z5hUNZHWToY63luHSntR
 sh6xFC/vp6EYMT4CKDNCj1G8+ObB7VYjzleONsLHP8wAsOEWPzi/BAKdhYbS2e0t4xXjFaBwn
 4ZsQ8Wg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The definition of this function goes back all the way to 043a449
(sequencer: factor code out of revert builtin, 2012-01-11), long before a
serious effort was made to translate all the error messages.

It is slightly out of the context of the current patch series (whose
purpose it is to re-implement the performance critical parts of the
interactive rebase in C) to make the error messages in the sequencer
translatable, but what the heck. We'll just do it while we're looking at
this part of the code.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 5144245..1e7f29e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -176,7 +176,7 @@ int sequencer_remove_state(struct replay_opts *opts)
 
 static const char *action_name(const struct replay_opts *opts)
 {
-	return opts->action == REPLAY_REVERT ? "revert" : "cherry-pick";
+	return opts->action == REPLAY_REVERT ? N_("revert") : N_("cherry-pick");
 }
 
 struct commit_message {
@@ -312,10 +312,10 @@ static struct tree *empty_tree(void)
 static int error_dirty_index(struct replay_opts *opts)
 {
 	if (read_cache_unmerged())
-		return error_resolve_conflict(action_name(opts));
+		return error_resolve_conflict(_(action_name(opts)));
 
 	error(_("Your local changes would be overwritten by %s."),
-		action_name(opts));
+		_(action_name(opts)));
 
 	if (advice_commit_before_merge)
 		advise(_("Commit your changes or stash them to proceed."));
@@ -333,7 +333,7 @@ static int fast_forward_to(const unsigned char *to, const unsigned char *from,
 	if (checkout_fast_forward(from, to, 1))
 		return -1; /* the callee should have complained already */
 
-	strbuf_addf(&sb, _("%s: fast-forward"), action_name(opts));
+	strbuf_addf(&sb, _("%s: fast-forward"), _(action_name(opts)));
 
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
@@ -409,7 +409,7 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 	    write_locked_index(&the_index, &index_lock, COMMIT_LOCK))
 		/* TRANSLATORS: %s will be "revert" or "cherry-pick" */
 		return error(_("%s: Unable to write new index file"),
-			action_name(opts));
+			_(action_name(opts)));
 	rollback_lock_file(&index_lock);
 
 	if (opts->signoff)
@@ -840,14 +840,14 @@ static int read_and_refresh_cache(struct replay_opts *opts)
 	if (read_index_preload(&the_index, NULL) < 0) {
 		rollback_lock_file(&index_lock);
 		return error(_("git %s: failed to read the index"),
-			action_name(opts));
+			_(action_name(opts)));
 	}
 	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, NULL, NULL, NULL);
 	if (the_index.cache_changed && index_fd >= 0) {
 		if (write_locked_index(&the_index, &index_lock, COMMIT_LOCK)) {
 			rollback_lock_file(&index_lock);
 			return error(_("git %s: failed to refresh the index"),
-				action_name(opts));
+				_(action_name(opts)));
 		}
 	}
 	rollback_lock_file(&index_lock);
-- 
2.10.0.windows.1.10.g803177d


