Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01D7F200E0
	for <e@80x24.org>; Tue, 27 Dec 2016 23:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933045AbcL0XnW (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Dec 2016 18:43:22 -0500
Received: from mail-pf0-f176.google.com ([209.85.192.176]:35877 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754345AbcL0XnR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2016 18:43:17 -0500
Received: by mail-pf0-f176.google.com with SMTP id 189so56245536pfz.3
        for <git@vger.kernel.org>; Tue, 27 Dec 2016 15:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QvGcMT2gsbncjrch8OPKJ7hwq1N6zS8JK3rpcB+2NzM=;
        b=sc7LZyeAujKqfcd3MFSW8x7DQlJzT73W8wdmH/EK9oZCXX656U1PqCC9ASDu/YvC03
         AnKyty4V6gcdUK8fGYVvdW/0H9WyjzfV29rysI8YR1pA1gmF7k0fo+85luPLLfKUBgB2
         30M/VSEpT6Emlp4sToQeKQ5X+9/IuJF+Qxl9I5Ngy7UbgUbLxfKKZLvnZXFwI1on7rJI
         lvj4nDYtTvvW2Qi4TR4BCP16TbgSsN8Q/xHLCO2r5TXFKdfmC1qS/4023e+OZOpetfVD
         tXqlWlqZ0FYdT0etkNiALMohWmDG9h0KrnLRFkE9q7e3yticyqY+/QVuU85NSG8oD7se
         J5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QvGcMT2gsbncjrch8OPKJ7hwq1N6zS8JK3rpcB+2NzM=;
        b=Gr+aKvjCvHI/qJqP0qvnI5W4q84m4W3gwe6QHCTWA8MIrT9zfv4Qr8U9GAfuDJvnnt
         TkD0q5ViyYQng6XTfoRH1xz52ZeYw+RRUUN8YsnM+NfucyNniuhevveSsFDxWezouLcc
         m4JsxBNfrTHxRSNfUFESkwg0yPJ/x9i23L9Vgy6UlQVRZfsxgCt6eiBs4L1Y1SOHIpF9
         cv0oTZ7dd3EZ5yG0EsubUlDmTAqxN+Gh8Ak8/e5WDPyziHjPpX6PSHZp+6AnTmZl5JkK
         JAwWM820WUttStlpWA4kNXUO2YKdTK4mzg1NowUaccn4y/bZbef6dyQC9W0ip7Qq0PJx
         8J1A==
X-Gm-Message-State: AIkVDXIOBxWbLYBBjbRsx8AoUuyu3l27N6uBx269pDoEmTL9Rk5JqbM31YOi4dI6xmenHYJr
X-Received: by 10.84.140.3 with SMTP id 3mr71194559pls.61.1482882196727;
        Tue, 27 Dec 2016 15:43:16 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:1aa:810:98b9:be05])
        by smtp.gmail.com with ESMTPSA id q145sm91940747pfq.22.2016.12.27.15.43.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 27 Dec 2016 15:43:16 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/3] submodule update documentation: don't repeat ourselves
Date:   Tue, 27 Dec 2016 15:43:09 -0800
Message-Id: <20161227234310.13264-3-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.196.gee862f456e.dirty
In-Reply-To: <20161227234310.13264-1-sbeller@google.com>
References: <20161227234310.13264-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The documentation for the `git submodule update` command, repeats itself
for each update option, "This is done when <option> is given, or no
option is given and `submodule.<name>.update` is set to <string>.

Avoid these repetitive clauses by stating the command line options take
precedence over configured options.

Also add 'none' to the list of options instead of mentioning it in the
following running text and split the list into two parts, one that is
accessible via the command line and one that is only reachable via the
configuration variables.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-submodule.txt | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index f9da0d9e91..7e03ccc444 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -153,13 +153,13 @@ Update the registered submodules to match what the superproject
 expects by cloning missing submodules and updating the working tree of
 the submodules. The "updating" can be done in several ways depending
 on command line options and the value of `submodule.<name>.update`
-configuration variable. Supported update procedures are:
+configuration variable. The command line option takes precedence over
+the configuration variable. if neither is given, a checkout is performed.
+update procedures supported both from the command line as well as setting
+`submodule.<name>.update`:
 
 	checkout;; the commit recorded in the superproject will be
-	    checked out in the submodule on a detached HEAD. This is
-	    done when `--checkout` option is given, or no option is
-	    given, and `submodule.<name>.update` is unset, or if it is
-	    set to 'checkout'.
+	    checked out in the submodule on a detached HEAD.
 +
 If `--force` is specified, the submodule will be checked out (using
 `git checkout --force` if appropriate), even if the commit specified
@@ -167,23 +167,21 @@ in the index of the containing repository already matches the commit
 checked out in the submodule.
 
 	rebase;; the current branch of the submodule will be rebased
-	    onto the commit recorded in the superproject. This is done
-	    when `--rebase` option is given, or no option is given, and
-	    `submodule.<name>.update` is set to 'rebase'.
+	    onto the commit recorded in the superproject.
 
 	merge;; the commit recorded in the superproject will be merged
-	    into the current branch in the submodule. This is done
-	    when `--merge` option is given, or no option is given, and
-	    `submodule.<name>.update` is set to 'merge'.
+	    into the current branch in the submodule.
+
+The following procedures are only available via the `submodule.<name>.update`
+configuration variable:
 
 	custom command;; arbitrary shell command that takes a single
 	    argument (the sha1 of the commit recorded in the
-	    superproject) is executed. This is done when no option is
-	    given, and `submodule.<name>.update` has the form of
-	    '!command'.
+	    superproject) is executed. When `submodule.<name>.update`
+	    is set to '!command', the remainder after the exclamation mark
+	    is the custom command.
 
-When no option is given and `submodule.<name>.update` is set to 'none',
-the submodule is not updated.
+	none;; the submodule is not updated.
 
 If the submodule is not yet initialized, and you just want to use the
 setting as stored in .gitmodules, you can automatically initialize the
-- 
2.11.0.196.gee862f456e.dirty

