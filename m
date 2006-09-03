From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Change the name of diff to parent link in "commit" view to "diff
Date: Sun, 3 Sep 2006 23:43:03 +0200
Message-ID: <200609032343.03657.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Sep 03 23:43:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJzkB-0006lr-At
	for gcvg-git@gmane.org; Sun, 03 Sep 2006 23:43:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbWICVnD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Sep 2006 17:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbWICVnD
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Sep 2006 17:43:03 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:9324 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750755AbWICVnB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Sep 2006 17:43:01 -0400
Received: by nf-out-0910.google.com with SMTP id o25so936625nfa
        for <git@vger.kernel.org>; Sun, 03 Sep 2006 14:43:00 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=BG3ApktUxd/T6e5UX2AH46Q6QwsvI1cAlWgw2T5Y36Cdq+M6+ibver0cXKamXRfCPIBYAmc9vWFL5q4JAKmANFq3uyePQ9oMCHtuYVQhPFOCcVwsD+4mZNG2kOzZZDWgUG0N5wpp30lvukO41MW78tq7bk0JX2jrWuszKXApiyA=
Received: by 10.48.48.15 with SMTP id v15mr5956581nfv;
        Sun, 03 Sep 2006 14:43:00 -0700 (PDT)
Received: from host-81-190-21-28.torun.mm.pl ( [81.190.21.28])
        by mx.gmail.com with ESMTP id o9sm7891197nfa.2006.09.03.14.42.59;
        Sun, 03 Sep 2006 14:42:59 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26384>

Change the name of diff to parent (current commit to one of parents)
link in "commit" view (git_commit subroutine) from "commitdiff" to
"diff".  Let's leave "commitdiff" for equivalent of git-show, or
git-diff-tree with one revision, i.e. diff for a given commit to its
parent (parents).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
One of the cases when commit message is larger than diff itself ;-)
Against 'master'.

 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 57ffa25..2b40aa1 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2781,7 +2781,7 @@ sub git_commit {
 		      "<td class=\"link\">" .
 		      $cgi->a({-href => href(action=>"commit", hash=>$par)}, "commit") .
 		      " | " .
-		      $cgi->a({-href => href(action=>"commitdiff", hash=>$hash, hash_parent=>$par)}, "commitdiff") .
+		      $cgi->a({-href => href(action=>"commitdiff", hash=>$hash, hash_parent=>$par)}, "diff") .
 		      "</td>" .
 		      "</tr>\n";
 	}
-- 
1.4.1.1


-- 
VGER BF report: U 0.508278
