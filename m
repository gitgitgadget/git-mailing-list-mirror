Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3307C1F404
	for <e@80x24.org>; Thu,  8 Feb 2018 16:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752003AbeBHQUK (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 11:20:10 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38241 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752372AbeBHQUI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 11:20:08 -0500
Received: by mail-wm0-f67.google.com with SMTP id 141so10974643wme.3
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 08:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=F7uokmFFr7IAZiXCVlsI6/Cjx/3VFYasDZB7TvxA7RE=;
        b=O+sOkWgOawOfzZNi+hbmrT3cvhoWXYuUhPVM8ZBdqcs/2MlLYFhW9V6F3E2nOR8bc3
         zYnaoYWg9XkYqDDVk/4rwYuI9xWZvhZtIqhi5c43D5Ir+Bi5sEGXCHopGcNaSIA1+JHM
         LfjmL5m8qVUPIt0ys4oy9INP4agG51SyOeqlrGGfljxRcrW5yTl0OCZCqbNnLo3/YMmJ
         tddoXabn3IuL883RxQlkfUyxLlneY4jLLB7cmlNg1sD8Y7AmEzUmRda9mcLF6l9sq8bP
         Z7xXGPg4iPcyWlqOVdldrJgeYx13NAEG8xsvfBEk4DUilobgfzthpZwIH0766s3hxhVX
         NO/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=F7uokmFFr7IAZiXCVlsI6/Cjx/3VFYasDZB7TvxA7RE=;
        b=TsIHRCupHtTguu3vjwBb5fs+sRlmnm6C6rqLUUZP/OpfetHFEk+V1XfQXLjxCBMQh8
         WI4tOiqQY2UzdT3vUEteEe3Lm5u1rtUEKXqtJrXIl1Cz3/ckJf/Ib9TdJlaMBwcSt1xb
         kg6HF7JSMoqx+3nPNvSvUVxyBwVnsRZCXNBCU37Vm5lu7ZlClOtelYD2GUk3WWDyExNJ
         XDruIWhyZ2sRupfogs7/Xp3aackmICHZnsD8wai8BH4gm3HdAbSFaOfMLU2ojcSMr7DL
         UdnOyPtapRsnaFQ+GbT29v4ck7nm9Xb7orccwcI2fCsmEuJmuDZiWXzGFdDH4SMFHat9
         Kl9A==
X-Gm-Message-State: APf1xPAu5SQN7BU7OPBePqQtjrWWG8T9NxzOAB6G6c9oTCj2X+1UjJAc
        P/bhUNkyqOJm1n0/fiUzkS9N1NEu
X-Google-Smtp-Source: AH8x226T0usjY3k1TqsefJBBBcJYsGSYdef/lsIhK3Dg0OfatVAXfBEcbNDqMf0QRO+oGCkgLGtdUw==
X-Received: by 10.28.182.86 with SMTP id g83mr1499375wmf.75.1518106806502;
        Thu, 08 Feb 2018 08:20:06 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id m1sm332532wrb.78.2018.02.08.08.20.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Feb 2018 08:20:05 -0800 (PST)
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
Subject: [PATCH v2 03/17] fetch: stop accessing "remote" variable indirectly
Date:   Thu,  8 Feb 2018 16:19:22 +0000
Message-Id: <20180208161936.8196-4-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180208161936.8196-1-avarab@gmail.com>
References: <20180208161936.8196-1-avarab@gmail.com>
In-Reply-To: <20180123221326.28495-1-avarab@gmail.com>
References: <20180123221326.28495-1-avarab@gmail.com>
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

