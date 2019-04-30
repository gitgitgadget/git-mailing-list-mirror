Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3921D1F453
	for <e@80x24.org>; Tue, 30 Apr 2019 06:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbfD3GCn (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Apr 2019 02:02:43 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36379 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfD3GCn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Apr 2019 02:02:43 -0400
Received: by mail-pl1-f195.google.com with SMTP id w20so5615610plq.3
        for <git@vger.kernel.org>; Mon, 29 Apr 2019 23:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DAl+iCvliRp9BdKezkKLww52S+nLkFhGysv4bsWkPFo=;
        b=BsEe3lHTovVagqC3gjFLZwMHxwX+wYUfXgkxixykHTruKoNT0Q2/Fl8RRZ9Vj86GDz
         pgNNLqCkL9x9ed7SlzOz21SYQFMqUKSnEvMB+atMZTvdnaKFK1S5MScCFgI630kCKdnr
         5viDrDSD7Z6dl6rqdFrCH0PyqA1OmrRZZhKAtqC5HEu7kWbk46ACrrPDPuSOwBmGKKFE
         C91Hp40E9JAesqVj8tuVLqinhbytE1HCeGbIEUQfqumt7WS8vBWYakzNwigmIqshxjyT
         KNy+cJ2CytDZqiwHV2Ush9o7RqzG+45LsJ+zNPHvpn8FlM2dBQLCR3Q7isLhqZmnkQww
         /UHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DAl+iCvliRp9BdKezkKLww52S+nLkFhGysv4bsWkPFo=;
        b=TsO8q+N6tZREKPtuY7OenDSnUuoZQGTET8Iy8mhk7It5CDICX6nUIMNnfZRbCSJlWZ
         DM4xF0JgcG6ZFAd/LjSYgErjO9TlGyBH9v9BsNi6MukdCYZGUiSsEfjLoBTyAHiM6EOR
         5KvS2tqbsO+1K2BVhf10VRCF2Cr+TCCmRjO5kQB/PV4JhEki+pcKaZXPD0rEO3i61kZX
         jn/cjG6Qo9bRbl2V/j4t2WpZAnDy8osaGs96mdn9sSgM4AP8Eakjac2L2VhZh4bOB4eU
         1KnMLxm+ta1lFCf2Q/J70RG3SBdKtL404o37QC9CYFFmdLU9i+JA8R2fsJLX3NbMHc6v
         ewVA==
X-Gm-Message-State: APjAAAU7kMlBM/beONeKjwDCM8YWZ8at2v0sbF8hGH7HJupRxu+HElza
        ha58gzvQgRaKKeD/q7KGzzPYLc4kJJA=
X-Google-Smtp-Source: APXvYqwcz8EHnXR8UNQ+EPMty+MgC79Ux95+xSdzLH2JaXQQw+BAR3oZhj+KQ5jFiVd1n+BYOt7hDw==
X-Received: by 2002:a17:902:758a:: with SMTP id j10mr2831056pll.221.1556604162124;
        Mon, 29 Apr 2019 23:02:42 -0700 (PDT)
Received: from localhost.localdomain (36-225-124-166.dynamic-ip.hinet.net. [36.225.124.166])
        by smtp.gmail.com with ESMTPSA id m2sm16781950pfi.24.2019.04.29.23.02.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 Apr 2019 23:02:41 -0700 (PDT)
From:   John Lin <johnlinp@gmail.com>
To:     git@vger.kernel.org
Cc:     John Lin <johnlinp@gmail.com>
Subject: [PATCH v2] status: add an empty line when there is no hint
Date:   Tue, 30 Apr 2019 14:02:10 +0800
Message-Id: <20190430060210.79610-1-johnlinp@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When typing "git status", there is an empty line between
the "Changes not staged for commit:" block and the list
of changed files. However, when typing "git commit" with
no files added, there are no empty lines between them.

This patch adds empty lines in the above case and some
similar cases.

Signed-off-by: John Lin <johnlinp@gmail.com>
---
 t/t7500-commit-template-squash-signoff.sh |  1 +
 t/t7508-status.sh                         |  5 +++++
 t/t7512-status-help.sh                    |  1 +
 wt-status.c                               | 12 ++++++++----
 4 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-template-squash-signoff.sh
index 46a5cd4b73..0423e77d1d 100755
--- a/t/t7500-commit-template-squash-signoff.sh
+++ b/t/t7500-commit-template-squash-signoff.sh
@@ -345,6 +345,7 @@ cat >expected-template <<EOF
 #
 # On branch commit-template-check
 # Changes to be committed:
+#
 #	new file:   commit-template-check
 #
 # Untracked files not listed
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index e1f11293e2..949b1dbcc4 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -204,12 +204,15 @@ Your branch and 'upstream' have diverged,
 and have 1 and 2 different commits each, respectively.
 
 Changes to be committed:
+
 	new file:   dir2/added
 
 Changes not staged for commit:
+
 	modified:   dir1/modified
 
 Untracked files:
+
 	dir1/untracked
 	dir2/modified
 	dir2/untracked
@@ -449,9 +452,11 @@ Your branch and '\''upstream'\'' have diverged,
 and have 1 and 2 different commits each, respectively.
 
 Changes to be committed:
+
 	new file:   dir2/added
 
 Changes not staged for commit:
+
 	modified:   dir1/modified
 
 Untracked files not listed
diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index 458608cc1e..0a29fa66a2 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -714,6 +714,7 @@ rebase in progress; onto $ONTO
 You are currently rebasing branch '\''statushints_disabled'\'' on '\''$ONTO'\''.
 
 Unmerged paths:
+
 	both modified:   main.txt
 
 no changes added to commit
diff --git a/wt-status.c b/wt-status.c
index 445a36204a..0766e3ee12 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -175,7 +175,7 @@ static void wt_longstatus_print_unmerged_header(struct wt_status *s)
 	}
 
 	if (!s->hints)
