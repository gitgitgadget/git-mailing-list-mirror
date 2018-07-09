Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00D9E1F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 19:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932856AbeGITpH (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 15:45:07 -0400
Received: from s019.cyon.net ([149.126.4.28]:42804 "EHLO s019.cyon.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932812AbeGITpF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 15:45:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=drbeat.li;
         s=default; h=Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version
        :Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=l2n1VVVGM9Z9tftJAaIDasgHyr6hYPmiHUutDXwlOdc=; b=e39i9z/D0LL9pb3/C4q9Y9Cq1o
        MbOZxq60oaZ3UPTi63Ap7g6HG07I8Og9fQXc2+mYOvd9euNkpH2/1sS5sKpxtqYwqs61eGVc44dNa
        +yvvoV5Tl+/DrZ5qLXt+DZ88tH05YXuoWPVZ5aK2CTRY47j3MPZIQPlVD0boZRK6pjpWLQa1xWvtW
        xnbTTl3h5mltscmrMFvtYFP+EnXuD+ZMOJ4Mb/oEvnMGD8b45VkL4Aev/Vpb+w2OpdT2p+m6yL4B+
        H94EE/OFCsIgAy6RDzp/iEfI/FJRiQRc1f7eu/7Ybn9pyB9DqxzFqHJ16DdVGd3iLB0+Z1ytQQW+e
        GAlQJiGQ==;
Received: from [10.20.10.233] (port=55840 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.91)
        (envelope-from <bb@drbeat.li>)
        id 1fcc5k-00Cp3d-SZ; Mon, 09 Jul 2018 21:45:03 +0200
Received: by drbeat.li (Postfix, from userid 1000)
        id 8CD0420022; Mon,  9 Jul 2018 21:45:00 +0200 (CEST)
From:   Beat Bolli <dev+git@drbeat.li>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH] unicode: update the width tables to Unicode 11
Date:   Mon,  9 Jul 2018 21:44:52 +0200
Message-Id: <20180709194452.19365-1-dev+git@drbeat.li>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9
X-OutGoing-Spam-Status: No, score=-0.5
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

Now that Unicode 11 has been announced[0], update the character
width tables to the new version.

[0] http://blog.unicode.org/2018/06/announcing-unicode-standard-version-110.html

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 unicode-width.h | 41 ++++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/unicode-width.h b/unicode-width.h
index 6dee2c77ce..7c643760f8 100644
--- a/unicode-width.h
+++ b/unicode-width.h
@@ -20,12 +20,13 @@ static const struct interval zero_width[] = {
 { 0x0730, 0x074A },
 { 0x07A6, 0x07B0 },
 { 0x07EB, 0x07F3 },
+{ 0x07FD, 0x07FD },
 { 0x0816, 0x0819 },
 { 0x081B, 0x0823 },
 { 0x0825, 0x0827 },
 { 0x0829, 0x082D },
 { 0x0859, 0x085B },
-{ 0x08D4, 0x0902 },
+{ 0x08D3, 0x0902 },
 { 0x093A, 0x093A },
 { 0x093C, 0x093C },
 { 0x0941, 0x0948 },
@@ -37,6 +38,7 @@ static const struct interval zero_width[] = {
 { 0x09C1, 0x09C4 },
 { 0x09CD, 0x09CD },
 { 0x09E2, 0x09E3 },
+{ 0x09FE, 0x09FE },
 { 0x0A01, 0x0A02 },
 { 0x0A3C, 0x0A3C },
 { 0x0A41, 0x0A42 },
@@ -63,6 +65,7 @@ static const struct interval zero_width[] = {
 { 0x0BC0, 0x0BC0 },
 { 0x0BCD, 0x0BCD },
 { 0x0C00, 0x0C00 },
+{ 0x0C04, 0x0C04 },
 { 0x0C3E, 0x0C40 },
 { 0x0C46, 0x0C48 },
 { 0x0C4A, 0x0C4D },
@@ -182,6 +185,7 @@ static const struct interval zero_width[] = {
 { 0xA825, 0xA826 },
 { 0xA8C4, 0xA8C5 },
 { 0xA8E0, 0xA8F1 },
+{ 0xA8FF, 0xA8FF },
 { 0xA926, 0xA92D },
 { 0xA947, 0xA951 },
 { 0xA980, 0xA982 },
@@ -219,19 +223,22 @@ static const struct interval zero_width[] = {
 { 0x10A38, 0x10A3A },
 { 0x10A3F, 0x10A3F },
 { 0x10AE5, 0x10AE6 },
+{ 0x10D24, 0x10D27 },
+{ 0x10F46, 0x10F50 },
 { 0x11001, 0x11001 },
 { 0x11038, 0x11046 },
 { 0x1107F, 0x11081 },
 { 0x110B3, 0x110B6 },
 { 0x110B9, 0x110BA },
 { 0x110BD, 0x110BD },
+{ 0x110CD, 0x110CD },
 { 0x11100, 0x11102 },
 { 0x11127, 0x1112B },
 { 0x1112D, 0x11134 },
 { 0x11173, 0x11173 },
 { 0x11180, 0x11181 },
 { 0x111B6, 0x111BE },
-{ 0x111CA, 0x111CC },
+{ 0x111C9, 0x111CC },
 { 0x1122F, 0x11231 },
 { 0x11234, 0x11234 },
 { 0x11236, 0x11237 },
@@ -239,13 +246,14 @@ static const struct interval zero_width[] = {
 { 0x112DF, 0x112DF },
 { 0x112E3, 0x112EA },
 { 0x11300, 0x11301 },
-{ 0x1133C, 0x1133C },
+{ 0x1133B, 0x1133C },
 { 0x11340, 0x11340 },
 { 0x11366, 0x1136C },
 { 0x11370, 0x11374 },
 { 0x11438, 0x1143F },
 { 0x11442, 0x11444 },
 { 0x11446, 0x11446 },
+{ 0x1145E, 0x1145E },
 { 0x114B3, 0x114B8 },
 { 0x114BA, 0x114BA },
 { 0x114BF, 0x114C0 },
@@ -264,8 +272,9 @@ static const struct interval zero_width[] = {
 { 0x1171D, 0x1171F },
 { 0x11722, 0x11725 },
 { 0x11727, 0x1172B },
-{ 0x11A01, 0x11A06 },
-{ 0x11A09, 0x11A0A },
+{ 0x1182F, 0x11837 },
+{ 0x11839, 0x1183A },
+{ 0x11A01, 0x11A0A },
 { 0x11A33, 0x11A38 },
 { 0x11A3B, 0x11A3E },
 { 0x11A47, 0x11A47 },
@@ -285,6 +294,10 @@ static const struct interval zero_width[] = {
 { 0x11D3C, 0x11D3D },
 { 0x11D3F, 0x11D45 },
 { 0x11D47, 0x11D47 },
+{ 0x11D90, 0x11D91 },
+{ 0x11D95, 0x11D95 },
+{ 0x11D97, 0x11D97 },
+{ 0x11EF3, 0x11EF4 },
 { 0x16AF0, 0x16AF4 },
 { 0x16B30, 0x16B36 },
 { 0x16F8F, 0x16F92 },
@@ -355,7 +368,7 @@ static const struct interval double_width[] = {
 { 0x3000, 0x303E },
 { 0x3041, 0x3096 },
 { 0x3099, 0x30FF },
-{ 0x3105, 0x312E },
+{ 0x3105, 0x312F },
 { 0x3131, 0x318E },
 { 0x3190, 0x31BA },
 { 0x31C0, 0x31E3 },
@@ -375,7 +388,7 @@ static const struct interval double_width[] = {
 { 0xFF01, 0xFF60 },
 { 0xFFE0, 0xFFE6 },
 { 0x16FE0, 0x16FE1 },
-{ 0x17000, 0x187EC },
+{ 0x17000, 0x187F1 },
 { 0x18800, 0x18AF2 },
 { 0x1B000, 0x1B11E },
 { 0x1B170, 0x1B2FB },
@@ -410,13 +423,15 @@ static const struct interval double_width[] = {
 { 0x1F6CC, 0x1F6CC },
 { 0x1F6D0, 0x1F6D2 },
 { 0x1F6EB, 0x1F6EC },
-{ 0x1F6F4, 0x1F6F8 },
+{ 0x1F6F4, 0x1F6F9 },
 { 0x1F910, 0x1F93E },
-{ 0x1F940, 0x1F94C },
-{ 0x1F950, 0x1F96B },
-{ 0x1F980, 0x1F997 },
-{ 0x1F9C0, 0x1F9C0 },
-{ 0x1F9D0, 0x1F9E6 },
+{ 0x1F940, 0x1F970 },
+{ 0x1F973, 0x1F976 },
+{ 0x1F97A, 0x1F97A },
+{ 0x1F97C, 0x1F9A2 },
+{ 0x1F9B0, 0x1F9B9 },
+{ 0x1F9C0, 0x1F9C2 },
+{ 0x1F9D0, 0x1F9FF },
 { 0x20000, 0x2FFFD },
 { 0x30000, 0x3FFFD }
 };
-- 
2.18.0.203.gfac676dfb9

