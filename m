Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F181C433F8
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 01:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 394952080D
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 01:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="C2DP3iFF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387627AbgGWBKK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jul 2020 21:10:10 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40488 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387619AbgGWBKH (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Jul 2020 21:10:07 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id BA6D061011
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 01:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595466605;
        bh=sulHYnLx/DRdhIwbRlRYUrvWMCiEMYec6UmOO0+MxvU=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=C2DP3iFFgI7l+oBuPHZMm4kOohG09ZSU7h7pRhgZme2yMY5k6TUOJFhoytMCVVpmj
         6uHhKn3TsUdgOPVC5it6YWxfedIp09IQCzj8GESQBVsUc70wxFTvYkTrvBsCpXdmTY
         kOGGV/nVm3hwceUE3gGSeZkz54y95m267mIYLYvK8ZGPzSDrJXoXJ46z+HIxQOHFYu
         cgRBlVwLgM2/MJSgX0BrFNvdkVXgLP/gbQ4GDiUFaXF6CKeU25vHPokQmZhOUe3JRS
         JQVF1cGRVHtFepCHDN7fzXpwXW1fcM0zfiJqOmBKw0pbaHSP2/pn1+oS5jYcvV7r/b
         whcewwhpHZmvS+LpVVe9ej4F5QnQypxsYymZc8qO4lLAZLxerf9rF5HjnO9K45h/Gr
         AZ4lBfUJT5F4QSIUvIPfnZs/u/j3o88PIkE8lHUoSrOxwknKINKSZjoRZ0DH6Y1u8I
         NVnpIzYW9btvBuxKwZVZSclAlP/clwyAll1bnBsLpADRNyW6mTb
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [PATCH v3 38/39] docs: add documentation for extensions.objectFormat
Date:   Thu, 23 Jul 2020 01:09:42 +0000
Message-Id: <20200723010943.2329634-39-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.rc1.129.ge9626dbbb9f
In-Reply-To: <20200723010943.2329634-1-sandals@crustytoothpaste.net>
References: <20200723010943.2329634-1-sandals@crustytoothpaste.net>
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
