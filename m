Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14EF91F51C
	for <e@80x24.org>; Thu, 17 May 2018 21:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751061AbeEQVrN (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 May 2018 17:47:13 -0400
Received: from mout.gmx.net ([212.227.17.20]:60893 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750924AbeEQVrM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 May 2018 17:47:12 -0400
Received: from virtualbox.mshome.net ([37.201.195.106]) by mail.gmx.com
 (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MWkZL-1ema6z13IR-00Xv1p; Thu, 17 May 2018 23:47:06 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH 0/1] Hot fix for js/empty-config-section-fix
Date:   Thu, 17 May 2018 23:47:04 +0200
Message-Id: <cover.1526593623.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.42.gaba71d8cd65
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:YrNYOwxmEY3R+wJheP9uZ7zZ+/Q89H77SLunN8f9j3hmQC50FFZ
 u8ee7mtSSY7oQWWrqT4yis2z5w0fWXmnFagWcLs42M71ZxxXXNZN4XsFrmwvU8/W778NlSO
 ie6/kN5Ik5lernRIpNYVO2HyRo1uP0gar7tAZulhl+HJBdphge67gTuqcD2Fh1qqV6vApAi
 kiJIYEzM2ay1rZMtrmWtg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:upJLoTNR6MM=:HAF8kDO50V7FBhcbG0RKdS
 H3nE1L43JHYIb88eN4zBa1EYAt6B0isFdvMdDG2sV7Y3rFfEYdLT9uUJ9pqi0rFE80WdXKjrA
 WngeO2SGs/lgpmaM+e2Wzy88D7+UZVUfAd9b5dhqidt3Z5MckLUfhZSu+kpF940URvGuO932n
 KxB6yOEhrAeWkQopJ7FW5b6H9E+gxp6z+ulU2ufCaMkBB+XYbfmq2smWtC6ipZMGft5UULoWB
 UFR4kgLnQkcTZhhmKx3zkkGezwuOvN+b8C3yO6V6uRgvHMGpQWk5wyfGo5mHaUVetQsvy1IGG
 M2u0xX5WQIV5wkuwa+RIzPPdiTVfvBKU6VGP6n7WQHWI1/CNnzYmrIoOY/h2MxHKcFB7ysQFG
 ZwTTosofM1A5bMtnGkJHWGEIkeMb/cDqzf5+I/K1CYsTNqnTe41m0aALW+m2BUvPnj2TFb+Zt
 oJilxtX4NXcUjdPn12FQVTG0u2aRbmOxWpquVTsoUNU0GGPFs7Dj8sO2zB48Wgxmq4Gw1o3bp
 61kw+h8ktmDnJPJuKFCM1gkxDzJLHmPZphu97SxO04JZhV0qypbUJDJBvECT/Z5lxEBjbtBc3
 8I1j7qyanERmPTuZOM26hkqCTLVpzzirz/BHEWZObSrKl4yvTj4pg9gDhdpNuV76T+1/KclNn
 1cjlvBBe+0HnYMFkWYTrHGFaQcWAqhsTk7ptKddbVIb2Tw2Ns0F0CIdXOm6xzSkw/QA6hp6xh
 wLWuIba20lPmskMqwSdYHjrzLnkCvc71owRTahfABXMK3JJTOtCPnXiHFJWwi1Cxojz+wxJwz
 DkkLlOz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In https://public-inbox.org/git/20180508134248.GA25513@sigill.intra.peff.net/
Jeff King pointed out that an invalid config section is not an indicator
of a bug, as it is usually provided by the user.

So we should not throw a fit and tell the user about a bug that they
might even report.

Instead, let's just error out.


Johannes Schindelin (1):
  config: a user-provided invalid section is not a BUG

 config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


base-commit: ccdcbd54c4475c2238b310f7113ab3075b5abc9c
Published-As: https://github.com/dscho/git/releases/tag/empty-config-section-fix-v1
Fetch-It-Via: git fetch https://github.com/dscho/git empty-config-section-fix-v1
-- 
2.17.0.windows.1.42.gaba71d8cd65

