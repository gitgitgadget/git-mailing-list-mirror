Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBCC9200E0
	for <e@80x24.org>; Mon, 26 Dec 2016 10:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755681AbcLZKWz (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Dec 2016 05:22:55 -0500
Received: from mail-wj0-f195.google.com ([209.85.210.195]:34978 "EHLO
        mail-wj0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755059AbcLZKWs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Dec 2016 05:22:48 -0500
Received: by mail-wj0-f195.google.com with SMTP id hb5so14857041wjc.2
        for <git@vger.kernel.org>; Mon, 26 Dec 2016 02:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dheYtaRdfTNafNQWNGHhPInDPUFX/sahT9Khn0syEpw=;
        b=WPoptExH+hgQAr3sukIIMBddHziBrSPMbqn9VlZZ2TFtbfmx7aWl5Tt9+5v+AufJdC
         0RyWww/GDP5Kk4Gi6pS1+gFhDUe8ciyjeiwaLcoQcPCgjGxY8rxRM74l8iC5MxRj6K6r
         XRHPoaS/Vq84vyIC4o4wZW1WXSwMiA94wbJ8Qf+67FYd15wuhk1etSg9d0yyqPNXISUP
         4Wz/CCJP15lOnz3qYPH+BwS0HXlXtpJaWW9oOtQpx50XrIeFXr7Yn37VkfNM7zj2D5vi
         5zEU+n7W9P9VYZ0cceo08HfarsZ8r+w9Z10t1dutHHQsGWnmWdNOAMqu/Frt3wWiXaPR
         mgrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dheYtaRdfTNafNQWNGHhPInDPUFX/sahT9Khn0syEpw=;
        b=uA+ggW4VCIhJmuU8pN5qmg2qOEMDAaMgByNlTwj6ff7rKE/pPTu6rBzmNvE8k0LsiZ
         kYQnjC5j/p63cfGOHFKah7STVwnNfVXwSgckZ16s7TfImvIaBYv2fz7UTEXDh3fk7x1i
         tsNwYcjBGuTIv0FKbIltw+UsILeQOJoKTzEXeMOEdzuN0yvPLbc42thAWDM9g+A51lOV
         xQsxQ5AiXVmwMk+g55v3gllJoNMD74G6C+H8qVEHd5yfAEkXtZZ5ceyAbGfAm2yszhzR
         U1KGGDeZDd+5edM9o08xlRIdOAsRuqSdqQ0GwFGqfoWIruonE3hiaXJ+YS09c6q9I+m5
         Hn4w==
X-Gm-Message-State: AIkVDXJY4214KB4j8/wubylQ4/MNS/wewVul21/pHTsZjB1f5cPvIhGlauTtSEvdb95Evw==
X-Received: by 10.194.93.104 with SMTP id ct8mr27330345wjb.87.1482747766866;
        Mon, 26 Dec 2016 02:22:46 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id kp5sm54259010wjb.8.2016.12.26.02.22.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Dec 2016 02:22:46 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 12/21] Documentation/config: add splitIndex.maxPercentChange
Date:   Mon, 26 Dec 2016 11:22:13 +0100
Message-Id: <20161226102222.17150-13-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.11.0.209.gda91e66374.dirty
In-Reply-To: <20161226102222.17150-1-chriscool@tuxfamily.org>
References: <20161226102222.17150-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 221c5982c0..e0f5a77980 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2773,6 +2773,19 @@ showbranch.default::
 	The default set of branches for linkgit:git-show-branch[1].
 	See linkgit:git-show-branch[1].
 
+splitIndex.maxPercentChange::
+	When the split index feature is used, this specifies the
+	percent of entries the split index can contain compared to the
+	whole number of entries in both the split index and the shared
+	index before a new shared index is written.
+	The value should be between 0 and 100. If the value is 0 then
+	a new shared index is always written, if it is 100 a new
+	shared index is never written.
+	By default the value is 20, so a new shared index is written
+	if the number of entries in the split index would be greater
+	than 20 percent of the total number of entries.
+	See linkgit:git-update-index[1].
+
 status.relativePaths::
 	By default, linkgit:git-status[1] shows paths relative to the
 	current directory. Setting this variable to `false` shows paths
-- 
2.11.0.209.gda91e66374.dirty

