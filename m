From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv6 05/10] gitweb: use fullname as hash_base in heads link
Date: Sun, 24 Oct 2010 12:45:31 +0200
Message-ID: <1287917136-26103-6-git-send-email-giuseppe.bilotta@gmail.com>
References: <1287917136-26103-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 24 12:46:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9y5x-0004rf-9L
	for gcvg-git-2@lo.gmane.org; Sun, 24 Oct 2010 12:46:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932471Ab0JXKqJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Oct 2010 06:46:09 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45935 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932465Ab0JXKqH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Oct 2010 06:46:07 -0400
Received: by mail-wy0-f174.google.com with SMTP id 28so2370311wyf.19
        for <git@vger.kernel.org>; Sun, 24 Oct 2010 03:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=q6d+8Lmmk1ayfBZ1ZfmQE4V1Du/4uNqPjWCZ8kF1Qn0=;
        b=rYoquUc5/9CZjFvefub+CapBvwhjPZ90NiwKJ7cr6sE+o3My/Z81EiI096r+n993AK
         ak78H4bmSvScdmzHD2Bm+gL7F6kfGFsGP4xD387vWXZN8hlalNIiP9AZcGJgAzFAc998
         hxEwdG9THnrmCK5DaOpQUrD+IZy+NddwBNXpE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=PmOjwNxmBf77Kftv5lLPtaRS1VBf6Fw1xXH/ArE9tUL4SVyeghGs1w+Zu41/oPsVQr
         0GTlK19QBOvrcicEFarTO+MKZZky9PJdOKTQ8lf2vQZ1rorKQgg0L11fDe11BKuS60zk
         kUQulLWQ1Q7wsn4BNddrcexYrg9SNsM45AE9o=
Received: by 10.216.24.199 with SMTP id x49mr4797548wex.109.1287917166402;
        Sun, 24 Oct 2010 03:46:06 -0700 (PDT)
Received: from localhost ([151.60.176.122])
        by mx.google.com with ESMTPS id w84sm3312439weq.20.2010.10.24.03.46.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 Oct 2010 03:46:05 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.68.g6ec8
In-Reply-To: <1287917136-26103-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159848>

Otherwise, if names are manipulated for display, the link will point to
the wrong head.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index f4592ad..a381892 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4991,7 +4991,7 @@ sub git_heads_body {
 		      "<td class=\"link\">" .
 		      $cgi->a({-href => href(action=>"shortlog", hash=>$ref{'fullname'})}, "shortlog") . " | " .
 		      $cgi->a({-href => href(action=>"log", hash=>$ref{'fullname'})}, "log") . " | " .
-		      $cgi->a({-href => href(action=>"tree", hash=>$ref{'fullname'}, hash_base=>$ref{'name'})}, "tree") .
+		      $cgi->a({-href => href(action=>"tree", hash=>$ref{'fullname'}, hash_base=>$ref{'fullname'})}, "tree") .
 		      "</td>\n" .
 		      "</tr>";
 	}
-- 
1.7.3.68.g6ec8
