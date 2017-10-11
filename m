Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D9831FA21
	for <e@80x24.org>; Wed, 11 Oct 2017 20:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752563AbdJKUC3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 16:02:29 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:47361 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752275AbdJKUC3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 16:02:29 -0400
Received: by mail-pf0-f196.google.com with SMTP id z11so1864667pfk.4
        for <git@vger.kernel.org>; Wed, 11 Oct 2017 13:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vOXgDtI056T2pNgiSAsN0FBWPv9DXtAjt4V4ONWt2ys=;
        b=IQMPxW85VTk7rqqWU5poMYE8kg6U5PM8PxWlpCUwYZ9oGMGYHupMme0YBmBKR4JkSN
         a2+jdKLSBAZw+NlzmHpRKUwZi/6Ykiry4Kl/rPp/RYJqXhXVWNuWL/owa1xcuGoHeWim
         7VC+2RxidJ2PkaJMTK+/TGl2UIhKKJ5NkY1FEPgQvZeLAyAyaeIYC6J5Ni+pSmz4PUV8
         rOgQ3Ft7dsG7dlc4LN0P7tqcIeZVvuROCdT9oqoZF5m1V1R/jdmeVvSpbo7BdQbZvQUU
         omi4c4EsofUuCD9wPFlhQXtnFSvVhbJXNSJIthOrmZ9S6m6Cy8cgTHx9BpIllw7sX4Hl
         Wwew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vOXgDtI056T2pNgiSAsN0FBWPv9DXtAjt4V4ONWt2ys=;
        b=jcz99ZLZcddOLU4l5nV0rasWfzXOBrd4yTNUxCcwPpK29T3yEMQMwdeHQwLRqmgfVb
         cFhc1nekKCPXlDLenmIozeFPP1HVfk8WjcqobYd6naxLACETHoFJNauBMEb6Q+ogZeP0
         DLXu8iK52xdEjdPEzfzgccBr6HHkFLkoqEeGqhSqMEzzi4XWFedB5y5eZsTAcMsbKWpd
         F7EotYTRFxRqbKDzsl5suwhdDKWj7a6NFGHRwNMXYFCKnBCLGewXcC8dE3INwvM/WU0p
         FH+FyNWyGgaRBnLhvple+kkd4Hjy8gEVInZcOyq5QoVK7kycoK++cyo4eoqamalAL0Rt
         PpdQ==
X-Gm-Message-State: AMCzsaUTj7NVLI7B4GIsgpSModm2LVqfjunvDNPl/wiT1CznFVZacjzj
        Mf5fELPv8qw0KQynjwO044k=
X-Google-Smtp-Source: AOwi7QACrT7emgmTXclPgxiRq1vjabkfMImEDzzg7NlJ95KHUmRWxVgYonmCEx71oW/bW541uEwGPQ==
X-Received: by 10.98.209.88 with SMTP id t24mr110304pfl.269.1507752148589;
        Wed, 11 Oct 2017 13:02:28 -0700 (PDT)
Received: from localhost.localdomain (64.71.239.49.rev.vmobile.jp. [49.239.71.64])
        by smtp.gmail.com with ESMTPSA id s3sm28725943pfb.16.2017.10.11.13.02.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Oct 2017 13:02:27 -0700 (PDT)
From:   Takahito Ogawa <aiueogawa217@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Takahito Ogawa <aiueogawa217@gmail.com>
Subject: [PATCH 1/1] git-stash.txt: correct "git stash" behavior with no arguments
Date:   Thu, 12 Oct 2017 05:01:47 +0900
Message-Id: <20171011200147.4377-1-aiueogawa217@gmail.com>
X-Mailer: git-send-email 2.13.1
In-Reply-To: <n>
References: <n>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git stash" behavior without any arguments was changed in
1ada5020b ("stash: use stash_push for no verb form", 2017-02-28).
This is equivalent to "git stash push" but documents says
"git stash save".

Correct it.

Reviewed-by: Thomas Gummerer <t.gummerer@gmail.com>
Signed-off-by: Takahito Ogawa <aiueogawa217@gmail.com>
---
 Documentation/git-stash.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 00f95fee1..63642c145 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -33,7 +33,7 @@ and reverts the working directory to match the `HEAD` commit.
 The modifications stashed away by this command can be listed with
 `git stash list`, inspected with `git stash show`, and restored
 (potentially on top of a different commit) with `git stash apply`.
-Calling `git stash` without any arguments is equivalent to `git stash save`.
+Calling `git stash` without any arguments is equivalent to `git stash push`.
 A stash is by default listed as "WIP on 'branchname' ...", but
 you can give a more descriptive message on the command line when
 you create one.
-- 
2.13.1

