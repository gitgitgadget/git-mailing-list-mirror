Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9B641F461
	for <e@80x24.org>; Sat,  7 Sep 2019 14:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404263AbfIGONV (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Sep 2019 10:13:21 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44547 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388458AbfIGONV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Sep 2019 10:13:21 -0400
Received: by mail-lj1-f196.google.com with SMTP id u14so8573599ljj.11
        for <git@vger.kernel.org>; Sat, 07 Sep 2019 07:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d6grHpI70/UKtx1Rboa/FrQpwxna6BwVuJvqTaEr83U=;
        b=Q+aP0AIFrY/xzPO5m9M5xGkY73s3f+ACEeNFlAPEu6WmM8xeX3NJl4tZsfuKQGvDhC
         2hB525wf+JOQoFUJ4/kCtH1nJ8BjT9eNL3gFK/OXmcG+Xmlpi8ZQRE/4lkW0O/7nxVpc
         KernzExaZ26vEQwbNJQSB+WFDkHvRg3AJe4nn5+A+hTn6//UrQ6wlr31HKczn4MtXO6c
         0aDLN6csGSh5A25us92EBsOcy0pM3WfgqKIrivK2s1XvA4XjIOvzbgno0fOW8oCcvurx
         yKIG7Be3YeTzszAo/6HXtfmXjM9lzlxHWUiJBTxJxAADTVviCC1KUBrNQJqmznz96tPM
         viUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d6grHpI70/UKtx1Rboa/FrQpwxna6BwVuJvqTaEr83U=;
        b=EOUBbNdcFKBL3/kxBLnKm4BZK6EYVQT18ZDolJTwKx7wqWqTAPtfpcfHmINxPwx46n
         kCgOuDcFExK10xJvUj/rffQ6jLoREagBDOZ9MkjeaKziW4qTwUf6Ui4wfF/1xdS4RZkP
         5uRUU+5SEhf0ofOpgBc/2AySOeqoAUBXti0kCt/43BWTcF0vnWb5SQOYXgegrDX5Qlz3
         sHBmNAqSC4WItMV7FhgV4ofV7GvQyb1DiH5AMhon6FSNzbf8Y6yHcTKMq/LB311QmEna
         2Igp/xW6NwT/GLtXO3z/TQp3bVeYM4L9pG3Txei7VW2Po+ajDtR9LiB6/dDr17MgR2/e
         vbZQ==
X-Gm-Message-State: APjAAAVnkIoYwM2mqmmcTiBdDNbNs6nBdPGKbbP9QTrq3y9aUTirIOUn
        ncTFulIu+0vxjAMUESyDjSo190+D
X-Google-Smtp-Source: APXvYqyDzWuZxsaCe2JBQ7P41V+B0s6UiwU+CCbgFqn0Y8oMig+lsUtijaa9xM7MiPGpZL/6AcmBHg==
X-Received: by 2002:a2e:9549:: with SMTP id t9mr5299259ljh.189.1567865598542;
        Sat, 07 Sep 2019 07:13:18 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id u10sm1741316lfk.34.2019.09.07.07.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2019 07:13:17 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH 3/7] Documentation: wrap config listings in "----"
Date:   Sat,  7 Sep 2019 16:12:49 +0200
Message-Id: <2a8cc66dff38f3e5bf9220a06440382ae2641fea.1567707999.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1567707999.git.martin.agren@gmail.com>
References: <cover.1567707999.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The indented lines in these example config-file listings are indented
differently by AsciiDoc and Asciidoctor.

Fix this by marking the example config-files as code listings by
wrapping them in "----". Because this gives us some extra indentation,
we can remove the one that we have been carrying explicitly. That is,
drop the first tab of indentation on each line.

With AsciiDoc, this results in identical rendering before and after this
commit. Asciidoctor now renders this the same as AsciiDoc does.

git-config.txt pretty consistently uses twelve dashes rather than the
minimum four to spell "----". Let's stick to the file-local convention
there.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/config.txt         | 84 ++++++++++++++++----------------
 Documentation/git-config.txt     | 56 +++++++++++----------
 Documentation/git-send-email.txt | 12 +++--
 Documentation/gitmodules.txt     | 15 +++---
 4 files changed, 87 insertions(+), 80 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 7e2a6f61f5..f7cd0ae584 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -164,47 +164,49 @@ to either specify only the realpath version, or both versions.
 Example
 ~~~~~~~
 
