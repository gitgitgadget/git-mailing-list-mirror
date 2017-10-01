Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15EB320A10
	for <e@80x24.org>; Sun,  1 Oct 2017 15:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751403AbdJAPOh (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 11:14:37 -0400
Received: from mout.web.de ([212.227.15.4]:51374 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751093AbdJAPOg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 11:14:36 -0400
Received: from [192.168.178.36] ([91.20.57.42]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MRzYo-1dsjek0DXu-00TDLe; Sun, 01
 Oct 2017 17:14:32 +0200
Subject: [PATCH 2/2] run-command: use ALLOC_ARRAY
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <c4abb7ac-dafd-57f2-8b46-45d610d656c4@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <6343155c-0986-06b0-8ced-146b23b8a137@web.de>
Date:   Sun, 1 Oct 2017 17:14:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <c4abb7ac-dafd-57f2-8b46-45d610d656c4@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:iVz/HdlOVH2hHaUWgMaffcIPMtg9kVx8PPkRtDKWUloWww335Bq
 0u3jOhh/RbNy+Itjx08g8rnfcIPhmYS217OYVZmDBHEWD7D8J/cGf8KsVVTb541YsorH60K
 wHakTfkLD7xn08n5SsBSO0DCX87CxwtQASWH3XZCiChalBpc+pXKJNnt34VJ3iZg5DTaV+U
 X62ENM1gOFkE4FbXR9fnw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SHe6z5D9so0=:J/IQ2cLClbfEP9RdKhEyhT
 2JFOWyNYcCMhpYBV/akrH0nMHsmWXNm+eALabHdYEXP5Om/WJ7HmMFuCY9ALlDLtimcQeR/kZ
 mRXNrwWmZAjMeYEvVCKd0K6i92Z75ufJumc9U6W+2N6vuYPze1l/AeRvFm4znPk6oJQEvVaat
 Mmw8JA52ZHEs3mVcyrwQrTRH3hUYA/N95IVm5FX4oFkI03qOhvlhLPrO8D9uTKnra2H0ICQ8I
 2WGxpyahyb8YM11LwI4sNEkoZvnXyvUP6ZaWUatuGoncPfOGHzTGCCt7RN53YMTQIRhUgoc2T
 nMiiyvkWAVPCOoQcg/bshIaduYilmja7PGNSFusqZupJD+R3nCzRqLhCCzIA7hY8B+sf2BaLJ
 RZhXCUBQWjWKgtgQ6cuotLUdcgSszFBICzanwlBY+6zOYYl1tspXLuXM9ZhsCOk8OkKeMbkDJ
 Yycy/uXFTg9GSx2Yh4qYbZPKf2JhtaeH31gZkVHZNTc99oCf9woHUTGq1X8Lo4wtjn4TwOc3/
 FythCGbCiGCiQU9e5Wn51EhCyqcgpGin4m3P4qL9SJ010VRoxi8wiPFScztg5L8+ZaFU6svUD
 4dbTkhgHFF0IiUH8JxzqFyfXVb1/QX+GB1uVll8o9R4anlHt86Qfkt4zO49xJ0obyWxhub2dE
 2XoRR3/MRIc+G5uph7uLJjWXunDMHXXJZ2621aZ9tsFK8dseFo6cg7RZI4rMKmhLD1GiNKDtg
 P51AWHM15up6HUCHeypZUfh9qPJ0ZUknlssnOD/zQo3jrqZKTB/myC8wLJjECZjuzOB9z2waB
 HE4Sudw2N+Q0hYM1LLGgH98iUGp/KY5JmpuxiRgz34dVZJxnH0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the macro ALLOC_ARRAY to allocate an array.  This is shorter and
eaasier, as it automatically infers the size of elements.

Patch generated with Coccinelle and contrib/coccinelle/array.cocci.

Signeg-off-by: Rene Scharfe <l.s.r@web.de>
---
 run-command.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/run-command.c b/run-command.c
index b5e6eb37c0..014b2165b5 100644
--- a/run-command.c
+++ b/run-command.c
@@ -452,7 +452,7 @@ static char **prep_childenv(const char *const *deltaenv)
 	}
 
 	/* Create an array of 'char *' to be used as the childenv */
-	childenv = xmalloc((env.nr + 1) * sizeof(char *));
+	ALLOC_ARRAY(childenv, env.nr + 1);
 	for (i = 0; i < env.nr; i++)
 		childenv[i] = env.items[i].util;
 	childenv[env.nr] = NULL;
-- 
2.14.2
