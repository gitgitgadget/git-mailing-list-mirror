Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC7AD1F424
	for <e@80x24.org>; Sat, 21 Apr 2018 10:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752578AbeDUKgA (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 06:36:00 -0400
Received: from mout.gmx.net ([212.227.17.20]:42123 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751496AbeDUKf6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Apr 2018 06:35:58 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LZmd6-1eiVwS0Apg-00lSZT; Sat, 21
 Apr 2018 12:35:52 +0200
Date:   Sat, 21 Apr 2018 12:35:35 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v8 10/16] rebase --rebase-merges: add test for --keep-empty
In-Reply-To: <cover.1524306546.git.johannes.schindelin@gmx.de>
Message-ID: <3e490b44d2e745dbc8bbb1a95ef17ce1252052c0.1524306547.git.johannes.schindelin@gmx.de>
References: <cover.1524139900.git.johannes.schindelin@gmx.de> <cover.1524306546.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:QcQS3SePTkUs+HP3LZHKV+KR1RNL0clh+ipKyVTargghe9UCA5F
 WsnFH3l+SE2Rzed/VqCSWnOoSrsTcLqU0I4tgBhz7IWkiz8s+07yqIiG5+fb5yfMeXR6h22
 9Grw3x5PgLNeLa8NU5eeBzqnNSdqq710apg+kxhmcEkWqSBJ5eSaJ0gSmD0lvm+WQscWJIP
 gW6Sot4pnAzfy9KDvPoXA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/TqpvAQWnKI=:c15GeI05hwlQSVYY3W0gy/
 VM9M4f4tCAmtqj34nWNuozxKYeiDbEFXdrosV4R03h6vt90nHh+qU7E7OwJ46vHzUWY8N5dsP
 EkrcQ1HZmUUZIdbJ9RULcV+PRt+3lRkrydE0W2tEFcFOgbQk6ZD9DqkDdSVLhCoSwRYOTsSOS
 fehq+R9M42w1mUvaKNfLOnG1ToSMCMoVRK0YgaOdpXAJTyPo/m4yNMC4Nx+mDVXRCWmwsKP/P
 d4IqaMaPT0WtyMt5jgcERRQ0+IIvESFa6zkgIy7RLynjgN4XkZEO/wBHladphWBXLafuC9/a8
 Vf03lii3Whle2kPKU1hHKY/Kk0L7LoJgJE6vnSWkeu7FMDwefqPOTmwMmWZEKOd3XjUfnRJZG
 0LFzuL3CCGEZEVkQgSaIgP1JiM7UtJLXGOBs1zh/IYb28GBI/C1IO1QQ3AsvoO+ZTEWgP4yUe
 idZzJViUJDCiJRk7zVsvl/U9C2khke0G/NcbaAOrCqKyTwI15SxAnnN0r+/UDpn4NJBOXte3R
 KU17w3+IP/SjfPtgRMVDEO9FfZKBz2m/Cj+mRz+RFOC/dSTjqVjwd2G+J0zZ4Zm6VjH0ClXJ5
 JV9pznJSzPuXufune7+tZeBTPjKUwK3ZD/CM+XIKXzxXcCYBIUMBM0AuaHKSAeMmsYvAWiJIK
 FBCtU/yS+Yuj8T2zZ+BB/JohMFm8eacjl3WyX5j+OUFHp0ybUPT/UqiXi+ffswCmE8MY8Qdcg
 O68o924J93j+2JnpwPSqEW37qomKDdPkriS1BcGGk1blG5ur2DgQHZGk8NVhpsY7HNX9sjbLR
 4m4UUWl8tBWxUJLveob4fZUo8s/vSqPMVwBW7XPeM/8TnzW0xc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If there are empty commits on the left hand side of $upstream...HEAD
then the empty commits on the right hand side that we want to keep are
being pruned.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3421-rebase-topology-linear.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t3421-rebase-topology-linear.sh b/t/t3421-rebase-topology-linear.sh
index 68fe2003ef5..fbae5dab7e2 100755
--- a/t/t3421-rebase-topology-linear.sh
+++ b/t/t3421-rebase-topology-linear.sh
@@ -217,6 +217,7 @@ test_run_rebase success ''
 test_run_rebase failure -m
 test_run_rebase failure -i
 test_run_rebase failure -p
+test_run_rebase success --rebase-merges
 
 #       m
 #      /
-- 
2.17.0.windows.1.15.gaa56ade3205


