Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D380320248
	for <e@80x24.org>; Tue, 26 Mar 2019 07:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731310AbfCZHx2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Mar 2019 03:53:28 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39469 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730944AbfCZHx0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Mar 2019 03:53:26 -0400
Received: by mail-pl1-f194.google.com with SMTP id b65so1252596plb.6
        for <git@vger.kernel.org>; Tue, 26 Mar 2019 00:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Kw4Vk3zj8pEqFYAEyKwjoev5rfukJjUM1HRy3BYUaUo=;
        b=d4H/WALyFHd7z4hTCWK4CdbpCdrSYv916JZId8SyHrh9JsBDiqKUxoAPSLcZj19Bs+
         smuqWqGbcj20P82I9Rbt5iM2idVEOjrjqyvUZldWbshnOuaROkTXug2ZH/g5GS76LO8C
         zIh4BVgVDibxNZF0ueAPh2KczEYPZGwYlLT37RhPuQepxImbh0H62zbrfnbTWSNjts5r
         AwJNNEaJ5zsgE3Tu0Yvq0xOFzShIAC8NcZFzP1BpbdLKelhylvdeU0Hom4LYvvWGWvSS
         64P7uX/fRA1iHShoEMMGGT2+ZYaMop+aDCXTVGFYCM6d2kKEVjloYIP8YWKwXRQMfOVc
         3xqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Kw4Vk3zj8pEqFYAEyKwjoev5rfukJjUM1HRy3BYUaUo=;
        b=isjBXJVOp8N5uoPbttNebHRlm6SFKmZqlWcJJVfabDEUm9qiZpPxWzOanTsVVvMp7E
         chodmmM3f18Wbj73uQ9mko9GaAO+LdYXNaKcJafmehXp/1HA410WHlA66AGIDQqAMjVY
         hse24PAg3n2z/scd6Zzaid9cRdjzFGnA7hRUnRjONTmX++Vx/dMNGIaXEEL2026NquYg
         lDc7DJM6YvDEMKPud2wJwH34Kav679pg1Qa9InjR5rFuo6qU/OKrnT3Yd05EbfO2uy93
         BRk5yq7WRTpeJdE9sdCAN1zQq3cUiiG/dBVZhmSqDpLHbdg/iA1GH7h4oJVYVGv9uZ5H
         wnBQ==
X-Gm-Message-State: APjAAAUZOfswJsOljSwosVCHVprpTllKqShT2MAGuOO4y1/YaRzrHpSZ
        NoMtdBz7gIJpH5+wmYZWNIaKv667
X-Google-Smtp-Source: APXvYqw4e07Kue0B6sTuYC5hkJhAzx19J0jh26rrcCiYjHUj3LM8X/yluLj2aDZY88curEky7Bz5JQ==
X-Received: by 2002:a17:902:a81:: with SMTP id 1mr29756599plp.308.1553586805602;
        Tue, 26 Mar 2019 00:53:25 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id d69sm16655661pfg.26.2019.03.26.00.53.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 00:53:24 -0700 (PDT)
Date:   Tue, 26 Mar 2019 00:53:23 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Robert Dailey <rcdailey.lists@gmail.com>
Subject: [PATCH 3/3] git-tag.txt: document --allow-recursive-tag option
Message-ID: <fe503ddc8f01f3c0c598b00da22c201a7f16ba7f.1553586707.git.liu.denton@gmail.com>
References: <20190325233723.GD23728@sigill.intra.peff.net>
 <cover.1553586707.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1553586707.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-tag.txt | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index a74e7b926d..7e7eb9a7e9 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git tag' [-a | -s | -u <keyid>] [-f] [-m <msg> | -F <file>] [-e]
-	<tagname> [<commit> | <object>]
+	[--allow-recursive-tag] <tagname> [<commit> | <object>]
 'git tag' -d <tagname>...
 'git tag' [-n[<num>]] -l [--contains <commit>] [--no-contains <commit>]
 	[--points-at <object>] [--column[=<options>] | --no-column]
@@ -193,6 +193,11 @@ This option is only applicable when listing tags without annotation lines.
 	that of linkgit:git-for-each-ref[1].  When unspecified,
 	defaults to `%(refname:strip=2)`.
 
+--allow-recursive-tag::
+	Usually recursively tagging a tag object is a mistake and the
+	command prevents you from making such a tag. This option
+	bypasses the safety and allows this to happen.
+
 <tagname>::
 	The name of the tag to create, delete, or describe.
 	The new tag name must pass all checks defined by
-- 
2.21.0.512.g57bf1b23e1