-	# Core variables
-	[core]
-		; Don't trust file modes
-		filemode = false
-
-	# Our diff algorithm
-	[diff]
-		external = /usr/local/bin/diff-wrapper
-		renames = true
-
-	[branch "devel"]
-		remote = origin
-		merge = refs/heads/devel
-
-	# Proxy settings
-	[core]
-		gitProxy="ssh" for "kernel.org"
-		gitProxy=default-proxy ; for the rest
-
-	[include]
-		path = /path/to/foo.inc ; include by absolute path
-		path = foo.inc ; find "foo.inc" relative to the current file
-		path = ~/foo.inc ; find "foo.inc" in your `$HOME` directory
-
-	; include if $GIT_DIR is /path/to/foo/.git
-	[includeIf "gitdir:/path/to/foo/.git"]
-		path = /path/to/foo.inc
-
-	; include for all repositories inside /path/to/group
-	[includeIf "gitdir:/path/to/group/"]
-		path = /path/to/foo.inc
-
-	; include for all repositories inside $HOME/to/group
-	[includeIf "gitdir:~/to/group/"]
-		path = /path/to/foo.inc
-
-	; relative paths are always relative to the including
-	; file (if the condition is true); their location is not
-	; affected by the condition
-	[includeIf "gitdir:/path/to/group/"]
-		path = foo.inc
+----
+# Core variables
+[core]
+	; Don't trust file modes
+	filemode = false
+
+# Our diff algorithm
+[diff]
+	external = /usr/local/bin/diff-wrapper
+	renames = true
+
+[branch "devel"]
+	remote = origin
+	merge = refs/heads/devel
+
+# Proxy settings
+[core]
+	gitProxy="ssh" for "kernel.org"
+	gitProxy=default-proxy ; for the rest
+
+[include]
+	path = /path/to/foo.inc ; include by absolute path
+	path = foo.inc ; find "foo.inc" relative to the current file
+	path = ~/foo.inc ; find "foo.inc" in your `$HOME` directory
+
+; include if $GIT_DIR is /path/to/foo/.git
+[includeIf "gitdir:/path/to/foo/.git"]
+	path = /path/to/foo.inc
+
+; include for all repositories inside /path/to/group
+[includeIf "gitdir:/path/to/group/"]
+	path = /path/to/foo.inc
+
+; include for all repositories inside $HOME/to/group
+[includeIf "gitdir:~/to/group/"]
+	path = /path/to/foo.inc
+
+; relative paths are always relative to the including
+; file (if the condition is true); their location is not
+; affected by the condition
+[includeIf "gitdir:/path/to/group/"]
+	path = foo.inc
+----
 
 Values
 ~~~~~~
diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index ff9310f958..899e92a1c9 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -339,33 +339,35 @@ EXAMPLES
 
 Given a .git/config like this:
 
-	#
-	# This is the config file, and
-	# a '#' or ';' character indicates
-	# a comment
-	#
-
-	; core variables
-	[core]
-		; Don't trust file modes
-		filemode = false
-
-	; Our diff algorithm
-	[diff]
-		external = /usr/local/bin/diff-wrapper
-		renames = true
-
-	; Proxy settings
-	[core]
-		gitproxy=proxy-command for kernel.org
-		gitproxy=default-proxy ; for all the rest
-
-	; HTTP
-	[http]
-		sslVerify
-	[http "https://weak.example.com"]
-		sslVerify = false
-		cookieFile = /tmp/cookie.txt
+------------
+#
+# This is the config file, and
+# a '#' or ';' character indicates
+# a comment
+#
+
+; core variables
+[core]
+	; Don't trust file modes
+	filemode = false
+
+; Our diff algorithm
+[diff]
+	external = /usr/local/bin/diff-wrapper
+	renames = true
+
+; Proxy settings
+[core]
+	gitproxy=proxy-command for kernel.org
+	gitproxy=default-proxy ; for all the rest
+
+; HTTP
+[http]
+	sslVerify
+[http "https://weak.example.com"]
+	sslVerify = false
+	cookieFile = /tmp/cookie.txt
+------------
 
 you can set the filemode to true with
 
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 504ae7fe76..b2909a3dc5 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -478,11 +478,13 @@ Use gmail as the smtp server
 To use 'git send-email' to send your patches through the GMail SMTP server,
 edit ~/.gitconfig to specify your account settings:
 
-	[sendemail]
-		smtpEncryption = tls
-		smtpServer = smtp.gmail.com
-		smtpUser = yourname@gmail.com
-		smtpServerPort = 587
+----
+[sendemail]
+	smtpEncryption = tls
+	smtpServer = smtp.gmail.com
+	smtpUser = yourname@gmail.com
+	smtpServerPort = 587
+----
 
 If you have multifactor authentication setup on your gmail account, you will
 need to generate an app-specific password for use with 'git send-email'. Visit
diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index a66e95b70c..08c7b8a722 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -105,14 +105,15 @@ EXAMPLES
 
 Consider the following .gitmodules file:
 
-	[submodule "libfoo"]
-		path = include/foo
-		url = git://foo.com/git/lib.git
-
-	[submodule "libbar"]
-		path = include/bar
-		url = git://bar.com/git/lib.git
+----
+[submodule "libfoo"]
+	path = include/foo
+	url = git://foo.com/git/lib.git
 
+[submodule "libbar"]
+	path = include/bar
+	url = git://bar.com/git/lib.git
+----
 
 This defines two submodules, `libfoo` and `libbar`. These are expected to
 be checked out in the paths `include/foo` and `include/bar`, and for both
-- 
2.23.0

