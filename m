Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D17891F461
	for <e@80x24.org>; Mon,  1 Jul 2019 20:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfGAUUn (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 16:20:43 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:36236 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbfGAUUn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 16:20:43 -0400
Received: by mail-pg1-f201.google.com with SMTP id s4so8208115pgr.3
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 13:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=C0JM8iml0Y7b/nw5glrRKi3q0dLchCPJJi/QjsWiaII=;
        b=C3IDvDdw1HcnhTMMNCDoO2io07kd9+NJlSlyXj96j3Vptm/LVI5Lclm38wgK61uYgI
         XHzzd3yzx3tP12CdO+Xp0jzSNMj7ENONbnlFBdYartR9LoBvLo0LH50ulYx5k7SLO0tH
         N1RxXcrC0u3uNk2nSYDmJDRUPP4GDvVCk2ULz6ZxmHkrt16jKDX1ijA45/MZudRdh+qD
         WV212y150oR8rC7c6Hn8kAkuD43O6YDYEycOqJWUEfAGdSHwElAZM+nHmf31FzHH0Kz5
         Uhpz5JfxXvV5IJl4zd/EHy3QYIif9Ct58ziJDuOdxlFlkWJXse2TFOyQ1pYsE4H/G0XI
         o/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=C0JM8iml0Y7b/nw5glrRKi3q0dLchCPJJi/QjsWiaII=;
        b=kTQ/92RZ3j/RzUWZjEFHSTZ1LyyRKrT6jVhgRIuprsrBlcEe6cpY/Ph/JmNNCfXoPA
         RfkUDR00ynrZITFekuBUJ2cvQynX3htdQR6MYnKwPnkYsCcySZV/7rmcCfSZtjerFZM0
         blPXCXqjYBotr56ja7ACwpnSpwSgko4Kr9wG/lvd9zNtUKCdrICrTkL+D5Ey3fI9xaha
         +rUsASreVcHD/TdcunS6kn73aacDYKeozqLuEGjhtNKWM2ZOis11U/v6GTv5JW55sj7y
         LHXDz02NLWOjvYbSwiGwYHW2LkAyuoGqko+JrWYFCq1NRuuvwyCEfTnE71lt9o2XLCam
         EufQ==
X-Gm-Message-State: APjAAAXWmny9rQc5PFeZp4EvMqNk4c3XK8yTU4Anlt57fGm5OGsBVSWw
        kqRz+NhvO50rx9jTs96tXsK5USs2cEGoHPcLyYredY/mkil0Bo6t4uPFEPAjGTy0G5Rnu0E/g2B
        bykVyU920flalw2Ix/PUhocsjpaBQB1SsD1j9nlPV7Kz8YfJ6z/rSsT5mD0u7buwPhKjAKE3rkg
        ==
X-Google-Smtp-Source: APXvYqxjv9DsaL4JptVMz9zgyRYSKWH4Xkk0ly9BpGGEitVwLIX0CGXzQeWmF1e65iv6a04N6s8XAMDRPg04Wu33NKc=
X-Received: by 2002:a63:b547:: with SMTP id u7mr27427016pgo.322.1562012442030;
 Mon, 01 Jul 2019 13:20:42 -0700 (PDT)
Date:   Mon,  1 Jul 2019 13:20:09 -0700
In-Reply-To: <20190701202014.34480-1-emilyshaffer@google.com>
Message-Id: <20190701202014.34480-9-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20190701201934.30321-1-emilyshaffer@google.com> <20190701202014.34480-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [RFC PATCH v3 08/13] walken: demonstrate various topographical sorts
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Order the revision walk by author or commit dates to demonstrate how to
apply topo_sort to a revision walk.

While following the tutorial, new contributors are guided to run a walk
with each sort and compare the results.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Change-Id: I7ce2f3e8a77c42001293637ae209087afec4ce2c
---
 builtin/walken.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/builtin/walken.c b/builtin/walken.c
index a600f88cf6..b334f61e69 100644
--- a/builtin/walken.c
+++ b/builtin/walken.c
@@ -61,6 +61,13 @@ static void final_rev_info_setup(int argc, const char **argv, const char *prefix
 	/* Let's force oneline format. */
 	get_commit_format("oneline", rev);
 	rev->verbose_header = 1;
+	
+	/* Let's play with the sort order. */
+	rev->topo_order = 1;
+
+	/* Toggle between these and observe the difference. */
+	rev->sort_order = REV_SORT_BY_COMMIT_DATE;
+	/* rev->sort_order = REV_SORT_BY_AUTHOR_DATE; */
 }
 
 /*
-- 
2.22.0.410.gd8fdbe21b5-goog

