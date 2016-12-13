Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 881882042F
	for <e@80x24.org>; Tue, 13 Dec 2016 15:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934239AbcLMPdy (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 10:33:54 -0500
Received: from mout.gmx.net ([212.227.15.19]:59090 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932414AbcLMPdq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 10:33:46 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MbxJ8-1c0wNb3WSM-00JKwF; Tue, 13
 Dec 2016 16:32:41 +0100
Date:   Tue, 13 Dec 2016 16:32:40 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH v2 31/34] sequencer (rebase -i): suggest --edit-todo upon
 unknown command
In-Reply-To: <cover.1481642927.git.johannes.schindelin@gmx.de>
Message-ID: <eb4cfa652ec89944a7dfe3e871f28926dd4f606e.1481642927.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de> <cover.1481642927.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:/NBbEmCKMjH3dX2MbnN03qbnQkGLYPsUZAkmC7tIGaxkfy3N8DV
 gh/p7rYR8E9DS3dPhxvq26zRYtCMDeMBsiEDbGxPsIVQgHIrOHkCYjKKShGz+Fvk1wB96eC
 xjqCaPbon3ymHClHPnb2jEKNHyUpgoQy3yUV0o5rUl8EOgbf6NI9X8M0EF7+fUGxrUBNtDw
 pU8xyV5k7RhreZpmZ6mRg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PYGMe5k/PKU=:hZqNALRPaukGvRj7POEMst
 z86EuUP2jPfqLOeKsuAdFx/mSQjggB1i6yrSN+fiCwz2VQcYDiegs/qspw5bn45P8a48VmItL
 VykHOtf52YzPaaSds0RSA+fL+2evwArzc6/1RKQsaFX1f+gBaKRUWDaYx4poru/HUvNur7tFy
 J2vmCOW//zzlDNv4lCwZ7mD2+EZJWyflpVaepf9ry9Pg0ClAGqTDacSFe3oMhJws+QV5rIzpm
 O+ImRGVh9YK0qyEklEJGCShcGm3vhrw4b3MACfEMnJzdvoHVH+qkR6LjsTaM8PkLLNWADHNPu
 rJYxu9rxUl8eq4b29rgBElkI2wrpFvXxyYDyL9JDnSGb4CCjI4WDgckNcLLXKM7T2kjoQBcKi
 0mdz3bceEm9zeT2+Z5Ya56J7BH7+0+5iEJ66+X08aZgFitz69cap/XWkyZs2fT+YVvdYNjqLc
 3TTF5F3DuzWa/bZ28BikZ9IElaxaoHXXzgCkCSgGk9D+hFtWVTcwokAkcg/cmwH5A/TcyVYwE
 aylc3F9ST639ZMaoa9Fu2JPHH8ZA2CXUbFkJGMnJaTYCOgTe8w8Te9ky2vTMrzyHijDVpzaNt
 P1WtiLNRlBG2H2caNz21/G539qdNFRJU0YWX7t0NM280xw7d0SeJg9lSP43MPaI0jWTuoJe8n
 DsNfT9IGyktsrJRILR/U0Qfn0nAR5K6ctbBGRENoUtaQl0jrNx8tiC5liVUjdv2Z4s0heACC3
 Tdn2lDxp9/gbCfzp0d3thN7RIX1SiGTFSPGDtN9OTKhH3FQqA5YaAiZOkosEd/jAm2cYj9+UF
 DG8tAZi
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the same behavior as known from `git rebase -i`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index edc213a2c8..498dd028d1 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1355,8 +1355,12 @@ static int read_populate_todo(struct todo_list *todo_list,
 	close(fd);
 
 	res = parse_insn_buffer(todo_list->buf.buf, todo_list);
-	if (res)
+	if (res) {
+		if (is_rebase_i(opts))
+			return error(_("please fix this using "
+				       "'git rebase --edit-todo'."));
 		return error(_("unusable instruction sheet: '%s'"), todo_file);
+	}
 
 	if (!todo_list->nr &&
 	    (!is_rebase_i(opts) || !file_exists(rebase_path_done())))
-- 
2.11.0.rc3.windows.1


