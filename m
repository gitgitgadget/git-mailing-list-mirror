Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDAFB20248
	for <e@80x24.org>; Wed,  6 Mar 2019 13:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbfCFNFt (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 08:05:49 -0500
Received: from cisrsmtp.univ-lyon1.fr ([134.214.188.146]:60843 "EHLO
        cisrsmtp.univ-lyon1.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbfCFNFt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 08:05:49 -0500
Received: from localhost (localhost [127.0.0.1])
        by cisrsmtp.univ-lyon1.fr (Postfix) with ESMTP id 9A2DBA0158
        for <git@vger.kernel.org>; Wed,  6 Mar 2019 14:05:47 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at cisrsmtp.univ-lyon1.fr
Received: from cisrsmtp.univ-lyon1.fr ([127.0.0.1])
        by localhost (cisrsmtp.univ-lyon1.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SklWutmvkCmr for <git@vger.kernel.org>;
        Wed,  6 Mar 2019 14:05:46 +0100 (CET)
Received: from BEMBX2013-01.univ-lyon1.fr (bembx2013-01.univ-lyon1.fr [134.214.201.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by cisrsmtp.univ-lyon1.fr (Postfix) with ESMTPS id 997EBA00AD
        for <git@vger.kernel.org>; Wed,  6 Mar 2019 14:05:46 +0100 (CET)
Received: from Corentin-Linux.lan (134.214.126.172) by
 BEMBX2013-01.univ-lyon1.fr (134.214.201.247) with Microsoft SMTP Server (TLS)
 id 15.0.1263.5; Wed, 6 Mar 2019 14:05:44 +0100
From:   Corentin BOMPARD <corentin.bompard@etu.univ-lyon1.fr>
To:     <git@vger.kernel.org>
CC:     <corentin.bompard@etu.univ-lyon1.fr>,
        <nathan.berbezier@etu.univ-lyon1.fr>,
        <pablo.chabanne@etu.univ-lyon1.fr>, <matthieu.moy@univ-lyon1.fr>
Subject: [PATCH 1/2 v3] doc/CodingGuidelines: URLs and paths as monospace.
Date:   Wed, 6 Mar 2019 14:04:45 +0100
Message-ID: <20190306130446.2193-1-corentin.bompard@etu.univ-lyon1.fr>
X-Mailer: git-send-email 2.21.0-rc0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [134.214.126.172]
X-ClientProxiedBy: BPMBX2013-01.univ-lyon1.fr (134.214.201.243) To
 BEMBX2013-01.univ-lyon1.fr (134.214.201.247)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The current documentation uses both quotes (italics) and backquotes
(monospace) to render URLs and pathnames, which is inconsistant.
Document a best practice in CodingGuidelines to help reduce
inconsistencies in the futur.

We set the best practice to using backquotes, since:

* It is already an established practice. For exemple:

  $ git grep "'[^']/*[^']'" | wc -l
  206

  $ git grep '`[^`]/*[^`]`' | wc -l
  690

  There are false on both sides, but after a cursory look at the
  output of both, It doesn't seem the false positive rate is really
  higher in the second case.

  At least, this shows that the existing documentation uses
  inconsistent formatting, and that it would be good to do
  something about it.

* It may be debatable whether path names need to be typed in
  monospace but having them in italics is really unusual.

Signed-off-by: Corentin BOMPARD <corentin.bompard@etu.univ-lyon1.fr>
Signed-off-by: Nathan BERBEZIER <nathan.berbezier@etu.univ-lyon1.fr>
Signed-off-by: Pablo CHABANNE <pablo.chabanne@etu.univ-lyon1.fr>
Signed-off-by: Matthieu MOY <matthieu.moy@univ-lyon1.fr>
---
 Changes: According to Matthieu MOY we added a new guideline in
 Documentation/CodingGuidelines.txt about monospace.

 Documentation/CodingGuidelines | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 857953071..0baff9dbe 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -580,11 +580,14 @@ Writing Documentation:
  or commands:
 
  Literal examples (e.g. use of command-line options, command names,
- branch names, configuration and environment variables) must be
- typeset in monospace (i.e. wrapped with backticks):
+ branch names, URLs, pathnames (files and directories), configuration and
+ environment variables) must be typeset in monospace (i.e. wrapped with 
+ backticks):
    `--pretty=oneline`
    `git rev-list`
    `remote.pushDefault`
+   `http://git.example.com`
+   `.git/config`
    `GIT_DIR`
    `HEAD`
 
-- 
2.21.0-rc0

