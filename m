Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4E6E20A26
	for <e@80x24.org>; Fri, 22 Sep 2017 20:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752358AbdIVUbk (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 16:31:40 -0400
Received: from siwi.pair.com ([209.68.5.199]:54753 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752212AbdIVUbj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 16:31:39 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id EA3A08470C;
        Fri, 22 Sep 2017 16:31:38 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 6DB358470A;
        Fri, 22 Sep 2017 16:31:38 -0400 (EDT)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 13/13] pack-objects: add filtering help text
Date:   Fri, 22 Sep 2017 20:30:17 +0000
Message-Id: <20170922203017.53986-14-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170922203017.53986-6-git@jeffhostetler.com>
References: <20170922203017.53986-6-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Add help text for new object filtering options to
pack-objects documentation.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Documentation/git-pack-objects.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 8973510..1ed7d4b 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -231,6 +231,23 @@ So does `git bundle` (see linkgit:git-bundle[1]) when it creates a bundle.
 	With this option, parents that are hidden by grafts are packed
 	nevertheless.
 
+--filter-omit-all-blobs::
+	Requires `--stdout`.  Omits all blobs from the packfile.
+
+--filter-omit-large-blobs=<n>[kmg]::
+	Requires `--stdout`.  Omits large blobs larger than n bytes from
+	the packfile.  May optionally be followed by 'k', 'm', or 'g' units.
+	Value may be zero.  Special files (matching ".git*") are always
+	included, regardless of size.
+
+--filter-use-blob=<blob-ish>::
+--filter-use-path=<path>::
+	Requires `--stdout`.  Use a sparse-checkout specification to
+	filter the resulting packfile to only contain the blobs that
+	would be referenced by such a sparse-checkout.  `<path>` specifies
+	a local pathname.  `<blob-ish>` specifies an expression that can
+	be evaluated to a blob.
+
 SEE ALSO
 --------
 linkgit:git-rev-list[1]
-- 
2.9.3

