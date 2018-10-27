Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E62A31F453
	for <e@80x24.org>; Sat, 27 Oct 2018 06:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbeJ0PEv (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:04:51 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46317 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728494AbeJ0PEu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:04:50 -0400
Received: by mail-lf1-f65.google.com with SMTP id o2-v6so2462012lfl.13
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QplCtkaDuUtMuyf2Roe21ES+wFnR0RypRvuejeV7x5U=;
        b=QfqEKNaU5nHkowskVTFIhVFNqh9JXCpFSg3/0I6DxxhgK18bx4sKj/h4c0jJF4hZ+c
         BCYRExWKLNsPbJhFQuvMs3MYqGak4UqdBT5YnWc1qBFMyJV35EgI0eP+SsLZbVlSdUsH
         2Q8BKqbm02+9f/HaAAPQW6GzS4hCHFJvD+km4+GREkdPjw8pBpqe2rfkrrPJ1SnDLcOP
         OTKTwq77gnBxkPnlcU+XwImVI+p01M8OvFS34d+Zkpfskj0K7hk5lQy4H5M8iLB/PXjL
         fMMxV8mPsFYSDeaUTMuETge1a4sfAHPvZqWTg9iygzAqzlQGsol4rIAygjWmjhVReiOU
         LOcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QplCtkaDuUtMuyf2Roe21ES+wFnR0RypRvuejeV7x5U=;
        b=q9dEdkE6HFwwnj8r5QCpuGIi0uuGcZMADG0+BARmExGnYSZYU87jsqDmqO5/AYPYmi
         dviOsgToF69lXbynUZ/sP0rUM33wRWOaGxKmkcdGcKfGERqFMwRVV41OG7TzU5pVfeka
         187TNFuvYDHKpTaaYIYQi8tF3WDRw3WhElMNT/iQEdDbl2NwY6ftACuNMZgOFFV9Wpj/
         PB5KLAEW24ruT1Yzz/x68aj7gWofNR4W79kQ2s9eyuJYNHcBiK4ncmEElm57t2kqdJf/
         dZyKyqufwdFwlRpuKlezzJt5WGygOqKRJK168ZkeLu5hUGtug6g0ZRUEVMHpRcA6MMxK
         Wu2A==
X-Gm-Message-State: AGRZ1gJwJzG+/+4pRY+fruPrVGwzbttst2m41bNshjx5ZeGjmeCK5f4U
        gA2PXj5Y0rIi7rX1WHY71c8bNZT6
X-Google-Smtp-Source: AJdET5c7BQV+0ZnBv6xEjvaHw+7W5k0p6yhlaKC3+xik/YYAnkgGTbtzgXjm089ijhmFzfsgtFvUkw==
X-Received: by 2002:a19:fc09:: with SMTP id a9mr3989985lfi.21.1540621495051;
        Fri, 26 Oct 2018 23:24:55 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.24.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:24:54 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 51/78] config.txt: move pretty.* to a separate file
Date:   Sat, 27 Oct 2018 08:23:24 +0200
Message-Id: <20181027062351.30446-52-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181027062351.30446-1-pclouds@gmail.com>
References: <20181027062351.30446-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt        | 10 +---------
 Documentation/config/pretty.txt |  9 +++++++++
 2 files changed, 10 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/config/pretty.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index a7b72d2722..d55776c383 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -381,15 +381,7 @@ include::config/pack.txt[]
 
 include::config/pager.txt[]
 
-pretty.<name>::
-	Alias for a --pretty= format string, as specified in
-	linkgit:git-log[1]. Any aliases defined here can be used just
-	as the built-in pretty formats could. For example,
-	running `git config pretty.changelog "format:* %H %s"`
-	would cause the invocation `git log --pretty=changelog`
-	to be equivalent to running `git log "--pretty=format:* %H %s"`.
-	Note that an alias with the same name as a built-in format
-	will be silently ignored.
+include::config/pretty.txt[]
 
 protocol.allow::
 	If set, provide a user defined default policy for all protocols which
diff --git a/Documentation/config/pretty.txt b/Documentation/config/pretty.txt
new file mode 100644
index 0000000000..063c6b63d9
--- /dev/null
+++ b/Documentation/config/pretty.txt
@@ -0,0 +1,9 @@
+pretty.<name>::
+	Alias for a --pretty= format string, as specified in
+	linkgit:git-log[1]. Any aliases defined here can be used just
+	as the built-in pretty formats could. For example,
+	running `git config pretty.changelog "format:* %H %s"`
+	would cause the invocation `git log --pretty=changelog`
+	to be equivalent to running `git log "--pretty=format:* %H %s"`.
+	Note that an alias with the same name as a built-in format
+	will be silently ignored.
-- 
2.19.1.647.g708186aaf9

