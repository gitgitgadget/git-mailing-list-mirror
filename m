From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/4] gitweb: Change the name of diff to parent link in "commit" view to "diff"
Date: Mon, 4 Sep 2006 18:15:28 +0200
Message-ID: <200609041815.29203.jnareb@gmail.com>
References: <200609041810.09838.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Sep 04 18:37:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKHRZ-0002bY-EO
	for gcvg-git@gmane.org; Mon, 04 Sep 2006 18:37:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477AbWIDQg7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Sep 2006 12:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751480AbWIDQg7
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Sep 2006 12:36:59 -0400
Received: from nz-out-0102.google.com ([64.233.162.204]:9700 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751477AbWIDQg6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Sep 2006 12:36:58 -0400
Received: by nz-out-0102.google.com with SMTP id n1so855142nzf
        for <git@vger.kernel.org>; Mon, 04 Sep 2006 09:36:57 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=BcFktuYDBRLdevVCRWpeme4+fylZWtJYy2Lo7yypzSng57JV41DFUu441r9IKiM9uUBdaRhAOoVCq1/2R78T34DE8sAuil08wgc+jOWqm1w8qvWAJcIIiRBYdMDMLxfNgtSjq/AnTBpNgNl8Q+Y+XZD9BehVRKR4lwxYsOmJREo=
Received: by 10.65.75.19 with SMTP id c19mr5803671qbl;
        Mon, 04 Sep 2006 09:36:57 -0700 (PDT)
Received: from host-81-190-21-28.torun.mm.pl ( [81.190.21.28])
        by mx.gmail.com with ESMTP id c5sm3859928qbc.2006.09.04.09.36.56;
        Mon, 04 Sep 2006 09:36:57 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200609041810.09838.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26421>

Change the name of diff to parent (current commit to one of parents)
link in "commit" view (git_commit subroutine) from "commitdiff" to
"diff".  Let's leave "commitdiff" for equivalent of git-show, or
git-diff-tree with one revision, i.e. diff for a given commit to its
parent (parents).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
The commit message is barely smaller than the diff itself, but it
is expected as commit message tell the why behind the change.

 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index bebaa0f..3b5c0e2 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2758,7 +2758,7 @@ sub git_commit {
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
