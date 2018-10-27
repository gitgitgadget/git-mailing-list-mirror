Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B5D81F454
	for <e@80x24.org>; Sat, 27 Oct 2018 06:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbeJ0PFM (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:05:12 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36275 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728520AbeJ0PFL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:05:11 -0400
Received: by mail-lj1-f196.google.com with SMTP id s15-v6so3127591lji.3
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pgm15OlkK8kRZWm7HJi+2AJyelwdVvOmyLVPjmav5N0=;
        b=QysHbeI1B9hhAa6pP02p+r+hJpGdrvl6y9CggLaQvaqvLlfq9ZY5JYqqXzlyEY9q8f
         7pYg1z1qAE/+A82e97x8v3xzAwyvrB50YYm2rIvu2AtSd3rdpm/HljRtDjl9cYsWg/Fu
         2mOBqeJ6m4zQcJC+OjY4H7in9B96VlGLB8gyOZfxNVx5+E3XT7V1tKAYAdM+q3bIOgdI
         7Zz3ho2dxeGTtKUhOW5f6dGgvQJivAp7OcIeMfS+SaDg4bsFuiwQBE2YZiplKA35EyoZ
         6IfwlLOph1dnnOfRmeMIfpH8/8FRKjvcECi7SgppcxVnclECmrmNVo8OlBIGYZ82zDzY
         HvzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pgm15OlkK8kRZWm7HJi+2AJyelwdVvOmyLVPjmav5N0=;
        b=q1afM2SjOqaDaHVyim86eZJIND4qc+H1YjMUGh0yz4l0aUb7Y48O/KRVWTQRLBa31N
         6Wh1mSPr/z7haX5wW0nXDIMpcE0aD9shjqLbu4AIBVrQJ7WlAicsV1J8W6XhopeJxI0M
         o3ddTjOuS8J32DcwXfT+QCbjwnoaijvJg0hPWEvENGpk7EJwcjk4mPt8A1+ctigkGyBr
         GTPzdFwLGMPoGjgu6QRr0AbvqMSHalvQPRxb/FTCSn1m7xQttVsdO6KOctphBu6Yx8qT
         xY/Tvyo+JwZ22z1VbcOZif/Tp5ASMkCWpsnqQfR55n8Pvg8vkCmmCXCzSvVMMqBEUc3H
         ktvw==
X-Gm-Message-State: AGRZ1gLUJc67B2zJwve3AKf19ag4PfLF+z3b+bu2j2mtAM7h1il0HzTS
        T0BKzb7WF+USqdbBwD6haw5AFozg
X-Google-Smtp-Source: AJdET5d16YMqfVn9oMFTEpimwSYOXTY8uQ08wzkZpGaNw6U55l+xYpaOiFsUPWh+g1APm1MF7Ezosw==
X-Received: by 2002:a2e:5159:: with SMTP id b25-v6mr4596977lje.156.1540621515762;
        Fri, 26 Oct 2018 23:25:15 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.25.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:25:15 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 69/78] config.txt: move tag.* to a separate file
Date:   Sat, 27 Oct 2018 08:23:42 +0200
Message-Id: <20181027062351.30446-70-pclouds@gmail.com>
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
 Documentation/config.txt     | 17 +----------------
 Documentation/config/tag.txt | 16 ++++++++++++++++
 2 files changed, 17 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/config/tag.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 966e82e851..1db9c58e8d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -419,22 +419,7 @@ include::config/stash.txt[]
 
 include::config/submodule.txt[]
 
-tag.forceSignAnnotated::
-	A boolean to specify whether annotated tags created should be GPG signed.
-	If `--annotate` is specified on the command line, it takes
-	precedence over this option.
-
-tag.sort::
-	This variable controls the sort ordering of tags when displayed by
-	linkgit:git-tag[1]. Without the "--sort=<value>" option provided, the
-	value of this variable will be used as the default.
-
-tar.umask::
-	This variable can be used to restrict the permission bits of
-	tar archive entries.  The default is 0002, which turns off the
-	world write bit.  The special value "user" indicates that the
-	archiving user's umask will be used instead.  See umask(2) and
-	linkgit:git-archive[1].
+include::config/tag.txt[]
 
 transfer.fsckObjects::
 	When `fetch.fsckObjects` or `receive.fsckObjects` are
diff --git a/Documentation/config/tag.txt b/Documentation/config/tag.txt
new file mode 100644
index 0000000000..663663bdec
--- /dev/null
+++ b/Documentation/config/tag.txt
@@ -0,0 +1,16 @@
+tag.forceSignAnnotated::
+	A boolean to specify whether annotated tags created should be GPG signed.
+	If `--annotate` is specified on the command line, it takes
+	precedence over this option.
+
+tag.sort::
+	This variable controls the sort ordering of tags when displayed by
+	linkgit:git-tag[1]. Without the "--sort=<value>" option provided, the
+	value of this variable will be used as the default.
+
+tar.umask::
+	This variable can be used to restrict the permission bits of
+	tar archive entries.  The default is 0002, which turns off the
+	world write bit.  The special value "user" indicates that the
+	archiving user's umask will be used instead.  See umask(2) and
+	linkgit:git-archive[1].
-- 
2.19.1.647.g708186aaf9

