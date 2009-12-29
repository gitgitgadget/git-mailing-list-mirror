From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] t7102: make the test fail if one of its check fails
Date: Tue, 29 Dec 2009 15:13:18 +0700
Message-ID: <1262074398-14628-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 09:14:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPXDa-0005ht-5V
	for gcvg-git-2@lo.gmane.org; Tue, 29 Dec 2009 09:14:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752663AbZL2IOJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Dec 2009 03:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752624AbZL2IOJ
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Dec 2009 03:14:09 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:35626 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752614AbZL2IOI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2009 03:14:08 -0500
Received: by ywh6 with SMTP id 6so11076571ywh.4
        for <git@vger.kernel.org>; Tue, 29 Dec 2009 00:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=s2zX6biWfW9uYxnElVoccnCWk2tpYpZLXXlLtpAXvt4=;
        b=aF6F+d8IS828fJJz1CAnObMh5GcXhEPOrWjGQ0Lwwhtv5uIbygyWTZ053riEkKMjIb
         so2WRc7ZXTJJTBqxewktLFjlFIt+q8kqrfouE8w3nDflsTFknZqcV5XHCART9zJyArpP
         CVCnsPYX2Kh8qpoWus1OEMhT/EH3Z4bhVKue0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=MkOLx2OFACRl0UZuoL6qEIxwasxsAkt+xr8Gjg8ns5H93pYWfPAw+kTzVDAEmsXZf2
         yAU+c6YYrL/WzvHcy8S/P7BD5k4yhXaTfSZEVpisppX0r7bdYbMJikxhtuQR0+PYSCbn
         LNooNxZyYDmJfYbDFzIzTzqM5bxuO1zW1Hmz8=
Received: by 10.101.142.22 with SMTP id u22mr24606541ann.117.1262074446284;
        Tue, 29 Dec 2009 00:14:06 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.227.183])
        by mx.google.com with ESMTPS id 21sm11666730iwn.2.2009.12.29.00.14.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 29 Dec 2009 00:14:05 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 29 Dec 2009 15:13:20 +0700
X-Mailer: git-send-email 1.6.5.2.216.g9c1ec
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135783>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t7102-reset.sh |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index e85ff02..b8cf260 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -139,19 +139,19 @@ test_expect_success \
 test_expect_success \
 	'resetting to HEAD with no changes should succeed and do nothing' '
 	git reset --hard &&
-		check_changes 3ec39651e7f44ea531a5de18a9fa791c0fd370fc
+		check_changes 3ec39651e7f44ea531a5de18a9fa791c0fd370fc &&
 	git reset --hard HEAD &&
-		check_changes 3ec39651e7f44ea531a5de18a9fa791c0fd370fc
+		check_changes 3ec39651e7f44ea531a5de18a9fa791c0fd370fc &&
 	git reset --soft &&
-		check_changes 3ec39651e7f44ea531a5de18a9fa791c0fd370fc
+		check_changes 3ec39651e7f44ea531a5de18a9fa791c0fd370fc &&
 	git reset --soft HEAD &&
-		check_changes 3ec39651e7f44ea531a5de18a9fa791c0fd370fc
+		check_changes 3ec39651e7f44ea531a5de18a9fa791c0fd370fc &&
 	git reset --mixed &&
-		check_changes 3ec39651e7f44ea531a5de18a9fa791c0fd370fc
+		check_changes 3ec39651e7f44ea531a5de18a9fa791c0fd370fc &&
 	git reset --mixed HEAD &&
-		check_changes 3ec39651e7f44ea531a5de18a9fa791c0fd370fc
+		check_changes 3ec39651e7f44ea531a5de18a9fa791c0fd370fc &&
 	git reset &&
-		check_changes 3ec39651e7f44ea531a5de18a9fa791c0fd370fc
+		check_changes 3ec39651e7f44ea531a5de18a9fa791c0fd370fc &&
 	git reset HEAD &&
 		check_changes 3ec39651e7f44ea531a5de18a9fa791c0fd370fc
 '
--=20
1.6.5.2.216.g9c1ec
