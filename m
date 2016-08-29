Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C9232018E
	for <e@80x24.org>; Mon, 29 Aug 2016 08:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932609AbcH2IFm (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 04:05:42 -0400
Received: from mout.gmx.net ([212.227.17.22]:53396 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756684AbcH2IFj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 04:05:39 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MZPer-1bPcxv40lB-00LEph; Mon, 29 Aug 2016 10:05:35
 +0200
Date:   Mon, 29 Aug 2016 10:05:34 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 10/22] sequencer: avoid completely different messages for
 different actions
In-Reply-To: <cover.1472457609.git.johannes.schindelin@gmx.de>
Message-ID: <1e940c58329ff5f224ec5bc48927a28ff4d1bf66.1472457609.git.johannes.schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:z2NDtoQbiwYvEdgUrta+FK11KnZiGyl37CejxWICCn9M59Xz/iS
 yN8ggJkEEzIVjr0c5zYMJh7UKN03p1uq7uND+EaD5ub/EABxe/Z+r9PSzb/r3TK+Tr8YcPj
 njKGMI31MAweACOd5jCqL2tfk/ohdZus+IOIz1SU+jjDsmAsqehTHUySAfF9AbDD4r+2ghU
 HA/5aFAhfJgNkhvl4HWNQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LsFZ6uL5Zrg=:UsVdpt8B+ibt+17SV/xgw6
 EQ2xLib9KbptxaqPQiWWGJZkS0/IeOT4UmiTYwhzZSU6xWTHUKZszHBDIOpfGnPE4cmrM64jJ
 noHUbLEi1Ks0FjWbaWxDCorspxA9Ny4Tki2gFRYRecX8y25fGMRG06PwcjfBHPzZbPUOOOjpj
 35X5BhnAxnTeLVMgAhc5da27mLwjyIvtSokJqKE0Xp0vr3m28wztql177/oyuX7KztEh8kxYf
 zXkCW+dxALx5KRqiVHC/82SIIt1ztrAh5x77VS71AoHxDTh3TkJIL5p/X1yHlYfWZNURVqzoh
 xtqOkj1dDh0oW08z/s1WreHciqBHXnSvEy5c3EO1Hp8rIfC+1pB8AUv0ldQFcr3zB/wyCRB8i
 Atxz/h+Q2jEIu/fqnbAPjBS13zN8mHMJmJCsMfU8AWi0ZI0KGwySDlvIIvX2zwQpEAUk5k33+
 YDnVspvUqcVcIfEPFwMJRcJfZVq2q+38J/lrKXsXcxq9CAn1fxskKypyfxlFqwNPkJXTjW6Yn
 lBma9s5lGIgXFya5BXAnPIrDE0wvWTK7qQG89ouGQI5zFOgvvRUska9oiaA2PzzdV9uzVopO1
 2JuhAGGziUR5Q1rKm1iijV7ddkYwPoGmWJcGRrukESZY5Ab8UBZE6TLl98J1uE940OW2y8OXB
 jraKxema1aixDmTq8+W/7bNC4ltU9121uEwuLQyrHHj+aBaTdAE0SuHdXJ1uwBvpVNG3/MbQS
 QM4UcYFBPQ3i+xBhFuIEk3/czib89DOGnq5e0/K8bl7Ujmz7yvE0UZqW9ZuV5DpkfbPX2ehbR
 ZhHkOzJ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index cbdce6d..1b65202 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -232,11 +232,8 @@ static int error_dirty_index(struct replay_opts *opts)
 	if (read_cache_unmerged())
 		return error_resolve_conflict(action_name(opts));
 
-	/* Different translation strings for cherry-pick and revert */
-	if (opts->action == REPLAY_PICK)
-		error(_("Your local changes would be overwritten by cherry-pick."));
-	else
-		error(_("Your local changes would be overwritten by revert."));
+	error(_("Your local changes would be overwritten by %s."),
+		action_name(opts));
 
 	if (advice_commit_before_merge)
 		advise(_("Commit your changes or stash them to proceed."));
-- 
2.10.0.rc1.114.g2bd6b38


