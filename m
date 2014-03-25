From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 016/144] t0300-credentials.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:24:21 -0700
Message-ID: <1395735989-3396-17-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:36:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMqj-0001XS-AD
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:36:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753729AbaCYI1K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:27:10 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:60501 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753375AbaCYI05 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:26:57 -0400
Received: by mail-pb0-f43.google.com with SMTP id um1so134212pbc.2
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=LQsVnK4b7xMOLokN62o+GU2aj4HhHBknwmGgXoU6VdM=;
        b=N7uf/O0vQIcsjpga+6ugqjyM4YhgdTpIsOtoVcQodiiCwonR7rr5x/sOQHGIUrV3ab
         3A8ZOctTJb6qLB/GQ38IguiBQwKz342SvE/xi1oOuJut54f/DjSmbiKcTrID6TZHn2DM
         vrCx9Tv7Af12hiWEptPsj25ZnYwX/VO/n2Z3Tbyn+VjqEk8A3SGkyCJfG0+mLtMPNzxY
         boxTQnoI8H3G9/LMLMAldvEHgEg3lRVa33yvgadQ2J9gt+MhweVg4wMqOAxl1MlT8ELy
         JecTT26bpss22wNWcAqnGyoEOEMOMBX7gJ+ksUZyhWWWzIrPzs3C4BRYEYNUdNnDCiJf
         z7QQ==
X-Received: by 10.68.194.65 with SMTP id hu1mr8991651pbc.158.1395736017365;
        Tue, 25 Mar 2014 01:26:57 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.26.56
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:26:56 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244997>

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
 t/t0300-credentials.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
index 538ea5f..57ea5a1 100755
--- a/t/t0300-credentials.sh
+++ b/t/t0300-credentials.sh
@@ -6,7 +6,7 @@ test_description=3D'basic credential helper tests'
=20
 test_expect_success 'setup helper scripts' '
 	cat >dump <<-\EOF &&
-	whoami=3D`echo $0 | sed s/.*git-credential-//`
+	whoami=3D$(echo $0 | sed s/.*git-credential-//)
 	echo >&2 "$whoami: $*"
 	OIFS=3D$IFS
 	IFS=3D=3D
--=20
1.7.10.4
