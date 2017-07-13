Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E59D202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 17:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752662AbdGMRft (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 13:35:49 -0400
Received: from siwi.pair.com ([209.68.5.199]:11076 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752643AbdGMRfp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 13:35:45 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 9E7A3844EE;
        Thu, 13 Jul 2017 13:35:39 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id F0A70844E3;
        Thu, 13 Jul 2017 13:35:38 -0400 (EDT)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, ethomson@edwardthomson.com,
        jonathantanmy@google.com, jrnieder@gmail.com,
        jeffhost@microsoft.com
Subject: [PATCH v2 12/19] pack-objects: add filtering help text
Date:   Thu, 13 Jul 2017 17:34:52 +0000
Message-Id: <20170713173459.3559-13-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170713173459.3559-1-git@jeffhostetler.com>
References: <20170713173459.3559-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Update pack-objects help text to describe object filtering.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Documentation/git-pack-objects.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 8973510..084641f 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -231,6 +231,20 @@ So does `git bundle` (see linkgit:git-bundle[1]) when it creates a bundle.
 	With this option, parents that are hidden by grafts are packed
 	nevertheless.
 
+--filter-omit-all-blobs::
+	Omits all blobs from the packfile.  This option requires --stdout.
+
+--filter-omit-large-blobs=<n>[kmg]::
+	Omits blobs larger than	n bytes from packfile.  May optionally be
+	followed by 'k', 'm', or 'g' units.  Value may be zero.  Special
+	files (matching ".git*") are always included, regardless of size.
+	This option requires --stdout.
+
+--filter-use-sparse=<object>::
+	Uses a sparse-checkout specification given by <object> to filter
+	the result by omitting blobs that would not be used by the
+	corresponding sparse checkout.  This option requires --stdout.
+
 SEE ALSO
 --------
 linkgit:git-rev-list[1]
-- 
2.9.3

