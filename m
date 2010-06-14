From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCHv4 02/17] gitweb: Fix typo in hash key name in %opts in git_header_html
Date: Mon, 14 Jun 2010 18:08:14 +0200
Message-ID: <1276531710-22945-3-git-send-email-jnareb@gmail.com>
References: <1276531710-22945-1-git-send-email-jnareb@gmail.com>
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Petr Baudis <pasky@ucw.cz>,
	Christian Couder <chriscool@tuxfamily.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 14 18:10:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOCEq-0002Dq-HA
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 18:10:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754839Ab0FNQIw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jun 2010 12:08:52 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44776 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754923Ab0FNQIk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jun 2010 12:08:40 -0400
Received: by mail-fx0-f46.google.com with SMTP id 8so2649600fxm.19
        for <git@vger.kernel.org>; Mon, 14 Jun 2010 09:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=YYrUDz39Trvoe03i6gi+qANm+K3nJ1DysAQaRZ5CDl4=;
        b=EsJSE5KA+uPsNzVc8/1e+2az/coQxFluG/QJGJW93CM+g7d+p7CtCRJrAKicGh/4Oz
         yH0kspx+R9H4zZP/fqzjE0wGl7yBTJMaO2N+TE63W0EEc7xVx5bAGCCMq1r1RlAg2W4i
         mWX6KrAn9djjhP8wtSLFaDpszv8P9qf+iEWaw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=aJAlPbImaAafsGxpMjtiMe9B+V60o8qpYfNvD4hMjAW6F4JqYZH7LJeZjNT/cQJYVL
         JtYza3a0yTd+Q6zawepTCmB+dWFcBnDAy6K6qBTSSQ51PIJWnwUa4u2LWb+h/DGgs7+c
         dr0WNAopb3tPMy+MbYULb69GkJ1zvBewkQovQ=
Received: by 10.223.6.152 with SMTP id 24mr5696024faz.25.1276531719354;
        Mon, 14 Jun 2010 09:08:39 -0700 (PDT)
Received: from localhost.localdomain (abuz111.neoplus.adsl.tpnet.pl [83.8.197.111])
        by mx.google.com with ESMTPS id u12sm7476715fah.28.2010.06.14.09.08.38
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 14 Jun 2010 09:08:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.1
In-Reply-To: <1276531710-22945-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149109>

The name of the key has to be the same in call site handle_errors_html
and in called subroutine that uses it, i.e. git_header_html.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c54a8a8..74be92b 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3230,7 +3230,7 @@ sub git_header_html {
 	}
 	print $cgi->header(-type=>$content_type, -charset => 'utf-8',
 	                   -status=> $status, -expires => $expires)
-		unless ($opts{'-no_http_headers'});
+		unless ($opts{'-no_http_header'});
 	my $mod_perl_version = $ENV{'MOD_PERL'} ? " $ENV{'MOD_PERL'}" : '';
 	print <<EOF;
 <?xml version="1.0" encoding="utf-8"?>
-- 
1.7.0.1
