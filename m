Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDDBA1F453
	for <e@80x24.org>; Sat, 20 Oct 2018 12:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbeJTUt6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 16:49:58 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43186 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbeJTUt6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 16:49:58 -0400
Received: by mail-lf1-f67.google.com with SMTP id p34-v6so27137706lfg.10
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 05:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vw81aJrr5FTRevLsv0B4Zzh/Y1XAWp2c/IQOPQiI5CU=;
        b=uDwLm2h6m+6gLqDvaNeIc4ny20OFktlWVSP/adX/3ntfcxJmGXe6v4DHd2fOcTRl+Z
         zGkuqjyiRnaAvZl0zewz6KIIlGZg+5508/tR1N3Fv7E9iEceS7cDdbMpFYXibkfJyEyk
         StLfpLNdEHG+LgdtjSyBXzOCyQbIkOBEIYKgtl7ssHusaRawBa3ZX/a4svEXXYCjOXbp
         lhU8mlI/fJL/oO2BSUWQ5bIlslqGwOUyYczfVRBAlvj6lMTd9pqU4hDWZI77WL0NAiDm
         5n5K06hsN2zzRSTIN2SSFhxDGldtvsPQ9xOX86WeMUBuHOzIBs3U/bLCbRaqsCfY/Wwq
         lYlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vw81aJrr5FTRevLsv0B4Zzh/Y1XAWp2c/IQOPQiI5CU=;
        b=hWHvZQgVHl1wG+n98J/a4BCZOR7aPhfwHXt3K8cPGhCTrnDR/iBKGLwQub7C7vypoV
         ATrBjEin04TXcGLDVcmDIDF8JE6xqm7XH78mkq+fxCTPRgE0qVQugQTGjiPBXnvITDbL
         V+cgiD4fqCuWgjwCUZx0TaHjCAiV/Se78c8aFx1mF8IZYriw2W89sZwcVtcaMB2jvwYn
         bZ5E17wdxqwWqATijYr82yGiUc80hWyOQI8AlYooinncaM4uBRHyhtd7C0cfxFEmhRfC
         OhsalOgl4YEiuw1tt5BwDVii/VBGdQz3H8M+G52jIdVf1JmL67Co0wrsWGqylXMTPzQJ
         S1jg==
X-Gm-Message-State: ABuFfoh3osr1SvDEEOUArwutnVI0VRcLmrIUq0nbaQhur9adDpRo6a3N
        lLlzgEzUyMjPz9iT72v0b4ElFBRp
X-Google-Smtp-Source: ACcGV602Es/hubPYhBe07UG9yX311VXlZpp4lk+Pn68Yh22sMhyaOiNV1zWxMCOVAdcYAe78f3TNvg==
X-Received: by 2002:a19:14c6:: with SMTP id 67mr594601lfu.7.1540039175511;
        Sat, 20 Oct 2018 05:39:35 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o22-v6sm5759379ljc.79.2018.10.20.05.39.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 05:39:34 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 27/59] config.txt: move ssh.* to a separate file
Date:   Sat, 20 Oct 2018 14:38:16 +0200
Message-Id: <20181020123848.2785-28-pclouds@gmail.com>
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
 Documentation/config.txt     | 38 ++----------------------------------
 Documentation/ssh-config.txt | 35 +++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 36 deletions(-)
 create mode 100644 Documentation/ssh-config.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index bb49f4c894..da97097805 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -600,42 +600,6 @@ Environment variable settings always override any matches.  The URLs that are
 matched against are those given directly to Git commands.  This means any URLs
 visited as a result of a redirection do not participate in matching.
 
-ssh.variant::
-	By default, Git determines the command line arguments to use
-	based on the basename of the configured SSH command (configured
-	using the environment variable `GIT_SSH` or `GIT_SSH_COMMAND` or
-	the config setting `core.sshCommand`). If the basename is
-	unrecognized, Git will attempt to detect support of OpenSSH
-	options by first invoking the configured SSH command with the
-	`-G` (print configuration) option and will subsequently use
-	OpenSSH options (if that is successful) or no options besides
-	the host and remote command (if it fails).
-+
-The config variable `ssh.variant` can be set to override this detection.
-Valid values are `ssh` (to use OpenSSH options), `plink`, `putty`,
-`tortoiseplink`, `simple` (no options except the host and remote command).
-The default auto-detection can be explicitly requested using the value
-`auto`.  Any other value is treated as `ssh`.  This setting can also be
-overridden via the environment variable `GIT_SSH_VARIANT`.
-+
-The current command-line parameters used for each variant are as
-follows:
-+
---
-
-* `ssh` - [-p port] [-4] [-6] [-o option] [username@]host command
-
-* `simple` - [username@]host command
-
-* `plink` or `putty` - [-P port] [-4] [-6] [username@]host command
-
-* `tortoiseplink` - [-P port] [-4] [-6] -batch [username@]host command
-
---
-+
-Except for the `simple` variant, command-line parameters are likely to
-change as git gains new features.
-
 i18n.commitEncoding::
 	Character encoding the commit messages are stored in; Git itself
 	does not care per se, but this information is necessary e.g. when
@@ -1274,6 +1238,8 @@ splitIndex.sharedIndexExpire::
 	either created based on it or read from it.
 	See linkgit:git-update-index[1].
 
+include::ssh-config.txt[]
+
 status.relativePaths::
 	By default, linkgit:git-status[1] shows paths relative to the
 	current directory. Setting this variable to `false` shows paths
diff --git a/Documentation/ssh-config.txt b/Documentation/ssh-config.txt
new file mode 100644
index 0000000000..2ca4bf93e1
--- /dev/null
+++ b/Documentation/ssh-config.txt
@@ -0,0 +1,35 @@
+ssh.variant::
+	By default, Git determines the command line arguments to use
+	based on the basename of the configured SSH command (configured
+	using the environment variable `GIT_SSH` or `GIT_SSH_COMMAND` or
+	the config setting `core.sshCommand`). If the basename is
+	unrecognized, Git will attempt to detect support of OpenSSH
+	options by first invoking the configured SSH command with the
+	`-G` (print configuration) option and will subsequently use
+	OpenSSH options (if that is successful) or no options besides
+	the host and remote command (if it fails).
++
+The config variable `ssh.variant` can be set to override this detection.
+Valid values are `ssh` (to use OpenSSH options), `plink`, `putty`,
+`tortoiseplink`, `simple` (no options except the host and remote command).
+The default auto-detection can be explicitly requested using the value
+`auto`.  Any other value is treated as `ssh`.  This setting can also be
+overridden via the environment variable `GIT_SSH_VARIANT`.
++
+The current command-line parameters used for each variant are as
+follows:
++
+--
+
+* `ssh` - [-p port] [-4] [-6] [-o option] [username@]host command
+
+* `simple` - [username@]host command
+
+* `plink` or `putty` - [-P port] [-4] [-6] [username@]host command
+
+* `tortoiseplink` - [-P port] [-4] [-6] -batch [username@]host command
+
+--
++
+Except for the `simple` variant, command-line parameters are likely to
+change as git gains new features.
-- 
2.19.1.647.g708186aaf9

