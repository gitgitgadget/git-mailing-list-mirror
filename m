From: =?UTF-8?Q?J=C3=BCrgen_Kreileder?= <jk@blackdown.de>
Subject: [PATCH] gitweb: Output site name with valid utf8 in OPML
Date: Mon, 28 Nov 2011 02:45:46 +0100
Message-ID: <CAKD0UuyJDaHyofM5VYG-R03mgYi_1QBJvQufv927+x6YYzPU2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 28 02:46:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RUqIR-00067H-UA
	for gcvg-git-2@lo.gmane.org; Mon, 28 Nov 2011 02:46:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755869Ab1K1BqJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Nov 2011 20:46:09 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:49203 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755538Ab1K1BqI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Nov 2011 20:46:08 -0500
Received: by wwp14 with SMTP id 14so7962667wwp.1
        for <git@vger.kernel.org>; Sun, 27 Nov 2011 17:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackdown.de; s=google;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=/8SJtOnHHvbpg3cGldNEZ3UVgufntmFubHZO3CQ10bI=;
        b=V1qNAtaIik0XKGg2T56kudUAq9fpCJHPyD3BCCvDz6vAe7gEwg7AOY1mJPygffyIS5
         nOIvVJQQNtl6hVp6cHgIkhNyezdJKnnS0j7KsJ8TruYrJCXe71j0nDx3RfoWeFFUsPEi
         dmmXtQLctDdF3QDZpv/Z2PBDnY0ECosCuPWZE=
Received: by 10.216.137.136 with SMTP id y8mr1307470wei.2.1322444767305; Sun,
 27 Nov 2011 17:46:07 -0800 (PST)
Received: by 10.180.87.37 with HTTP; Sun, 27 Nov 2011 17:45:46 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185998>

Signed-off-by: Juergen Kreileder <jk@blackdown.de>
---
 gitweb/gitweb.perl |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 4f0c3bd..df747c1 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -7699,11 +7699,12 @@ sub git_opml {
 		-charset => 'utf-8',
 		-content_disposition => 'inline; filename="opml.xml"');

+	my $title = esc_html($site_name);
 	print <<XML;
 <?xml version="1.0" encoding="utf-8"?>
 <opml version="1.0">
 <head>
-  <title>$site_name OPML Export</title>
+  <title>$title OPML Export</title>
 </head>
 <body>
 <outline text="git RSS feeds">
-- 
1.7.5.4
