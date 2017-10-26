Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A1772055E
	for <e@80x24.org>; Thu, 26 Oct 2017 01:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752055AbdJZBbj (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 21:31:39 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:53382 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751902AbdJZBbc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 21:31:32 -0400
Received: by mail-pf0-f196.google.com with SMTP id t188so1296434pfd.10
        for <git@vger.kernel.org>; Wed, 25 Oct 2017 18:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dropbox.com; s=corp;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=lvMCi0uifDsqUSyCK40YGsG49EMihDFxZAgty3tvICQ=;
        b=z7CpkBcG6iqsMjxtzpxkKIYaBtgj5Io58XH0U/+zIGyq/sQ6PGxYO6FCf4cUMffMC/
         mjLvZBWllGW+6K7Hg2VR16GwOwQnyTOHYvAO34BWa4bqjbiZ7Pyh8qTd8pS8PqebK+s1
         JZGI/9oaYXAUn+AaaAIYfPglTKNauBVZYBKGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=lvMCi0uifDsqUSyCK40YGsG49EMihDFxZAgty3tvICQ=;
        b=FSJyvypPwnm7KRPdoyqDZDPrMwkdCyUxQ/gtsZ+o9ox8trbYJprwdh18CwMfdoTFNN
         /Nv4gdrnDHR9QLdRQK24RDyeURL0x7irTftgLLUgy+RlbaL29mDyhHBbBVesIyMXeJ/3
         wusbqbKHzjkAOHmTzvEQHKoVPPCOymnbv65zzzvSZOq5EWSGMH5+q1M2dC0yUZAoYs5x
         PCO3VYuSkGnMVVVPvxD7U5FX4sa1QSEhnjcuJx8rvt91zs/S1TDYek44iKF1jrCwsHRL
         M+/JG7Lnmis8N15ZJWJ9PDbJXYWBjprhToyiF28qPc6CGvDrRNdZOLcZ5swopHECHpnE
         sN6Q==
X-Gm-Message-State: AMCzsaUCLG0JNzeH8t8uR4dUlHwCEGz9unpMEeWrCNyyUc7feeJ3KZLu
        oOd+ZxxWjaf9gpnthyfB4hlUNM1HJRY=
X-Google-Smtp-Source: ABhQp+SInLMIIc8lrNhlcQTeJLaV/6IH13+wwK/lC9lVPHIRe+yVEYfmCofXHjvWcnR45fB+42SdqQ==
X-Received: by 10.98.70.78 with SMTP id t75mr3810180pfa.6.1508981491803;
        Wed, 25 Oct 2017 18:31:31 -0700 (PDT)
Received: from alexmv-linux.corp.dropbox.com (v160-sfo11-br01.corp.dropbox.com. [205.189.0.163])
        by smtp.gmail.com with ESMTPSA id s3sm8159206pfk.7.2017.10.25.18.31.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 25 Oct 2017 18:31:31 -0700 (PDT)
From:   Alex Vandiver <alexmv@dropbox.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Peart <peartben@gmail.com>
Subject: [PATCH v2 3/4] fsmonitor: Document GIT_TRACE_FSMONITOR
Date:   Wed, 25 Oct 2017 18:31:16 -0700
Message-Id: <7b71969808cc83c677b7b349920fc5cffd5237fd.1508981451.git.alexmv@dropbox.com>
X-Mailer: git-send-email 2.15.0.rc1.413.g76aedb451
In-Reply-To: <20171026013117.30034-1-alexmv@dropbox.com>
References: <20171026013117.30034-1-alexmv@dropbox.com>
In-Reply-To: <9af6d28ef43edbc99a9b7a9c41990de0989bfc76.1508981451.git.alexmv@dropbox.com>
References: <9af6d28ef43edbc99a9b7a9c41990de0989bfc76.1508981451.git.alexmv@dropbox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Alex Vandiver <alexmv@dropbox.com>
---
 Documentation/git.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 1fca63634..720db196e 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -594,6 +594,10 @@ into it.
 Unsetting the variable, or setting it to empty, "0" or
 "false" (case insensitive) disables trace messages.
 
+`GIT_TRACE_FSMONITOR`::
+	Enables trace messages for the filesystem monitor extension.
+	See `GIT_TRACE` for available trace output options.
+
 `GIT_TRACE_PACK_ACCESS`::
 	Enables trace messages for all accesses to any packs. For each
 	access, the pack file name and an offset in the pack is
-- 
2.15.0.rc1.413.g76aedb451

