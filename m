Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F49E1F4F8
	for <e@80x24.org>; Fri, 14 Oct 2016 13:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932802AbcJNNUN (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 09:20:13 -0400
Received: from mout.gmx.net ([212.227.17.21]:52974 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755834AbcJNNSK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 09:18:10 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LhjeH-1chaY03RM9-00mutK; Fri, 14 Oct 2016 15:17:57
 +0200
Date:   Fri, 14 Oct 2016 15:17:57 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v4 10/25] sequencer: avoid completely different messages for
 different actions
In-Reply-To: <cover.1476450940.git.johannes.schindelin@gmx.de>
Message-ID: <21954fadd458bc4dab27e9eb6c31c29bcf21191e.1476450940.git.johannes.schindelin@gmx.de>
References: <cover.1476120229.git.johannes.schindelin@gmx.de> <cover.1476450940.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:tWlZFHbDSXkD2VR1yRrZmIY6oay2WVd8Y9X3YacRm+JQBtaTkTR
 Qk6NB39853zh4jEPOPU5qVhvfK77qpsc0rMVAC5nrDisRmSUzE+aOuDzQX/OkqPBjH2AhDg
 zjwjvU0z1l0TsNoG1hgulGoV6ViLo2ofUweU6zwDLO/QsEb+FDKiTLOZhcrLNkjVEFhzpfc
 PUEmf0fGJabwrLfnSIQFg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qqrMvFmJxoI=:YEB4LgPVNSAmCnMZWNVFeY
 Zg/IEsANwG4pCUYTLMXiuMM0eNP0+QMIiXolgjVKYcsivYCWk7zduyKo7CPTNLl+b9Sd4uM1e
 NUyNp7MwJCu3b8IAp63vhhoynTAwPooBOP73QPRCT2RV0XUVVcASz1KSk5tUEWZwhR3PX51Tp
 phGmx8BCxoe70LiSbfGt75XOqQK2y6RIBsisWuNhDYy9cSRpy2sdeQI+WcaOmNjk8GEl12cb4
 on7DEjRN0uTQ2FOOo7uazaSPtylyLq2eWuvBjU4ekx5JzbyNv4n0Cjk3yA5Od7A6hFueRbGr3
 rztVsILr8DMvZiYW+VaYhWwD34khiLQSE9UViX/i0xr1wxNi50MXNbGQVPjm1CwE2lMv0LaGs
 C5K3dRu/FHATkBPP0UmEdPFC5ocojaI6+cHkWZVpJmCtaAzh9J/hLEEnFZn20n1xU8I4dCTgF
 aA+4ij6t08Fcul3VL1nhHCk4Wb/WN0Wetxc8y/Lz0w0uVEPKreIctYmbljEeFoOjDc57zI5PQ
 MZms4KYnSiDcDOKcRdqTUUVZnqp0k0GAIFJ8OWPKUdoxDw8NEcjLv/2DeSOXF/y7RlGI/Meuf
 cdBPMVCLpgOg8iADKF4PnwSLMpSGV1h6GMRdGMIHsrV/8OfODprMouCnw/uy+pdq3u2IXcjES
 riGFlVJBzxQZ8IR6pI5ZKzk3/OnNpEOvSz2AWc3EVbyxmwDp1M/Abb+dU2jzGk3tdwmUP9JwE
 tDvqNKYH3X+qwaxGvO43eGcc4fjtkQB7gR6eQCF29M8hoIfr/D51V4G80e8mroqnhgRtW/41A
 58xfdcj
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index eac531b..9bca056 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -229,11 +229,8 @@ static int error_dirty_index(struct replay_opts *opts)
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
2.10.1.513.g00ef6dd


