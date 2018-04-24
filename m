Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C7EE1F424
	for <e@80x24.org>; Tue, 24 Apr 2018 05:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755692AbeDXFHl (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 01:07:41 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:41892 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755603AbeDXFHj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 01:07:39 -0400
Received: by mail-pg0-f66.google.com with SMTP id m21so6961165pgv.8
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 22:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FpYAGWsv1De+FxGexr40qMpKCfFrIGeKdYu2kofHgko=;
        b=QwUCV563C7zzuhfHua3VVWkNGt7fd4nwlBqtaNtqq7X94KgUJoR6UbcU9hlDa4gjj5
         EVd3q0SUoVU7hX2r1vwgdd8s7SOoeq8+S6YiTyINlcUcTaKkXB9z4ADO7p2FLga5NdZA
         1kYhUUpiCJf4L+8x38FxKxpWNxpylpimub8M1hiZC1VCsVry+ZFf/TwtAwgQYdfsmpDF
         ANpoWBWAleucLgcThvLA/xqHTbJ3m6GoRESH6zASiKftBA8ob+UZn72UOjjDexdSDarC
         aMUm/jf8ypOCVq55sQuTUxrK9NfrMTblgUmGbafslA+3PU4C5WeDxL71GcYnvAJOAH+n
         1fqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FpYAGWsv1De+FxGexr40qMpKCfFrIGeKdYu2kofHgko=;
        b=ixjTOZapfsa9BE+iDvEJxqVUjxAEgXLxGC7hAFAJ+xCQIHcIJdZq7NYr2Lx3yFlE6Y
         dexyj5k2uyKuyBfd4xWu/2V40Okit3qbYC4Rd0ak4wg1JefjWV9Q1/9fAZ01foqZu3tW
         5KUtoMiifbxzKwYQtH6cpArKke0BPykRAVj7BuxQjubjSLWR9f9dFFT+lGaLumrVpRIE
         rrNh/dbxyBAdTiCnDSLGCZeVha1CesgeUaUi4qurxvS8OYpfPFwaqtFDEUWpiGPa0NLv
         ljvSemcrAyNie9hXJkE1MM47BslY0TSoT6HNnUAKDPWJzzjOLfg1qdE6upeox5wCQaDp
         ubdg==
X-Gm-Message-State: ALQs6tBrAOdJudcexHTHWywD9qGztmonTM1mWhKz5zIl0qKt6G3rENhx
        VnYpzQzSqJFRUxtgVmAzbr7etrxO/LhrGQ==
X-Google-Smtp-Source: AIpwx4+5Clg2ywASkzbWWTzC1npWhPYyuFNERph1q6CJcHMyzD9eDWUcBsHVhwGVreXWZztcuTqFCg==
X-Received: by 10.98.236.24 with SMTP id k24mr18248419pfh.204.1524546458651;
        Mon, 23 Apr 2018 22:07:38 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:3dfa:3e1b:ab89:1ffb])
        by smtp.gmail.com with ESMTPSA id b3sm23146252pfi.54.2018.04.23.22.07.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Apr 2018 22:07:37 -0700 (PDT)
Date:   Mon, 23 Apr 2018 22:07:36 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com, l.s.r@web.de,
        martin.agren@gmail.com, peff@peff.net, sunshine@sunshineco.com
Subject: [PATCH v3 1/7] Documentation/config.txt: camel-case lineNumber for
 consistency
Message-ID: <95bd565d1b976d8503a13ce7cd4125f38fbf8e8b.1524545768.git.me@ttaylorr.com>
References: <20180421034530.GB24606@syl.local>
 <cover.1524545768.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1524545768.git.me@ttaylorr.com>
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

