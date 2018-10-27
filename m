Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C59741F453
	for <e@80x24.org>; Sat, 27 Oct 2018 06:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbeJ0PEc (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:04:32 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43709 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728434AbeJ0PEb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:04:31 -0400
Received: by mail-lj1-f196.google.com with SMTP id g26-v6so1844117lja.10
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C3zCsQEqJ2LLX9ca3MckC6QpjHUpIMwKFEVf9YrMHcs=;
        b=joJ8E6uFVfw8h9Bw3aZZeY8l9I7WWEp7Y1aVflcbyVkVwOvOguJaBS+/OyxqJLqPC8
         7w3mRV+k/fZF6Peq+RHUSvysb85qyAvP05ya0rZ1JNaJv3I7ydRp4xU3rVEZAXutW0dV
         CPdDr2fuvYpRVMs3YiSvnGv47v3ha5M5KLgUyIq2PJu12QliD/pz18GhzSFgO1rJB4hb
         iQgLd16zVo7H2aHAMyZGJUK4EblK8CQ2OBTmfpSBP3/PapmUeiRq49dasQYiqUUBlw9I
         xAR7mZMb6CbQvrwFos3TreXIPsUO/VJCvUwXJCWYHo0jk5atj0olDl0X2dS+kqtWsuLO
         8SDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C3zCsQEqJ2LLX9ca3MckC6QpjHUpIMwKFEVf9YrMHcs=;
        b=svCk1UI9N9XOCQbg6s0X/PXIKxapa0HkfDmY8/3LmQMaIKjJwrwdKXyzls8wgWd2Pr
         66mCyF5iMqy5ZC+iQfsHaIf6lOXO7z1fqVUddPcjKoE9kfqNWFeqhMtTx+VHjdyLW+YM
         BvsUd6TvuXjIb6wiLmQZSAy5tZ5RE1fM/iWHGwbWKRcbdi8D815rc2UK+Hxc0sGCVRUD
         +ooz51G1E2OWwPheqR/y2OZooyByFZXc0kTBhpTvpK/Mjx629gII73CSxRNX3BrK0dV4
         EqNSRgvSwZVpr40RnBFZb+f2P1K44Sjp8U34giOiPNPMXWgsb4Fjj1R6oPg0OzybXmDH
         Nb6A==
X-Gm-Message-State: AGRZ1gLTemJOArI1tjA3C7RS5D48V7NWTiQjdyu78nKWXMh9c2V5t5oA
        HTFYukgktBjNHz3v+1hv9yBQavSt
X-Google-Smtp-Source: AJdET5eVweDZ0/J5FhnhPYVnn3CCrIr+GwlFd0vW0Mnm9cbkd/15eVIFASla08Y3slBI/Rwl4QIPwA==
X-Received: by 2002:a2e:3e0b:: with SMTP id l11-v6mr4586403lja.16.1540621475545;
        Fri, 26 Oct 2018 23:24:35 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.24.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:24:34 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 34/78] config.txt: move ssh.* to a separate file
Date:   Sat, 27 Oct 2018 08:23:07 +0200
Message-Id: <20181027062351.30446-35-pclouds@gmail.com>
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
 Documentation/config.txt     | 38 ++----------------------------------
 Documentation/config/ssh.txt | 35 +++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 36 deletions(-)
 create mode 100644 Documentation/config/ssh.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ba3b775fb0..60c2204fb4 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -621,42 +621,6 @@ Environment variable settings always override any matches.  The URLs that are
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
@@ -1298,6 +1262,8 @@ splitIndex.sharedIndexExpire::
 	either created based on it or read from it.
 	See linkgit:git-update-index[1].
 
+include::config/ssh.txt[]
+
 status.relativePaths::
 	By default, linkgit:git-status[1] shows paths relative to the
 	current directory. Setting this variable to `false` shows paths
diff --git a/Documentation/config/ssh.txt b/Documentation/config/ssh.txt
new file mode 100644
index 0000000000..2ca4bf93e1
--- /dev/null
+++ b/Documentation/config/ssh.txt
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

