From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 10] gitweb: Replace form-feed character by ^L
Date: Sun, 30 Jul 2006 15:02:27 +0200
Message-ID: <200607301502.28142.jnareb@gmail.com>
References: <200607292239.11034.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Sun Jul 30 15:02:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7Aw5-00083i-Ky
	for gcvg-git@gmane.org; Sun, 30 Jul 2006 15:02:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbWG3NCW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Jul 2006 09:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbWG3NCW
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Jul 2006 09:02:22 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:54962 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932311AbWG3NCW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Jul 2006 09:02:22 -0400
Received: by ug-out-1314.google.com with SMTP id m3so358971ugc
        for <git@vger.kernel.org>; Sun, 30 Jul 2006 06:02:21 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=sQSOHvkuMxq0QKSUyh0mUe9UNxtw7iVG3hsif2oa5whNTGKSZzIg+n1VQU0sHKTkwS/aXeh38WGvoJAReQlzi83cPqRVlluSTZWg/sZe4Czw47k0tu55U5YMUc/240co0h+YdgzVWL6EGWbPKr5vxuFBlTzKFGsAFYRlu0Uh8ps=
Received: by 10.66.224.3 with SMTP id w3mr1525680ugg;
        Sun, 30 Jul 2006 06:02:21 -0700 (PDT)
Received: from roke.d-201 ( [193.0.122.19])
        by mx.gmail.com with ESMTP id j3sm3646433ugd.2006.07.30.06.02.20;
        Sun, 30 Jul 2006 06:02:20 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200607292239.11034.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24455>

>From 2be5cab10486cba804ccae063e93b146288054fe Mon Sep 17 00:00:00 2001
From: Jakub Narebski <jnareb@gmail.com>
Date: Sun, 30 Jul 2006 13:11:56 +0200
Subject: [PATCH] 

Replace FORM FEED (FF) character (014, 12, 0xc) by it's textual
representation '^L'.  This character is used for example in GNU GPL
'COPYING' file.  With this patch "blob" output for COPYING passes
XHTML validation.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.cgi |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index 6c72d33..d39af82 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -250,6 +250,7 @@ sub esc_html {
 	my $str = shift;
 	$str = decode("utf8", $str, Encode::FB_DEFAULT);
 	$str = escapeHTML($str);
+	$str =~ s/\014/^L/g; # escape FORM FEED (FF) character (e.g. in COPYING file)
 	return $str;
 }
 
-- 
1.4.0
