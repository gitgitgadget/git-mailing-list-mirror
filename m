From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv6 6/8] gitweb: add 'alt' to avatar images
Date: Thu, 25 Jun 2009 12:43:05 +0200
Message-ID: <1245926587-25074-7-git-send-email-giuseppe.bilotta@gmail.com>
References: <1245926587-25074-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1245926587-25074-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1245926587-25074-3-git-send-email-giuseppe.bilotta@gmail.com>
 <1245926587-25074-4-git-send-email-giuseppe.bilotta@gmail.com>
 <1245926587-25074-5-git-send-email-giuseppe.bilotta@gmail.com>
 <1245926587-25074-6-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 25 12:44:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJmQy-0008IK-3X
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 12:44:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757435AbZFYKna (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2009 06:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757488AbZFYKn2
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 06:43:28 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:47512 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757263AbZFYKnU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2009 06:43:20 -0400
Received: by mail-bw0-f213.google.com with SMTP id 9so1301579bwz.37
        for <git@vger.kernel.org>; Thu, 25 Jun 2009 03:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=JQQbXMZFAQrnkK1D1CAxWIvLY2V3096pWh/Ne8K5eKI=;
        b=HTACu63fTg/rWSsP9LtvbrfScZ5lM/FVy084kp5lj7PAER/5oDgO20p4rZ9jGXWL7B
         Ei8USEVJwHA28VmzLQlo/duoiXa/MDYTymTvPsx4RLXiQzsCCYzzbR5gEHsXot5WZ4EV
         2OHtj/WZrkTEwzrHWUMSL5IyGGrRYOAWGSQc0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=F0rAmbE1MAPEtmkmyH8+xD4GyNwIzOZxFt8vPTOcZngW1XPvlsd94bsfBjBA592a8t
         9zT4ugd1N0Xrq24YQAgsJq7z+xEQURrtk3mZhrTiEielqlDsINBjHPab2udfuCLNI7AQ
         riI0VBKgQ0dAtk5yj+0m0bvQ9/RutDdy9iDNQ=
Received: by 10.204.112.205 with SMTP id x13mr2298915bkp.170.1245926602949;
        Thu, 25 Jun 2009 03:43:22 -0700 (PDT)
Received: from localhost (dynamic-adsl-94-37-13-28.clienti.tiscali.it [94.37.13.28])
        by mx.google.com with ESMTPS id 19sm1064828fkr.25.2009.06.25.03.43.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Jun 2009 03:43:22 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.rc1.192.gdbfcb
In-Reply-To: <1245926587-25074-6-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122202>

Without it, text-only browsers display the URL of the avatar, which can
be long and not very informative. We use the avatar provider name for
the alt text.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index d3bc849..3e6786b 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3294,7 +3294,7 @@ sub git_get_avatar {
 	# as needed. If no variant puts something in $url, we assume avatars
 	# are completely disabled/unavailable.
 	if ($url) {
-		return $pre_white . "<img class=\"avatar\" src=\"$url\" />" . $post_white;
+		return $pre_white . "<img class=\"avatar\" src=\"$url\" alt=\"$git_avatar\" />" . $post_white;
 	} else {
 		return "";
 	}
-- 
1.6.3.rc1.192.gdbfcb
