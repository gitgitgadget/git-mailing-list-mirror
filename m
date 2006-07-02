From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH] gitweb: add --full-history to history generation optimization
Date: Sat, 1 Jul 2006 21:42:06 -0700 (PDT)
Message-ID: <20060702044206.75887.qmail@web31806.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Sun Jul 02 06:42:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fwtml-0005E4-7d
	for gcvg-git@gmane.org; Sun, 02 Jul 2006 06:42:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbWGBEmI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Jul 2006 00:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbWGBEmI
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Jul 2006 00:42:08 -0400
Received: from web31806.mail.mud.yahoo.com ([68.142.207.69]:52839 "HELO
	web31806.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751002AbWGBEmH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jul 2006 00:42:07 -0400
Received: (qmail 75889 invoked by uid 60001); 2 Jul 2006 04:42:06 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=uEWSOs1ra3Xngjbcqti8u8AUXYoVuzMtymVoR+u3V4elh6dTnTuyBM55rFvJy6GMpIXieghasdWNi9O59iaySEtQ8e8Ip+s1VB2OGX8JswNUU0lSxVEsMOqrNRbA590WcCzhft6nRQu2bHvH5dQxptZB6eF22QSPFBwzFe/6vvU=  ;
Received: from [68.186.62.135] by web31806.mail.mud.yahoo.com via HTTP; Sat, 01 Jul 2006 21:42:06 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23092>

Now that Linus fixed full history generation, we can
add this to the optimized history generation.

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
---
 gitweb/gitweb.cgi |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index d808900..934af4a 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -2296,7 +2296,7 @@ sub git_history {
 	      "</div>\n";
 	print "<div class=\"page_path\"><b>/" . esc_html($file_name) . "</b><br/></div>\n";
 
-	open my $fd, "-|", "$gitbin/git-rev-list $hash -- \'$file_name\'";
+	open my $fd, "-|", "$gitbin/git-rev-list --full-history $hash -- \'$file_name\'";
 	print "<table cellspacing=\"0\">\n";
 	my $alternate = 0;
 	while (my $line = <$fd>) {
-- 
1.4.1.rc2.gffcf
