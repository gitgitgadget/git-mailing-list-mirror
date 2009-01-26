From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv2 3/6] gitweb: rss feed managingEditor
Date: Mon, 26 Jan 2009 12:50:13 +0100
Message-ID: <1232970616-21167-4-git-send-email-giuseppe.bilotta@gmail.com>
References: <1232970616-21167-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1232970616-21167-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1232970616-21167-3-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 26 12:52:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRQ1A-0004CT-WC
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 12:52:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753172AbZAZLuR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 06:50:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753091AbZAZLuO
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 06:50:14 -0500
Received: from ik-out-1112.google.com ([66.249.90.181]:62824 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753004AbZAZLuJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 06:50:09 -0500
Received: by ik-out-1112.google.com with SMTP id c28so767734ika.5
        for <git@vger.kernel.org>; Mon, 26 Jan 2009 03:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Ak21Az6eoTPADhTlMoqpOpQ4nDemGlB65PQvjKS9FO4=;
        b=hF7MDFecM3MQ/Ft/3xIIpOAmyYvOMK3wG84Yx35f8cSyUwr8fU0VSkntkjuPFBfcaD
         BKoxDT5EfcSSZSAPV3Not0ViRReDS129LRnpk4/eF+MeeCiEZA+g09XMGvTw7JPCT9Tv
         I3acin4ZBDUpBOb6ZynrZLfPlvERd0NshEnOQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=huhbDooZLmHALR2B2nmbGI2lc3UcgMCtM21gG5ZJpaN4C+O+WSJy3pP5LfriNw2O6z
         NEBPElz8j3fx/eKC70GPQ5GLztVqDEp6EYqNwtgUB0kY7r2LLgEMdDaZmsHNoizC8piR
         2QKH4JNmkpajKeBbMmEUEEF7R4eEhX6tWLQc0=
Received: by 10.103.221.5 with SMTP id y5mr634147muq.66.1232970606002;
        Mon, 26 Jan 2009 03:50:06 -0800 (PST)
Received: from localhost ([94.37.14.37])
        by mx.google.com with ESMTPS id 7sm12568093mup.10.2009.01.26.03.50.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Jan 2009 03:50:05 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1232970616-21167-3-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107199>

The RSS 2.0 specification allows an optional managingEditor tag for the
channel, containing the "email address for person responsible for editorial
content", which is basically the project owner.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 3d94f50..cc6d0fb 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -6074,7 +6074,9 @@ XML
 		print "<title>$title</title>\n" .
 		      "<link>$alt_url</link>\n" .
 		      "<description>$descr</description>\n" .
-		      "<language>en</language>\n";
+		      "<language>en</language>\n" .
+		      # project owner is responsible for 'editorial' content
+		      "<managingEditor>$owner</managingEditor>\n";
 		if (defined $logo || defined $favicon) {
 			# prefer the logo to the favicon, since RSS
 			# doesn't allow both
-- 
1.5.6.5
