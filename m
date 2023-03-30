Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B48C6FD1D
	for <git@archiver.kernel.org>; Thu, 30 Mar 2023 19:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjC3TW7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Mar 2023 15:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjC3TW5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2023 15:22:57 -0400
X-Greylist: delayed 448 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 30 Mar 2023 12:22:55 PDT
Received: from mail-gateway-shared13.cyon.net (mail-gateway-shared13.cyon.net [194.126.200.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15816C1
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 12:22:54 -0700 (PDT)
Received: from s019.cyon.net ([149.126.4.28])
        by mail-gateway-shared13.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim)
        (envelope-from <bb@drbeat.li>)
        id 1phxk3-0006Pb-3C
        for git@vger.kernel.org;
        Thu, 30 Mar 2023 21:15:24 +0200
Received: from [10.20.10.231] (port=6604 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.95)
        (envelope-from <bb@drbeat.li>)
        id 1phxk2-00C4yZ-Qm;
        Thu, 30 Mar 2023 21:15:22 +0200
Received: by drbeat.li (Postfix, from userid 1000)
        id 846C51800CB; Thu, 30 Mar 2023 21:15:22 +0200 (CEST)
From:   Beat Bolli <dev+git@drbeat.li>
To:     git@vger.kernel.org
Cc:     Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH] unicode: update the width tables to Unicode 15
Date:   Thu, 30 Mar 2023 21:15:17 +0200
Message-Id: <20230330191517.1762375-1-dev+git@drbeat.li>
X-Mailer: git-send-email 2.35.1.720.g215f5dbbfb
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Unicode version 15 was released in September 2022 [1], and we have so
far neglected to update our width tables. Do this now.

[1] http://blog.unicode.org/2022/09/announcing-unicode-standard-version-150.html

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 unicode-width.h | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/unicode-width.h b/unicode-width.h
index 97c851b27d..e15fb0455b 100644
--- a/unicode-width.h
+++ b/unicode-width.h
@@ -94,7 +94,7 @@ static const struct interval zero_width[] = {
 { 0x0E47, 0x0E4E },
 { 0x0EB1, 0x0EB1 },
 { 0x0EB4, 0x0EBC },
-{ 0x0EC8, 0x0ECD },
+{ 0x0EC8, 0x0ECE },
 { 0x0F18, 0x0F19 },
 { 0x0F35, 0x0F35 },
 { 0x0F37, 0x0F37 },
@@ -228,6 +228,7 @@ static const struct interval zero_width[] = {
 { 0x10AE5, 0x10AE6 },
 { 0x10D24, 0x10D27 },
 { 0x10EAB, 0x10EAC },
+{ 0x10EFD, 0x10EFF },
 { 0x10F46, 0x10F50 },
 { 0x10F82, 0x10F85 },
 { 0x11001, 0x11001 },
@@ -252,6 +253,7 @@ static const struct interval zero_width[] = {
 { 0x11234, 0x11234 },
 { 0x11236, 0x11237 },
 { 0x1123E, 0x1123E },
+{ 0x11241, 0x11241 },
 { 0x112DF, 0x112DF },
 { 0x112E3, 0x112EA },
 { 0x11300, 0x11301 },
@@ -313,7 +315,12 @@ static const struct interval zero_width[] = {
 { 0x11D95, 0x11D95 },
 { 0x11D97, 0x11D97 },
 { 0x11EF3, 0x11EF4 },
-{ 0x13430, 0x13438 },
+{ 0x11F00, 0x11F01 },
+{ 0x11F36, 0x11F3A },
+{ 0x11F40, 0x11F40 },
+{ 0x11F42, 0x11F42 },
+{ 0x13430, 0x13440 },
+{ 0x13447, 0x13455 },
 { 0x16AF0, 0x16AF4 },
 { 0x16B30, 0x16B36 },
 { 0x16F4F, 0x16F4F },
@@ -339,9 +346,11 @@ static const struct interval zero_width[] = {
 { 0x1E01B, 0x1E021 },
 { 0x1E023, 0x1E024 },
 { 0x1E026, 0x1E02A },
+{ 0x1E08F, 0x1E08F },
 { 0x1E130, 0x1E136 },
 { 0x1E2AE, 0x1E2AE },
 { 0x1E2EC, 0x1E2EF },
+{ 0x1E4EC, 0x1E4EF },
 { 0x1E8D0, 0x1E8D6 },
 { 0x1E944, 0x1E94A },
 { 0xE0001, 0xE0001 },
@@ -417,7 +426,9 @@ static const struct interval double_width[] = {
 { 0x1AFF5, 0x1AFFB },
 { 0x1AFFD, 0x1AFFE },
 { 0x1B000, 0x1B122 },
+{ 0x1B132, 0x1B132 },
 { 0x1B150, 0x1B152 },
+{ 0x1B155, 0x1B155 },
 { 0x1B164, 0x1B167 },
 { 0x1B170, 0x1B2FB },
 { 0x1F004, 0x1F004 },
@@ -451,7 +462,7 @@ static const struct interval double_width[] = {
 { 0x1F6CC, 0x1F6CC },
 { 0x1F6D0, 0x1F6D2 },
 { 0x1F6D5, 0x1F6D7 },
-{ 0x1F6DD, 0x1F6DF },
+{ 0x1F6DC, 0x1F6DF },
 { 0x1F6EB, 0x1F6EC },
 { 0x1F6F4, 0x1F6FC },
 { 0x1F7E0, 0x1F7EB },
@@ -459,15 +470,13 @@ static const struct interval double_width[] = {
 { 0x1F90C, 0x1F93A },
 { 0x1F93C, 0x1F945 },
 { 0x1F947, 0x1F9FF },
-{ 0x1FA70, 0x1FA74 },
-{ 0x1FA78, 0x1FA7C },
-{ 0x1FA80, 0x1FA86 },
-{ 0x1FA90, 0x1FAAC },
-{ 0x1FAB0, 0x1FABA },
-{ 0x1FAC0, 0x1FAC5 },
-{ 0x1FAD0, 0x1FAD9 },
-{ 0x1FAE0, 0x1FAE7 },
-{ 0x1FAF0, 0x1FAF6 },
+{ 0x1FA70, 0x1FA7C },
+{ 0x1FA80, 0x1FA88 },
+{ 0x1FA90, 0x1FABD },
+{ 0x1FABF, 0x1FAC5 },
+{ 0x1FACE, 0x1FADB },
+{ 0x1FAE0, 0x1FAE8 },
+{ 0x1FAF0, 0x1FAF8 },
 { 0x20000, 0x2FFFD },
 { 0x30000, 0x3FFFD }
 };
-- 
2.35.1.720.g215f5dbbfb

