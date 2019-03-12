Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1730E20382
	for <e@80x24.org>; Tue, 12 Mar 2019 13:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfCLNa1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 09:30:27 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42659 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfCLNa0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 09:30:26 -0400
Received: by mail-ed1-f65.google.com with SMTP id j89so2272684edb.9
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 06:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AhApy9Y6AQjlxzwFR3k6fXwn9HT58J9/Qy4FTI7TZp8=;
        b=p5JC5019QqYr4S0IX3rw/TdaTPFgEHnDq7eZPm0NVPG5Bn+s+5smMP7zPrWwQ3UEUg
         xZzK3yt0Lt729JCpIBPnyB0B4gGREW67Dj4UHsh680LILdToIWCLTqJJesk5cpPciucP
         FPoNX1Lpg23oO4/WM9HxRdlseIuaUFqH0F3RCoJNJdVWiADuz6UbEAEcLOkUyzEDw3nv
         Reat+kEAkHpIztPaeS1dprtwbuoMJeskMXJNl5kkYrqk96oObGO7tqfTfhiLJbYGrmQC
         NNqNr1Y6V2cxQCicNGRZjss2Eenm34qY+lR2BzGE6J5JKwREa8iUrR39IJhFlMTDLMzs
         h6Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AhApy9Y6AQjlxzwFR3k6fXwn9HT58J9/Qy4FTI7TZp8=;
        b=cc7N6zBJpHrTlJRQ8K4rvjzWNx4IxQoYMvuP/xveCkr2ybZ3YCTa2T10mBT/VPCOev
         0QhAudDxveCcLq0wwG3/7Z09XmI/sohK/1/FTUqT6ICLR98aEFCc05bxIba/FhLaPUhd
         QVSeUTBBVZZsWWd/fuhnPyo3s3IxqY3BXTj/hUHg+ZfAJ8mqP1cQjV951bdAOubrcJDL
         JD6Vej8wlvAL5UQAq5YwfbIKws1KBgHZuQLxadXl5dnjYD3PLrpVl7RsorBuDZpku/Yi
         DKoJN03UArWv6IkDloG5jgZ+TJ/F5PNXCJEgGZRkr1VE30uCRGP5mph/ocZ1PJqesVlB
         IrpA==
X-Gm-Message-State: APjAAAXQazi1FoD/5kf1dmboIk6vl2sqcU5o0tCT9YDMzeJuvjy4R/U+
        CC23l32kQgIoFrJjtr/rZzXHK8QP
X-Google-Smtp-Source: APXvYqzCpgQM5ADkaeaw9PRMdL71XzwXkxA23vnvWOFJDwVuSziPzE29n1IlseipL0tk/CwIgnh8Ag==
X-Received: by 2002:a17:906:4595:: with SMTP id t21mr24688180ejq.120.1552397424039;
        Tue, 12 Mar 2019 06:30:24 -0700 (PDT)
Received: from ubuntu-N750HU.booking.pcln.com (access-114.38.rev.fr.colt.net. [213.41.38.114])
        by smtp.gmail.com with ESMTPSA id h8sm5875213edk.21.2019.03.12.06.30.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 06:30:23 -0700 (PDT)
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
Subject: [PATCH v3 08/11] builtin/fetch: remove unique promisor remote limitation
Date:   Tue, 12 Mar 2019 14:29:56 +0100
Message-Id: <20190312132959.11764-9-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.21.0.166.gb5e4dbcfd3
In-Reply-To: <20190312132959.11764-1-chriscool@tuxfamily.org>
References: <20190312132959.11764-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As the infrastructure for more than one promisor remote
has been introduced in previous patches, we can remove
code that forbids the registration of more than one
promisor remote.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/fetch.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 9d436bd727..56c6827165 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1465,26 +1465,16 @@ static inline void fetch_one_setup_partial(struct remote *remote)
 		return;
 
 	/*
-	 * If this is the FIRST partial-fetch request, we enable partial
-	 * on this repo and remember the given filter-spec as the default
-	 * for subsequent fetches to this remote.
+	 * If this is a partial-fetch request, we enable partial on
+	 * this repo if not already enabled and remember the given
+	 * filter-spec as the default for subsequent fetches to this
+	 * remote.
 	 */
-	if (!has_promisor_remote() && filter_options.choice) {
+	if (filter_options.choice) {
 		partial_clone_register(remote->name, &filter_options);
 		return;
 	}
 
-	/*
-	 * We are currently limited to only ONE promisor remote and only
-	 * allow partial-fetches from the promisor remote.
-	 */
-	if (!promisor_remote_find(remote->name)) {
-		if (filter_options.choice)
-			die(_("--filter can only be used with the remote "
-			      "configured in extensions.partialClone"));
-		return;
-	}
-
 	/*
 	 * Do a partial-fetch from the promisor remote using either the
 	 * explicitly given filter-spec or inherit the filter-spec from
-- 
2.21.0.166.gb5e4dbcfd3

