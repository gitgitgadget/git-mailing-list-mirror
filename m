Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E70C20305
	for <e@80x24.org>; Tue, 12 Mar 2019 13:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfCLNaY (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 09:30:24 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:32868 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfCLNaV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 09:30:21 -0400
Received: by mail-ed1-f67.google.com with SMTP id d12so2320288edp.0
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 06:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U4N+VL7xrP7XWFLQZvSKADPDiuJ6H3btFTJWpW9kTe0=;
        b=Qyo0LrukHUR4W4+u56Fsrw36KMed4T1w8ksJQhhzPTaeata7sZ9ORzbnCIIO8Fm9Db
         0eE1NVq0DM/LFHgJ6tVNpeFjRy/hFV346s3+OKdwKX/kkhhh9ZBn9WYLuiq6IaSl+BvH
         7ZtjXVw4GyQcwUhetE/CAeWg2xP3/Zpnt0FtESKBH1hRBvOA5IgRPV6jlcxAMiDSl5V5
         WQ2E70pdN778cGJXNQ+XZ2z15AOHu+IDYTyVg/RTLX3JetoeFP6n9hA5cdj/FnRyibcn
         XA5jOjVlQPVQlqHMEJ46qAjkzBjPvmlE09rWvVh1m4jTTDRMHaRoASOdZGwdT1N6yDTl
         Nbrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U4N+VL7xrP7XWFLQZvSKADPDiuJ6H3btFTJWpW9kTe0=;
        b=N/z8jVitYtEBsWEQ86PRcE0WimYOc1cOXRbphSe33x7mYtkz5yRUCeoLzOGwd8Z20O
         y57pSuRxiGhG6RtgW5LhogFS4+aXq4Hsfk9LeBIHy1GyfqltlW3K0pvYPdy+9SK39hyG
         /JStRmEzmZcJluHF1K/a/56XLG+Hu+xleu2y27EDkWB7E+HuZKtt4yYMggWqIOwirDNZ
         KpbKP1xWN71NKxhyRR4hlSha/M31IxbF2qjrlluvAvC7UZsDAbqEYB/3y28AQ/cVJfZZ
         my0pMAjGIukHhiCI5UZJJdoxd7TCdGf/HL9WRgyybj2r1KYvngJFavnkfl/ecpGo0Gsj
         +f/w==
X-Gm-Message-State: APjAAAU3exqyvyj2DP52jH/1yoGq9gbUXsQCmg/tj4uEQY7jN6vjrfZ3
        dFQBzHWTlmgrQjdd+PJGGluqf15y
X-Google-Smtp-Source: APXvYqxXHtpGqpksXK20XIeWMUy2IzsHAVNaGpm5C6My20boHHSNO1XbuvuW3WE5gOX7Z57uEVK6sQ==
X-Received: by 2002:a17:906:3c3:: with SMTP id c3mr25006240eja.181.1552397419758;
        Tue, 12 Mar 2019 06:30:19 -0700 (PDT)
Received: from ubuntu-N750HU.booking.pcln.com (access-114.38.rev.fr.colt.net. [213.41.38.114])
        by smtp.gmail.com with ESMTPSA id h8sm5875213edk.21.2019.03.12.06.30.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 06:30:18 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH v3 05/11] promisor-remote: use repository_format_partial_clone
Date:   Tue, 12 Mar 2019 14:29:53 +0100
Message-Id: <20190312132959.11764-6-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.21.0.166.gb5e4dbcfd3
In-Reply-To: <20190312132959.11764-1-chriscool@tuxfamily.org>
References: <20190312132959.11764-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A remote specified using the extensions.partialClone config
option should be considered a promisor remote too.

This remote should be at the end of the promisor remote list,
so that it is used only if objects have not been found in other
remotes.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/promisor-remote.c b/promisor-remote.c
index ea74f6d8a8..dcf6ef6521 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -83,6 +83,17 @@ static void promisor_remote_do_init(int force)
 	initialized = 1;
 
 	git_config(promisor_remote_config, NULL);
+
+	if (repository_format_partial_clone) {
+		struct promisor_remote *o, *previous;
+
+		o = promisor_remote_look_up(repository_format_partial_clone,
+					    &previous);
+		if (o)
+			promisor_remote_move_to_tail(o, previous);
+		else
+			promisor_remote_new(repository_format_partial_clone);
+	}
 }
 
 static inline void promisor_remote_init(void)
-- 
2.21.0.166.gb5e4dbcfd3

