Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55461202A7
	for <e@80x24.org>; Fri,  7 Jul 2017 12:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752507AbdGGMR2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jul 2017 08:17:28 -0400
Received: from s019.cyon.net ([149.126.4.28]:43020 "EHLO s019.cyon.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752495AbdGGMR1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2017 08:17:27 -0400
X-Greylist: delayed 498 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Jul 2017 08:17:26 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=drbeat.li;
         s=default; h=Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version
        :Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=mtXKOelcyuFgdqJndY2rTikkXRiVoIsHdy2YvVvypfQ=; b=LwVP532SVtWqezs02FCT7E0QE6
        HwYYXfc0r4SPST04c1V+pzkOZtRvp3l+Jv9uIl0+9ARDHvZUPwUG8y3sWU3X4PfxWnVp0JOMEe65A
        +YPctzINYc856CYhpCKJy9sETil4kKo5DBVsziHm2RrWoX3Z/agRQIJkFR7LucQzZ7eZX8Cls+wGP
        vtVXlh8LVJ6C6DWBJXsdwsymZWPdTyO/qnLsx+Q4eYgTUYi5ueMIwGmpKCWwHP1UJDwVbzHUBkjFX
        UZ7d+3nF0RlLzo6btBIYH5Iw6tBhxgk1UCBPrIyX4CuOjWxgm2bSXIclqSCOQVpEacRYMw9baMVwp
        EpGru0eA==;
Received: from [10.20.10.233] (port=24658 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.87)
        (envelope-from <bb@drbeat.li>)
        id 1dTS4G-0003V5-8B; Fri, 07 Jul 2017 14:09:06 +0200
Received: by drbeat.li (Postfix, from userid 1000)
        id ADCDE20207; Fri,  7 Jul 2017 14:09:03 +0200 (CEST)
From:   Beat Bolli <dev+git@drbeat.li>
To:     git@vger.kernel.org
Cc:     Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH] unicode: update the width tables to Unicode 10
Date:   Fri,  7 Jul 2017 14:08:44 +0200
Message-Id: <20170707120844.18049-1-dev+git@drbeat.li>
X-Mailer: git-send-email 2.13.2.753.g7f5404b
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

Now that the Unicode 10 has been announced[0], update the character
width tables to the new version.

