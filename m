Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2575120380
	for <e@80x24.org>; Tue,  9 Apr 2019 16:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfDIQL5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 12:11:57 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40681 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbfDIQL4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 12:11:56 -0400
Received: by mail-wr1-f65.google.com with SMTP id h4so21651934wre.7
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 09:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JaLcNLgH1FGvrESE5cWo/Yv1cI7dR1PzTsVxV3BN05A=;
        b=O0W287gaWtjeEWgGdg37MVgq19h/huaOh0UIGeW8mkvP2dg/iYqYH9nTyyDPXRWKB4
         G/xad30WBfhtrTAQOKBROBcaa44G6PVJICoxmD/+RBRvMJRcNd9CaBnU2gcxt+e8otiT
         aYoglHxS60HBsbdK7sEa8+wo1KviOuxg00k0uGCFSSO0YAiIH1ZZxMtwOeihvtacS+Ak
         lulkq3lv5mi1WWxwabIx7F/4pae3Ba67CuAc1fytYWNvOY4sqpHt/Y1ZXqTrIN1/+V8p
         Egv1RzpWJPF3r7jSsQQKi52I5wKDhzeuM8Mza+Qn2ebCiyzYa/JjUARP5+UH/OCgq/3R
         M9Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JaLcNLgH1FGvrESE5cWo/Yv1cI7dR1PzTsVxV3BN05A=;
        b=LQ8IQLkSHqTI3dQkXzFJoortmNzX0K/7T6zO2dqPBhgc+qM1bFf5lFbWfBoeKeqRl2
         FJvxVz4EBZ6VE7xEWB53TGYYvmSpHKRBtfpIC0faSXHEfCIYlsPIPKGdPEZJxfKUrIPe
         1IWdBozP46SDpn0JMrgA1qHlbI0CdtO+PjCl74mKBgHPSwQYZawLlNsUJ02ctNumS2VA
         D3t5LiMAuwjx1sMDxdgRgNtUwvNr3Vwfd/KohvNBdQjNOlCfkaTNOWyd/S7KaO9K+N4x
         swLB6G6UQ/VaQxEpH2LEqpvC66wnRf5enhBq5yM/dDHaVbRPvwhgNmnEab6sty8A8iq/
         5IHA==
X-Gm-Message-State: APjAAAUQSdEUaNhQyn5b05I+jDho6Buq0DzOpk38q5nxjdvcmoHdlNCn
        2Xuq0w9pMZOnQWYHHOQi4kb8XqkA
X-Google-Smtp-Source: APXvYqzDhU7z2xVtxuy9swj0BOrSXJ5t7kJC6KwdBVYh4ho2fBmcHgTv814KnTBg/OI7AhODU1LuBQ==
X-Received: by 2002:adf:ea0b:: with SMTP id q11mr5369803wrm.233.1554826314195;
        Tue, 09 Apr 2019 09:11:54 -0700 (PDT)
Received: from ubuntu-N750HU.booking.pcln.com (access-114.38.rev.fr.colt.net. [213.41.38.114])
        by smtp.gmail.com with ESMTPSA id i2sm4356012wmg.47.2019.04.09.09.11.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 09:11:53 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v5 08/16] diff: use promisor-remote.h instead of fetch-object.h
Date:   Tue,  9 Apr 2019 18:11:08 +0200
Message-Id: <20190409161116.30256-9-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.21.0.750.g68c8ebb2ac
In-Reply-To: <20190409161116.30256-1-chriscool@tuxfamily.org>
References: <20190409161116.30256-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The repository_format_partial_clone global and fetch_objects()
should not be used anymore when there can be more than one
promisor remote. Instead let's use has_promisor_remote()
and promisor_remote_get_direct() from "promisor-remote.h".

This way all the configured promisor remotes will be taken
into account, not only the one specified by
extensions.partialClone.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 diff.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index 4d3cf83a27..02864171fd 100644
--- a/diff.c
+++ b/diff.c
@@ -25,7 +25,7 @@
 #include "packfile.h"
 #include "parse-options.h"
 #include "help.h"
-#include "fetch-object.h"
+#include "promisor-remote.h"
 
 #ifdef NO_FAST_WORKING_DIRECTORY
 #define FAST_WORKING_DIRECTORY 0
@@ -6490,8 +6490,7 @@ static void add_if_missing(struct repository *r,
 
 void diffcore_std(struct diff_options *options)
 {
-	if (options->repo == the_repository &&
-	    repository_format_partial_clone) {
+	if (options->repo == the_repository && has_promisor_remote()) {
 		/*
 		 * Prefetch the diff pairs that are about to be flushed.
 		 */
@@ -6508,8 +6507,7 @@ void diffcore_std(struct diff_options *options)
 			/*
 			 * NEEDSWORK: Consider deduplicating the OIDs sent.
 			 */
-			fetch_objects(repository_format_partial_clone,
-				      to_fetch.oid, to_fetch.nr);
+			promisor_remote_get_direct(to_fetch.oid, to_fetch.nr);
 		oid_array_clear(&to_fetch);
 	}
 
-- 
2.21.0.750.g68c8ebb2ac

