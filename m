Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 255811F404
	for <e@80x24.org>; Sat, 16 Dec 2017 08:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751368AbdLPIOe (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Dec 2017 03:14:34 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:44999 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751041AbdLPIOd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Dec 2017 03:14:33 -0500
Received: by mail-pg0-f67.google.com with SMTP id j9so7206109pgc.11
        for <git@vger.kernel.org>; Sat, 16 Dec 2017 00:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H21O8DT5WNs/1zyOfYJ93cdB2qC/BwwhsOk/sNASYqI=;
        b=RVOwCIuPMqDv4YKgkmaUB/FFrdwpWHn1zwt3HKEyEaamwhR4pFMBrrUWBfDd10KOh2
         nc6zmgOpEbM2A2KtvZJoUUHu64Y1gEDuCCWJFIRvOH1iYY5jLC5CWBzQGWglwTZdLt1r
         u8X5LmvhiU82fREmyxFTlwBWKNkf0loTA54lTx4ZLKjpNFJ5c4LcKrpMQnLHGLel+6LH
         QXpiwcVJRbhsJdlHZehx9V2u7em1ohridQZ5ZAGbW/2iYwGd8l4PxFuFfOKbgymojs4c
         b0Y4w/w5ePRfAbBQ6jfqMDnyoRY2V+yY55hTAGtuoMGgtL5R8oQPspNx7HZyus8FMMU9
         8z8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=H21O8DT5WNs/1zyOfYJ93cdB2qC/BwwhsOk/sNASYqI=;
        b=cpa0TQmSUAwkQSXTpIaOBoHjfCJI26rZLo9dCYIC4jYgz2PcFi9yEfh8NsrN9mlRVV
         VxW3N238q4U3vi0zN2MAGQXAfT2WsZZIC6JiQetLYn77cjf8sVLnsi7ATlMqOBfMrDnB
         czkCdZbcb82w2irTo7A1HJzzZ+E5JllquBHlmNA6rjWuNL660n5sW04eK6MyEjtXbxmd
         yVF5s/UYQnt/YLrgj/kmVupHhIgvOH0ymtomDt30K2IO9yasacfGa3Jt6luptV+7c/bc
         wXEVEsxdYJzFRemfRyrXKm8QTBrw1iANerB7g8iPudefvLLVN7izJUS3cWJhZhXtikZ9
         1VAg==
X-Gm-Message-State: AKGB3mJf2K2X8PNi2PjJMTvCZsDh+dxtHfshDI8FJLW2aEew89UfILNP
        TaKBftQFm4lXXR0iig6m5P4=
X-Google-Smtp-Source: ACJfBouhWzviyvCCB8T3FwQN8sZU9TVGA6rt8MWadbnO0YhObNS2Z9/4MwsmDWtTwwIzWOWyZwiahg==
X-Received: by 10.98.193.1 with SMTP id i1mr16092616pfg.29.1513412072120;
        Sat, 16 Dec 2017 00:14:32 -0800 (PST)
Received: from localhost.localdomain ([117.209.230.129])
        by smtp.gmail.com with ESMTPSA id b127sm13410307pgc.70.2017.12.16.00.14.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Dec 2017 00:14:30 -0800 (PST)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>
Subject: [PATCH v5 1/1] Doc/check-ref-format: clarify information about @{-N} syntax
Date:   Sat, 16 Dec 2017 13:43:49 +0530
Message-Id: <20171216081349.10431-2-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.15.0.531.g2ccb3012c
In-Reply-To: <20171216081349.10431-1-kaartic.sivaraam@gmail.com>
References: <xmqqa7ylur1i.fsf@gitster.mtv.corp.google.com>
 <20171216081349.10431-1-kaartic.sivaraam@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the N-th previous thing checked out syntax (@{-N}) is used
with '--branch' option of check-ref-format the result may not be
the name of a branch that currently exists or ever existed. This
is because @{-N} is used to refer to the N-th last checked out
"thing", which might be a commit object name if the previous check
out was a detached HEAD state; or a branch name, otherwise. The
documentation thus does a wrong thing by promoting it as the
"previous branch syntax".

State that @{-N} is the syntax for specifying "N-th last thing
checked out" and also state that the result of using @{-N} might
also result in an commit object name.

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
 Documentation/git-check-ref-format.txt | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
index cf0a0b7df..d9de99258 100644
--- a/Documentation/git-check-ref-format.txt
+++ b/Documentation/git-check-ref-format.txt
@@ -79,16 +79,21 @@ reference name expressions (see linkgit:gitrevisions[7]):
 
 With the `--branch` option, the command takes a name and checks if
 it can be used as a valid branch name (e.g. when creating a new
-branch).  The rule `git check-ref-format --branch $name` implements
+branch). But be cautious when using the
+previous checkout syntax that may refer to a detached HEAD state.
+The rule `git check-ref-format --branch $name` implements
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
+was checked out using "git checkout" operation. This option should be
+used by porcelains to accept this syntax anywhere a branch name is
+expected, so they can act as if you typed the branch name. As an
+exception note that, the ``previous checkout operation'' might result
+in a commit object name when the N-th last thing checked out was not
+a branch.
 
 OPTIONS
 -------
@@ -116,7 +121,7 @@ OPTIONS
 EXAMPLES
 --------
 
-* Print the name of the previous branch:
+* Print the name of the previous thing checked out:
 +
 ------------
 $ git check-ref-format --branch @{-1}
-- 
2.15.0.531.g2ccb3012c

