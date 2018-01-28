Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E10D61F404
	for <e@80x24.org>; Sun, 28 Jan 2018 19:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752118AbeA1TQR (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jan 2018 14:16:17 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56941 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752364AbeA1TQQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Jan 2018 14:16:16 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E3FDDD4812;
        Sun, 28 Jan 2018 14:16:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id; s=sasl; bh=j3uoB5rxq64wJcJk3GBZYRmYIgc
        =; b=hjcKvd0rqdxyZ6wH98vA7awtx9JTbhO9x/IxeNzUAWSg0nWB5cBEcZZ9jjk
        Me5XpWbPgbBP2SemsWT0oTyTn8x+7DWpDD3s1oR+7/9JQiJSrT1UPPTtUNB3wH2q
        ux0LKDqSMeNtjeDAOUTdwOOTm7Wj02HZl/QgJRxvVSZ4IH+4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id; q=dns; s=sasl; b=v4EGMWWoK5GX0G5xBXY6Y
        YmN9AR+liYFr0D3Y9R4Xdyc2sR4WRnq/m/uIJOZ5xQRg/sXGwN29X3vb4SS0kPv0
        j4bdwxWSTVHKCHFxJwoPFlz2knnv3G8q8J3VsXwKHaIJIy66Qq7FSRcm7Xjl3eAD
        rb7bLtFHyRZX69X1SErDOk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DB4AFD4811;
        Sun, 28 Jan 2018 14:16:10 -0500 (EST)
Received: from morphine.paradise.teonanacatl.net (unknown [47.202.85.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0AF88D4810;
        Sun, 28 Jan 2018 14:16:09 -0500 (EST)
From:   Todd Zullinger <tmz@pobox.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH] doc: mention 'git show' defaults to HEAD
Date:   Sun, 28 Jan 2018 14:16:07 -0500
Message-Id: <20180128191607.31199-1-tmz@pobox.com>
X-Mailer: git-send-email 2.16.1
X-Pobox-Relay-ID: B2B63820-045F-11E8-A11F-692D1A68708C-09356542!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When 'git show' is called without any object it defaults to HEAD.  This
has been true since d4ed9793fd ("Simplify common default options setup
for built-in log family.", 2006-04-16).

The SYNOPSIS suggests that the object argument is required.  Clarify
that it is not required and note the default.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
This was mentioned in #git today by qaz.  It seems reasonable to document the
default.

 Documentation/git-show.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-show.txt b/Documentation/git-show.txt
index 82a4125a2d..e73ef54017 100644
--- a/Documentation/git-show.txt
+++ b/Documentation/git-show.txt
@@ -9,7 +9,7 @@ git-show - Show various types of objects
 SYNOPSIS
 --------
 [verse]
-'git show' [options] <object>...
+'git show' [options] [<object>...]
 
 DESCRIPTION
 -----------
@@ -35,7 +35,7 @@ This manual page describes only the most frequently used options.
 OPTIONS
 -------
 <object>...::
-	The names of objects to show.
+	The names of objects to show (defaults to 'HEAD').
 	For a more complete list of ways to spell object names, see
 	"SPECIFYING REVISIONS" section in linkgit:gitrevisions[7].
 
-- 
2.16.1

