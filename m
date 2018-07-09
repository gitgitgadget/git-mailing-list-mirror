Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 911B51F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 19:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932923AbeGIT0D (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 15:26:03 -0400
Received: from s019.cyon.net ([149.126.4.28]:33880 "EHLO s019.cyon.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932633AbeGIT0C (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 15:26:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=drbeat.li;
         s=default; h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=sesXThuiDYD5DwcUk9sATon2Jgm/XUffiGdUunukNK0=; b=YjFrifwwaEPZUvapGa31lN4wTb
        Xezi3HUDNxQQAD89X7ovWSyc4vigVQ76V3cetql5wxivMnuy99Zo3HpXERrF9MwtHAXPjpq1QMRp8
        h9s8JOSajNfZwL3jt1x6fBMvBd68CIOKUTbviFueMxa7+KTu1aanBbzK9VjewUMthC2gYGtxQmIzT
        XvFQxQtlPBEtGBnpgpJAl/pal1rrvITOWgKunPd8SrSQ81V4G+KTkSe8B6e4+nIpjG1KXBLOnRfxG
        XlLCykDhqyusGoJt3oyqbLTpIurSNqYpah1LZGwGV3Dy7KL+irC42JQqzm4135XlaVdZFFhH5FE6P
        i6ax2Sgw==;
Received: from [10.20.10.232] (port=50108 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.91)
        (envelope-from <bb@drbeat.li>)
        id 1fcbnL-00Ck4F-RF; Mon, 09 Jul 2018 21:26:01 +0200
Received: by drbeat.li (Postfix, from userid 1000)
        id 7DDDE234A0; Mon,  9 Jul 2018 21:25:59 +0200 (CEST)
From:   Beat Bolli <dev+git@drbeat.li>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH 3/6] convert.c: replace "\e" escapes with "\033".
Date:   Mon,  9 Jul 2018 21:25:34 +0200
Message-Id: <20180709192537.18564-4-dev+git@drbeat.li>
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

The "\e" escape is not defined in ISO C.

While on this line, add a missing space after the comma.

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 convert.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/convert.c b/convert.c
index 64d0d30e08..edebb946f5 100644
--- a/convert.c
+++ b/convert.c
@@ -334,7 +334,7 @@ static void trace_encoding(const char *context, const char *path,
 	strbuf_addf(&trace, "%s (%s, considered %s):\n", context, path, encoding);
 	for (i = 0; i < len && buf; ++i) {
 		strbuf_addf(
-			&trace,"| \e[2m%2i:\e[0m %2x \e[2m%c\e[0m%c",
+			&trace, "| \033[2m%2i:\033[0m %2x \033[2m%c\033[0m%c",
 			i,
 			(unsigned char) buf[i],
 			(buf[i] > 32 && buf[i] < 127 ? buf[i] : ' '),
-- 
2.18.0.203.gfac676dfb9

