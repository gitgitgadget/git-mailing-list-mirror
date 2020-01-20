Return-Path: <SRS0=cmu9=3J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7AD0C33CA1
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 17:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA66821835
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 17:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="yOC9tuTk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgATReC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 12:34:02 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:43058 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726642AbgATRd5 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Jan 2020 12:33:57 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7CA04607F8;
        Mon, 20 Jan 2020 17:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1579541636;
        bh=1gz1uFStXA7Jkxdnj2K2/AYj2PxiwTkDuyF3nGcBeOE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=yOC9tuTk2hOPrZHN/IowSFiggVLdBaA7L1rYp0pIPiiAatGjoP75ombZbtgPotEBu
         FhDS1W9AxXUI/oD3IHqOVC/LmkkJPkjxOLvcE9qXKOPVFlS1GJLxSsSmnd2vJrRgr8
         IGTYOChFfHKRmMDPbpuRpFvnRsxpfmpSt2jP+kPj984k4ScprN3WUglv7Bsr711aNE
         X42oL/cV8ffLWRGbncb0r/Idg+nvsJkPq9AhhrCVxcsFzCIEBAM1BpH9DPzSZY2Wxv
         MPYI5RsL+G34iOgz0iQ+HrXhAPux6OgiJm6ZbslTzeisb43/xJVlXTsBIQtx4FtJMi
         C/I2f+WM8VLKY+Lw6aAceHTFbQMWu3+YzSG5KiyNPO54z4NJ945EdnyBS4mbKUyW4k
         0EF2mX0JWcThku9/EC6tAylszloza1Fjd1PSLJMD9dooxBWZEDF8U4GyB3stFUqkhI
         T5oS8E2nzKlwPVd7chYvpU82EwxYDSvIywqK0+8jZy8KlaJip7c
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: [PATCH v4 3/5] doc: provide guidance on user.name format
Date:   Mon, 20 Jan 2020 17:33:41 +0000
Message-Id: <20200120173343.4102954-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309
In-Reply-To: <20200120173343.4102954-1-sandals@crustytoothpaste.net>
References: <20200120173343.4102954-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's a frequent misconception that the user.name variable controls
authentication in some way, and as a result, beginning users frequently
attempt to change it when they're having authentication troubles.
Document that the convention is that this variable represents some form
of a human's personal name, although that is not required.  In addition,
address concerns about whether Unicode is supported.

Use the term "personal name" as this is likely to draw the intended
contrast, be applicable across cultures which may have different naming
conventions, and be easily understandable to people who do not speak
English as their first language.  Indicate that "some form" is
conventionally used, as people may use a nickname or preferred name
instead of a full legal name.

Point users who may be confused about authentication to an appropriate
configuration option instead.  Provide a shortened form of this
information in the configuration option description.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/config/user.txt | 7 ++++++-
 Documentation/git-commit.txt  | 6 ++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/user.txt b/Documentation/config/user.txt
index a1f80e823c..f0edb06329 100644
--- a/Documentation/config/user.txt
+++ b/Documentation/config/user.txt
@@ -13,7 +13,12 @@ committer.email::
 	Also, all of these can be overridden by the `GIT_AUTHOR_NAME`,
 	`GIT_AUTHOR_EMAIL`, `GIT_COMMITTER_NAME`,
 	`GIT_COMMITTER_EMAIL` and `EMAIL` environment variables.
-	See linkgit:git-commit[1] for more information.
++
+Note that the `name` forms of these variables conventionally refer to
+some form of a personal name.
+See linkgit:git-commit[1] for more information on these settings and
+the `credential.username` option if you're looking for authentication
+credentials instead.
 
 user.useConfigOnly::
 	Instruct Git to avoid trying to guess defaults for `user.email`
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 7b61c9ba79..13f653989f 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -475,6 +475,12 @@ variables, if set:
 
 (nb "<", ">" and "\n"s are stripped)
 
+The author and committer names are by convention some form of a personal name
+(that is, the name by which other humans refer to you), although Git does not
+enforce or require any particular form. Arbitrary Unicode may be used, subject
+to the constraints listed above. This name has no effect on authentication; for
+that, see the `credential.username` variable in linkgit:git-config[1].
+
 In case (some of) these environment variables are not set, the information
 is taken from the configuration items `user.name` and `user.email`, or, if not
 present, the environment variable EMAIL, or, if that is not set,
