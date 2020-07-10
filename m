Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BFEC433E0
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 332B620708
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="xXiU2VAa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgGJCs5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 22:48:57 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40396 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727110AbgGJCsr (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 9 Jul 2020 22:48:47 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A439460A7A;
        Fri, 10 Jul 2020 02:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1594349319;
        bh=40Whot27i90nDy3dIosMLpcMEvQSKm6RdwJH7pew+kw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=xXiU2VAaIHF8oVEbwYSmHv0V7utdfKGZuPRi5XbipOgWXzS2jGDISCWjRZhlZhHCz
         c9AkkaGUXbpNCn/6MW/2E0GkUTcYMMrU+omBjaBU+U1f6kAS6f/53vFdgcLtBTyL60
         zy9PJ86If9+ryuXrfzjTpPJEqfTzFInK42m8jwWtlFzHese5XOpa7Zd/Dg+9UnpYiY
         k1bcl8gxmY2FN/uQo2Et7AklkrunXbeMlmXd8AM0ZTkzWNHmg2pC+h3M3pQrDbisrF
         mBmQzXcoD7ij9Y8VcP2dTdIdDsUeGqjR/7sJh71Bk+3UU+8sIfvkhT+mc+szMvqEvK
         SSdFWVklCWVuvDyuuJPTKUJmvchIaiuMZ+Ez/bt3KFq4U8u2S07s6tiiAjlfW6dSIS
         ZAJ3Rf+dw9y49Cbl4qeI5zQyeUxw9hMY/7Ao0aWmflwsh1b2bPOv67wILrFPFznMLN
         qWB7oykRojjgaPjiKSUCNGbYlHpBQQQgq/1TqIQFCzlTr3c7ZPi
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 37/38] docs: add documentation for extensions.objectFormat
Date:   Fri, 10 Jul 2020 02:47:27 +0000
Message-Id: <20200710024728.3100527-38-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.353.gb9a2d1a020
In-Reply-To: <20200710024728.3100527-1-sandals@crustytoothpaste.net>
References: <20200710024728.3100527-1-sandals@crustytoothpaste.net>
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
 Documentation/config/extensions.txt | 7 +++++++
 2 files changed, 9 insertions(+)
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
index 0000000000..70d69cf9ab
--- /dev/null
+++ b/Documentation/config/extensions.txt
@@ -0,0 +1,7 @@
+extensions.objectFormat::
+	Specify the hash algorithm to use.  The acceptable values are `sha1`
+	and (if supported) `sha256`.  If not specified, `sha1` is assumed.
++
+Note that this setting should only by set by linkgit:git-init[1] or
+linkgit:git-clone[1].  Trying to change it after initialization will not
+work and will produce hard-to-diagnose issues.
