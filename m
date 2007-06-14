From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] Easy commands, without bashisms.
Date: Thu, 14 Jun 2007 14:51:00 +0200
Message-ID: <11818254621993-git-send-email-madcoder@debian.org>
References: <11818254621527-git-send-email-madcoder@debian.org>
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
To: Josef Jeff Sipek <jsipek@cs.sunysb.edu>
X-From: git-owner@vger.kernel.org Thu Jun 14 14:51:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyonU-0003Jt-VX
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 14:51:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbXFNMvV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 08:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbXFNMvU
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 08:51:20 -0400
Received: from pan.madism.org ([88.191.52.104]:60902 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751200AbXFNMvF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2007 08:51:05 -0400
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id E45DBDA68;
	Thu, 14 Jun 2007 14:51:03 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 7F367929B9; Thu, 14 Jun 2007 14:51:02 +0200 (CEST)
X-Mailer: git-send-email 1.5.2.1
In-Reply-To: <11818254621527-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50195>

  Just move to /bin/sh and use . `dirname $0`/guilt as posh fails else.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 guilt-applied |    4 ++--
 guilt-delete  |    4 ++--
 guilt-fold    |    4 ++--
 guilt-header  |    4 ++--
 guilt-init    |    4 ++--
 guilt-pop     |    4 ++--
 guilt-prev    |    4 ++--
 guilt-rebase  |    4 ++--
 guilt-refresh |    4 ++--
 guilt-rm      |    4 ++--
 guilt-top     |    4 ++--
 11 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/guilt-applied b/guilt-applied
index 373e5f7..52f8470 100755
--- a/guilt-applied
+++ b/guilt-applied
@@ -1,10 +1,10 @@
-#!/bin/bash
+#!/bin/sh
 #
 # Copyright (c) Josef "Jeff" Sipek, 2006, 2007
 #
 
 USAGE="[-c]"
-. guilt
+. `dirname $0`/guilt
 
 case $# in
 	0)
diff --git a/guilt-delete b/guilt-delete
index 8649875..1118b00 100755
--- a/guilt-delete
+++ b/guilt-delete
@@ -1,10 +1,10 @@
-#!/bin/bash
+#!/bin/sh
 #
 # Copyright (c) Josef "Jeff" Sipek, 2006, 2007
 #
 
 USAGE="[-f] <patchname>"
-. guilt
+. `dirname $0`/guilt
 
 case $# in
 	1)
diff --git a/guilt-fold b/guilt-fold
index 0d0222b..92fac1a 100755
--- a/guilt-fold
+++ b/guilt-fold
@@ -1,10 +1,10 @@
-#!/bin/bash
+#!/bin/sh
 #
 # Copyright (c) Josef "Jeff" Sipek, 2006, 2007
 #
 
 USAGE="<patchname>"
-. guilt
+. `dirname $0`/guilt
 
 if [ $# -ne 1 ]; then
 	usage
diff --git a/guilt-header b/guilt-header
index eb89cfd..d07e2be 100755
--- a/guilt-header
+++ b/guilt-header
@@ -1,10 +1,10 @@
-#!/bin/bash
+#!/bin/sh
 #
 # Copyright (c) Josef "Jeff" Sipek, 2006, 2007
 #
 
 USAGE="[<patchname>]"
-. guilt
+. `dirname $0`/guilt
 
 if [ $# -gt 1 ]; then
 	usage
diff --git a/guilt-init b/guilt-init
index feacf95..ffe2434 100755
--- a/guilt-init
+++ b/guilt-init
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/bin/sh
 #
 # Copyright (c) Josef "Jeff" Sipek, 2006, 2007
 #
@@ -6,7 +6,7 @@
 DO_NOT_CHECK_BRANCH_EXISTENCE=1
 
 USAGE="[-n]"
-. guilt
+. `dirname $0`/guilt
 
 autotag=1
 
diff --git a/guilt-pop b/guilt-pop
index 2b9c2ec..89ad021 100755
--- a/guilt-pop
+++ b/guilt-pop
@@ -1,10 +1,10 @@
-#!/bin/bash
+#!/bin/sh
 #
 # Copyright (c) Josef "Jeff" Sipek, 2006, 2007
 #
 
 USAGE="[-f] [-a | --all | <patchname>]"
-. guilt
+. `dirname $0`/guilt
 
 while [ $# -gt 0 ]; do
 	case "$1" in
diff --git a/guilt-prev b/guilt-prev
index 5348f88..26e7a51 100755
--- a/guilt-prev
+++ b/guilt-prev
@@ -1,10 +1,10 @@
-#!/bin/bash
+#!/bin/sh
 #
 # Copyright (c) Josef "Jeff" Sipek, 2006, 2007
 #
 
 USAGE=""
-. guilt
+. `dirname $0`/guilt
 
 if [ $# -ne 0 ]; then
 	usage
diff --git a/guilt-rebase b/guilt-rebase
index 823384d..cc8dcf6 100755
--- a/guilt-rebase
+++ b/guilt-rebase
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/bin/sh
 #
 # Copyright (c) Josef "Jeff" Sipek, 2007
 #
@@ -6,7 +6,7 @@
 #
 
 USAGE="<upstream>"
-. guilt
+. `dirname $0`/guilt
 
 case "$#" in
 	1) 
diff --git a/guilt-refresh b/guilt-refresh
index 957f23d..8541484 100755
--- a/guilt-refresh
+++ b/guilt-refresh
@@ -1,10 +1,10 @@
-#!/bin/bash
+#!/bin/sh
 #
 # Copyright (c) Josef "Jeff" Sipek, 2006, 2007
 #
 
 USAGE=""
-. guilt
+. `dirname $0`/guilt
 
 if [ $# -ne 0 ]; then
 	usage
diff --git a/guilt-rm b/guilt-rm
index f0025b4..0ec120d 100755
--- a/guilt-rm
+++ b/guilt-rm
@@ -1,10 +1,10 @@
-#!/bin/bash
+#!/bin/sh
 #
 # Copyright (c) Josef "Jeff" Sipek, 2006, 2007
 #
 
 USAGE="<file>..."
-. guilt
+. `dirname $0`/guilt
 
 if [ $# -lt 1 ]; then
 	usage
diff --git a/guilt-top b/guilt-top
index 3d407e8..8004f10 100755
--- a/guilt-top
+++ b/guilt-top
@@ -1,10 +1,10 @@
-#!/bin/bash
+#!/bin/sh
 #
 # Copyright (c) Josef "Jeff" Sipek, 2006, 2007
 #
 
 USAGE=""
-. guilt
+. `dirname $0`/guilt
 
 if [ $# -ne 0 ]; then
 	usage
-- 
1.5.2.1
