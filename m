Return-Path: <SRS0=cmu9=3J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A085C33CAA
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 17:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54C4A21835
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 17:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="xfVGq9Fx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbgATRd5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 12:33:57 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:43050 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726901AbgATRd4 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Jan 2020 12:33:56 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id F40AB607F7;
        Mon, 20 Jan 2020 17:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1579541636;
        bh=UVKsYt/9GzBUZj0UgdY6lD//V/UbooCeMLbDbhbQcNM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=xfVGq9FxrZJ84g8wQvj50kVOdDNGhhceaNYnSbuCs6zEPXOV7OgOEjanoKM7b6c12
         2VzlNlFMHa2yj+c2WhiL2YFSJVEGt8//SL/2CRwTqeVrRVWjdf3nymwYvHFjLRIW66
         uwvzEoR28seQeCT1KVvvt7XJ1wTE2u2rNfR0O13PLLwTPzb35WIjw92K9ZQOmqwiIK
         AXeNs10LS/SdFYu9gl4pCITotzk9hHK+VLeufhWeOEB316XPm6oZCqbbpnrLFqlu3B
         9zoSJ5OBMXaofQXUetCKfYufJVGlFDFOLz0LZ/bmABxseIF33BuJJ0wLRrouIliMKX
         fKewMntiuppH/3ueEGrc0rzu3GpGl/lPNHGlCD2NWTwqeu9ZJDyrClkQXwtDNY7OUB
         LYIKMZ4LkBRndrIfgYKXNKFabeukME5n37t6/v1DYI5OUMbuGUZ9rtOb4j5ZRLDeaj
         stIjsJRidsN2qIoqT0ipf5GUdyICWub2QWdYIxNsp9Hu23qoo/h
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: [PATCH v4 2/5] docs: expand on possible and recommended user config options
Date:   Mon, 20 Jan 2020 17:33:40 +0000
Message-Id: <20200120173343.4102954-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309
In-Reply-To: <20200120173343.4102954-1-sandals@crustytoothpaste.net>
References: <20200120173343.4102954-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the section on setting author and committer information, we omit the
author.* and committer.* variables, so mention them for completeness.
In addition, guide users to the typical case: simply setting user.name
and user.email, which are recommended if one does not need complex
configuration.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/git-commit.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 30c30ccd80..7b61c9ba79 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -482,6 +482,13 @@ system user name and the hostname used for outgoing mail (taken
 from `/etc/mailname` and falling back to the fully qualified hostname when
 that file does not exist).
 
+The `author.name` and `committer.name` and their corresponding email options
+override `user.name` and `user.email` if set and are overridden themselves by
+the environment variables.
+
+The typical usage is to set just the `user.name` and `user.email` variables;
+the other options are provided for more complex use cases.
+
 :git-commit: 1
 include::date-formats.txt[]
 
