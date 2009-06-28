From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] git-submodule documentation: fix foreach example
Date: Sun, 28 Jun 2009 13:39:32 +0200
Message-ID: <20090628113931.GC10895@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Levedahl <mlevedahl@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 28 13:39:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKsjd-0000YF-D7
	for gcvg-git-2@gmane.org; Sun, 28 Jun 2009 13:39:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752394AbZF1Ljd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2009 07:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751542AbZF1Ljc
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jun 2009 07:39:32 -0400
Received: from virgo.iok.hu ([212.40.97.103]:48647 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751409AbZF1Ljc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2009 07:39:32 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id F1BEE58096;
	Sun, 28 Jun 2009 13:39:32 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 4C253448D3;
	Sun, 28 Jun 2009 13:39:32 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 3E722634001; Sun, 28 Jun 2009 13:39:32 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122399>

Backstick and apostrophe are asciidoc markup, so they should be escaped
in order to get the expected result in the rendered manual page.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 Documentation/asciidoc.conf     |    1 +
 Documentation/git-submodule.txt |    5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
index dc76e7f..b88d875 100644
--- a/Documentation/asciidoc.conf
+++ b/Documentation/asciidoc.conf
@@ -17,6 +17,7 @@ caret=&#94;
 startsb=&#91;
 endsb=&#93;
 tilde=&#126;
+backstick=&#96;
 
 ifdef::backend-docbook[]
 [linkgit-inlinemacro]
diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 470bd75..8941ad7 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -141,8 +141,9 @@ foreach::
 	the processing to terminate. This can be overridden by adding '|| :'
 	to the end of the command.
 +
-As an example, "git submodule foreach 'echo $path `git rev-parse HEAD`' will
-show the path and currently checked out commit for each submodule.
+As an example, +git submodule foreach \'echo $path {backstick}git
+rev-parse HEAD{backstick}'+ will show the path and currently checked out
+commit for each submodule.
 
 sync::
 	Synchronizes submodules' remote URL configuration setting
-- 
1.6.3.2
