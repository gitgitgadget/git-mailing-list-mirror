Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC6421F404
	for <e@80x24.org>; Sun, 11 Feb 2018 00:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752969AbeBKAKS (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Feb 2018 19:10:18 -0500
Received: from mout.gmx.net ([212.227.15.19]:41545 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752949AbeBKAKP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Feb 2018 19:10:15 -0500
Received: from MININT-TB4PCE7.southpacific.corp.microsoft.com
 ([37.201.195.115]) by mail.gmx.com (mrgmx003 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 0Lhwt0-1f61nn43iU-00n7SY; Sun, 11 Feb 2018 01:10:10 +0100
Date:   Sun, 11 Feb 2018 01:10:08 +0100 (STD)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 02/12] sequencer: make rearrange_squash() a bit more
 obvious
In-Reply-To: <cover.1518307771.git.johannes.schindelin@gmx.de>
Message-ID: <321a314584f61e5d5ba94bbe704716e0f9fc336d.1518307771.git.johannes.schindelin@gmx.de>
References: <cover.1517266437.git.johannes.schindelin@gmx.de> <cover.1518307771.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:I4SI4T6l0+koD6cvxAqYCB4F+imUZoGCyb1dIl8uIGzLFQHYQbY
 FM6D3B6nfNDjFQPMWKWuFsuDjfW1f9Re//KaKT5mz0Bv19sub2jUiwKpN1VX+l3XHPyFMTJ
 JcqbDSl7mZYqicv3WeZQPsI7vu1pB0y95HlAyJKzfz8EOmhFhGMykCc0YNel2/Fyywh63jc
 JJBWv5dIyHAGB98LH5SDA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0nNMD5lLXA8=:QMEc9Et2CF6p8rNJjNHvRU
 gGfFUxrOXiDJRdBe8RtOkGUBUIXNo+Ka92u2X9kAdDFLYK1Qc0sKZf4icyL019g2P9NLYOyXY
 lXp4nLv2MtNhGrZWstYFX4X45WY0/2HCWX67oOIaGUrnZjHGffxb33bBHw9SZmjVl/E+mdzO2
 9BKUSFvmp2CA8LLQdt3e/NIiDYykrJ06sAoatCF5SsgdYmRxprEKUJROa1fiCjDNFoaTBmza+
 jWlzr6BXv2ymN/Zgs1e1ix1qvbA5L1pIjJNBUPqCtSmQapX3MDcpEgGBBsOGHmhiLbvGD8ur3
 Oi3v6YEnhUv1o/aX5m2kdAJrJPzYcHVEzutF6/cevunxM6B9sG9jc4lhQzlnvUvqVxC+YxW/O
 reSL954ML0sADjzv7ucKPHMeQ66gHrss3NYqPtp2UPE42rWMOkYO7XbfAnm3VMLLibn2Kh0cX
 70KVfN+j71G/Ehr5GL2iqQm+CsY+qSJ/wb+14hZFfR2A+wRKX9EmOsBnUMOfmIHejdEFsBrot
 4JLTgWduXmvRzkWuIzGecu+E5137WxclAAFFSn1QlGUnoGHKy77roWMDpOaQWUeYeoxiY2azA
 meSMPx/gfzLjer396B03PG+fbFtvYYhybeezJfDma3pBFYPi2q69shPp6imjbvtM8W52uoYeF
 cvWUx2EsOVtjE12XW55kn3bMFb7K+P6NMnzzv221HrXWr3IB05oXijR2TflwXWs4KRUe2GBnT
 KY+JnM/5owCg9Lzx1/fsXyNS7jWEa4AAAiB2IPGXgYhvXPhWHuWTHbrWSosRToQHQX8RdxOPX
 fESsv2YZkrLHaY/eSOI7mEwtEtSf7pvbuGUegGSzoCWaJ9GP3k=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are some commands that have to be skipped from rearranging by virtue
of not handling any commits.

However, the logic was not quite obvious: it skipped commands based on
their position in the enum todo_command.

Instead, let's make it explicit that we skip all commands that do not
handle any commit. With one exception: the `drop` command, because it,
well, drops the commit and is therefore not eligible to rearranging.

Note: this is a bit academic at the moment because the only time we call
`rearrange_squash()` is directly after generating the todo list, when we
have nothing but `pick` commands anyway.

However, the upcoming `merge` command *will* want to be handled by that
function, and it *can* handle commits.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 114db3b2775..764ad43388f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2890,7 +2890,7 @@ int rearrange_squash(void)
 		struct subject2item_entry *entry;
 
 		next[i] = tail[i] = -1;
-		if (item->command >= TODO_EXEC) {
+		if (!item->commit || item->command == TODO_DROP) {
 			subjects[i] = NULL;
 			continue;
 		}
-- 
2.16.1.windows.1