[0] http://blog.unicode.org/2017/06/announcing-unicode-standard-version-100.html

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 unicode_width.h | 42 +++++++++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/unicode_width.h b/unicode_width.h
index 02207be4f..6dee2c77c 100644
--- a/unicode_width.h
+++ b/unicode_width.h
@@ -51,6 +51,7 @@ static const struct interval zero_width[] = {
 { 0x0AC7, 0x0AC8 },
 { 0x0ACD, 0x0ACD },
 { 0x0AE2, 0x0AE3 },
+{ 0x0AFA, 0x0AFF },
 { 0x0B01, 0x0B01 },
 { 0x0B3C, 0x0B3C },
 { 0x0B3F, 0x0B3F },
@@ -73,7 +74,8 @@ static const struct interval zero_width[] = {
 { 0x0CC6, 0x0CC6 },
 { 0x0CCC, 0x0CCD },
 { 0x0CE2, 0x0CE3 },
-{ 0x0D01, 0x0D01 },
+{ 0x0D00, 0x0D01 },
+{ 0x0D3B, 0x0D3C },
 { 0x0D41, 0x0D44 },
 { 0x0D4D, 0x0D4D },
 { 0x0D62, 0x0D63 },
@@ -158,7 +160,7 @@ static const struct interval zero_width[] = {
 { 0x1CED, 0x1CED },
 { 0x1CF4, 0x1CF4 },
 { 0x1CF8, 0x1CF9 },
-{ 0x1DC0, 0x1DF5 },
+{ 0x1DC0, 0x1DF9 },
 { 0x1DFB, 0x1DFF },
 { 0x200B, 0x200F },
 { 0x202A, 0x202E },
@@ -262,6 +264,15 @@ static const struct interval zero_width[] = {
 { 0x1171D, 0x1171F },
 { 0x11722, 0x11725 },
 { 0x11727, 0x1172B },
+{ 0x11A01, 0x11A06 },
+{ 0x11A09, 0x11A0A },
+{ 0x11A33, 0x11A38 },
+{ 0x11A3B, 0x11A3E },
+{ 0x11A47, 0x11A47 },
+{ 0x11A51, 0x11A56 },
+{ 0x11A59, 0x11A5B },
+{ 0x11A8A, 0x11A96 },
+{ 0x11A98, 0x11A99 },
 { 0x11C30, 0x11C36 },
 { 0x11C38, 0x11C3D },
 { 0x11C3F, 0x11C3F },
@@ -269,6 +280,11 @@ static const struct interval zero_width[] = {
 { 0x11CAA, 0x11CB0 },
 { 0x11CB2, 0x11CB3 },
 { 0x11CB5, 0x11CB6 },
+{ 0x11D31, 0x11D36 },
+{ 0x11D3A, 0x11D3A },
+{ 0x11D3C, 0x11D3D },
+{ 0x11D3F, 0x11D45 },
+{ 0x11D47, 0x11D47 },
 { 0x16AF0, 0x16AF4 },
 { 0x16B30, 0x16B36 },
 { 0x16F8F, 0x16F92 },
@@ -339,7 +355,7 @@ static const struct interval double_width[] = {
 { 0x3000, 0x303E },
 { 0x3041, 0x3096 },
 { 0x3099, 0x30FF },
-{ 0x3105, 0x312D },
+{ 0x3105, 0x312E },
 { 0x3131, 0x318E },
 { 0x3190, 0x31BA },
 { 0x31C0, 0x31E3 },
@@ -358,10 +374,11 @@ static const struct interval double_width[] = {
 { 0xFE68, 0xFE6B },
 { 0xFF01, 0xFF60 },
 { 0xFFE0, 0xFFE6 },
-{ 0x16FE0, 0x16FE0 },
+{ 0x16FE0, 0x16FE1 },
 { 0x17000, 0x187EC },
 { 0x18800, 0x18AF2 },
-{ 0x1B000, 0x1B001 },
+{ 0x1B000, 0x1B11E },
+{ 0x1B170, 0x1B2FB },
 { 0x1F004, 0x1F004 },
 { 0x1F0CF, 0x1F0CF },
 { 0x1F18E, 0x1F18E },
@@ -370,6 +387,7 @@ static const struct interval double_width[] = {
 { 0x1F210, 0x1F23B },
 { 0x1F240, 0x1F248 },
 { 0x1F250, 0x1F251 },
+{ 0x1F260, 0x1F265 },
 { 0x1F300, 0x1F320 },
 { 0x1F32D, 0x1F335 },
 { 0x1F337, 0x1F37C },
@@ -392,15 +410,13 @@ static const struct interval double_width[] = {
 { 0x1F6CC, 0x1F6CC },
 { 0x1F6D0, 0x1F6D2 },
 { 0x1F6EB, 0x1F6EC },
-{ 0x1F6F4, 0x1F6F6 },
-{ 0x1F910, 0x1F91E },
-{ 0x1F920, 0x1F927 },
-{ 0x1F930, 0x1F930 },
-{ 0x1F933, 0x1F93E },
-{ 0x1F940, 0x1F94B },
-{ 0x1F950, 0x1F95E },
-{ 0x1F980, 0x1F991 },
+{ 0x1F6F4, 0x1F6F8 },
+{ 0x1F910, 0x1F93E },
+{ 0x1F940, 0x1F94C },
+{ 0x1F950, 0x1F96B },
+{ 0x1F980, 0x1F997 },
 { 0x1F9C0, 0x1F9C0 },
+{ 0x1F9D0, 0x1F9E6 },
 { 0x20000, 0x2FFFD },
 { 0x30000, 0x3FFFD }
 };
-- 
2.13.2.753.g7f5404b

