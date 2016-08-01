Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 131BA1F71B
	for <e@80x24.org>; Mon,  1 Aug 2016 11:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753360AbcHALpQ (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 07:45:16 -0400
Received: from mout.gmx.net ([212.227.17.21]:59935 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752843AbcHALpI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 07:45:08 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LlXnX-1atCGE2nih-00bHHt; Mon, 01 Aug 2016 13:44:01
 +0200
Date:	Mon, 1 Aug 2016 13:43:53 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v6 03/16] Avoid translating bug messages
In-Reply-To: <cover.1470051326.git.johannes.schindelin@gmx.de>
Message-ID: <d739dc9aa781a551d8654f5cba17f1a32c8d90d4.1470051326.git.johannes.schindelin@gmx.de>
References: <cover.1469547160.git.johannes.schindelin@gmx.de> <cover.1470051326.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Q5mZ/BBQqJ3lBlIzOhKtyBTxlPUx1i4bUb+VTzyshOk1+Sm2R+Y
 sYKrgNafvDBYzQd9A2J0ZlyAC/JY55dRdl8YXuSQoXHQV2lSo0izvfpTKsb73ErlV/Lq4YU
 30TKhGWCWILAuVvL1K245CwmoiQT4yEJ4P79PrqZs4bf3PEGSomJnErjOyrkVAbDWiReh90
 D1w4FDXdTo2afMtrIa0Qg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:ANoHSLxNIHw=:MeyxmkAcGAxGMvZObrviiE
 tyEYZytwJmEtRWJKKIeDAGsnG/2AGTtrvKAlsvImmJPZukBcJ0MGPmH+qkNnzKWeNmI5iY98L
 VRSCFOgoOjQAo/ffjNG+UhBsbWrHA+Mpb7U+fugdje0fmnF7OzkXHL5aNUDXzNtXCTsWQCSsD
 TCVsvUQNDwlMlB2DfAJ9soQVjFMhKwC1jFRjhj+2mUp+1RNlhz4MjW8Oz5tdMPRR9o7n/S8XI
 9kNhV4p/AGnJVGYJDP10Kav+iHN8vRFJfnvzgZ3m2DeoVGEi/Wx7FyaCOkZGBCv+78+zl2Fok
 DWdTDo6M1n3w4ZztRrotD60rQsObXz34qgQeoar8TgWIfzN8Zuov1PguSr7chysNgWMzzJoeF
 Lc91sB8lABAtlhMzQuxwdLUSDvtIB7ynN9Qv+T2whTbGwRVsBbee+FVpFQuRtAcERrizkqFxx
 rhWbb4PJSdou8sP7MYRrOJvsi7juCOUKPpJZDMRoVPTD4C5Lp9q1Ri+krJU+uu06dE3+K3VMa
 Dp7ytb/tMJYmRe9OiCRQ+J4pxlU8nbVZZ2LarAOe+cjYczCaV7g40GUmVykXXz1jXP0OQ01G0
 dSMxVR6S05WijQgLL4nqlk6PgvPZN5Dw1Lz0kEtMYVuQFkrd2G49wXmIWe+HLxLYsXgn/wRm6
 PxNpi59f9DWlqHM3qYgsEeAtgd9Bj5SgcuHJ0DbJ1XeO8vy9Sfginc58lPO3mITnd8fnXiiRq
 cd8+UsoY9CDoSBCZ4IBMJ0x22XdnxOLVKP6mvGxTmFlAyEANTSqnVVYy5N30hk3HNtdfqf6Ei
 gb0gx2i
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

While working on the patch series that avoids die()ing in recursive
merges, the issue came up that bug reports (i.e. die("BUG: ...")
constructs) should never be translated, as the target audience is the
Git developer community, not necessarily the current user, and hence
a translated message would make it *harder* to address the problem.

So let's stop translating the obvious ones. As it is really, really
outside the purview of this patch series to see whether there are more
die() statements that report bugs and are currently translated, that
task is left for another day and patch.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 merge-recursive.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 4338b73..1b6db87 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -967,7 +967,7 @@ static struct merge_file_info merge_file_1(struct merge_options *o,
 			if (!oid_eq(&a->oid, &b->oid))
 				result.clean = 0;
 		} else
-			die(_("BUG: unsupported object type in the tree"));
+			die("BUG: unsupported object type in the tree");
 	}
 
 	return result;
@@ -1811,7 +1811,7 @@ static int process_entry(struct merge_options *o,
 		 */
 		remove_file(o, 1, path, !a_mode);
 	} else
-		die(_("BUG: fatal merge failure, shouldn't happen."));
+		die("BUG: fatal merge failure, shouldn't happen.");
 
 	return clean_merge;
 }
@@ -1869,7 +1869,7 @@ int merge_trees(struct merge_options *o,
 		for (i = 0; i < entries->nr; i++) {
 			struct stage_data *e = entries->items[i].util;
 			if (!e->processed)
-				die(_("BUG: unprocessed path??? %s"),
+				die("BUG: unprocessed path??? %s",
 				    entries->items[i].string);
 		}
 
-- 
2.9.0.281.g286a8d9


