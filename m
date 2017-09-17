Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A6742047F
	for <e@80x24.org>; Sun, 17 Sep 2017 16:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751660AbdIQQxu (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Sep 2017 12:53:50 -0400
Received: from avasout07.plus.net ([84.93.230.235]:54640 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751497AbdIQQxu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Sep 2017 12:53:50 -0400
Received: from [10.0.2.15] ([147.147.86.16])
        by avasout07 with smtp
        id Agtn1w0030M91Ur01gtov2; Sun, 17 Sep 2017 17:53:48 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=CrLPSjwD c=1 sm=1 tr=0
 a=dubYQqM3tRRTmV8xSh8cXQ==:117 a=dubYQqM3tRRTmV8xSh8cXQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=Ea180b7dbQmxOU1IUEIA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] protocol: make parse_protocol_version() private
To:     Brandon Williams <bmwill@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Message-ID: <1cb7d40d-3f11-71a0-6e53-dced7810a0ca@ramsayjones.plus.com>
Date:   Sun, 17 Sep 2017 17:53:47 +0100
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

Hi Brandon,

If you need to re-roll your 'bw/protocol-v1' branch, could you please
squash this into the relevant patch (commit 45954f179e, "protocol:
introduce protocol extention mechanisms", 13-09-2017).

This assumes you agree that this symbol does not need to be public; if
not, then please just ignore! ;-)

Thanks!

ATB,
Ramsay Jones

 protocol.c | 2 +-
 protocol.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/protocol.c b/protocol.c
index 1b16c7b9a..369503065 100644
--- a/protocol.c
+++ b/protocol.c
@@ -2,7 +2,7 @@
 #include "config.h"
 #include "protocol.h"
 
-enum protocol_version parse_protocol_version(const char *value)
+static enum protocol_version parse_protocol_version(const char *value)
 {
 	if (!strcmp(value, "0"))
 		return protocol_v0;
diff --git a/protocol.h b/protocol.h
index 2fa6486d0..18f9a5235 100644
--- a/protocol.h
+++ b/protocol.h
@@ -7,7 +7,6 @@ enum protocol_version {
 	protocol_v1 = 1,
 };
 
-extern enum protocol_version parse_protocol_version(const char *value);
 extern enum protocol_version get_protocol_version_config(void);
 extern enum protocol_version determine_protocol_version_server(void);
 extern enum protocol_version determine_protocol_version_client(const char *server_response);
-- 
2.14.0
