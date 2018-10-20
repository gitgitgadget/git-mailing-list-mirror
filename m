Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8265E1F453
	for <e@80x24.org>; Sat, 20 Oct 2018 12:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbeJTUuq (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 16:50:46 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39540 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727764AbeJTUuq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 16:50:46 -0400
Received: by mail-lf1-f65.google.com with SMTP id p11-v6so718077lfc.6
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 05:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/2kwsoE7lbqQoEeboXqs5RcKdfuwmGuTPxPM6crrt/I=;
        b=j8J3Yfjh28UP0OJdtEave3XHsr9wtVnjTwedkrBGmVI8hz0O/p2oll/3uqsA7BF66/
         tZWpTRFkFPe070b4wd4Xoph7lUVUaxmDu5vdwNhAc0/0MgcdUX4QCN/SyzEZWy62Uymh
         mGxGNZmPVWRRR9h7w5D3CFJjPksLAnU0I5gtfAoy/3NFgSqwzlz5LQlhxt9wyFcZR5iD
         ZnYOclyIVhQQi/NtRNkR2Q5e87MfywBr2XKPaCwVraJzBb88ycoYO75RbBj+ny2xM8LN
         yb3hzpi0Xo5LOQv9Q7e9XpImnxaXFH9QtMDdd7hSRAyqUuKYOWCNqUOcRG4YUBusNaUB
         EdTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/2kwsoE7lbqQoEeboXqs5RcKdfuwmGuTPxPM6crrt/I=;
        b=BUM0HDNC3F5fa/p6rR48bfqfovKuDVre8Z5yOT2/vrDEre6PI0bXNBJyobML2DRTiW
         vIX7iNUzab7M63i0s35GCHqwIk1Qu8/lC6IWonI0DquJlRV9pmF/aMfaI46b7L8aTe40
         dFjpJRjH0yidZU2lAiiXTosR/iqg1F01kdWRW9UcoH/ibVEp/HsIGLU4m50OdWycWi/z
         HmCcTY9hIz1lK3cJvj/4P71tLIAjw6A9BJn9+UMuqQl4fi9SH2RYTZbha13C6IMznD11
         c5Z8xnrKjOSvOjsUc0642O5deFWVBqYQcHKlj08NZ7iG91ttdKYEpH0khxtPV1/RhhAC
         U2jQ==
X-Gm-Message-State: ABuFfoiRfrKXbZ4cmaGwevtuiSXw7sK9ZKH5C8PmRFN6Yexoe2S6W06V
        tnNe6Dny3dq6RkGrUNVRkE2mZQMt
X-Google-Smtp-Source: ACcGV63zTdEdMSJHBtzb5EUAqTFLJu9LJxuhFa2gzZ7l9lxuaCxRXj9KZt/ykCliqzVu3QeEzdOIow==
X-Received: by 2002:a19:fc09:: with SMTP id a9mr3541513lfi.21.1540039223425;
        Sat, 20 Oct 2018 05:40:23 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o22-v6sm5759379ljc.79.2018.10.20.05.40.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 05:40:22 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 55/59] config.txt: move url.* to a separate file
Date:   Sat, 20 Oct 2018 14:38:44 +0200
Message-Id: <20181020123848.2785-56-pclouds@gmail.com>
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
 Documentation/config.txt     | 31 +------------------------------
 Documentation/url-config.txt | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 30 deletions(-)
 create mode 100644 Documentation/url-config.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f2c3c12ded..9f38178220 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -676,36 +676,7 @@ include::uploadarchive-config.txt[]
 
 include::uploadpack-config.txt[]
 
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
+include::url-config.txt[]
 
 user.email::
 	Your email address to be recorded in any newly created commits.
diff --git a/Documentation/url-config.txt b/Documentation/url-config.txt
new file mode 100644
index 0000000000..e5566c371d
--- /dev/null
+++ b/Documentation/url-config.txt
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

