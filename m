Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3A82200B9
	for <e@80x24.org>; Sat,  5 May 2018 02:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751775AbeEECm5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 22:42:57 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35079 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751572AbeEECm4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 22:42:56 -0400
Received: by mail-pf0-f196.google.com with SMTP id j5so18790951pfh.2
        for <git@vger.kernel.org>; Fri, 04 May 2018 19:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FpYAGWsv1De+FxGexr40qMpKCfFrIGeKdYu2kofHgko=;
        b=oBwm57NBrhYMFBwk4SNroLw3IDj/05kWHOWvwnWTlloyNR3F9m7j2rGBGB3Pb3PndC
         8/x1G8a/RxDm30klSRhvDPD1m9XpNSguH0xYsmpxI7kWQmi1IUwPtG8jX0KTR6faBVJW
         6fZUOpzi2EswIOaT2HYtU61m/vzlll/Dj/RP1ODVYgTDRWcUWBzz16maK3wV9dVOBmR1
         daUrRVbUritSThzN08cxThCSLhjJzARdqIgjlfFxF6W2xbVWum5pv4aLaob9EpCRJJdR
         RjVHX3LcgBOh8/n7YnRUTXDnKvkOmcemS3fqOFpRvGet2RbY5thf+liT4Mx9XmR3naWf
         Ye4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FpYAGWsv1De+FxGexr40qMpKCfFrIGeKdYu2kofHgko=;
        b=C7to4CRYev7nxAfXi0WZif8fF58PmU8zTswXXv0Gbdt7nYAQ9bQjjoU3r7nw1z/yb8
         bR5iBPReMoNiWexe/UsGvG6QoglzQBbs2EBCqL5cNYBZsfITyZw2HnDlLV6dD6EBc6k1
         CuwUTqzNTnuN91J+h9TJJDIvuh+UNW6V30SLdPeUvIxAgUOLTUwYm6W3e/RFgtvS/TMf
         LtR6KzwqaZ+A2FKOi8BrDWyRfSXhzm8khLS3ycYTdyxkZHd//0/4RI8ieSKB0UAXSdiX
         RcKf0+AFdTZteOEIsk6WVvmoP+Di0P2GDMdee4iKqt5eUhm0XrzWYybCrBo6QmCYEqPl
         j1pg==
X-Gm-Message-State: ALQs6tBKZCk5c/FkuiII/2DcjZEGXvkKJuzCjFxjuoLPqcE+3NdOLAyB
        WGXYJcSLbZ3rA568ub4SAJX3U/e3UZkypA==
X-Google-Smtp-Source: AB8JxZrvrw9XPjM0bm0LmiDZp/2jpTXsMcVSHxeFjLvdJuiVvmv3cJlpLjkR0ePOnK7zqhqkMXEA3w==
X-Received: by 10.98.253.18 with SMTP id p18mr10416719pfh.152.1525488174901;
        Fri, 04 May 2018 19:42:54 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:a961:c277:c90f:2435])
        by smtp.gmail.com with ESMTPSA id m66sm20930731pfb.82.2018.05.04.19.42.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 May 2018 19:42:53 -0700 (PDT)
Date:   Fri, 4 May 2018 19:42:52 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com, l.s.r@web.de,
        martin.agren@gmail.com, peff@peff.net, sunshine@sunshineco.com
Subject: [PATCH v4 1/7] Documentation/config.txt: camel-case lineNumber for
 consistency
Message-ID: <7c4bdff4ecd74448efffd35726681f62de7a9ed6.1525488108.git.me@ttaylorr.com>
References: <20180421034530.GB24606@syl.local>
 <cover.1525488108.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1525488108.git.me@ttaylorr.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

lineNumber has casing that is inconsistent with surrounding options,
like color.grep.matchContext, and color.grep.matchSelected. Re-case this
documentation in order to be consistent with the text around it, and to
ensure that new entries are consistent, too.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/config.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2659153cb3..6e8d969f52 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1157,7 +1157,7 @@ color.grep.<slot>::
 	filename prefix (when not using `-h`)
 `function`;;
 	function name lines (when using `-p`)
-`linenumber`;;
+`lineNumber`;;
 	line number prefix (when using `-n`)
 `match`;;
 	matching text (same as setting `matchContext` and `matchSelected`)
-- 
2.17.0

