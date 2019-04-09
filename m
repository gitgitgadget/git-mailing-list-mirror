Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5477920377
	for <e@80x24.org>; Tue,  9 Apr 2019 16:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfDIQLp (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 12:11:45 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41403 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfDIQLp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 12:11:45 -0400
Received: by mail-wr1-f65.google.com with SMTP id r4so21641915wrq.8
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 09:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XUl3DQ3ZGYAhJzG7PGKZHIvFALRhc78wPtePq4s0Ur8=;
        b=SzVIbzJjLhz95BK4PY+vkyd3yWqM8BW6oYFGiUR8o4Y6grJ2tCK66uE/gLH/w0WS9m
         yI3kdDycgO0IK/L4676MvKV+nV3X05/iYH8MHWwQyIURu7PVbv9dYcGNQs2DlIbaaJiF
         PYMLmLfVhoy8BHQwRVeDy6PzJHQEd7yYzceHXwMvf+5t0VWeNCN0XqLufJcX+6My3s95
         zKfstCzqFsoiVU8bvZ7cfWKofW5v8MqxivvTjpW9ryplMejy1t1bP6gGPAOd11gT2Ylu
         dRPqSXTmgRiZ9h3YILCrCquduTEvgoBdrWRMs2CB0KB3VkpZRPUVfOEYY05HcJJnOVX0
         Vc4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XUl3DQ3ZGYAhJzG7PGKZHIvFALRhc78wPtePq4s0Ur8=;
        b=imQz/YdVsDDqYujHhnP/KWK2dmUCZo9sX8VfKusjwn3eXFjWvZlU6yCJxu0dSP515x
         eOE8UZb3eM/a2/9GZL8GzVqhMkLtiO23vY2o4Wcl1nbk6/lU5BL2JGtNpq56siFKpA77
         Q1liKkST+bWUyIJyccI+6YA+YO/QaR9K3t9JhU/FrWI4uTVbb4ArCJOC4KlvSVNXzlTB
         8oQ38R8eJrv38K6Gdh38FLYLmX8BIlWr37nbMj/AQwmLJKraBqbkdYy/BB2rp4uM7hp4
         G3y4gEsxVmhHuTPY2zw3QCyvQUR8lrKLpS4x1slLzoiwbjGiXb/fLNZCKINhyAzPHxs/
         pPow==
X-Gm-Message-State: APjAAAX0omkgpxbVN1csK9irqUE2y9Og0T83TcUT/lk10+3TI7jkZrWM
        2g4Do95UwRTxO4uDpAKl2sqojx48
X-Google-Smtp-Source: APXvYqzn3Et2GGT7G0HBdnjFjJ4/SjFrq8Pj+gcGlEaAY0fVs8G8V59lD42YOrWC7ZX0Yb8eVqHO3w==
X-Received: by 2002:adf:ce8c:: with SMTP id r12mr4817543wrn.60.1554826302779;
        Tue, 09 Apr 2019 09:11:42 -0700 (PDT)
Received: from ubuntu-N750HU.booking.pcln.com (access-114.38.rev.fr.colt.net. [213.41.38.114])
        by smtp.gmail.com with ESMTPSA id i2sm4356012wmg.47.2019.04.09.09.11.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 09:11:42 -0700 (PDT)
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
Subject: [PATCH v5 01/16] t0410: remove pipes after git commands
Date:   Tue,  9 Apr 2019 18:11:01 +0200
Message-Id: <20190409161116.30256-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.21.0.750.g68c8ebb2ac
In-Reply-To: <20190409161116.30256-1-chriscool@tuxfamily.org>
References: <20190409161116.30256-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let's not run a git command, especially one with "verify" in its
name, upstream of a pipe, because the pipe will hide the git
command's exit code.

While at it, let's also avoid a useless `cat` command piping
into `sed`.

Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0410-partial-clone.sh | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 5bd892f2f7..3559313bd0 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -166,8 +166,9 @@ test_expect_success 'fetching of missing objects' '
 	# associated packfile contains the object
 	ls repo/.git/objects/pack/pack-*.promisor >promisorlist &&
 	test_line_count = 1 promisorlist &&
-	IDX=$(cat promisorlist | sed "s/promisor$/idx/") &&
-	git verify-pack --verbose "$IDX" | grep "$HASH"
+	IDX=$(sed "s/promisor$/idx/" promisorlist) &&
+	git verify-pack --verbose "$IDX" >out &&
+	grep "$HASH" out
 '
 
 test_expect_success 'fetching of missing objects works with ref-in-want enabled' '
@@ -514,8 +515,9 @@ test_expect_success 'fetching of missing objects from an HTTP server' '
 	# associated packfile contains the object
 	ls repo/.git/objects/pack/pack-*.promisor >promisorlist &&
 	test_line_count = 1 promisorlist &&
-	IDX=$(cat promisorlist | sed "s/promisor$/idx/") &&
-	git verify-pack --verbose "$IDX" | grep "$HASH"
+	IDX=$(sed "s/promisor$/idx/" promisorlist) &&
+	git verify-pack --verbose "$IDX" >out &&
+	grep "$HASH" out
 '
 
 test_done
-- 
2.21.0.750.g68c8ebb2ac

