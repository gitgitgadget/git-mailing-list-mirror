Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84CA920285
	for <e@80x24.org>; Tue, 29 Aug 2017 11:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753131AbdH2L0K (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Aug 2017 07:26:10 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37375 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752836AbdH2LXs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2017 07:23:48 -0400
Received: by mail-wr0-f194.google.com with SMTP id n37so2061796wrf.4
        for <git@vger.kernel.org>; Tue, 29 Aug 2017 04:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daniel-watkins-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=dO2Xo8t7zaboLzApaqReSbvyP5QpsAA0zvBLOINYEmE=;
        b=zj6cXnYjqxRCaR6Kwu3LgeZXv5KiQ0omwwsuEnTMMqH70IMwo0vZGZKCGbltwfgc2Y
         4ZtNF0eJmiyHFIf1/0WN998Obdbj8qbYY5xu26Qsmo4QBgn0fjz/ZepTbmn2sJFlmGbE
         2JJk2Y5poktaIksMwEt6fHjwMqjlb6iEkC97663HveqdTjPUUDGSAnEil5ZRQl/G9YAO
         obW1g3UUIt/DJfX37ppOMSIAeOPvuhoBIy6e2to2XfP6+x4J/hyKq1Z4tsdpeqQbeCAo
         TN+RY6h4NXtNKfUJg/GcMPycR3SPKlAwK17EioGuebSltk7KitT+iBGWYzE5lUWEbVcz
         X6Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dO2Xo8t7zaboLzApaqReSbvyP5QpsAA0zvBLOINYEmE=;
        b=oJuhOlaSa8SZSEOZUA2r5t2jlon6/z2NQtLE/WC/n05voRAK8VI8mavBFyMe23Gmoa
         7NH0Juh8smwawVFHKYXbFGQUToORlQzVzJYiaoBR9kB8QSjMii7+4PIQLDvlOufcChyk
         HlQ7CqclexBDqxFhqVl+KyPMTPJ2HdDtC3QvsvodGWfEaxiV6PgJZtIrtfJwXfZplAig
         ybd8SEnIdFqKJiNI6nFoPRzqzNqO7vKoQ/8/p8h62aPdPRpUx81bS6E62nNQsR+ZDMrq
         F99BYY06Mt7iQd3lzBT5P8Hw8DftWOZ5gcjDSTMc2BQamUwqhI8UPROn1qF6o2xqsRxo
         7H9w==
X-Gm-Message-State: AHYfb5jatRlWwIztv5LQIob8rqG8/+lvy6L9h2t+AMyI71xIbbq4FiFy
        ZEX232+0xlgWKXoOOc1+vQ==
X-Received: by 10.223.173.23 with SMTP id p23mr2176632wrc.27.1504005827365;
        Tue, 29 Aug 2017 04:23:47 -0700 (PDT)
Received: from localhost.localdomain (cpc112317-pete13-2-0-cust280.4-4.cable.virginm.net. [86.9.193.25])
        by smtp.gmail.com with ESMTPSA id l64sm2434884wmb.12.2017.08.29.04.23.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Aug 2017 04:23:46 -0700 (PDT)
From:   Daniel Watkins <daniel@daniel-watkins.co.uk>
To:     git@vger.kernel.org
Cc:     peff@peff.net, Daniel Watkins <daniel@daniel-watkins.co.uk>
Subject: [PATCH] diff-highlight: Add clean target to Makefile
Date:   Tue, 29 Aug 2017 12:23:11 +0100
Message-Id: <20170829112311.16432-1-daniel@daniel-watkins.co.uk>
X-Mailer: git-send-email 2.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that `make` produces a file, we should have a clean target to remove
it.

Signed-off-by: Daniel Watkins <daniel@daniel-watkins.co.uk>
---
 contrib/diff-highlight/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/contrib/diff-highlight/Makefile b/contrib/diff-highlight/Makefile
index fbf5c5824..f2be7cc92 100644
--- a/contrib/diff-highlight/Makefile
+++ b/contrib/diff-highlight/Makefile
@@ -17,4 +17,7 @@ shebang.perl: FORCE
 test: all
 	$(MAKE) -C t
 
+clean:
+	$(RM) diff-highlight
+
 .PHONY: FORCE
-- 
2.14.1

