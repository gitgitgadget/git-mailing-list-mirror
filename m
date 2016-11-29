Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E7C91FC96
	for <e@80x24.org>; Tue, 29 Nov 2016 17:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753820AbcK2Rg3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Nov 2016 12:36:29 -0500
Received: from avasout05.plus.net ([84.93.230.250]:34072 "EHLO
        avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751347AbcK2Rg2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2016 12:36:28 -0500
Received: from [10.0.2.15] ([143.159.212.40])
        by avasout05 with smtp
        id DtcQ1u00B0srQBz01tcRaM; Tue, 29 Nov 2016 17:36:26 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=Qskc5h6d c=1 sm=1 tr=0
 a=8Z0saNXTz8GoXi/9Q5ysMA==:117 a=8Z0saNXTz8GoXi/9Q5ysMA==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=oxKW_R1wS-74YrZttMQA:9
 a=mKh1MN6ifWSoMbZi:21 a=Qj-nY_lv9Uw5qYCR:21 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] difftool.c: mark a file-local symbol with static
Message-ID: <4ddad7ea-5ac8-20b2-da9e-5843c486878a@ramsayjones.plus.com>
Date:   Tue, 29 Nov 2016 17:36:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Johannes,

If you need to re-roll your 'js/difftool-builtin' branch, could
you please squash this into the relevant patch.

Thanks!

Also, due to a problem in my config.mak file on Linux (a commented
out line that had a line continuation '\', grrrrr!), gcc issued a
warning, thus:

  builtin/difftool.c: In function ‘run_dir_diff’:
  builtin/difftool.c:568:13: warning: zero-length gnu_printf format string [-Wformat-zero-length]
       warning("");
               ^
I am not sure why -Wno-format-zero-length is set in DEVELOPER_CFLAGS,
but do you really need to space the output with an an 'empty'
"warning:" line? (Just curious).

ATB,
Ramsay Jones

 builtin/difftool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index 3480920..830369c 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -170,7 +170,7 @@ struct path_entry {
 	char path[FLEX_ARRAY];
 };
 
-int path_entry_cmp(struct path_entry *a, struct path_entry *b, void *key)
+static int path_entry_cmp(struct path_entry *a, struct path_entry *b, void *key)
 {
 	return strcmp(a->path, key ? key : b->path);
 }
-- 
2.9.0
