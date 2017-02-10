Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B750C1FC46
	for <e@80x24.org>; Fri, 10 Feb 2017 15:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752180AbdBJPRc (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 10:17:32 -0500
Received: from mout.gmx.net ([212.227.17.22]:60150 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751370AbdBJPRa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2017 10:17:30 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lxt3Q-1cNiFi0DeG-015LA3; Fri, 10
 Feb 2017 16:10:42 +0100
Date:   Fri, 10 Feb 2017 16:10:39 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] preload-index: avoid lstat for skip-worktree items
Message-ID: <a1297b9426e7980f41e9e662fc0f30717c576c3e.1486739428.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:gTgzMZH54PRtWr0dgt2AbWWPKFIwrSUS3m+n/K4mor2+AjOMRST
 lbIzzRAP6xB6cC5xmi4O9GwuRhxffxebuFXfgozH+hmvGrDsMSLhienKe11GwOgduoIRz6E
 vhmYtQiSUOaWm6O8rURRwGL5ZPABHWIqOHvFh3zPzMmuRu+Ys9xQmyDwRkBfSv0yNl270lo
 ctKgZr6rg1lp4jq2HPyAg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:j+t2bmTj3cA=:AidVBKsjv3GVolIymeOtVa
 b4lVQDRtsLGp5ItYIwEyRUHYqxmoWjpj3VGwIiZE16hvZ/NiGoLPBU99XbtHByJHZ27u6wjUV
 Gaf9H2saga3ET60KVKqHT8rFYgLC/RzNpfFtQtCeS14kBvjpR+JwDLYHk80lMJ47LowFxiVbN
 Ln01Jc6ojyX0jENRp4qwkaufrep5q18ijeKdAOM2rfDxb7iJLY6CZ2GEXiCUfj2uAjjaFoQwt
 zzb89LXTmHcpleQw7GJO7g7zzuxjS6lxFQ34Rg6Kl2Yr9SnV2YDrSbT1mmelUwUHpgQhITnq7
 /YpvyzWSyObE/f+OFc99AFBMgm5Q9il8ChADfA3U7rxKR/AZp4qk2Ar10NgsUgfr76qiwfIfm
 Nt3VnUnK4+4ENIbQ/ZVQSLFTlbn9vb90Foh2KR5zuCZRdQXzNW1DJOG0U3g3Vdpc0oN6mL3nJ
 PkGdZoe1WnAAjlE4UFBHo5hA2wXy8912s8u5cw3tpY5rqerRhcJkfHcShhc4EL+qzpC/o8HQN
 P9sraf7TONLDFlUwQ8nKhfgZc/1fNyw/lXz9LBvdkElCWnC/dhANR4ZlTd0UPPKjhXoZXQopV
 7eOQXU8s//5MB6/KVbgROPaGTA7DD8sOF8uMnXuISPiTwItJOBetWz0bP2CZFE6pwDn2NlKWH
 F7u2pAetBoz+knGPRnA8mFGWJvA3Xl1MSqO2f4ta44yIZ28i2Ha7/yOZxCEtHFpCXxfZ9znEG
 AFnVPJfJOghQZWHQ2GxvekY4x91U0Lmv5bOMtHuOjnfDXIqBwDGZju9AavOxy227PgjZCY+Az
 cm0O+5AXhLSYV1zzFPL9BqI26gGxF87vxtNM5lDE5r8OaQEt2rruXWnZgnfuLbCrSTjrS1McW
 VZwbk77ZWFjVJCnUwAfDp+1swsrnPiVSrHbIiJwhnMmL95U527FsG0gTu+SGfTOkRaDU2w1Cu
 W7PVcZS6yY/I5fafh3GkWSjxfWKwvW4StmZYmolm/Hs/tvyUOQWgZ3+fGB49dNBacdBb32m7C
 xz12uf7FR8nO5zadIYACPE1XIsVe1lOVzfyiJOCXOFpqYOd/SQdCyFgQWi+Ubq7MLw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach preload-index to avoid lstat() calls for index-entries
with skip-worktree bit set.  This is a performance optimization.

During a sparse-checkout, the skip-worktree bit is set on items
that were not populated and therefore are not present in the
worktree.  The per-thread preload-index loop performs a series
of tests on each index-entry as it attempts to compare the
worktree version with the index and mark them up-to-date.
This patch short-cuts that work.

On a Windows 10 system with a very large repo (450MB index)
and various levels of sparseness, performance was improved
in the {preloadindex=true, fscache=false} case by 80% and
in the {preloadindex=true, fscache=true} case by 20% for various
commands.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
Published-As: https://github.com/dscho/git/releases/tag/preload-index-sparse-v1
Fetch-It-Via: git fetch https://github.com/dscho/git preload-index-sparse-v1

 preload-index.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/preload-index.c b/preload-index.c
index c1fe3a3ef9c..70a4c808783 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -53,6 +53,8 @@ static void *preload_thread(void *_data)
 			continue;
 		if (ce_uptodate(ce))
 			continue;
+		if (ce_skip_worktree(ce))
+			continue;
 		if (!ce_path_match(ce, &p->pathspec, NULL))
 			continue;
 		if (threaded_has_symlink_leading_path(&cache, ce->name, ce_namelen(ce)))

base-commit: 6e3a7b3398559305c7a239a42e447c21a8f39ff8
-- 
2.11.1.windows.1
