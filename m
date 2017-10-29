Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A866202A0
	for <e@80x24.org>; Sun, 29 Oct 2017 15:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751457AbdJ2PMb (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Oct 2017 11:12:31 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:53863 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751324AbdJ2PMa (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2017 11:12:30 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 04A7920680;
        Sun, 29 Oct 2017 11:12:30 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute2.internal (MEProxy); Sun, 29 Oct 2017 11:12:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dwim.me; h=cc
        :content-transfer-encoding:content-type:date:from:message-id
        :mime-version:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        mesmtp; bh=6iIrmIGEN1xnpYkTrqRAKvgwZ+3TwilE4mIUrumbZKM=; b=elPul
        hNt/3PHj/d5btZqhaNMCiYkFJefwfmXsc/WCqOqtqMCR2k3XxltlQlptTRNDxb9w
        KDYWHYl78Owqn1nkdJfTTK82cD1ZCDKhvysELMuVqdx+b9V6na/eBd0kZCRrA3AE
        1Ka3s0uKfzFdjRtyFvS6u9n4/cZoagAbtr/Vjk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=6iIrmIGEN1xnpYkTrqRAKvgwZ+3Tw
        ilE4mIUrumbZKM=; b=PpgXxwCsLSm/QFu2H2dUYFzioWztrh+kIWYJ4InuveJM9
        OCM23JPbCXulEzulr84qQl2Mo2E4WYbfEpT+b5LeQ9LlpgbHvXljV1puLXC6b7f2
        zBO9x8LkNoVW4d/EvwD1oHx3Zik+yIRjG9+F5dEANNnNuS3f/AcLKCW8OGzkzHMu
        rLUEd2/rTx+NQvqzFj9wUdWMX4yYLske5TvyXDbpInczYb0AWM3QboPOJ7gvdNHG
        /emryVtlExhA/4GFsOPegTAkDiJ9o0B0WfGfOVcYrHUlc4kTIH/1T3Kuw6QEv97i
        Sftn1SiT/FVzDW1t67QCs8BfgS1FSpOOilM4ZsO9w==
X-ME-Sender: <xms:3e_1WS9ORuCU0eXLzipE14XGGuhZCZBsWy7Rf8QxX6jmrFrzSGVgpw>
Received: from cmartin.tk (ip5f5bf2d0.dynamic.kabel-deutschland.de [95.91.242.208])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6F6CD7E13B;
        Sun, 29 Oct 2017 11:12:29 -0400 (EDT)
Received: (nullmailer pid 607879 invoked by uid 1000);
        Sun, 29 Oct 2017 15:12:28 -0000
From:   =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@dwim.me>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH] diff: --indent-heuristic is no longer experimental
Date:   Sun, 29 Oct 2017 16:12:28 +0100
Message-Id: <20171029151228.607834-1-cmn@dwim.me>
X-Mailer: git-send-email 2.15.0.rc2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This heuristic has been the default since 2.14 so we should not confuse our
users by saying that it's experimental and off by default.

Signed-off-by: Carlos Martín Nieto <cmn@dwim.me>
---
 Documentation/diff-heuristic-options.txt | 5 -----
 Documentation/diff-options.txt           | 7 ++++++-
 2 files changed, 6 insertions(+), 6 deletions(-)
 delete mode 100644 Documentation/diff-heuristic-options.txt

diff --git a/Documentation/diff-heuristic-options.txt b/Documentation/diff-heuristic-options.txt
deleted file mode 100644
index d4f3d95505..0000000000
--- a/Documentation/diff-heuristic-options.txt
+++ /dev/null
@@ -1,5 +0,0 @@
---indent-heuristic::
---no-indent-heuristic::
-	These are to help debugging and tuning experimental heuristics
-	(which are off by default) that shift diff hunk boundaries to
-	make patches easier to read.
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index a88c76741e..dd0dba5b1d 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -63,7 +63,12 @@ ifndef::git-format-patch[]
 	Synonym for `-p --raw`.
 endif::git-format-patch[]
 
-include::diff-heuristic-options.txt[]
+--indent-heuristic::
+	Enable the heuristic that shift diff hunk boundaries to make patches
+	easier to read. This is the default.
+
+--no-indent-heuristic::
+	Disable the indent heuristic.
 
 --minimal::
 	Spend extra time to make sure the smallest possible
-- 
2.15.0.rc2

