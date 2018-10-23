Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87E811F453
	for <e@80x24.org>; Tue, 23 Oct 2018 11:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbeJWUCV (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 16:02:21 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40452 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727720AbeJWUCV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 16:02:21 -0400
Received: by mail-pg1-f196.google.com with SMTP id o14-v6so502606pgv.7
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 04:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+qqIVQa4W8uA+0vy7jDkgBnPPDLNVNa5Cssk3E1OjUc=;
        b=ccz/WjYvieU4Bgav9Jzed8I+2aTABUPFhT9LzldnmQu8I8Xh587yDi3jwzOAqX4iHU
         j74Z1FwDSSoQq5LaHGXQ0c82qR1Yel9b0g9UTRQQ1gsyowJJrUKQpKeG6Mqa+AQ2vCK8
         4ICnCndRfAg/CLDaLtU7+cvERT4N/jGC6q0hwkCN7Wa3hJlJQu15Z7JWT1fFw7kW41Sy
         2zj1jc/ERGPr6FdFtiIPGrGFz8Mxt9N/BuGeXBN0ItAyg6ypbeqVuNVmPoNVLAqsYwV6
         Ku+RZMRQ1pkotwtAFfDdjsbUsjL2Mz7geNby9J5taKKqK7NaweyNmlh6L2VvCOcak5my
         YkOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+qqIVQa4W8uA+0vy7jDkgBnPPDLNVNa5Cssk3E1OjUc=;
        b=KsioEwMzUNKS4V6IfIxxl5sS9SkUPNih0InVhe5WLsCY2LkxqBLE3NDHafpC9R4AdN
         Rj46JZjIaNR+OZ8q2R7aM+VCGDac30uE+x5DIlCFk8r7rpMtv657jtH2spN6y5JCGdAG
         DsKuPlUiXUy8LowVdcj9K0TnztkRTF2OXXPrb/QlTsv8ZrgO15vR0az1ADi5SJh/4YW2
         RONG2iwweX2sDtfbSs/J6Q95Ddkr3oORJCXw/yBICXjgBFLYGLPL9Y8VzttsdUW9aJFU
         ju1lB1kg8N8cagCZbYeybWJSu9cRmtk3/8ioWd8UffBtKLp1tgWYlQqhTKA0tJ+u4Bzi
         V6nQ==
X-Gm-Message-State: ABuFfohKcWhlkCzkMjHtXaVodwhOc+0msUEaAtOGcbcoft/A2knGBUYI
        gPguhhb1KhXwYYxwmT1T24yerjIB6+k=
X-Google-Smtp-Source: ACcGV61Xvk14TSnZQN7D3c5lP6SGoNvLBi+v30aSl7atJdBG81VOm+ttjVS0/JI3ljHisUGbFz4dfg==
X-Received: by 2002:a62:3245:: with SMTP id y66-v6mr40308146pfy.72.1540294754256;
        Tue, 23 Oct 2018 04:39:14 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id i4-v6sm1676068pgt.4.2018.10.23.04.39.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Oct 2018 04:39:13 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH] khash: silence -Wunused-function
Date:   Tue, 23 Oct 2018 04:34:16 -0700
Message-Id: <20181023113416.90958-1-carenas@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

after 36da893114 ("config.mak.dev: enable -Wunused-function", 2018-10-18)
macro generated code should use a similar solution than commit-slab to
silence the compiler.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 khash.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/khash.h b/khash.h
index d10caa0c35..39c2833877 100644
--- a/khash.h
+++ b/khash.h
@@ -234,7 +234,7 @@ static const double __ac_HASH_UPPER = 0.77;
 	__KHASH_IMPL(name, SCOPE, khkey_t, khval_t, kh_is_map, __hash_func, __hash_equal)
 
 #define KHASH_INIT(name, khkey_t, khval_t, kh_is_map, __hash_func, __hash_equal) \
-	KHASH_INIT2(name, static inline, khkey_t, khval_t, kh_is_map, __hash_func, __hash_equal)
+	KHASH_INIT2(name, __attribute__((__unused__)) static inline, khkey_t, khval_t, kh_is_map, __hash_func, __hash_equal)
 
 /* Other convenient macros... */
 
-- 
2.19.1

