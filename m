From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] urls.txt: Use substitution to escape square brackets
Date: Fri, 14 Jul 2006 23:50:39 +0200
Message-ID: <20060714215039.GA21994@diku.dk>
References: <11528726881431-git-send-email-alp@atoker.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Fri Jul 14 23:50:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1VYb-0001rk-TW
	for gcvg-git@gmane.org; Fri, 14 Jul 2006 23:50:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161312AbWGNVun (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Jul 2006 17:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161314AbWGNVun
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Jul 2006 17:50:43 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:56208 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1161312AbWGNVum (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Jul 2006 17:50:42 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 70CE1770051;
	Fri, 14 Jul 2006 23:50:41 +0200 (CEST)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 08396-14; Fri, 14 Jul 2006 23:50:39 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 9ACC9770054;
	Fri, 14 Jul 2006 23:50:39 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 0764A6DFEC5; Fri, 14 Jul 2006 23:50:12 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 79111629B4; Fri, 14 Jul 2006 23:50:39 +0200 (CEST)
To: Alp Toker <alp@atoker.com>
Content-Disposition: inline
In-Reply-To: <11528726881431-git-send-email-alp@atoker.com>
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23912>

This changes "[user@]" to use {startsb} and {endsb} to insert [ and ],
similar to how {caret} is used in git-rev-parse.txt.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---

Alternate "fix".

---

diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
index 7ce7151..41754d5 100644
--- a/Documentation/asciidoc.conf
+++ b/Documentation/asciidoc.conf
@@ -9,6 +9,8 @@ # the command.
 
 [attributes]
 caret=^
+startsb=&#91; # [
+endsb=&#93;   # ]
 
 ifdef::backend-docbook[]
 [gitlink-inlinemacro]
diff --git a/Documentation/urls.txt b/Documentation/urls.txt
index 93378d2..2950ac9 100644
--- a/Documentation/urls.txt
+++ b/Documentation/urls.txt
@@ -10,9 +10,9 @@ to name the remote repository:
 - https://host.xz/path/to/repo.git/
 - git://host.xz/path/to/repo.git/
 - git://host.xz/~user/path/to/repo.git/
-- ssh://+++[user@+++]host.xz/path/to/repo.git/
-- ssh://+++[user@+++]host.xz/~user/path/to/repo.git/
-- ssh://+++[user@+++]host.xz/~/path/to/repo.git
+- ssh://{startsb}user@{endsb}host.xz/path/to/repo.git/
+- ssh://{startsb}user@{endsb}host.xz/~user/path/to/repo.git/
+- ssh://{startsb}user@{endsb}host.xz/~/path/to/repo.git
 ===============================================================
 
 SSH Is the default transport protocol and also supports an

-- 
Jonas Fonseca
