Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F37B20954
	for <e@80x24.org>; Thu,  7 Dec 2017 20:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752705AbdLGUU1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 15:20:27 -0500
Received: from mout.web.de ([212.227.15.14]:49448 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752342AbdLGUU0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 15:20:26 -0500
Received: from [192.168.178.36] ([91.20.50.52]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LmLOE-1eweJz09YY-00Zu8a; Thu, 07
 Dec 2017 21:20:21 +0100
X-Mozilla-News-Host: news://news.public-inbox.org:119
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] am: release strbuf after use in split_mail_mbox()
Message-ID: <ad0af192-1bd4-eee2-d6e8-2f1776e87428@web.de>
Date:   Thu, 7 Dec 2017 21:20:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:ghPWHz+t6uB/bLSjTQBz3UDS3Zl4qpQCY6+IAo4uiZ+9YU1bWIh
 ZDwGsLnJQczvybF6eLAg9BGNrw+jw+e3Q8zOd+I2+j3h+TpREnkGR/X7gduc3AfsghbGmew
 LFNAAlN9STbCG/JFrP9O4LLONT0bkDFLpwCS68Piz+rlEtnDL/x6D1ydGO12wCVyzFs0fyG
 OdfyTGkTj3TtQkm9i233A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:M+ALhKJcU/s=:XKSwY59oTSickD+4PTw5tA
 9zxBf4xTNzE1CI0bwjX/E8F+04W0eqsB3Xnc8me9mauOg+A0Lyd5yt0X0cmYFcVvOvMAcPVpB
 RD+LibxE7TCh5ChWUwaDCQlrnxHRrabGuajnYZGeZEZDbomVSSy97j8ip3hFePQPPl5v5gpDP
 M4fNooErJrOM5n9tsn/dQkjKjPyw4aTvccAbw4oGltPo2kESq/KG5HGHQXdNhuUxgBbJOXHv1
 Uu8VSJ7OVWa6FMk/t3Dla7O21VgPgZ5oNpugOZ6W6JNU3d150KFBAWtUnblPgIz7XUJAhx92N
 FCBYv+3aaYtWIbMYEdJE2/HSFtmKcffuSI485cnlbC6Nw1ONqe0oTbofYqS57rztxv52Q8nuH
 zQI7TjCvKowPlYsUmTDRazOcL+62HWQCK4Vta6qAbjvpw9G66a8M2C5BQ/P1ftsr/oUc7xteG
 1AFQhIi5IT/hjQjlc57del4o5q/AX3b1JlC6IN8PRBOEnNt0OI6Jt86Gw7LadJKgYb8eiL8kW
 8fCiYZQKGxNMD14p565KfnVtjTVsai9FXkilViqn7ih0IxLwz7NAAxlnzIDvYiTVzokYqT6cb
 n41JkSkwr637POvBfHOXgaqtpYlOwh8RmsxokYDCuRJAvlLUbCDtaV/7HKw8Jssyaj7v0Ic8O
 nmVYLB1T5iaCZabbaQT65SSi3M5YO4MlI+suMar6ZFQH0DhRvlEC2PkCbHPPnkKO3HHqBSkr7
 zeJiDq0C9AnoRuUhTH7hOTF4m0wBR65E7Whs0tG8K43zaW7eWFCeslwD79f8aOJMdZMQvQt1b
 4qmBTGLXNznrdHwtHz7xBY0rCtWA669ivLwiinb/4vd+Xin8+Q=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/am.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 02853b3e05..1ac044da2e 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -708,6 +708,7 @@ static int split_mail_mbox(struct am_state *state, const char **paths,
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 	struct strbuf last = STRBUF_INIT;
+	int ret;
 
 	cp.git_cmd = 1;
 	argv_array_push(&cp.args, "mailsplit");
@@ -721,13 +722,16 @@ static int split_mail_mbox(struct am_state *state, const char **paths,
 	argv_array_push(&cp.args, "--");
 	argv_array_pushv(&cp.args, paths);
 
-	if (capture_command(&cp, &last, 8))
-		return -1;
+	ret = capture_command(&cp, &last, 8);
+	if (ret)
+		goto exit;
 
 	state->cur = 1;
 	state->last = strtol(last.buf, NULL, 10);
 
-	return 0;
+exit:
+	strbuf_release(&last);
+	return ret ? -1 : 0;
 }
 
 /**
-- 
2.15.1
