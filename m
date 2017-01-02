Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53001205C9
	for <e@80x24.org>; Mon,  2 Jan 2017 15:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755615AbdABP0Z (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 10:26:25 -0500
Received: from mout.gmx.net ([212.227.15.18]:53026 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753115AbdABP0X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 10:26:23 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M39zL-1cgZQD33O3-00sxRe; Mon, 02
 Jan 2017 16:26:10 +0100
Date:   Mon, 2 Jan 2017 16:26:08 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Stephan Beyer <s-beyer@gmx.net>, Jeff King <peff@peff.net>
Subject: [PATCH v3 01/38] sequencer: avoid unnecessary curly braces
In-Reply-To: <cover.1483370556.git.johannes.schindelin@gmx.de>
Message-ID: <bc1a6c21c9ab2f55882c363e802bfcf37e49d79f.1483370556.git.johannes.schindelin@gmx.de>
References: <cover.1481642927.git.johannes.schindelin@gmx.de> <cover.1483370556.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Q1Rxciy4e14YN/nxvQJ8zL9aPOb2k9AMl4lP/pyN3wBNiUoEOEy
 /QGLIzucbQZ1zmZSwes/g8Rw5C/Ty4f3st7gFN21ek5+w2hHL6Tj7DCG5VyD/J54ei/URH1
 4BbdhmnEDP9vUKIe7DwN+QzGfvQW4vXy1/i1qm87q0E2jpkEb28AO9dtzlJgFhribcYjw8s
 leZPw3BxZlVnhRXwvGTXA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0V57RlrRLwQ=:cScOMcotgRPDwyh6YMFBxL
 iXAK1zBqD7BQW2OCdHTGl5mukmfNweHyGJ4HWzjO3sfBOah5yd0KN7o+KWOW8MZz0XAPuzWrM
 78gu0OghFaOquinDYh5iTw2D/u3Z3T879uNKSU7DXxpTqQq1XS+/LIjx2lrkU8hlxS2aEpwEe
 2oVlE8QgTLLMVbptRRPDW/jrMCNRSYiyB1MI4xROya5qn67FcaUnNAeWBAualY5dY8CygDzzF
 b+jvI/JdaeW8LeIQNnZ4EiTs9v7uBaOCwF4emrJ3uvUatm4tRRH3D72gHLcZXoyuNswcFlWtn
 W2HL4UUsD3rlg1IzQvkLuDeFk32TI+/FQfk4k1dwbTV7aUED2qMtvrbrnxg7ccC+RV7PDxOfS
 qpPCB6uhiLAANaqtqI3T2F1asuj3mZkxSsPtLlhiNb0H+lFIYVbPlBYU6wkD6qLqsLhzlF/oL
 JZbtVI0xGhtivnW7NWeY7FKATwTpZlSavPok/eyZvEIUW3pGWCwi8JeXLZUVTjKb8zg8jDrBT
 9+ZzqitRxfn8BQeNRmm0xthKaqhsMG9jdKXKq6V7B4gifumAJuF2KRmeoZb/JeuvPwHUWY+C5
 fYfviQWk5Qz65bjfPj9XUlAyhBCv5OjAOt7ZhBOiJkya95ufT3vcQCecryQFurwc4itBaXBGo
 bETsPQX5zYw/9HOzN5/nFGiZ4isRSZ/kRs25ul29VGHvTCG6kWu2XQ/0EDA16XIbkrzSAebdf
 uinhX4HNhp2dc0JVm2IJxjqUjx2D0M7n43qkQNJq76Q92nWPeIivnigBd/XOm+AHcBZ5YMs/w
 oHc3X3V
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This was noticed while addressing Junio Hamano's concern that some
"else" operators were on separate lines than the preceding closing
brace.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 9adb7bbf1d..23793db08b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -632,9 +632,8 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 	}
 	discard_cache();
 
-	if (!commit->parents) {
+	if (!commit->parents)
 		parent = NULL;
-	}
 	else if (commit->parents->next) {
 		/* Reverting or cherry-picking a merge commit */
 		int cnt;
-- 
2.11.0.rc3.windows.1


