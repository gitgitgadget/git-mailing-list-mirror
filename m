Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 112371F403
	for <e@80x24.org>; Tue, 19 Jun 2018 08:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965150AbeFSIEw (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 04:04:52 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38552 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756452AbeFSIE1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 04:04:27 -0400
Received: by mail-wm0-f66.google.com with SMTP id 69-v6so20199678wmf.3
        for <git@vger.kernel.org>; Tue, 19 Jun 2018 01:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VmpBQTzJNl52uA0Svpw5+gReN7tXEo0gwGatqju4ckQ=;
        b=RHo2cCDT48xnn2xEN30YBrrtburE1etMMFl16gMmETb3orqpPjownK9GNSsGh0Ifcj
         vxvA0b4HQqP/uNVzXMXw1WYXuN8UaVsIAf5LwLlG2Lx3jp9gOlTcDe5JXKkMnhYIQqJB
         qF7WR8kaHzDLUm14M2JWGKNeE4v3oWe3bKzeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VmpBQTzJNl52uA0Svpw5+gReN7tXEo0gwGatqju4ckQ=;
        b=nn3OzmRt+CtYW4VenuQd+LNRmysVQfSkn4vizkADdHZ/cGKeMivNSN82Exa2sTIUlQ
         EEF8I9pheDbTMYp2Kj9r6smHE+p3wt2uH3C08T3NOc6JYFgqLKNsMpEdOpLsRTAyu9EE
         gTeXU8dtpuKdQYu3jfpER8MWsK1oYejhMDCBIDEgDIP38ka7khdx+XBXP52h79B5seev
         F5fe2Kjr2M9wckvSIVVlpLuVYgwmicU7904rrtu0abpDLyHYhgmrmovnGW+QUXelIouj
         tQUxbEQnRP+Tn6vti1LKwEVn2ynocL/EZ7JGTSJ8slWq0grcWUtQ6DS3jFuONetnw7J6
         FCqg==
X-Gm-Message-State: APt69E1qOPxDb+vTOpb075sL2gLExmt8EAk6JX3PIh9YB9hYx9x6iy3K
        qsKJXisz1j0kR9vb5cmhIK209seZ
X-Google-Smtp-Source: ADUXVKLJivsoHVZa8WbBtaH58HsgQlSqaRxe4vmOPpVnk6fHP+TFTlcI57wd6P2Z8V13jto2GVD5kw==
X-Received: by 2002:a1c:228b:: with SMTP id i133-v6mr11601978wmi.92.1529395464157;
        Tue, 19 Jun 2018 01:04:24 -0700 (PDT)
Received: from ethel.corp.roku (cpc92728-cmbg20-2-0-cust351.5-4.cable.virginm.net. [82.29.15.96])
        by smtp.gmail.com with ESMTPSA id r2-v6sm12757215wmb.39.2018.06.19.01.04.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 01:04:23 -0700 (PDT)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Romain Merland <merlorom@yahoo.fr>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Lex Spoon <lex@lexspoon.org>,
        Andrey Mazo <amazo@checkvideo.com>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCH 5/6] git-p4: python3: use print() function
Date:   Tue, 19 Jun 2018 09:04:10 +0100
Message-Id: <20180619080411.6554-6-luke@diamand.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a
In-Reply-To: <20180619080411.6554-5-luke@diamand.org>
References: <20180619080411.6554-1-luke@diamand.org>
 <20180619080411.6554-2-luke@diamand.org>
 <20180619080411.6554-3-luke@diamand.org>
 <20180619080411.6554-4-luke@diamand.org>
 <20180619080411.6554-5-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace calls to print ... with the function form, print(...), to
allow use with python3 as well as python2.x.

Converted using 2to3 (and some hand-editing).

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 git-p4.py | 248 +++++++++++++++++++++++++++---------------------------
 1 file changed, 124 insertions(+), 124 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index f127ebce27..714e442d7c 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -892,7 +892,7 @@ def findUpstreamBranchPoint(head = "HEAD"):
 
 def createOrUpdateBranchesFromOrigin(localRefPrefix = "refs/remotes/p4/", silent=True):
     if not silent:
