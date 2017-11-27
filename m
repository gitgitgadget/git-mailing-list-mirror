Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E989A20C11
	for <e@80x24.org>; Mon, 27 Nov 2017 17:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753780AbdK0R3F (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 12:29:05 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:46826 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753138AbdK0R3E (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 12:29:04 -0500
Received: by mail-pf0-f195.google.com with SMTP id q4so17643151pfg.13
        for <git@vger.kernel.org>; Mon, 27 Nov 2017 09:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mndAy63NxVV+wvr3H+/K/6+6++9lwJT+NeRjk+A/nyk=;
        b=NcolrDOvJ5jVU+ikhZe2qAAClmfKyP/OdY0/sQT+ieWUuG6C32SD3x43YMoBLiFw2v
         9DDW2DH42DQfmicOSh6cCepI21PdOIZsbb41hsE03w7VL7unEIqHVQlzgEG0zuKuAA/S
         72I31d3EFLhxZzaVL8no3atje0c49POAMpous0yLXRC5/Vn3A0fNRyrHbk/45TiQTa3D
         97YROGXDgJ5HDLLccyh5R2E+U2J3j3tRTV83FS32PD0Caipbb54WDO+zs96svSwSpmRo
         +uWWzngPtBTlHcbDp8/CjBFKQ2k2M11dlGl6aacWBEK8T+8Y0YMR0NYnTserGhazqp+W
         3FWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mndAy63NxVV+wvr3H+/K/6+6++9lwJT+NeRjk+A/nyk=;
        b=XJ8VJ9CB8V5RHNeTrnLanp3742aApCD/eZbaMFkqJRyI6Vr7OSlgjtxt4JipppvNGc
         8I95qPw2QcN8cKb+OuPwUI8slf0cbv8DzwkVQqMaAaJTytqYi93O6TMLR61wqFBO8ePG
         5sMI0KfNnrv9NzOvsff8JBN9q8KdNDUKFNzlvF6lJb/LL+rrITxaBKpW7R/DNhUxvirJ
         eRJ1NHYVwdiNKINlAcsT8W2PrPpR4zObUImyPH9+d0jEHTJl13m0V/y/BItwO5tjwHSO
         /HT/xs6EvrUzHfORAqDjj6mpEa/rIeWCbmghf5PJF3Md2zUpsE7rcwdnF7dWBWu5v6Lk
         kITA==
X-Gm-Message-State: AJaThX4qjETeYe2/2lqx+aZd+8d5Khj8ZD7sUmVKVWQMzlpFF+o6+ZWf
        ejKq2h7l5a5JeU4kID7zOMqUNgGKcE4=
X-Google-Smtp-Source: AGs4zMZopvbdvyypJSv+g/uEJbIlV429xt4nIUUtJmRsab9zDUanEObA44o8hYj8QzGfHzwmX53vbA==
X-Received: by 10.101.87.193 with SMTP id q1mr17264135pgr.370.1511803743535;
        Mon, 27 Nov 2017 09:29:03 -0800 (PST)
Received: from localhost.localdomain ([2405:204:73c7:b4fb:72c8:dd31:37ff:6021])
        by smtp.gmail.com with ESMTPSA id s81sm51232454pfg.60.2017.11.27.09.29.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Nov 2017 09:29:02 -0800 (PST)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>
Subject: [PATCH v2 2/2] Doc/check-ref-format: clarify information about @{-N} syntax
Date:   Mon, 27 Nov 2017 22:58:34 +0530
Message-Id: <20171127172834.6396-2-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.15.0.345.gf926f18f3
In-Reply-To: <20171127172834.6396-1-kaartic.sivaraam@gmail.com>
References: <xmqqpo8dn1jd.fsf@gitster.mtv.corp.google.com>
 <20171127172834.6396-1-kaartic.sivaraam@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the N-th previous thing checked out sytax is used with
'--branch' option of check-ref-format the results might not
always be a valid branch name as @{-N} is used to refer to
the N-th last checked out "thing" which might be any commit
(sometimes a branch). The documentation thus does a wrong thing
by promoting it as the "previous branch syntax".

So, correctly state @{-N} is the syntax for specifying "N-th last
thing checked out" and also state that the result of using @{-N}
might also result in a "commit hash".

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
2.15.0.345.gf926f18f3

