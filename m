Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3298D1F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 19:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933056AbeGIT0L (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 15:26:11 -0400
Received: from s019.cyon.net ([149.126.4.28]:33922 "EHLO s019.cyon.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932844AbeGIT0D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 15:26:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=drbeat.li;
         s=default; h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0fTlcJgXgA98MvLOG6fluCOIi0a1YSCxfK1TG0/UDuE=; b=VGoY6gPllf5E5L03GChH5ZE6yU
        ZIog+JGWBsVesKoRDwff1eU5zS9Eh50JWsyJInCm0rwEdEvuFEqAWLx9O9vXJorsyQcN3MKxQJWHx
        Nn3ZvlXld4ksIeAcw1dAqVYQLgLE//dQe7WPynW7EHopeh45EzVvhuKPPwm7KByObvWk0fuWp7mH3
        seJ09zdXjWAXtvf2JmTczl9nXM4DK9r/kixpv0JuIbhcH5uh3xcy5jTrMDhUxxNEZcIRP7XIsNw8h
        j1TZXVGCzUfIkE4rDsn9/otn9QqEUGKAA/qk9hWV3MeyQgLhq9sVrxkCs6MKx4dezzCFymYGf/Sxr
        T6mXIs0Q==;
Received: from [10.20.10.230] (port=60058 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.91)
        (envelope-from <bb@drbeat.li>)
        id 1fcbnL-00Ck4K-R3; Mon, 09 Jul 2018 21:26:02 +0200
Received: by drbeat.li (Postfix, from userid 1000)
        id 7A4FD22F6D; Mon,  9 Jul 2018 21:25:59 +0200 (CEST)
From:   Beat Bolli <dev+git@drbeat.li>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH 2/6] refs/refs-internal.h: avoid forward declaration of an enum
Date:   Mon,  9 Jul 2018 21:25:33 +0200
Message-Id: <20180709192537.18564-3-dev+git@drbeat.li>
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

Include iterator.h to define enum iterator_selection.

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 refs/refs-internal.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index dd834314bd..a78b5cb803 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -1,6 +1,8 @@
 #ifndef REFS_REFS_INTERNAL_H
 #define REFS_REFS_INTERNAL_H
 
+#include "iterator.h"   /* for enum iterator_selection */
+
 /*
  * Data structures and functions for the internal use of the refs
  * module. Code outside of the refs module should use only the public
-- 
2.18.0.203.gfac676dfb9

