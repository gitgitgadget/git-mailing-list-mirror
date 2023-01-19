Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FA5C6379F
	for <git@archiver.kernel.org>; Thu, 19 Jan 2023 18:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjASSUB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Jan 2023 13:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjASSTl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2023 13:19:41 -0500
Received: from smtp-out-2.talktalk.net (smtp-out-2.talktalk.net [62.24.135.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E292B29B
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 10:19:38 -0800 (PST)
Received: from localhost.localdomain ([88.110.98.79])
        by smtp.talktalk.net with SMTP
        id IZUipjyTdLVi2IZUipC7TN; Thu, 19 Jan 2023 18:18:37 +0000
X-Originating-IP: [88.110.98.79]
X-Spam: 0
X-OAuthority: v=2.3 cv=H8GlPNQi c=1 sm=1 tr=0 a=qs8Jj6vsB7NiZ+3IlNxB6Q==:117
 a=qs8Jj6vsB7NiZ+3IlNxB6Q==:17 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10
 a=ldyaYNNxDcoA:10 a=maobgtrrHKCnxS5SnIYA:9
From:   Philip Oakley <philipoakley@iee.email>
To:     GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>,
        self <philipoakley@iee.email>
Subject: [PATCH v5 2/5] doc: pretty-formats: delineate `%<|(` parameter values
Date:   Thu, 19 Jan 2023 18:18:24 +0000
Message-Id: <20230119181827.1319-3-philipoakley@iee.email>
X-Mailer: git-send-email 2.39.1.windows.1
In-Reply-To: <20230119181827.1319-1-philipoakley@iee.email>
References: <20221112143616.1429-1-philipoakley@iee.email>
 <20230119181827.1319-1-philipoakley@iee.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfKjmWDDidILLRDqZI4JfqPxXhx1+6DJpE85VAVVwD/HbvHJ9KCP5dEd4rs3ON1QiHRtNnO0KWF7JDsrMj8EIKCFRV60EB5PXpVJk71yxiBwbkthTJaQ0
 vGbc5Jgpyg4zXpzDbBzic7zkMun3QwdKEHaHB3W1ysYb/+1BXRsGAIK6bkvSl+/W1uVZnuJnqwIh70TozmxCrNfLooxpBwAOHH0YY7piZJbc3ZFxf7aedb53
 Jpdfl8lR9nlGMvIoM3CThr9JnXA/7CKMPphE1Stg1BgVA8X26m74YEYEiBqTKIXL+dmhuswhYjHErc9UWgdkhw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit a57523428b4 (pretty: support padding placeholders, %< %> and %><,
2013-04-19) introduced column width place holders. It also added
separate column position `%<|(` placeholders for display screen based
placement.

Change the display screen parameter reference from 'N' to 'M' and
corresponding descriptives to make the distinction clearer.

Signed-off-by: Philip Oakley <philipoakley@iee.email>
---
 Documentation/pretty-formats.txt | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 02bec23509..8cc1072196 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -147,7 +147,7 @@ The placeholders are:
 '%w([<w>[,<i1>[,<i2>]]])':: switch line wrapping, like the -w option of
 			    linkgit:git-shortlog[1].
 '%<( <N> [,trunc|ltrunc|mtrunc])':: make the next placeholder take at
-				  least N columns, padding spaces on
+				  least N column widths, padding spaces on
 				  the right if necessary.  Optionally
 				  truncate at the beginning (ltrunc),
 				  the middle (mtrunc) or the end
@@ -155,18 +155,18 @@ The placeholders are:
 				  N columns.
 				  Note 1: that truncating
 				  only works correctly with N >= 2.
-				  Note 2: spaces around the N
+				  Note 2: spaces around the N and M (see below)
 				  values are optional.
-'%<|( <N> )':: make the next placeholder take at least until Nth
-	     columns, padding spaces on the right if necessary
-'%>( <N> )', '%>|( <N> )':: similar to '%<( <N> )', '%<|( <N> )' respectively,
+'%<|( <M> )':: make the next placeholder take at least until Mth
+	     display column, padding spaces on the right if necessary
+'%>( <N> )', '%>|( <M> )':: similar to '%<( <N> )', '%<|( <M> )' respectively,
 			but padding spaces on the left
-'%>>( <N> )', '%>>|( <N> )':: similar to '%>( <N> )', '%>|( <N> )'
+'%>>( <N> )', '%>>|( <M> )':: similar to '%>( <N> )', '%>|( <M> )'
 			  respectively, except that if the next
 			  placeholder takes more spaces than given and
 			  there are spaces on its left, use those
 			  spaces
-'%><( <N> )', '%><|( <N> )':: similar to '%<( <N> )', '%<|( <N> )'
+'%><( <N> )', '%><|( <M> )':: similar to '%<( <N> )', '%<|( <M> )'
 			  respectively, but padding both sides
 			  (i.e. the text is centered)
 
-- 
2.39.1.windows.1

