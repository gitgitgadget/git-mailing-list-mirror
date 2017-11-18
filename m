Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C16D201C8
	for <e@80x24.org>; Sat, 18 Nov 2017 18:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424443AbdKRSM4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Nov 2017 13:12:56 -0500
Received: from mout.web.de ([217.72.192.78]:57234 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1424440AbdKRSMy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Nov 2017 13:12:54 -0500
Received: from [192.168.178.36] ([91.20.49.242]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MAMy6-1eRdrc2nAA-00BeVf; Sat, 18
 Nov 2017 19:08:10 +0100
Subject: [PATCH 6/6] grep: show non-empty lines before functions with -W
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Vegard Nossum <vegard.nossum@oracle.com>
References: <790c2344-a71e-7089-9000-f9b37a4a5cd9@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <9c3462e3-2d1d-05bc-9f7d-4bc93d32e7ff@web.de>
Date:   Sat, 18 Nov 2017 19:08:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <790c2344-a71e-7089-9000-f9b37a4a5cd9@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:WpkRq3m+DsMIOO/bf7bBUK823zLTsrOaX+a5K5HLafr71x+j4rV
 /kIx7ku/QfOsbIgnWGJyMY/X02oiFSOhbuaG53hY6IMZN9/Kfv401OpwujFJXcanruheatU
 v7B3X4ELEe5pPE8y6zTAsZ6dV/qvxEsSDjlSp2iV3s528K5Z3W6RDS2bZE5cGNDOtmZTTH1
 vJJklHmm0ZHG2BDLlskXg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MeZJTyJd5As=:FKp9kX+O4zkEmY2WNIZQtK
 wMemAlihQJ/z4tq1CxsOTNbEyPUSMdQWgEYKNN/18dPEBO953ObgczZwl705gRuZqhQXR2Np/
 pZoAVxb6cGtVywcq5ek6DXPU1nOxnUb2w7UFNrSKznCWdcLIz+xfGkh5WHqZnbqNsI0qa6Ylt
 UhYJH+oHsHE5iDncs/XjtFj5ZMRQaoXL3y5gG/Idnrxftmg2087dsY6ngcZCx1RpPHao0MIUQ
 LBryrE5RFsBpgYfILIbYTo4KUKcFhQiTLjdGyAzCkOB6lhnvoxa0uWQvdN2aWCozfpUfrwR6I
 q8WQWF8zaP6TTq167XXS/BdpKFq6BGlSTUpEumpz1Z+GpwNWxK+WTUjet8iYLPVKhM3EiOTVS
 I9MrXHdAVcYOre5oF7/JjFKJwh/g4T9x95Uo6wBRLBRhZ/YzXfXOCjzZwnrReA1Wbjm1AkCny
 u8KD8oOew4APX3axLngT/5nkn1KW0NgkUokS1rHMgDGtyGCEsPtnRjElW1Y1nkQSMrzq87LS5
 3VJZqOyCsbstguykIt5ZSZ3DNpWscPTQ58xAyJsfCX8bHVS87dA39gk8ReQrUnWrbP1LDT3EH
 KzaZYiKeeJEUT7A3JEgOg9PKNuKuVo9h9rtsKgziexNkiYm5Z6yYNAUsV8gYRlJbceFaDgmEt
 dwd8WKN0FS4Bzd8nJQv2pnzF9YA1+V7aUpOKEbGlg4Ho5Ryi1XdVItfjpogsCGNWW8Lsobstx
 a2OtjAEB9xB3oPaF8F5X1yF9uuRs+oSyjBG6AJm3AQexxWQcDVVdTrWx++vhiWqMh7L0ngMe5
 5QfCFnBcYlh9E9gK2uQwwtyxzY6a2yzljMjgohw67X9JYA+cvo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Non-empty lines before a function definition are most likely comments
for that function and thus relevant.  Include them in function context.

Such a non-empty line might also belong to the preceding function if
there is no separating blank line.  Stop extending the context upwards
also at the next function line to make sure only one extra function body
is shown at most.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 grep.c          | 27 +++++++++++++++++++++++----
 t/t7810-grep.sh |  2 +-
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/grep.c b/grep.c
index 2c55d10c55..a69c05edc2 100644
--- a/grep.c
+++ b/grep.c
@@ -1476,33 +1476,52 @@ static void show_funcname_line(struct grep_opt *opt, struct grep_source *gs,
 	}
 }
 
+static int is_empty_line(const char *bol, const char *eol);
+
 static void show_pre_context(struct grep_opt *opt, struct grep_source *gs,
 			     char *bol, char *end, unsigned lno)
 {
 	unsigned cur = lno, from = 1, funcname_lno = 0, orig_from;
-	int funcname_needed = !!opt->funcname;
+	int funcname_needed = !!opt->funcname, comment_needed = 0;
 
 	if (opt->pre_context < lno)
 		from = lno - opt->pre_context;
 	if (from <= opt->last_shown)
 		from = opt->last_shown + 1;
 	orig_from = from;
-	if (opt->funcbody && !match_funcname(opt, gs, bol, end)) {
-		funcname_needed = 1;
+	if (opt->funcbody) {
+		if (match_funcname(opt, gs, bol, end))
+			comment_needed = 1;
+		else
+			funcname_needed = 1;
 		from = opt->last_shown + 1;
 	}
 
 	/* Rewind. */
 	while (bol > gs->buf && cur > from) {
+		char *next_bol = bol;
 		char *eol = --bol;
 
 		while (bol > gs->buf && bol[-1] != '\n')
 			bol--;
 		cur--;
+		if (comment_needed && (is_empty_line(bol, eol) ||
+				       match_funcname(opt, gs, bol, eol))) {
+			comment_needed = 0;
+			from = orig_from;
+			if (cur < from) {
+				cur++;
+				bol = next_bol;
+				break;
+			}
+		}
 		if (funcname_needed && match_funcname(opt, gs, bol, eol)) {
 			funcname_lno = cur;
 			funcname_needed = 0;
-			from = orig_from;
+			if (opt->funcbody)
+				comment_needed = 1;
+			else
+				from = orig_from;
 		}
 	}
 
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 632b905611..c02ca735b9 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -785,7 +785,7 @@ test_expect_success 'grep -W with userdiff' '
 	git grep -W echo >function-context-userdiff-actual
 '
 
-test_expect_failure ' includes preceding comment' '
+test_expect_success ' includes preceding comment' '
 	grep "# Say hello" function-context-userdiff-actual
 '
 
-- 
2.15.0
