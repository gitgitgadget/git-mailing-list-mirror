Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9441A1F453
	for <e@80x24.org>; Sat, 20 Oct 2018 12:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbeJTUub (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 16:50:31 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41628 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727706AbeJTUub (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 16:50:31 -0400
Received: by mail-lj1-f195.google.com with SMTP id u21-v6so33076126lja.8
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 05:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yH94TrhZF2ayZTJ+c1L6TIwrTpWMhMUBh5nEHxR2In0=;
        b=Yph3O0tAGwMYgusEnSajwHWrj2Pvnj9vz3nUZszFMZIoyv68H9K2kXV1tpTTJKqmOw
         HD8V02F/gWo4Uc60RXZld9p1q+cqnLQtPjJKsA71hk/85fmDh/kWqjs/ul83Ogx6CCNI
         56Z9/zg55XphQ+exKv8gcVP/hTCvMn/rmQR7uRLwzJDLQG1Ttf/XOFr3oDVMG7q4+Yz2
         Qi5C9npxCN3IufcVmHo2jhTi484sA0MgrvSBVnGbV3ou84r31bmmnMFBkgqIhiYyPigk
         AXcxu/pKN9CVzC5/Q2WP7Vm4r7GjX3jzSR5kiVNSfEHmWXZn0XDcPe5Ks2ItIHd9VyA4
         WN4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yH94TrhZF2ayZTJ+c1L6TIwrTpWMhMUBh5nEHxR2In0=;
        b=RPxoLlORdQ/kOykjfEDEB+C1Bnlw2+xduxpVMg0pPtzYMCPCf0DjTRrxYje1AmoUF2
         lJ1qErvyt2dv8jHnVCSS7LD2sztMx3rJq+hsOw1g3TWwetpjFDwF0Xu5zhhOtgTZ5VYt
         jbGgo+tttFv6ew/iYUQpQiQWKCo6kHuczbYo7TxsyNOv40IrYY3urEg90BWCxSHWORSf
         kUC24apaQyQYlPUCaKOHPlhU+AgdT9XBGSeefZ9KvB1Dp5VE0kdb6Vkc1aoBu/c44+Qj
         PmjgyCD7NpNsiNgQtiBKa3AxH1wjjfN/dtz39mi7Z+AmqTe+TGBU6yOolCnvf30TyFDV
         s1CA==
X-Gm-Message-State: ABuFfojrkEfQZIo/5S8uEyux4Z1R+x8K9FimeNVwJ+PBVcQ53I7S0XwD
        YB+yRMfCF1iH6pLNQ2C0QS3Opz0e
X-Google-Smtp-Source: ACcGV615dkhYuyrqsLO+P+4DFWH3yl8Lay4MLHhwKctvQxtMyF8lpF31qidigVLeUGTtFpU6hePleQ==
X-Received: by 2002:a2e:5159:: with SMTP id b25-v6mr27339291lje.156.1540039207835;
        Sat, 20 Oct 2018 05:40:07 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o22-v6sm5759379ljc.79.2018.10.20.05.40.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 05:40:06 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 43/59] config.txt: move remote.* to a separate file
Date:   Sat, 20 Oct 2018 14:38:32 +0200
Message-Id: <20181020123848.2785-44-pclouds@gmail.com>
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
 Documentation/config.txt        | 79 +--------------------------------
 Documentation/remote-config.txt | 78 ++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+), 78 deletions(-)
 create mode 100644 Documentation/remote-config.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f57b494041..71844cf8e3 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -644,84 +644,7 @@ include::rebase-config.txt[]
 
 include::receive-config.txt[]
 
