Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0C131F954
	for <e@80x24.org>; Wed, 22 Aug 2018 16:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbeHVTbk (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 15:31:40 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43137 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbeHVTbk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 15:31:40 -0400
Received: by mail-lj1-f196.google.com with SMTP id m84-v6so1832526lje.10
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 09:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6hfGwiNCfVwldws+t5vdOHTISEA5qHBCfEHERr+ALzw=;
        b=I0jpat5l6zg28DIew+0FtOl5OhroJWUACcblK4hyKWSDFjnZGSLZBikYpPwtmo3Br6
         U+X5a1XkS4uFneAE9c1k+bEGi24Sc+JJK2iZnhk3q7tAHnS8KM24yNbnd8QoSjS9wjCu
         N3q3vzORy+o3Xa63V/v2xeRleYrMVQtN51LNL0+wMX8lGOny1tyKA9cg6Y2Q9YGvSbNz
         G9ets4t+8UdgoMqw+gmYtON7zbU4e2MJvsvkkUAvP/7R8fbGPvzJuAUtTADGaVKdMEK0
         31pUp6kSa1w6+ag7MbsehYCjU1jFD3m0w9HL4QkmW4yIWjT0BuQT0fFCUfLpSaYgmllY
         Qqag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6hfGwiNCfVwldws+t5vdOHTISEA5qHBCfEHERr+ALzw=;
        b=TecnVrITNF1z4p1pXHbsq+OLETFu42WCoFBi3bYYoKgB/GV6eGbBbTpKddcKjSDwR9
         M8tu7/JiiSRwsX1rIyN+RS6bqyZBEz6ttQmlmZK7wOicp3AI4O7ZnkuijlkGElcwnbKb
         7R9sW7dgZuCh8I77q1eGYXM7LC3/faIdfdq7HMlKtsKG6GrI8ImQUloaVoWC7ciiRvOg
         5HUC6mP5UV9jqPaQeNsTK+L22aH+VYODiqDr5RtbiIMxFVy+tF5nIZx5k6a9R8u/I87Z
         Y4uZ2wD5Vb+680jDvYl/SpE+4+mevNeoFzdOmYaCSVjQUbvD/04kwZWpLh/tlqM7GtOD
         578A==
X-Gm-Message-State: AOUpUlHxFOurHMS0Daog756YNB5nxx9qfa1MjWatGAiEdGpwoQG6y701
        ISswB8gVrGZfm6P9uBpTDSwB9m3f
X-Google-Smtp-Source: AA+uWPyoMWXz91Ydye8JUKFKP+cR+6LgLcP98j/CQ+tBb7B6Sd+L8StJzly1Dd4mVD1ffwrScyNpvw==
X-Received: by 2002:a2e:2d0a:: with SMTP id t10-v6mr25338839ljt.8.1534953969585;
        Wed, 22 Aug 2018 09:06:09 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id u86-v6sm375213lfi.90.2018.08.22.09.06.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 09:06:08 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 01/11] config.txt: follow camelCase naming
Date:   Wed, 22 Aug 2018 18:05:55 +0200
Message-Id: <20180822160605.21864-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.335.ga73d156e9c
In-Reply-To: <20180822160605.21864-1-pclouds@gmail.com>
References: <20180822160605.21864-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1c42364988..30adca61ee 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -3282,7 +3282,7 @@ sendemail.smtpReloginDelay::
 	Seconds wait before reconnecting to smtp server.
 	See also the `--relogin-delay` option of linkgit:git-send-email[1].
 
-showbranch.default::
+showBranch.default::
 	The default set of branches for linkgit:git-show-branch[1].
 	See linkgit:git-show-branch[1].
 
-- 
2.19.0.rc0.335.ga73d156e9c

