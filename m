Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D37181FAEB
	for <e@80x24.org>; Sat, 10 Jun 2017 08:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751934AbdFJI4F (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Jun 2017 04:56:05 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34575 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751870AbdFJI4E (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2017 04:56:04 -0400
Received: by mail-wr0-f194.google.com with SMTP id u101so11224639wrc.1
        for <git@vger.kernel.org>; Sat, 10 Jun 2017 01:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+9xIpWMXeiLXd4WhJZPnldGVVCY/XMppYHxUrr147bU=;
        b=VYWAGT8X/xWvZaqKc7k5XvpA8RuH57LzQQiH42hdSaDbdMLzyPlXnC0IcFItoAg3M7
         DMh1L0vPN2cH3i8WVuwLXYtjKRjr5u11/JV8pvd23Z96cyp1eLrcWhTw57rnRqVajvq3
         5ESkPoQg911KJKx3hNg+vrJOYkx/7EIUeMZj/zlKPJKPCPLSlHZ6eoIiV2Q9p0Q92odM
         /YZu9cMS8gkBFgkn0dEcQpxOm/RmXPrdWCDJq0/z2rdNFuYt05aiXkXmzRsxrWE+pqQV
         aZhfn9iD1qVhlsFDXLCngB87un4qWsVe1pA5vJBAXjgnsMaZDcgbaFBZtxrLgGPqE3YS
         j1SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+9xIpWMXeiLXd4WhJZPnldGVVCY/XMppYHxUrr147bU=;
        b=PIlJWvLQWxFAD05Q0epSewvX+34baYIGlmuhdf1o6VCUoNKfj8Fmk+EEoWst02PCy0
         B1Ztn0rrtLllb/x5jDA7ILPXqebnqdIXEzAUkw6D4LUcWub852nlD4nffaXwvF0ETNtW
         uAycjedfXaX0F31SEjT9zpjQM3r7QH4VYF1WhoImD6Cy+RvleXW/CMsrnu5u7haEMG/w
         WfKfErK9Xc6cRdTgk1YUGqoCZ2HCfeYe8hLmHM74pFrkP8O0DjnVXrF9moHBzUQOlFTH
         PBu9TZsCyGKWxUNVTl9LywqsMP5q61X8bTT+8c6FEnxqKrEpXPy4sqFSzX+QZVwNvg5i
         5osw==
X-Gm-Message-State: AODbwcB1EBSQGPP1CtYdJmw9RZ/m278qS7cBUTa2dDuPH865GsC35MAH
        r7RmWCbgk5WTWqmen8A=
X-Received: by 10.223.139.81 with SMTP id v17mr1712430wra.70.1497084962855;
        Sat, 10 Jun 2017 01:56:02 -0700 (PDT)
Received: from arrakeen.fritz.box ([2001:a61:3439:7300:99fb:6818:11d2:739])
        by smtp.gmail.com with ESMTPSA id 47sm3716544wrb.55.2017.06.10.01.56.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 10 Jun 2017 01:56:02 -0700 (PDT)
From:   Andreas Heiduk <asheiduk@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Andreas Heiduk <asheiduk@gmail.com>
Subject: [PATCH v2 2/2] add [--] to usage of filter-branch
Date:   Sat, 10 Jun 2017 10:54:45 +0200
Message-Id: <20170610085445.6470-2-asheiduk@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170610085445.6470-1-asheiduk@gmail.com>
References: <20170603101755.13619-1-asheiduk@gmail.com>
 <20170610085445.6470-1-asheiduk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
---
 git-filter-branch.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 2758ae5eb..3a74602ef 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -87,7 +87,7 @@ USAGE="[--setup <command>] [--env-filter <command>]
 	[--commit-filter <command>] [--tag-name-filter <command>]
 	[--subdirectory-filter <directory>] [--original <namespace>]
 	[-d <directory>] [-f | --force]
-	[<rev-list options>...]"
+	[--] [<rev-list options>...]"
 
 OPTIONS_SPEC=
 . git-sh-setup
-- 
2.13.0

