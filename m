From: Orgad Shaneh <orgads@gmail.com>
Subject: [PATCH] gitweb: fix error when highlight is enabled
Date: Wed, 26 Dec 2012 09:54:16 +0200
Message-ID: <1356508456-17454-1-git-send-email-orgads@gmail.com>
Cc: Orgad Shaneh <orgads@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 26 09:01:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TnlvQ-0007kt-1j
	for gcvg-git-2@plane.gmane.org; Wed, 26 Dec 2012 09:01:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753338Ab2LZIAz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2012 03:00:55 -0500
Received: from mail-we0-f180.google.com ([74.125.82.180]:65047 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751189Ab2LZIAx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Dec 2012 03:00:53 -0500
X-Greylist: delayed 374 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Dec 2012 03:00:53 EST
Received: by mail-we0-f180.google.com with SMTP id t57so3785594wey.39
        for <git@vger.kernel.org>; Wed, 26 Dec 2012 00:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=KREySpAgJkra4mwnLT4BGOcbh8p0NbUh/LE8n6ZDjzw=;
        b=KjtCMoBVKoYO9JUDlZ/q5yIcGRkWjk/zj1qplXiF+N2N50kRJ97jd/JK8iV2z7u+Zq
         oR9plNF4KIcZVLp/wvtd/tx1T3hx9TNljNnohMQMTG3H5eQ+CsjgRAOtpVxPTcdx7URW
         OrkJlgzi2bDvyn9AC7rrwlxyWlP1eJpxlh759KDqNhRmZ41078LSYTiHaTNTqcs0U1Uv
         KvKpqkgT20EmMX9FPbm72W0LFhb3wmUDFr+t17Plmz7xRuERH4VWT551kYYRox+AMFoh
         PR+cC+A5AEvb62MGUV0CqiS38SxBYBZ8LiMMi22UiRUARvCjwoXbcNowh+7k7qWPbt1l
         HyJQ==
X-Received: by 10.180.107.130 with SMTP id hc2mr41536466wib.12.1356508478472;
        Tue, 25 Dec 2012 23:54:38 -0800 (PST)
Received: from localhost.localdomain (IGLD-84-228-63-15.inter.net.il. [84.228.63.15])
        by mx.google.com with ESMTPS id ex6sm42636182wid.3.2012.12.25.23.54.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 25 Dec 2012 23:54:36 -0800 (PST)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212130>

Use of uninitialized value in substitution iterator at gitweb.cgi line 1560

Signed-off-by: Orgad Shaneh <orgads@gmail.com>
---
 gitweb/gitweb.perl |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 0f207f2..862b9cd 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1556,7 +1556,7 @@ sub sanitize {
 	return undef unless defined $str;
 
 	$str = to_utf8($str);
-	$str =~ s|([[:cntrl:]])|($1 =~ /[\t\n\r]/ ? $1 : quot_cec($1))|eg;
+	$str =~ s|([[:cntrl:]])|($1 =~ /([\t\n\r])/ ? $1 : quot_cec($1))|eg;
 	return $str;
 }
 
-- 
1.7.10.4
