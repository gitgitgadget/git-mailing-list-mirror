Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FEDB1F453
	for <e@80x24.org>; Sat, 27 Oct 2018 06:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbeJ0PEU (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:04:20 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39686 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728417AbeJ0PET (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:04:19 -0400
Received: by mail-lf1-f65.google.com with SMTP id p11-v6so2488169lfc.6
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+dUigzDQWahsQlA6R+Kk2WKiVzjQHiIfE358k1E21n4=;
        b=EDf2dK2SYLnVCtj3HuzKaToMmA/uqriQnoWteVionstpUnBruSgl07ejQMe5C/zajG
         RdAeP6QDx675Xm1okBKDTvH1cf+e6IgVvLIhtWthrK+efvt/Acyp90hMfwdt8Skl7GEY
         ayGIidoQ50mcyHjTrdWtVNdJNoGY6jgqddknJcILmUoctgqcfOT2SJThQkWN4oE+DTP0
         ZMqBTmDw+0mHTtf3jDd7m2ZJwC6PfgvQGEpM9tbfeson5PGFOZCE7JUt2n7vJhpMJBxK
         Pvm3eZWuNjbghULatH6M63pbN1YX6F5YTk2Y9X6saVmCYjEpYVT8Wo++WGC9dXP9MVrJ
         0NAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+dUigzDQWahsQlA6R+Kk2WKiVzjQHiIfE358k1E21n4=;
        b=BlSX4QoPA0/jUD4J+ieOiA2f/acM1z2dhqt5OXsxmaJ35H8V7nZRWRT6+VBuC8q0UJ
         cAzK16srLonwK70ZY3ah+BMgARlXRMS8mXGP+cZ4wKVX4UDP9b7rM4UaG57HCmtpllFe
         VUOB//4R7RB/j0/T2tWnJjZeNjxwJ0wI93SNlh3lY9fj3NzDUArxg8LLxS99VEQVJLx5
         AxatPFq7xYdVNVDFpZk7QmxFHItkqmjR0TwrVlLTYX8MiMivqKHJizjkBaBvi/scXwkh
         ULe4I1Y1mW26KCRd9f1bvtQLLwpr+R7L/bXcBclSLCpWv7ZiYLDUIvyOVt4IbLGu4Fme
         I5UA==
X-Gm-Message-State: AGRZ1gIarLI5O9NS0vgs5NKQ5mQcGo5iH7bL84AKRIygA21MWaxypD8w
        1Vjh7Piq+yIh0GmRETElvUuPPVk+
X-Google-Smtp-Source: AJdET5f4ozyhsLqIERKvtg2DQ+TC/Ov3PQRiwasaRrxSAo5ET0yFuwGKleHQehxR/uZpE6hUbSTe9A==
X-Received: by 2002:a19:5d45:: with SMTP id p5mr3091519lfj.35.1540621464583;
        Fri, 26 Oct 2018 23:24:24 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.24.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:24:23 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 24/78] config.txt: move fmt-merge-msg-config.txt to config/
Date:   Sat, 27 Oct 2018 08:22:57 +0200
Message-Id: <20181027062351.30446-25-pclouds@gmail.com>
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

Note that this file is not directly included in config.txt but through
merge-config.txt and it's in "merge" section instead of a separate
"fmtMergeMsg" section like others.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 .../{fmt-merge-msg-config.txt => config/fmt-merge-msg.txt}      | 0
 Documentation/git-fmt-merge-msg.txt                             | 2 +-
 Documentation/merge-config.txt                                  | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename Documentation/{fmt-merge-msg-config.txt => config/fmt-merge-msg.txt} (100%)

diff --git a/Documentation/fmt-merge-msg-config.txt b/Documentation/config/fmt-merge-msg.txt
similarity index 100%
rename from Documentation/fmt-merge-msg-config.txt
rename to Documentation/config/fmt-merge-msg.txt
diff --git a/Documentation/git-fmt-merge-msg.txt b/Documentation/git-fmt-merge-msg.txt
index 423b6e033b..6793d8fc05 100644
--- a/Documentation/git-fmt-merge-msg.txt
+++ b/Documentation/git-fmt-merge-msg.txt
@@ -51,7 +51,7 @@ OPTIONS
 
 CONFIGURATION
 -------------
-include::fmt-merge-msg-config.txt[]
+include::config/fmt-merge-msg.txt[]
 
 merge.summary::
 	Synonym to `merge.log`; this is deprecated and will be removed in
diff --git a/Documentation/merge-config.txt b/Documentation/merge-config.txt
index 662c2713ca..0bb703fbac 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -30,7 +30,7 @@ merge.verifySignatures::
 	If true, this is equivalent to the --verify-signatures command
 	line option. See linkgit:git-merge[1] for details.
 
-include::fmt-merge-msg-config.txt[]
+include::config/fmt-merge-msg.txt[]
 
 merge.renameLimit::
 	The number of files to consider when performing rename detection
-- 
2.19.1.647.g708186aaf9

