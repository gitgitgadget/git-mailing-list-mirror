Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DC071F954
	for <e@80x24.org>; Thu, 23 Aug 2018 02:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbeHWGHb (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 02:07:31 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54012 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbeHWGHb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 02:07:31 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 66C80F5333;
        Wed, 22 Aug 2018 22:40:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id; s=sasl; bh=b+pWfBbX69Nc48eimdFX37WxUeM
        =; b=h/jq6y/wXb2S5IabSrw3ttSV5c5cLdFsDrkgBHT9DFjUfMcQwcvoL+Useg7
        zqO6RpvRaT1jaWhJbKMcFoZtjhrXZ0nsaZiJ22Cb7UWxcP4kqsHdaXQzPY/uW2lT
        JoK/aHkTH03/NyvfYN4hPaFHHNvwjSWhJko53D9bUcIfYvN4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5A28EF5332;
        Wed, 22 Aug 2018 22:40:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:date:message-id; s=mesmtp;
 bh=U19Z3dO5G41wdXPBmvGGxZmkpZj1+d8qAn8N3l/ycx4=;
 b=dHcPM/0rP/I2gNvjrtlJbw50MLiWpvQJMtDyBDbznKn386Tgzi28WdEYejcBwBO3+orP4WY2QiHEf51xUHHIga3KFRh7xZChCCC10KqzxDVM5ypj15WWEsWRlKodf7a84OKtqXDtl0Kgy7c4YuK/AjwYvdGj8HzR1lUD0uOMvF8=
Received: from hylob.local (unknown [76.118.43.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 58421F5331;
        Wed, 22 Aug 2018 22:40:06 -0400 (EDT)
From:   Kyle Meyer <kyle@kyleam.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, Kyle Meyer <kyle@kyleam.com>
Subject: [PATCH] range-diff: update stale summary of --no-dual-color
Date:   Wed, 22 Aug 2018 22:39:55 -0400
Message-Id: <20180823023955.12980-1-kyle@kyleam.com>
X-Mailer: git-send-email 2.18.0
X-Pobox-Relay-ID: D8489E32-A67D-11E8-81F2-063AD72159A7-24757444!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

275267937b (range-diff: make dual-color the default mode, 2018-08-13)
replaced --dual-color with --no-dual-color but left the option's
summary untouched.  Rewrite the summary to describe --no-dual-color
rather than dual-color.

Signed-off-by: Kyle Meyer <kyle@kyleam.com>
---
 builtin/range-diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index f52d45d9d6..7dc90a5ec3 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -25,7 +25,7 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 		OPT_INTEGER(0, "creation-factor", &creation_factor,
 			    N_("Percentage by which creation is weighted")),
 		OPT_BOOL(0, "no-dual-color", &simple_color,
-			    N_("color both diff and diff-between-diffs")),
+			    N_("restrict coloring to outer diff markers")),
 		OPT_END()
 	};
 	int i, j, res = 0;
-- 
2.18.0

