From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 2/4] gitweb: feed generator metadata
Date: Fri, 23 Jan 2009 05:48:39 +0100
Message-ID: <1232686121-1800-3-git-send-email-giuseppe.bilotta@gmail.com>
References: <1232686121-1800-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1232686121-1800-2-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 23 05:50:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQDzk-00049L-Uf
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 05:50:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755882AbZAWEsf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 23:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755644AbZAWEsd
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 23:48:33 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:61810 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755259AbZAWEsb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 23:48:31 -0500
Received: by fg-out-1718.google.com with SMTP id 19so2404923fgg.17
        for <git@vger.kernel.org>; Thu, 22 Jan 2009 20:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=gM+xUk2TuTnIIMxz8UteP9+Q5k6+svlRynVgFbgwzys=;
        b=UGzaxROsYOzN3MGwyilT4BvS9AuyHHYojWEoPiGQZdabqdSky7GuMERmtwdf7FWUuK
         7OHh/UL9Ow42ZMVXWnV858LwtZooqFd+sGEqXVjYt8TIN0PkgqFRXmvYBfVTO3fmfNGd
         g9V+rXm7L5QQYCwAwoiqTYjRG4wK1My43mzh0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=lJ/p3QTl/lOcF+lINXnFW/C64uiulJY0G8X0vA7BzzroV/JBUzNGHBxAgrFFP/wRhT
         UmPQiOfpDMGJfGdwZP0Ua+GKalLKXQo66ytmQjhiJrXjiUYWcAxVVFjU5qmkYaDMmeaT
         4fyEr+JVYgkgSTP0p7TTeuZ4vu4SGJgPJeoTE=
Received: by 10.86.68.2 with SMTP id q2mr521833fga.68.1232686110534;
        Thu, 22 Jan 2009 20:48:30 -0800 (PST)
Received: from localhost ([94.37.14.37])
        by mx.google.com with ESMTPS id 12sm8582594fgg.46.2009.01.22.20.48.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 22 Jan 2009 20:48:30 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1232686121-1800-2-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106833>

Add <generator> tag to RSS and Atom feed. Versioning info (gitweb/git
core versions, separated by a literal slash) is stored in the
appropriate attribute for the Atom feed, and in the tag content for the
RSS feed.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index f8a5d2e..3d94f50 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -6085,6 +6085,7 @@ XML
 			      "<link>$alt_url</link>\n" .
 			      "</image>\n";
 		}
+		print "<generator>gitweb v.$version/$git_version</generator>\n";
 	} elsif ($format eq 'atom') {
 		print <<XML;
 <feed xmlns="http://www.w3.org/2005/Atom">
@@ -6111,6 +6112,7 @@ XML
 		} else {
 			print "<updated>$latest_date{'iso-8601'}</updated>\n";
 		}
+		print "<generator version='$version/$git_version'>gitweb</generator>\n";
 	}
 
 	# contents
-- 
1.5.6.5
