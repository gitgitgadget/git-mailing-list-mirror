From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: [PATCH 2/2] configure: add settings for gitconfig, editor and pager
Date: Wed,  4 Nov 2009 13:06:00 -0500
Message-ID: <1257357960-12763-3-git-send-email-bwalton@artsci.utoronto.ca>
References: <20091103222123.GA17097@progeny.tock>
 <1257357960-12763-1-git-send-email-bwalton@artsci.utoronto.ca>
 <1257357960-12763-2-git-send-email-bwalton@artsci.utoronto.ca>
Cc: Ben Walton <bwalton@artsci.utoronto.ca>
To: gitster@pobox.com, jrnieder@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 04 19:06:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5kFk-00078w-GP
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 19:06:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbZKDSGK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 13:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932227AbZKDSGJ
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 13:06:09 -0500
Received: from www.cquest.utoronto.ca ([192.82.128.5]:49377 "EHLO
	www.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932220AbZKDSGG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 13:06:06 -0500
Received: from ntdws12.chass.utoronto.ca ([128.100.160.253]:59409 ident=93)
	by www.cquest.utoronto.ca with esmtp (Exim 4.43)
	id 1N5kFH-0001QE-Ks; Wed, 04 Nov 2009 13:06:11 -0500
Received: from localhost
	([127.0.0.1] helo=ntdws12.chass.utoronto.ca ident=505)
	by ntdws12.chass.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1N5kFH-0003Kl-H3; Wed, 04 Nov 2009 13:06:11 -0500
Received: (from bwalton@localhost)
	by ntdws12.chass.utoronto.ca (8.13.8/8.13.8/Submit) id nA4I6BxP012815;
	Wed, 4 Nov 2009 13:06:11 -0500
X-Mailer: git-send-email 1.6.5
In-Reply-To: <1257357960-12763-2-git-send-email-bwalton@artsci.utoronto.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132107>

Use the new GIT_PARSE_WITH_SET_MAKE_VAR macro to allow configuration
settings for ETC_GITCONFIG, DEFAULT_PAGER and DEFAULT_EDITOR.

Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>
---
 configure.ac |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/configure.ac b/configure.ac
index a305d0b..78345eb 100644
--- a/configure.ac
+++ b/configure.ac
@@ -247,6 +247,29 @@ GIT_PARSE_WITH(iconv))
 # change being considered an inode change from the update-index perspective.
 
 #
+# Allow user to set ETC_GITCONFIG variable
+GIT_PARSE_WITH_SET_MAKE_VAR(gitconfig, ETC_GITCONFIG,
+			Use VALUE instead of /etc/gitconfig as the
+			global git configuration file.
+			If VALUE is not fully qualified it will be interpretted
+			as a path relative to the computed prefix at runtime.)
+
+#
+# Allow user to set the default pager
+GIT_PARSE_WITH_SET_MAKE_VAR(pager, DEFAULT_PAGER,
+			Use VALUE as the fall-back pager instead of 'less'.
+			This is used by things like 'git log' when the user
+			does not specify a pager to use through alternate
+			methods. eg: /usr/bin/pager)
+#
+# Allow user to set the default editor
+GIT_PARSE_WITH_SET_MAKE_VAR(editor, DEFAULT_EDITOR,
+			Use VALUE as the fall-back editor instead of 'vi'.
+			This is used by things like 'git commit' when the user
+			does not specify a preferred editor through other
+			methods. eg: /usr/bin/editor)
+
+#
 # Define SHELL_PATH to provide path to shell.
 GIT_ARG_SET_PATH(shell)
 #
-- 
1.6.5.1
