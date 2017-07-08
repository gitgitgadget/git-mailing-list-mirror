Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C7AE202AC
	for <e@80x24.org>; Sat,  8 Jul 2017 20:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751109AbdGHUkE (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Jul 2017 16:40:04 -0400
Received: from mail.eclipso.de ([217.69.254.104]:48984 "EHLO mail.eclipso.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751023AbdGHUkE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jul 2017 16:40:04 -0400
Received: from localhost.localdomain (136.ip-92-222-84.eu [92.222.84.136])
        by mail.eclipso.de with ESMTPS id 543297C0
        for <git@vger.kernel.org>; Sat, 08 Jul 2017 22:34:59 +0200 (CEST)
X-ESMTP-Authenticated-User: 00022B69
From:   astian <astian@eclipso.at>
To:     git@vger.kernel.org
Cc:     astian <astian@eclipso.at>
Subject: [PATCH 1/4] Doc/config.txt: explain repeated sections
Date:   Sat,  8 Jul 2017 20:34:10 +0000
Message-Id: <20170708203413.16442-2-astian@eclipso.at>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20170708203413.16442-1-astian@eclipso.at>
References: <20170708203413.16442-1-astian@eclipso.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a paragraph explaining what happens when a section name is repeated
in the configuration file(s).

The example configuration file shown in this document already implied
Git's behaviour, this patch simply tries to make it explicit.

Signed-off-by: astian <astian@eclipso.at>
---
 Documentation/config.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d5c9c4cab..afce25705 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -31,6 +31,10 @@ characters, `-` and `.` are allowed in section names.  Each variable
 must belong to some section, which means that there must be a section
 header before the first setting of a variable.
 
+Multiple occurrences of the same section are all logically merged.  (There's
+no special treatment for variables defined multiple times across physically
+different sections, the variable is simply made multivalued.)
+
 Sections can be further divided into subsections.  To begin a subsection
 put its name in double quotes, separated by space from the section name,
 in the section header, like in the example below:
-- 
2.13.2



