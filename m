From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv6 2/8] gitweb: uniform author info for commit and commitdiff
Date: Thu, 25 Jun 2009 12:43:01 +0200
Message-ID: <1245926587-25074-3-git-send-email-giuseppe.bilotta@gmail.com>
References: <1245926587-25074-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1245926587-25074-2-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 25 12:44:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJmQu-0008IK-Sg
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 12:43:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757280AbZFYKnS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2009 06:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757267AbZFYKnP
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 06:43:15 -0400
Received: from mail-fx0-f213.google.com ([209.85.220.213]:37327 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757072AbZFYKnK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2009 06:43:10 -0400
Received: by fxm9 with SMTP id 9so1350427fxm.37
        for <git@vger.kernel.org>; Thu, 25 Jun 2009 03:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=WPqrgp62VXATWBz/g65gqLdnA+dAeC+toa+DiBhgEBI=;
        b=IH1EaN1Ga9ITD/QlxO95oO9PWkYGxub/fnj4WVc7aXm5S4fjNErqw5HaYzgpCXQlnM
         P+IsSB1i/4z+mZY9WFZVZNvAdnKngXPJcE2nWDdD2sRmKDo+eywi2ZDBB1GvSEpQd5A4
         IrKB3NL1P+6UIt4dybf6YPcXs4G7OfavLbNL4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=QBzBI4sCCx/7gnJ2dl+Xyk4syTmx8SJlG9YWpx7ZzfCodWAv66yoQLi9IOopOOSUvC
         h+CPrfEmRRdNynBHRsrljwP2M5JHU3oaGFTDAZ+nEkQf0oKpV1yZdQSGyi4PkhuHzUDS
         3Vcgl4QcYKQvt7ioFOshVWoU4OSiwmbchQe3g=
Received: by 10.204.71.15 with SMTP id f15mr2340455bkj.113.1245926592595;
        Thu, 25 Jun 2009 03:43:12 -0700 (PDT)
Received: from localhost (dynamic-adsl-94-37-13-28.clienti.tiscali.it [94.37.13.28])
        by mx.google.com with ESMTPS id f31sm3204015fkf.8.2009.06.25.03.43.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Jun 2009 03:43:12 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.rc1.192.gdbfcb
In-Reply-To: <1245926587-25074-2-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122198>

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 9b60418..cdfd1d5 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5595,7 +5595,11 @@ sub git_commitdiff {
 		git_header_html(undef, $expires);
 		git_print_page_nav('commitdiff','', $hash,$co{'tree'},$hash, $formats_nav);
 		git_print_header_div('commit', esc_html($co{'title'}) . $ref, $hash);
-		git_print_authorship(\%co, 'localtime' => 1);
+		print "<div class=\"title_text\">\n" .
+		      "<table class=\"object_header\">\n";
+		git_print_full_authorship(\%co);
+		print "</table>".
+		      "</div>\n";
 		print "<div class=\"page_body\">\n";
 		if (@{$co{'comment'}} > 1) {
 			print "<div class=\"log\">\n";
-- 
1.6.3.rc1.192.gdbfcb
