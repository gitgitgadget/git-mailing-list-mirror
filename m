Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 463C71F51C
	for <e@80x24.org>; Thu, 17 May 2018 21:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751530AbeEQVrQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 May 2018 17:47:16 -0400
Received: from mout.gmx.net ([212.227.15.15]:37179 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750924AbeEQVrO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 May 2018 17:47:14 -0400
Received: from virtualbox.mshome.net ([37.201.195.106]) by mail.gmx.com
 (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0LjIit-1eh4Ng40mF-00dUcL; Thu, 17 May 2018 23:47:08 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH 1/1] config: a user-provided invalid section is not a BUG
Date:   Thu, 17 May 2018 23:47:06 +0200
Message-Id: <7559f3e7e1e5858b0f50afd53da5aafb683b9828.1526593623.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.42.gaba71d8cd65
In-Reply-To: <cover.1526593623.git.johannes.schindelin@gmx.de>
References: <cover.1526593623.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:zgGUs+UcFaAd7lf/rh9TzUSsG+CanUHD/QlyorMWfNkBwO/AN2t
 VW49sEaNJwZ2CM3tplt2okYgOA3jm+Kyg98dxlU8IeZMRvlfZ814zaigfwjt1rhnoRfyxTa
 a9uSdWe7ZEPsLf5aGZaWYYT3ohL4ZRMzFUjebmX0ATD2ebHKesl8179x1Ph+LdrE98Bzir4
 8zAd2/a79SMxJUdzGdaEg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ulXgEtF/XB8=:+pXf96lsKHBiI/nC7laFhO
 jV6hYfs4s8WRPvQxA2cxkWqPyfh9CPi6i6IuyU0kX8GZmcLUVR75DEWWgQ4YFpJerszP/KWsn
 8kDPbjlSzW2lSaa37tQAaIGMWZ/4HdL64TqRNt4o3U/j2CrIGq4m8sALxhTMje6MLfBRBAUI9
 TWiBilDb7qFBDWIJLjMJ9U6Q7vQhGqnNJ8ped+h3Nf2YGlCgzHof1OzriQRqzixbP/JNe+BQI
 0IgTIOzj4y3MQpxnyS8BePAV2YdMrYTssZlsuFJRBomVnweWurHLKfxPmNCTtAWl7VdU5nPXo
 QbdvzU0LkUhdbWsvkzZYokhT7qZZpYCVE0/s4AUk2EarOwbdRgaBuQhkLbkK3ifltw7NLTpt+
 iuAiS6sIpLxbmfyScvo0+7tRxkBGxtUpCOUUv8ArGc6jmGKq2+XBp/vWe8SECqmuzYN18LTC2
 i3oD2D9Bs6xoZVLTBFTyyzglgJP8/nif55qvb9x2PYITu0QhrQm5sgduixwdLg5Y45xDVNF0s
 F/lC2EdAvm11gdMt1RePL2Z20vVXGBgMfSx4t4E1ixAttr6Pt3W/hDEC8U7PYyfE5A3s5YC7M
 q9tVuKEyTVU184rWbVAJ1hs/D5Mto0E2GkNBTMXlx7j17ZmG6YjmKRTkTcRyFaEU/jpPcP61g
 NqPT6GtXB9Hh8c7GbnASCJ3W062srKrAlsDfngx91uUaCH7C4arh1k2CVijVoiqzOJx9FKKNI
 JV7prScdJCI2mi03bJ/x8JGdpr4DGIoyW7qzQoKfSPrXCNl3MK/UnfjTsmFi+cwK51ftOLMpg
 nrXL8LD
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This was pointed out by Jeff King while the empty-config-section-fix
patch series was cooking, and was not addressed in time for that patch
series to advance to `master`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.c b/config.c
index 6f8f1d8c113..2392a8076b7 100644
--- a/config.c
+++ b/config.c
@@ -2359,7 +2359,7 @@ static int store_aux_event(enum config_event_t type,
 
 	if (type == CONFIG_EVENT_SECTION) {
 		if (cf->var.len < 2 || cf->var.buf[cf->var.len - 1] != '.')
-			BUG("Invalid section name '%s'", cf->var.buf);
+			return error("invalid section name '%s'", cf->var.buf);
 
 		/* Is this the section we were looking for? */
 		store->is_keys_section =
-- 
2.17.0.windows.1.42.gaba71d8cd65
