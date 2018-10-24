Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F5BA1F453
	for <e@80x24.org>; Wed, 24 Oct 2018 02:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbeJXLNr (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 07:13:47 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42950 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725266AbeJXLNq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 07:13:46 -0400
Received: by mail-io1-f67.google.com with SMTP id n18-v6so2201973ioa.9
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 19:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=rbzjfi72SOlcqcYe+gXXD6YoDqn6ghOmoLZ60dRN0zI=;
        b=nTsjZ/sTYRfaQjVFARSmN4fkEO2zvjis2BJhJekT3c6f8+/l88mmMuJ6r8pLI1AcAw
         m7Qt68qZZGVXLEoIgviYNB8WlIOAQwu6g5xxKJhr2rHvASWCoMGZ+hzxA4OyIqHLeTb+
         eZtfEALYnyZ1NbmqUJn/4yxmxQxbheFovhAvBRlzxRuJcifqH2GUOHG5HSDNgQfUwijP
         blU9ATteB8LrV/ZC9vSW4/lr7GF2RuKciL/HUkP9Gd7aC+MLBQCdTGbpY8TZsGQ3AZWx
         lrxsRO+HF0PJeWmGy5I3PH2z27/rMJ8o8rEI9YKzKiLBbi0SojQi6naoTJJRd73nihIf
         dxbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=rbzjfi72SOlcqcYe+gXXD6YoDqn6ghOmoLZ60dRN0zI=;
        b=F41QO6s+9Vv8KAtBVpPx/I0bO+hHZ74oEvGB/fjC4lugmp+1t/2Z/P3UYuwe9GvP5d
         mxtEmtdWgHqeu+a0HgSdIHyCPPlZGjhmuX4IHuATyGxJSEXjgF1eLbBjQRdiNlki8482
         YsSvuo6BI/4Pum5FCkvVaFTtnQPD8OFCJTz8WahV+HMQWgh66o7ZSoXW2ykgSU8Qdv9U
         Wtli21bnWQXlab4bsDskYj8Wdc6DiP5VXxAhjbwUqPHzaqV6j126PXjhYsGX2GEVlJHC
         0IdZ96fEmdoTpzYEXU5HPGqR6KHhYG9Q0+5WiMa7jhYGsKA42xM88y13s57K9XgsfMAx
         AOoA==
X-Gm-Message-State: AGRZ1gKuOgt3nzP4XUObQc7BprlCbnzgnaBS0/8reHaHLzZKAcfH4Gpe
        eQ/b6iD1tWM6SGak055KjS8H0zkQ
X-Google-Smtp-Source: AJdET5dg1kNGg91oN9S6yZ00BumHgV3Ce0valMPM9cNmJX6BuVzSyCeMuZhgkuCs3ZWw6ZYE1/dvLA==
X-Received: by 2002:a6b:b417:: with SMTP id d23-v6mr13188416iof.227.1540347914393;
        Tue, 23 Oct 2018 19:25:14 -0700 (PDT)
Received: from archbookpro.localdomain (ktnron0919w-lp140-01-76-68-143-166.dsl.bell.ca. [76.68.143.166])
        by smtp.gmail.com with ESMTPSA id c26-v6sm1824082itd.18.2018.10.23.19.25.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 19:25:13 -0700 (PDT)
Date:   Tue, 23 Oct 2018 22:25:11 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     liu.denton@gmail.com, anmolmago@gmail.com, briankyho@gmail.com,
        david.lu97@outlook.com, shirui.wang@hotmail.com, davvid@gmail.com
Subject: [PATCH 2/2] completion: Support `git mergetool --[no-]gui`
Message-ID: <20181024022511.GA29050@archbookpro.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Denton Liu <liu.denton@gmail.com>
Signed-off-by: Anmol Mago <anmolmago@gmail.com>
Signed-off-by: Brian Ho <briankyho@gmail.com>
Signed-off-by: David Lu <david.lu97@outlook.com>
Signed-off-by: Ryan Wang <shirui.wang@hotmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index db7fd87b6..a45b4a050 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1833,7 +1833,7 @@ _git_mergetool ()
 		return
 		;;
 	--*)
-		__gitcomp "--tool= --prompt --no-prompt"
+		__gitcomp "--tool= --prompt --no-prompt --gui --no-gui"
 		return
 		;;
 	esac
-- 
2.19.1

