Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24A8B1F454
	for <e@80x24.org>; Sat, 27 Oct 2018 06:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbeJ0PFT (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:05:19 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41828 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbeJ0PFS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:05:18 -0400
Received: by mail-lj1-f193.google.com with SMTP id u21-v6so3101222lja.8
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iJIGE0NclobRyCoCCAcqkR4dY31gVCvsjY2C8h21YVA=;
        b=VOrqr8JZvNE2wC3jU7eZAGd8+Z7C9vGbiVHNjpCIutyy2VWY2Pz4hHwJ3q/8DPyCLC
         9UKN4JzNtP7KAfz4ZtgKpJrgFWndbGhzETM6poLuDEhXnPEs3ivJzH1ATOqISPc/v3LM
         JLc8EeZ20uUBmI/Yfd450DUy60kjCfNdLdR3db+ge8+cdrZTe/aePs7A0Pac9Ve0emnz
         sEzCA0yfshryVuF6B08UMtoQuDUZoZ9ZR+qU+RyaZ5Ttdl7s/zCXaCKD5wSn//Ec3wdW
         KRZmkfA7/7cEPEt8GAPrYwtgsOrE+bDF82sP4wtfT80qn84iBnTysTQZFIZ8ucUONXxv
         IR/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iJIGE0NclobRyCoCCAcqkR4dY31gVCvsjY2C8h21YVA=;
        b=R7ywcJFgvnFHWAzmn4gegxFICH2X9XRhlzT6YPBFDwR74CBWn21PJyGjUznQ6uAhTu
         8DPt8JKBfrrIfebkyxY4/ON7lozzj0KF0M74CPHvdnGEnfZa7WYDWB4SWFPVc8CK99t+
         F2bjk0eEzUlvYaZ2/Nhh9tA+JjgEeJ4N5oRwSjqLdMgmJk8mwVQx2cOOSC4JxuMQRljs
         COGxZxybm+Nsr9rnGSwPWkavg76jpf3iHY7CSBZg9QwasjDUEDcNpYSON1K5gIc78jE7
         MB+U18yJDCn7XWsJb9KISaW5Ur+3RlK4Wn6RwFOrLwc9N7tbQpzCGBMjUsGCIz6eqUXn
         na3Q==
X-Gm-Message-State: AGRZ1gKNd4VDQVj8fuc9f3T8AEF+X+aACNP4gfDz7mvYRR43WD/3rZ5t
        pXpWD1rV9EfLPlorly3+4h24vdpc
X-Google-Smtp-Source: AJdET5cZ8h4fOYt4lMveBkBXqQ/TpIQRh5QUoZeMoLi0ilQr5T9LYS+rSAyH58LVKScPqJ9fZRnZPw==
X-Received: by 2002:a2e:8511:: with SMTP id j17-v6mr4253508lji.55.1540621522191;
        Fri, 26 Oct 2018 23:25:22 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.25.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:25:21 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 75/78] config.txt: move versionsort.* to a separate file
Date:   Sat, 27 Oct 2018 08:23:48 +0200
Message-Id: <20181027062351.30446-76-pclouds@gmail.com>
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
 Documentation/config.txt             | 34 +---------------------------
 Documentation/config/versionsort.txt | 33 +++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 33 deletions(-)
 create mode 100644 Documentation/config/versionsort.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 3cba2420e0..eacaaa2deb 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -431,39 +431,7 @@ include::config/url.txt[]
 
 include::config/user.txt[]
 
-versionsort.prereleaseSuffix (deprecated)::
-	Deprecated alias for `versionsort.suffix`.  Ignored if
-	`versionsort.suffix` is set.
-
-versionsort.suffix::
-	Even when version sort is used in linkgit:git-tag[1], tagnames
-	with the same base version but different suffixes are still sorted
-	lexicographically, resulting e.g. in prerelease tags appearing
-	after the main release (e.g. "1.0-rc1" after "1.0").  This
-	variable can be specified to determine the sorting order of tags
-	with different suffixes.
-+
-By specifying a single suffix in this variable, any tagname containing
-that suffix will appear before the corresponding main release.  E.g. if
-the variable is set to "-rc", then all "1.0-rcX" tags will appear before
-"1.0".  If specified multiple times, once per suffix, then the order of
-suffixes in the configuration will determine the sorting order of tagnames
-with those suffixes.  E.g. if "-pre" appears before "-rc" in the
-configuration, then all "1.0-preX" tags will be listed before any
-"1.0-rcX" tags.  The placement of the main release tag relative to tags
-with various suffixes can be determined by specifying the empty suffix
-among those other suffixes.  E.g. if the suffixes "-rc", "", "-ck" and
-"-bfs" appear in the configuration in this order, then all "v4.8-rcX" tags
-are listed first, followed by "v4.8", then "v4.8-ckX" and finally
-"v4.8-bfsX".
-+
-If more than one suffixes match the same tagname, then that tagname will
-be sorted according to the suffix which starts at the earliest position in
-the tagname.  If more than one different matching suffixes start at
-that earliest position, then that tagname will be sorted according to the
-longest of those suffixes.
-The sorting order between different suffixes is undefined if they are
-in multiple config files.
+include::config/versionsort.txt[]
 
 web.browser::
 	Specify a web browser that may be used by some commands.
diff --git a/Documentation/config/versionsort.txt b/Documentation/config/versionsort.txt
new file mode 100644
index 0000000000..6c7cc054fa
--- /dev/null
+++ b/Documentation/config/versionsort.txt
@@ -0,0 +1,33 @@
+versionsort.prereleaseSuffix (deprecated)::
+	Deprecated alias for `versionsort.suffix`.  Ignored if
+	`versionsort.suffix` is set.
+
+versionsort.suffix::
+	Even when version sort is used in linkgit:git-tag[1], tagnames
+	with the same base version but different suffixes are still sorted
+	lexicographically, resulting e.g. in prerelease tags appearing
+	after the main release (e.g. "1.0-rc1" after "1.0").  This
+	variable can be specified to determine the sorting order of tags
+	with different suffixes.
++
+By specifying a single suffix in this variable, any tagname containing
+that suffix will appear before the corresponding main release.  E.g. if
+the variable is set to "-rc", then all "1.0-rcX" tags will appear before
+"1.0".  If specified multiple times, once per suffix, then the order of
+suffixes in the configuration will determine the sorting order of tagnames
+with those suffixes.  E.g. if "-pre" appears before "-rc" in the
+configuration, then all "1.0-preX" tags will be listed before any
+"1.0-rcX" tags.  The placement of the main release tag relative to tags
+with various suffixes can be determined by specifying the empty suffix
+among those other suffixes.  E.g. if the suffixes "-rc", "", "-ck" and
+"-bfs" appear in the configuration in this order, then all "v4.8-rcX" tags
+are listed first, followed by "v4.8", then "v4.8-ckX" and finally
+"v4.8-bfsX".
++
+If more than one suffixes match the same tagname, then that tagname will
+be sorted according to the suffix which starts at the earliest position in
+the tagname.  If more than one different matching suffixes start at
+that earliest position, then that tagname will be sorted according to the
+longest of those suffixes.
+The sorting order between different suffixes is undefined if they are
+in multiple config files.
-- 
2.19.1.647.g708186aaf9

