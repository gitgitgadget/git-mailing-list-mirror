Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BB3C433FE
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 22:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbiKBWs4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 18:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKBWsz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 18:48:55 -0400
Received: from smtp-out-2.talktalk.net (smtp-out-2.talktalk.net [62.24.135.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6290263BE
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 15:48:53 -0700 (PDT)
Received: from localhost.localdomain ([88.110.102.84])
        by smtp.talktalk.net with SMTP
        id qMXSo68vDLVi2qMXTojVpM; Wed, 02 Nov 2022 22:48:51 +0000
X-Originating-IP: [88.110.102.84]
X-Spam: 0
X-OAuthority: v=2.3 cv=H8GlPNQi c=1 sm=1 tr=0 a=f4UhoLCnUTRb1HgAgoWw0g==:117
 a=f4UhoLCnUTRb1HgAgoWw0g==:17 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10
 a=ldyaYNNxDcoA:10 a=JPTC99osL3cmJ_4B028A:9
From:   Philip Oakley <philipoakley@iee.email>
To:     GitList <git@vger.kernel.org>
Cc:     Self <philipoakley@iee.email>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: [RFC/PoC 2/5] Documentation Bundles: ignore artifact files from creating doc bundles
Date:   Wed,  2 Nov 2022 22:48:40 +0000
Message-Id: <20221102224843.2104-3-philipoakley@iee.email>
X-Mailer: git-send-email 2.38.1.281.g83ef3ded8d
In-Reply-To: <20221102224843.2104-1-philipoakley@iee.email>
References: <20221102224843.2104-1-philipoakley@iee.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfP+5GEMKmOJJ1OjmZfyD96VPuiapPur3v2rUxs7JwZAcvb/Mncp2kz08XkYkGHtKtUw4CjAhy1EpJD1AWqRH6t5+A76hrwsVWFP9zcAQZS6Sk/xFKqZZ
 a8Pc4ayHzhBJqNriM7sJLR9eFWxTwVY/3IgZfyzzVZLoRmw84ea0/S8oQybRTKzTMW1dgYSzKEL7lhtQ3wHAQgMV+9ciN0Oi+hXoeRgQEYoIg3eSyPnGYUDv
 OkGdJg9fF/yOOC9vE59RbFTsFwg5IJyE0TlX4N5f6zM=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The Git documentation contains many examples that can be prepared as
repository bundles for users to clone and explore without any language
or translation confusions between the written word and intended code.

There are also a large number of example repositories in the t/ test
system can can also be exposed to users to highlight the critical
distinctions tested therein.

These documentation bundles will be prepared ar part of the test system.
Start by ignoring those parts which will be considered build artifacts,
the GIT-BUNDLE-DIR, and the `.bndl` bundle files themselves.

The artifacts themselves will later be manipulated by the `make` elements
of the documentation system.

Signed-off-by: Philip Oakley <philipoakley@iee.email>
---
 .gitignore | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.gitignore b/.gitignore
index 6ded10067a..b96a4ce5df 100644
--- a/.gitignore
+++ b/.gitignore
@@ -3,6 +3,7 @@
 /fuzz-pack-headers
 /fuzz-pack-idx
 /GIT-BUILD-OPTIONS
+/GIT-BUNDLE-DIR
 /GIT-CFLAGS
 /GIT-LDFLAGS
 /GIT-PREFIX
@@ -250,3 +251,4 @@ Release/
 *.dSYM
 /contrib/buildsystems/out
 CMakeSettings.json
+*.bndl
-- 
2.38.1.281.g83ef3ded8d

