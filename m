Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25269202A3
	for <e@80x24.org>; Mon, 16 Oct 2017 23:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932518AbdJPXRQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Oct 2017 19:17:16 -0400
Received: from a7-20.smtp-out.eu-west-1.amazonses.com ([54.240.7.20]:37266
        "EHLO a7-20.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752007AbdJPXRO (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 16 Oct 2017 19:17:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1508195832;
        h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=lvYVzBG+OzxqlOr3i4LxSnmzx4rStGh9m2oJodL5was=;
        b=fEJ69Sml9IR7h2gfuz5FLQBShRGG0GtrzgHq+8wA53m5ih5nh13RwcpArKr3wEHl
        pThAIYrR+eSNOqyxVxWulDnKXyZ91KbKZmn/v+/cY+GksJAN4c3Ru7E/XPLYSdTjTUa
        71qn/tXbMllJ6u4ZHGMXt9BocMEWnZufxh3bn1k4=
From:   David Glasser <glasser@meteor.com>
To:     git@vger.kernel.org
Message-ID: <0102015f277a12fe-c69362e3-b14c-4b5c-abaa-4693fd6632c2-000000@eu-west-1.amazonses.com>
Subject: [PATCH] doc: list filter-branch subdirectory-filter first
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Mon, 16 Oct 2017 23:17:12 +0000
X-SES-Outgoing: 2017.10.16-54.240.7.20
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: David Glasser <glasser@davidglasser.net>

The docs claim that filters are applied in the listed order, so
subdirectory-filter should come first.
---
 Documentation/git-filter-branch.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 9e5169aa64f4f..605583c0ad2b5 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -89,6 +89,11 @@ OPTIONS
 	can be used or modified in the following filter steps except
 	the commit filter, for technical reasons.
 
+--subdirectory-filter <directory>::
+	Only look at the history which touches the given subdirectory.
+	The result will contain that directory (and only that) as its
+	project root. Implies <<Remap_to_ancestor>>.
+
 --env-filter <command>::
 	This filter may be used if you only need to modify the environment
 	in which the commit will be performed.  Specifically, you might
@@ -167,11 +172,6 @@ be removed, buyer beware. There is also no support for changing the
 author or timestamp (or the tag message for that matter). Tags which point
 to other tags will be rewritten to point to the underlying commit.
 
---subdirectory-filter <directory>::
-	Only look at the history which touches the given subdirectory.
-	The result will contain that directory (and only that) as its
-	project root. Implies <<Remap_to_ancestor>>.
-
 --prune-empty::
 	Some filters will generate empty commits that leave the tree untouched.
 	This option instructs git-filter-branch to remove such commits if they

--
https://github.com/git/git/pull/415
