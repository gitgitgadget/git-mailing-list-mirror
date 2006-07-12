From: Alp Toker <alp@atoker.com>
Subject: [PATCH] Documentation: Fix ssh:// URLs in generated documentation
Date: Wed, 12 Jul 2006 22:55:21 +0100
Message-ID: <11527413212127-git-send-email-alp@atoker.com>
X-From: git-owner@vger.kernel.org Wed Jul 12 23:55:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0mg2-0007YA-9u
	for gcvg-git@gmane.org; Wed, 12 Jul 2006 23:55:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442AbWGLVzX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Jul 2006 17:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbWGLVzX
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Jul 2006 17:55:23 -0400
Received: from host-84-9-44-142.bulldogdsl.com ([84.9.44.142]:34056 "EHLO
	ndesk.org") by vger.kernel.org with ESMTP id S1751442AbWGLVzW (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Jul 2006 17:55:22 -0400
Received: by ndesk.org (Postfix, from userid 1000)
	id 68EC8A7259; Wed, 12 Jul 2006 22:55:21 +0100 (BST)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.1.g2fca1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23799>

Commit c3f17061be95de3498449a548e93883aebff23d6 was causing warnings
during doc generation due to bad asciidoc markup.

This resulted in "ssh://[user@]host.xz/path/to/repo.git/" being rendered
as "host.xz/path/to/repo.git/" in the man pages and html output.

This patch converts sections listing URL formats to verbatim.

It also changes a minor capitalization inconsistency which ended up
appearing in several man pages by inclusion.

Signed-off-by: Alp Toker <alp@atoker.com>
---
 Documentation/urls.txt |   34 ++++++++++++++--------------------
 1 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/Documentation/urls.txt b/Documentation/urls.txt
index 9abec80..2b5a7f8 100644
--- a/Documentation/urls.txt
+++ b/Documentation/urls.txt
@@ -4,33 +4,27 @@ GIT URLS[[URLS]]
 One of the following notations can be used
 to name the remote repository:
 
-===============================================================
-- rsync://host.xz/path/to/repo.git/
-- http://host.xz/path/to/repo.git/
-- https://host.xz/path/to/repo.git/
-- git://host.xz/path/to/repo.git/
-- git://host.xz/~user/path/to/repo.git/
-- ssh://[user@]host.xz/path/to/repo.git/
-- ssh://[user@]host.xz/~user/path/to/repo.git/
-- ssh://[user@]host.xz/~/path/to/repo.git
-===============================================================
-
-SSH Is the default transport protocol and also supports an
+	rsync://host.xz/path/to/repo.git/
+	http://host.xz/path/to/repo.git/
+	https://host.xz/path/to/repo.git/
+	git://host.xz/path/to/repo.git/
+	git://host.xz/~user/path/to/repo.git/
+	ssh://[user@]host.xz/path/to/repo.git/
+	ssh://[user@]host.xz/~user/path/to/repo.git/
+	ssh://[user@]host.xz/~/path/to/repo.git
+
+SSH is the default transport protocol and also supports an
 scp-like syntax.  Both syntaxes support username expansion,
 as does the native git protocol. The following three are
 identical to the last three above, respectively:
 
-===============================================================
-- host.xz:/path/to/repo.git/
-- host.xz:~user/path/to/repo.git/
-- host.xz:path/to/repo.git
-===============================================================
+	host.xz:/path/to/repo.git/
+	host.xz:~user/path/to/repo.git/
+	host.xz:path/to/repo.git
 
 To sync with a local directory, use:
 
-===============================================================
-- /path/to/repo.git/
-===============================================================
+	/path/to/repo.git/
 
 REMOTES
 -------
-- 
1.4.1.g2fca1
