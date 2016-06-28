Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 930D22018B
	for <e@80x24.org>; Tue, 28 Jun 2016 10:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752211AbcF1KDG (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 06:03:06 -0400
Received: from mout.gmx.net ([212.227.15.19]:59529 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752154AbcF1KDE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 06:03:04 -0400
Received: from virtualbox ([37.24.143.100]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LfjlS-1bff9t1YPi-00pPiw; Tue, 28 Jun 2016 12:02:51
 +0200
Date:	Tue, 28 Jun 2016 12:02:49 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Karsten Blees <blees@dcon.de>, Stepan Kasal <kasal@ucw.cz>,
	Jeff King <peff@peff.net>, Lukas Fleischer <lfleischer@lfos.de>
Subject: [PATCH] Remove obsolete comment from color.h
Message-ID: <16f3d3edb03c2cb9a6c11b745eda9fb2274af182.1467108142.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Uuor+VMRrkMHVEUcqXOcUiQys8UhIQLZ3xrJ4J/YNiOnsP1QBAP
 dPH2QwHt0YRCslNoHG9MBWSTNolPMICuDu9DYELfl4w/yhuqX4VM14Lg8zir0aa0yZWoQ++
 bYbv91EgSJ1F/ZOdgFn7w9lj45w1jjFoQJWPvHvkO3gjVGa7MoKSzGmF/+D7oI9tJzYr8VH
 Dq1Kz4S4HPJiTmX5/6kiw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:7MYja2W0uGI=:QpMZHbwzFo8wbB3EOMBvPv
 6IZWuHULgj94XMfpz2GN4Xgs63FaBQvdqRig61IgUR1anPuLf45027rQVklweEvcU09wIYZBK
 pbvzoZbnYeOAG4r7yG0BPDWNQXR8pbNBrgt/RcTwkJ9I+7B7ME/yITB3chcAwQ2m6Mtk7p/5b
 32ED5xlzk0367S8v4hYomxmBWQwrcx7CnGkhn/LikRt6WuaRFtpXQ+GRYKjv79d2EyBIIeTB6
 wRCinokL+3kDPc+uBX7eV5RYNFDtObqR0PCFNw69QbvJfCGx7pKzp/7rXsnsanwpF+MATzJP+
 DGpIBnot2swU4izNR4BoBVUtJoK3KlcsjEEJfawXWfHaM54dbLtzez2kPB1++g2Asy17c8w3Z
 yRGM1tNzzYAeCu0Cp0IsawjaItf0ie57fpPjZvMUpLjO+HqDJ8DZQfgPxl+JD0N/sR7pbIsfP
 8bVcJSW+O0mLqiK4r0Ov9OLXI8EbWKHgk32vgOacsN6v7Wa6fv7RocNbEc2ogHjjfbOvE6hds
 bg7cTwFglXfT7RHAEbwAWvqUWApddfrLO052Ommk1zJqXfULF4rz72dtIxZUiIqwVKxyItQAW
 UJ/XuzJY5q4Kq/Uqf4XN/D5ts53qPsAueT6o+cyjb6Mtg2pJ6FT2FVCiG9kxZ9p0RhWTAq+mS
 D3KjiavziKyHGIIYXIFGXSCoVZQytx3zcRnfMRGanvmL10KtVpcxwkuo3rHWbVRbfd0d2m+P8
 kWy5l2x3HUCmIVtp5d/nlOV4hqQT42iTQ9vuiWOt6ZWj/CYl7Z/WzY9r9Oquayp8R4hjkjvkn
 wxKLj0I
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Originally, ANSI color sequences were supported on Windows only by
overriding the printf() and fprintf() functions, as mentioned in e7821d7
(Add a notice that only certain functions can print color escape codes,
2009-11-27).

As of eac14f8 (Win32: Thread-safe windows console output, 2012-01-14),
however, this is no longer the case, as the ANSI color sequence support
code needed to be replaced with a thread-safe version, one side effect
being that stdout and stderr handled no matter which function is used to
write to it.

So let's just remove the comment that is now obsolete.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
Published-As: https://github.com/dscho/git/releases/tag/winansi-color-v1
 color.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/color.h b/color.h
index e155d13..b9ead16 100644
--- a/color.h
+++ b/color.h
@@ -18,11 +18,6 @@ struct strbuf;
  */
 #define COLOR_MAXLEN 70
 
-/*
- * IMPORTANT: Due to the way these color codes are emulated on Windows,
- * write them only using printf(), fprintf(), and fputs(). In particular,
- * do not use puts() or write().
- */
 #define GIT_COLOR_NORMAL	""
 #define GIT_COLOR_RESET		"\033[m"
 #define GIT_COLOR_BOLD		"\033[1m"
-- 
2.9.0.118.g0e1a633

base-commit: cf4c2cfe52be5bd973a4838f73a35d3959ce2f43
