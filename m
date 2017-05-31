Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B64EF1FD09
	for <e@80x24.org>; Wed, 31 May 2017 21:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751056AbdEaVjk (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 17:39:40 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33497 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751037AbdEaVjk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 17:39:40 -0400
Received: by mail-wm0-f65.google.com with SMTP id b84so6696016wmh.0
        for <git@vger.kernel.org>; Wed, 31 May 2017 14:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FvXL+yz3YkSxW2hPpSrppYFPPRLPZjiTk8WCy9Cf4Sc=;
        b=cpL6bNX8NgVaa/3+/5/BK+kW+7v4/Zsvfvpmm+b9X81uWRFSeTLWxToDCGhvf8mJex
         +lNVzEFU2xmKO7MEyQa98QUKiyBMTL19m54u2bfUYd4W3kVUhDMCdXcdFnwvBDp+h2LG
         rpLTFJvqZdCAiRfBJc+nukP5G7J0ZIb9pyt4LQRNelo+lLzhz2XMsPoqmw9Zg7+LwxG7
         ISDeS4QVArzQInlu8TDpiOQT4iuadtMsUCwgFtTUUArY00CReygTj6CcOfV3c8xxG9y3
         ZspaAbjZ2QBFpnEPvAmq44yO9ZjXq8SkbV5FczEBTZWQ3F8cweAsEaQrZQgiNW4O2aku
         O1XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FvXL+yz3YkSxW2hPpSrppYFPPRLPZjiTk8WCy9Cf4Sc=;
        b=UJW9LdYcWYb0PiIJrwifPHEsAt/ooLwQAt7lfQDyJmCYdBVDv3eo2n8bkjeOkEh2Kb
         YXgGL0RZzj67e9Buw8YPbldzN7rAu63Cedy4TmVPZbsst/vTB4DMXwcz9ECHNbUnixY5
         N54vbT894aKSItjQ3Q80RrvRbzkp2fp5ZZhKNSdOTHeBh6lVLaXgSGHIDYg6iXcjNZ9a
         APefE0vzz8e5if8F+LUv2On6wBRJVmCWQcY6JuY/sD3s/dUqwbTcSPmQQ3V4jRPi+orz
         SlNfpDPYMZrq3pcFqTn375rM2i7FppqIRJdHX/m/py3kp1Zk2+kezg86HrJnERmJ+PNL
         kTDQ==
X-Gm-Message-State: AODbwcBtQ/4ZteWjQZk5veo5dV6QIYFjC5kZVm2T+Lv2Lt2F00U2SuB/
        1xN3WlwclWJvfA==
X-Received: by 10.223.151.146 with SMTP id s18mr19472218wrb.40.1496266778552;
        Wed, 31 May 2017 14:39:38 -0700 (PDT)
Received: from arrakeen.fritz.box ([2001:a61:3445:eb00:35f5:15fd:38d2:b51])
        by smtp.gmail.com with ESMTPSA id f3sm6176350wrf.2.2017.05.31.14.39.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 May 2017 14:39:37 -0700 (PDT)
From:   Andreas Heiduk <asheiduk@gmail.com>
To:     gitster@pobox.com, git@vger.kernel.org
Cc:     Andreas Heiduk <asheiduk@gmail.com>
Subject: [PATCH v1] doc: rewrite description for rev-parse --short
Date:   Wed, 31 May 2017 23:39:29 +0200
Message-Id: <20170531213929.19060-1-asheiduk@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170528143322.8580-1-asheiduk@gmail.com>
References: <20170528143322.8580-1-asheiduk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`git rev-parse --short` is not a generic modifier but just a variant
of `--verify` and considers the given length only as a suggestion to
ensure uniqueness.

Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
---
 Documentation/config.txt        |  1 +
 Documentation/git-rev-parse.txt | 12 ++++++------
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 43d830ee3..3256a3344 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -883,6 +883,7 @@ core.abbrev::
 	computed based on the approximate number of packed objects
 	in your repository, which hopefully is enough for
 	abbreviated object names to stay unique for some time.
+	The minimum length is 4.
 
 add.ignoreErrors::
 add.ignore-errors (deprecated)::
diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index c40c47044..b1293f24b 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -126,6 +126,12 @@ can be used.
 	'git diff-{asterisk}'). In contrast to the `--sq-quote` option,
 	the command input is still interpreted as usual.
 
+--short[=length]::
+	Same as `--verify` but shortens the object name to a unique
+	prefix with at least `length` characters. The minimum length
+	is 4, the default is the effective value of the `core.abbrev`
+	configuration variable (see linkgit:git-config[1]).
+
 --not::
 	When showing object names, prefix them with '{caret}' and
 	strip '{caret}' prefix from the object names that already have
@@ -136,12 +142,6 @@ can be used.
 	The option core.warnAmbiguousRefs is used to select the strict
 	abbreviation mode.
 
---short::
---short=number::
-	Instead of outputting the full SHA-1 values of object names try to
-	abbreviate them to a shorter unique name. When no length is specified
-	7 is used. The minimum length is 4.
-
 --symbolic::
 	Usually the object names are output in SHA-1 form (with
 	possible '{caret}' prefix); this option makes them output in a
-- 
2.13.0

