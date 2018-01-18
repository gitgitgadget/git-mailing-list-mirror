Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 980971FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 18:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756003AbeARSgb (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 13:36:31 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:38553 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755827AbeARSga (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 13:36:30 -0500
Received: by mail-pg0-f68.google.com with SMTP id y27so8979590pgc.5
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 10:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WJXzwVdGvOqkLlxJNuoUzTsEzhxI52glz+DL9IGU9OA=;
        b=PlHs76oERzzKjrRwl7N9NJpwd8IW9dpKIQ5KIhUFv+w6xQFRvMBoqaRfR+T5UEjYzV
         /DLbhNnbQsDkvwUhD3hW0BiaZiHaW9vBFZHTXKL6qwsKUOBkZQ7froBi6dPesr+PpWwG
         7y3GNIZ5fU6p/tCJmQ11cc2D7saGsr9wtMP04IuI0x/Tca6JwfR13YQXHJo1JpTsn85U
         X9k5jfpHC+6jFmfk3kZigYMYRgAENsUlL1ifzt5HKMzHKHlsxd/5u0iLvtCaCrmAUIgV
         zRUfXLhUGQd2eUaWvqdGZY8gl3UhAQu1daSWvx2dgkHgLlyXo8STEAz8smte/+ocOE3p
         Uk1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WJXzwVdGvOqkLlxJNuoUzTsEzhxI52glz+DL9IGU9OA=;
        b=ayLzwwgRiXFYNrRXkLF9CbBRZ0fFhTkvA6THNS6lBdlcXw0HW98/2sd8TQgcvyLmgC
         C27JqNYAKl1kCOWUL5oLAvdH3RQgJWKW4x2jUmJ0Szha+4ksxSpNQRnOU/1S4/H6bdnn
         q7kJQcA0CZxotQIeIFHkAnY14PM/eg53OJ5RwvDUe0yxffy0alWvgCfi8h50EH1bTupj
         WyrCyg2tb8G6QSoCkiQjw6PAbVsBx8ndcQvvFlEF4r/+yDGmbD0YKUIfp5b+19MMH5LJ
         VDKw6LXuM5Sv6BbdMJs+iK2oIShljQiE/TDbnFmXFhTcSfyYVXwHvbFG5NcOHBrj8erm
         Bm3A==
X-Gm-Message-State: AKGB3mJNFyXNzKx4EU0qkNjb4olznTVk1c0e2zl3U5+OTS07hJbuMz26
        /24Elcao/Bgh6Uq+IDr4BoUjyw==
X-Google-Smtp-Source: ACJfBosBPFls3BObJqnC+VIQKtx4lKO+YaH+VEUH39W/ju9fKCDX+eDgez2MmXkX9HjG6mhXd+qvVA==
X-Received: by 10.99.117.18 with SMTP id q18mr32898581pgc.71.1516300589241;
        Thu, 18 Jan 2018 10:36:29 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id m6sm13594366pfh.151.2018.01.18.10.36.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Jan 2018 10:36:28 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     johannes.schindelin@gmx.de
Cc:     git@vger.kernel.org, gitster@pobox.com, jacob.keller@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 9/8] [DO NOT APPLY, but squash?] git-rebase--interactive: clarify arguments
Date:   Thu, 18 Jan 2018 10:36:17 -0800
Message-Id: <20180118183618.39853-2-sbeller@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
In-Reply-To: <20180118183618.39853-1-sbeller@google.com>
References: <cover.1516225925.git.johannes.schindelin@gmx.de>
 <20180118183618.39853-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Up to now each command took a commit as its first argument and ignored
the rest of the line (usually the subject of the commit)

Now that we have commands that take different arguments, clarify each
command by giving the argument list.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 git-rebase--interactive.sh | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 23184c77e8..3cd7446d0b 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -155,17 +155,17 @@ reschedule_last_action () {
 append_todo_help () {
 	gettext "
 Commands:
-p, pick = use commit
-r, reword = use commit, but edit the commit message
-e, edit = use commit, but stop for amending
-s, squash = use commit, but meld into previous commit
-f, fixup = like \"squash\", but discard this commit's log message
-x, exec = run command (the rest of the line) using shell
-d, drop = remove commit
-l, label = label current HEAD with a name
-t, reset = reset HEAD to a label
-b, bud = reset HEAD to the revision labeled 'onto'
-m, merge = create a merge commit using a given commit's message
+p, pick <commit> = use commit
+r, reword <commit> = use commit, but edit the commit message
+e, edit <commit> = use commit, but stop for amending
+s, squash <commit> = use commit, but meld into previous commit
+f, fixup <commit> = like \"squash\", but discard this commit's log message
+x, exec <commit> = run command (the rest of the line) using shell
+d, drop <commit> = remove commit
+l, label <label>= label current HEAD with a name
+t, reset <label> = reset HEAD to a label
+b, bud = reset HEAD to the revision labeled 'onto', no arguments
+m, merge [<label-or-commit>]* = create a merge commit using a given commit's message
 
 These lines can be re-ordered; they are executed from top to bottom.
 " | git stripspace --comment-lines >>"$todo"
-- 
2.16.0.rc1.238.g530d649a79-goog

