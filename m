Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 713E41FAFB
	for <e@80x24.org>; Thu,  6 Apr 2017 20:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754021AbdDFUmD (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Apr 2017 16:42:03 -0400
Received: from mout.web.de ([212.227.15.14]:62299 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753035AbdDFUmB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2017 16:42:01 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LrsC6-1bx4tl3LVm-013cST; Thu, 06
 Apr 2017 22:41:43 +0200
X-Mozilla-News-Host: news://news.public-inbox.org:119
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] test-read-cache: setup git dir
Message-ID: <020feb89-be3e-1261-d9b5-cad7c38ef2f0@web.de>
Date:   Thu, 6 Apr 2017 22:41:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:42zLroqhuLeFm5ujs3RliSXfKhhfl+5sTc72gX022AEXoN7cPcK
 AhQ/Mjy0XQLnjbRGkijtUZthRftjPE4Msv3DHk3iG316Nz83/tFC0i+3mm3b5qEbY5snzQ+
 AlYB0zUk4PovFupcZNuZ7mQLMNfxe3Ne2OzDCqw3/ehLQKtyeRd07HZA932wfLcM/CGCHxN
 QYrjfTOxcmWUSlMz4ZzAQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DWmE5et2Ah4=:w3jO2/FtS/6TQx8j+mp1Ab
 DoU/NeG7ErQs3hjO1gF4ARVCRTQIyZuyTj664IfEtX9f7ppH8Q8pbGPXayUnugVb1HLAMD5+n
 T0uFvIJx1+ysusDeOnq/RH0opGfOO5NpU2WoelW2usslqrJLuxUFPvbYRC4fMe7rlY6ubBULC
 IIwlJWSFNWK9mzTA71NZwEhJq8SGyqNChnW/ZzogMkGDuXbi1huZMYQr+qAQYn5oL2I38zePC
 p0xRm57XlRj4IMxXvZUXomg9CO0GPeR9f+GeDCR5PNBrybyMbB+V9nDGbniRAM4TQa6e1v/0Q
 8OXWxAq0ntI58f8rVbrr0QzR/oPnz5xL33c5PgXUqISSuyn74niChnIsJsqXFTAbhZ3rA0+UY
 Lre2GsIh/wrb66wRuCpSf1WhitaJwe7f50CZ3NBhLS1YB5gJb8q5MaERbaVxLVVjTnwSJMEgN
 sCMmAYO4n3p/n+Nu4b1e8z4pxEBt+DNOGmS50Y6kJU5hXDJaOTqqdCIPd0sISLnLq7SlpCYTm
 XPoaBGZ7cvwG8X0yeJFj23oYEZZPW096nB4okaKPJPerfR2Us4ACle5UhzchbwsADdyB6S19U
 AljFzP6Fgx7YELfjDCH12TTdEcyQM5hMrw5TGLfd1ThpFv2LtzTX8xMdYSrsVvWAj+wFLKvy7
 TY4aSYqbh4f5Drq0EhKGiOH85JIS4uYzMiDsjHl3o2S9cVH+cEj5YMUmBcsLqUqRkyruyP12U
 h90pX9v1alb0B94iqtJLBPlIa0lFb4TS41FUNSlQJeJSL1B/SXrNV68Jy2E6L2eKh8BSBGOuO
 WeChnu1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

b1ef400e (setup_git_env: avoid blind fall-back to ".git") made programs
that tried to access a repository without initializing properly die with
a diagnostic message.  One offender is test-read-cache, which is used in
p0002.  Fix it by calling setup_git_directory() before accessing the
index.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 t/helper/test-read-cache.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/helper/test-read-cache.c b/t/helper/test-read-cache.c
index 2a7990efc3..48255eef31 100644
--- a/t/helper/test-read-cache.c
+++ b/t/helper/test-read-cache.c
@@ -5,6 +5,7 @@ int cmd_main(int argc, const char **argv)
 	int i, cnt = 1;
 	if (argc == 2)
 		cnt = strtol(argv[1], NULL, 0);
+	setup_git_directory();
 	for (i = 0; i < cnt; i++) {
 		read_cache();
 		discard_cache();
-- 
2.12.2

