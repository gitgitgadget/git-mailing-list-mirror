From: Andrej Andb <admin@andrej-andb.ru>
Subject: [PATCH] remove protocol from gravatar and picon links for clear if Gitweb is being called through a secure server
Date: Mon, 28 Jan 2013 20:14:50 +0100
Message-ID: <1359400490-16449-1-git-send-email-admin@andrej-andb.ru>
Cc: Andrej Andb <admin@andrej-andb.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 28 20:15:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzuAp-0004Ap-El
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 20:15:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753104Ab3A1TO5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 14:14:57 -0500
Received: from mail-ee0-f51.google.com ([74.125.83.51]:59456 "EHLO
	mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751415Ab3A1TO4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 14:14:56 -0500
Received: by mail-ee0-f51.google.com with SMTP id d17so1455340eek.38
        for <git@vger.kernel.org>; Mon, 28 Jan 2013 11:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=andrej-andb.ru; s=google;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=FIXZ+h3eOtwQrabbeo4IVp4zA1dD3jM6n7l6DHAP7WE=;
        b=QPfkZiDS24rXAuuKNPRHbJ4/57n7LNjKDZ7h2OaMPiyh8KZKUaRD/NXApy13xR1jZ/
         C0ENIOXJLcVNRPgscBV5BLYBoIiZa5e3+UOoaLimAtVTahOQaT3fseOYTqH45tgMmaKN
         iTdYPQtLHosadNE84fOhOzSc4GxIPXDWHy34k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer
         :x-gm-message-state;
        bh=FIXZ+h3eOtwQrabbeo4IVp4zA1dD3jM6n7l6DHAP7WE=;
        b=Ex8qR/G3tVKVMXPXbiISBsqz938hz4wtGmpPd3lVidDCMQLjvQO3fSqdVYgL8fmjoM
         9grpnIz+KHFHiyJnBQ04XIg+tuYLaYsdzVkcJNlVoQ+2TGptHS8fmc6h2YWtV5M9C+wb
         LIZHgVKtXxKD6j4mBkWv1G/iEm+xCqSo1ivDYT7CLJf+05QDBtGO78tgmlqVVLbep695
         lSDAnuik+X42b/8q4n9+Mt+MBq0x15Vw4pPm/stNrSfoImUZSBYCA5uNif4JHMyQ+KfI
         aYSQBpxl4IFUm09zYt77Z8H6qhFi9msZbGGw/+7752SAkZOLoJ2atLerpDS1HqscTLEn
         tCig==
X-Received: by 10.14.206.132 with SMTP id l4mr14351720eeo.38.1359400495405;
        Mon, 28 Jan 2013 11:14:55 -0800 (PST)
Received: from andrej-andb.ru.ru (andrej-andb.ru. [78.46.145.210])
        by mx.google.com with ESMTPS id o3sm13359872eem.15.2013.01.28.11.14.54
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Jan 2013 11:14:54 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1
X-Gm-Message-State: ALoCoQnDT1GItD9UFehWIz8J0heHUXu31h/e08S2jqk0Wt5F/OyLh4EHgy6+QbZmojIKbZgW6Pw6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214857>

---
 gitweb/gitweb.perl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c6bafe6..1309196 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2068,7 +2068,7 @@ sub picon_url {
 	if (!$avatar_cache{$email}) {
 		my ($user, $domain) = split('@', $email);
 		$avatar_cache{$email} =
-			"http://www.cs.indiana.edu/cgi-pub/kinzler/piconsearch.cgi/" .
+			"//www.cs.indiana.edu/cgi-pub/kinzler/piconsearch.cgi/" .
 			"$domain/$user/" .
 			"users+domains+unknown/up/single";
 	}
@@ -2083,7 +2083,7 @@ sub gravatar_url {
 	my $email = lc shift;
 	my $size = shift;
 	$avatar_cache{$email} ||=
-		"http://www.gravatar.com/avatar/" .
+		"//www.gravatar.com/avatar/" .
 			Digest::MD5::md5_hex($email) . "?s=";
 	return $avatar_cache{$email} . $size;
 }
-- 
1.8.1.1
