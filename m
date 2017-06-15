Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 596AC20282
	for <e@80x24.org>; Thu, 15 Jun 2017 01:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751590AbdFOBUY (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 21:20:24 -0400
Received: from avasout07.plus.net ([84.93.230.235]:35010 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750768AbdFOBUX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 21:20:23 -0400
Received: from [10.0.2.15] ([143.159.212.80])
        by avasout07 with smtp
        id YpLL1v0021keHif01pLMpG; Thu, 15 Jun 2017 02:20:21 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=CrLPSjwD c=1 sm=1 tr=0
 a=n+zECcf3rkBNBoU0FNF4VQ==:117 a=n+zECcf3rkBNBoU0FNF4VQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=nzcjYYqy7tOb2SVGvasA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     sahildua2305@gmail.com
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Subject: [PATCH] config: mark a file-local symbol as static
Message-ID: <7d11fa4e-232b-8741-504f-ab4e3e788130@ramsayjones.plus.com>
Date:   Thu, 15 Jun 2017 02:20:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
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

Hi Sahil,

If you need to re-roll your 'sd/branch-copy' branch, could you please
squash this into the relevant patch (commit 37af9c71b6, "config: create
a function to format section headers", 13-06-2017).

Also, I note that another patch in that branch (commit fd44da469c,
"branch: add a --copy (-c) option to go with --move (-m)", 13-06-2017),
adds a couple of external symbols which, currently, don't need to be
externally visible. Is it intended that git_config_copy_section_in_file()
and refs_copy_existing_ref() be part of the public API?

Thanks!

ATB,
Ramsay Jones

 config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.c b/config.c
index 2996e6d56..fbba17483 100644
--- a/config.c
+++ b/config.c
@@ -2173,7 +2173,7 @@ static int write_error(const char *filename)
 	return 4;
 }
 
-struct strbuf store_create_section(const char *key)
+static struct strbuf store_create_section(const char *key)
 {
 	const char *dot;
 	int i;
-- 
2.13.0
