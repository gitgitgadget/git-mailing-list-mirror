Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7669202A0
	for <e@80x24.org>; Sun, 19 Nov 2017 15:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753223AbdKSPES (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Nov 2017 10:04:18 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39959 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753097AbdKSPEQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Nov 2017 10:04:16 -0500
Received: by mail-wm0-f65.google.com with SMTP id b189so14058073wmd.5
        for <git@vger.kernel.org>; Sun, 19 Nov 2017 07:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=1CfGyVNfANe1QyxntUuxGCrQn9udYdFQWlKLiUveKWU=;
        b=cHZifHc9OAd5vKxaSRWBbJfcZK9G/BwMso4NZybYNzix3J9WOu5AJbgDRoQNSSY6Sq
         eT0lQ9zHhC9jCdmouNtysXs6RsC8B26Iq/ufKY/t7pvk5J8nTDpUKPZjqoM7R7rTZAva
         cc80AbQHLsA8nxaZGPcfRaiVn5fpkVBqCTDEt+861J7N6WN3BPBEuY0PKWStsivi4G62
         O1/n6jRqnekv2A5f3EVh3EI+lV7kN7rLd6oNqyXdawGls7zBZLt79w0KfKZCNv6x1YQL
         vaI6ieCkmt8s/b0t3xcrmBjFI1g15iCiwDtqMHeNl+GjRItoEye67CQO8lYwY+c6UKNk
         mxTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1CfGyVNfANe1QyxntUuxGCrQn9udYdFQWlKLiUveKWU=;
        b=o0GsAS/047vVa2jt+jmQGNH7m1BG9tFLvMzrVPhj2Hakf0++nHFgWnj6rLDW/ZAklr
         iHdDnaW7Nm7/dNp/d+seWNtzZN30xpvKc03SbO1egdij6YMH5BMVJZ6FHYxasoonddWU
         xmLhjU3vTPiuola04U9GArPrFSGrwXPhlBXP4dqtbs7qAKlh1lRWJjd/+dASaOtWOUIj
         BOzC+8oQOI0xRPDyiUTFHHYCOFDA+/jsmTPj1by9Xrav+fCxkfRDADOMYkohxcLpm9kb
         jWTHE8mnCcQZ3gkqAcF+bKh9RD9XxWMyil8dkrwGDMaSFFQwEj13PyCgB/4mry65g2F/
         pXfQ==
X-Gm-Message-State: AJaThX4GMzSt/5WDD2/fL8cVvg2hTMpnGGMKUlFqHUqImtPHW/T+5kG7
        pxBb5MMe3Mk3dthweGYM54JlrTMZ
X-Google-Smtp-Source: AGs4zMaWDrDe4AnpWsFmqe+zM0XvD/SMRbAp5MnoMUZXdJz8Xq7F4mBL3D9Jhtcuu8Mi8moRfo4puQ==
X-Received: by 10.28.225.197 with SMTP id y188mr8684531wmg.12.1511103855069;
        Sun, 19 Nov 2017 07:04:15 -0800 (PST)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id 56sm5163518wrx.2.2017.11.19.07.04.13
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Nov 2017 07:04:14 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 3/3] branch: change default of `pager.branch` to "on"
Date:   Sun, 19 Nov 2017 16:03:50 +0100
Message-Id: <ef9b1f9e3cd70bdf3500a242781f9ba030bbf8aa.1511103275.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.15.0.415.gac1375d7e
In-Reply-To: <5f6be626171060e008005062560c76319b31958f.1511103275.git.martin.agren@gmail.com>
References: <5f6be626171060e008005062560c76319b31958f.1511103275.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is similar to ff1e72483 (tag: change default of `pager.tag` to
"on", 2017-08-02) and is safe now that we do not consider `pager.branch`
at all when we are not listing branches. This change will help with
listing many branches, but will not hurt users of `git branch
--edit-description` as it would have before the previous commit.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-branch.txt |  2 +-
 t/t7006-pager.sh             | 10 +++++-----
 builtin/branch.c             |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index df24506e18..520c53b5e8 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -284,7 +284,7 @@ start-point is either a local or remote-tracking branch.
 CONFIGURATION
 -------------
 `pager.branch` is only respected when listing branches, i.e., when
-`--list` is used or implied.
+`--list` is used or implied. The default is to use a pager.
 See linkgit:git-config[1].
 
 Examples
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index bb4fee3901..f5f46a95b4 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -214,21 +214,21 @@ test_expect_success TTY 'git tag as alias respects pager.tag with -l' '
 	! test -e paginated.out
 '
 
-test_expect_success TTY 'git branch defaults to not paging' '
+test_expect_success TTY 'git branch defaults to paging' '
 	rm -f paginated.out &&
 	test_terminal git branch &&
-	! test -e paginated.out
+	test -e paginated.out
 '
 
 test_expect_success TTY 'git branch respects pager.branch' '
 	rm -f paginated.out &&
-	test_terminal git -c pager.branch branch &&
-	test -e paginated.out
+	test_terminal git -c pager.branch=false branch &&
+	! test -e paginated.out
 '
 
 test_expect_success TTY 'git branch respects --no-pager' '
 	rm -f paginated.out &&
-	test_terminal git -c pager.branch --no-pager branch &&
+	test_terminal git --no-pager branch &&
 	! test -e paginated.out
 '
 
diff --git a/builtin/branch.c b/builtin/branch.c
index 9c74689fb0..4e6b8c3bc1 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -676,7 +676,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	}
 
 	if (list)
-		setup_auto_pager("branch", 0);
+		setup_auto_pager("branch", 1);
 
 	if (delete) {
 		if (!argc)
-- 
2.15.0.415.gac1375d7e

