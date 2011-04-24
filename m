From: Mathias Lafeldt <misfire@debugon.org>
Subject: [PATCH] t/README: unify documentation of test function args
Date: Sun, 24 Apr 2011 12:52:59 +0200
Message-ID: <4DB4010B.6080804@debugon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 24 12:53:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QDwwR-0003Jq-6n
	for gcvg-git-2@lo.gmane.org; Sun, 24 Apr 2011 12:53:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756551Ab1DXKxH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2011 06:53:07 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:54631 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756505Ab1DXKxF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2011 06:53:05 -0400
Received: from [192.168.2.111] (pD95546C1.dip.t-dialin.net [217.85.70.193])
	by mrelayeu.kundenserver.de (node=mreu4) with ESMTP (Nemesis)
	id 0Lsaqr-1PqH7U1bcf-012L6k; Sun, 24 Apr 2011 12:53:01 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.14) Gecko/20110223 Thunderbird/3.1.8
X-Provags-ID: V02:K0:tPsh80w7LhrBfBKzFI+ccodrk+PV1lNU9ZvV9hWn1HR
 BnsDzDYS2hPA2zLQsRjf7Ps49EPHEq2yKFl0Uq5j+Jiu925XeP
 6TSYe03OdRpaZCjtCdxM30Ujgbd5Qh7t8kZmOIhiEip2eI/LZm
 NTKTf4SKU+IvsrltYGbjhm+F9sxYeaGNoym4hq0no7CoYyMsVY
 40esSuqvYr4mYhS2q33ghjREeVVDipLXjYF/TzTdRc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171990>

Document all test function arguments in the same way.

While at it, correct some grammatical errors.

Signed-off-by: Mathias Lafeldt <misfire@debugon.org>
---
 t/README |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/t/README b/t/README
index 428ee05..e8372d7 100644
--- a/t/README
+++ b/t/README
@@ -379,7 +379,7 @@ library for your script to use.
 
  - test_expect_success [<prereq>] <message> <script>
 
-   Usually takes two strings as parameter, and evaluates the
+   Usually takes two strings as parameters, and evaluates the
    <script>.  If it yields success, test is considered
    successful.  <message> should state what it is testing.
 
@@ -389,7 +389,7 @@ library for your script to use.
 	    'git-write-tree should be able to write an empty tree.' \
 	    'tree=$(git-write-tree)'
 
-   If you supply three parameters the first will be taken to be a
+   If you supply three parameters, the first will be taken to be a
    prerequisite, see the test_set_prereq and test_have_prereq
    documentation below:
 
@@ -446,7 +446,7 @@ library for your script to use.
    Merges the given rev using the given message.  Like test_commit,
    creates a tag and calls test_tick before committing.
 
- - test_set_prereq SOME_PREREQ
+ - test_set_prereq <prereq>
 
    Set a test prerequisite to be used later with test_have_prereq. The
    test-lib will set some prerequisites for you, see the
@@ -456,7 +456,7 @@ library for your script to use.
    test_have_prereq directly, or the three argument invocation of
    test_expect_success and test_expect_failure.
 
- - test_have_prereq SOME PREREQ
+ - test_have_prereq <prereq>
 
    Check if we have a prerequisite previously set with
    test_set_prereq. The most common use of this directly is to skip
@@ -503,18 +503,18 @@ library for your script to use.
 		test_expect_code 1 git merge "merge msg" B master
 	'
 
- - test_must_fail <git-command>
+ - test_must_fail <command>
 
-   Run a git command and ensure it fails in a controlled way.  Use
-   this instead of "! <git-command>".  When git-command dies due to a
-   segfault, test_must_fail diagnoses it as an error; "! <git-command>"
-   treats it as just another expected failure, which would let such a
-   bug go unnoticed.
+   Run a command and ensure it fails in a controlled way.  Use this
+   instead of "! <command>".  When the command dies due to a segfault,
+   test_must_fail diagnoses it as an error; "! <command>" treats it as
+   just another expected failure, which would let such a bug go
+   unnoticed.
 
- - test_might_fail <git-command>
+ - test_might_fail <command>
 
    Similar to test_must_fail, but tolerate success, too.  Use this
-   instead of "<git-command> || :" to catch failures due to segv.
+   instead of "<command> || :" to catch failures due to segfault.
 
  - test_cmp <expected> <actual>
 
@@ -530,7 +530,7 @@ library for your script to use.
    test_path_is_dir <dir> [<diagnosis>]
    test_path_is_missing <path> [<diagnosis>]
 
-   Check whether a file/directory exists or doesn't. <diagnosis> will
+   Check whether a file/directory exists or not. <diagnosis> will
    be displayed if the test fails.
 
  - test_when_finished <script>
-- 
1.7.5.rc3
