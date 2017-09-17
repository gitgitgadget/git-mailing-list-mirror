Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17A982047F
	for <e@80x24.org>; Sun, 17 Sep 2017 22:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751923AbdIQW4E (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Sep 2017 18:56:04 -0400
Received: from avasout07.plus.net ([84.93.230.235]:55524 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751842AbdIQW4D (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Sep 2017 18:56:03 -0400
Received: from [10.0.2.15] ([147.147.86.16])
        by avasout07 with smtp
        id Amw11w0020M91Ur01mw2DG; Sun, 17 Sep 2017 23:56:02 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=CrLPSjwD c=1 sm=1 tr=0
 a=dubYQqM3tRRTmV8xSh8cXQ==:117 a=dubYQqM3tRRTmV8xSh8cXQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=3bcJRznAEjzW6wCumecA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Michael J Gruber <git@grubix.eu>,
        Adam Dinwoodie <adam@dinwoodie.org>, Jeff King <peff@peff.net>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 1/2] test-lib: use more compact expression in PIPE
 prerequisite
Message-ID: <308f3128-a96e-e7f0-e430-5eb10b08ec08@ramsayjones.plus.com>
Date:   Sun, 17 Sep 2017 23:56:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 t/test-lib.sh | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 32f9b2001..9b61f16f7 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1067,14 +1067,8 @@ test_i18ngrep () {
 
 test_lazy_prereq PIPE '
 	# test whether the filesystem supports FIFOs
-	case $(uname -s) in
-	CYGWIN*|MINGW*)
-		false
-		;;
-	*)
-		rm -f testfifo && mkfifo testfifo
-		;;
-	esac
+	test_have_prereq !MINGW,!CYGWIN &&
+	rm -f testfifo && mkfifo testfifo
 '
 
 test_lazy_prereq SYMLINKS '
-- 
2.14.0
