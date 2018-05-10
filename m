Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E5AA1F424
	for <e@80x24.org>; Thu, 10 May 2018 06:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756569AbeEJGNQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 02:13:16 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:44225 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756350AbeEJGNP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 02:13:15 -0400
Received: by mail-lf0-f68.google.com with SMTP id h197-v6so1262837lfg.11
        for <git@vger.kernel.org>; Wed, 09 May 2018 23:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=435x9cExZ/31VRvYJCjpOqhuhvqrBB9j+MkQzHbnyqs=;
        b=atLklbSIYhFLk56LSELxnqrQuMrcXZaFPVIUiTgpLsWQTyrrQ8K9Qnk2hzkLLaqrwP
         nEQhM5bt+31sm7iXPmZMbph7ruPGlZBOTSvvESMLROyaaWnHUWx2HNHlKpoQRDTyqOwl
         S5vT1UZeTrGZt5aHueMnABexvc0y15UBrCnXRMXLIsGOp0fgjKEnjSedC9Pl9xO3BsVQ
         desFujyX5dctYvH9Ktr5ru9sET5v+8xpGCu9m+xluNRIhBqqkt7/aAGYjam1zVRZFKqB
         Q73TOwjkuuQCVo4S2RA/edV8Noz6SSrRAJV3OMCfCnFGrK2r+swEK3aQ75fUs9XaYQPx
         nK/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=435x9cExZ/31VRvYJCjpOqhuhvqrBB9j+MkQzHbnyqs=;
        b=uZBHXw1ZTL5SKkOIbMpFtZeO+99gPY3/vcnh45sfz8qvbXTt9ycIv8fgH/fHdV1WuO
         O8lAr0DS9rYFC0VJH2geFX9iYCSBC+eU55lnvxHvbP67vuJ4apf3P0/71gDV7kmJ0Ljm
         G9j9UAHNuo+m6AIWEoboLo/zc0mnwdb1rceeupaaUF4JvZWe9HTSPpub8olJs8BFx0t/
         jDlI8mqohrmJFWzqiiUcLsoMCBHcmUHzwG2qeWmghQmKXssDJ/U1+epV7tcHC4uWkHmc
         PrI9zAn8sfLiOF7S4SKJGAAk0D6yC60CWwodW6854n4IO6CfZYQj1hwoXbdNGQnm1cpZ
         Ik/g==
X-Gm-Message-State: ALKqPwdZWKXUpK6AAFPwbQxNUxlAKIO85+jmRVNfNrenb6cYdzl9Nfb4
        aUZCAZXvRa7uwlszlupY7KU9OA==
X-Google-Smtp-Source: AB8JxZodqEfgZ6bRCT1Mep8q6PBn0+EZIw8WJDQLGL2C+BvFLUr0wHObCK/lPGBzcW8K7O6zhD7PRQ==
X-Received: by 2002:a19:e5c4:: with SMTP id i65-v6mr100950lfk.112.1525932793865;
        Wed, 09 May 2018 23:13:13 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id t20-v6sm14602ljb.28.2018.05.09.23.13.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 May 2018 23:13:13 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2] repository: fix free problem with repo_clear(the_repository)
Date:   Thu, 10 May 2018 08:13:10 +0200
Message-Id: <20180510061310.28265-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180509170409.13666-1-pclouds@gmail.com>
References: <20180509170409.13666-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

the_repository is special. One of the special things about it is that
it does not allocate a new index_state object like submodules but
points to the global the_index variable instead. As a global variable,
the_index cannot be free()'d.

Add an exception for this in repo_clear(). In the future perhaps we
would be able to allocate the_repository's index on heap too. Then we
can revert this.

the_repository->index remains pointed to a clean the_index even after
repo_clear() so that it could still be used next time (e.g. in a crazy
use case where a dev switches repo in the same process).

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 v2 keeps the_repository->index pointed to the_index even after cleared

 repository.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/repository.c b/repository.c
index a4848c1bd0..4143073f89 100644
--- a/repository.c
+++ b/repository.c
@@ -238,7 +238,8 @@ void repo_clear(struct repository *repo)
 
 	if (repo->index) {
 		discard_index(repo->index);
-		FREE_AND_NULL(repo->index);
+		if (repo->index != &the_index)
+			FREE_AND_NULL(repo->index);
 	}
 }
 
-- 
2.17.0.705.g3525833791

