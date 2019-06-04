Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B1C61F462
	for <e@80x24.org>; Tue,  4 Jun 2019 23:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbfFDXVp (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jun 2019 19:21:45 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:55648 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfFDXVp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jun 2019 19:21:45 -0400
Received: by mail-it1-f193.google.com with SMTP id i21so741758ita.5
        for <git@vger.kernel.org>; Tue, 04 Jun 2019 16:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F/ppk5ER3rPPbpIRAXn2kvOYUYf8/ZKD8tcT4IZRMtw=;
        b=ad99ns+SaIgXbBp2CNvE2ALljTRLKOU2SaeN0WFvE6VHwGBU9sa6NkRKNt4xzSHk98
         /HbyMzUc+dJO0dUleq9XokGg+TIIyhzzTL0PWkbKaxzaaMKzC94jdt0om/JFjvy4J6Yo
         /Jt2fAudbbaYFrn8VZlOVeSGkpSW58KkzG541wO5EADsft+Gx9KFdqIRTPUqOJUDvq9h
         67jesJeM5i96WkdLIVaA4p4WSDNyqbbtbEtDTKI5OacpR6YvrFuAjrvmuljXhlC5HIr+
         EsucfLeuhEVJZRAuQJ6QLCB3aqpV9pFo6izkUCck7HEt3aVGX6MZTZYfLdMgyWiRSxEP
         cYLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F/ppk5ER3rPPbpIRAXn2kvOYUYf8/ZKD8tcT4IZRMtw=;
        b=FkglWR0mExgA1NrwDZHPoX9vhk8OQ+L+1d9mmY7ZpYHJfKp3T7+gpTXIuq/mQFfhbf
         ACWQ0hytIVXQSAiEdtpMHn7Ajvj/DmmNWvv50lNUiS6q2dQUOZ0/ePQGL8Eh8MJOK+PI
         6P/WWErNNXwRzKTyMj5SFSfr3g7uJwOtP8IQYNUOwl1wqh4DOrkmMR3S+x3TKICuFV/f
         Wq7pp6T1kZkFbVtUej5ksS17gz55d8HY8LMS9ImqUsdcqrNCSCxPcl1twRZ81+uDLkxO
         IMt00AZ4GTrxvJeNLVsLYwmREJVDcLHTC3QskGptvVy3c0NdZfyuk4L+QAxIyYo+LJyA
         4obA==
X-Gm-Message-State: APjAAAXIntzf8jmEK8MoJE9/zlNv786giBHJtEMnSDwTWdrNo3SBRpP9
        2QTEZXKQOxoHgitSy9oSfIw=
X-Google-Smtp-Source: APXvYqwJo4h4CFCWFUxiifXHi+Fw2B+bAKDga3Hnx8PEjrjyuJg0eCsfSsaMAxX4MxKz/zsmpYj2fQ==
X-Received: by 2002:a24:da83:: with SMTP id z125mr12184681itg.126.1559690504298;
        Tue, 04 Jun 2019 16:21:44 -0700 (PDT)
Received: from localhost.localdomain ([209.202.195.144])
        by smtp.gmail.com with ESMTPSA id g21sm3528971ita.43.2019.06.04.16.21.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 16:21:43 -0700 (PDT)
From:   Wen Bei Li <wenbei123@gmail.com>
To:     johannes.schindelin@gmx.de
Cc:     git@vger.kernel.org
Subject: [PATCH] mergetools: add support for VS Code
Date:   Tue,  4 Jun 2019 19:21:34 -0400
Message-Id: <20190604232134.14748-1-wenbei123@gmail.com>
X-Mailer: git-send-email 2.18.0.windows.1
In-Reply-To: <nycvar.QRO.7.76.6.1906041542050.1775@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.1906041542050.1775@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach difftool and mergetool about VS Code and VS Code Insiders

Signed-off-by: Wen Bei Li <wenbei123@gmail.com>
---
Hello Johannes, thank you for reviewing my patch. It's the first time I've done this via email.
I've added `code-insiders` as you suggested, but I wasn't sure if I should send it as a v2.
I used this commit as a reference: 
https://github.com/git/git/commit/5116eab70bf8a0c8b1c29a09c4b932c4d1cf2701

 contrib/completion/git-completion.bash | 2 +-
 git-mergetool--lib.sh                  | 2 +-
 mergetools/code                        | 7 +++++++
 mergetools/code-insiders               | 7 +++++++
 4 files changed, 16 insertions(+), 2 deletions(-)
 create mode 100644 mergetools/code
 create mode 100644 mergetools/code-insiders

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 3eefbabdb1..6eaa0df5b2 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1502,7 +1502,7 @@ _git_diff ()
 
 __git_mergetools_common="diffuse diffmerge ecmerge emerge kdiff3 meld opendiff
 			tkdiff vimdiff gvimdiff xxdiff araxis p4merge bc
-			codecompare smerge
+			codecompare smerge code code-insiders
 "
 
 _git_difftool ()
diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 204a5acd66..44f1967c84 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -283,7 +283,7 @@ list_merge_tool_candidates () {
 		fi
 		tools="$tools gvimdiff diffuse diffmerge ecmerge"
 		tools="$tools p4merge araxis bc codecompare"
-		tools="$tools smerge"
+		tools="$tools smerge code code-insiders"
 	fi
 	case "${VISUAL:-$EDITOR}" in
 	*vim*)
diff --git a/mergetools/code b/mergetools/code
new file mode 100644
index 0000000000..566a0d9d63
--- /dev/null
+++ b/mergetools/code
@@ -0,0 +1,7 @@
+diff_cmd () {
+	"$merge_tool_path" --wait --diff "$LOCAL" "$REMOTE"
+}
+
+merge_cmd () {
+	"$merge_tool_path" --wait "$MERGED"
+}
diff --git a/mergetools/code-insiders b/mergetools/code-insiders
new file mode 100644
index 0000000000..566a0d9d63
--- /dev/null
+++ b/mergetools/code-insiders
@@ -0,0 +1,7 @@
+diff_cmd () {
+	"$merge_tool_path" --wait --diff "$LOCAL" "$REMOTE"
+}
+
+merge_cmd () {
+	"$merge_tool_path" --wait "$MERGED"
+}
-- 
2.21.0.windows.1

