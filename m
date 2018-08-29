Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41A2C1F404
	for <e@80x24.org>; Wed, 29 Aug 2018 00:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbeH2ExX (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 00:53:23 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37318 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727099AbeH2ExX (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Aug 2018 00:53:23 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:1024:89fd:c4a5:84be])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D92516075B
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 00:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1535504347;
        bh=7nXpY+CleSE/lOcDIX26N+Di0N7mBQqrFrax5nvkjlo=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=Iix7aokc3YhYGUpGROGKXTcsJKF0iSVzJ+dwVjCbVDJDLCDPG004NLyv2YUOmK7yJ
         aaH01qPeR7a9sRS0Q6veQw3sWKq+gHdo0YfmxUOn4GMVCCoT8qV2JCDFH+p2my6AVk
         BMV4VZk2rUVLVRHkWIe5yX+WHTalP2vZKwr0u15wDuzvnl4a7EtEZquKCPNtzwA6/B
         u/99GGOmJ4DAR7JbZEEz5g3XBspjMGJKfj+6XgSkjSwF+fY0ncs/yyNTc7o2H+q+Oj
         0lAsC1Ga6A8sQkD3n/hP2Dy9W6Ag5h3M1Ry7J0Y8hOiIxWIy+zUyOiXbYDJqOcR2pa
         8psLjogdZotY2TP5UZpxqp92+JSp9TC4MQvUXdoNGqjBbvuYuNN8KO770SbDcvf7iz
         fciK518vMZUXFxETy//tqI1xT21W/UzpDQM9qtrKzqPU6uoQeInWEx5AnQn0bZJaS+
         v2vDFbAEUWYA6yBnKKfNf44knAmljGrSdG9Hg76xXQTCzZnjVmK
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Subject: [RFC PATCH 01/12] sha1-file: rename algorithm to "sha1"
Date:   Wed, 29 Aug 2018 00:58:46 +0000
Message-Id: <20180829005857.980820-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0
In-Reply-To: <20180829005857.980820-1-sandals@crustytoothpaste.net>
References: <20180829005857.980820-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The transition plan anticipates us using a syntax such as "^{sha1}" for
disambiguation.  Since this is a syntax some people will be typing a
lot, it makes sense to provide a short, easy-to-type syntax.  Omitting
the dash doesn't create any ambiguity, but it does make it shorter and
easier to type, especially for touch typists.  In addition, the
transition plan already uses "sha1" in this context.

Rename the name of SHA-1 implementation to "sha1".

Note that this change creates no backwards compatibility concerns, since
we haven't yet used this field in any serialized data formats.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 sha1-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sha1-file.c b/sha1-file.c
index 97b7423848..5223e3d1ce 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -97,7 +97,7 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 		NULL,
 	},
 	{
-		"sha-1",
+		"sha1",
 		/* "sha1", big-endian */
 		0x73686131,
 		GIT_SHA1_RAWSZ,
