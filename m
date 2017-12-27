Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 655C51F404
	for <e@80x24.org>; Wed, 27 Dec 2017 22:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752569AbdL0W5P (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 17:57:15 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:45664 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752473AbdL0W5N (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 17:57:13 -0500
Received: by mail-io0-f194.google.com with SMTP id e204so36660865iof.12
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 14:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1bOqZTIgNfYaGearpUu/NTtFHtC7CcEpqwb4HBh3SiI=;
        b=qUC9SfjUukDKvsbmYPSe6T27Bi1sJp2dJs8cmy/inmo8X2xrhw4RSpgKmKr0s+ut43
         hsNxoNTEF9PKQC6+sTuW0oUq9cIPENsVpkWFPexaQYKzFwvClw2l+xLABM057EDaIRaP
         34QUcHuxu9XWOI1715LVvrY8UDIq4gk3Idiuw0zA9nbnhETkUdAJskWnWn9Ej4iHxtaN
         zphENduap0BRp0VFvokbvrMO/s8WcTLLw09K4sV6gI41iKRruifZwXKUaAfK1UP/KC/U
         v6ErAfGOX2l4CHLi/sV9oGgcYFRk/KKfioTorOGCxwYhoPm2JCkE5BMvQ/lEFHkUMIuO
         BM9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1bOqZTIgNfYaGearpUu/NTtFHtC7CcEpqwb4HBh3SiI=;
        b=IgPL/+lJsjr33J3XNrmWHfdxcIu5kPegojyn6c8/ooK5RFp8nqC/qLXmNJqSiBsRqh
         KXv8sAWMfnNtYbcvvY+6SlLijzQJAtGsTkjnG+qNEYKrVkztrJ6R0J/nTRNaBvYf5Jk0
         nduaaRotOMotM4aPbvLZskmw7PlwBjEBCuq0tTTGJTVrGaq709QMze8Pww0ERZg2ptCv
         n3v2EI2j+zF+99I3VJEZ9pJZRZ8+9hzcq6/ARUiMToHuojTBIXzpXhYJt3t04K+oJVE1
         1COdPLvjI1eONkXyX2ZuKX+HQsP3cYfPFv+ZpPdkxismslk1vtMeZnX5hFZe7TkmRieo
         Rh+A==
X-Gm-Message-State: AKGB3mLyr9/90CFYOnC2ZHBibko2sH+JDaqo8mhnnz+Rjo954Tjq+x72
        lNq+jhX4PJ4zt+urh1WyvUOzxg==
X-Google-Smtp-Source: ACJfBotI6p/NiH3USUzCPjGdba2wFEYHNwknG30ejvMUcHoUVXo9qTUm6PgxAOLahpKDaFiKKKRezQ==
X-Received: by 10.107.56.4 with SMTP id f4mr39894111ioa.71.1514415432922;
        Wed, 27 Dec 2017 14:57:12 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id 3sm11034453itk.19.2017.12.27.14.57.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Dec 2017 14:57:12 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: [PATCHv2 1/5] t/helper/test-lazy-name-hash: fix compilation
Date:   Wed, 27 Dec 2017 14:57:01 -0800
Message-Id: <20171227225705.73235-2-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670-goog
In-Reply-To: <20171227225705.73235-1-sbeller@google.com>
References: <20171219222636.216001-1-sbeller@google.com>
 <20171227225705.73235-1-sbeller@google.com>
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

