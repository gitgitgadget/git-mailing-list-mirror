Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B77A20323
	for <e@80x24.org>; Wed, 22 Mar 2017 15:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760670AbdCVPBq (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 11:01:46 -0400
Received: from mout.gmx.net ([212.227.15.18]:59561 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1760627AbdCVPBl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 11:01:41 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MTCDO-1ciZ5x2gic-00S7lQ; Wed, 22
 Mar 2017 16:01:15 +0100
Date:   Wed, 22 Mar 2017 16:01:14 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH 0/3] rebase -i (reword): call the commit-msg hook again
Message-ID: <cover.1490194846.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:SlKwzC6DbKmBazjpM9rbtnOW5Ub/Xmx2djsWlJeP365qs8wxF6U
 1HeqxmcRVsO4iMrJhDDzvS4PCXGdyu/trcFczHFUikkGiGvcnWyV61CFL9Zlv3Hhsp9WMqQ
 /zlvUmwvoP+azyCwod4+w1KycPdmNyxZUkWtlnHzI8CFDdIaYEHw8XDh69zkS163wpsjNZx
 IOhsu5Ps+p27pQRdndS0w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lXosRSQ71ug=:OcG9nT1c/lT9p4pkOWNC62
 5qZw0DZt+DuEbzLY3fuYb2RMwgd2rwwT5vFe+qGaVypXDxzP7a+cYnbDbNs+QZ4QBf5Yy+G2F
 oaGqlqlOkWnuMAf5AIfOfX7JoE79Pd5csQiXMLcOtn15Mz4pCp0KC0F+Yfovnqhtz7WpvWb8Q
 WpvRUCmlHzBaAjWqlNpAlihs2Awsvbu/p/z+LfwtRg741TczgIWMRfAZjnDJkypeCwxxWptb3
 KeK8a/codmaGFlxUN+u0uIgQTDEn5J5bXZZSDYvZJPgb1Ke7K+2y4Mtuo0SYRRNbz6TSRJUcg
 I3x/pUCVhzW30l1KEja8giXGlVFZDGwEIU/LSwgozvpVl26Szb+kwsvg+BMgpjQREdyVhXmKz
 d0a1kO0mkUeo1WMl52VSTEVzxnNFu+yqRc0+mqpEx2sqXbRSndZkugnNVqqJwidpPMTW9H0Z3
 ZnTaRGNjE8Kyz3jEdOVZKnZ8HAHXG2L2OITye/oiIqzFvPJKWfSmD+jb9q6tb1akslGOTkB8j
 cfoCKYFzYuv2nCpXpnNllYZ/ZTxCdyXmQtQnq69eqgALwyDVXhj9R14uMR15GBSTuu2XqgG3c
 64HYWbg5h2YnhPXt2ThoTOKPdk6We3RNQzSgB0RMIzDg1zGkdSI434upsE3Ja28rBsqCJKpdA
 qfzv6Pbt37ccbASSR4DdqHjj0SxvrItM/mGwgBVDZbUiGgefsloHODl10C3z5f95k6LMlbGKn
 aAtbxJZIZxPkXTDiG/b6xE8UcMMRLc0p/gjVVLXQieuecBqP8bxvR3u316nXXdj3nz7aXuSMm
 IlFwiAgo1K57fcCEQWxuXmzwlbUtw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is actually not only the commit-msg, but also the prepare-commit-msg
hook...


Johannes Schindelin (3):
  t7504: document regression: reword no longer calls commit-msg
  sequencer: make commit options more extensible
  sequencer: allow the commit-msg hooks to run during a `reword`

 sequencer.c                | 58 +++++++++++++++++++++++++++-------------------
 t/t7504-commit-msg-hook.sh | 17 ++++++++++++++
 2 files changed, 51 insertions(+), 24 deletions(-)


base-commit: afd6726309f57f532b4b989a75c1392359c611cc
Published-As: https://github.com/dscho/git/releases/tag/reword-commit-msg-hook-v1
Fetch-It-Via: git fetch https://github.com/dscho/git reword-commit-msg-hook-v1

-- 
2.12.1.windows.1

