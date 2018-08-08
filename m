Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEFE4208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 06:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbeHHJG0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 05:06:26 -0400
Received: from forward101j.mail.yandex.net ([5.45.198.241]:54354 "EHLO
        forward101j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726954AbeHHJG0 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 8 Aug 2018 05:06:26 -0400
X-Greylist: delayed 431 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Aug 2018 05:06:25 EDT
Received: from mxback17j.mail.yandex.net (mxback17j.mail.yandex.net [IPv6:2a02:6b8:0:1619::93])
        by forward101j.mail.yandex.net (Yandex) with ESMTP id 89D241243132
        for <git@vger.kernel.org>; Wed,  8 Aug 2018 09:40:58 +0300 (MSK)
Received: from smtp1p.mail.yandex.net (smtp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:6])
        by mxback17j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id GhajVLvKGk-ewYOCGiP;
        Wed, 08 Aug 2018 09:40:58 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail; t=1533710458;
        bh=4GpqSmSKZlfi7C8X3Sv0tnx/p93gc9gHHydQhwJZ+40=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=pZ6OuKh96krlL5k/5REMRt+BscE0Mc/3w71oohNpszhchWbBQMXYNDU02G8uqB0R+
         ZWT6rXJyA5au5FYvUXXJ0krhnZ72jaf7n4S6mIVz9M9lX7478HdDsIbqwxTJTv/vRf
         WUiFDRrBMUDdrO7Yg8zbRPyQaiXdaa68Aiuq9Nf4=
Received: by smtp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 1lXgI88hdg-evuCuVxV;
        Wed, 08 Aug 2018 09:40:58 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail; t=1533710458;
        bh=4GpqSmSKZlfi7C8X3Sv0tnx/p93gc9gHHydQhwJZ+40=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=pZ6OuKh96krlL5k/5REMRt+BscE0Mc/3w71oohNpszhchWbBQMXYNDU02G8uqB0R+
         ZWT6rXJyA5au5FYvUXXJ0krhnZ72jaf7n4S6mIVz9M9lX7478HdDsIbqwxTJTv/vRf
         WUiFDRrBMUDdrO7Yg8zbRPyQaiXdaa68Aiuq9Nf4=
Authentication-Results: smtp1p.mail.yandex.net; dkim=pass header.i=@ya.ru
From:   Nicholas Guriev <guriev-ns@ya.ru>
To:     git@vger.kernel.org
Cc:     Nicholas Guriev <guriev-ns@ya.ru>
Subject: [PATCH] status: -i shorthand for --ignored command line option
Date:   Wed,  8 Aug 2018 09:39:26 +0300
Message-Id: <20180808063926.11911-1-guriev-ns@ya.ru>
X-Mailer: git-send-email 2.18.0.547.g1d89318.dirty
In-Reply-To: <20180804181539.29536-1-guriev-ns@ya.ru>
References: <20180804181539.29536-1-guriev-ns@ya.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This short option saves the number of keys to press for the
typically git-status command.
---
I already sent the patch here, but it doesn't seem reached to the
list. So I send the email (now with DKIM) again and apologize if you
get this twice.

 builtin/commit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 158e3f8..44829b9 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1319,7 +1319,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 		  N_("mode"),
 		  N_("show untracked files, optional modes: all, normal, no. (Default: all)"),
 		  PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
-		{ OPTION_STRING, 0, "ignored", &ignored_arg,
+		{ OPTION_STRING, 'i', "ignored", &ignored_arg,
 		  N_("mode"),
 		  N_("show ignored files, optional modes: traditional, matching, no. (Default: traditional)"),
 		  PARSE_OPT_OPTARG, NULL, (intptr_t)"traditional" },
-- 
2.7.4

