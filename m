Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF8421F461
	for <e@80x24.org>; Sat, 24 Aug 2019 08:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbfHXI1H (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Aug 2019 04:27:07 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37399 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfHXI1H (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Aug 2019 04:27:07 -0400
Received: by mail-io1-f65.google.com with SMTP id q22so25656915iog.4
        for <git@vger.kernel.org>; Sat, 24 Aug 2019 01:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C7cvA63Mls7f/glzSnNwJN2P5f8JSKcVpFamqhfO42o=;
        b=JOWJP6jUsOEI06bE92HzZEc195YG7TQWYGBL8xHG3fmJ7NjhuLmVUHjVWb5TK9DhcI
         SFD+dFH6IS130736hYBiasNYw5Ws5SOfgbQlhKTrIbqHh7kBjaUCedimaX9ak7tccXXy
         NlzBBPFdHmiqFO6+edWhWWWUh2EtoY1FKp7qd+vO023OClW0K4UzlmdjkbJjR0qAIpcm
         cqVkxAiPmQC4cuOnIm8ShWF2dGrTFr4+/wUxJT+37MUFYxQjKzbnVLKbCM6tOwZgFUN+
         Ur94eDzgWmt+poGApHcRFBKkWdvIpH6NG+s1GnLf0qfNngAhvEF2d9o1LQWUd3I7ic/c
         KqSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C7cvA63Mls7f/glzSnNwJN2P5f8JSKcVpFamqhfO42o=;
        b=bRCZVJ7Li3cFpQ1fmhcgIKIm2e8f4fA83EgcZGfb2XEHMhu1dnZxV8az0K2sEMuAx5
         ZAgJ65o+BBidaxlzUuyHYx/VOwjGenHiLo1brRZFjj6ql0zmwnLXkg1k2Y3bhK4QrF79
         RBWf4YPjskerQGa18sPwIe0sn4SWp5fF+swObfIBAfbC8xC5tlDWbDM6cPAMZ6ChDwDR
         nBx1/sQOV41D9lxrSr81gCH0JcBuQQzaqLYC2ImePSOKMA7yxOrdVzCScQRmMntZ724Q
         +EM04UuhtRXNIsol7jqe66rbOAT7FJ3gvANVjC3+xiEm0NBfboys+oTh0a3nL0n2X+Bg
         2DBA==
X-Gm-Message-State: APjAAAWIUSGw6WzNOxm5gz4As2+5DU9CkQNkIA594xKbtbRmn18aSlpC
        +g9W2aPwhBz7OezE5oV+O0QC2AT0
X-Google-Smtp-Source: APXvYqwyZhJEhhiNzX/yropfYtJ54b6a0J4D55qTmC6WuyHWg0Z4I/zzF+9G6IlBoys8GH8dCLft+w==
X-Received: by 2002:a02:c857:: with SMTP id r23mr8717253jao.139.1566635225936;
        Sat, 24 Aug 2019 01:27:05 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id e12sm4826527iob.66.2019.08.24.01.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2019 01:27:05 -0700 (PDT)
Date:   Sat, 24 Aug 2019 04:27:03 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH 07/13] t4014: drop redirections to /dev/null
Message-ID: <804b3163f866cce0b8a928256b5009fc42dbc709.1566635008.git.liu.denton@gmail.com>
References: <cover.1566285151.git.liu.denton@gmail.com>
 <cover.1566635008.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1566635008.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since output is silenced when running without `-v` and debugging output
is useful with `-v`, remove redirections to /dev/null as it is not
useful.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t4014-format-patch.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index c07d868491..2048fb2008 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1502,42 +1502,42 @@ test_expect_success 'cover letter using branch description (1)' '
 	git checkout rebuild-1 &&
 	test_config branch.rebuild-1.description hello &&
 	git format-patch --stdout --cover-letter master >actual &&
-	grep hello actual >/dev/null
+	grep hello actual
 '
 
 test_expect_success 'cover letter using branch description (2)' '
 	git checkout rebuild-1 &&
 	test_config branch.rebuild-1.description hello &&
 	git format-patch --stdout --cover-letter rebuild-1~2..rebuild-1 >actual &&
-	grep hello actual >/dev/null
+	grep hello actual
 '
 
 test_expect_success 'cover letter using branch description (3)' '
 	git checkout rebuild-1 &&
 	test_config branch.rebuild-1.description hello &&
 	git format-patch --stdout --cover-letter ^master rebuild-1 >actual &&
-	grep hello actual >/dev/null
+	grep hello actual
 '
 
 test_expect_success 'cover letter using branch description (4)' '
 	git checkout rebuild-1 &&
 	test_config branch.rebuild-1.description hello &&
 	git format-patch --stdout --cover-letter master.. >actual &&
-	grep hello actual >/dev/null
+	grep hello actual
 '
 
 test_expect_success 'cover letter using branch description (5)' '
 	git checkout rebuild-1 &&
 	test_config branch.rebuild-1.description hello &&
 	git format-patch --stdout --cover-letter -2 HEAD >actual &&
-	grep hello actual >/dev/null
+	grep hello actual
 '
 
 test_expect_success 'cover letter using branch description (6)' '
 	git checkout rebuild-1 &&
 	test_config branch.rebuild-1.description hello &&
 	git format-patch --stdout --cover-letter -2 >actual &&
-	grep hello actual >/dev/null
+	grep hello actual
 '
 
 test_expect_success 'cover letter with nothing' '
-- 
2.23.0.248.g3a9dd8fb08

