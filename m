From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 3/4] gitweb: rss feed managingEditor
Date: Fri, 23 Jan 2009 05:48:40 +0100
Message-ID: <1232686121-1800-4-git-send-email-giuseppe.bilotta@gmail.com>
References: <1232686121-1800-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1232686121-1800-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1232686121-1800-3-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 23 05:50:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQDzl-00049L-KB
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 05:50:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755901AbZAWEsg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 23:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755851AbZAWEsf
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 23:48:35 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:61810 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755562AbZAWEsd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 23:48:33 -0500
Received: by fg-out-1718.google.com with SMTP id 19so2404923fgg.17
        for <git@vger.kernel.org>; Thu, 22 Jan 2009 20:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Ak21Az6eoTPADhTlMoqpOpQ4nDemGlB65PQvjKS9FO4=;
        b=qGhOwHn0T2/QkiyGtNKf8/hrmh+xbPlODt5Mb3CoZzt3iZr76vKYoM4E0Sqs49mR5y
         hgTquijNSsTZ5EMW19E/naU+Y9gsM8T9TgE4ne1KBVOg88fSfHISjfG2IqXnVqNGBmnz
         hwZfNsUwuzZCFy/NfByvUV4l2TYqx9r2VdFCY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=HB5aMlXjQVVw2YoB5GP4nyyvqQJf7r5wgp45uV5uMhIhmKcL/dwOUivBBkd+F9xGmr
         KPW5p/OKa9M3Qi3Hk7qitMR9wfLJv6twRup61Tt6H1fzc0DonJzc77IEaLNXbUT2KOdU
         xSjnpEySks6kiQ4dL1c2U2XBIUYEvcRJceBKM=
Received: by 10.86.57.9 with SMTP id f9mr782416fga.48.1232686112497;
        Thu, 22 Jan 2009 20:48:32 -0800 (PST)
Received: from localhost ([94.37.14.37])
        by mx.google.com with ESMTPS id d4sm3285454fga.51.2009.01.22.20.48.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 22 Jan 2009 20:48:31 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1232686121-1800-3-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106834>

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
