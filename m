Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A77F1F954
	for <e@80x24.org>; Wed, 22 Aug 2018 16:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbeHVTbv (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 15:31:51 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34150 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbeHVTbu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 15:31:50 -0400
Received: by mail-lj1-f196.google.com with SMTP id f8-v6so1863590ljk.1
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 09:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8/tJx2wYKSaFH7x+0WV5AZB+tP+XudBtpVj2MYf2aQY=;
        b=hWEfwH+60qFo+ZXtEYaoMl9AaPfCpWvELJtif01Le8Q9JEjCo5K6ofNcbijQu/D8/w
         mOoOHjqO0OFRXt5Gntx7WriigCDIov4dqVFYPwRajLfNtCZj01xPgr2O+NNzs3ssutvS
         dqCxO0GJqZHhppc/eTKUgXIG4R5OUo9lFVLDGNmeyb58WZHBekWyIbbwu3r6ui7yRA5c
         Xd5AL4ZTXjlJerUlQsIEu8f5wwT1SMOz6/uHH/xUW3tbNtDZmUkxqv1gkOArra0yy4v5
         zFY9bG8rvbs6sN1lIhSlqO+RrhlGEbWhYaI6tTIoc2VABHBdSFLXjfLIaWdScmchnwps
         0KyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8/tJx2wYKSaFH7x+0WV5AZB+tP+XudBtpVj2MYf2aQY=;
        b=fQ0oompQx5Y/aYQEymprGDLvS8Pl0teoeXsijJM+H/KtRX64GAH8YGS8lcy7z6F9ut
         TftEIzGcwYUjxLa7OfShPwys/fLFqkcdpIfesjYsyMApp2hqkY7tAfhL676Jj6l8/z8D
         zWV/8cyU1Z95OVOz2Gpjsc3YhDzdna39TzZ6eOoBhDAX93lOeRN6j5brnsD/KvNO7SMp
         KZgmM1P+wq995/HnqDn1QBVeiAiaxS1aTMxEoBmw5+T9qqW93fYYEsO7iKk4qOfOJNYU
         TS1hArqaws5/Nm/E3YVViVsjBKQhJPbOOthPfXQnYOCqtjDHtUc5chkwa8D1oIW85zHa
         n6pg==
X-Gm-Message-State: APzg51DT1e+wXa5V7niOQQPdwqfEL4BvlL6X8gD/3YK8zBFPXul+CE4w
        CUG2gVWDOWwydxobmYscqZ3NAu/8
X-Google-Smtp-Source: ANB0VdYApSjY92evgtQDQtIS56Q1OkybWW95zkRlaZM9XFFP01WhZ3xZQYXrBBJiKasgdvodE0WZ6Q==
X-Received: by 2002:a2e:3c1a:: with SMTP id j26-v6mr5093414lja.149.1534953978889;
        Wed, 22 Aug 2018 09:06:18 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id u86-v6sm375213lfi.90.2018.08.22.09.06.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 09:06:18 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 09/11] config.txt: move sendemail part out to a separate file
Date:   Wed, 22 Aug 2018 18:06:03 +0200
Message-Id: <20180822160605.21864-10-pclouds@gmail.com>
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
 Documentation/config.txt           | 64 +-----------------------------
 Documentation/sendemail-config.txt | 63 +++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+), 63 deletions(-)
 create mode 100644 Documentation/sendemail-config.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ed809dd245..414e28244e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2677,69 +2677,7 @@ rerere.enabled::
 	`$GIT_DIR`, e.g. if "rerere" was previously used in the
 	repository.
 
