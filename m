Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16A4A1F405
	for <e@80x24.org>; Sat, 15 Dec 2018 11:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730022AbeLOL2H (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Dec 2018 06:28:07 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37378 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729687AbeLOL2G (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Dec 2018 06:28:06 -0500
Received: by mail-lj1-f196.google.com with SMTP id e5-v6so7094890lja.4
        for <git@vger.kernel.org>; Sat, 15 Dec 2018 03:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=v2unD8Ccn9zHdGK2QLB6y4As0xFRgGXyjONU074gM9k=;
        b=YteGj5eMswr/XKF7malcQUF+3HPFP06OjHYSKInbfWCEyKoxbbQc2OJfCTdiwDoC2G
         dCUcxrMlOpKMFvBQnaiW+9OI3UBCsyF7n4lzhxglE1c6XAMW7S++ny1YN+/VhUu2SKC9
         afImlqRRIromnD71UhpjymFj71NqH1eMweQvF42me072JPWtut6/d2VCDB3jn2BAD43L
         KYw0WXMFJuTxNujfnlGsX+kFpK/5OvfxUNYSsTa26qzVmwgy5h4J7DBkatwizbSAkwQ+
         1hsrkE7mCaick7p3ClQLcx+xg24mVi47DOXleYMAshuID/Ux6GGWl4OeVGKD+jS1huz2
         Me0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v2unD8Ccn9zHdGK2QLB6y4As0xFRgGXyjONU074gM9k=;
        b=HSxT9CT6fXbj0Q5wQedK51S/6QDtgMmsA56cWpoY+YARY4pbtj5EbeLIrevLxjPG6W
         9o7pFMKgJWigpPTNAWJTbUUihUKYYFkrtO9dUiItBgxrgKdU11Yjt2vLebslRsxxoW5T
         RCaG4BWCeGnFudcFwOVojxpRsZDz9oFG15kt6f1AZL4SyiM26zavmcgbkTlQU165c3u0
         pzlnlOYOZrKRZugJqa0YzTiP0wRFtmnR5ohyhDaPSldnalb0L5eGsjwchQCseJgiRgrR
         kyz/x07oJwwa3vousP3xuPCzGh59FLqeaRG82bCHAePoL8nih9uNvuShCW+oB2/qmweS
         czGQ==
X-Gm-Message-State: AA+aEWYltUMZ0MW3U7CQZBvBfj3QTVIn6ErhfePK+goCXEQz1yUvj5pE
        AC0QmAGZ2wnFmXL7EU+R1PsTrwHx
X-Google-Smtp-Source: AFSGD/XkEBBUy0JM/n8rpsS5Rmj1MTrO0SI97f/V7n0ZTrtbsB1JJB579nusFKjxX/phNuGSmIUM6Q==
X-Received: by 2002:a2e:914b:: with SMTP id q11-v6mr3566584ljg.164.1544873283983;
        Sat, 15 Dec 2018 03:28:03 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id t18sm1439174lft.93.2018.12.15.03.28.02
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Dec 2018 03:28:03 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 3/4] rev-list-options.txt: do not nest open blocks
Date:   Sat, 15 Dec 2018 12:27:41 +0100
Message-Id: <20181215112742.1475882-4-martin.agren@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181215112742.1475882-1-martin.agren@gmail.com>
References: <20181215112742.1475882-1-martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Similar to the previous commit, it appears we try to nest open blocks,
which does not work well with Asciidoctor. Drop the outer one. That
fixes the indentation similar to the previous patch, and makes us stop
rendering a literal '+' before "Under --pretty=oneline ...". Asciidoc
renders identically before and after this patch, both man-page and html.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 See https://git-scm.com/docs/git-log#git-log--g and
 https://git-scm.com/docs/git-rev-list#git-rev-list--g . The indentation
 doesn't look too bad, but the "+ Under" is clearly wrong.

 Documentation/rev-list-options.txt | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index bab5f50b17..98b538bc77 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -13,8 +13,6 @@ has a line that matches `<pattern>`), unless otherwise noted.
 Note that these are applied before commit
 ordering and formatting options, such as `--reverse`.
 
---
-
 -<number>::
 -n <number>::
 --max-count=<number>::
@@ -308,8 +306,6 @@ ifdef::git-rev-list[]
 	`<header>` text will be printed with each progress update.
 endif::git-rev-list[]
 
---
-
 History Simplification
 ~~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.20.1

