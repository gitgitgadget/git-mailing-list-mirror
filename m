From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv5 05/12] gitweb: use fullname as hash_base in heads link
Date: Fri, 24 Sep 2010 18:02:40 +0200
Message-ID: <1285344167-8518-6-git-send-email-giuseppe.bilotta@gmail.com>
References: <1285344167-8518-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 24 18:04:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzAlD-0006Mx-W0
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 18:04:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358Ab0IXQDh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 12:03:37 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:49941 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932354Ab0IXQDf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 12:03:35 -0400
Received: by wwb13 with SMTP id 13so21348wwb.1
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 09:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=3EIdLZi+7sRS5JII7uMK66MvpanIN+Efr32FAxmHtnc=;
        b=oIlrjKiumNPX7Ilmg2LnWKNSRbimkAwaY6I1oTtKQPE8mh08VRSvW6nqK/tXJHqXiY
         LkfxThUsuHNTmBPfI9ZcvsKlH4znmH39aDRUk/HR6LxuAFej3iFavJc3qMVbmGN99NMt
         mQdyIPcNL/fznA5EfrrO7bnYkg7HrCjWE8C3g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=YXgvUS6YzWndVvS08dIASmP8f4SSisXhiTY+f3gN5IrvVzbZwcGfQgvrrB4CuQJhtF
         k7unXinrLfQX4exods6HUOowuNpD7vy9HdqQKZzehu3FNjdvcd0IucFj5VH2nwoSST6d
         SwwkVXxCTybaeG4IYT8+HEq73lIPLIMfX0RSY=
Received: by 10.227.137.149 with SMTP id w21mr3007545wbt.169.1285344213927;
        Fri, 24 Sep 2010 09:03:33 -0700 (PDT)
Received: from localhost ([151.60.177.109])
        by mx.google.com with ESMTPS id e31sm1922067wbe.17.2010.09.24.09.03.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 09:03:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.68.g6ec8
In-Reply-To: <1285344167-8518-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157005>

Otherwise, if names are manipulated for display, the link will point to
the wrong head.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c3ce7a3..e70897e 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4977,7 +4977,7 @@ sub git_heads_body {
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
