Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 843CF1F454
	for <e@80x24.org>; Thu, 25 Oct 2018 11:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbeJYTh3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 15:37:29 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42037 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbeJYTh2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 15:37:28 -0400
Received: by mail-pl1-f194.google.com with SMTP id t6-v6so3649666plo.9
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 04:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t4NzXWwR8Caddhtr8/H7jijAPXDoy4qtgq3g303mE+Y=;
        b=HRKU7jvnwOkrsi50Ciaj//pGOFR4mJuwiVKzLlzeMRSBA0THajKzRVCHjweQSGpSvG
         moucyzB3UR7mFR1o8aNr3ZWYJAizyCxxlY3jN3SoYDfbfcUn7S5QfWEEkYEdbkMx+It1
         IaxboX1xOox0EzpGjfXBcC0yN1Bfur3sAR4tvIi+IOfAG4tAhqeL/3Fc3uOAHk+lJDN6
         j5SY0BpEXYrUw1KIQ2IE5WJxPoAj8VTf8mFkwiO4GhwAATWbtxOyKfjx61AF/bMXOZ6/
         K8M8KCEfapTZnOjTpQ0RAfZWL3ers/akEGvJOQbWNx0oQQGOdR9VmHzPVMD4xFVxOIs0
         ANPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t4NzXWwR8Caddhtr8/H7jijAPXDoy4qtgq3g303mE+Y=;
        b=oWuXfgOwhtke7sJ4FN4KaixMWLWfb129eOWBobDEzlXGWrAKWujPoR02pn28ege7yr
         JrBdQDv4v6S0+JZxKJlobW1qRK0aU06kLpFNch6SSFUE6aBs97RdgdVRR38aWpzHFd48
         eI+oI6FYQCxrXCSMn1TWCdKTxT9pJP4ekqLMXtuFnqZT63G4P2OhCwg9Edc6Ak+HIOGK
         ZmifMg+aKhCcA6vslQ6GGGr3CUh1ichWdiwSCceu9Wk5er+ht+cdzgM8gfsfD++AyVH0
         kOkofgDQtH74So8uEPeiKiX2k7OiMJvlzycxrPlRVA1KmrFTBluH6zGbgWLinGvnim9K
         tbFQ==
X-Gm-Message-State: AGRZ1gJUDmzKS6E6QTY5p+o8WE4EZbC4c70K06Bl1xKY+Runqqht3n4d
        OooLhWkDHZJfG4Wt5dhBtrzIg2lFkes=
X-Google-Smtp-Source: AJdET5eeQ94/TbLir9RSHq4fudMXVZ81WYZq+jokYwkOuaTfCnKZHNttYe17t/Kcd+fWHTm/Y0fqBQ==
X-Received: by 2002:a17:902:20c5:: with SMTP id v5-v6mr1080689plg.62.1540465511632;
        Thu, 25 Oct 2018 04:05:11 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id 74-v6sm17545405pfx.182.2018.10.25.04.05.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Oct 2018 04:05:11 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, peff@peff.net, chriscool@tuxfamily.org,
        l.s.r@web.de, ramsay@ramsayjones.plus.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 2/3] khash: silence -Wunused-function in delta-islands from khash
Date:   Thu, 25 Oct 2018 04:04:26 -0700
Message-Id: <20181025110427.13655-3-carenas@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181025110427.13655-1-carenas@gmail.com>
References: <20181025110427.13655-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

showing the following when compiled with latest clang (OpenBSD, Fedora
and macOS):

delta-islands.c:23:1: warning: unused function 'kh_destroy_str'
      [-Wunused-function]
delta-islands.c:23:1: warning: unused function 'kh_clear_str'
      [-Wunused-function]
delta-islands.c:23:1: warning: unused function 'kh_del_str' [-Wunused-function]

Reported-by: René Scharfe <l.s.r@web.de>
Suggested-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 khash.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/khash.h b/khash.h
index d10caa0c35..532109c87f 100644
--- a/khash.h
+++ b/khash.h
@@ -234,7 +234,7 @@ static const double __ac_HASH_UPPER = 0.77;
 	__KHASH_IMPL(name, SCOPE, khkey_t, khval_t, kh_is_map, __hash_func, __hash_equal)
 
 #define KHASH_INIT(name, khkey_t, khval_t, kh_is_map, __hash_func, __hash_equal) \
-	KHASH_INIT2(name, static inline, khkey_t, khval_t, kh_is_map, __hash_func, __hash_equal)
+	KHASH_INIT2(name, MAYBE_UNUSED static inline, khkey_t, khval_t, kh_is_map, __hash_func, __hash_equal)
 
 /* Other convenient macros... */
 
-- 
2.19.1

