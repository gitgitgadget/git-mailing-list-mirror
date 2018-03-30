Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE4591F424
	for <e@80x24.org>; Fri, 30 Mar 2018 09:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751104AbeC3J3Y (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 05:29:24 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37185 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750927AbeC3J3W (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 05:29:22 -0400
Received: by mail-wm0-f66.google.com with SMTP id r131so15819284wmb.2
        for <git@vger.kernel.org>; Fri, 30 Mar 2018 02:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tl6x4yHDd+ZnrlnPVfFT6Q8/ZN+2hAWXRfnUzjRDtbY=;
        b=YuGC/Fvz89xlz0MLq8iRFhdiQebyjRwfyUoJul4MMuD9k/FDc6D4Guj3UIndZq7Iz8
         3N5HVSzznYoKISPaVyn9jJsi2C2eBkaSY3cuNjte4JYt6/0+W16YbWtX5HAJ80YdwaKO
         z552e7Zu+nmSEGaRpKpvyd3nuQcvwpXBLQdmIPbupXabmlYtzMkeAnqePTLlZMNfXkP3
         XptSMzWehVNOgD2gVE1lb1NZ7veNypRmZZqibYeRdTUGw00Op6mcj6imw2cOWL/fwPlp
         +qQCYQw1gTj6dFhu9heC1/qshqD/cQDl6ORP7zmYoloqK9iE4ug3sQPGTemC7nTEQszX
         PHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tl6x4yHDd+ZnrlnPVfFT6Q8/ZN+2hAWXRfnUzjRDtbY=;
        b=jpYQ00uQIJBImO8kibtFM2zHmp47Fgn/5qDTxRi9L32SWKEkSY6eDiloYU8KKVcITD
         y68DnETAhBFoCXHV29hjtv7w9DIHYFMrXhjclkgNnohSY8YhFmXy8+lFGquy+f5d/TvT
         ZT/Ol4hKGWcqdhfKUASF95Rhr+Fi7BHlFEyZSSzKY4s7Od+acUBEqtgDqyP/wbOM9iDZ
         ZT/nEdfv4PExe6eVtdAdU6lNWYvEeIMRaYeKy8nn2kowvv7X//dM0R07DlYa5slvaAdf
         WBP0AFC0Exe5AddDpt3lZsSGqLRWSVfgCJVDk2y8OGemiLpw8X1II59/e8Q0sD6AwWdg
         mTkQ==
X-Gm-Message-State: AElRT7ExW6fNPJCI8smV8wiXS8qj6m4IaG1QVQBf3hPBAgw5kISxg4o8
        gVYVWhAm7kAi5WvZV3E9SqGrX354
X-Google-Smtp-Source: AIpwx4+mPojOlMt+WgtHF8YR/WcZ8bNboGgXsvUUali/oEEDKh5pesaFUn6ZOoEUM5raJ+bY7rbo1Q==
X-Received: by 10.28.106.1 with SMTP id f1mr1868288wmc.59.1522402161064;
        Fri, 30 Mar 2018 02:29:21 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id y131sm521791wme.0.2018.03.30.02.29.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Mar 2018 02:29:20 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] {fetch,upload}-pack: clearly mark unreachable v2 code
Date:   Fri, 30 Mar 2018 09:29:07 +0000
Message-Id: <20180330092907.611-1-avarab@gmail.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118
In-Reply-To: <20180314183213.223440-1-bmwill@google.com>
References: <20180314183213.223440-1-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the switch statement driving upload_pack_v2() and
do_fetch_pack_v2() to clearly indicate that the FETCH_DONE case is
being handled implicitly by other code, instead of giving the reader
the impression that the "continue" statement is needed.

This issue was flagged as DEADCODE by Coverity[1]. Simply removing the
"case FETCH_DONE" would make -Wswitch warn. Instead implement the same
solution discussed for my "[PATCH v2 18/29] grep: catch a missing enum
in switch statement" patch[2] (which never made it into git.git).

1. https://public-inbox.org/git/CAGZ79kbAOcwaRzjuMtZ_HVsYvUr_7UAPbOcnrmPgsdE19q=PrQ@mail.gmail.com/
2. https://public-inbox.org/git/20170513231509.7834-19-avarab@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fetch-pack.c  | 4 ++--
 upload-pack.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 216d1368be..3a16b4bc1a 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1393,8 +1393,8 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 
 			state = FETCH_DONE;
 			break;
-		case FETCH_DONE:
-			continue;
+		default:
+			BUG("Added a new fetch_state without updating switch");
 		}
 	}
 
diff --git a/upload-pack.c b/upload-pack.c
index 87b4d32a6e..b7a7601c83 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1416,8 +1416,8 @@ int upload_pack_v2(struct repository *r, struct argv_array *keys,
 			create_pack_file();
 			state = FETCH_DONE;
 			break;
-		case FETCH_DONE:
-			continue;
+		default:
+			BUG("Added a new fetch_state without updating switch");
 		}
 	}
 
-- 
2.16.2.804.g6dcf76e118

