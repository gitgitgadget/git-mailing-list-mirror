Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72B111F403
	for <e@80x24.org>; Tue,  5 Jun 2018 19:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752411AbeFETzA (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 15:55:00 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:40976 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752380AbeFETyz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 15:54:55 -0400
Received: by mail-wr0-f193.google.com with SMTP id h10-v6so3689860wrq.8
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 12:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=rseXWAEWzGIJL8ZnqvruII/12SqgVLomIti3nIGKpuU=;
        b=WO0QkNFNW++3ZiJnskcXXxBEAKtYnutrgYmR9zalXOKfeEtO30NMdCa3G/6HAOz1Gh
         VbDbdHW0Im7/zVMFSCTFsYgnjqrBcjY8us0817zwSthp6CFAVFHLHe+zivKzBGqOWWps
         HdXM/eGM4A6a21CZ5/Xxrz7SvCIDojGsS4WRV12RU7qlMlYe8EDO0AJ7Xhiso9mme6e0
         pVVW72Rp908FuuUuKI6YnYoacWJ4DcVLU7hYZ1n8joh15KRG0mwJ57hzzinlqqYt1xzb
         vsscqRhhxGQhkD0IO98y93wIw3zgiUr1n34cjDY/umf6WJ1ane9mEfvuueHRJ6JkFNZn
         cU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=rseXWAEWzGIJL8ZnqvruII/12SqgVLomIti3nIGKpuU=;
        b=SCAPYV7VZNArjGRTTbtR/trixsh2oO4MnbbBnm5YRdhVa2RFrVcZMtIEhCnAaR8tgx
         2xfQ/ycXeMa/UIN3eFoyLeKHJ3q1yOPyUpVH8LDM5BY+sC5UgV2YaZhnxuevgYMBnQJ9
         MN4+N9Qg7hcuC9cJC32gLoHxxm5IReKc7B/1KokUOf5Rt95lEGa+Jq6xR1GGeHqbQWIW
         L7xNDIyjUBzTtve3sg65sqIlS5MWt3/OppSN0rc5vRFdYUMeNNZnIuxtIZy7p6Fl/LTA
         zepxN3uaV6Oz4GC9rPLJ6NFYUpOYRkdOzXKHiO0UYTWnZhpTIq/ReyBtMDwxBquvu0uh
         jw3A==
X-Gm-Message-State: APt69E3IScb5W/31RvkyjCt0uS/ielQQikLyQG/yB9g3AHDwCCiKXMRy
        g2a5dlEMGn9GAw1vIv56/Ab8NQt+
X-Google-Smtp-Source: ADUXVKJHUxuW1f0fapfzJsqb8l3XSukzFJWcTAn6Fk8jUYsNGH/gxYfEmfLcxOOFyL7CPv5SGMBhnQ==
X-Received: by 2002:adf:b587:: with SMTP id c7-v6mr12537wre.141.1528228493609;
        Tue, 05 Jun 2018 12:54:53 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id o2-v6sm2252533wmo.24.2018.06.05.12.54.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jun 2018 12:54:52 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/3] refspec: initalize `refspec_item` in `valid_fetch_refspec()`
Date:   Tue,  5 Jun 2018 19:54:40 +0000
Message-Id: <20180605195440.8505-4-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180605195440.8505-1-avarab@gmail.com>
References: <20180605195440.8505-1-avarab@gmail.com>
In-Reply-To: <20180605162939.GA158365@google.com>
References: <20180605162939.GA158365@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Martin Ågren <martin.agren@gmail.com>

We allocate a `struct refspec_item` on the stack without initializing
it. In particular, its `dst` and `src` members will contain some random
data from the stack. When we later call `refspec_item_clear()`, it will
call `free()` on those pointers. So if the call to `parse_refspec()` did
not assign to them, we will be freeing some random "pointers". This is
undefined behavior.

To the best of my understanding, this cannot currently be triggered by
user-provided data. And for what it's worth, the test-suite does not
trigger this with SANITIZE=address. It can be provoked by calling
`valid_fetch_refspec(":*")`.

Zero the struct, as is done in other users of `struct refspec_item` by
using the refspec_item_init() initialization function.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refspec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refspec.c b/refspec.c
index a35493e35e..e8010dce0c 100644
--- a/refspec.c
+++ b/refspec.c
@@ -196,7 +196,7 @@ void refspec_clear(struct refspec *rs)
 int valid_fetch_refspec(const char *fetch_refspec_str)
 {
 	struct refspec_item refspec;
-	int ret = parse_refspec(&refspec, fetch_refspec_str, REFSPEC_FETCH);
+	int ret = refspec_item_init(&refspec, fetch_refspec_str, REFSPEC_FETCH);
 	refspec_item_clear(&refspec);
 	return ret;
 }
-- 
2.17.0.290.gded63e768a

