Return-Path: <SRS0=BIPJ=BF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0AA1C433FB
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 19:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71D172065F
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 19:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="QRKpZ2W4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbgGZTzB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jul 2020 15:55:01 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40740 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728020AbgGZTy7 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Jul 2020 15:54:59 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3EE686101C;
        Sun, 26 Jul 2020 19:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595793298;
        bh=sulHYnLx/DRdhIwbRlRYUrvWMCiEMYec6UmOO0+MxvU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=QRKpZ2W4DdhoOijkpbRquwagpItuuMyG2V3ES14QCT2AWjjjcU7aQMxMj4dlSd4lX
         LGiyMivuFWWhEnl/KYHkPVBUqG3z44FIHz6d/YGxLtQiil/iffJ2oyE6yrmZZ6Vd1c
         oO7oNB1icvobXWNb0SzMVKgwFS9lmQ2/VGJM/0yZNAIoLnbkq96RWtX/qPezUV3f3i
         sBFu7PpxsGZT5kiwppNYeCyfgA+BCvk0PBwY+ux8sXiWlcOejkdPTvifd0EDd3sQ9R
         XGScsxF+0DOjJJuxTSeo8pDBV5VGoj0GdktPpJzXO+yuRnDk141ILXHlaaUXbUB3i7
         hm1RIYMvHK9VJxKplZZsXAoRjzSxB+1Mwr624p4MRbol5hWag9bj8e0pr8GzJarFYM
         g5tKeJWx8pe0ezgikf4h9/Za4CAcE4u6odc3NW3s+yRGngNe6JUmldoTxfJEecJ1MX
         PJV7st64r5b80Wcp8onNcagjATzYAup/cehW9AAy7Gce+xrfCHz
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 38/39] docs: add documentation for extensions.objectFormat
Date:   Sun, 26 Jul 2020 19:54:23 +0000
Message-Id: <20200726195424.626969-39-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.rc2.160.gd0b3904b262
In-Reply-To: <20200726195424.626969-1-sandals@crustytoothpaste.net>
References: <20200726195424.626969-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Document the extensions.objectFormat config setting.  Warn users not to
modify it themselves.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/config.txt            | 2 ++
 Documentation/config/extensions.txt | 8 ++++++++
 2 files changed, 10 insertions(+)
 create mode 100644 Documentation/config/extensions.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ef0768b91a..3042d80978 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -348,6 +348,8 @@ include::config/diff.txt[]
 
 include::config/difftool.txt[]
 
+include::config/extensions.txt[]
+
 include::config/fastimport.txt[]
 
 include::config/feature.txt[]
diff --git a/Documentation/config/extensions.txt b/Documentation/config/extensions.txt
new file mode 100644
index 0000000000..e97a78bdd6
--- /dev/null
+++ b/Documentation/config/extensions.txt
@@ -0,0 +1,8 @@
+extensions.objectFormat::
+	Specify the hash algorithm to use.  The acceptable values are `sha1` and
+	`sha256`.  If not specified, `sha1` is assumed.  It is an error to specify
+	this key unless `core.repositoryformatversion` is 1.
++
+Note that this setting should only be set by linkgit:git-init[1] or
+linkgit:git-clone[1].  Trying to change it after initialization will not
+work and will produce hard-to-diagnose issues.
