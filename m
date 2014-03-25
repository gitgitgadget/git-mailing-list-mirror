From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 090/144] t7103-reset-bare.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:25:35 -0700
Message-ID: <1395735989-3396-91-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:28:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMii-00008U-SG
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:28:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753950AbaCYI2S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:28:18 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:62534 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134AbaCYI2Q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:28:16 -0400
Received: by mail-pa0-f51.google.com with SMTP id kq14so126878pab.24
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=pCIuafJcfT1oSjvsbV3QO1H8stGSnIwN6OM/KmEv2ic=;
        b=y3KHQfClYtmlaWJXLMT8GiEZml1y3rTI2PufIx8SkHDohjnotWrDB2z/IEQ0kgJ4QN
         mSSLH2+dK0i5DXm47ObexO8MwAvwm7t9cqRKyzejRTvLVQGTFl18LpWDWIFkh3GpNKTF
         rgDVbDwo5Pvcaxl8ltnGFuzY1g9/PANi5Mc8aDyp+Po/tbSo/csxgI92Zesxge6MGmeT
         A5XLi0kmDy9S8eAZCQr2UT212uTTQ6wjocgNyg2UDdi0KKZf1gt2GTFqs/PTsXaMBmlx
         Bt5gIA4TV9pWXXqqIXZtSnpGKxXiLADSAKo2pEoZ3Fj9TYRb9Gwdm7F7FmT0913IGZOJ
         YVXg==
X-Received: by 10.66.122.72 with SMTP id lq8mr78402980pab.69.1395736095432;
        Tue, 25 Mar 2014 01:28:15 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.28.14
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:28:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244935>

The Git CodingGuidelines prefer the $( ... ) construct for command
substitution instead of using the back-quotes, or grave accents (`..`).

The backquoted form is the historical method for command substitution,
and is supported by POSIX. However,all but the simplest uses become
complicated quickly. In particular,embedded command substitutions
and/or the use of double quotes require careful escaping with the backs=
lash
character. Because of this the POSIX shell adopted the $(=E2=80=A6) fea=
ture from
the Korn shell.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 t/t7103-reset-bare.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7103-reset-bare.sh b/t/t7103-reset-bare.sh
index 1eef93c..afe36a5 100755
--- a/t/t7103-reset-bare.sh
+++ b/t/t7103-reset-bare.sh
@@ -63,7 +63,7 @@ test_expect_success '"mixed" reset is not allowed in =
bare' '
=20
 test_expect_success '"soft" reset is allowed in bare' '
 	git reset --soft HEAD^ &&
-	test "`git show --pretty=3Dformat:%s | head -n 1`" =3D "one"
+	test "$(git show --pretty=3Dformat:%s | head -n 1)" =3D "one"
 '
=20
 test_done
--=20
1.7.10.4
