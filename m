Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F6F31F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 18:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751568AbdB0SCO (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 13:02:14 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36824 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751421AbdB0SCD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 13:02:03 -0500
Received: by mail-wr0-f196.google.com with SMTP id l37so2443873wrc.3
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 10:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X4OLQS7HyHzNuWo8wb7UGdZ1p++Px2bTsvXXWgvC99g=;
        b=dKBtkc6H0bVxD/dUMuaX10OaX0gVjLcIDypStR9xQo3ySJOnnlctXnrr6fxuE7G+I1
         FU2SNPaRAoC8+SRJTlvCg3VZM1LTgaspkDh86hpXJOlfT+rdv6vS8Y/WQ9ApqJT6h8lR
         ibDCnGVSmrPXHdD5XuuPsUp8vzWsGctj5KmcaIOjo4MJ2buCZnN99nbVN/5SC3wgAfzy
         z+PwVgGuueVPWwCVdWNCBgqF7sx8hMX33U6TDmJr7ELI5Yg6t8RSC45ZvVRdko3iTWSc
         deo1vZsFjMNzsbcpwYqUmftW/j2GZBsdvJTwi9rkm/w+KS7ZrejdthwgZSqbvJ9P2w5k
         Xf2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X4OLQS7HyHzNuWo8wb7UGdZ1p++Px2bTsvXXWgvC99g=;
        b=QD+I7xUiOIDq7v5bopaqjNLC+g3FRP97VXEFf10eOWCJUdDpDM1UZpxvt46dlLOZia
         RmkZegTqafEbvGp+DskXwwcDtQea+mbWnOgcWrWwnvnuTgtmayw9B4EwsDotKXsJT995
         KDbB2y62vbiTU/aiqqgpbK8QLZ/ED/bbuyoQohT6Gq3e1lfOG0yAaY8lcaIDSa+UuVk0
         q7O0UTl+lppH8JtmzHonDNX60k1f17DarF+B6f/+2OzZ2aLxL5UjKyXeo4jkw1aoH5+S
         /7mhvo71chxQMjVsqt7UbtKW4hIoT5rvZkNZiuXOUv7CAlYd0xPssQWht1aDcNU3lu9R
         FfwA==
X-Gm-Message-State: AMke39lVDshAp8zOQO6mKts21L46bqssZqiciVeUcROXbkghAVZsFoXoi8D42kff3EuAXg==
X-Received: by 10.223.166.137 with SMTP id t9mr15355870wrc.15.1488218448059;
        Mon, 27 Feb 2017 10:00:48 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id e73sm15226798wmi.32.2017.02.27.10.00.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Feb 2017 10:00:47 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 08/22] Documentation/config: add information for core.splitIndex
Date:   Mon, 27 Feb 2017 19:00:05 +0100
Message-Id: <20170227180019.18666-9-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.12.0.22.g0672473d40
In-Reply-To: <20170227180019.18666-1-chriscool@tuxfamily.org>
References: <20170227180019.18666-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 015346c417..61a863adeb 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -334,6 +334,10 @@ core.trustctime::
 	crawlers and some backup systems).
 	See linkgit:git-update-index[1]. True by default.
 
+core.splitIndex::
+	If true, the split-index feature of the index will be used.
+	See linkgit:git-update-index[1]. False by default.
+
 core.untrackedCache::
 	Determines what to do about the untracked cache feature of the
 	index. It will be kept, if this variable is unset or set to
-- 
2.12.0.22.g0672473d40

