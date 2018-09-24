Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8E7F1F453
	for <e@80x24.org>; Mon, 24 Sep 2018 22:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbeIYEhQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 00:37:16 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:32648 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbeIYEhQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 00:37:16 -0400
Received: from localhost.localdomain ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id 4ZHUgIql1oI6L4ZHVgLKqc; Mon, 24 Sep 2018 23:24:42 +0100
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.3 cv=FOE1Odgs c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=5rxgeBVgAAAA:8 a=S6JmO2vaAAAA:8
 a=xtxXYLxNAAAA:8 a=5qj-N4dWq4Iw6-1wYJYA:9 a=PwKx63F5tFurRwaNxrlG:22
 a=9Bf777meHY6sFTcdLnoB:22 a=xts0dhWdiJbonKbuqhAr:22
From:   Philip Oakley <philipoakley@iee.org>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Philip Oakley <philipoakley@iee.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        stas@stason.org
Subject: [PATCH 1/1] config doc: highlight the name=value syntax
Date:   Mon, 24 Sep 2018 23:24:16 +0100
Message-Id: <20180924222416.5240-2-philipoakley@iee.org>
X-Mailer: git-send-email 2.19.0.windows.1
In-Reply-To: <29173fd8-ce72-0927-9bfe-786442dfd82c@stason.org>
References: <29173fd8-ce72-0927-9bfe-786442dfd82c@stason.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfEia0+iW21EouvnpbrqXaq1l+35QZoDfoN49FcVUYpFNxkd6JwRPZXK7Id2jsG/zNyK4PRg5nhRy1bZPSz+CfyrBmG0j7+aG1fl5oXRL81PKIQVyfFiK
 ayLuiKnLf9zDJvdi5iaIvrj18nHW/sFdi9srAwIUgx0gLvAjbiXjri1iKdHBfZr9MWrGcfxaM7pKDWVfJR//luAYAawHYlF8MCeYrQbcU+ctq4arHawTmfqA
 mudbWp1/djJDdXqF79JyVbaI4wYHkv/9PwG7ZyhO9ZapEu+WoP4Fj6+z4houMYcmkFKeWkqkARuFiWHKOd3IHreTs33x5x53utf98r3sriJ4+JySBUENj967
 tgB8CfMp
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stas Bekman reported [1] that Git config was not accepting single quotes
around a filename as may have been expected by shell users.

Highlight the 'name = value' syntax with its own heading. Clarify that
single quotes are not special here. Also point to this paragraph in the
'include' section regarding pathnames.

In addition clarify that missing include file paths are not an error, but
rather an implicit 'if found' for include files.

[1] https://public-inbox.org/git/ca2b192e-1722-092e-2c54-d79d21a66ba2@stason.org/

Reported-by: Stas Bekman <stas@stason.org>
Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 Documentation/config.txt | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1264d91fa3..b65fd6138d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -19,8 +19,8 @@ characters and `-`, and must start with an alphabetic character.  Some
 variables may appear multiple times; we say then that the variable is
 multivalued.
 
-Syntax
-~~~~~~
+Config file Syntax
+~~~~~~~~~~~~~~~~~~
 
 The syntax is fairly flexible and permissive; whitespaces are mostly
 ignored.  The '#' and ';' characters begin comments to the end of line,
@@ -56,6 +56,9 @@ syntax, the subsection name is converted to lower-case and is also
 compared case sensitively. These subsection names follow the same
 restrictions as section names.
 
+Variable name/value syntax
+^^^^^^^^^^^^^^^^^^^^^^^^^^
+
 All the other lines (and the remainder of the line after the section
 header) are recognized as setting variables, in the form
 'name = value' (or just 'name', which is a short-hand to say that
@@ -69,7 +72,8 @@ stripped.  Leading whitespaces after 'name =', the remainder of the
 line after the first comment character '#' or ';', and trailing
 whitespaces of the line are discarded unless they are enclosed in
 double quotes.  Internal whitespaces within the value are retained
-verbatim.
+verbatim. Single quotes are not special and form part of the
+variable's value.
 
 Inside double quotes, double quote `"` and backslash `\` characters
 must be escaped: use `\"` for `"` and `\\` for `\`.
@@ -89,10 +93,14 @@ each other with the exception that `includeIf` sections may be ignored
 if their condition does not evaluate to true; see "Conditional includes"
 below.
 
+Both the `include` and `includeIf` sections implicitly apply an 'if found'
+condition to the given path names.
+
 You can include a config file from another by setting the special
 `include.path` (or `includeIf.*.path`) variable to the name of the file
 to be included. The variable takes a pathname as its value, and is
-subject to tilde expansion. These variables can be given multiple times.
+subject to tilde expansion and the value syntax detailed above.
+These variables can be given multiple times.
 
 The contents of the included file are inserted immediately, as if they
 had been found at the location of the include directive. If the value of the
-- 
2.17.1.windows.2

