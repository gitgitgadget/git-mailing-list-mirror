Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95F9F1F424
	for <e@80x24.org>; Wed,  9 May 2018 02:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933547AbeEICNh (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 22:13:37 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:43433 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932484AbeEICNc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 22:13:32 -0400
Received: by mail-pl0-f68.google.com with SMTP id a39-v6so3344433pla.10
        for <git@vger.kernel.org>; Tue, 08 May 2018 19:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FpYAGWsv1De+FxGexr40qMpKCfFrIGeKdYu2kofHgko=;
        b=xtEYyYMPzYaPsiI2WTV3hfbCeDEE7c8bC1bk48kkc8kBbAoKUYjLJxy/lcP1/tvt0R
         MyuBj7heR3rMHWqfTMaFGRVNAFRFaMh5G+q7Cecbz463pSWKyaa2kJcUtnKHNXDN7Qj3
         Lxt4BDDTtOdr2ldUweMaybNS3OtpOmXcz0GYI9QytWKkOSHhhlBlTCzvNomhU7EhuHVt
         Uet3Q9us2oS4deHxhhVjqh5+1CeMnNt7lw7zzRcwCwI/oGFoGVXhSDpl0XQsqICB1xlf
         FbnfDDXsOq5AQct8avPTu8GNUEVmHw3MqbTrVY7n+LtXhxXZZKi2mKOShumjrsS9QfXn
         N1ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FpYAGWsv1De+FxGexr40qMpKCfFrIGeKdYu2kofHgko=;
        b=P1aVpn0FvfY3cGUjlS2L9VQxE3rWVV45LfGJ51TkxOhwFSv06EC6hDNFDCgNY0RGin
         QxNnQllH9MxjMMfW0b54FUKLAfuo44kI1YHNCMLfK+xZuaaci45iSKU7hkw0pzleWvC8
         LLYjS2Pjcd8Y/kWWlozKWL/L1zSI7cJ0l4X8yh3CjQV6hjPw34z6QOfQbXcWWOF2d/Q6
         3Uf6PTCXPurvVlmLPTDyd8bwd1xoCJ0C674IBtF38vK8ecn1GLLTabxXI4AxvCWVARNX
         /4sflhIJ+wcknfr3h16l8x9A+6tBY6QoniLTz/vpzczuoGw4oJLF7PMeEKG3TLMSkA7j
         RoVA==
X-Gm-Message-State: ALQs6tAGv4pCd3KXXWI7Y/6AYVlb622R9yAIUZXVUOpyXu1NyJX+Vdrh
        asAHsHokHdBJnVNEMp074BaWfmUvR24g/g==
X-Google-Smtp-Source: AB8JxZpJfnh8WqiNrq0QU0gYijGU/HUj9jTZGfyAngCXgW+p6b7LiPX+q8rIK4bgLYyxiTLbZRrieQ==
X-Received: by 2002:a17:902:52ed:: with SMTP id a100-v6mr43775593pli.131.1525832011209;
        Tue, 08 May 2018 19:13:31 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:d537:72d4:95b0:7812])
        by smtp.gmail.com with ESMTPSA id z83sm21146822pfd.103.2018.05.08.19.13.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 May 2018 19:13:30 -0700 (PDT)
Date:   Tue, 8 May 2018 19:13:29 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com, l.s.r@web.de,
        martin.agren@gmail.com, pclouds@gmail.com, peff@peff.net,
        phillip.wood@talktalk.net, sunshine@sunshineco.com
Subject: [PATCH v5 1/7] Documentation/config.txt: camel-case lineNumber for
 consistency
Message-ID: <7c4bdff4ecd74448efffd35726681f62de7a9ed6.1525831201.git.me@ttaylorr.com>
References: <20180421034530.GB24606@syl.local>
 <cover.1525831201.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1525831201.git.me@ttaylorr.com>
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

