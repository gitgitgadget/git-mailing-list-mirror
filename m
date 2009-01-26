From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv2 2/6] gitweb: feed generator metadata
Date: Mon, 26 Jan 2009 12:50:12 +0100
Message-ID: <1232970616-21167-3-git-send-email-giuseppe.bilotta@gmail.com>
References: <1232970616-21167-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1232970616-21167-2-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 26 12:51:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRQ08-0003vA-AB
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 12:51:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753083AbZAZLuM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 06:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753043AbZAZLuK
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 06:50:10 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:62961 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752918AbZAZLuE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 06:50:04 -0500
Received: by mail-ew0-f21.google.com with SMTP id 14so329602ewy.13
        for <git@vger.kernel.org>; Mon, 26 Jan 2009 03:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=gM+xUk2TuTnIIMxz8UteP9+Q5k6+svlRynVgFbgwzys=;
        b=K91VaEMCz0MtsORJhwJDCNb+YrPGFRWiJec85VgDJgAYiX6enXP/cZSqyjFiuUjzQ+
         AoNRJw6OCD8pG+VuHcKM0sH9xfG3PrlgobZP0atCv9QM+L6AlYt7HQKfuymtbz+ZPfF8
         0O5vwT8f0QOy3dqetOstSNjjUxYUl8aS+6veY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=yBgPHA1pYKm3d24VUR/VwEJWdBXSnu5jYTdDFJhjSoEPYEo3xe5bSdf4i7zf4l3yCL
         tUVAs8CMOft2af3bP6P6i3r4hNNifIqa+h4Fe/kSHGv48YNgT3Eq20hJgsuHg+7DG46t
         0tkRSjrzEqEcufBjtGCK9zx/V28eORyx4cLes=
Received: by 10.103.92.8 with SMTP id u8mr2095171mul.12.1232970603584;
        Mon, 26 Jan 2009 03:50:03 -0800 (PST)
Received: from localhost ([94.37.14.37])
        by mx.google.com with ESMTPS id y6sm23616398mug.32.2009.01.26.03.50.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Jan 2009 03:50:02 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1232970616-21167-2-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107196>

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
