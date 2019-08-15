Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7A6B1F45A
	for <e@80x24.org>; Thu, 15 Aug 2019 09:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731039AbfHOJMv (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Aug 2019 05:12:51 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43503 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731000AbfHOJMv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Aug 2019 05:12:51 -0400
Received: by mail-wr1-f68.google.com with SMTP id y8so1589569wrn.10
        for <git@vger.kernel.org>; Thu, 15 Aug 2019 02:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4aYyj+QskswuMk3evdIXpXQ3JZ3UHlcBlTlQuBaGie4=;
        b=GP2VOS8Pb5+1NUb4jFGSXdA+YH3YCPLx6r+c/is7Rc5XiVufG0eLCCIhq9RvdwVFxd
         U1V8zNnFSSTS3m8j1QKr2u6vu8gXUeM0HDoiOym3KYkjUr4mdu6BWkromlBgjLJRZmFO
         8lVIejJF1IO0vjHwsNkvWGvZX58mraAokMwD7RQT/ypGy3th2fuBsP3/nvAxdy635cKj
         XIIv9dcqcUPQinC8AUO2ts0L9dsBn1cNlrUFHLRkNlTYlPu9h+C7siYebDJnXVJ5I2ns
         nyr76PBzFUArBfJc9Po4Rtvjg/GTt6pwGF+syF65CUT82xAhxrf4/3el06qODubUEQlu
         tqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4aYyj+QskswuMk3evdIXpXQ3JZ3UHlcBlTlQuBaGie4=;
        b=n3vhMyQybjGL11MjTlZgsxWe64f21/cG1GWAZUSeZSQ3UW26wul1yUDtmzS9upENBt
         KiCwnmBlo4c3hxc/3LQlqGbnAWME1HJOvGkCQ56Obp/oD0lJ7LrNf/6obK/9xPxFn8qU
         XqOpcGBBCzoC5qaHkZS7nibkX37epJnl7TycciWQnVG8JSUo3W+6Ei7vOnbkenW/GcKj
         PmgMx4/6AILM3WAUl7xw0YtenxwXblkOIM9kZxanoiQvXdmDNcc6Fvbf3nxuG28XWHjg
         t8S4T/o79QxFG1XpGWzY6BSUrlkVU96bt2b20U/yUiGgXp0Di5IGunYA5UhOtj+SK+6r
         eFvw==
X-Gm-Message-State: APjAAAUmk5yigyB6/Qz7jTZ8IoOOjLtjiLPxPYNAxDi/E7d5XwFfDEm/
        8Te2W/uAgYrnXG1Y3Suxhd8=
X-Google-Smtp-Source: APXvYqxYvpjjhHSXcBIOv830f0hJuHM3UaEviEwWUDU46qewoVWC25kqWvhXx7L1C/2zdjvpaZxr8g==
X-Received: by 2002:adf:f844:: with SMTP id d4mr4496232wrq.128.1565860368818;
        Thu, 15 Aug 2019 02:12:48 -0700 (PDT)
Received: from localhost.localdomain (x4dbd33ce.dyn.telefonica.de. [77.189.51.206])
        by smtp.gmail.com with ESMTPSA id f10sm2382886wrw.16.2019.08.15.02.12.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Aug 2019 02:12:48 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Hong Xu <hong@topbug.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] diff: 'diff.indentHeuristic' is no longer experimental
Date:   Thu, 15 Aug 2019 11:12:45 +0200
Message-Id: <20190815091245.16525-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.366.g16015fd804
In-Reply-To: <58aafeaa-72b0-25ce-27b6-f8480fe48b5e@topbug.net>
References: <58aafeaa-72b0-25ce-27b6-f8480fe48b5e@topbug.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The indent heuristic started out as experimental, but it's now our
default diff heuristic since 33de716387 (diff: enable indent heuristic
by default, 2017-05-08).  Alas, that commit didn't update the
documentation, and the description of the 'diff.indentHeuristic'
configuration variable still implies that it's experimental and not
the default.

Update the description of 'diff.indentHeuristic' to make it clear that
it's the default diff heuristic.

The description of the related '--indent-heuristic' option has already
been updated in bab76141da (diff: --indent-heuristic is no
longer experimental, 2017-10-29).

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 Documentation/config/diff.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config/diff.txt b/Documentation/config/diff.txt
index 5afb5a2cbc..ff09f1cf73 100644
--- a/Documentation/config/diff.txt
+++ b/Documentation/config/diff.txt
@@ -189,7 +189,7 @@ diff.guitool::
 include::../mergetools-diff.txt[]
 
 diff.indentHeuristic::
-	Set this option to `true` to enable experimental heuristics
+	Set this option to `false` to disable the default heuristics
 	that shift diff hunk boundaries to make patches easier to read.
 
 diff.algorithm::
-- 
2.23.0.rc2.366.g16015fd804

