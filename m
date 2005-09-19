From: Martin Atukunda <matlads@dsmagic.com>
Subject: [PATCH][COGITO] Broken Documentation
Date: Mon, 19 Sep 2005 23:23:10 +0300
Message-ID: <20050919202310.GB17503@igloo.ds.co.ug>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Sep 19 22:26:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHSCk-0001BZ-7a
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 22:25:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932625AbVISUZb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 16:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932626AbVISUZb
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 16:25:31 -0400
Received: from mail1.imul.com ([217.113.72.31]:43872 "EHLO mail1.infocom.co.ug")
	by vger.kernel.org with ESMTP id S932625AbVISUZb (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2005 16:25:31 -0400
Received: from entandikwa.ds.co.ug ([::ffff:217.113.73.39])
  by mail1.infocom.co.ug with esmtp; Mon, 19 Sep 2005 23:25:17 +0300
  id 000E5DB7.432F1EAD.00002597
Received: from igloo.ds.co.ug (igloo.ds.co.ug [192.168.129.66])
	by entandikwa.ds.co.ug (Postfix) with ESMTP id DDE23514A
	for <git@vger.kernel.org>; Mon, 19 Sep 2005 23:26:39 +0300 (EAT)
Received: from matlads by igloo.ds.co.ug with local (Exim 4.52)
	id 1EHSAQ-0004bs-Tw
	for git@vger.kernel.org; Mon, 19 Sep 2005 23:23:10 +0300
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8905>

As noted by Horst von Brand <vonbrand@inf.utfsm.cl>, cg-parent-id.txt
and cg-tree-id.txt don't validate as xml, and this breaks the Documentation build.

I traced this to the fact that cg-parent-id and cg-tree-id do not have
USAGE=... lines. btw, this also affects cg-commit-id.

Patch below adds USAGE lines to cg-parent-id, cg-tree-id, and
cg-commit-id.

Signed-Off-By: Martin Atukunda <matlads@dsmagic.com>

---

diff --git a/cg-commit-id b/cg-commit-id
--- a/cg-commit-id
+++ b/cg-commit-id
@@ -5,6 +5,8 @@
 #
 # Takes the appropriate ID, defaults to HEAD.
 
+USAGE="cg-commit-id [COMMIT_ID]"
+
 id="$1"
 normid=$(. ${COGITO_LIB}cg-Xnormid "$id") || exit 1
 type=${normid#* }
diff --git a/cg-parent-id b/cg-parent-id
--- a/cg-parent-id
+++ b/cg-parent-id
@@ -7,5 +7,7 @@
 #
 # NOTE: Will return multiple SHA1s if ID is a commit with multiple parents.
 
+USAGE="cg-parent-id [COMMIT_ID]"
+
 normid=$(. ${COGITO_LIB}cg-Xnormid "$1"^)
 echo ${normid%% *}
diff --git a/cg-tree-id b/cg-tree-id
--- a/cg-tree-id
+++ b/cg-tree-id
@@ -5,6 +5,8 @@
 #
 # Takes ID of the appropriate commit, defaults to HEAD.
 
+USAGE="cg-tree-id [COMMIT_ID]"
+
 id="$1"
 normid=$(. ${COGITO_LIB}cg-Xnormid "$id") || exit 1
 type=${normid#* }
