From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/6] t5538: fix default http port
Date: Thu,  6 Feb 2014 22:10:35 +0700
Message-ID: <1391699439-22781-3-git-send-email-pclouds@gmail.com>
References: <1391699439-22781-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 06 16:11:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBQc9-0005XY-Nk
	for gcvg-git-2@plane.gmane.org; Thu, 06 Feb 2014 16:11:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753212AbaBFPLg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Feb 2014 10:11:36 -0500
Received: from mail-pb0-f48.google.com ([209.85.160.48]:60741 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752755AbaBFPLf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Feb 2014 10:11:35 -0500
Received: by mail-pb0-f48.google.com with SMTP id rr13so1858396pbb.21
        for <git@vger.kernel.org>; Thu, 06 Feb 2014 07:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=TeJATesII5mtURmsIJO1bizQQGk+QXddkVd2qy+Ed04=;
        b=KhVqkQ48KYFROSpSyxOVNfDnE4An5K5OZlps3J/GbJCHtaIUBuZ9zGU6M6Fd0b4RnY
         tdvzHc41zZXDTEHejKwKWLXVNEcBr5z8ZVXA9MHed6v0bU4lYcQsWKSX+mZBNCtw8iKw
         10Qt9DqBDNOeY+pOJHCLriFw1A0It5FFs+8WmUzqSF9903OgwrpP014Oy9N7Ml1UIIxP
         ZNHeQsI2QAI2gZMzWzsMfQh1N1qr9HdhfaB2rzrUyXb0fPu5jCSOl50zXG+cwSJ7AdVz
         HxHshsVblI5h6aN4cn31AJ79o9QkxzegwGGR55K9RKrFNz4WOE57cj5oJhe5oc+/Asob
         kNIQ==
X-Received: by 10.66.137.109 with SMTP id qh13mr1186833pab.140.1391699495330;
        Thu, 06 Feb 2014 07:11:35 -0800 (PST)
Received: from lanh ([115.73.207.183])
        by mx.google.com with ESMTPSA id pp5sm4334438pbb.33.2014.02.06.07.11.31
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 06 Feb 2014 07:11:34 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 06 Feb 2014 22:11:34 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1391699439-22781-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241696>

Originally I had t5537 use port 5536 and 5538 use port 5537(!). Then
Jeff found my fault so I changed port in t5537 from 5536 to 5537 in
3b32a7c (t5537: fix incorrect expectation in test case 10 -
2014-01-08). Which makes it worse because now both t5537 and t5538
both use the same port. Fix it.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t5538-push-shallow.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5538-push-shallow.sh b/t/t5538-push-shallow.sh
index 0a6e40f..19fe425 100755
--- a/t/t5538-push-shallow.sh
+++ b/t/t5538-push-shallow.sh
@@ -126,7 +126,7 @@ if test -n "$NO_CURL" -o -z "$GIT_TEST_HTTPD"; then
 	test_done
 fi
=20
-LIB_HTTPD_PORT=3D${LIB_HTTPD_PORT-'5537'}
+LIB_HTTPD_PORT=3D${LIB_HTTPD_PORT-'5538'}
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
=20
--=20
1.8.5.2.240.g8478abd
