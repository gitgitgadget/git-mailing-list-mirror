Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 347071F404
	for <e@80x24.org>; Thu, 23 Aug 2018 21:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbeHXB3h (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 21:29:37 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60915 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbeHXB3h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 21:29:37 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A1FFBF5EA0;
        Thu, 23 Aug 2018 17:57:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=kAUF
        2aWXsi/BQ+/vfsZ4Sw6mgPo=; b=O6FXyiJpcN9f0wVJpX7d2/OT0Fh/ZoLE2uw9
        DgOMhF3EgKMBlipETr9l/SvhSFs3FLOJQysPxV8SOTWArNQXTynE+n6yJa1jjJXA
        SHpdyzUciKDur6JDiY1Ry4jP0qNQ75gGzzdLhViIN2dA2EqEJdUncAGI1uDwlhCi
        Aw+ve+Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 99E67F5E9E;
        Thu, 23 Aug 2018 17:57:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:date:message-id:in-reply-to:references; s=mesmtp;
 bh=cdTbVAqrWBvXuFn6Ktb6wH/VlzNeTJImKcyukbITakA=;
 b=OxOj1fUVEgpIOCn0KqfMe4A+6UOgpJW/m9IrOfUrNUnkr/SH4adovKTxC8oHHrvkYAf/PtFlzKJ06CDz0gE06QYc1b6ipl1Ey8nL6yy/DUtoq3JMlJaMPsVWXhZmdRVSWQIRh6+drY10LhuZa6PwtPKjQeJBapbyqdIpDnPkxg8=
Received: from hylob.local (unknown [76.118.43.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BE5E4F5E9D;
        Thu, 23 Aug 2018 17:57:53 -0400 (EDT)
From:   Kyle Meyer <kyle@kyleam.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org,
        Johannes.Schindelin@gmx.de
Subject: [PATCH v3] range-diff: update stale summary of --no-dual-color
Date:   Thu, 23 Aug 2018 17:57:48 -0400
Message-Id: <20180823215748.3474-1-kyle@kyleam.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823211028.GA99542@aiede.svl.corp.google.com>
References: <20180823211028.GA99542@aiede.svl.corp.google.com>
X-Pobox-Relay-ID: 9644D29C-A71F-11E8-9FF6-BFB3E64BB12D-24757444!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

275267937b (range-diff: make dual-color the default mode, 2018-08-13)
replaced --dual-color with --no-dual-color but left the option's
summary untouched.  Rewrite the summary to describe --no-dual-color
rather than dual-color.

Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Kyle Meyer <kyle@kyleam.com>
---
 builtin/range-diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index f52d45d9d6..0aa9bed41f 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -25,7 +25,7 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 		OPT_INTEGER(0, "creation-factor", &creation_factor,
 			    N_("Percentage by which creation is weighted")),
 		OPT_BOOL(0, "no-dual-color", &simple_color,
-			    N_("color both diff and diff-between-diffs")),
+			    N_("use simple diff colors")),
 		OPT_END()
 	};
 	int i, j, res = 0;
-- 
2.18.0

