Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17AED20229
	for <e@80x24.org>; Fri, 21 Oct 2016 12:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932818AbcJUM0k (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 08:26:40 -0400
Received: from mout.gmx.net ([212.227.15.18]:64151 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755325AbcJUM0h (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 08:26:37 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LomN9-1cYpf83RcJ-00gsBY; Fri, 21 Oct 2016 14:26:17
 +0200
Date:   Fri, 21 Oct 2016 14:26:17 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v5 24/27] sequencer: mark action_name() for translation
In-Reply-To: <cover.1477052405.git.johannes.schindelin@gmx.de>
Message-ID: <a53f60adceaba6fc02192931c37cc97a40617153.1477052405.git.johannes.schindelin@gmx.de>
References: <cover.1476450940.git.johannes.schindelin@gmx.de> <cover.1477052405.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:cYx2u7PKXb0cmeEsf+sL5cBowyfyYhSDX+q8D1FT2uQ5KX6K0n/
 MEQexcyaYdc2BQrISnEPni0LiizoK5jIUeQNHs6WZXt0cZl1+FrvpibOSKFZp9o69gtygNL
 3sLPNfUSY6omQAV+up0MT+VqsbQg7CRR2KAuyXZdl/47NdQImlo0IKrq5XZKrDawnM/Ehgz
 AuIdJ5BEmk2AksvZRY2Sw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uptFrO3Vy1Y=:tIBYGTXzY40AzI+VjbEcOJ
 JFdnE9E2/LNyrQhIxVpK/+0jrTseFesSWv1q+pjofGWszritSTGNuGu2up1p3/fsA2r7Rw31R
 r4bVebfCi3TlJERk/N2Pr7r6nvFwwxd3xN43b3sb7n/s5bpK9F9VhZcpo70F6cslGb5b9GPOL
 qJUPURbRs9xyYlQoCMnoYwTHBFh4SYQ61C/ux/Yi+yfsNg5WFCrci/6VxXmF4Ei8PPQKCk7QD
 3NZZFpUXC9LspsGSgp2/V2UY4MDjUI+FSYvyr+LuJrOjxpbSJsWjtaW2CPCIhIXAoWadr3COU
 /FLxx/yawJjcOZOzak1wccgY59gjU4Ai+i4acmNMJf4T1EeWZlXgCpqmO5du7cUf15iCdmxcH
 kV23Fd1LPZ+pjOvyoM05zUrn1cBVgnXTdPDnZKzBBUqkgPWfW6rejzQ0aX9WeFnAonmZWwcQG
 MfDbkFAKBgRf8PPOqSgfLBgVwDZbtgI/saKOe2XSX9tnsNx+UQzL+Up39jUjAPP8QQnKO0T1V
 Wo6VRWUyB6+JVCSLNBqjQIzLPNb67doa3ysm47C5jIEspQiCy6dyjA8JPK1/ZPJ2fZ0S6+qfP
 TE70lKGpkO6+b9S/fstil04PGvZXUAW1AXD43yA6OMwX8KPKsAALJ5uQ8M3RapvB5zeyz0L0J
 IpYlSIp0dCHetJx2ejKRvX2JTz5si1JzvyfQGsmfGccfnLsGHycYX/TfBI3eH7/fjt6KsFoHa
 +XyRVP3EjeainBbmGQv0PeLzO8npxV/4rApKUZ6web743rgcVYN5EW/bdHOUfjoAUCGy2lVUu
 HI0lGG1
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
index bd11db4..ff76b6f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -168,7 +168,7 @@ int sequencer_remove_state(struct replay_opts *opts)
 
 static const char *action_name(const struct replay_opts *opts)
 {
-	return opts->action == REPLAY_REVERT ? "revert" : "cherry-pick";
+	return opts->action == REPLAY_REVERT ? N_("revert") : N_("cherry-pick");
 }
 
 struct commit_message {
@@ -300,10 +300,10 @@ static struct tree *empty_tree(void)
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
@@ -321,7 +321,7 @@ static int fast_forward_to(const unsigned char *to, const unsigned char *from,
 	if (checkout_fast_forward(from, to, 1))
 		return -1; /* the callee should have complained already */
 
-	strbuf_addf(&sb, _("%s: fast-forward"), action_name(opts));
+	strbuf_addf(&sb, _("%s: fast-forward"), _(action_name(opts)));
 
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
@@ -397,7 +397,7 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 	    write_locked_index(&the_index, &index_lock, COMMIT_LOCK))
 		/* TRANSLATORS: %s will be "revert" or "cherry-pick" */
 		return error(_("%s: Unable to write new index file"),
-			action_name(opts));
+			_(action_name(opts)));
 	rollback_lock_file(&index_lock);
 
 	if (opts->signoff)
@@ -835,14 +835,14 @@ static int read_and_refresh_cache(struct replay_opts *opts)
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
2.10.1.583.g721a9e0


