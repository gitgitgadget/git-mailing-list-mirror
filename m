Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 608A62042F
	for <e@80x24.org>; Tue, 13 Dec 2016 15:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933740AbcLMPjT (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 10:39:19 -0500
Received: from mout.gmx.net ([212.227.15.19]:62122 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933730AbcLMPjQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 10:39:16 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lh7PL-1cwUwj2wad-00oUm1; Tue, 13
 Dec 2016 16:32:38 +0100
Date:   Tue, 13 Dec 2016 16:32:37 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH v2 30/34] sequencer (rebase -i): show only failed cherry-picks'
 output
In-Reply-To: <cover.1481642927.git.johannes.schindelin@gmx.de>
Message-ID: <45ba32ba1bb70ffe2f5034b638e3aa1936b5546d.1481642927.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de> <cover.1481642927.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:D4UGDR894MjjIdDi8OO8IOuEfSRYky5c1imizOi5PBQ+6q+8bN1
 3UJWhI7w3YhDOu/w1lVFjR5G6RvHSeOwMnKVQRfA14pqFjFV2EYo0CofljPPq2KtBtzKrpd
 qGnmtfTJZ6Rz0GVudAI/unvPwXgORsectV3eOXLlw2c75G8XUxDgARvmMh5KRLcBMfMzVJQ
 igzAyQCdJKwMLclPozZng==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vDeK7Z4z1jM=:JpyiQQlTOzetgqO7GzSOCu
 9fkQKa+OTomR+ucQC3a+JgjSEnqzTZV9fxXgvcEx7vCwYf1MS6A+4ygxbr2p+sTS0nJVDBCSz
 OkhsQPEpHI7SXLNfNzhH+AsSiQpWpx4nYowHXEMyQWU3Unyp5nTWG32CbkihvBHpf4czmrZa7
 gxUXwyYUdZkqj85duTQ5/bq53rhVn3muIOlyz+Gio6mo/nBURI34MpleWTjKwgop8l4lXhnXN
 ceUHG8jSRkuaqHoW26MFhP++q/e2l/wTkUlv0LV1JgvYHedpghLGqqzdKaDBWCfqbGrwCwhDq
 FNUTwc5CBOrat7xEFka5abCeGrkJi924K4GHuMM5xt86UIQqlbaYMvweEM1tt2H+Gakj0cfyY
 PyMBVJBzaireVb7QPHBgzRrA0ovb2IX7O9Jg0Gq1X06Oa2yOxpKkdwI4eoHMWLd7Yp8kjhwRM
 w5PmTV9M9s8LQuLIbHuLj2/+pnk0E68NSBlv01+3ClcsRbqZC8RxLsL2I5OAufXZWrvwfyqIq
 tlml0doHz8jvvHNndpHyk5nNh7o41X89k6PMIOytH9RoCs1fWc4y9Bw4wIUw3naL8EjHm8dUm
 RldcIuUIOSk3M66IaTy44d+udvnSolhGpY+jMidsfmZc6Z/mmFMmrJQRYOY/wUcNoAQgBkk9j
 ttXnxiTls1LjH9fWZq/dKCF+PEmkkBhop1MdwS3UF0hKSDsnzn/VIClpaUdByA9qD7dUHPSQf
 nesWk5MdYojgyXNrJxv40TQcN3ncsF5tYcYpMtEjfq36d2I8UX2c9veYMIR7Zd994pcnOgI2Y
 O/n/zbG
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the behavior of the shell script version of the interactive
rebase, by using the `output` function defined in `git-rebase.sh`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index dfa4fab98b..edc213a2c8 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -464,6 +464,8 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 	o.ancestor = base ? base_label : "(empty tree)";
 	o.branch1 = "HEAD";
 	o.branch2 = next ? next_label : "(empty tree)";
+	if (is_rebase_i(opts))
+		o.buffer_output = 2;
 
 	head_tree = parse_tree_indirect(head);
 	next_tree = next ? next->tree : empty_tree();
@@ -475,6 +477,8 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 	clean = merge_trees(&o,
 			    head_tree,
 			    next_tree, base_tree, &result);
+	if (is_rebase_i(opts) && clean <= 0)
+		fputs(o.obuf.buf, stdout);
 	strbuf_release(&o.obuf);
 	if (clean < 0)
 		return clean;
-- 
2.11.0.rc3.windows.1


