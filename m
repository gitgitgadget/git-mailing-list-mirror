Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F015E20984
	for <e@80x24.org>; Wed, 14 Sep 2016 13:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1763173AbcINNbd (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Sep 2016 09:31:33 -0400
Received: from avasout02.plus.net ([212.159.14.17]:45390 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1763135AbcINNbb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2016 09:31:31 -0400
Received: from [10.0.2.15] ([194.75.29.46])
        by avasout02 with smtp
        id jRXT1t0040zhorE01RXUnX; Wed, 14 Sep 2016 14:31:28 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=U6jQNqju c=1 sm=1 tr=0
 a=g54qAj+LxVGqXy9pVcJ+0w==:117 a=g54qAj+LxVGqXy9pVcJ+0w==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=EWRAwTfyQT02ezdOKZgA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] pkt-line: mark a file-local symbol static
Message-ID: <6373d68b-574d-59f3-7b8d-60dd3a673806@ramsayjones.plus.com>
Date:   Wed, 14 Sep 2016 14:31:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Lars,

If you need to re-roll your 'ls/filter-process' branch, could you
please squash this into the relevant patch; commit 2afd9b22
("pkt-line: add packet_write_gently()", 08-09-2016).

[If you think the symbol should be public (I don't), then add a
suitable declaration to pkt-line.h instead.]

Thanks!

ATB,
Ramsay Jones

 pkt-line.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pkt-line.c b/pkt-line.c
index 538e35f..4900fc0 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -181,7 +181,7 @@ int packet_write_fmt_gently(int fd, const char *fmt, ...)
 	return status;
 }
 
-int packet_write_gently(const int fd_out, const char *buf, size_t size)
+static int packet_write_gently(const int fd_out, const char *buf, size_t size)
 {
 	static char packet_write_buffer[LARGE_PACKET_MAX];
 
-- 
2.10.0
