From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH] Enable tree (directory) history display
Date: Fri, 30 Jun 2006 18:00:12 -0700 (PDT)
Message-ID: <20060701010012.1559.qmail@web31809.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Sat Jul 01 03:00:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwTqM-00040X-UA
	for gcvg-git@gmane.org; Sat, 01 Jul 2006 03:00:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbWGABAP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 21:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932237AbWGABAP
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 21:00:15 -0400
Received: from web31809.mail.mud.yahoo.com ([68.142.207.72]:51359 "HELO
	web31809.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932081AbWGABAN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jun 2006 21:00:13 -0400
Received: (qmail 1561 invoked by uid 60001); 1 Jul 2006 01:00:12 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=D+MCQu3k3kRx3xXvA/M7NKYmD3Kq9jYeWjA4lT85KoZurnfbaJpIeuSgU1M5dYymVaw5vS46VqjK8kX0Pff4+Lo2XF2TNts6njBvJVjvhG2TBAdBFbBlALV1f0Q7AU4W9fMJd4cFkH38zjni3yZA/jeahURMf4aoy99roeM/l/Q=  ;
Received: from [68.186.62.135] by web31809.mail.mud.yahoo.com via HTTP; Fri, 30 Jun 2006 18:00:12 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23024>

This patch allows history display of whole trees/directories a la
"git-rev-list HEAD -- <dir or file>".  I find this useful especially
when a project lives in its own subdirectory, as opposed to being all
of the GIT repository (i.e. when a sub-project is merged into a
super-project).

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
---
 gitweb/gitweb.cgi |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index 2705a93..d808900 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -1676,6 +1676,7 @@ #			      " | " . $cgi->a({-href => "$my
 			      "</td>\n" .
 			      "<td class=\"link\">" .
 			      $cgi->a({-href => "$my_uri?" .
esc_param("p=$project;a=tree;h=$t_hash$base_key;f=$base$t_name")}, "tree") .
+			      " | " . $cgi->a({-href => "$my_uri?" .
esc_param("p=$project;a=history;h=$hash_base;f=$base$t_name")}, "history") .
 			      "</td>\n";
 		}
 		print "</tr>\n";
-- 
1.4.1.rc2.g4ce4
