Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D0011F404
	for <e@80x24.org>; Fri,  9 Feb 2018 20:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752737AbeBIUcl (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 15:32:41 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33918 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750909AbeBIUck (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 15:32:40 -0500
Received: by mail-wr0-f196.google.com with SMTP id j19so3121405wre.1
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 12:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=F7uokmFFr7IAZiXCVlsI6/Cjx/3VFYasDZB7TvxA7RE=;
        b=DK0JypQ6IGH7zWJJsgP4rfWCPTvWtUFdiiKki2RzyIT1pjh2Qc5ttlxB/6zyUTiXUc
         0ikjPYE6EnZdoLNB8zuL3scd58f/l+2vzgEBs+0zwvY8WxwXXY/7MY9WgqzHmxjvLeqQ
         5qdo1+eAnplW54zfVPs286lGpVGjVQ53TOv++lipc+ad50pgveA9SZYv7ln8AeXqhLF6
         gTxbWw5X0a8Lr4FsRliDUtWQxO7Qjp8qwzCywRvBuThYnjm0cEDkDmaO7pk15TThUGlC
         DQ8yE9lPNFq1uDYRM5cLYXF2lQ8AyzmsH/I2QARLWMkPBJ84duUvK1a3NScdGRyd0YEL
         LQnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=F7uokmFFr7IAZiXCVlsI6/Cjx/3VFYasDZB7TvxA7RE=;
        b=OdzHip/ERUweclolU9NlLE8Q1CgkMuozzZY64RRspca5/4o0Rbl+A/tJMnm1S0kn+R
         f9JKpihTK0ZswRsGszuoc3sgD3010FOSkuLD55k2IFFuRFuDIBqCY/0Cklj80Qdhc1Ms
         DSrvJlI18PcUJ5C6USdrVsSafQwQahVT2NeqQZHarV98kblIheov3Hw0b9fDYOMpXLQY
         WFbZg7cVMQjWaupq2hEWsWEzFGL1sPiZZOzJLl1k7uTx4MYI9Y8kv2XljJ6J3cC7iN3F
         pk56qIUdQJLl8B5Bot/SM06zLp15RmMPEnVntyGyZvOqkI1fUGQVC+4pdG1hfl2/yq2u
         l3wA==
X-Gm-Message-State: APf1xPDbThrz9McyVKxetRdxlp0UAURJ0dwHqM9z8QknsvdykvRNnUav
        DsoF+gDhiQ6Bkj0uhNMy66uSLH4g
X-Google-Smtp-Source: AH8x226uhZuUa2VO9+bvEki9ntQDTGcw6JCb/lruZA+o7I50TNxarC3HvDZ0YYi/2KaoyuzKwkvBDA==
X-Received: by 10.223.200.74 with SMTP id e10mr3493343wrh.128.1518208359304;
        Fri, 09 Feb 2018 12:32:39 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id y90sm5750233wrc.24.2018.02.09.12.32.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Feb 2018 12:32:38 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Daniel Barkalow <barkalow@iabervon.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 03/17] fetch: stop accessing "remote" variable indirectly
Date:   Fri,  9 Feb 2018 20:32:02 +0000
Message-Id: <20180209203216.11560-4-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180209203216.11560-1-avarab@gmail.com>
References: <20180209203216.11560-1-avarab@gmail.com>
In-Reply-To: <20180121000304.32323-1-avarab@gmail.com>
References: <20180121000304.32323-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Access the "remote" variable passed to the fetch_one() directly rather
than through the gtransport wrapper struct constructed in this
function for other purposes.

This makes the code more readable, as it's now obvious that the remote
struct doesn't somehow get munged by the prepare_transport() function
above, which takes the "remote" struct as an argument and constructs
the "gtransport" struct, containing among other things the "remote"
struct.

A subsequent change will copy this pattern to access a new
remote->prune_tags field, but without the use of the gtransport
variable. It's useful once that change lands to see that the two
pieces of code behave exactly the same.

This pattern of accessing the container struct was added in
737c5a9cde ("fetch: make --prune configurable", 2013-07-13) when this
code was initially introduced.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/fetch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 72085e30b9..a7705bc150 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1280,8 +1280,8 @@ static int fetch_one(struct remote *remote, int argc, const char **argv)
 
 	if (prune < 0) {
 		/* no command line request */
-		if (0 <= gtransport->remote->prune)
-			prune = gtransport->remote->prune;
+		if (0 <= remote->prune)
+			prune = remote->prune;
 		else if (0 <= fetch_prune_config)
 			prune = fetch_prune_config;
 		else
-- 
2.15.1.424.g9478a66081

