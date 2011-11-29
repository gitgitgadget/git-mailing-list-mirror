From: =?UTF-8?Q?J=C3=BCrgen_Kreileder?= <jk@blackdown.de>
Subject: [PATCH] gitweb: esc_html() site name for title in OPML
Date: Tue, 29 Nov 2011 22:45:08 +0100
Message-ID: <CAKD0Uuy=O43xB6K5pXL575puckK-AQoLKYV1Q9rtadY3CtEF9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 29 22:45:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVVUd-0003mu-EF
	for gcvg-git-2@lo.gmane.org; Tue, 29 Nov 2011 22:45:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754695Ab1K2Vpb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Nov 2011 16:45:31 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42084 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752792Ab1K2Vpa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Nov 2011 16:45:30 -0500
Received: by faaq16 with SMTP id q16so157196faa.19
        for <git@vger.kernel.org>; Tue, 29 Nov 2011 13:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackdown.de; s=google;
        h=mime-version:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=qGWKAqjyUJw0UkJS7HAkeEfQPNjVBTBeDEmFOggVLlE=;
        b=DCKRGNIOWvswFwHxPjp+XiiD6titF57mlvAPkuo4GJZA9RJGRkFNuqK3I3rsXS78cT
         oziG/j6DxA98fWXULTJi4JpI38mIo+90/25Rq2qroKE67yjIVKyflotadyLcLzSQrZLp
         Z8iZ7q9VVftrkCRyQLUlDIPN4gB1MtlwB1XLA=
Received: by 10.180.24.65 with SMTP id s1mr49380228wif.59.1322603129235; Tue,
 29 Nov 2011 13:45:29 -0800 (PST)
Received: by 10.180.87.37 with HTTP; Tue, 29 Nov 2011 13:45:08 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186088>

This escapes the site name in OPML.  Also fixes encoding issues
because esc_html() uses to_utf().

Signed-off-by: J=C3=BCrgen Kreileder <jk@blackdown.de>
---
 gitweb/gitweb.perl |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 4f0c3bd..df747c1 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -7699,11 +7699,12 @@ sub git_opml {
 		-charset =3D> 'utf-8',
 		-content_disposition =3D> 'inline; filename=3D"opml.xml"');

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
1.7.5.4
