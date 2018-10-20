Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13F391F453
	for <e@80x24.org>; Sat, 20 Oct 2018 12:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbeJTUut (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 16:50:49 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42861 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727739AbeJTUus (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 16:50:48 -0400
Received: by mail-lf1-f68.google.com with SMTP id s10-v6so27111725lfc.9
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 05:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SI4+IDM2p23amc/t3O6T/cd4AndKjQoQXD0/G0/lZTc=;
        b=I1qL7/Zdl8nhly3QFgKi0/la72BBNYvWvnfdrMzJo48jr9UR2gq035KyF5SGSVO1ij
         t0cTqDJRwiiZpvDDcJmGQIkreDQujOjOFT2txYrVlAoh3MpAWdDYJPcyr8REsTOXhlRB
         xLet9ejp8w2bL5pBYvnXIUagZkbL4E71nUppkuIQqNfY4P4I3Qf36UaTknXkhtTcSY+b
         /zMjh3o3mLzh9xDDpyomBGHmeRoG+DTsF7Ofo4TqPtvHIBJ5QovkOWt8C0+B5ReiNmlh
         BqJMT+sgVaE+p8cQ7r1FCpbtDRuKJJz/Sj52nu8fACbJdu1OP3ElOfBJhm0/DEybppvn
         OCCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SI4+IDM2p23amc/t3O6T/cd4AndKjQoQXD0/G0/lZTc=;
        b=eF+53PfT61kCdULujbQHrQz2zFoIfmfUFOlwCtS3pTxkQ9iqhKt2amWK8TFUP5LUYi
         7KjaCFik53ishZfYgqZWSSF+f6n+9RRE2y1TRjh2hqtdHLXnblKr9WADWY7ULJi+ABvP
         1rkSVw7ledX2xZ7ZoDKWqjrEPvIgyG+NCHyrsReOtfgqyGNZrohQ1IzoGMsSpKcYD9nu
         frxXeLA8NsmQEuZYuxOllNCTOYvtMC6XeQqyKU8/DusY9nBfcFpUWMVwErg98mpH3U0x
         4A1YxUP2eWBxKWKNnQ2xXRvZNtnhwgMEp1volZec6GsEbSNt4fV2VMLNmxRAedAuSz3g
         Wq/w==
X-Gm-Message-State: ABuFfohyU/h1Mljq55FkN3tXCe+IL3MzbC2cyDSP7qSWST5ksbF9n7p6
        j4ZTntWp1dUtm4CBFN1N4Z3KYMHv
X-Google-Smtp-Source: ACcGV61GVS0Zn38Y4zb+5jw1rS36+s22Ab/NsPbHSRBylnV7XXZ7f5Y+mE7MkmGRV+lGQnriaY0fiQ==
X-Received: by 2002:a19:53d9:: with SMTP id h86-v6mr5500577lfl.75.1540039225570;
        Sat, 20 Oct 2018 05:40:25 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o22-v6sm5759379ljc.79.2018.10.20.05.40.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 05:40:24 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 57/59] config.txt: move versionsort.* to a separate file
Date:   Sat, 20 Oct 2018 14:38:46 +0200
Message-Id: <20181020123848.2785-58-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181020123848.2785-1-pclouds@gmail.com>
References: <20181020123848.2785-1-pclouds@gmail.com>
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
 Documentation/versionsort-config.txt | 33 +++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 33 deletions(-)
 create mode 100644 Documentation/versionsort-config.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 3ccf88ea4c..05fb670be2 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -680,39 +680,7 @@ include::url-config.txt[]
 
 include::user-config.txt[]
 
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
+include::versionsort-config.txt[]
 
 web.browser::
 	Specify a web browser that may be used by some commands.
diff --git a/Documentation/versionsort-config.txt b/Documentation/versionsort-config.txt
new file mode 100644
index 0000000000..6c7cc054fa
--- /dev/null
+++ b/Documentation/versionsort-config.txt
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

