Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B340C636D4
	for <git@archiver.kernel.org>; Fri,  3 Feb 2023 12:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjBCM7e (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Feb 2023 07:59:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbjBCM7d (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2023 07:59:33 -0500
Received: from smtp-out-4.talktalk.net (smtp-out-4.talktalk.net [62.24.135.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0894DA267
        for <git@vger.kernel.org>; Fri,  3 Feb 2023 04:59:31 -0800 (PST)
Received: from localhost.localdomain ([2.103.194.72])
        by smtp.talktalk.net with SMTP
        id Nvf7pDW65rEXiNvf7pgeCO; Fri, 03 Feb 2023 12:59:29 +0000
X-Originating-IP: [2.103.194.72]
X-Spam: 0
X-OAuthority: v=2.3 cv=TbToSiYh c=1 sm=1 tr=0 a=Qehj7yZWyyqKOS66vkBoiw==:117
 a=Qehj7yZWyyqKOS66vkBoiw==:17 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10
 a=ldyaYNNxDcoA:10 a=VwQbUJbxAAAA:8 a=71sI7BlFOM1_F5eSxv0A:9
 a=AjGcO6oz07-iQ99wixmX:22
From:   Philip Oakley <philipoakley@iee.email>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Self <philipoakley@iee.email>
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Sixt <j6t@kdbg.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH] .gitattributes: include `text` attribute for eol attributes
Date:   Fri,  3 Feb 2023 12:59:20 +0000
Message-Id: <20230203125920.751-1-philipoakley@iee.email>
X-Mailer: git-send-email 2.39.0.rc1.windows.1.334.ge370b595619
In-Reply-To: <20220216115239.uo2ie3flaqo3nf2d@tb-raspi4>
References: <20220216115239.uo2ie3flaqo3nf2d@tb-raspi4>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfOIdtiYDkyTO8BpJQv+/DvmyfWj97hn1T8Jj6hVkDPpWjlKxZ5l0iZLFgyY+UF8DbSSgKbxMARbqy3lHO4sTcJSoxwj4qel7Eo0Evzp3oXECF+qRImoI
 aRMrkj/Ms3r5TF5FEVgZh6SJqJj8aySI3BEgBa+u8F+P3mJvDAa9xy9EhNXvWtTD5Sw+FmExzD1rm5g/1LA3ceAlJ1ZZhsgMpWAee++uW72ebbiK1VVcKJ6E
 N8npOW49QBRYr+V8U5OXqDsn2OVueGcAXtg3D7w8V5eF1GoLjXkb3Uo5dph8LVWS2M1qPqzbTaaCKdd0rN0ERX4KOGBoxuhy3yjZW1RbrRM=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The standard advice for text file eol endings in the .gitattributes file
was updated in e28eae3184 (gitattributes: Document the unified "auto"
handling, 2016-08-26) with a recent clarification in 8c591dbfce (docs:
correct documentation about eol attribute, 2022-01-11), with a follow
up comment by the original author in [1] confirming the use of the eol
attribute in conjunction with the text attribute.

Update Git's .gitattributes file to reflect our own advice.

[1] https://lore.kernel.org/git/?q=%3C20220216115239.uo2ie3flaqo3nf2d%40tb-raspi4%3E.

Signed-off-by: Philip Oakley <philipoakley@iee.email>
---

I was catching up on last year's back emails, and had saved those on
eol and text conversion, and was prompted by Torsten's [1] to check
my .gitattribute files, only to discover, we aren't providing a good
example to others. Let's fix that. 


 .gitattributes | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/.gitattributes b/.gitattributes
index b0044cf272..158c3d45c4 100644
--- a/.gitattributes
+++ b/.gitattributes
@@ -1,17 +1,17 @@
 * whitespace=!indent,trail,space
 *.[ch] whitespace=indent,trail,space diff=cpp
-*.sh whitespace=indent,trail,space eol=lf
-*.perl eol=lf diff=perl
-*.pl eof=lf diff=perl
-*.pm eol=lf diff=perl
-*.py eol=lf diff=python
-*.bat eol=crlf
+*.sh whitespace=indent,trail,space text eol=lf
+*.perl text eol=lf diff=perl
+*.pl text eof=lf diff=perl
+*.pm text eol=lf diff=perl
+*.py text eol=lf diff=python
+*.bat text eol=crlf
 CODE_OF_CONDUCT.md -whitespace
-/Documentation/**/*.txt eol=lf
-/command-list.txt eol=lf
-/GIT-VERSION-GEN eol=lf
-/mergetools/* eol=lf
-/t/oid-info/* eol=lf
+/Documentation/**/*.txt text eol=lf
+/command-list.txt text eol=lf
+/GIT-VERSION-GEN text eol=lf
+/mergetools/* text eol=lf
+/t/oid-info/* text eol=lf
 /Documentation/git-merge.txt conflict-marker-size=32
 /Documentation/gitk.txt conflict-marker-size=32
 /Documentation/user-manual.txt conflict-marker-size=32
-- 
2.39.1.windows.1

