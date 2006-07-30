From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 11] gitweb: Read project description using utf-8 encoding
Date: Sun, 30 Jul 2006 16:13:47 +0200
Message-ID: <200607301613.49947.jnareb@gmail.com>
References: <200607292239.11034.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Jul 30 16:14:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7C3L-0002us-B5
	for gcvg-git@gmane.org; Sun, 30 Jul 2006 16:13:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbWG3ONs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Jul 2006 10:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbWG3ONs
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Jul 2006 10:13:48 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:29972 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932321AbWG3ONr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Jul 2006 10:13:47 -0400
Received: by ug-out-1314.google.com with SMTP id m3so372506ugc
        for <git@vger.kernel.org>; Sun, 30 Jul 2006 07:13:46 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=EnBUKezj88Kij8GYPIbNFyiYx0jYEOZo5jdYWAj521KVi4dCMZqhVlgBhMc6bjFJBnMsRzQiQddyJrOBVPCBJhqfLqCm/wroy2a/tJ5mHV3q/Y6XnClWlbC9kEzu6nsCKsIj+VlQeSactCY3GgLUuaQfJLskIhwoOn10ha4oJKk=
Received: by 10.66.244.10 with SMTP id r10mr1565937ugh;
        Sun, 30 Jul 2006 07:13:46 -0700 (PDT)
Received: from roke.d-201 ( [193.0.122.19])
        by mx.gmail.com with ESMTP id k30sm4173169ugc.2006.07.30.07.13.45;
        Sun, 30 Jul 2006 07:13:46 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200607292239.11034.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24456>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.cgi |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index d39af82..7d52a2c 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -463,7 +463,7 @@ sub git_read_hash {
 sub git_read_description {
 	my $path = shift;
 
-	open my $fd, "$projectroot/$path/description" or return undef;
+	open (my $fd, "<:utf8", "$projectroot/$path/description") or return undef;
 	my $descr = <$fd>;
 	close $fd;
 	chomp $descr;
-- 
1.4.0
