Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810C2C43219
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 14:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347008AbiDAO2c (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 10:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346960AbiDAO2T (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 10:28:19 -0400
Received: from b-painless.mh.aa.net.uk (b-painless.mh.aa.net.uk [IPv6:2001:8b0:0:30::52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB31282B1D
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 07:26:25 -0700 (PDT)
Received: from [195.110.77.193] (helo=red.nvidia.com)
        by painless-b.tch.aa.net.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <jholdsworth@nvidia.com>)
        id 1naIEK-009TW3-RA; Fri, 01 Apr 2022 15:26:24 +0100
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
Subject: [PATCH v5 12/22] git-p4: remove extraneous spaces before function arguments
Date:   Fri,  1 Apr 2022 15:24:54 +0100
Message-Id: <20220401142504.58995-13-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.35.GIT
In-Reply-To: <20220401142504.58995-1-jholdsworth@nvidia.com>
References: <20220401142504.58995-1-jholdsworth@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PEP8 recommends that there should be no spaces before function arguments
in the in the "Pet Peeves" section:

https://www.python.org/dev/peps/pep-0008/#pet-peeves

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index c9081d79ac..862dc4ca00 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -911,16 +911,16 @@ def extractSettingsGitLog(log):
     values = {}
     for line in log.split("\n"):
         line = line.strip()
-        m = re.search (r"^ *\[git-p4: (.*)\]$", line)
+        m = re.search(r"^ *\[git-p4: (.*)\]$", line)
         if not m:
             continue
 
-        assignments = m.group(1).split (':')
+        assignments = m.group(1).split(':')
         for a in assignments:
-            vals = a.split ('=')
+            vals = a.split('=')
             key = vals[0].strip()
-            val = ('='.join (vals[1:])).strip()
-            if val.endswith ('\"') and val.startswith('"'):
+            val = ('='.join(vals[1:])).strip()
+            if val.endswith('\"') and val.startswith('"'):
                 val = val[1:-1]
 
             values[key] = val
@@ -2275,9 +2275,9 @@ def applyCommit(self, id):
             # Revert changes if we skip this patch
             if not submitted or self.shelve:
                 if self.shelve:
-                    print ("Reverting shelved files.")
+                    print("Reverting shelved files.")
                 else:
-                    print ("Submission cancelled, undoing p4 changes.")
+                    print("Submission cancelled, undoing p4 changes.")
                 sys.stdout.flush()
                 for f in editedFiles | filesToDelete:
                     p4_revert(f)
@@ -3948,7 +3948,7 @@ def run(self, args):
                                     i = i - 1
                                     break
 
-                            paths.append ("/".join(cur_list[:i + 1]))
+                            paths.append("/".join(cur_list[:i + 1]))
 
                         self.previousDepotPaths = paths
 
@@ -3977,8 +3977,8 @@ def run(self, args):
         else:
             if self.depotPaths and self.depotPaths != args:
                 print("previous import used depot path %s and now %s was specified. "
-                       "This doesn't work!" % (' '.join (self.depotPaths),
-                                               ' '.join (args)))
+                       "This doesn't work!" % (' '.join(self.depotPaths),
+                                               ' '.join(args)))
                 sys.exit(1)
 
             self.depotPaths = sorted(args)
@@ -4018,7 +4018,7 @@ def run(self, args):
                 if len(self.changesFile) == 0:
                     revision = "#head"
 
-            p = re.sub ("\.\.\.$", "", p)
+            p = re.sub("\.\.\.$", "", p)
             if not p.endswith("/"):
                 p += "/"
 
-- 
2.35.GIT

