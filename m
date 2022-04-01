Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2069FC433EF
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 14:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245680AbiDAO2x (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 10:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346979AbiDAO2T (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 10:28:19 -0400
Received: from b-painless.mh.aa.net.uk (b-painless.mh.aa.net.uk [IPv6:2001:8b0:0:30::52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4412856A7
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 07:26:26 -0700 (PDT)
Received: from [195.110.77.193] (helo=red.nvidia.com)
        by painless-b.tch.aa.net.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <jholdsworth@nvidia.com>)
        id 1naIEL-009TW3-9g; Fri, 01 Apr 2022 15:26:24 +0100
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
Subject: [PATCH v5 13/22] git-p4: remove redundant backslash-continuations inside brackets
Date:   Fri,  1 Apr 2022 15:24:55 +0100
Message-Id: <20220401142504.58995-14-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.35.GIT
In-Reply-To: <20220401142504.58995-1-jholdsworth@nvidia.com>
References: <20220401142504.58995-1-jholdsworth@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PEP8 recommends that backslash line continuations should only be used
for line-breaks outside parentheses.

This recommendation is described in the "Maximum Line Length" section:

https://www.python.org/dev/peps/pep-0008/#maximum-line-length

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 862dc4ca00..471a26744a 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2201,13 +2201,13 @@ def applyCommit(self, id):
                 print("  " + self.clientPath)
                 print("")
                 print("To submit, use \"p4 submit\" to write a new description,")
-                print("or \"p4 submit -i <%s\" to use the one prepared by" \
+                print("or \"p4 submit -i <%s\" to use the one prepared by"
                       " \"git p4\"." % fileName)
                 print("You can delete the file \"%s\" when finished." % fileName)
 
                 if self.preserveUser and p4User and not self.p4UserIsMe(p4User):
-                    print("To preserve change ownership by user %s, you must\n" \
-                          "do \"p4 change -f <change>\" after submitting and\n" \
+                    print("To preserve change ownership by user %s, you must\n"
+                          "do \"p4 change -f <change>\" after submitting and\n"
                           "edit the User field.")
                 if pureRenameCopy:
                     print("After submitting, renamed files must be re-synced.")
@@ -2350,7 +2350,7 @@ def exportGitTags(self, gitTags):
             if self.dry_run:
                 print("Would create p4 label %s for tag" % name)
             elif self.prepare_p4_only:
-                print("Not creating p4 label %s for tag due to option" \
+                print("Not creating p4 label %s for tag due to option"
                       " --prepare-p4-only" % name)
             else:
                 p4_write_pipe(["label", "-i"], labelTemplate)
@@ -2515,12 +2515,12 @@ def run(self, args):
         if not self.no_verify:
             try:
                 if not run_git_hook("p4-pre-submit"):
-                    print("\nThe p4-pre-submit hook failed, aborting the submit.\n\nYou can skip " \
-                        "this pre-submission check by adding\nthe command line option '--no-verify', " \
+                    print("\nThe p4-pre-submit hook failed, aborting the submit.\n\nYou can skip "
+                        "this pre-submission check by adding\nthe command line option '--no-verify', "
                         "however,\nthis will also skip the p4-changelist hook as well.")
                     sys.exit(1)
             except Exception as e:
-                print("\nThe p4-pre-submit hook failed, aborting the submit.\n\nThe hook failed "\
+                print("\nThe p4-pre-submit hook failed, aborting the submit.\n\nThe hook failed "
                     "with the error '{0}'".format(e.message))
                 sys.exit(1)
 
@@ -2543,7 +2543,7 @@ def run(self, args):
                 applied.append(commit)
                 if self.prepare_p4_only:
                     if i < last:
-                        print("Processing only the first commit due to option" \
+                        print("Processing only the first commit due to option"
                                 " --prepare-p4-only")
                     break
             else:
@@ -4206,7 +4206,7 @@ def run(self, args):
             if not self.cloneBare:
                 system(["git", "checkout", "-f"])
         else:
-            print('Not checking out any branch, use ' \
+            print('Not checking out any branch, use '
                   '"git checkout -q -b master <branch>"')
 
         # auto-set this variable if invoked with --use-client-spec
-- 
2.35.GIT

