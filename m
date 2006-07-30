From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 16] gitweb: Remove characters entities entirely when shortening string
Date: Sun, 30 Jul 2006 22:36:04 +0200
Message-ID: <200607302236.06686.jnareb@gmail.com>
References: <200607292239.11034.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Jul 30 22:36:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7I1E-00052s-9U
	for gcvg-git@gmane.org; Sun, 30 Jul 2006 22:36:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbWG3UgI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Jul 2006 16:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbWG3UgI
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Jul 2006 16:36:08 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:64 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932143AbWG3UgH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Jul 2006 16:36:07 -0400
Received: by ug-out-1314.google.com with SMTP id m3so454991ugc
        for <git@vger.kernel.org>; Sun, 30 Jul 2006 13:36:05 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=XBpBhvhgzSVDu0b+GQx2h0jq/ttAg7FLlmEENw4Acz/4B3q7hGrx29vRhxx8fXMJtNSmS92D5MRzFuQUlQux+CqaVgRxum+6hBk7sZTsSDHXsQTTLmFSm57iNttyQPfCT9NOu17LYnvOdIHuquLSaywr0wOs5sM2lqwEglTrbNQ=
Received: by 10.66.216.6 with SMTP id o6mr1791440ugg;
        Sun, 30 Jul 2006 13:36:05 -0700 (PDT)
Received: from roke.d-201 ( [193.0.122.19])
        by mx.gmail.com with ESMTP id q1sm4421190uge.2006.07.30.13.36.04;
        Sun, 30 Jul 2006 13:36:05 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200607292239.11034.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24472>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Yet another error noticed due to strict validation 
of application/xhtml+xml by Mozilla.

 gitweb/gitweb.cgi |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index 06a6930..83ea97a 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -776,6 +776,7 @@ sub chop_str {
 	my $tail = $2;
 	if (length($tail) > 4) {
 		$tail = " ...";
+		$body =~ s/&[^;]$//; # remove chopped character entities
 	}
 	return "$body$tail";
 }
-- 
1.4.0
