Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C830205C9
	for <e@80x24.org>; Mon,  2 Jan 2017 15:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933075AbdABPfw (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 10:35:52 -0500
Received: from mout.gmx.net ([212.227.15.19]:49531 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932874AbdABPfv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 10:35:51 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M7Hao-1ckg0Y0Lpe-00x3Z3; Mon, 02
 Jan 2017 16:35:40 +0100
Date:   Mon, 2 Jan 2017 16:35:39 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Stephan Beyer <s-beyer@gmx.net>, Jeff King <peff@peff.net>
Subject: [PATCH v3 34/38] sequencer (rebase -i): show only failed cherry-picks'
 output
In-Reply-To: <cover.1483370556.git.johannes.schindelin@gmx.de>
Message-ID: <4209508dfa80b1097a1b25b07f1a723c27d7c07d.1483370556.git.johannes.schindelin@gmx.de>
References: <cover.1481642927.git.johannes.schindelin@gmx.de> <cover.1483370556.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Auk51YWiUjIYGnJbPSwKonulSVmoYBf1ShTLkiQXhi1RTl1dBzW
 MXx+G8hwngGk3j6vbVuwKiAJuqfLcbOJr5ElCMQR4CYF9LXJUAJpvKQtHxHIwm+wAMLqH8x
 npWFTECYJ22uNL/6mB3tX5Fa2+61szKt7PQBEa4wCbDJ2b0W2xIMVHnzBA23ZlWLOVJSj6h
 m4PMnc9A9BA2yV6RFU3FQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5PJV3LS5C1s=:6nljlsMsorjSHz41fUBZxy
 de0+Kc2H31EBnx/DYve8LViOORO6wzcZ6fjdQuPC9kfLnKiT6JaLe20zTjWwqCjXqq4AdB6r0
 Wo2/SDz9P6xlioOHHe4/f+4CCtaBphLz5Nv1ReythXYaJmeVElus5NFj+rglBtErDP19XcHaO
 4amBIp2YMSHYicljag7XVQHaDEY7E00WeP8UfPbn3K7KWHBSfA69KtiWqihA5Xr7L0aKUTCzU
 JioLCUn0N+w1TP940lsz4KH5pghN/51TNx7f2AfaNM0HIlK6FtDzA6L1voqTC9VHHg3h21rpB
 zbsRCLhBy7scXeO+9byGv/WJWqAHv1mqNGHtx5jCY+4vKrmuGcJ1aDfw1FDmM2wCp0VO2dbEm
 Y1PYJNmS1RcX0lxeqhToCPCVA+W2p0R/MXmxXBwNUjyxnKub0t7a6+7p+4R8BfTGPOeKiw1PP
 WLd95NzOAsK8n615lS6vGE4pThe54RiDzSAduVI/8ON/lSG5fFTTHgrS62uSDupCZeGCnXWX6
 kN49eKtS4Tk2I6Ed3IZOE+0/UJ2uhZ8DeuuqBkAurgQikXtavlq3hkZhPjSs7kEOa/NOpoZnZ
 Iwx8oMmulN0edurkMn6hHUeaKHnAWN8I5T+w+KqFXu8UcyPrU9aWgBqbcDCa/PTjsFso0LOB0
 5BGKwy/8rfl2z9kvN3+nur57WBsBTxP659SFF89NqnLOQ0/NrwhKN7eJ2d4NJSk1vV51/zlUy
 1p5736y1eP0I9IGXWurqC5wamj0EH3zFYt1cZlb9eYyxGFKVMhBufGviw8/f6XwVpO3EYvDNK
 jx6y6Xm
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
index a501dfce38..4f37ba8d33 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -433,6 +433,8 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 	o.ancestor = base ? base_label : "(empty tree)";
 	o.branch1 = "HEAD";
 	o.branch2 = next ? next_label : "(empty tree)";
+	if (is_rebase_i(opts))
+		o.buffer_output = 2;
 
 	head_tree = parse_tree_indirect(head);
 	next_tree = next ? next->tree : empty_tree();
@@ -444,6 +446,8 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
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


