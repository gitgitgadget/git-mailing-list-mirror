Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8426220A10
	for <e@80x24.org>; Sun,  1 Oct 2017 14:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751089AbdJAOyT (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 10:54:19 -0400
Received: from mout.web.de ([212.227.15.14]:63937 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751005AbdJAOyS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 10:54:18 -0400
Received: from [192.168.178.36] ([91.20.57.42]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lr2Dz-1dLVG00mWJ-00eh10; Sun, 01
 Oct 2017 16:54:15 +0200
Subject: [PATCH 2/2] commit: use strbuf_add() to add a buffer to a strbuf
References: <85605bc6-2e91-7132-ce63-f6e08a08a768@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <223ef0c8-dac2-747b-41c8-3bad62f4c274@web.de>
Date:   Sun, 1 Oct 2017 16:54:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <85605bc6-2e91-7132-ce63-f6e08a08a768@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:Ct/LDsw4NGTFhV+F3kSFn4qIJqpaI7iAjpazqOStLlQIcQSlUZj
 H39nK4RDx++cf+sEVd1UoXFoEXTXgdxZSQ/MsE7ej3ZIRfdDBFqrOcA170Q9AMzDoOTVMCo
 y84N2UNEqa9VcdRY8KzAhP+F1xN0E/xroA9t2OyJvhFc1Zwihsn8etRn+F4cTfQVkWkgKDU
 1ytHb/w+DLAPy0cbQobLw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:g3FnLZU1xQY=:/BGDOmKVvJYYj0idxDavgg
 rfwuuZo3i2R1gZh3gmtfmFIAK+MIifPe9vEyxoOdKEsOy1xHF5EyVO/RCIXzOYU5xMrdNOwus
 5JYbI5HvVekw6xaTSVszCL2uNHPDVX95sxBaCF2d1HrmDWO1dmKrKGekOEj2Qj9JZ+5f+D96W
 KERQuWg1zCNSnYjJMP/ygqoYTBhvLCak+guqm3dLGmGQFYS/EBILCn8EZbKhcFzFQU4LshKSL
 O1T3r43OTDKtQLu6r5Qvojb42yfsnq9pZ7wSNdBeC8+0V1LV4i/Q6ONfRT+kptHCQhdNXV/cD
 9XeEQHvSJLRFIS0dE2018kWgTfjNLPMQLdgB3Re/9VyY/IM3wLy6eqPSXTTH8/VbkP2L3LHi4
 n3sqkHlTbu5h7tNtA73kfVP9S6iSs+4KhGFGp2a5qAO/7VH2MJkFWFNQsDrT1Oyop0J74RGRB
 KY6PeIs/Og8eZ29pqQMkDm4mjgUAv83zP7k3R4dewTLkh7t5SWWjE3g4N6CM1hCnvx+siri9N
 Jy4ExgKLYXyn+ELcueWGXj3vAB13M7oZJnycRQUSbtIrp2vygdCO8F+5c6NBkrwC9DfaXOEk1
 Fi7nGzcgCYBwjCJAk4GXNWZHAB4eGrFPT96+7ivIMPc9coa+FTjxngH4YOZbcGYAE/E114AMs
 zoL8brj+Jcfx6VgzlW/F5eSn3ftfp14XtExZZOOBza/CPyVSbG9h9mv7BqERr0787gr9lDeGm
 hsxBhkFI+ycXxtgUa+oiSV5agu9YJJ346WTyDOHwEQz0llVJqzA3MWNqAPQC2jryHfTFzRpvF
 74bYJz6Wg65c+oIteARx8jSpNcWZiDaGtyrWmj8ZpYr6Q0GX7E=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is shorter, easier and makes the intent clearer.

Patch generated with Coccinelle and contrib/coccinelle/strbuf.cocci.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/commit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 0f8ddb6866..d186736617 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -542,7 +542,7 @@ static void export_one(const char *var, const char *s, const char *e, int hack)
 	struct strbuf buf = STRBUF_INIT;
 	if (hack)
 		strbuf_addch(&buf, hack);
-	strbuf_addf(&buf, "%.*s", (int)(e - s), s);
+	strbuf_add(&buf, s, e - s);
 	setenv(var, buf.buf, 1);
 	strbuf_release(&buf);
 }
-- 
2.14.2