-sendemail.identity::
-	A configuration identity. When given, causes values in the
-	'sendemail.<identity>' subsection to take precedence over
-	values in the 'sendemail' section. The default identity is
-	the value of `sendemail.identity`.
-
-sendemail.smtpEncryption::
-	See linkgit:git-send-email[1] for description.  Note that this
-	setting is not subject to the 'identity' mechanism.
-
-sendemail.smtpssl (deprecated)::
-	Deprecated alias for 'sendemail.smtpEncryption = ssl'.
-
-sendemail.smtpsslcertpath::
-	Path to ca-certificates (either a directory or a single file).
-	Set it to an empty string to disable certificate verification.
-
-sendemail.<identity>.*::
-	Identity-specific versions of the 'sendemail.*' parameters
-	found below, taking precedence over those when this
-	identity is selected, through either the command-line or
-	`sendemail.identity`.
-
-sendemail.aliasesFile::
-sendemail.aliasFileType::
-sendemail.annotate::
-sendemail.bcc::
-sendemail.cc::
-sendemail.ccCmd::
-sendemail.chainReplyTo::
-sendemail.confirm::
-sendemail.envelopeSender::
-sendemail.from::
-sendemail.multiEdit::
-sendemail.signedoffbycc::
-sendemail.smtpPass::
-sendemail.suppresscc::
-sendemail.suppressFrom::
-sendemail.to::
-sendemail.tocmd::
-sendemail.smtpDomain::
-sendemail.smtpServer::
-sendemail.smtpServerPort::
-sendemail.smtpServerOption::
-sendemail.smtpUser::
-sendemail.thread::
-sendemail.transferEncoding::
-sendemail.validate::
-sendemail.xmailer::
-	See linkgit:git-send-email[1] for description.
-
-sendemail.signedoffcc (deprecated)::
-	Deprecated alias for `sendemail.signedoffbycc`.
-
-sendemail.smtpBatchSize::
-	Number of messages to be sent per connection, after that a relogin
-	will happen.  If the value is 0 or undefined, send all messages in
-	one connection.
-	See also the `--batch-size` option of linkgit:git-send-email[1].
-
-sendemail.smtpReloginDelay::
-	Seconds wait before reconnecting to smtp server.
-	See also the `--relogin-delay` option of linkgit:git-send-email[1].
+include::sendemail-config.txt[]
 
 showBranch.default::
 	The default set of branches for linkgit:git-show-branch[1].
diff --git a/Documentation/sendemail-config.txt b/Documentation/sendemail-config.txt
new file mode 100644
index 0000000000..0006faf800
--- /dev/null
+++ b/Documentation/sendemail-config.txt
@@ -0,0 +1,63 @@
+sendemail.identity::
+	A configuration identity. When given, causes values in the
+	'sendemail.<identity>' subsection to take precedence over
+	values in the 'sendemail' section. The default identity is
+	the value of `sendemail.identity`.
+
+sendemail.smtpEncryption::
+	See linkgit:git-send-email[1] for description.  Note that this
+	setting is not subject to the 'identity' mechanism.
+
+sendemail.smtpssl (deprecated)::
+	Deprecated alias for 'sendemail.smtpEncryption = ssl'.
+
+sendemail.smtpsslcertpath::
+	Path to ca-certificates (either a directory or a single file).
+	Set it to an empty string to disable certificate verification.
+
+sendemail.<identity>.*::
+	Identity-specific versions of the 'sendemail.*' parameters
+	found below, taking precedence over those when this
+	identity is selected, through either the command-line or
+	`sendemail.identity`.
+
+sendemail.aliasesFile::
+sendemail.aliasFileType::
+sendemail.annotate::
+sendemail.bcc::
+sendemail.cc::
+sendemail.ccCmd::
+sendemail.chainReplyTo::
+sendemail.confirm::
+sendemail.envelopeSender::
+sendemail.from::
+sendemail.multiEdit::
+sendemail.signedoffbycc::
+sendemail.smtpPass::
+sendemail.suppresscc::
+sendemail.suppressFrom::
+sendemail.to::
+sendemail.tocmd::
+sendemail.smtpDomain::
+sendemail.smtpServer::
+sendemail.smtpServerPort::
+sendemail.smtpServerOption::
+sendemail.smtpUser::
+sendemail.thread::
+sendemail.transferEncoding::
+sendemail.validate::
+sendemail.xmailer::
+	See linkgit:git-send-email[1] for description.
+
+sendemail.signedoffcc (deprecated)::
+	Deprecated alias for `sendemail.signedoffbycc`.
+
+sendemail.smtpBatchSize::
+	Number of messages to be sent per connection, after that a relogin
+	will happen.  If the value is 0 or undefined, send all messages in
+	one connection.
+	See also the `--batch-size` option of linkgit:git-send-email[1].
+
+sendemail.smtpReloginDelay::
+	Seconds wait before reconnecting to smtp server.
+	See also the `--relogin-delay` option of linkgit:git-send-email[1].
-- 
2.19.0.rc0.335.ga73d156e9c

