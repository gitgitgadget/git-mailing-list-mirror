Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 704441F453
	for <e@80x24.org>; Sat, 20 Oct 2018 12:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbeJTUtf (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 16:49:35 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33710 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727512AbeJTUtd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 16:49:33 -0400
Received: by mail-lf1-f66.google.com with SMTP id o21-v6so27164496lfe.0
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 05:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RkmNsw8bBjBhQ3blW5PQot4XFWLRel82tuhZwJvw2Yw=;
        b=oBwhBo6D8eo3qozLo1gVNBa06zPmJOhmDQE83dGBmQHWbYPUBckwxOtKpgJEfhZ5Qe
         oubU/HpPRv3uS6EQ4Lw11hZ2t7OOkC9Cdr2iGxXH7tTvoQxPHBhsLVfGxiOutGlGEYFZ
         yOnTfHub4IbAdKfSDbda94WHgoYb2kT0o5hHnTC9wmC245NeVI2anfzjckjE95q/9bup
         irBMoT2aKbLgLBTVJuPB0/zIH1++fs5O5hVQkitE1IVYNMQyQ47/J56ayreeV1XJhNYk
         bVLPGcAmj79xT4ArVlY6EAXlxqhidZ3N3OWkAD4MJyq2GVB2/5MkSFLGrZ9tlwM6d+kA
         wvpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RkmNsw8bBjBhQ3blW5PQot4XFWLRel82tuhZwJvw2Yw=;
        b=hdo1IVhyN98rvCXC4O0ctwWTbJ8v6cvcM+Y6/+VmvD0zlQ0nTzrn2yFJgeE+NhbFlI
         EZ//7aJu3AUecituv2iYX2PTZ/LgVfFOMFhbFnxDgS6Gwb6FzcNHLO3rdPNZeS9JfTwc
         scjH9xdQqdynoxqkypgMWi7wLQAGn5NiUGh7g3bCUKEv0tk0VHFKvF3MvS/ZKm3PKIXU
         0JG2wqYHWAYXhr0nDe9eyP+zBh5tB78QmUw2zDyaS3+jDcHXHJWVEw1504naMDccCPWq
         d9+dyLrgLbopHmG+tLtSe0Cg3JRU7gXYcixR5jkhSGX+J4lprCETRkUnD7fd2DmZwSQQ
         l4wQ==
X-Gm-Message-State: ABuFfoitqsayyritgAlfv4px2Fm7+VsORNv6kDbSAiGlqI6viDWBTe14
        iu8l//cC6rD+BHXhArhjbsNcRgEO
X-Google-Smtp-Source: ACcGV60bVwo1/EgIwG41PmOrBy3OGdNQDdk1axthT6D/qXj6aemHlHpQ7aR0aQkDzFvCH0r7Pa/Fhw==
X-Received: by 2002:a19:db84:: with SMTP id t4-v6mr5237651lfi.74.1540039151842;
        Sat, 20 Oct 2018 05:39:11 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o22-v6sm5759379ljc.79.2018.10.20.05.39.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 05:39:11 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 14/59] config.txt: move commit.* to a separate file
Date:   Sat, 20 Oct 2018 14:38:03 +0200
Message-Id: <20181020123848.2785-15-pclouds@gmail.com>
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
 Documentation/commit-config.txt | 29 +++++++++++++++++++++++++++++
 Documentation/config.txt        | 30 +-----------------------------
 2 files changed, 30 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/commit-config.txt

diff --git a/Documentation/commit-config.txt b/Documentation/commit-config.txt
new file mode 100644
index 0000000000..2c95573930
--- /dev/null
+++ b/Documentation/commit-config.txt
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
diff --git a/Documentation/config.txt b/Documentation/config.txt
index 48ce01f596..59cae6a895 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -313,35 +313,7 @@ include::color-config.txt[]
 
 include::column-config.txt[]
 
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
+include::commit-config.txt[]
 
 credential.helper::
 	Specify an external helper to be called when a username or
-- 
2.19.1.647.g708186aaf9

