Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3ADA320229
	for <e@80x24.org>; Sun, 23 Oct 2016 09:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756448AbcJWJ1z (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Oct 2016 05:27:55 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34951 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754677AbcJWJ1U (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Oct 2016 05:27:20 -0400
Received: by mail-wm0-f66.google.com with SMTP id o81so5222887wma.2
        for <git@vger.kernel.org>; Sun, 23 Oct 2016 02:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jYdQGVsYUTHr/1xpNaliY2gPUwXOOgTlnHRu5hmrR7c=;
        b=OcKcjopOQk0bQXh1EeSAdEPFpXpfZZKInoEYJ3jO45e1fbFWJHT2igfRoUuhKTbPZt
         YjPM7BdQabF9o92LqfsOz6uGmaSfPP18KWcZWyqXszJ2xR9OZRPtRynekBhNwLnmB1fF
         fAghVb8pmjZvPglJl9sJUsSHH70YVRghMlHyfK2xuSfNr8a5rk5lw8jewA5enOen1Oqt
         /ZzVFwulqTfWzSVgCsze93aSPzfeTPVQpd9+8PaV/Q2+qvKdRP9TnM5MJ53QdyvcRg98
         a+sW1zrHAFx2bKDZgLXMu7musLOYMAO9+7NnfiA3ITFj7g1JHBvC9VTesc+cDLddrqZP
         /rSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jYdQGVsYUTHr/1xpNaliY2gPUwXOOgTlnHRu5hmrR7c=;
        b=leCJqT35ByyB1Fvsl5Py4W5o6CXXqFs7VOuMo8/LweiOxTn0D3YY36JswEqSurYSEX
         lmGHuUY41M/QRd7H8yzo2HPZaqBimszdPkpbUo/eYxk+5hNd9UExKDaw+KcCmX4J6vkd
         nB5Hbj45JeVGlAfe1Hr7K/HI8ljqfyyEfO/aZJzPVdmHKoHB01VhNhCETHewec3yR7PQ
         Goakajy6tnV+riz4jo+cSFg97wEOtnlktCJsAL/PoSUO+kK6a4eGmH6YMfWrW6s7r3ZE
         5Jq+JP/XSeCmcyf04NhOaWJyokgHELJVGvkgOJo2g6oRY6L2a9D5QoPmCJ7CF0/CDfqs
         asGA==
X-Gm-Message-State: AA6/9Rk8+MORjLnKHfQPe6BUCP5PebmkKoFSizjCNo4HDH6xZ3LjfV6aX2Qq//bYULSfHw==
X-Received: by 10.28.1.83 with SMTP id 80mr9716894wmb.31.1477214839146;
        Sun, 23 Oct 2016 02:27:19 -0700 (PDT)
Received: from localhost.localdomain (183.187.113.78.rev.sfr.net. [78.113.187.183])
        by smtp.gmail.com with ESMTPSA id x138sm8257569wme.14.2016.10.23.02.27.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 23 Oct 2016 02:27:18 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v1 08/19] Documentation/git-update-index: talk about core.splitIndex config var
Date:   Sun, 23 Oct 2016 11:26:37 +0200
Message-Id: <20161023092648.12086-9-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.1.462.g7e1e03a
In-Reply-To: <20161023092648.12086-1-chriscool@tuxfamily.org>
References: <20161023092648.12086-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-update-index.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 7386c93..e091b2a 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -171,6 +171,12 @@ may not support it yet.
 	given again, all changes in $GIT_DIR/index are pushed back to
 	the shared index file. This mode is designed for very large
 	indexes that take a significant amount of time to read or write.
++
+These options take effect whatever the value of the `core.splitIndex`
+configuration variable (see linkgit:git-config[1]). But a warning is
+emitted when the change goes against the configured value, as the
+configured value will take effect next time the index is read and this
+will remove the intended effect of the option.
 
 --untracked-cache::
 --no-untracked-cache::
-- 
2.10.1.462.g7e1e03a

