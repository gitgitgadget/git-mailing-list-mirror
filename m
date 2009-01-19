From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH] contrib/difftool: remove distracting 'echo' in the SIGINT handler
Date: Tue, 20 Jan 2009 00:41:18 +0100
Message-ID: <200901200041.18793.markus.heidelberg@web.de>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 20 00:42:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LP3lT-0005Xv-62
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 00:42:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753394AbZASXlU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 18:41:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752526AbZASXlT
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 18:41:19 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:34838 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752433AbZASXlT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 18:41:19 -0500
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id 4E378F91EA1B;
	Tue, 20 Jan 2009 00:41:18 +0100 (CET)
Received: from [89.59.93.106] (helo=pluto)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LP3k6-0005Uq-00; Tue, 20 Jan 2009 00:41:18 +0100
User-Agent: KMail/1.9.9
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX19GTeoTmsF+4F8/lfFyxQaVdVABzbFnEw4O/TqX
	LxlsElfX1+t9hbukOUUJU4D8y1vc7SqI2+VIYd9/RWc1bDYNYO
	rZRP5gG7rjDvaVL9VckA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106407>

When interrupting git-difftool with Ctrl-C, the output of this echo
command led to having the cursor at the beginning of the line below the
shell prompt.

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---

	David, have you intentionally added this 'echo', did it fix
	anything for you?

 contrib/difftool/git-difftool-helper |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/contrib/difftool/git-difftool-helper b/contrib/difftool/git-difftool-helper
index a2eb59b..0c48506 100755
--- a/contrib/difftool/git-difftool-helper
+++ b/contrib/difftool/git-difftool-helper
@@ -32,7 +32,6 @@ cleanup_temp_files () {
 
 # This is called when users Ctrl-C out of git-difftool-helper
 sigint_handler () {
-	echo
 	cleanup_temp_files
 	exit 1
 }
-- 
1.6.1.216.g3acd
