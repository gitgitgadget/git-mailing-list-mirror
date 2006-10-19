From: pclouds@gmail.com
Subject: [PATCH] Don't segfault if the given SHA1 name is longer than 40 characters
Date: Thu, 19 Oct 2006 08:34:41 +0700
Message-ID: <20061019013441.GB9379@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Thu Oct 19 03:38:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaMrn-00066Z-Hk
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 03:38:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945964AbWJSBig convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 18 Oct 2006 21:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945960AbWJSBig
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 21:38:36 -0400
Received: from zeus2.kernel.org ([204.152.191.36]:61130 "EHLO zeus2.kernel.org")
	by vger.kernel.org with ESMTP id S1945965AbWJSBif (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Oct 2006 21:38:35 -0400
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.179])
	by zeus2.kernel.org (8.13.7/8.13.1) with ESMTP id k9J1cMum027855
	for <git@vger.kernel.org>; Thu, 19 Oct 2006 01:38:35 GMT
Received: by py-out-1112.google.com with SMTP id n25so590568pyg
        for <git@vger.kernel.org>; Wed, 18 Oct 2006 18:36:17 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:bcc:subject:message-id:mime-version:content-type:content-disposition:content-transfer-encoding:user-agent:from;
        b=YR68Yn3TyvMkcDzkvq+Rgu9bpWZGeDkYdVDrcAoMgQEVo3GPJ+uGDVyY/x/qR3wuGd6E6Vd5tIgsFyjGnhtAjpq416ADAtGoekDr6UNRVm3iJyhKSLkH6Zz+sfwhvQbkDkAr7xAXY9jWVLha1PTnqs5Q6sbdwIdaSXexC0zceB4=
Received: by 10.35.8.13 with SMTP id l13mr18944520pyi;
        Wed, 18 Oct 2006 18:36:17 -0700 (PDT)
Received: from localhost ( [125.234.255.91])
        by mx.google.com with ESMTP id p4sm1570727nzc.2006.10.18.18.36.14;
        Wed, 18 Oct 2006 18:36:17 -0700 (PDT)
Received: by localhost (sSMTP sendmail emulation); Thu, 19 Oct 2006 08:34:41 +0700
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Virus-Scanned: ClamAV 0.88.4/2041/Wed Oct 18 06:29:52 2006 on zeus2.kernel.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29312>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 sha1_name.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 9b226e3..6ffee22 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -157,7 +157,7 @@ static int get_short_sha1(const char *na
 	char canonical[40];
 	unsigned char res[20];
=20
-	if (len < MINIMUM_ABBREV)
+	if (len < MINIMUM_ABBREV || len > 40)
 		return -1;
 	hashclr(res);
 	memset(canonical, 'x', 40);
--=20
1.4.3.rc2.g0503-dirty
