From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] t/t960[123]: remove leftover scripts
Date: Fri, 11 Jan 2013 21:38:39 -0800
Message-ID: <7v1udr9d0g.fsf_-_@alter.siamese.dyndns.org>
References: <1357875152-19899-1-git-send-email-gitster@pobox.com>
 <7v62339du4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Chris Rorvick <chris@rorvick.com>
To: "Eric S. Raymond" <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 06:39:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TttoD-00085z-RY
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jan 2013 06:39:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751676Ab3ALFin (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2013 00:38:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65367 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751604Ab3ALFim (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2013 00:38:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C2736706A;
	Sat, 12 Jan 2013 00:38:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/JPhFtO4TJpIB/lXRldE1JJJOMA=; b=pACT3T
	a+rtCRKKVXv6RcaGfjjjNeuFF/VDxeMFd15oW+We6zhPvE+Fp1nkDHFw8ezoAwy4
	JwgzrALDUozmAo8jwydKg3MxZTiWkyWrkNRS9sx0uNz8Whw14w6QLxUa+EQFcuAH
	ql0mx1nWTctD75+L4hkB3K5DIb/X0YudiJgko=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qPagqFvVFlahJlQ4wF54UbDA0+y31l2W
	P52WfXhvOh67WDDOYqss4DiDm55qntLP1O6Ynv/M+jy6RFXVMDFz7XHrSh2rwlNR
	ib9AQG0pBvt6Ovc9GrNUW/QkHLY7LSk2NK5yENIFAfz/8Ojhy1+A55GalWL35WzZ
	w7zO+HD/J+s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B7AD57069;
	Sat, 12 Jan 2013 00:38:41 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F2D3A7067; Sat, 12 Jan 2013
 00:38:40 -0500 (EST)
In-Reply-To: <7v62339du4.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 11 Jan 2013 21:20:51 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 523CE7D8-5C7A-11E2-A5B2-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213262>

The rewrite patch was supposed to remove these scripts, but somehow
we ended up removing only the supporting files for them but not the
test script themselves.  Remove them for real.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * I'll queue this on top of your patch together with a few fix-up
   patches from Chris Rorvick.  This may have been caused by your
   private patch e-mail mangled somewhere between us before I resent
   your patch, or perhaps you simply may have forgot to remove them,
   but at this point I do not really care where these deletions were
   lost---the only thing I care about is to make sure that you
   _meant_ to remove them in your patch (i.e. if you didn't mean to,
   then I am further breaking the tests in a way you did not intend
   to), so I'd appreciate either "Yup, these three files should be
   removed", or "No, they should stay; removal of their supporting
   data is no longer needed" from you (I and this patch expect the
   former, of course).

   By the way, Chris, we'll need your Sign-off on the three paches
   (t/lib-cvs.sh fix to allow cvsps v3, t9600 fix and t9604 fix).

 t/t9601-cvsimport-vendor-branch.sh | 85 --------------------------------------
 t/t9602-cvsimport-branches-tags.sh | 78 ----------------------------------
 t/t9603-cvsimport-patchsets.sh     | 39 -----------------
 3 files changed, 202 deletions(-)
 delete mode 100755 t/t9601-cvsimport-vendor-branch.sh
 delete mode 100755 t/t9602-cvsimport-branches-tags.sh
 delete mode 100755 t/t9603-cvsimport-patchsets.sh

diff --git a/t/t9601-cvsimport-vendor-branch.sh b/t/t9601-cvsimport-vendor-branch.sh
deleted file mode 100755
index 827d39f..0000000
--- a/t/t9601-cvsimport-vendor-branch.sh
+++ /dev/null
@@ -1,85 +0,0 @@
-#!/bin/sh
-
-# Description of the files in the repository:
-#
-#    imported-once.txt:
-#
-#       Imported once.  1.1 and 1.1.1.1 should be identical.
-#
-#    imported-twice.txt:
-#
-#       Imported twice.  HEAD should reflect the contents of the
-#       second import (i.e., have the same contents as 1.1.1.2).
-#
-#    imported-modified.txt:
-#
-#       Imported, then modified on HEAD.  HEAD should reflect the
-#       modification.
-#
-#    imported-modified-imported.txt:
-#
-#       Imported, then modified on HEAD, then imported again.
-#
-#    added-imported.txt,v:
-#
-#       Added with 'cvs add' to create 1.1, then imported with
-#       completely different contents to create 1.1.1.1, therefore the
-#       vendor branch was never the default branch.
-#
-#    imported-anonymously.txt:
-#
-#       Like imported-twice.txt, but with a vendor branch whose branch
-#       tag has been removed.
-
-test_description='git cvsimport handling of vendor branches'
-. ./lib-cvs.sh
-
-setup_cvs_test_repository t9601
-
-test_expect_success PERL 'import a module with a vendor branch' '
-
-	git cvsimport -C module-git module
-
-'
-
-test_expect_success PERL 'check HEAD out of cvs repository' 'test_cvs_co master'
-
-test_expect_success PERL 'check master out of git repository' 'test_git_co master'
-
-test_expect_success PERL 'check a file that was imported once' '
-
-	test_cmp_branch_file master imported-once.txt
-
-'
-
-test_expect_failure PERL 'check a file that was imported twice' '
-
-	test_cmp_branch_file master imported-twice.txt
-
-'
-
-test_expect_success PERL 'check a file that was imported then modified on HEAD' '
-
-	test_cmp_branch_file master imported-modified.txt
-
-'
-
-test_expect_success PERL 'check a file that was imported, modified, then imported again' '
-
-	test_cmp_branch_file master imported-modified-imported.txt
-
-'
-
-test_expect_success PERL 'check a file that was added to HEAD then imported' '
-
-	test_cmp_branch_file master added-imported.txt
-
-'
-
-test_expect_success PERL 'a vendor branch whose tag has been removed' '
-
-	test_cmp_branch_file master imported-anonymously.txt
-
-'
-
-test_done
diff --git a/t/t9602-cvsimport-branches-tags.sh b/t/t9602-cvsimport-branches-tags.sh
deleted file mode 100755
index e1db323..0000000
--- a/t/t9602-cvsimport-branches-tags.sh
+++ /dev/null
@@ -1,78 +0,0 @@
-#!/bin/sh
-
-# A description of the repository used for this test can be found in
-# t9602/README.
-
-test_description='git cvsimport handling of branches and tags'
-. ./lib-cvs.sh
-
-setup_cvs_test_repository t9602
-
-test_expect_success PERL 'import module' '
-
-	git cvsimport -C module-git module
-
-'
-
-test_expect_success PERL 'test branch master' '
-
-	test_cmp_branch_tree master
-
-'
-
-test_expect_success PERL 'test branch vendorbranch' '
-
-	test_cmp_branch_tree vendorbranch
-
-'
-
-test_expect_failure PERL 'test branch B_FROM_INITIALS' '
-
-	test_cmp_branch_tree B_FROM_INITIALS
-
-'
-
-test_expect_failure PERL 'test branch B_FROM_INITIALS_BUT_ONE' '
-
-	test_cmp_branch_tree B_FROM_INITIALS_BUT_ONE
-
-'
-
-test_expect_failure PERL 'test branch B_MIXED' '
-
-	test_cmp_branch_tree B_MIXED
-
-'
-
-test_expect_success PERL 'test branch B_SPLIT' '
-
-	test_cmp_branch_tree B_SPLIT
-
-'
-
-test_expect_failure PERL 'test tag vendortag' '
-
-	test_cmp_branch_tree vendortag
-
-'
-
-test_expect_success PERL 'test tag T_ALL_INITIAL_FILES' '
-
-	test_cmp_branch_tree T_ALL_INITIAL_FILES
-
-'
-
-test_expect_failure PERL 'test tag T_ALL_INITIAL_FILES_BUT_ONE' '
-
-	test_cmp_branch_tree T_ALL_INITIAL_FILES_BUT_ONE
-
-'
-
-test_expect_failure PERL 'test tag T_MIXED' '
-
-	test_cmp_branch_tree T_MIXED
-
-'
-
-
-test_done
diff --git a/t/t9603-cvsimport-patchsets.sh b/t/t9603-cvsimport-patchsets.sh
deleted file mode 100755
index 52034c8..0000000
--- a/t/t9603-cvsimport-patchsets.sh
+++ /dev/null
@@ -1,39 +0,0 @@
-#!/bin/sh
-
-# Structure of the test cvs repository
-#
-# Message   File:Content         Commit Time
-# Rev 1     a: 1.1               2009-02-21 19:11:43 +0100
-# Rev 2     a: 1.2    b: 1.1     2009-02-21 19:11:14 +0100
-# Rev 3               b: 1.2     2009-02-21 19:11:43 +0100
-#
-# As you can see the commit of Rev 3 has the same time as
-# Rev 1 this leads to a broken import because of a cvsps
-# bug.
-
-test_description='git cvsimport testing for correct patchset estimation'
-. ./lib-cvs.sh
-
-setup_cvs_test_repository t9603
-
-test_expect_failure 'import with criss cross times on revisions' '
-
-    git cvsimport -p"-x" -C module-git module &&
-    (cd module-git &&
-        git log --pretty=format:%s > ../actual-master &&
-        git log A~2..A --pretty="format:%s %ad" -- > ../actual-A &&
-        echo "" >> ../actual-master &&
-	echo "" >> ../actual-A
-    ) &&
-    echo "Rev 4
-Rev 3
-Rev 2
-Rev 1" > expect-master &&
-    test_cmp actual-master expect-master &&
-
-    echo "Rev 5 Branch A Wed Mar 11 19:09:10 2009 +0000
-Rev 4 Branch A Wed Mar 11 19:03:52 2009 +0000" > expect-A &&
-    test_cmp actual-A expect-A
-'
-
-test_done
-- 
1.8.1.421.g6236851
