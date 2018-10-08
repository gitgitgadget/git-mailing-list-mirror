Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45EAC1F97E
	for <e@80x24.org>; Mon,  8 Oct 2018 22:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbeJIFRy (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 01:17:54 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:49416 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725749AbeJIFRx (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 9 Oct 2018 01:17:53 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e17d:6d35:bfb8:6a25])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DE1F060790;
        Mon,  8 Oct 2018 22:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1539036242;
        bh=jNG8DiRU7v3V775YGaUUXeuDfawrb/VMkr94XZWjSYs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=MiYu+vw3ijGJI2hvCchBoTx8KkGc7Sxeic7iB+HfJ+gO+03BUxVb9Ycf6IXnTxp4L
         lhVvz4o+sOUTalBNTMYnPTHce4x3A0lt21kZce+3Ck7TNHMRqz8h5pf543l6hzNJ7h
         z1E2wthsLk+AnSiUHrKlbIfr61GmSF59TnD0Hq0NeOb7pt6B8YuBwX3RG1ojK7dhfa
         O+UDpxPV8DXiYRkRdY5G2wjUG2cPcFEO4FkbtYDzGoCoN1vHw14sEMuHU+QWEBszl+
         G+kiXTbo/EXXxQeXMIDnrVgr9zhpXD9TRd/z78yv/Am+nuaj6tu2Cui9Uz6wsrjF1P
         /zjXXuAoSQZuiC7auhaARHkPAWcy31Zu7XOD5HviKMLjNeBJbAIDP1Kn3+bjOzVhlO
         RwCxyekInlycD4EYnnHB21WD3RfYYNpAOow/wBNiAOx2WQbY+2q8xYIlBfZEsBhhxH
         O8BDws29c2xRar1A8u6LtC7RnELcuDJgP9qede9WzMYPMl+ULjT
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 2/2] editorconfig: indicate settings should be kept in sync
Date:   Mon,  8 Oct 2018 22:03:53 +0000
Message-Id: <20181008220353.780301-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c
In-Reply-To: <20181008220353.780301-1-sandals@crustytoothpaste.net>
References: <20181008220353.780301-1-sandals@crustytoothpaste.net>
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
index 8667740e1d..42cdc4bbfb 100644
--- a/.editorconfig
+++ b/.editorconfig
@@ -2,6 +2,8 @@
 charset = utf-8
 insert_final_newline = true
 
+# The settings for C (*.c and *.h) files are mirrored in .clang-format.  Keep
+# them in sync.
 [*.{c,h,sh,perl,pl,pm}]
 indent_style = tab
 tab_width = 8
