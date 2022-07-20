Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01CECCA485
	for <git@archiver.kernel.org>; Wed, 20 Jul 2022 18:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbiGTS4H (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jul 2022 14:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbiGTSzh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jul 2022 14:55:37 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFAF5DF17
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 11:55:35 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id b26so27421015wrc.2
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 11:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8CQZzk5WQTrklnhDq+eF1kIuclBLqdF8Zch5eAGpfY0=;
        b=k+M1tbmPvyENe1rEeiNJfWkaB1i+SnfUWk4vU7Xxhlt3aYTnSWeDiNk2UfnaKlTtJI
         0v7uWL2IAOFN+ZK5T/XBobRwfKQsZTbOtXzqdfIN+RtRkgWm/4Gj88R+o5eepgk4wTGO
         csww1UATk3afRSWYnamYZtpmDo3df6sTyeaJvTDKSOm9nZeB5VoHr7UdE7dawJ4i87xg
         OtTG8geWYkQ9siONv1KJDbIthMNydltaCI1SYeaEr/OXzj9nEe31MqSuIya8R+zTo9Y4
         +giRxbVUv3t6iFn1Uu/Gnj+LdoKPOVfE3/TWmmtdvgqWHBnT5XcCWrbfhtXBfD5wknoQ
         aFPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8CQZzk5WQTrklnhDq+eF1kIuclBLqdF8Zch5eAGpfY0=;
        b=7ZEjV5oFNypZhUOtu3xpmA1Gxtvs2lRdFHHtqm6R59HOhnfNWA1v8kJSOwf9EwPopN
         nSSXvnFgFq4C29G7HLnCEegsUBEjAz85EnBkNlfGzdEXfURWtnsit4VWOB6spCEwvHmF
         eoQJEpdi63bblwG5O9+hbGXftl5iOXBZEkh8P4AAjDCNwl7ns97aUmEoMje26Mn8aGwr
         OtprRIVCwGxiJTt1TOfl+JaxigHLCLAKZuu6NAXR/VFEdrTMsLyIpg4b1njcb6QXfhBH
         1kSWr2IFGcobU9QE3M8YQ8tTZc3X0h/v69qDi+MEc69lzaThVdliDFm/7QtdfBV+l9iJ
         snTg==
X-Gm-Message-State: AJIora8vpGkCwgdInmXMFapOM2WB2eVSL/8Tkued+grN29cIaN1yP6A2
        L0rwx+7J6gOYDsXGsUQGCDI8grp2Z/g=
X-Google-Smtp-Source: AGRyM1uP9IyYZOwPL35mm0Iv/NEgqWpkrVGHFNcroUm1ZSI+tHo3NQ5VEuz38QbabXbWBvaDDVnpEg==
X-Received: by 2002:a05:6000:1681:b0:21d:85a7:4ed with SMTP id y1-20020a056000168100b0021d85a704edmr31489934wrd.345.1658343334125;
        Wed, 20 Jul 2022 11:55:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b16-20020a056000055000b0021e2fccea97sm5389213wrf.64.2022.07.20.11.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 11:55:33 -0700 (PDT)
Message-Id: <f7566dd5fc36fd3ae648abf7054fc0e1269b6874.1658343330.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1297.v2.git.git.1658343330.gitgitgadget@gmail.com>
References: <pull.1297.git.git.1658298900.gitgitgadget@gmail.com>
        <pull.1297.v2.git.git.1658343330.gitgitgadget@gmail.com>
From:   "Moritz Baumann via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 Jul 2022 18:55:30 +0000
Subject: [PATCH v2 2/2] git-p4: fix error handling in
 P4Unshelve.renameBranch()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Luke Diamand <luke@diamand.org>,
        Moritz Baumann <moritz.baumann@sap.com>,
        Moritz Baumann <moritz.baumann@sap.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Moritz Baumann <moritz.baumann@sap.com>

The error handling code path is meant to be triggered when the loop does
not exit early via "break". This fails, as the boolean variable "found",
which is used to track whether the loop was exited early, is initialized
incorrectly.

It would be possible to fix this issue by correcting the initialization,
but Python supports a for:-else: control flow construct for this exact
use case (executing code if a loop does not exit early), so it is more
idiomatic to remove the tracking variable entirely.

In addition, the error message no longer refers to a variable that does
not exist.

Signed-off-by: Moritz Baumann <moritz.baumann@sap.com>
---
 git-p4.py | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 1de3d6f1cd4..8f20d15f272 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -4369,19 +4369,16 @@ class P4Unshelve(Command):
     def renameBranch(self, branch_name):
         """Rename the existing branch to branch_name.N ."""
 
-        found = True
         for i in range(0, 1000):
             backup_branch_name = "{0}.{1}".format(branch_name, i)
             if not gitBranchExists(backup_branch_name):
                 # Copy ref to backup
                 gitUpdateRef(backup_branch_name, branch_name)
                 gitDeleteRef(branch_name)
-                found = True
                 print("renamed old unshelve branch to {0}".format(backup_branch_name))
                 break
-
-        if not found:
-            sys.exit("gave up trying to rename existing branch {0}".format(sync.branch))
+        else:
+            sys.exit("gave up trying to rename existing branch {0}".format(branch_name))
 
     def findLastP4Revision(self, starting_point):
         """Look back from starting_point for the first commit created by git-p4
-- 
gitgitgadget
