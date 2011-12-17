From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/3] gitweb: esc_html() site name for title in OPML
Date: Sat, 17 Dec 2011 10:15:23 +0100
Message-ID: <1324113324-21328-3-git-send-email-jnareb@gmail.com>
References: <1324113324-21328-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Juergen Kreileder <jk@blackdown.de>,
	John Hawley <warthog9@kernel.org>, admin@repo.or.cz
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 17 10:16:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbqNo-0000v5-63
	for gcvg-git-2@lo.gmane.org; Sat, 17 Dec 2011 10:16:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422Ab1LQJQj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Dec 2011 04:16:39 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:53439 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987Ab1LQJQH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Dec 2011 04:16:07 -0500
Received: by eekc4 with SMTP id c4so3910031eek.19
        for <git@vger.kernel.org>; Sat, 17 Dec 2011 01:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=8H42s5ewMNgnV1M2c9SV2/KntUTIMKR2YHdJYd8wHeo=;
        b=YUYgjzKU9prXY8js4XRl+TeKuT/nLJd6XnF0NLp9vSc0Q++jOriMW/D4n2T/ZFdOos
         z8m1T2JbWsHZ2WTul+6IAU3o9jVQ/esu81zdN/gkeUYVKWAXTjrOYJHV9FNT964ecrvd
         oUu/kvuECIhRM+2XDYacybOiBImt5VRF9Igsk=
Received: by 10.14.2.71 with SMTP id 47mr209340eee.16.1324113365969;
        Sat, 17 Dec 2011 01:16:05 -0800 (PST)
Received: from localhost.localdomain (abrz159.neoplus.adsl.tpnet.pl. [83.8.119.159])
        by mx.google.com with ESMTPS id q28sm10728465eea.6.2011.12.17.01.16.04
        (version=SSLv3 cipher=OTHER);
        Sat, 17 Dec 2011 01:16:05 -0800 (PST)
X-Mailer: git-send-email 1.7.6
In-Reply-To: <1324113324-21328-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187355>

=46rom: J=FCrgen Kreileder <jk@blackdown.de>

This escapes the site name in OPML (XML uses the same escaping rules
as HTML).  Also fixes encoding issues because esc_html() uses
to_utf8().

Signed-off-by: J=FCrgen Kreileder <jk@blackdown.de>
Acked-by: Jakub Nar=EAbski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 35126cd..dcf4658 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -7863,11 +7863,12 @@ sub git_opml {
 		-charset =3D> 'utf-8',
 		-content_disposition =3D> 'inline; filename=3D"opml.xml"');
=20
+	my $title =3D esc_html($site_name);
 	print <<XML;
 <?xml version=3D"1.0" encoding=3D"utf-8"?>
 <opml version=3D"1.0">
 <head>
-  <title>$site_name OPML Export</title>
+  <title>$title OPML Export</title>
 </head>
 <body>
 <outline text=3D"git RSS feeds">
--=20
1.7.6
