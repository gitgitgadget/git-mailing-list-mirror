From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH 2/3] Make tutorial-script work with current cogito
Date: Thu, 02 Mar 2006 20:11:57 -0500
Message-ID: <20060303011157.14619.99070.stgit@dv.roinet.com>
References: <20060303011154.14619.71590.stgit@dv.roinet.com>
X-From: git-owner@vger.kernel.org Fri Mar 03 02:12:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEyq4-0003AK-Lt
	for gcvg-git@gmane.org; Fri, 03 Mar 2006 02:12:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752106AbWCCBMF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 20:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752111AbWCCBMB
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 20:12:01 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:46047 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1752108AbWCCBMA
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Mar 2006 20:12:00 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FEypp-0005TR-Sw
	for git@vger.kernel.org; Thu, 02 Mar 2006 20:11:58 -0500
Received: from localhost.roinet.com ([127.0.0.1] helo=dv.roinet.com)
	by dv.roinet.com with esmtp (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1FEypp-0003on-7I; Thu, 02 Mar 2006 20:11:57 -0500
To: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060303011154.14619.71590.stgit@dv.roinet.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17130>

Labels on merge conflict lines have changed.  There is no "git rename",
use cg-mv instead.  In one case stack.h is not created, so copy
stack.h~master to stack.h before fixing it.

Also fix comments in script.sh to use the new labels.

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 .../tutorial-script/0010-alice-bob-fixup.ed        |    2 +
 .../tutorial-script/0017-alice-bob-fixup.ed        |    2 +
 .../tutorial-script/0018-alice-charlie-fixup1.ed   |    4 +--
 .../tutorial-script/0019-alice-charlie-fixup2.ed   |    4 +--
 .../tutorial-script/0021-bob-alice-fixup1.ed       |    4 +--
 .../tutorial-script/0022-bob-alice-fixup2.ed       |    2 +
 Documentation/tutorial-script/script.sh            |   31 ++++++++++----------
 7 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/Documentation/tutorial-script/0010-alice-bob-fixup.ed b/Documentation/tutorial-script/0010-alice-bob-fixup.ed
index ca2047c..81b1360 100644
--- a/Documentation/tutorial-script/0010-alice-bob-fixup.ed
+++ b/Documentation/tutorial-script/0010-alice-bob-fixup.ed
@@ -1,3 +1,3 @@
-/^<<<<<<< rpn\.c/,/^>>>>>>> \.merge_file_/d
+/^<<<<<<< bob/,/^>>>>>>> bobswork/d
 w
 q
diff --git a/Documentation/tutorial-script/0017-alice-bob-fixup.ed b/Documentation/tutorial-script/0017-alice-bob-fixup.ed
index ad04eb7..6353328 100644
--- a/Documentation/tutorial-script/0017-alice-bob-fixup.ed
+++ b/Documentation/tutorial-script/0017-alice-bob-fixup.ed
@@ -1,4 +1,4 @@
-/^<<<<<<< Makefile/d
+/^<<<<<<< \.merge_file_/d
 /^=======/,/^=======/+1d
 /^>>>>>>> \.merge_file_/d
 w
diff --git a/Documentation/tutorial-script/0018-alice-charlie-fixup1.ed b/Documentation/tutorial-script/0018-alice-charlie-fixup1.ed
index 65f5ef5..20c25c8 100644
--- a/Documentation/tutorial-script/0018-alice-charlie-fixup1.ed
+++ b/Documentation/tutorial-script/0018-alice-charlie-fixup1.ed
@@ -1,7 +1,7 @@
-/^<<<<<<< Makefile/d
+/^<<<<<<< master/d
 /^rpn\.o:/s/\.h.*$/.h lexer.h/
 /^lexer\.o:/s/:.*$/: lexer.h/
-/^=======/,/^>>>>>>> \.merge_file_/d
+/^=======/,/^>>>>>>> charlie/d
 w
 q
 
diff --git a/Documentation/tutorial-script/0019-alice-charlie-fixup2.ed b/Documentation/tutorial-script/0019-alice-charlie-fixup2.ed
index f1aadb4..5d531de 100644
--- a/Documentation/tutorial-script/0019-alice-charlie-fixup2.ed
+++ b/Documentation/tutorial-script/0019-alice-charlie-fixup2.ed
@@ -1,5 +1,5 @@
-/^<<<<<<< rpn\.c/,/^=======/d
-/^>>>>>>> \.merge_file_/d
+/^<<<<<<< master/,/^=======/d
+/^>>>>>>> charlie/d
 w
 q
 
diff --git a/Documentation/tutorial-script/0021-bob-alice-fixup1.ed b/Documentation/tutorial-script/0021-bob-alice-fixup1.ed
index 2783f73..df703d5 100644
--- a/Documentation/tutorial-script/0021-bob-alice-fixup1.ed
+++ b/Documentation/tutorial-script/0021-bob-alice-fixup1.ed
@@ -1,4 +1,4 @@
-/^<<<<<<< Makefile/,/^=======/d
-/^>>>>>>> \.merge_file_/d
+/^<<<<<<< master/,/^=======/d
+/^>>>>>>> origin/d
 w
 q
diff --git a/Documentation/tutorial-script/0022-bob-alice-fixup2.ed b/Documentation/tutorial-script/0022-bob-alice-fixup2.ed
index 18c90d4..d8c5746 100644
--- a/Documentation/tutorial-script/0022-bob-alice-fixup2.ed
+++ b/Documentation/tutorial-script/0022-bob-alice-fixup2.ed
@@ -1,5 +1,5 @@
 /^#include "stack\.h"/+1d
 /^#include "lexer\.h"/+1,/^#include "stack\.h"/d
-/^<<<<<<< rpn\.c/-1,/^>>>>>>> \.merge_file_/d
+/^<<<<<<< master/-1,/^>>>>>>> origin/d
 w
 q
diff --git a/Documentation/tutorial-script/script.sh b/Documentation/tutorial-script/script.sh
index bc70b77..edcebda 100755
--- a/Documentation/tutorial-script/script.sh
+++ b/Documentation/tutorial-script/script.sh
@@ -120,13 +120,13 @@ cg-update bobswork && should_fail
 # difference between her version and Bob's:
 
 #: ...
-#: <<<<<<< rpn.c
+#: <<<<<<< bob
 #: extern double pop(void);
 #: extern void push(double);
 #: extern void clear(void);
 #: 
 #: =======
-#: >>>>>>> .merge_file_5wCNZT
+#: >>>>>>> bobswork
 #: extern int getsym(void);
 #: ...
  
@@ -216,7 +216,7 @@ cg-merge bob && should_fail
 # Merge fails:
 
 #: ...
-#: <<<<<<< Makefile
+#: <<<<<<< .merge_file_l54ztH
 #:	$(CC) $(CFLAGS) $^ -lm -o $@
 #: =======
 #:	$(CC) $(CFLAGS) $^ -o $@
@@ -235,31 +235,31 @@ cg-merge charlie && should_fail
 # Merge conflicts!
 
 #: ...
-#: <<<<<<< Makefile
-#:         $(CC) $(CFLAGS) $^ -lm -o $@
-#:        
+#: <<<<<<< master
+#:	$(CC) $(CFLAGS) $^ -lm -o $@
+#:	
 #: rpn.o: stack.h
 #: stack.o: stack.h
-#: lexer.o:
+#: lexer.o:	
 #: =======
-#:         $(CC) $(CFLAGS) $^ -o $@
-#:                
+#:	$(CC) $(CFLAGS) $^ -o $@
+#:	
 #: rpn.o lexer.o: lexer.h
-#: 
-#: >>>>>>> .merge_file_huuX9C
+#:	
+#: >>>>>>> charlie
 
 ed Makefile < $TOP/0018-alice-charlie-fixup1.ed
 
 #: ...
-#: <<<<<<< rpn.c
+#: <<<<<<< master
 #: extern int getsym(void);
 #: 
 #: =======
 #: extern double pop(void);
 #: extern void push(double);
 #: extern void clear(void);
-#:
-#: >>>>>> .merge_file_qtv6VA
+#: 
+#: >>>>>>> charlie
 #: ...
 
 ed rpn.c    < $TOP/0019-alice-charlie-fixup2.ed
@@ -273,7 +273,7 @@ cg-add CONTRIBUTORS
 cg-commit -m "Add CONTRIBUTORS"
 
 # Wrong file name...
-git rename CONTRIBUTORS CREDITS
+cg-mv CONTRIBUTORS CREDITS
 cg-commit -m "Rename CONTRIBUTORS to CREDITS"
 
 
@@ -308,6 +308,7 @@ echo "Merge with 0.4" | cg-merge && shou
 # Mishandled stack.h
 ed Makefile < $TOP/0021-bob-alice-fixup1.ed
 ed rpn.c    < $TOP/0022-bob-alice-fixup2.ed
+cp stack.h~master stack.h
 ed stack.h  < $TOP/0023-bob-alice-fixup3.ed
 cg-add stack.h
 
