Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F702C433DB
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 22:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4425323B00
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 22:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbhAIWHf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Jan 2021 17:07:35 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:49746 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726068AbhAIWHf (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 9 Jan 2021 17:07:35 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1CDE360781;
        Sat,  9 Jan 2021 22:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1610229984;
        bh=XpPn8YFx+YYukV/4hUuUXjm3Ktbomn4bCfn+9hF0S08=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=fEw/RXLFGVpwzGlJtUWEauFLrB8XECJvVj7YSu8bogq/CFRaVejbNfBFzKrS15SOB
         6ZWCyYiTOCedff6HMYQ1XokOwMVmKlzrraY0jG8j1Pza3uSa8pGatg4U9jcsCelM7r
         JIbszlOH2hGZkQ4xjl6paIy6rN31XUgaKt8AxfLbifxTpQEltfUALb617IM6QBo8ga
         wJMJXJk7BvSGvBltOFvEgak8BJeS35bwEZqvfNEB7AewN1tmLL5lm8kq0Mcb2vawgB
         y7TvOQ3ODpJd+T3ASg6Pn/gokv6ypSEp00B+q0+eKKHAq5QocgawswWHOctK06Bsss
         KWU9gz2JCHNhEqU+5HuyzaZrhwQvGWqoHLWWxz93cU6nZmFaaMJVDfmLEvjuzC/iV+
         TAm5BatxnG0BiccaXmmZRrjw3sLhpTJhzkFBJ6TfP5jOO5bdjYkmLYtqhG4UU/Ku3O
         7cHmpssapQv6wmGJM8tv7noeGpqpvhG5oMAFKgZhnvjb1I9BrNI
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Alan Mackenzie <acm@muc.de>
Subject: [PATCH] docs: add description of status output table
Date:   Sat,  9 Jan 2021 22:06:14 +0000
Message-Id: <20210109220614.759779-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <X/oAhdZlLwcFRCrR@ACM>
References: <X/oAhdZlLwcFRCrR@ACM>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The table describing the porcelain format in git-status(1) is helpful,
but it's not completely clear what the three sections mean, even to
some contributors.  As a result, users are unable to find how to detect
common cases like merge conflicts programmatically.

Let's improve this situation by describing what each section means:
non-conflicted, conflicted, or untracked files.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/git-status.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 7731b45f07..63f13c201d 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -201,6 +201,10 @@ codes can be interpreted as follows:
 Ignored files are not listed, unless `--ignored` option is in effect,
 in which case `XY` are `!!`.
 
+In the table below, the first section indicates normal non-conflicted states for
+tracked files, the second indicates files where a merge conflict has occurred
+but not yet been resolved, and the third indicates files not tracked by Git.
+
 ....
 X          Y     Meaning
 -------------------------------------------------
