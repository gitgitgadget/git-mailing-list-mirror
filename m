Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 919F41F404
	for <e@80x24.org>; Fri,  9 Feb 2018 20:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752598AbeBIUcg (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 15:32:36 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34690 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750909AbeBIUcf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 15:32:35 -0500
Received: by mail-wm0-f66.google.com with SMTP id j21so214268wmh.1
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 12:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=2atKY5JP9RSZ2WcFH5EVwuioWXGE6N4BpO6l4lXokA4=;
        b=pB5lG4//jSlzJiLhmACW+Z8WwwohfyCnfo7NVwIwZawDg3rTxaHL5UAdk8PCKQM4+W
         6rJF2PrDk0TSRbw2SwWSUYtyGEQLYMd80r9vjZNKTLsezd0TZx5W8qsM6Vf9hhjick9l
         UuXqUPxVD4WFhTN+LQLbkHCLJp4oERRlz5GuiXlqy+noqGePe5I1K0g2vN7Fo2kBov1W
         fidov4sgYnWrgBQDvTJ38JPkf+cb3eacqXgaZ53RppF7gMxy+CsySQan/3pq3A4e+33n
         +sfpmmXvVhsnE1P+1xL7wOWJ8yIWG3M+UFBdt4qWQQUdRYtKsOCy1aFFDoys9vGdl5mL
         0uRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=2atKY5JP9RSZ2WcFH5EVwuioWXGE6N4BpO6l4lXokA4=;
        b=NupnFoFPWcsrU+6Lb5AAPjDdoQ34q06eje2lUIiTuHQxcngJ6luxIavLwFR6KRWPNn
         eABTFQ2eww3vwSXSKalRh069WjTZpnzfF7gUoCjko6fygIAhGFkNQPfJhimRqa8Od/oG
         vngGjSmMeZeX/r6IKWLVktQiKiIjhoZAqs7wdlQOkDr29OcmwzlQIfJ9Lm6qlVVWlZVm
         pQj/tbxaVbfNzMkO57d10CdeE5JP+dfGRqjtl8zHVIMfyzNJI9jUt8sUkF2wxTu1Pwgf
         gfpWekm3N3JsssS4bJkWA8VeM3v7bqHnrIda3JcgNdDy9aUdH/qhc1SDsIyGo8NELVfz
         Rzlw==
X-Gm-Message-State: APf1xPBrR8b/nS+fx7+53Q6Yp8H/Vih5ljFxnr99J0+saZSKC0G/96sa
        bf/BI6+dtxd4Y5PiNiaImncNvUt8
X-Google-Smtp-Source: AH8x227amOXKv080ranwtCgl/eQVrNsv8DeXusicctblLh33iDNROAnDXKFDQfqdllWE0K66JzQ52g==
X-Received: by 10.28.99.9 with SMTP id x9mr2931106wmb.70.1518208354485;
        Fri, 09 Feb 2018 12:32:34 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id y90sm5750233wrc.24.2018.02.09.12.32.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Feb 2018 12:32:33 -0800 (PST)
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
Subject: [PATCH v5 01/17] fetch: don't redundantly NULL something calloc() gave us
Date:   Fri,  9 Feb 2018 20:32:00 +0000
Message-Id: <20180209203216.11560-2-avarab@gmail.com>
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

Stop redundantly NULL-ing the last element of the refs structure,
which was retrieved via calloc(), and is thus guaranteed to be
pre-NULL'd.

This code dates back to b888d61c83 ("Make fetch a builtin",
2007-09-10), where wasn't any reason to do this back then either, it's
just boilerplate left over from when git-fetch was initially
introduced.

The motivation for this change was to make a subsequent change which
would also modify the refs variable smaller, since it won't have to
copy this redundant "NULL the last + 1 item" pattern.

We may not end up keeping that change, but as this pattern is still
pointless, so let's fix it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/fetch.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 7bbcd26faf..b34665db9e 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1302,7 +1302,6 @@ static int fetch_one(struct remote *remote, int argc, const char **argv)
 			} else
 				refs[j++] = argv[i];
 		}
-		refs[j] = NULL;
 		ref_nr = j;
 	}
 
-- 
2.15.1.424.g9478a66081

