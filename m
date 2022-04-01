Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74178C43217
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 14:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347006AbiDAO24 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 10:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346916AbiDAO2T (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 10:28:19 -0400
Received: from b-painless.mh.aa.net.uk (b-painless.mh.aa.net.uk [IPv6:2001:8b0:0:30::52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666052856BB
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 07:26:29 -0700 (PDT)
Received: from [195.110.77.193] (helo=red.nvidia.com)
        by painless-b.tch.aa.net.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <jholdsworth@nvidia.com>)
        id 1naIEO-009TW3-Fu; Fri, 01 Apr 2022 15:26:27 +0100
From:   Joel Holdsworth <jholdsworth@nvidia.com>
To:     git@vger.kernel.org, Luke Diamand <luke@diamand.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Cc:     Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>,
        Joel Holdsworth <jholdsworth@nvidia.com>
Subject: [PATCH v5 20/22] git-p4: move inline comments to line above
Date:   Fri,  1 Apr 2022 15:25:02 +0100
Message-Id: <20220401142504.58995-21-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.35.GIT
In-Reply-To: <20220401142504.58995-1-jholdsworth@nvidia.com>
References: <20220401142504.58995-1-jholdsworth@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PEP8 recommends that all inline comments should be separated from code
by two spaces, in the "Inline Comments" section:

https://www.python.org/dev/peps/pep-0008/#inline-comments

However, because all instances of these inline comments extended to an
excessive line length, they have been moved onto a seprate line.

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index c003b6246d..524a7a5c99 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1979,7 +1979,9 @@ def get_diff_description(self, editedFiles, filesToAdd, symlinks):
                     for line in f.readlines():
                         newdiff += "+" + line
                 except UnicodeDecodeError:
-                    pass # Found non-text data and skip, since diff description should only include text
+                    # Found non-text data and skip, since diff description
+                    # should only include text
+                    pass
                 f.close()
 
         return (diff + newdiff).replace('\r\n', '\n')
@@ -2975,7 +2977,8 @@ def streamOneP4File(self, file, contents):
             if 'fileSize' in self.stream_file:
                 size = int(self.stream_file['fileSize'])
             else:
-                size = 0 # deleted files don't get a fileSize apparently
+                # Deleted files don't get a fileSize apparently
+                size = 0
             sys.stdout.write('\r%s --> %s (%s)\n' % (
                 file_path, relPath, format_size_human_readable(size)))
             sys.stdout.flush()
@@ -4233,7 +4236,8 @@ def renameBranch(self, branch_name):
         for i in range(0, 1000):
             backup_branch_name = "{0}.{1}".format(branch_name, i)
             if not gitBranchExists(backup_branch_name):
-                gitUpdateRef(backup_branch_name, branch_name) # copy ref to backup
+                # Copy ref to backup
+                gitUpdateRef(backup_branch_name, branch_name)
                 gitDeleteRef(branch_name)
                 found = True
                 print("renamed old unshelve branch to {0}".format(backup_branch_name))
-- 
2.35.GIT