-        print ("Creating/updating branch(es) in %s based on origin branch(es)"
+        print("Creating/updating branch(es) in %s based on origin branch(es)"
                % localRefPrefix)
 
     originPrefix = "origin/p4/"
@@ -914,7 +914,7 @@ def createOrUpdateBranchesFromOrigin(localRefPrefix = "refs/remotes/p4/", silent
         update = False
         if not gitBranchExists(remoteHead):
             if verbose:
-                print "creating %s" % remoteHead
+                print("creating %s" % remoteHead)
             update = True
         else:
             settings = extractSettingsGitLog(extractLogMessageFromGitCommit(remoteHead))
@@ -923,13 +923,13 @@ def createOrUpdateBranchesFromOrigin(localRefPrefix = "refs/remotes/p4/", silent
                     originP4Change = int(original['change'])
                     p4Change = int(settings['change'])
                     if originP4Change > p4Change:
-                        print ("%s (%s) is newer than %s (%s). "
+                        print("%s (%s) is newer than %s (%s). "
                                "Updating p4 branch from origin."
                                % (originHead, originP4Change,
                                   remoteHead, p4Change))
                         update = True
                 else:
-                    print ("Ignoring: %s was imported from %s while "
+                    print("Ignoring: %s was imported from %s while "
                            "%s was imported from %s"
                            % (originHead, ','.join(original['depot-paths']),
                               remoteHead, ','.join(settings['depot-paths'])))
@@ -1397,9 +1397,9 @@ def __init__(self):
     def run(self, args):
         j = 0
         for output in p4CmdList(args):
-            print 'Element: %d' % j
+            print('Element: %d' % j)
             j += 1
-            print output
+            print(output)
         return True
 
 class P4RollBack(Command):
@@ -1440,14 +1440,14 @@ def run(self, args):
 
                 if len(p4Cmd("changes -m 1 "  + ' '.join (['%s...@%s' % (p, maxChange)
                                                            for p in depotPaths]))) == 0:
-                    print "Branch %s did not exist at change %s, deleting." % (ref, maxChange)
+                    print("Branch %s did not exist at change %s, deleting." % (ref, maxChange))
                     system("git update-ref -d %s `git rev-parse %s`" % (ref, ref))
                     continue
 
                 while change and int(change) > maxChange:
                     changed = True
                     if self.verbose:
-                        print "%s is at %s ; rewinding towards %s" % (ref, change, maxChange)
+                        print("%s is at %s ; rewinding towards %s" % (ref, change, maxChange))
                     system("git update-ref %s \"%s^\"" % (ref, ref))
                     log = extractLogMessageFromGitCommit(ref)
                     settings =  extractSettingsGitLog(log)
@@ -1457,7 +1457,7 @@ def run(self, args):
                     change = settings['change']
 
                 if changed:
-                    print "%s rewound to %s" % (ref, change)
+                    print("%s rewound to %s" % (ref, change))
 
         return True
 
@@ -1593,10 +1593,10 @@ def patchRCSKeywords(self, file, pattern):
         except:
             # cleanup our temporary file
             os.unlink(outFileName)
-            print "Failed to strip RCS keywords in %s" % file
+            print("Failed to strip RCS keywords in %s" % file)
             raise
 
-        print "Patched up RCS keywords in %s" % file
+        print("Patched up RCS keywords in %s" % file)
 
     def p4UserForCommit(self,id):
         # Return the tuple (perforce user,git email) for a given git commit id
@@ -1616,7 +1616,7 @@ def checkValidP4Users(self,commits):
             if not user:
                 msg = "Cannot find p4 user for email %s in commit %s." % (email, id)
                 if gitConfigBool("git-p4.allowMissingP4Users"):
-                    print "%s" % msg
+                    print("%s" % msg)
                 else:
                     die("Error: %s\nSet git-p4.allowMissingP4Users to true to allow this." % msg)
 
@@ -1808,8 +1808,8 @@ def get_diff_description(self, editedFiles, filesToAdd, symlinks):
     def applyCommit(self, id):
         """Apply one commit, return True if it succeeded."""
 
-        print "Applying", read_pipe(["git", "show", "-s",
-                                     "--format=format:%h %s", id])
+        print("Applying", read_pipe(["git", "show", "-s",
+                                     "--format=format:%h %s", id]))
 
         (p4User, gitEmail) = self.p4UserForCommit(id)
 
@@ -1899,7 +1899,7 @@ def applyCommit(self, id):
         if os.system(tryPatchCmd) != 0:
             fixed_rcs_keywords = False
             patch_succeeded = False
-            print "Unfortunately applying the change failed!"
+            print("Unfortunately applying the change failed!")
 
             # Patch failed, maybe it's just RCS keyword woes. Look through
             # the patch to see if that's possible.
@@ -1917,13 +1917,13 @@ def applyCommit(self, id):
                         for line in read_pipe_lines(["git", "diff", "%s^..%s" % (id, id), file]):
                             if regexp.search(line):
                                 if verbose:
-                                    print "got keyword match on %s in %s in %s" % (pattern, line, file)
+                                    print("got keyword match on %s in %s in %s" % (pattern, line, file))
                                 kwfiles[file] = pattern
                                 break
 
                 for file in kwfiles:
                     if verbose:
-                        print "zapping %s with %s" % (line,pattern)
+                        print("zapping %s with %s" % (line,pattern))
                     # File is being deleted, so not open in p4.  Must
                     # disable the read-only bit on windows.
                     if self.isWindows and file not in editedFiles:
@@ -1932,7 +1932,7 @@ def applyCommit(self, id):
                     fixed_rcs_keywords = True
 
             if fixed_rcs_keywords:
-                print "Retrying the patch with RCS keywords cleaned up"
+                print("Retrying the patch with RCS keywords cleaned up")
                 if os.system(tryPatchCmd) == 0:
                     patch_succeeded = True
 
@@ -2000,34 +2000,34 @@ def applyCommit(self, id):
             # Leave the p4 tree prepared, and the submit template around
             # and let the user decide what to do next
             #
-            print
-            print "P4 workspace prepared for submission."
-            print "To submit or revert, go to client workspace"
-            print "  " + self.clientPath
-            print
-            print "To submit, use \"p4 submit\" to write a new description,"
-            print "or \"p4 submit -i <%s\" to use the one prepared by" \
-                  " \"git p4\"." % fileName
-            print "You can delete the file \"%s\" when finished." % fileName
+            print()
+            print("P4 workspace prepared for submission.")
+            print("To submit or revert, go to client workspace")
+            print("  " + self.clientPath)
+            print()
+            print("To submit, use \"p4 submit\" to write a new description,")
+            print("or \"p4 submit -i <%s\" to use the one prepared by" \
+                  " \"git p4\"." % fileName)
+            print("You can delete the file \"%s\" when finished." % fileName)
 
             if self.preserveUser and p4User and not self.p4UserIsMe(p4User):
-                print "To preserve change ownership by user %s, you must\n" \
+                print("To preserve change ownership by user %s, you must\n" \
                       "do \"p4 change -f <change>\" after submitting and\n" \
-                      "edit the User field."
+                      "edit the User field.")
             if pureRenameCopy:
-                print "After submitting, renamed files must be re-synced."
-                print "Invoke \"p4 sync -f\" on each of these files:"
+                print("After submitting, renamed files must be re-synced.")
+                print("Invoke \"p4 sync -f\" on each of these files:")
                 for f in pureRenameCopy:
-                    print "  " + f
+                    print("  " + f)
 
-            print
-            print "To revert the changes, use \"p4 revert ...\", and delete"
-            print "the submit template file \"%s\"" % fileName
+            print()
+            print("To revert the changes, use \"p4 revert ...\", and delete")
+            print("the submit template file \"%s\"" % fileName)
             if filesToAdd:
-                print "Since the commit adds new files, they must be deleted:"
+                print("Since the commit adds new files, they must be deleted:")
                 for f in filesToAdd:
-                    print "  " + f
-            print
+                    print("  " + f)
+            print()
             return True
 
         #
@@ -2094,7 +2094,7 @@ def exportGitTags(self, gitTags):
 
             if not m.match(name):
                 if verbose:
-                    print "tag %s does not match regexp %s" % (name, validLabelRegexp)
+                    print("tag %s does not match regexp %s" % (name, validLabelRegexp))
                 continue
 
             # Get the p4 commit this corresponds to
@@ -2104,7 +2104,7 @@ def exportGitTags(self, gitTags):
             if 'change' not in values:
                 # a tag pointing to something not sent to p4; ignore
                 if verbose:
-                    print "git tag %s does not give a p4 commit" % name
+                    print("git tag %s does not give a p4 commit" % name)
                 continue
             else:
                 changelist = values['change']
@@ -2139,10 +2139,10 @@ def exportGitTags(self, gitTags):
                 labelTemplate += "\t%s\n" % depot_side
 
             if self.dry_run:
-                print "Would create p4 label %s for tag" % name
+                print("Would create p4 label %s for tag" % name)
             elif self.prepare_p4_only:
-                print "Not creating p4 label %s for tag due to option" \
-                      " --prepare-p4-only" % name
+                print("Not creating p4 label %s for tag due to option" \
+                      " --prepare-p4-only" % name)
             else:
                 p4_write_pipe(["label", "-i"], labelTemplate)
 
@@ -2151,7 +2151,7 @@ def exportGitTags(self, gitTags):
                           ["%s@%s" % (depot_side, changelist) for depot_side in clientSpec.mappings])
 
                 if verbose:
-                    print "created p4 label for tag %s" % name
+                    print("created p4 label for tag %s" % name)
 
     def run(self, args):
         if len(args) == 0:
@@ -2195,10 +2195,10 @@ def run(self, args):
             self.conflict_behavior = val
 
         if self.verbose:
-            print "Origin branch is " + self.origin
+            print("Origin branch is " + self.origin)
 
         if len(self.depotPath) == 0:
-            print "Internal error: cannot locate perforce depot path from existing branches"
+            print("Internal error: cannot locate perforce depot path from existing branches")
             sys.exit(128)
 
         self.useClientSpec = False
@@ -2219,7 +2219,7 @@ def run(self, args):
         if self.clientPath == "":
             die("Error: Cannot locate perforce checkout of %s in client view" % self.depotPath)
 
-        print "Perforce checkout for depot path %s located at %s" % (self.depotPath, self.clientPath)
+        print("Perforce checkout for depot path %s located at %s" % (self.depotPath, self.clientPath))
         self.oldWorkingDirectory = os.getcwd()
 
         # ensure the clientPath exists
@@ -2230,9 +2230,9 @@ def run(self, args):
 
         chdir(self.clientPath, is_client_path=True)
         if self.dry_run:
-            print "Would synchronize p4 checkout in %s" % self.clientPath
+            print("Would synchronize p4 checkout in %s" % self.clientPath)
         else:
-            print "Synchronizing p4 checkout..."
+            print("Synchronizing p4 checkout...")
             if new_client_dir:
                 # old one was destroyed, and maybe nobody told p4
                 p4_sync("...", "-f")
@@ -2308,13 +2308,13 @@ def run(self, args):
         # continue to try the rest of the patches, or quit.
         #
         if self.dry_run:
-            print "Would apply"
+            print("Would apply")
         applied = []
         last = len(commits) - 1
         for i, commit in enumerate(commits):
             if self.dry_run:
-                print " ", read_pipe(["git", "show", "-s",
-                                      "--format=format:%h %s", commit])
+                print(" ", read_pipe(["git", "show", "-s",
+                                      "--format=format:%h %s", commit]))
                 ok = True
             else:
                 ok = self.applyCommit(commit)
@@ -2322,15 +2322,15 @@ def run(self, args):
                 applied.append(commit)
             else:
                 if self.prepare_p4_only and i < last:
-                    print "Processing only the first commit due to option" \
-                          " --prepare-p4-only"
+                    print("Processing only the first commit due to option" \
+                          " --prepare-p4-only")
                     break
                 if i < last:
                     quit = False
                     while True:
                         # prompt for what to do, or use the option/variable
                         if self.conflict_behavior == "ask":
-                            print "What do you want to do?"
+                            print("What do you want to do?")
                             response = raw_input("[s]kip this commit but apply"
                                                  " the rest, or [q]uit? ")
                             if not response:
@@ -2344,10 +2344,10 @@ def run(self, args):
                                 self.conflict_behavior)
 
                         if response[0] == "s":
-                            print "Skipping this commit, but applying the rest"
+                            print("Skipping this commit, but applying the rest")
                             break
                         if response[0] == "q":
-                            print "Quitting"
+                            print("Quitting")
                             quit = True
                             break
                     if quit:
@@ -2360,7 +2360,7 @@ def run(self, args):
         elif self.prepare_p4_only:
             pass
         elif len(commits) == len(applied):
-            print ("All commits {0}!".format(shelved_applied))
+            print("All commits {0}!".format(shelved_applied))
 
             sync = P4Sync()
             if self.branch:
@@ -2376,17 +2376,17 @@ def run(self, args):
 
         else:
             if len(applied) == 0:
-                print ("No commits {0}.".format(shelved_applied))
+                print("No commits {0}.".format(shelved_applied))
             else:
-                print ("{0} only the commits marked with '*':".format(shelved_applied.capitalize()))
+                print("{0} only the commits marked with '*':".format(shelved_applied.capitalize()))
                 for c in commits:
                     if c in applied:
                         star = "*"
                     else:
                         star = " "
-                    print star, read_pipe(["git", "show", "-s",
-                                           "--format=format:%h %s",  c])
-                print "You will have to do 'git p4 sync' and rebase."
+                    print(star, read_pipe(["git", "show", "-s",
+                                           "--format=format:%h %s",  c]))
+                print("You will have to do 'git p4 sync' and rebase.")
 
         if gitConfigBool("git-p4.exportLabels"):
             self.exportLabels = True
@@ -2596,7 +2596,7 @@ def checkpoint(self):
         self.gitStream.write("progress checkpoint\n\n")
         out = self.gitOutput.readline()
         if self.verbose:
-            print "checkpoint finished: " + out
+            print("checkpoint finished: " + out)
 
     def cmp_shelved(self, path, filerev, revision):
         """ Determine if a path at revision #filerev is the same as the file
@@ -2751,7 +2751,7 @@ def encodeWithUTF8(self, path):
                 encoding = gitConfig('git-p4.pathEncoding')
             path = path.decode(encoding, 'replace').encode('utf8', 'replace')
             if self.verbose:
-                print 'Path with non-ASCII characters detected. Used %s to encode: %s ' % (encoding, path)
+                print('Path with non-ASCII characters detected. Used %s to encode: %s ' % (encoding, path))
         return path
 
     # output one file from the P4 stream
@@ -2780,7 +2780,7 @@ def streamOneP4File(self, file, contents):
                 # to nothing.  This causes p4 errors when checking out such
                 # a change, and errors here too.  Work around it by ignoring
                 # the bad symlink; hopefully a future change fixes it.
-                print "\nIgnoring empty symlink in %s" % file['depotFile']
+                print("\nIgnoring empty symlink in %s" % file['depotFile'])
                 return
             elif data[-1] == '\n':
                 contents = [data[:-1]]
@@ -2820,7 +2820,7 @@ def streamOneP4File(self, file, contents):
             # Ideally, someday, this script can learn how to generate
             # appledouble files directly and import those to git, but
             # non-mac machines can never find a use for apple filetype.
-            print "\nIgnoring apple filetype file %s" % file['depotFile']
+            print("\nIgnoring apple filetype file %s" % file['depotFile'])
             return
 
         # Note that we do not try to de-mangle keywords on utf16 files,
@@ -2969,7 +2969,7 @@ def streamTag(self, gitStream, labelName, labelDetails, commit, epoch):
         """
 
         if verbose:
-            print "writing tag %s for commit %s" % (labelName, commit)
+            print("writing tag %s for commit %s" % (labelName, commit))
         gitStream.write("tag %s\n" % labelName)
         gitStream.write("from %s\n" % commit)
 
@@ -2988,7 +2988,7 @@ def streamTag(self, gitStream, labelName, labelDetails, commit, epoch):
 
         gitStream.write("tagger %s\n" % tagger)
 
-        print "labelDetails=",labelDetails
+        print("labelDetails=",labelDetails)
         if 'Description' in labelDetails:
             description = labelDetails['Description']
         else:
@@ -3060,7 +3060,7 @@ def commit(self, details, files, branch, parent = ""):
 
         if len(parent) > 0:
             if self.verbose:
-                print "parent %s" % parent
+                print("parent %s" % parent)
             self.gitStream.write("from %s\n" % parent)
 
         self.streamP4Files(files)
@@ -3073,7 +3073,7 @@ def commit(self, details, files, branch, parent = ""):
             labelDetails = label[0]
             labelRevisions = label[1]
             if self.verbose:
-                print "Change %s is labelled %s" % (change, labelDetails)
+                print("Change %s is labelled %s" % (change, labelDetails))
 
             files = p4CmdList(["files"] + ["%s...@%s" % (p, change)
                                                 for p in self.branchPrefixes])
@@ -3091,12 +3091,12 @@ def commit(self, details, files, branch, parent = ""):
 
                 else:
                     if not self.silent:
-                        print ("Tag %s does not match with change %s: files do not match."
+                        print("Tag %s does not match with change %s: files do not match."
                                % (labelDetails["label"], change))
 
             else:
                 if not self.silent:
-                    print ("Tag %s does not match with change %s: file count is different."
+                    print("Tag %s does not match with change %s: file count is different."
                            % (labelDetails["label"], change))
 
     # Build a dictionary of changelists and labels, for "detect-labels" option.
@@ -3112,7 +3112,7 @@ def getLabels(self):
             revisions = {}
             newestChange = 0
             if self.verbose:
-                print "Querying files for label %s" % label
+                print("Querying files for label %s" % label)
             for file in p4CmdList(["files"] +
                                       ["%s...@%s" % (p, label)
                                           for p in self.depotPaths]):
@@ -3124,7 +3124,7 @@ def getLabels(self):
             self.labels[newestChange] = [output, revisions]
 
         if self.verbose:
-            print "Label changes: %s" % self.labels.keys()
+            print("Label changes: %s" % self.labels.keys())
 
     # Import p4 labels as git tags. A direct mapping does not
     # exist, so assume that if all the files are at the same revision
@@ -3132,7 +3132,7 @@ def getLabels(self):
     # just ignore.
     def importP4Labels(self, stream, p4Labels):
         if verbose:
-            print "import p4 labels: " + ' '.join(p4Labels)
+            print("import p4 labels: " + ' '.join(p4Labels))
 
         ignoredP4Labels = gitConfigList("git-p4.ignoredP4Labels")
         validLabelRegexp = gitConfig("git-p4.labelImportRegexp")
@@ -3145,7 +3145,7 @@ def importP4Labels(self, stream, p4Labels):
 
             if not m.match(name):
                 if verbose:
-                    print "label %s does not match regexp %s" % (name,validLabelRegexp)
+                    print("label %s does not match regexp %s" % (name,validLabelRegexp))
                 continue
 
             if name in ignoredP4Labels:
@@ -3167,7 +3167,7 @@ def importP4Labels(self, stream, p4Labels):
                     gitCommit = read_pipe(["git", "rev-list", "--max-count=1",
                         "--reverse", ":/\[git-p4:.*change = %d\]" % changelist], ignore_error=True)
                     if len(gitCommit) == 0:
-                        print "importing label %s: could not find git commit for changelist %d" % (name, changelist)
+                        print("importing label %s: could not find git commit for changelist %d" % (name, changelist))
                     else:
                         commitFound = True
                         gitCommit = gitCommit.strip()
@@ -3177,16 +3177,16 @@ def importP4Labels(self, stream, p4Labels):
                     try:
                         tmwhen = time.strptime(labelDetails['Update'], "%Y/%m/%d %H:%M:%S")
                     except ValueError:
-                        print "Could not convert label time %s" % labelDetails['Update']
+                        print("Could not convert label time %s" % labelDetails['Update'])
                         tmwhen = 1
 
                     when = int(time.mktime(tmwhen))
                     self.streamTag(stream, name, labelDetails, gitCommit, when)
                     if verbose:
-                        print "p4 label %s mapped to git commit %s" % (name, gitCommit)
+                        print("p4 label %s mapped to git commit %s" % (name, gitCommit))
             else:
                 if verbose:
-                    print "Label %s has no changelists - possibly deleted?" % name
+                    print("Label %s has no changelists - possibly deleted?" % name)
 
             if not commitFound:
                 # We can't import this label; don't try again as it will get very
@@ -3231,8 +3231,8 @@ def getBranchMapping(self):
 
                     if destination in self.knownBranches:
                         if not self.silent:
-                            print "p4 branch %s defines a mapping from %s to %s" % (info["branch"], source, destination)
-                            print "but there exists another mapping from %s to %s already!" % (self.knownBranches[destination], destination)
+                            print("p4 branch %s defines a mapping from %s to %s" % (info["branch"], source, destination))
+                            print("but there exists another mapping from %s to %s already!" % (self.knownBranches[destination], destination))
                         continue
 
                     self.knownBranches[destination] = source
@@ -3296,28 +3296,28 @@ def gitRefForBranch(self, branch):
 
     def gitCommitByP4Change(self, ref, change):
         if self.verbose:
-            print "looking in ref " + ref + " for change %s using bisect..." % change
+            print("looking in ref " + ref + " for change %s using bisect..." % change)
 
         earliestCommit = ""
         latestCommit = parseRevision(ref)
 
         while True:
             if self.verbose:
-                print "trying: earliest %s latest %s" % (earliestCommit, latestCommit)
+                print("trying: earliest %s latest %s" % (earliestCommit, latestCommit))
             next = read_pipe("git rev-list --bisect %s %s" % (latestCommit, earliestCommit)).strip()
             if len(next) == 0:
                 if self.verbose:
-                    print "argh"
+                    print("argh")
                 return ""
             log = extractLogMessageFromGitCommit(next)
             settings = extractSettingsGitLog(log)
             currentChange = int(settings['change'])
             if self.verbose:
-                print "current change %s" % currentChange
+                print("current change %s" % currentChange)
 
             if currentChange == change:
                 if self.verbose:
-                    print "found %s" % next
+                    print("found %s" % next)
                 return next
 
             if currentChange < change:
@@ -3363,7 +3363,7 @@ def searchParent(self, parent, branch, target):
             if len(read_pipe(["git", "diff-tree", blob, target])) == 0:
                 parentFound = True
                 if self.verbose:
-                    print "Found parent of %s in commit %s" % (branch, blob)
+                    print("Found parent of %s in commit %s" % (branch, blob))
                 break
         if parentFound:
             return blob
@@ -3394,7 +3394,7 @@ def importChanges(self, changes, shelved=False, origin_revision=0):
                         filesForCommit = branches[branch]
 
                         if self.verbose:
-                            print "branch is %s" % branch
+                            print("branch is %s" % branch)
 
                         self.updatedBranches.add(branch)
 
@@ -3415,13 +3415,13 @@ def importChanges(self, changes, shelved=False, origin_revision=0):
                                         print("\n    Resuming with change %s" % change);
 
                                 if self.verbose:
-                                    print "parent determined through known branches: %s" % parent
+                                    print("parent determined through known branches: %s" % parent)
 
                         branch = self.gitRefForBranch(branch)
                         parent = self.gitRefForBranch(parent)
 
                         if self.verbose:
-                            print "looking for initial parent for %s; current parent is %s" % (branch, parent)
+                            print("looking for initial parent for %s; current parent is %s" % (branch, parent))
 
                         if len(parent) == 0 and branch in self.initialParents:
                             parent = self.initialParents[branch]
@@ -3431,7 +3431,7 @@ def importChanges(self, changes, shelved=False, origin_revision=0):
                         if len(parent) > 0:
                             tempBranch = "%s/%d" % (self.tempBranchLocation, change)
                             if self.verbose:
-                                print "Creating temporary branch: " + tempBranch
+                                print("Creating temporary branch: " + tempBranch)
                             self.commit(description, filesForCommit, tempBranch)
                             self.tempBranches.append(tempBranch)
                             self.checkpoint()
@@ -3440,7 +3440,7 @@ def importChanges(self, changes, shelved=False, origin_revision=0):
                             self.commit(description, filesForCommit, branch, blob)
                         else:
                             if self.verbose:
-                                print "Parent of %s not found. Committing into head of %s" % (branch, parent)
+                                print("Parent of %s not found. Committing into head of %s" % (branch, parent))
                             self.commit(description, filesForCommit, branch, parent)
                 else:
                     files = self.extractFilesFromCommit(description, shelved, change, origin_revision)
@@ -3449,7 +3449,7 @@ def importChanges(self, changes, shelved=False, origin_revision=0):
                     # only needed once, to connect to the previous commit
                     self.initialParent = ""
             except IOError:
-                print self.gitError.read()
+                print(self.gitError.read())
                 sys.exit(1)
 
     def sync_origin_only(self):
@@ -3457,11 +3457,11 @@ def sync_origin_only(self):
             self.hasOrigin = originP4BranchesExist()
             if self.hasOrigin:
                 if not self.silent:
-                    print 'Syncing with origin first, using "git fetch origin"'
+                    print('Syncing with origin first, using "git fetch origin"')
                 system("git fetch origin")
 
     def importHeadRevision(self, revision):
-        print "Doing initial import of %s from revision %s into %s" % (' '.join(self.depotPaths), revision, self.branch)
+        print("Doing initial import of %s from revision %s into %s" % (' '.join(self.depotPaths), revision, self.branch))
 
         details = {}
         details["user"] = "git perforce import user"
@@ -3513,8 +3513,8 @@ def importHeadRevision(self, revision):
         try:
             self.commit(details, self.extractFilesFromCommit(details), self.branch)
         except IOError:
-            print "IO error with git fast-import. Is your git version recent enough?"
-            print self.gitError.read()
+            print("IO error with git fast-import. Is your git version recent enough?")
+            print(self.gitError.read())
 
     def openStreams(self):
         self.importProcess = subprocess.Popen(["git", "fast-import"],
@@ -3576,14 +3576,14 @@ def run(self, args):
 
             if len(self.p4BranchesInGit) > 1:
                 if not self.silent:
-                    print "Importing from/into multiple branches"
+                    print("Importing from/into multiple branches")
                 self.detectBranches = True
                 for branch in branches.keys():
                     self.initialParents[self.refPrefix + branch] = \
                         branches[branch]
 
             if self.verbose:
-                print "branches: %s" % self.p4BranchesInGit
+                print("branches: %s" % self.p4BranchesInGit)
 
             p4Change = 0
             for branch in self.p4BranchesInGit:
@@ -3618,7 +3618,7 @@ def run(self, args):
                 self.depotPaths = sorted(self.previousDepotPaths)
                 self.changeRange = "@%s,#head" % p4Change
                 if not self.silent and not self.detectBranches:
-                    print "Performing incremental import into %s git branch" % self.branch
+                    print("Performing incremental import into %s git branch" % self.branch)
 
         # accept multiple ref name abbreviations:
         #    refs/foo/bar/branch -> use it exactly
@@ -3635,10 +3635,10 @@ def run(self, args):
 
         if len(args) == 0 and self.depotPaths:
             if not self.silent:
-                print "Depot paths: %s" % ' '.join(self.depotPaths)
+                print("Depot paths: %s" % ' '.join(self.depotPaths))
         else:
             if self.depotPaths and self.depotPaths != args:
-                print ("previous import used depot path %s and now %s was specified. "
+                print("previous import used depot path %s and now %s was specified. "
                        "This doesn't work!" % (' '.join (self.depotPaths),
                                                ' '.join (args)))
                 sys.exit(1)
@@ -3705,8 +3705,8 @@ def run(self, args):
             else:
                 self.getBranchMapping()
             if self.verbose:
-                print "p4-git branches: %s" % self.p4BranchesInGit
-                print "initial parents: %s" % self.initialParents
+                print("p4-git branches: %s" % self.p4BranchesInGit)
+                print("initial parents: %s" % self.initialParents)
             for b in self.p4BranchesInGit:
                 if b != "master":
 
@@ -3750,8 +3750,8 @@ def run(self, args):
                                     self.branch)
 
                 if self.verbose:
-                    print "Getting p4 changes for %s...%s" % (', '.join(self.depotPaths),
-                                                              self.changeRange)
+                    print("Getting p4 changes for %s...%s" % (', '.join(self.depotPaths),
+                                                              self.changeRange))
                 changes = p4ChangesForPaths(self.depotPaths, self.changeRange, self.changes_block_size)
 
                 if len(self.maxChanges) > 0:
@@ -3759,10 +3759,10 @@ def run(self, args):
 
             if len(changes) == 0:
                 if not self.silent:
-                    print "No changes to import!"
+                    print("No changes to import!")
             else:
                 if not self.silent and not self.detectBranches:
-                    print "Import destination: %s" % self.branch
+                    print("Import destination: %s" % self.branch)
 
                 self.updatedBranches = set()
 
@@ -3777,7 +3777,7 @@ def run(self, args):
                 self.importChanges(changes)
 
                 if not self.silent:
-                    print ""
+                    print("")
                     if len(self.updatedBranches) > 0:
                         sys.stdout.write("Updated branches: ")
                         for b in self.updatedBranches:
@@ -3841,7 +3841,7 @@ def rebase(self):
         # the branchpoint may be p4/foo~3, so strip off the parent
         upstream = re.sub("~[0-9]+$", "", upstream)
 
-        print "Rebasing the current branch onto %s" % upstream
+        print("Rebasing the current branch onto %s" % upstream)
         oldHead = read_pipe("git rev-parse HEAD").strip()
         system("git rebase %s" % upstream)
         system("git diff-tree --stat --summary -M %s HEAD --" % oldHead)
@@ -3895,7 +3895,7 @@ def run(self, args):
         if not self.cloneDestination:
             self.cloneDestination = self.defaultDestination(args)
 
-        print "Importing from %s into %s" % (', '.join(depotPaths), self.cloneDestination)
+        print("Importing from %s into %s" % (', '.join(depotPaths), self.cloneDestination))
 
         if not os.path.exists(self.cloneDestination):
             os.makedirs(self.cloneDestination)
@@ -3917,8 +3917,8 @@ def run(self, args):
             if not self.cloneBare:
                 system([ "git", "checkout", "-f" ])
         else:
-            print 'Not checking out any branch, use ' \
-                  '"git checkout -q -b master <branch>"'
+            print('Not checking out any branch, use ' \
+                  '"git checkout -q -b master <branch>"')
 
         # auto-set this variable if invoked with --use-client-spec
         if self.useClientSpec_from_options:
@@ -4034,7 +4034,7 @@ def run(self, args):
             log = extractLogMessageFromGitCommit("refs/remotes/%s" % branch)
             settings = extractSettingsGitLog(log)
 
-            print "%s <= %s (%s)" % (branch, ",".join(settings["depot-paths"]), settings["change"])
+            print("%s <= %s (%s)" % (branch, ",".join(settings["depot-paths"]), settings["change"]))
         return True
 
 class HelpFormatter(optparse.IndentedHelpFormatter):
@@ -4048,12 +4048,12 @@ def format_description(self, description):
             return ""
 
 def printUsage(commands):
-    print "usage: %s <command> [options]" % sys.argv[0]
-    print ""
-    print "valid commands: %s" % ", ".join(commands)
-    print ""
-    print "Try %s <command> --help for command specific help." % sys.argv[0]
-    print ""
+    print("usage: %s <command> [options]" % sys.argv[0])
+    print("")
+    print("valid commands: %s" % ", ".join(commands))
+    print("")
+    print("Try %s <command> --help for command specific help." % sys.argv[0])
+    print("")
 
 commands = {
     "debug" : P4Debug,
@@ -4078,8 +4078,8 @@ def main():
         klass = commands[cmdName]
         cmd = klass()
     except KeyError:
-        print "unknown command %s" % cmdName
-        print ""
+        print("unknown command %s" % cmdName)
+        print("")
         printUsage(commands.keys())
         sys.exit(2)
 
-- 
2.18.0.rc1.242.g61856ae69a

