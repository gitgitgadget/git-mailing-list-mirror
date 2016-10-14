Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 283891F4F8
	for <e@80x24.org>; Fri, 14 Oct 2016 13:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932778AbcJNNT6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 09:19:58 -0400
Received: from mout.gmx.net ([212.227.15.18]:49927 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755430AbcJNNTX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 09:19:23 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0Lbujs-1ce2KG0i3w-00jKJ7; Fri, 14 Oct 2016 15:19:16
 +0200
Date:   Fri, 14 Oct 2016 15:19:15 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v4 22/25] sequencer: mark action_name() for translation
In-Reply-To: <cover.1476450940.git.johannes.schindelin@gmx.de>
Message-ID: <a6900b2ae43c92354d52a335facc4f931878f16d.1476450940.git.johannes.schindelin@gmx.de>
References: <cover.1476120229.git.johannes.schindelin@gmx.de> <cover.1476450940.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ArkRPa+ek5L2RdwtLZm291X6I3ZuOSU7lSir3XRqh5Kk6jTBf0j
 1FUOQH/qQZo5LcDc+bgc2d9f3ax/tG2DsuImn8HA4b3NwoEr9k5G4czJizgl8G3xfdaZ595
 K3xCnGF+SWqYZmJAmEbLMnK/5KjzPS03hatbJBjBYlz8YETtNZqJg1yjv6GPZbllP0gZ5I5
 CZa13TjBmEbeZiUMZdMBg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:am90qn6v0R8=:gRGmKjRSMzkCV2jRA7gRNk
 B3B0C9mx9IN+yBRqkWHiHWbNBsqz50zqdGvqp9KCvDGhgm071tY5AOcBmgSCu+cFAIhNQuAj8
 PVa9jLnG+4npYkVVxQn1yM4S6A5opzy+Kx781qXgJ6NJJm3zEAjHsFzX79x6J1hpWeNmLo6m8
 k2xAaCZ8JhPGuhk9SsedmpMxZLvksz6y2jumu6u4eLi26DdlnKGe1QVDUsw7DiS7IeVKw4dG6
 R9uRKElRsc2y0rMYuxcPdPkp52c0heyg9a0nnyK3IsmlZKTTjPJyFZBeSn75tBdeloDq1FMR0
 Kv/6+poncbGtpw1AioYZ0+AB+f4YZcBMkzbjLivbrYSd84yRX4irhkKMRHS2N4471+/xTa3tD
 /VI+IG2o0p9l+VE0S286gH/KGNHAHmdaQXUNUboePQjbYVwPdQlCghQewcv768nXWYW5ofRKq
 Kmudui7kMWIc+dx8XdZtMnmdXbNMUHw94mFmqUtNFjxtwp4rSyYSQ3TM6uSL62wWHcaawpccb
 GhH2hxM/NA80PK58OPzeIDxZnFmE9hjC6NAWY3W7/sPSYy+UpjZXdB/4oyjN58U2rnnh2b00Y
 tCY0XOsVjLvnzTlY9Wm23azNKA2YOqqGyIxfysfV5M8p7HXtVjNPhMSF4Y02XNPZFvxd1FsMT
 CYEr0smaciS7WlD9wh0wZMSfeBEfUpGT0/jaWF5vPMjTSycc39Xo5LW7/uIOYfZMYFcfycu/B
 MhcQ7i/of9A9RWiP2qqf99B8vfEnqd2FX3IV1J4hddlX0hoyDHGPUy/5BnNgBaQX3pTFZlbck
 u2NEIDo
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
index 36c24b6..af88753 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -168,7 +168,7 @@ int sequencer_remove_state(struct replay_opts *opts)
 
 static const char *action_name(const struct replay_opts *opts)
 {
-	return opts->action == REPLAY_REVERT ? "revert" : "cherry-pick";
+	return opts->action == REPLAY_REVERT ? N_("revert") : N_("cherry-pick");
 }
 
 struct commit_message {
@@ -304,10 +304,10 @@ static struct tree *empty_tree(void)
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
@@ -325,7 +325,7 @@ static int fast_forward_to(const unsigned char *to, const unsigned char *from,
 	if (checkout_fast_forward(from, to, 1))
 		return -1; /* the callee should have complained already */
 
-	strbuf_addf(&sb, _("%s: fast-forward"), action_name(opts));
+	strbuf_addf(&sb, _("%s: fast-forward"), _(action_name(opts)));
 
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
@@ -401,7 +401,7 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 	    write_locked_index(&the_index, &index_lock, COMMIT_LOCK))
 		/* TRANSLATORS: %s will be "revert" or "cherry-pick" */
 		return error(_("%s: Unable to write new index file"),
-			action_name(opts));
+			_(action_name(opts)));
 	rollback_lock_file(&index_lock);
 
 	if (opts->signoff)
@@ -836,14 +836,14 @@ static int read_and_refresh_cache(struct replay_opts *opts)
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
2.10.1.513.g00ef6dd


