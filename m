Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A8121F85A
	for <e@80x24.org>; Mon,  9 Jul 2018 19:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932967AbeGIT0E (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 15:26:04 -0400
Received: from s019.cyon.net ([149.126.4.28]:33888 "EHLO s019.cyon.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932798AbeGIT0C (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 15:26:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=drbeat.li;
         s=default; h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=riCUPdWnbi7m6QZoXCNRek64xhRBUXyw38jWmWOTZ5o=; b=vCPEd8qX3LMr2iC+YI0P7lN6hk
        u0Hxut/vCUoqCjUItkkl7/0vcbWHc7Jj+okBPNEQJNcyehbBWer2U67OQgE6DxXHIhs9EWpnvpNC2
        2Pei/7zc5zm/A5KGrew693tcGl10v4NPsF2j5knGMUfS5sPbxq9KiXRnF3fdsuEL0z+Pj/48m9qSi
        6yK70QFVQNUzkWIsb9+93I1thkQdzYA/Ll0iF2JQx6e1z+CECG/tlUzD5ymW5RJeN7vTBSPK9hHeN
        1u9/flKHVMSPuzQz1Fbvp0ymmzz1NyxZmUbU6bK/eIB2hfu0DQDZ6xECXyBuPk9MatOb0s4V1X0QM
        gm/MnOFg==;
Received: from [10.20.10.230] (port=60052 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.91)
        (envelope-from <bb@drbeat.li>)
        id 1fcbnL-00Ck4H-Rt; Mon, 09 Jul 2018 21:26:01 +0200
Received: by drbeat.li (Postfix, from userid 1000)
        id 7768722F27; Mon,  9 Jul 2018 21:25:59 +0200 (CEST)
From:   Beat Bolli <dev+git@drbeat.li>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH 1/6] connect.h: avoid forward declaration of an enum
Date:   Mon,  9 Jul 2018 21:25:32 +0200
Message-Id: <20180709192537.18564-2-dev+git@drbeat.li>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9
In-Reply-To: <20180708144342.11922-1-dev+git@drbeat.li>
References: <20180708144342.11922-1-dev+git@drbeat.li>
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Include protocol.h to define enum protocol_version.

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 connect.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/connect.h b/connect.h
index 0e69c6709c..c86f862f2f 100644
--- a/connect.h
+++ b/connect.h
@@ -1,6 +1,8 @@
 #ifndef CONNECT_H
 #define CONNECT_H
 
+#include "protocol.h"   /* for enum protocol_version */
+
 #define CONNECT_VERBOSE       (1u << 0)
 #define CONNECT_DIAG_URL      (1u << 1)
 #define CONNECT_IPV4          (1u << 2)
-- 
2.18.0.203.gfac676dfb9

