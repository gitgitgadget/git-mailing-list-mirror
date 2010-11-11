From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv7 01/11] gitweb: use fullname as hash_base in heads link
Date: Thu, 11 Nov 2010 13:26:08 +0100
Message-ID: <1289478378-15604-2-git-send-email-giuseppe.bilotta@gmail.com>
References: <1289478378-15604-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 11 13:26:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGWEg-0000Gr-JA
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 13:26:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756405Ab0KKM0Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 07:26:25 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:57901 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753964Ab0KKM0Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 07:26:25 -0500
Received: by wwb29 with SMTP id 29so64691wwb.1
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 04:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=pCYfmx0LMOS01KlNJUIx529EY//E4xL6SIqigPKMsiQ=;
        b=HgnPUtS9nM/BQPLprBC966xyE9Ch+l1Rfpl7HF9mXKKaKB9UtO1iQU4gOPVpsp7oKv
         3r7A+5loCgSbCi3+ZJuIouD47BzYAY70HMJ8pJhADhUEXsDwn9c6SutTGul/SJsTqobG
         nWDNY40JYTteD/ecT0JEEHzRos/JTTxa8h1fY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=tdC3oOa5t3rml4YNjv1CNbnxg70exPCXU2OZvuUQhe5aOIMznaId4a3WtfO31B2iWq
         b79AfnVRXg/FYgbmxxW/UAYpIiX3KOeSnMfN6Aun/LdrWaFHkL0IpGK2bnv3v37NvYLG
         kXzrvZDREskb3rIHXMD7JGcc5jYAAxn4qZkRo=
Received: by 10.227.132.213 with SMTP id c21mr740661wbt.135.1289478383186;
        Thu, 11 Nov 2010 04:26:23 -0800 (PST)
Received: from localhost ([151.60.176.40])
        by mx.google.com with ESMTPS id k4sm1244016weq.9.2010.11.11.04.26.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Nov 2010 04:26:22 -0800 (PST)
X-Mailer: git-send-email 1.7.3.68.g6ec8
In-Reply-To: <1289478378-15604-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161234>

Otherwise, if names are manipulated for display, the link will point to
the wrong head.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 253f41a..77693ab 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4960,7 +4960,7 @@ sub git_heads_body {
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
