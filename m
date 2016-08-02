Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B076E1F71B
	for <e@80x24.org>; Tue,  2 Aug 2016 18:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936374AbcHBSZH (ORCPT <rfc822;e@80x24.org>);
	Tue, 2 Aug 2016 14:25:07 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33763 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936351AbcHBSXN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2016 14:23:13 -0400
Received: by mail-pa0-f43.google.com with SMTP id b2so12947935pat.0
        for <git@vger.kernel.org>; Tue, 02 Aug 2016 11:22:04 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qu2L/ju/1/QJLosqrMbsSRKQ4HQwy2tcwyjzf/CJwHo=;
        b=iyFXSO+Phdzh+mvIVEySoIicutwQpVPbbAd1sl6STlfGLCRMjrTH/1oESAdHkr+3hv
         gEUbzeeR4iJakXaJxpHUVuyYGyAqamIq7wfBuiY+4uvf6uq7V7XCq7GBL44FL4MV3nXi
         vyzycXgEM0IEZGGQ4gPo3/gnRnWz0qJKaZASjIarMzXC3DXfZDNlvsbARXifgZPEtlmG
         Zz0tlznTxESg7H8xdvAAKsb+rvfNXBZOSmUYCIQcXGETs1wr4Sg2rL1PNwEsfk6p/o60
         uSno2L6fhgyaY3YUfL3wwylmmK4DV/uMGldVY+JgSTh3J048ev8Zx01iYYoP0SCdScHs
         xKOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qu2L/ju/1/QJLosqrMbsSRKQ4HQwy2tcwyjzf/CJwHo=;
        b=IZxmJfl+jNOgk8aAiDLUg9GxOlnf6nGt5RZg/caI+w8vQJy/4dbFMtqRD8nx9Aq4Xb
         WU4UYnLKqIxd0nXdZFcd6nFBHeNwO9lfGOYsEGo07Q7uC+yGfKqIJGbxaW3/fq1mPZD8
         hFZa/sA8qEwYDVUAysltpttlM21/KK1Ybb2h1ylKbaaOUDTDfdLjd1Zx75gl3e4GjXFG
         xNmLxah2iGldEh8F7stqBosQcwiqZ4EAh/gj5PVRvKqwvHJD5T2oW1aczp7nVPXMth9c
         ebcntUSJjE0Q+62MYwxPcvXAMT9aG4GUeFyJgbq+SlyXvoufZMp5OcmolHYsCyHXRHVp
         rTIQ==
X-Gm-Message-State: AEkoouuWE2ZrLwZxXEfDL2jnjZxAlVWShfFbBNAuTUNbibJSa2X6cnbc4zholYyNApnAOOXO
X-Received: by 10.66.189.104 with SMTP id gh8mr107124917pac.125.1470162123924;
        Tue, 02 Aug 2016 11:22:03 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:c95e:4bc7:6c52:ebb0])
        by smtp.gmail.com with ESMTPSA id dz13sm6479806pac.44.2016.08.02.11.22.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 02 Aug 2016 11:22:03 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	git@vger.kernel.org, gitster@pobox.com
Cc:	Jens.Lehmann@web.de, hvoigt@hvoigt.net, jrnieder@gmail.com,
	Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/2] submodule update documentation: don't repeat ourselves
Date:	Tue,  2 Aug 2016 11:21:52 -0700
Message-Id: <20160802182152.20637-2-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.525.g1760797
In-Reply-To: <20160802182152.20637-1-sbeller@google.com>
References: <20160802182152.20637-1-sbeller@google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

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
index 1452c31..9b5abaf 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -158,13 +158,13 @@ Update the registered submodules to match what the superproject
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
@@ -172,23 +172,21 @@ in the index of the containing repository already matches the commit
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
2.9.2.525.g1760797

