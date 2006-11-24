X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Replace SPC with &nbsp; also in tag comment
Date: Fri, 24 Nov 2006 22:25:50 +0100
Message-ID: <11644035504182-git-send-email-jnareb@gmail.com>
NNTP-Posting-Date: Fri, 24 Nov 2006 21:24:30 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=Vv3VYt+qPfJv1ZTK902j01a//HRfnZkS2/Z+DR0rqsFyqv6359Hg+El5VT0SaG5xBUgwGovbphCB6hipR4iiOvf4luz7weHlHSBDUwXG14fh0BmfT3k17ks1vpHFHtyIFRc0TxzUhHmPJMzTwsoloV0kpWbTF2Ykbe71wofekY8=
X-Mailer: git-send-email 1.4.4.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32239>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GniWw-0006mB-Fi for gcvg-git@gmane.org; Fri, 24 Nov
 2006 22:24:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935063AbWKXVYM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 24 Nov 2006
 16:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935064AbWKXVYM
 (ORCPT <rfc822;git-outgoing>); Fri, 24 Nov 2006 16:24:12 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:12114 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S935063AbWKXVYK
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 24 Nov 2006 16:24:10 -0500
Received: by ug-out-1314.google.com with SMTP id 44so769097uga for
 <git@vger.kernel.org>; Fri, 24 Nov 2006 13:24:09 -0800 (PST)
Received: by 10.67.117.2 with SMTP id u2mr7626952ugm.1164403449284; Fri, 24
 Nov 2006 13:24:09 -0800 (PST)
Received: from roke.D-201 ( [81.190.24.209]) by mx.google.com with ESMTP id
 e1sm15272596ugf.2006.11.24.13.24.08; Fri, 24 Nov 2006 13:24:09 -0800 (PST)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1]) by roke.D-201
 (8.13.4/8.13.4) with ESMTP id kAOLPop4030000; Fri, 24 Nov 2006 22:25:50 +0100
Received: (from jnareb@localhost) by roke.D-201 (8.13.4/8.13.4/Submit) id
 kAOLPott029999; Fri, 24 Nov 2006 22:25:50 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Commit messages had SPC replaced with &nbsp; entity;
make it so also in tag message (tag comment).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 53214b0..f06cd3e 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2924,8 +2924,8 @@ sub git_tag {
 	print "<div class=\"page_body\">";
 	my $comment = $tag{'comment'};
 	foreach my $line (@$comment) {
-		chomp($line);
-		print esc_html($line) . "<br/>\n";
+		chomp $line;
+		print esc_html($line, -nbsp=>1) . "<br/>\n";
 	}
 	print "</div>\n";
 	git_footer_html();
-- 
1.4.4.1
