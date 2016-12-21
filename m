Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F9A31FF40
	for <e@80x24.org>; Wed, 21 Dec 2016 17:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760976AbcLURyB (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Dec 2016 12:54:01 -0500
Received: from mout.gmx.net ([212.227.17.22]:62557 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1760845AbcLURx7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2016 12:53:59 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Meutp-1bvn7Q39cP-00OYSK; Wed, 21
 Dec 2016 18:53:37 +0100
Date:   Wed, 21 Dec 2016 18:53:36 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 1/2] mingw: adjust is_console() to work with stdin
In-Reply-To: <cover.1482342791.git.johannes.schindelin@gmx.de>
Message-ID: <8c472bdd0be9d767c5388105f452e27b9118a0f9.1482342791.git.johannes.schindelin@gmx.de>
References: <cover.1482342791.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:cVEi3Z946KG8uXWBJunYf2n07v0mIMz4wq1VR09COgEC4pTtqEv
 j1NqRgZBp0zOblt7QtR36tjMIQ7U2OQTsHm/RIyfjZHb1o7M2lkqeBByO9TzH1vh7ELNc+8
 4WPxc+BRXLz15kATsv1gPb3bF2AgNq/o1LK2APrB6AfAKsowvyVwJ3Tyus0pE8eqhswi0jS
 Ri1Z/MNh619F1kfpk5XuQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:io8WNvemMNA=:AJ8BJjbCbe8apDaXu422DJ
 eVuscxRBPndVyPQ2fC5njJsg5GyhF5wppfqP6M7jiL5RJ0TVkBEKB78wZaCuj993/Zr0P30m1
 /v7JqnHhjX1LCYfWnUr4FZrgZnichsOo5Wj2nelaT7ei35xHGA46lLWzxA/OFB06vXDInwXWF
 Pa3eqIN8jd8GN0uCairI9sfuDN5GEUFFR0NefRFHUdJy9UDQMabG7FvMFBAMI1mXW5k2KVd2C
 +lJfYhCZAkb7QnCISm4GUQ659UP1AJtAwHGYE6k/3lJTA3zBBOZyEvMgx91AlEUaae7ThKC0E
 ijmmvbWnEnflNJGceU0Ht1qw4a8t6vPE5seIZHTdJV8fzttPF9lhKjVSEMPuyah4gBRwYh50e
 yYR4HzAoZgIux8N8K2sBFff1krK+sSQsEIFIMlJK+LA0RRO2u36PXpDmEzU1fswhziX04c1xi
 JOkqtFFPT+UvEHP2/ozZ+eVqQ/RCCJgSERlBMRlCfEmerJkKAlciSz4RBtkIasZKgrpedTT8G
 s3DHPYQmnvP04z3ET/VnRxBdO1dP3iIvXFJhSuIVG/bShTYQ/JwDQf8ck+l5G7J19qcFJqj1S
 fAXqRPsRPYfPqMilpGF3l65EuDY9gU7n7s0JtOEvGexRJ2cfFAtglUukGRDep+gZPzhoidUck
 LsoOIG8Vv62bNv3Sv15R8L/zUoQGbaSmfLqOL7o3FOhKZtr5ONIzhLrRHRNWcW3EK1ABhAkCC
 Bnj+XSDaPwTswp/Mz8VC/4nOpdWDZJZGGnE+AL9QSFjJ7qZtX4XiF4iCDrgdktmDmLX+3aTK5
 c3XdKPXu98FxxiKRHJfDMFbZTLq51hUiDGdgkTQ5grCsafEZdcTIC7iXbUTXvTFFgJRTa405o
 o2a6MQ9OFh+rtUXGCIcufGs1UCWVDoL7aHhzBkPJ79MGLsq9foO/UcWFKOGxQP+I+r5mm5K8F
 4RR6I754ixTlXSU5nTqgd/9P3I9R2sN2gLmCH9IB3Np9SW3Ljf5jv2dktfO9Z2x2p42QqxILq
 olfz3vpRhEpm9JKo1C9QcJg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When determining whether a handle corresponds to a *real* Win32 Console
(as opposed to, say, a character device such as /dev/null), we use the
GetConsoleOutputBufferInfo() function as a tell-tale.

However, that does not work for *input* handles associated with a
console. Let's just use the GetConsoleMode() function for input handles,
and since it does not work on output handles fall back to the previous
method for those.

This patch prepares for using is_console() instead of my previous
misguided attempt in cbb3f3c9b1 (mingw: intercept isatty() to handle
/dev/null as Git expects it, 2016-12-11) that broke everything on
Windows.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/winansi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/compat/winansi.c b/compat/winansi.c
index 5b2f5638ec..97a004b8ab 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -84,6 +84,7 @@ static void warn_if_raster_font(void)
 static int is_console(int fd)
 {
 	CONSOLE_SCREEN_BUFFER_INFO sbi;
+	DWORD mode;
 	HANDLE hcon;
 
 	static int initialized = 0;
@@ -98,7 +99,10 @@ static int is_console(int fd)
 		return 0;
 
 	/* check if its a handle to a console output screen buffer */
-	if (!GetConsoleScreenBufferInfo(hcon, &sbi))
+	if (!fd) {
+		if (!GetConsoleMode(hcon, &mode))
+			return 0;
+	} else if (!GetConsoleScreenBufferInfo(hcon, &sbi))
 		return 0;
 
 	/* initialize attributes */
-- 
2.11.0.rc3.windows.1


