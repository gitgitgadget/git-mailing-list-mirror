Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E78E01F454
	for <e@80x24.org>; Sat, 27 Oct 2018 06:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbeJ0PFR (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:05:17 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40440 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbeJ0PFQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:05:16 -0400
Received: by mail-lj1-f193.google.com with SMTP id t22-v6so3107995lji.7
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7SchX1vUedUUvPVnL3ZmXnHVS5w3k+OMkkYe36cU148=;
        b=mOZstiXDwA1R+We34uc5gc/Hn83FTZWrxriSBtP13X+AyLXsKMTFwruiw9x72kpgoP
         TaF/XBNlO+KKlFLsvZzX25H9XvcGgIAaldikd54H1pPasXaMmxD9cqJMPNh/hX2I6b5Z
         Bqxjw6Qis5sBYxS4BJbHtdrP/X08LmImRUk+gJSum06sQkTd80SdpUGCMZDN9NDricrW
         zP1XVyg78t8casYGviJczsLwJsaSkOgH9XhKusvBD/8xau+a1GAGED0YS4XntnZ67LfQ
         5OXqMg+Pp9lYm7ab2c6758lXsJv7B7e8r+4YOX6VWKxNakgbsttlilmCu3qSodxMP9Le
         dnrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7SchX1vUedUUvPVnL3ZmXnHVS5w3k+OMkkYe36cU148=;
        b=Am4VP5FHKltQ60dmuhMqzNe1Hd8MP5YUyuvorErWu9Ii7HHMtpsxZ+t3ZRCEo02qVw
         SxJraaRUcArhxwAaLNshx3bCXrTsKw6vOp3XiuBfTSYW2QVvIgYFtdJMncC+q1lNZJ3o
         +Ev2fzLT9Km/RTPp71ee3Ji6TQ3BwG9N0Q5VvHAJodCmCpmGn1pvm7o4g5VVKJyPBypp
         s6K0UQG9/mMQLHv2CFyfYV9GGZnM5noBNqI7MX55ZAr2CovyTUaqKfVPEooscE9BWySi
         iKICrFfndpCXKf1qFJNnlElEy1oqFD4Vbb+p9fUjuqoYWTp0J0XBA2tclcMTwvUja+uQ
         gNeQ==
X-Gm-Message-State: AGRZ1gJVXBD0Lk7WXTnV8yngCxcGk4jMFwhERc2EEx1X5t5LAwUFirkN
        ITRmPIeHxwnD6wlwHyZA6E/jVXXE
X-Google-Smtp-Source: AJdET5dxdP/YVqsu5Mb9KHmje++HsWVtFIWDClnZXtaLuAFpmC8NFCZWBd2YPPBlT1SirY1ZspIsig==
X-Received: by 2002:a2e:5b1d:: with SMTP id p29-v6mr4158322ljb.176.1540621520140;
        Fri, 26 Oct 2018 23:25:20 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.25.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:25:19 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 73/78] config.txt: move url.* to a separate file
Date:   Sat, 27 Oct 2018 08:23:46 +0200
Message-Id: <20181027062351.30446-74-pclouds@gmail.com>
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
 Documentation/config.txt     | 31 +------------------------------
 Documentation/config/url.txt | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 30 deletions(-)
 create mode 100644 Documentation/config/url.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 451c9fe2b3..924776f7fa 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -427,36 +427,7 @@ include::config/uploadarchive.txt[]
 
 include::config/uploadpack.txt[]
 
-url.<base>.insteadOf::
-	Any URL that starts with this value will be rewritten to
-	start, instead, with <base>. In cases where some site serves a
-	large number of repositories, and serves them with multiple
-	access methods, and some users need to use different access
-	methods, this feature allows people to specify any of the
-	equivalent URLs and have Git automatically rewrite the URL to
-	the best alternative for the particular user, even for a
-	never-before-seen repository on the site.  When more than one
-	insteadOf strings match a given URL, the longest match is used.
-+
-Note that any protocol restrictions will be applied to the rewritten
-URL. If the rewrite changes the URL to use a custom protocol or remote
-helper, you may need to adjust the `protocol.*.allow` config to permit
-the request.  In particular, protocols you expect to use for submodules
-must be set to `always` rather than the default of `user`. See the
-description of `protocol.allow` above.
-
-url.<base>.pushInsteadOf::
-	Any URL that starts with this value will not be pushed to;
-	instead, it will be rewritten to start with <base>, and the
-	resulting URL will be pushed to. In cases where some site serves
-	a large number of repositories, and serves them with multiple
-	access methods, some of which do not allow push, this feature
-	allows people to specify a pull-only URL and have Git
-	automatically use an appropriate URL to push, even for a
-	never-before-seen repository on the site.  When more than one
-	pushInsteadOf strings match a given URL, the longest match is
-	used.  If a remote has an explicit pushurl, Git will ignore this
-	setting for that remote.
+include::config/url.txt[]
 
 user.email::
 	Your email address to be recorded in any newly created commits.
diff --git a/Documentation/config/url.txt b/Documentation/config/url.txt
new file mode 100644
index 0000000000..e5566c371d
--- /dev/null
+++ b/Documentation/config/url.txt
@@ -0,0 +1,30 @@
+url.<base>.insteadOf::
+	Any URL that starts with this value will be rewritten to
+	start, instead, with <base>. In cases where some site serves a
+	large number of repositories, and serves them with multiple
+	access methods, and some users need to use different access
+	methods, this feature allows people to specify any of the
+	equivalent URLs and have Git automatically rewrite the URL to
+	the best alternative for the particular user, even for a
+	never-before-seen repository on the site.  When more than one
+	insteadOf strings match a given URL, the longest match is used.
++
+Note that any protocol restrictions will be applied to the rewritten
+URL. If the rewrite changes the URL to use a custom protocol or remote
+helper, you may need to adjust the `protocol.*.allow` config to permit
+the request.  In particular, protocols you expect to use for submodules
+must be set to `always` rather than the default of `user`. See the
+description of `protocol.allow` above.
+
+url.<base>.pushInsteadOf::
+	Any URL that starts with this value will not be pushed to;
+	instead, it will be rewritten to start with <base>, and the
+	resulting URL will be pushed to. In cases where some site serves
+	a large number of repositories, and serves them with multiple
+	access methods, some of which do not allow push, this feature
+	allows people to specify a pull-only URL and have Git
+	automatically use an appropriate URL to push, even for a
+	never-before-seen repository on the site.  When more than one
+	pushInsteadOf strings match a given URL, the longest match is
+	used.  If a remote has an explicit pushurl, Git will ignore this
+	setting for that remote.
-- 
2.19.1.647.g708186aaf9

