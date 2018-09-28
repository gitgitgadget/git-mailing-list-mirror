Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93C9D1F453
	for <e@80x24.org>; Fri, 28 Sep 2018 15:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729422AbeI1WIc (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 18:08:32 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33993 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729025AbeI1WIc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 18:08:32 -0400
Received: by mail-lf1-f66.google.com with SMTP id y10-v6so5375475lfj.1
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 08:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hv/9G+QK8iY3P040t7HC+wH3L7npdRsARfBMuIajDLk=;
        b=b1+Npp+LEOlr816J4+fbFPbZ8XSaCbIE3o3OFVmupHwHdhG7roije3HxA1D+WwyNOT
         1YTBDxy0mJh92NjCKz6MdR6GuuwgVcjnfYIgGogKhk9CtDV4Q2cKNguSbvzvCifPOCni
         VwSWTZCCOw+FEINj9ASKvq0vZXcOClfROhJbsAaykpjozXYPXu/KAkkq9noFh/5DlO2c
         yKQzBwV64+ZXV7ETTcsW3YzP8pOQYStETNUQNEEfqmcvoxdWuqgw+FwCBOCNMsNVkyex
         tladGp1hglsY7KrppQEWmRZ53LYgIQmZxPpu4e8OtYZlFpT6cTyX4WlaTpNoXk8VhkEr
         H5Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hv/9G+QK8iY3P040t7HC+wH3L7npdRsARfBMuIajDLk=;
        b=mlocs4L6ymWbTUBIQmfEo6eqhjwLfiEdRAVy/Ds+5yL2a3CVMJoRuBw7wXpknhJUeK
         041xaCBFFPI5V1kwB84khO4bYfyHrHFDe3OaRq/YBxd8IBEvUqyzGtd1JHfMH0xaOeq0
         pWk/+PRNGUaXj3vEqi94uA2pTosdyOcGiL9lG7q1viAQ+2clJAw9uTTAmnN1b+87Malx
         ZWz2qXTl7dLPQvZxsKzcGillERt8oDMarCNslXMcF8TZzpcBNc804B2vFgd0E31XLIEM
         ty30GDCE5DLSpLsqCcfZecmTmiKSViQKuwQOMNvcylDBR6n2KD3jyTedZn0+hZeF/Ur2
         7c5Q==
X-Gm-Message-State: ABuFfohbap08TseN07eyFasb4vw+ZbeQA3L3hJZ/OzgfcyO7VZ56s2Zi
        b187kdjAmEJrbpCCP3QbJCUFzpVW
X-Google-Smtp-Source: ACcGV62R+dV1UUU64kdCloEXP70NvsO2gfDs5EtVamW9S8iEYm36JmavNYcOmXBP4HYxNIH75s2kcw==
X-Received: by 2002:a19:9b12:: with SMTP id d18-v6mr11444871lfe.132.1538149450480;
        Fri, 28 Sep 2018 08:44:10 -0700 (PDT)
Received: from mosebacke.ipredator.se ([2001:67c:1350:106::1a])
        by smtp.gmail.com with ESMTPSA id d126-v6sm1090499lfe.75.2018.09.28.08.44.09
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 28 Sep 2018 08:44:09 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH] t1400: drop debug `echo` to actually execute `test`
Date:   Fri, 28 Sep 2018 17:43:59 +0200
Message-Id: <20180928154359.26919-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.19.0.216.g2d3b1c576c
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of running `test "foo" = "$(bar)"`, we prefix the whole thing
with `echo`. Comparing to nearby tests makes it clear that this is just
debug leftover. This line has actually been modified four times since it
was introduced in e52290428b (General ref log reading improvements.,
2006-05-19) and the `echo` has always survived. Let's finally drop it.

This script could need some more cleanups. This is just an immediate fix
so that we actually test what we intend to.

All other hits for `git grep "\<echo test " -- t/` seem fine. They want
to create some input or expected output data.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 t/t1400-update-ref.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 02493f14ba..b72beebe42 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -359,21 +359,21 @@ ld="Thu, 26 May 2005 18:43:00 -0500"
 test_expect_success 'Query "master@{May 25 2005}" (before history)' '
 	test_when_finished "rm -f o e" &&
 	git rev-parse --verify "master@{May 25 2005}" >o 2>e &&
 	test $C = $(cat o) &&
 	test "warning: Log for '\''master'\'' only goes back to $ed." = "$(cat e)"
 '
 test_expect_success 'Query master@{2005-05-25} (before history)' '
 	test_when_finished "rm -f o e" &&
 	git rev-parse --verify master@{2005-05-25} >o 2>e &&
 	test $C = $(cat o) &&
-	echo test "warning: Log for '\''master'\'' only goes back to $ed." = "$(cat e)"
+	test "warning: Log for '\''master'\'' only goes back to $ed." = "$(cat e)"
 '
 test_expect_success 'Query "master@{May 26 2005 23:31:59}" (1 second before history)' '
 	test_when_finished "rm -f o e" &&
 	git rev-parse --verify "master@{May 26 2005 23:31:59}" >o 2>e &&
 	test $C = $(cat o) &&
 	test "warning: Log for '\''master'\'' only goes back to $ed." = "$(cat e)"
 '
 test_expect_success 'Query "master@{May 26 2005 23:32:00}" (exactly history start)' '
 	test_when_finished "rm -f o e" &&
 	git rev-parse --verify "master@{May 26 2005 23:32:00}" >o 2>e &&
-- 
2.19.0.216.g2d3b1c576c

