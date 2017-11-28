Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C04920C13
	for <e@80x24.org>; Tue, 28 Nov 2017 16:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753252AbdK1QeY (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Nov 2017 11:34:24 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:46395 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752852AbdK1QeX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Nov 2017 11:34:23 -0500
Received: by mail-pg0-f67.google.com with SMTP id b11so144608pgu.13
        for <git@vger.kernel.org>; Tue, 28 Nov 2017 08:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7m0h+mjkzZAc21+4OjX8oBRtxunVxHv2u4t4n/q2LYc=;
        b=Y//4TX28ytO1hgHYQ4LjKS/s1SUWlKOLbXq8SPsXMA1Wh/lIkTzwPo8NSZr+a90tPj
         Q74f5tTwKoyLm2gs+TCeIGc+JgeB4ZNvGi67D7pOl/orrAhNc6tBGzyRxGAsVk08RFh0
         JQGg5Rw1Rup/EJnQ9g4CAuYcCAZ8EKtpCGmGRc9b6rkEimor7Ns6ZzkAtoElSEl4OWBI
         SFc+VgJBixF7YnonhLBmFbsaXb6vPt4WRWV8npKoT9GZ3kDwBKdfPX8dVfsWn06U6ciC
         vNm3HYVzBQdm7X6Xp1FZfN9zZkLBg5jweg1TtrCfUqzPypEaSPkmZG3elB4H2ctbD6z/
         bnWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7m0h+mjkzZAc21+4OjX8oBRtxunVxHv2u4t4n/q2LYc=;
        b=psUtv4XK5LUowoV86RzfkS5+HoBl3c2hTJCrRBUnW2nWt59d00J9VHRrwiyEe0dlOx
         NH/U4zfbeNGOcuMX0DPd7dUsctER776HaxmPZrpWw3eFq/SDS+DKUpyzyNyeFuphjnoR
         RcFYwphn3u69AtnMsCH+4tD3pTInSkeqU4sOtUGMQ2h0eY7TShw1xrPm62KR994Ovv6G
         Jk1dgms2zNXYawhaYEgmLvytwnHr1gVRS+LC70PWUsuahVYzw6O8qSr4tezCFsYhisEx
         +65HoV5f8dFf3Ukri5xfddqt/2m0JkbzuoSy41hNN8u0icWGDPAta0nJ5ZhB5i8YsqyQ
         zJrQ==
X-Gm-Message-State: AJaThX6+vzxkwaKw1HAqDz/GFJCnuVQzFs86gCh7ZrAT+D+heA8tH7A1
        PRl/8zWZ6x1CB3tfhzqmiq2HC1Z0
X-Google-Smtp-Source: AGs4zMagJOgOIiNRc9UmrYQZagJrHM4AXEeJfTrC/aOEiU0xvSC1AZR16dqXRMbjwUZey41kM7VC7g==
X-Received: by 10.101.66.11 with SMTP id c11mr40262879pgq.169.1511886862555;
        Tue, 28 Nov 2017 08:34:22 -0800 (PST)
Received: from localhost.localdomain ([2405:204:7344:993e:9a3:d467:14f5:495b])
        by smtp.gmail.com with ESMTPSA id z74sm46183279pfi.123.2017.11.28.08.34.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Nov 2017 08:34:21 -0800 (PST)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>
Subject: [PATCH v3 2/2] Doc/check-ref-format: clarify information about @{-N} syntax
Date:   Tue, 28 Nov 2017 22:04:06 +0530
Message-Id: <20171128163406.15452-1-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.15.0.531.g2ccb3012c
In-Reply-To: <xmqqd14386sw.fsf@gitster.mtv.corp.google.com>
References: <xmqqd14386sw.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the N-th previous thing checked out syntax (@{-N}) is used
with '--branch' option of check-ref-format the result might not
always be a valid branch name (see NOTE below). This is because
@{-N} is used to refer to the N-th last checked out "thing" which
might be any commit (sometimes a branch). The documentation thus
does a wrong thing by promoting it as the "previous branch syntax".

So, correctly state @{-N} is the syntax for specifying "N-th last
thing checked out" and also state that the result of using @{-N}
might also result in a "commit hash".

NOTE: Though a commit-hash is a "syntactically" valid branch name,
it is generally not considered as one for the use cases of
"git check-ref-format --branch". That's because a user who does
"git check-ref-format --branch @{-$N}" would except the output
to be a "existing" branch name apart from it being syntactically
valid.

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
 Documentation/git-check-ref-format.txt | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
index cf0a0b7df..5ddb562d0 100644
--- a/Documentation/git-check-ref-format.txt
+++ b/Documentation/git-check-ref-format.txt
@@ -78,17 +78,20 @@ reference name expressions (see linkgit:gitrevisions[7]):
 . at-open-brace `@{` is used as a notation to access a reflog entry.
 
 With the `--branch` option, the command takes a name and checks if
-it can be used as a valid branch name (e.g. when creating a new
-branch).  The rule `git check-ref-format --branch $name` implements
+it can be used as a valid branch name e.g. when creating a new branch
+(except for one exception related to the previous checkout syntax
+noted below). The rule `git check-ref-format --branch $name` implements
 may be stricter than what `git check-ref-format refs/heads/$name`
 says (e.g. a dash may appear at the beginning of a ref component,
 but it is explicitly forbidden at the beginning of a branch name).
 When run with `--branch` option in a repository, the input is first
-expanded for the ``previous branch syntax''
-`@{-n}`.  For example, `@{-1}` is a way to refer the last branch you
-were on.  This option should be used by porcelains to accept this
-syntax anywhere a branch name is expected, so they can act as if you
-typed the branch name.
+expanded for the ``previous checkout syntax''
+`@{-n}`.  For example, `@{-1}` is a way to refer the last thing that
+was checkout using "git checkout" operation. This option should be
+used by porcelains to accept this syntax anywhere a branch name is
+expected, so they can act as if you typed the branch name. As an
+exception note that, the ``previous checkout operation'' might result
+in a commit hash when the N-th last thing checked out was not a branch.
 
 OPTIONS
 -------
@@ -116,7 +119,7 @@ OPTIONS
 EXAMPLES
 --------
 
-* Print the name of the previous branch:
+* Print the name of the previous thing checked out:
 +
 ------------
 $ git check-ref-format --branch @{-1}
-- 
2.15.0.531.g2ccb3012c

