Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A76041F428
	for <e@80x24.org>; Wed,  3 Jan 2018 01:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750989AbeACBMh (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 20:12:37 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:33482 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750922AbeACBMg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 20:12:36 -0500
Received: by mail-io0-f194.google.com with SMTP id t63so572673iod.0
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 17:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1bOqZTIgNfYaGearpUu/NTtFHtC7CcEpqwb4HBh3SiI=;
        b=onj99QUVPnHydjHmVXO5J1CoIHxckp5nqtFkHc+RBf+JgrFM0mE75TUDdKNpBBvbKY
         Ybyq3eAZwTjecuVXdQy83/6e7bhhZ1TXL3dpWAEGkoady0nkvbaStyzzf/81zzXoAq8/
         d7etpqT6QNEb6TCPQO3Le7qiYjSasYsJ14DuGmC+8h/n3WhrzCqbKp/8FiW1vddVtoXw
         RtS1seiW4ZngsDsehmOVF9xRrAQguFkFsFntBw3oTFieEjUB78wG7zGTMBPJ0votQ1zP
         +mO1F6AdL58oA7te93QWBmyTBqSkO2g3qIK0Iqpw5oJ+lD7ToRIEcDITjtmod6M+dQgj
         gqdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1bOqZTIgNfYaGearpUu/NTtFHtC7CcEpqwb4HBh3SiI=;
        b=Fm3atV804gqPagCUl3LdG+o2QTvJc9R0RYE+JtIZaDsomJxjsXw+NsFtWEIQAao7LF
         vh/kENPocujnnnDY3o5XZeg5hLZac9H0mBq6kZF/MIb0JstCrmXk6NubyuKbogDXsEYX
         SFH9yJNcZWJbyJPYq7DCED02g7Zqc8a1Elk3X2owx4AIxv/XuVuUY5mG0bpjmuJMkIAN
         pb1x53/fst7hji377E4ifmvHKIerxQ23h1wYVJ+LSISAJV6EeC1xdDzD7So88nQz9yvy
         2d7HbjTP0OVlSF3FbL2FrWqwC45MhY8+v32cAmSIB106fz5eH+H+fiq/D4KK4mV57zqF
         RvAQ==
X-Gm-Message-State: AKGB3mI/mv2375KJ8MyWup9RaSLsuOZMVOyqrt0gZdAxY7pCquW45vFH
        IrtMNxwFz/yVzXk+Ao6ixKoXam1EfwM=
X-Google-Smtp-Source: ACJfBovtTGXNtVHFabOsBpNAyZWu1pmckitl+fEGWeAgRy5eU7Wn/7AnKrfdIpcLCBVsAAHn3sfhnQ==
X-Received: by 10.107.128.225 with SMTP id k94mr60096887ioi.184.1514941955440;
        Tue, 02 Jan 2018 17:12:35 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id d65sm6421198iod.37.2018.01.02.17.12.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jan 2018 17:12:34 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com, sbeller@google.com
Subject: [PATCH 1/5] t/helper/test-lazy-name-hash: fix compilation
Date:   Tue,  2 Jan 2018 17:12:22 -0800
Message-Id: <20180103011226.160185-2-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670-goog
In-Reply-To: <20180103011226.160185-1-sbeller@google.com>
References: <xmqqbmichws2.fsf@gitster.mtv.corp.google.com>
 <20180103011226.160185-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was compiling origin/master today with stricter compiler flags today
and was greeted by

t/helper/test-lazy-init-name-hash.c: In function ‘cmd_main’:
t/helper/test-lazy-init-name-hash.c:172:5: error: ‘nr_threads_used’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
     printf("avg [size %8d] [single %f] %c [multi %f %d]\n",
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         nr,
         ~~~
         (double)avg_single/1000000000,
         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         (avg_single < avg_multi ? '<' : '>'),
         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         (double)avg_multi/1000000000,
         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         nr_threads_used);
         ~~~~~~~~~~~~~~~~
t/helper/test-lazy-init-name-hash.c:115:6: note: ‘nr_threads_used’ was declared here
  int nr_threads_used;
      ^~~~~~~~~~~~~~~

I do not see how we can arrive at that line without having `nr_threads_used`
initialized, as we'd have `count > 1`  (which asserts that we ran the
loop above at least once, such that it *should* be initialized).

I do not have time to dive into further analysis.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/helper/test-lazy-init-name-hash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/helper/test-lazy-init-name-hash.c b/t/helper/test-lazy-init-name-hash.c
index 6368a89345..297fb01d61 100644
--- a/t/helper/test-lazy-init-name-hash.c
+++ b/t/helper/test-lazy-init-name-hash.c
@@ -112,7 +112,7 @@ static void analyze_run(void)
 {
 	uint64_t t1s, t1m, t2s, t2m;
 	int cache_nr_limit;
-	int nr_threads_used;
+	int nr_threads_used = 0;
 	int i;
 	int nr;
 
-- 
2.15.1.620.gb9897f4670-goog