-remote.pushDefault::
-	The remote to push to by default.  Overrides
-	`branch.<name>.remote` for all branches, and is overridden by
-	`branch.<name>.pushRemote` for specific branches.
-
-remote.<name>.url::
-	The URL of a remote repository.  See linkgit:git-fetch[1] or
-	linkgit:git-push[1].
-
-remote.<name>.pushurl::
-	The push URL of a remote repository.  See linkgit:git-push[1].
-
-remote.<name>.proxy::
-	For remotes that require curl (http, https and ftp), the URL to
-	the proxy to use for that remote.  Set to the empty string to
-	disable proxying for that remote.
-
-remote.<name>.proxyAuthMethod::
-	For remotes that require curl (http, https and ftp), the method to use for
-	authenticating against the proxy in use (probably set in
-	`remote.<name>.proxy`). See `http.proxyAuthMethod`.
-
-remote.<name>.fetch::
-	The default set of "refspec" for linkgit:git-fetch[1]. See
-	linkgit:git-fetch[1].
-
-remote.<name>.push::
-	The default set of "refspec" for linkgit:git-push[1]. See
-	linkgit:git-push[1].
-
-remote.<name>.mirror::
-	If true, pushing to this remote will automatically behave
-	as if the `--mirror` option was given on the command line.
-
-remote.<name>.skipDefaultUpdate::
-	If true, this remote will be skipped by default when updating
-	using linkgit:git-fetch[1] or the `update` subcommand of
-	linkgit:git-remote[1].
-
-remote.<name>.skipFetchAll::
-	If true, this remote will be skipped by default when updating
-	using linkgit:git-fetch[1] or the `update` subcommand of
-	linkgit:git-remote[1].
-
-remote.<name>.receivepack::
-	The default program to execute on the remote side when pushing.  See
-	option --receive-pack of linkgit:git-push[1].
-
-remote.<name>.uploadpack::
-	The default program to execute on the remote side when fetching.  See
-	option --upload-pack of linkgit:git-fetch-pack[1].
-
-remote.<name>.tagOpt::
-	Setting this value to --no-tags disables automatic tag following when
-	fetching from remote <name>. Setting it to --tags will fetch every
-	tag from remote <name>, even if they are not reachable from remote
-	branch heads. Passing these flags directly to linkgit:git-fetch[1] can
-	override this setting. See options --tags and --no-tags of
-	linkgit:git-fetch[1].
-
-remote.<name>.vcs::
-	Setting this to a value <vcs> will cause Git to interact with
-	the remote with the git-remote-<vcs> helper.
-
-remote.<name>.prune::
-	When set to true, fetching from this remote by default will also
-	remove any remote-tracking references that no longer exist on the
-	remote (as if the `--prune` option was given on the command line).
-	Overrides `fetch.prune` settings, if any.
-
-remote.<name>.pruneTags::
-	When set to true, fetching from this remote by default will also
-	remove any local tags that no longer exist on the remote if pruning
-	is activated in general via `remote.<name>.prune`, `fetch.prune` or
-	`--prune`. Overrides `fetch.pruneTags` settings, if any.
-+
-See also `remote.<name>.prune` and the PRUNING section of
-linkgit:git-fetch[1].
+include::remote-config.txt[]
 
 remotes.<group>::
 	The list of remotes which are fetched by "git remote update
diff --git a/Documentation/remote-config.txt b/Documentation/remote-config.txt
new file mode 100644
index 0000000000..6c4cad83a2
--- /dev/null
+++ b/Documentation/remote-config.txt
@@ -0,0 +1,78 @@
+remote.pushDefault::
+	The remote to push to by default.  Overrides
+	`branch.<name>.remote` for all branches, and is overridden by
+	`branch.<name>.pushRemote` for specific branches.
+
+remote.<name>.url::
+	The URL of a remote repository.  See linkgit:git-fetch[1] or
+	linkgit:git-push[1].
+
+remote.<name>.pushurl::
+	The push URL of a remote repository.  See linkgit:git-push[1].
+
+remote.<name>.proxy::
+	For remotes that require curl (http, https and ftp), the URL to
+	the proxy to use for that remote.  Set to the empty string to
+	disable proxying for that remote.
+
+remote.<name>.proxyAuthMethod::
+	For remotes that require curl (http, https and ftp), the method to use for
+	authenticating against the proxy in use (probably set in
+	`remote.<name>.proxy`). See `http.proxyAuthMethod`.
+
+remote.<name>.fetch::
+	The default set of "refspec" for linkgit:git-fetch[1]. See
+	linkgit:git-fetch[1].
+
+remote.<name>.push::
+	The default set of "refspec" for linkgit:git-push[1]. See
+	linkgit:git-push[1].
+
+remote.<name>.mirror::
+	If true, pushing to this remote will automatically behave
+	as if the `--mirror` option was given on the command line.
+
+remote.<name>.skipDefaultUpdate::
+	If true, this remote will be skipped by default when updating
+	using linkgit:git-fetch[1] or the `update` subcommand of
+	linkgit:git-remote[1].
+
+remote.<name>.skipFetchAll::
+	If true, this remote will be skipped by default when updating
+	using linkgit:git-fetch[1] or the `update` subcommand of
+	linkgit:git-remote[1].
+
+remote.<name>.receivepack::
+	The default program to execute on the remote side when pushing.  See
+	option --receive-pack of linkgit:git-push[1].
+
+remote.<name>.uploadpack::
+	The default program to execute on the remote side when fetching.  See
+	option --upload-pack of linkgit:git-fetch-pack[1].
+
+remote.<name>.tagOpt::
+	Setting this value to --no-tags disables automatic tag following when
+	fetching from remote <name>. Setting it to --tags will fetch every
+	tag from remote <name>, even if they are not reachable from remote
+	branch heads. Passing these flags directly to linkgit:git-fetch[1] can
+	override this setting. See options --tags and --no-tags of
+	linkgit:git-fetch[1].
+
+remote.<name>.vcs::
+	Setting this to a value <vcs> will cause Git to interact with
+	the remote with the git-remote-<vcs> helper.
+
+remote.<name>.prune::
+	When set to true, fetching from this remote by default will also
+	remove any remote-tracking references that no longer exist on the
+	remote (as if the `--prune` option was given on the command line).
+	Overrides `fetch.prune` settings, if any.
+
+remote.<name>.pruneTags::
+	When set to true, fetching from this remote by default will also
+	remove any local tags that no longer exist on the remote if pruning
+	is activated in general via `remote.<name>.prune`, `fetch.prune` or
+	`--prune`. Overrides `fetch.pruneTags` settings, if any.
++
+See also `remote.<name>.prune` and the PRUNING section of
+linkgit:git-fetch[1].
-- 
2.19.1.647.g708186aaf9

