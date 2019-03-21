Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7871720248
	for <e@80x24.org>; Thu, 21 Mar 2019 21:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbfCUVOn (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 17:14:43 -0400
Received: from mail-gateway-shared15.cyon.net ([194.126.200.68]:45008 "EHLO
        mail-gateway-shared15.cyon.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727194AbfCUVOm (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 21 Mar 2019 17:14:42 -0400
X-Greylist: delayed 485 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Mar 2019 17:14:41 EDT
Received: from s019.cyon.net ([149.126.4.28])
        by mail-gateway-shared15.cyon.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim)
        (envelope-from <bb@drbeat.li>)
        id 1h74tT-0001cX-8z
        for git@vger.kernel.org; Thu, 21 Mar 2019 22:06:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=drbeat.li;
         s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=/HH2M1qWFzeQV8JKv6XD3E0G3TjsGC6p9UjTirqMR08=; b=VV+ecNKNqHowucq1+Z4CWdinMo
        khyN20Gm7Kp3rl9tFrgfjgWQtJeYM/9xFcA4PpbQcW4tN5t1r82Jy9+y06NxLT1eC4ljk88HAi+Gm
        +br09EBRAJgGtRigjNHPaGVECWXD5BCGs//9+O/iKYx4xT1KwaLrnSHZpaJsOSGICjJKHj6sZwYaI
        yCHT4Cqv9cQ1WRjkEhsJN5dVNeJZfrXVB69hX/tPJb6bXxqi8d6rYwLPnyEVQ/mtKYeVmz1L86bQk
        u7lhq0ieiazTYdTg3lp2BezW2mif2VlgY0COHnPu3kYVjiyAA5cViENV6/AQDU6kU4YJa+IFcsVxV
        m0y8jS4Q==;
Received: from [10.20.10.232] (port=28122 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.91)
        (envelope-from <bb@drbeat.li>)
        id 1h74tR-004NpL-9V; Thu, 21 Mar 2019 22:06:30 +0100
Received: by drbeat.li (Postfix, from userid 1000)
        id 5475A1FDB9; Thu, 21 Mar 2019 22:06:28 +0100 (CET)
From:   Beat Bolli <dev+git@drbeat.li>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH] unicode: update the width tables to Unicode 12
Date:   Thu, 21 Mar 2019 22:06:17 +0100
Message-Id: <20190321210617.25015-1-dev+git@drbeat.li>
X-Mailer: git-send-email 2.20.1.415.g653613c723
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-OutGoing-Spam-Status: No, score=-0.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that Unicode 12 has been announced[0], update the character
width tables to the new version.

[0] http://blog.unicode.org/2019/03/announcing-unicode-standard-version-120.html

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 unicode-width.h | 38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/unicode-width.h b/unicode-width.h
index 7c643760f8..93a48f3bf8 100644
--- a/unicode-width.h
+++ b/unicode-width.h
@@ -89,8 +89,7 @@ static const struct interval zero_width[] = {
 { 0x0E34, 0x0E3A },
 { 0x0E47, 0x0E4E },
 { 0x0EB1, 0x0EB1 },
-{ 0x0EB4, 0x0EB9 },
-{ 0x0EBB, 0x0EBC },
+{ 0x0EB4, 0x0EBC },
 { 0x0EC8, 0x0ECD },
 { 0x0F18, 0x0F19 },
 { 0x0F35, 0x0F35 },
@@ -191,7 +190,7 @@ static const struct interval zero_width[] = {
 { 0xA980, 0xA982 },
 { 0xA9B3, 0xA9B3 },
 { 0xA9B6, 0xA9B9 },
-{ 0xA9BC, 0xA9BC },
+{ 0xA9BC, 0xA9BD },
 { 0xA9E5, 0xA9E5 },
 { 0xAA29, 0xAA2E },
 { 0xAA31, 0xAA32 },
@@ -274,6 +273,9 @@ static const struct interval zero_width[] = {
 { 0x11727, 0x1172B },
 { 0x1182F, 0x11837 },
 { 0x11839, 0x1183A },
+{ 0x119D4, 0x119D7 },
+{ 0x119DA, 0x119DB },
+{ 0x119E0, 0x119E0 },
 { 0x11A01, 0x11A0A },
 { 0x11A33, 0x11A38 },
 { 0x11A3B, 0x11A3E },
@@ -298,8 +300,10 @@ static const struct interval zero_width[] = {
 { 0x11D95, 0x11D95 },
 { 0x11D97, 0x11D97 },
 { 0x11EF3, 0x11EF4 },
+{ 0x13430, 0x13438 },
 { 0x16AF0, 0x16AF4 },
 { 0x16B30, 0x16B36 },
+{ 0x16F4F, 0x16F4F },
 { 0x16F8F, 0x16F92 },
 { 0x1BC9D, 0x1BC9E },
 { 0x1BCA0, 0x1BCA3 },
@@ -319,6 +323,8 @@ static const struct interval zero_width[] = {
 { 0x1E01B, 0x1E021 },
 { 0x1E023, 0x1E024 },
 { 0x1E026, 0x1E02A },
+{ 0x1E130, 0x1E136 },
+{ 0x1E2EC, 0x1E2EF },
 { 0x1E8D0, 0x1E8D6 },
 { 0x1E944, 0x1E94A },
 { 0xE0001, 0xE0001 },
@@ -387,10 +393,12 @@ static const struct interval double_width[] = {
 { 0xFE68, 0xFE6B },
 { 0xFF01, 0xFF60 },
 { 0xFFE0, 0xFFE6 },
-{ 0x16FE0, 0x16FE1 },
-{ 0x17000, 0x187F1 },
+{ 0x16FE0, 0x16FE3 },
+{ 0x17000, 0x187F7 },
 { 0x18800, 0x18AF2 },
 { 0x1B000, 0x1B11E },
+{ 0x1B150, 0x1B152 },
+{ 0x1B164, 0x1B167 },
 { 0x1B170, 0x1B2FB },
 { 0x1F004, 0x1F004 },
 { 0x1F0CF, 0x1F0CF },
@@ -422,16 +430,20 @@ static const struct interval double_width[] = {
 { 0x1F680, 0x1F6C5 },
 { 0x1F6CC, 0x1F6CC },
 { 0x1F6D0, 0x1F6D2 },
+{ 0x1F6D5, 0x1F6D5 },
 { 0x1F6EB, 0x1F6EC },
-{ 0x1F6F4, 0x1F6F9 },
-{ 0x1F910, 0x1F93E },
-{ 0x1F940, 0x1F970 },
+{ 0x1F6F4, 0x1F6FA },
+{ 0x1F7E0, 0x1F7EB },
+{ 0x1F90D, 0x1F971 },
 { 0x1F973, 0x1F976 },
-{ 0x1F97A, 0x1F97A },
-{ 0x1F97C, 0x1F9A2 },
-{ 0x1F9B0, 0x1F9B9 },
-{ 0x1F9C0, 0x1F9C2 },
-{ 0x1F9D0, 0x1F9FF },
+{ 0x1F97A, 0x1F9A2 },
+{ 0x1F9A5, 0x1F9AA },
+{ 0x1F9AE, 0x1F9CA },
+{ 0x1F9CD, 0x1F9FF },
+{ 0x1FA70, 0x1FA73 },
+{ 0x1FA78, 0x1FA7A },
+{ 0x1FA80, 0x1FA82 },
+{ 0x1FA90, 0x1FA95 },
 { 0x20000, 0x2FFFD },
 { 0x30000, 0x3FFFD }
 };
-- 
2.20.1.415.g653613c723