-		return;
+		goto conclude;
 	if (s->whence != FROM_COMMIT)
 		;
 	else if (!s->is_initial)
@@ -193,6 +193,7 @@ static void wt_longstatus_print_unmerged_header(struct wt_status *s)
 	} else {
 		status_printf_ln(s, c, _("  (use \"git add/rm <file>...\" as appropriate to mark resolution)"));
 	}
+conclude:
 	status_printf_ln(s, c, "%s", "");
 }
 
@@ -202,13 +203,14 @@ static void wt_longstatus_print_cached_header(struct wt_status *s)
 
 	status_printf_ln(s, c, _("Changes to be committed:"));
 	if (!s->hints)
-		return;
+		goto conclude;
 	if (s->whence != FROM_COMMIT)
 		; /* NEEDSWORK: use "git reset --unresolve"??? */
 	else if (!s->is_initial)
 		status_printf_ln(s, c, _("  (use \"git reset %s <file>...\" to unstage)"), s->reference);
 	else
 		status_printf_ln(s, c, _("  (use \"git rm --cached <file>...\" to unstage)"));
+conclude:
 	status_printf_ln(s, c, "%s", "");
 }
 
@@ -220,7 +222,7 @@ static void wt_longstatus_print_dirty_header(struct wt_status *s,
 
 	status_printf_ln(s, c, _("Changes not staged for commit:"));
 	if (!s->hints)
-		return;
+		goto conclude;
 	if (!has_deleted)
 		status_printf_ln(s, c, _("  (use \"git add <file>...\" to update what will be committed)"));
 	else
@@ -228,6 +230,7 @@ static void wt_longstatus_print_dirty_header(struct wt_status *s,
 	status_printf_ln(s, c, _("  (use \"git checkout -- <file>...\" to discard changes in working directory)"));
 	if (has_dirty_submodules)
 		status_printf_ln(s, c, _("  (commit or discard the untracked or modified content in submodules)"));
+conclude:
 	status_printf_ln(s, c, "%s", "");
 }
 
@@ -238,8 +241,9 @@ static void wt_longstatus_print_other_header(struct wt_status *s,
 	const char *c = color(WT_STATUS_HEADER, s);
 	status_printf_ln(s, c, "%s:", what);
 	if (!s->hints)
-		return;
+		goto conclude;
 	status_printf_ln(s, c, _("  (use \"git %s <file>...\" to include in what will be committed)"), how);
+conclude:
 	status_printf_ln(s, c, "%s", "");
 }
 
-- 
2.21.0

