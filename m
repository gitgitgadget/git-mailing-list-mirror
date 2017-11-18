Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A5B2201C8
	for <e@80x24.org>; Sat, 18 Nov 2017 18:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424380AbdKRSFh (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Nov 2017 13:05:37 -0500
Received: from mout.web.de ([217.72.192.78]:61245 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1424371AbdKRSF3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Nov 2017 13:05:29 -0500
Received: from [192.168.178.36] ([91.20.49.242]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MHY1o-1eJQLd3mYe-003Od2; Sat, 18
 Nov 2017 19:05:21 +0100
Subject: [PATCH 3/6] xdiff: show non-empty lines before functions with -W
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Vegard Nossum <vegard.nossum@oracle.com>
References: <790c2344-a71e-7089-9000-f9b37a4a5cd9@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <3a304ace-05ee-2285-1790-627aa6674cba@web.de>
Date:   Sat, 18 Nov 2017 19:05:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <790c2344-a71e-7089-9000-f9b37a4a5cd9@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:Dpwar2dqqELFiJ2znofo4W4GEQEjEkV+jqDZWjiS5jgtGvOwQjT
 2nBgJ/eiOYlPu7wBZroFjeNwxLqAjidf0LsCPFJwXZ8fn//VFv4bsYrcDYv1h7Bqx09vXh3
 tKoDlwxRi1ymuP/6uhtq5dwWs6TQdI9fGf+cMj+/1Jwr+TI0fEj013ZXUye2pJbZTy1ULe8
 CEJreZCtqpkfQUtQgak/g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UESnXVwp1nQ=:YPkC6RQRCepWVIuvtUB82A
 jK9NGEqmW27tAMRNAXO5rC71DRLtIvMsMGJSLj0DMS3SS4DkVFahk8I4nijDZax+00PaBvIj2
 /Q1xPQHjJW9XaO0uLMmZW5MivbKxlfjrhOCvJ4EgdJdErS5xyxpGKCg4QHwScj++vKFVrtoU3
 czgHC4jTA8lw05Adk+KTwRZBwiON02Vpi120TgeRU3QQIc2+U8ktsHpmmCs7xlHR09TLKFXub
 WW8dTXMq8mqK83g4wQ2792H96srtOalcd7U9tBQXsd0qi5DC6TNUVauYr9fgczfRkw4TP/Utr
 0XHlU8CkOZw2HSsy3gV7cIxfItNqJo9ybMgT4iC1tsHtzHm1uedOGruYMPuUD4kNc8XW83hh6
 v4YoRu+dSlwEVNJC3M0DMmUYhOx8J/1zwOzF/pTxvk0scPLaQ3VsE3jeLhXi7xjEfQz0MnxUG
 +ElvLTjsp5TAOykQAEfGsii1lBGHCdptRNNApR7mKf0otoYqUWVSA45xFe4fDYxZV8mEzWZad
 2xnZ3Rg0SURyUL2EjheFFKT+a/f6VWxv1hvFU3UXOhZJpqL08de8qhE94SpUHBUPgioZAtC3w
 nnQFzx2FSBqRvOlvobgDahSkNSCPDmL5BcGaHZMbAPcZTvRJN2wGE3wncgXodXRn0Sp5QRgxp
 CIjD9MNQpRDyekePwi6vztLOT9ZnhXM1aln3fIuGrRQp9k/cCLDWeqrmnwYbSGna/uNSe4N/L
 v6Ta8AjwceRX0vx++G7QjJGEhc4F9z9UDoz0C/PBg2R9weFgPOo+hmieTK82LeJkAcNnUylTf
 5UDwBCWYG8m4EScBPLUoL2sm03KvuO8EtaWI1ZGjGlp9C7QDJ4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Non-empty lines before a function definition are most likely comments
for that function and thus relevant.  Include them in function context.

Such a non-empty line might also belong to the preceeding function if
there is no separating blank line.  Stop extending the context upwards
also at the next function line to make sure only one extra function body
is shown at most.

Original-patch-by: Vegard Nossum <vegard.nossum@oracle.com>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 t/t4051-diff-function-context.sh | 2 +-
 xdiff/xemit.c                    | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/t4051-diff-function-context.sh b/t/t4051-diff-function-context.sh
index 30fc5bf2b3..2d76a971c4 100755
--- a/t/t4051-diff-function-context.sh
+++ b/t/t4051-diff-function-context.sh
@@ -85,7 +85,7 @@ test_expect_success 'setup' '
 
 check_diff changed_hello 'changed function'
 
-test_expect_failure ' context includes comment' '
+test_expect_success ' context includes comment' '
 	grep "^ .*Hello comment" changed_hello.diff
 '
 
diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index c2d5bd004c..7778dc2b19 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -204,6 +204,9 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 			}
 
 			fs1 = get_func_line(xe, xecfg, NULL, i1, -1);
+			while (fs1 > 0 && !is_empty_rec(&xe->xdf1, fs1 - 1) &&
+			       !is_func_rec(&xe->xdf1, xecfg, fs1 - 1))
+				fs1--;
 			if (fs1 < 0)
 				fs1 = 0;
 			if (fs1 < s1) {
-- 
2.15.0
