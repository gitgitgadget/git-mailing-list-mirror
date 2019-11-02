Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	URIBL_DBL_SPAM shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 825DD1F454
	for <e@80x24.org>; Sat,  2 Nov 2019 19:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfKBT0s (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Nov 2019 15:26:48 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:59066 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727091AbfKBT0s (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 2 Nov 2019 15:26:48 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9CD1761C6A;
        Sat,  2 Nov 2019 19:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1572722806;
        bh=awgk/Wcl8OMFu6ZMzyvts9wJbA4f1UZgdWxba6huPEo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=TSIgyHHo3x6U9ODn3R7tuWtOcy+0cePq9QHCmS9dXcuPjtZdBRTfc/BoBNKJc+yaC
         IK4baeuVmb/eTm0KERoN1D1qdzDXNShHZ+gv9BrTLRrYdm+syIS0gBCBgQCuYK4N73
         szEwPt0uk8w5wUPJgQM2kyDmB4LX/OzNGdvrFh9yfrV7BzfTtpxqqBrC2SSP9hrrCx
         sjAfQAqdzmDKcKVdzC2rxOKF4PcksqwKJhPgti1JabFjQ4Fl4yu0NhFY9pPmPPygo/
         lfpfRcOX9MGvUtCxeu5sMPyntURjijnnpejuUPgsvXWr5ztLRlEF8+5tJ0HdJETa8n
         6BGxmEI4APTDLLHt4sV+z8YUSaiZzPSk48qLv/H9aixmAlsCiWKMkFML6DlksQGu3b
         VfS0jq3Z4NFG20BMmRFmaPElZTwUgA5xxhN3lJBXl9h6EH0GmOj8yk/JXOBCH+2SK5
         SRvmrKyrllvt1T2mbIa6405OLbhpxSmJAULv1aiD0zQw8TAxR/N
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 2/4] doc: provide guidance on user.name format
Date:   Sat,  2 Nov 2019 19:26:13 +0000
Message-Id: <20191102192615.10013-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.24.0.rc2.428.g50e10028f1
In-Reply-To: <20191102192615.10013-1-sandals@crustytoothpaste.net>
References: <20191102192615.10013-1-sandals@crustytoothpaste.net>
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
index f684f7fdc2..3a69d82d52 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -467,6 +467,12 @@ if set:
 
 (nb "<", ">" and "\n"s are stripped)
 
+The author and committer names are by convention some form of a personal name
+(that is, the name by which other humans refer to you), although Git does not
+enforce or require any particular form. Arbitrary Unicode may be used, subject
+to the constraints listed above. This name has no effect on authentication; for
+that, see the `credential.username` variable in linkgit::git-config[1].
+
 In case (some of) these environment variables are not set, the information
 is taken from the configuration items user.name and user.email, or, if not
 present, the environment variable EMAIL, or, if that is not set,
