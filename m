Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E33D21F453
	for <e@80x24.org>; Sat, 27 Oct 2018 06:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbeJ0PEK (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:04:10 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33831 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728380AbeJ0PEK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:04:10 -0400
Received: by mail-lf1-f66.google.com with SMTP id n26-v6so2494995lfl.1
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=699IPdRCQsr7h2qK1cjmpQWr0awt9dBZgfRmCD6vJ2w=;
        b=Nj7yTIVu9TCodR7+lbe/us+4HFwPjSjyvsV4vXrqfNlKkCvyAtwUwN+rv95iDbpY8a
         FJQrBBuh5zDv1ZXJCErCnv/IEMhSriwCN0o2GvBlPyQVmfqTzuFjS69tUjHW6R4t8bHn
         Em4zN1KkXfPXcgI3f5wce8ft+x8FYvRlxc9VjL9yFBEiFB+2j6Ehs1FVDp9k1g2W3XgK
         FtSuvcGy+NrW0WbE/radqXL7p+0rPpl0JDmQpsY5r/lfuKHOKw2L7Ti5AhrOnWnEAB2s
         hpLVbslX0iriORTU8lPvdBDzpUxZO17xagC6nIQ7QAV2Lba5ffKXu+2AkGIktu4QrR9D
         0jzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=699IPdRCQsr7h2qK1cjmpQWr0awt9dBZgfRmCD6vJ2w=;
        b=qPWIGMMSKAVlaLnFqH956kvo9WNjmowSatp8I+46/D5rIh76IT/R8JqGlebeoCogL7
         CXpnUMJTCBsu7pTiVUX7xZKOdRwGBUGw+0WnOFVz8JnwcFhoSsqpl4tOJqC3U9LxerZF
         wW0ng4tkUGHjP8jrukr94UY7BZeMZkkPWXFLDyV18p3rL3J/rUsCvDqqvcHiiNiELClJ
         Y3ZccxH6CeFOKnuqRWHm1jUTxdj9C7Lnb+EGfEIL2OgkfwU5hfHip/+Wf4eyB30zCsHo
         qeuYtiiVNM1S7twbaWfl+RELj5HZ+Gr469QFeV5LdfY3cMjk9yidY0sqUzndcJNE5vpi
         1Wfw==
X-Gm-Message-State: AGRZ1gIBEICLKqBDzxPad7by54JNjrWd5l/Q9uUzw/2vUtN7dMbqf49z
        1yeXjJiWMBfsNDJdVm25RlUG884p
X-Google-Smtp-Source: AJdET5d537uI42X06P6L9ee4IbLJjdbmVVmkYIyGZvc4sR1NFcPrmYLKuVFsqfKqlkSZk71nl4QJAw==
X-Received: by 2002:a19:25c2:: with SMTP id l185-v6mr2794118lfl.122.1540621454865;
        Fri, 26 Oct 2018 23:24:14 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.24.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:24:13 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 15/78] config.txt: move commit.* to a separate file
Date:   Sat, 27 Oct 2018 08:22:48 +0200
Message-Id: <20181027062351.30446-16-pclouds@gmail.com>
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
 Documentation/config.txt        | 30 +-----------------------------
 Documentation/config/commit.txt | 29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/config/commit.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0618a7d974..bbae7e68bd 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -313,35 +313,7 @@ include::config/color.txt[]
 
 include::config/column.txt[]
 
-commit.cleanup::
-	This setting overrides the default of the `--cleanup` option in
-	`git commit`. See linkgit:git-commit[1] for details. Changing the
-	default can be useful when you always want to keep lines that begin
-	with comment character `#` in your log message, in which case you
-	would do `git config commit.cleanup whitespace` (note that you will
-	have to remove the help lines that begin with `#` in the commit log
-	template yourself, if you do this).
-
-commit.gpgSign::
-
-	A boolean to specify whether all commits should be GPG signed.
-	Use of this option when doing operations such as rebase can
-	result in a large number of commits being signed. It may be
-	convenient to use an agent to avoid typing your GPG passphrase
-	several times.
-
-commit.status::
-	A boolean to enable/disable inclusion of status information in the
-	commit message template when using an editor to prepare the commit
-	message.  Defaults to true.
-
-commit.template::
-	Specify the pathname of a file to use as the template for
-	new commit messages.
-
-commit.verbose::
-	A boolean or int to specify the level of verbose with `git commit`.
-	See linkgit:git-commit[1].
+include::config/commit.txt[]
 
 credential.helper::
 	Specify an external helper to be called when a username or
diff --git a/Documentation/config/commit.txt b/Documentation/config/commit.txt
new file mode 100644
index 0000000000..2c95573930
--- /dev/null
+++ b/Documentation/config/commit.txt
@@ -0,0 +1,29 @@
+commit.cleanup::
+	This setting overrides the default of the `--cleanup` option in
+	`git commit`. See linkgit:git-commit[1] for details. Changing the
+	default can be useful when you always want to keep lines that begin
+	with comment character `#` in your log message, in which case you
+	would do `git config commit.cleanup whitespace` (note that you will
+	have to remove the help lines that begin with `#` in the commit log
+	template yourself, if you do this).
+
+commit.gpgSign::
+
+	A boolean to specify whether all commits should be GPG signed.
+	Use of this option when doing operations such as rebase can
+	result in a large number of commits being signed. It may be
+	convenient to use an agent to avoid typing your GPG passphrase
+	several times.
+
+commit.status::
+	A boolean to enable/disable inclusion of status information in the
+	commit message template when using an editor to prepare the commit
+	message.  Defaults to true.
+
+commit.template::
+	Specify the pathname of a file to use as the template for
+	new commit messages.
+
+commit.verbose::
+	A boolean or int to specify the level of verbose with `git commit`.
+	See linkgit:git-commit[1].
-- 
2.19.1.647.g708186aaf9

