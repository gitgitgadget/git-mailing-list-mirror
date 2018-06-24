Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E7D91F516
	for <e@80x24.org>; Sun, 24 Jun 2018 10:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751999AbeFXKo2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Jun 2018 06:44:28 -0400
Received: from smtprelay06.ispgateway.de ([80.67.18.29]:41583 "EHLO
        smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751596AbeFXKo1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jun 2018 06:44:27 -0400
Received: from [91.113.179.170] (helo=[192.168.92.26])
        by smtprelay06.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <marc.strapetz@syntevo.com>)
        id 1fX2VM-00082m-M4; Sun, 24 Jun 2018 12:44:24 +0200
From:   Marc Strapetz <marc.strapetz@syntevo.com>
Subject: [PATCH v2] Documentation: declare "core.ignorecase" as internal
 variable
To:     git@vger.kernel.org
References: <7f6b2a42-334d-9443-7b89-625069931ca7@syntevo.com>
Cc:     sunshine@sunshineco.com
Message-ID: <aa841316-5fc0-b69b-a3d0-15911b0776f4@syntevo.com>
Date:   Sun, 24 Jun 2018 12:44:26 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <7f6b2a42-334d-9443-7b89-625069931ca7@syntevo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-Df-Sender: bWFyYy5zdHJhcGV0ekBzeW50ZXZvLmNvbQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The current description of "core.ignoreCase" reads like an option which
is intended to be changed by the user while it's actually expected to
be set by Git on initialization only. This is especially important for
Git for Windows, as noted by Bryan Turner [1]:

     Git on Windows is not designed to run with anything other than
     core.ignoreCase=true, and attempting to do so will cause
     unexpected behavior. In other words, it's not a behavior toggle so
     user's can request the functionality to work one way or the other;
     it's an implementation detail that `git init` and `git clone` set
     when a repository is created purely so they don't have to probe
     the file system each time you run a `git` command.

[1] https://marc.info/?l=git&m=152972992729761&w=2

Signed-off-by: Marc Strapetz <marc.strapetz@syntevo.com>
---
  Documentation/config.txt | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ab641bf5a..c25693828 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -390,7 +390,7 @@ core.hideDotFiles::
  	default mode is 'dotGitOnly'.

  core.ignoreCase::
-	If true, this option enables various workarounds to enable
+	Internal variable which enables various workarounds to enable
  	Git to work better on filesystems that are not case sensitive,
  	like FAT. For example, if a directory listing finds
  	"makefile" when Git expects "Makefile", Git will assume
@@ -399,7 +399,7 @@ core.ignoreCase::
  +
  The default is false, except linkgit:git-clone[1] or linkgit:git-init[1]
  will probe and set core.ignoreCase true if appropriate when the repository
-is created.
+is created. Modifying this value afterwards may result in unexpected 
behavior.

  core.precomposeUnicode::
  	This option is only used by Mac OS implementation of Git.
-- 
2.17.0.rc0.3.gb1b5a51b2
