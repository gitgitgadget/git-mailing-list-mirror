Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED3AE202A7
	for <e@80x24.org>; Fri, 30 Jun 2017 00:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752629AbdF3AIB (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Jun 2017 20:08:01 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34657 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752609AbdF3AH6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2017 20:07:58 -0400
Received: by mail-pf0-f180.google.com with SMTP id s66so58009207pfs.1
        for <git@vger.kernel.org>; Thu, 29 Jun 2017 17:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=saLD6vcOTdVkO/K/f9uuChVI0Rf4EK+XctRkTYl6gNI=;
        b=sylENzrgUJudZ1kwqkx/r5c6hk7nFJc4hncnFRRaVjBjgT15kjFiGMBx3hst42eSpT
         g5n24MmMgF+jtb6skg8rukjIIp3wp1Qnf3t5TP9XHxwDjm8EJ6aiTyw6kYg+Iq/QXFXv
         bo7oU0tDbI+DZz4kTPcbLSBN0yM75OP7IPVE9VqCUZ/phayNfxAGAZrQxhK5c62GCXns
         PPpiAyVuMmonW70zZb+Ugacc5XvAWObM6rhCn/kELV3Y+Ud/uG2DlyghX/sFiDYPMkNH
         vJNawZWiliPkZd0NANZJUh6Gf50ww8lRx55PoA2JhGKPCYpFAOxMBHpl7L5lf4H9gzt+
         untw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=saLD6vcOTdVkO/K/f9uuChVI0Rf4EK+XctRkTYl6gNI=;
        b=FPmi5g3BDamDxLHIL4d5FB2VDcQOpxSlL03dGhNB7yIrmFFb6hNW+zAXraRn0PFlsu
         NR7vJEYsgdmZSPjrb/I7n/3DEW/3EGdI74aosKqXcEmANlzI551W5hYfFuaSXAb0C1Wh
         nbXt8dB8VML17Y2IQrUvKyK2Vmre6L0XlNAxcbWoR8mHb0LCIdZtmGUHCrn49aMoFUOR
         WFTn6vviQYsC6b+FymGPA9luU3VntmWEE/hE/bMrSgwXp/AcAQwOCe78h2kTGmxrjJJe
         CYYanVaJaB6nL9K3YpafkuD/9P3KRu1J+R85UfY1AcagaAielTFvAwO+JzSdudmY5LWN
         biRw==
X-Gm-Message-State: AKS2vOxzOJ6PTmcqUjC9U4fh0GVS60lHkflW1sHc++MxYZ+T+ap0xF1Q
        LPR5x0SAJiBwOPL+
X-Received: by 10.84.128.9 with SMTP id 9mr21095453pla.61.1498781277603;
        Thu, 29 Jun 2017 17:07:57 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c3c:7a18:f5d8:50e0])
        by smtp.gmail.com with ESMTPSA id u73sm13906553pfi.105.2017.06.29.17.07.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 29 Jun 2017 17:07:55 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 25/25] diff: document the new --color-moved setting
Date:   Thu, 29 Jun 2017 17:07:10 -0700
Message-Id: <20170630000710.10601-26-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.31.g9b732c453e
In-Reply-To: <20170630000710.10601-1-sbeller@google.com>
References: <20170630000710.10601-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/config.txt       | 15 +++++++++++++--
 Documentation/diff-options.txt | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 06898a7498..74382e5ff5 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1077,14 +1077,25 @@ This does not affect linkgit:git-format-patch[1] or the
 'git-diff-{asterisk}' plumbing commands.  Can be overridden on the
 command line with the `--color[=<when>]` option.
 
+diff.colorMoved::
+	If set to either a valid `<mode>` or a true value, moved lines
+	in a diff are colored differently, for details of valid modes
+	see '--color-moved' in linkgit:git-diff[1]. If simply set to
+	true the default color mode will be used. When set to false,
+	moved lines are not colored.
+
 color.diff.<slot>::
 	Use customized color for diff colorization.  `<slot>` specifies
 	which part of the patch to use the specified color, and is one
 	of `context` (context text - `plain` is a historical synonym),
 	`meta` (metainformation), `frag`
 	(hunk header), 'func' (function in hunk header), `old` (removed lines),
-	`new` (added lines), `commit` (commit headers), or `whitespace`
-	(highlighting whitespace errors).
+	`new` (added lines), `commit` (commit headers), `whitespace`
+	(highlighting whitespace errors), `oldMoved` (deleted lines),
+	`newMoved` (added lines), `oldMovedDimmed`, `oldMovedAlternative`,
+	`oldMovedAlternativeDimmed`, `newMovedDimmed`, `newMovedAlternative`
+	and `newMovedAlternativeDimmed` (See the '<mode>'
+	setting of '--color-moved' in linkgit:git-diff[1] for details).
 
 color.decorate.<slot>::
 	Use customized color for 'git log --decorate' output.  `<slot>` is one
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 89cc0f48de..bb257a83b2 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -231,6 +231,40 @@ ifdef::git-diff[]
 endif::git-diff[]
 	It is the same as `--color=never`.
 
+--color-moved[=<mode>]::
+	Moved lines of code are colored differently.
+ifdef::git-diff[]
+	It can be changed by the `diff.colorMoved` configuration setting.
+endif::git-diff[]
+	The <mode> defaults to 'no' if the option is not given
+	and to 'zebra' if the option with no mode is given.
+	The mode must be one of:
++
+--
+no::
+	Moved lines are not highlighted.
+default::
+	Is a synonym for `zebra`. This may change to a more sensible mode
+	in the future.
+plain::
+	Any line that is added in one location and was removed
+	in another location will be colored with 'color.diff.newMoved'.
+	Similarly 'color.diff.oldMoved' will be used for removed lines
+	that are added somewhere else in the diff. This mode picks up any
+	moved line, but it is not very useful in a review to determine
+	if a block of code was moved without permutation.
+zebra::
+	Blocks of moved code are detected greedily. The detected blocks are
+	painted using either the 'color.diff.{old,new}Moved' color or
+	'color.diff.{old,new}MovedAlternative'. The change between
+	the two colors indicates that a new block was detected.
+	Small blocks of 3 moved lines or fewer are skipped.
+dimmed_zebra::
+	Similar to 'zebra', but additional dimming of uninteresting parts
+	of moved code is performed. The bordering lines of two adjacent
+	blocks are considered interesting, the rest is uninteresting.
+--
+
 --word-diff[=<mode>]::
 	Show a word diff, using the <mode> to delimit changed words.
 	By default, words are delimited by whitespace; see
-- 
2.13.0.31.g9b732c453e

