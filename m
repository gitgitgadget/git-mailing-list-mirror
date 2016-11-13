Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A06A21F40E
	for <e@80x24.org>; Sun, 13 Nov 2016 16:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934155AbcKMQmT (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 Nov 2016 11:42:19 -0500
Received: from avasout03.plus.net ([84.93.230.244]:46777 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933891AbcKMQmS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Nov 2016 11:42:18 -0500
Received: from [10.0.2.15] ([194.75.29.46])
        by avasout03 with smtp
        id 7UiF1u0010zhorE01UiGdK; Sun, 13 Nov 2016 16:42:16 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=YLLd8lOx c=1 sm=1 tr=0
 a=g54qAj+LxVGqXy9pVcJ+0w==:117 a=g54qAj+LxVGqXy9pVcJ+0w==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=tWkevG_N4H8zcK_0pg0A:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] attr: mark a file-local symbol as static
Message-ID: <83508d1f-e809-f6be-5afc-4c23195dbd08@ramsayjones.plus.com>
Date:   Sun, 13 Nov 2016 16:42:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Stefan,

If you need to re-roll your 'sb/attr' branch, could you please
squash this into the relevant patch.

Alternatively, since there is only a single call site for git_attr()
(on line #1005), you could perhaps remove git_attr() and inline that
call. (However, that does make that line exceed 80 columns).

Thanks!

ATB,
Ramsay Jones

 attr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/attr.c b/attr.c
index 667ba85..84c4b08 100644
--- a/attr.c
+++ b/attr.c
@@ -169,7 +169,7 @@ static struct git_attr *git_attr_internal(const char *name, int len)
 	return a;
 }
 
-struct git_attr *git_attr(const char *name)
+static struct git_attr *git_attr(const char *name)
 {
 	return git_attr_internal(name, strlen(name));
 }
-- 
2.10.0
