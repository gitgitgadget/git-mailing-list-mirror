Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47DEA1F406
	for <e@80x24.org>; Sat, 12 May 2018 03:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751164AbeELDLE (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 23:11:04 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:43898 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751092AbeELDLE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 23:11:04 -0400
Received: by mail-pf0-f196.google.com with SMTP id j20-v6so3529378pff.10
        for <git@vger.kernel.org>; Fri, 11 May 2018 20:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FpYAGWsv1De+FxGexr40qMpKCfFrIGeKdYu2kofHgko=;
        b=Pjb7rw14DtqHMoWzcjriFZRLDalS/GeaTohHXk8oJF0+AWs0Mp2r7vNNEgePksCmoo
         ItfuKrKEUzZCM+o8IxhK8JTktdjAMHIwfnA5pO92IAKMU/Mw6lA0iKh8cCcOkzJ8qRme
         PGZTZI+ZCjqdztvxHTL6W93oE1QEdCh7bBI6BumaOx0Sh2qZzvLqGslvufMmA+oUp3lo
         hYxiw92+/soXB4ndsworD7PGxrnLZ1mmOFRSTT/yCYiR4ombxKpvGcZGfUx3N60Sdgdh
         CGAKKN8kG34j1ZSWrfJpd+UC1ZAt9PN94yMV3jbNi4jwmnvTy+yVjBWg/pwYxuYAvPOQ
         UdCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FpYAGWsv1De+FxGexr40qMpKCfFrIGeKdYu2kofHgko=;
        b=Y8rqdmyN/YrRyAG7kZXQuNw4QvZjKpWBCL1XIOm1lrOvmROQAzV2QONE00/kUrRx5j
         ZNlJizo0HEOvMRVSRwqKSfc2sF+9HJwKBp6VURg1fxrxQ9Ixwk/QWZA1YTGo5oYoCTLH
         Vwse/PUnEauzF6x5TuYQiJXAygM7Sc83Ne2GH096Voh6YrGgOafXlrjojE1BQDiJWyE/
         1oZvy+0dc2jnykXfroVSFWUds2csgPiMMw+cI8ePcf3K2SRcgOktyMfBXBI/M6+SCdTT
         HhOFoObqjnaeGSABNyjqXb2gP0PLzSJb3dg+WLeh/DlGp9oPb8Op8xXnWZ6JI2oVzGAQ
         EBPQ==
X-Gm-Message-State: ALKqPwc1D1JFb6M2y+RnLe+EwSqnanmEqaqfqvGvKxDXdDJ4h/iemgeB
        tY5lXAkk/Z5ljLvaaTRZery5460+p44=
X-Google-Smtp-Source: AB8JxZoB7U+NVQ5NByCCYgY+ZIXxYZjH1cnPWpxqjGl+GvhCkT44MQ12+ficbuM1fZ2ebhQ+Ij42lA==
X-Received: by 2002:a63:7f4f:: with SMTP id p15-v6mr1317995pgn.319.1526094662916;
        Fri, 11 May 2018 20:11:02 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:81b:33bd:f4a4:78cd])
        by smtp.gmail.com with ESMTPSA id d62-v6sm7846351pga.29.2018.05.11.20.11.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 May 2018 20:11:01 -0700 (PDT)
Date:   Fri, 11 May 2018 20:11:00 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, l.s.r@web.de, martin.agren@gmail.com,
        peff@peff.net, phillip.wood@talktalk.net
Subject: [PATCH v6 1/7] Documentation/config.txt: camel-case lineNumber for
 consistency
Message-ID: <7c4bdff4ecd74448efffd35726681f62de7a9ed6.1526094383.git.me@ttaylorr.com>
References: <20180421034530.GB24606@syl.local>
 <cover.1526094383.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1526094383.git.me@ttaylorr.com>
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

