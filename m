Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4941F1F97E
	for <e@80x24.org>; Mon,  8 Oct 2018 20:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbeJIDmq (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Oct 2018 23:42:46 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:49250 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726348AbeJIDmq (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 8 Oct 2018 23:42:46 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e17d:6d35:bfb8:6a25])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6135160781;
        Mon,  8 Oct 2018 20:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1539030553;
        bh=rSQY3NuugVBc3vnuNiJ7d7TK6okU2BWtCaqrtW+tcdc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=C7Fea53La3ujEhPTdbqLbZptMJqiennr6HGipODOkH+By4NllsjA0qWTKCA5Hlsgn
         +5Q3gaLXy7BbfFvuuq6UImjqTa20Wg0yQ0rNnwSJbBjGFxsB3lhZioMFzZEWDdkxC0
         CDIA7quqHbMsewj3BhpxQ04jWFXnKrg/011zvkwrwVsrPLtI9/HzsaT0BgO7J1ARZV
         DOw2utbQNPfdfuXceVUnG2Gi/HH5YcoHoqIajjK9YNBj3fndNLvq37yLdQRbkAPXNJ
         je69YwEmp58RrKDNL37LAqDYx6iFWL2bdwyJguXc1OyX+fiHFPXTZ/X8BhFd+xsS8a
         wVm8wR4UDvEW10nOOiOWtxIponKr4Z5hP5+IHpePcRx4h49DdMBktV7cEdN7lDtEhV
         WnO3cIo9KWFI1xHIvkmV8dKIdkq4pX7pJ+lj48PKCwpbVnYFwaYXbVDreEqfuCwwFL
         EkrtRaKnJQZmvgedZ5CLWC4SaSAnV487dACQakH36F7Z4cqB64V
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/2] editorconfig: indicate settings should be kept in sync
Date:   Mon,  8 Oct 2018 20:29:03 +0000
Message-Id: <20181008202903.100166-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c
In-Reply-To: <20181008202903.100166-1-sandals@crustytoothpaste.net>
References: <20181008202903.100166-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that we have two places where we set code formatting settings,
.editorconfig and .clang-format, it's possible that they could fall out
of sync.  This is relatively unlikely, since we're not likely to change
the tab width or our preference for tabs, but just in case, add comments
to both files reminding future developers to keep them in sync.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 .clang-format | 2 ++
 .editorconfig | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/.clang-format b/.clang-format
index 12a89f95f9..de1c8b5c77 100644
--- a/.clang-format
+++ b/.clang-format
@@ -6,6 +6,8 @@
 
 # Use tabs whenever we need to fill whitespace that spans at least from one tab
 # stop to the next one.
+#
+# These settings are mirrored in .editorconfig.  Keep them in sync.
 UseTab: Always
 TabWidth: 8
 IndentWidth: 8
diff --git a/.editorconfig b/.editorconfig
index 83227fa0b2..98d7c5ff99 100644
--- a/.editorconfig
+++ b/.editorconfig
@@ -2,6 +2,8 @@
 charset = utf-8
 insert_final_newline = true
 
+# The settings for C (*.c and *.h) files are mirrored in .clang-format.  Keep
+# them in sync.
 [*.{c,h,sh,perl}]
 indent_style = tab
 tab_width = 8
