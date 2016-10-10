Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A29D20989
	for <e@80x24.org>; Mon, 10 Oct 2016 17:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753453AbcJJRdu (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 13:33:50 -0400
Received: from mout.gmx.net ([212.227.15.19]:62127 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752938AbcJJRdt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 13:33:49 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LuxG5-1atbdq2GFF-0108uO; Mon, 10 Oct 2016 19:26:27
 +0200
Date:   Mon, 10 Oct 2016 19:26:26 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v3 22/25] sequencer: mark action_name() for translation
In-Reply-To: <cover.1476120229.git.johannes.schindelin@gmx.de>
Message-ID: <826d552366d1ce9550e448c0e05db6090f529873.1476120229.git.johannes.schindelin@gmx.de>
References: <cover.1473590966.git.johannes.schindelin@gmx.de> <cover.1476120229.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:b78HypJPKc33uBdq/8CeAOWMouoaM54kBVpYedte72QG+jTKpMj
 jjpAKylJ4FLC6zKgLAVqbft6FFh1T/s5XdFJsp0HQKHeRfA3KoslWVgYWKW6vVOVlp2ueW4
 c72r9U2KhXR79PILhKfCaEhmanPFWBIN6n/efsaWnNew5lJ6C9xgbrsvlDe39GgP6fHQkYn
 Vs4AD7cAGa0hS5G9k41HQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QIrB4+GKgQo=:lF0pUynU75cUkr+LHdLqfc
 JblQRp2FaOdghNrBK16JCwPvAgo+cHZrTvu32Gogp4ZFiOmfyjRT2K9TkX2SRT5az6lkZWZ5G
 6tCkC64owvw8vCNnPk2Wt+ZPVCxJiYZmlDv99BlcF0oTOCxPcQBluXrMk/ztUVAZrQwzFwrdF
 RHN1aQYMZNO2HediTupIIh+0dapdUpIoQ+j4lI6QRSd4FiyGVhWmADA56iHgH9Dj0WZ/yqaGG
 l83aBWAWWMlij4gNgt+jR++12hB0LitqMREmhD35DJ7WvUNu5PMfqHQu5XSHNNOcx3s5MIlRf
 xlVMnMqrvWOcDirbrp8xE3HqMJzv4Y1AUJumE3Ahc1gNoeMpk6rSx3XKFyK2Z3I6OG2dvkQ3p
 fK8BdB6/mnN0IwqlcINHF3dxiIhwIHRTHsV9BJS4HiqIRw0Hx4ZY1D022UiArQWIsjHUziBx5
 fZeNU8KDgE/MaHpZoVeybt7Qq6VfdxIpS0yVo19zQDWum/N/smvJmm43ALqlZB5loz3tIo1lS
 AK474O+HqHZLHlaEMPGUVIGo8XH+FL7O2SNu1o4LMZo6A9zt90pzrzub9jB60SnB1rkFjcPtd
 fCgbQx8lGVDSdDZOdvUibqOBozhJASl0AHht217pJaXzdXS9YwUf2jrJWzHvTKlQnQCV0VyMg
 xfCvmgvfMEVu1TNLe46Xeae+toq3GmX0Q7IxGMPFmja3WKoW9FrDiJaO0CLQ7V0o6HYPKciGM
 UdXj7cr82PQs9v5j68ZZ3WCknZgXTxF/3uGPMt1+BCxbgXD4NIiLYDEOnKfu969cmYj7BBJTy
 6AZWhKI
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
index ffce095..40ef33c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -168,7 +168,7 @@ int sequencer_remove_state(struct replay_opts *opts)
 
 static const char *action_name(const struct replay_opts *opts)
 {
-	return opts->action == REPLAY_REVERT ? "revert" : "cherry-pick";
+	return opts->action == REPLAY_REVERT ? N_("revert") : N_("cherry-pick");
 }
 
 struct commit_message {
@@ -310,10 +310,10 @@ static struct tree *empty_tree(void)
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
@@ -331,7 +331,7 @@ static int fast_forward_to(const unsigned char *to, const unsigned char *from,
 	if (checkout_fast_forward(from, to, 1))
 		return -1; /* the callee should have complained already */
 
-	strbuf_addf(&sb, _("%s: fast-forward"), action_name(opts));
+	strbuf_addf(&sb, _("%s: fast-forward"), _(action_name(opts)));
 
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
@@ -407,7 +407,7 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 	    write_locked_index(&the_index, &index_lock, COMMIT_LOCK))
 		/* TRANSLATORS: %s will be "revert" or "cherry-pick" */
 		return error(_("%s: Unable to write new index file"),
-			action_name(opts));
+			_(action_name(opts)));
 	rollback_lock_file(&index_lock);
 
 	if (opts->signoff)
@@ -844,14 +844,14 @@ static int read_and_refresh_cache(struct replay_opts *opts)
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
2.10.0.windows.1.325.ge6089c1


