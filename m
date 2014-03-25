From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 039/144] t3910-mac-os-precompose.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:24:44 -0700
Message-ID: <1395735989-3396-40-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:34:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMoq-0007ck-FJ
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:34:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754085AbaCYIec convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:34:32 -0400
Received: from mail-pb0-f48.google.com ([209.85.160.48]:35811 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753772AbaCYI1W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:27:22 -0400
Received: by mail-pb0-f48.google.com with SMTP id md12so133330pbc.7
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=2UAxZ4VquJhcvSRdZdOHV1ta6O9RjLdqFj7tXZNd/3U=;
        b=xqy9DEB8nZVKi/3Lab+W4lECfKeXbixIoagna57ZKrBHUipmylz0olfcFeiRSQHAM0
         25FHyMeW+9aMyGCpRA4hKJ2sbJBuV+9IBqcZjaR3didzpExoIxfQ074HdyscNizKIJwd
         hiU827J+Ea4mryCr9Jfnb34TGxUHTxAtDX99Ea+Fq2TpijhCSooqW7aghuXDPjH29vev
         70bZU2Uan/KVSl73pWJM8QHlck8surU8x1BwMbPvyDV9KKiif9BQNyDSplX9m1g0GmSz
         GjW6X7W0y17pHP3jGxtkqWb1z9suptM8lxtq/vW5HBymEL1gCh0/APej3b73ql5h9w7p
         KNuQ==
X-Received: by 10.68.136.133 with SMTP id qa5mr76812047pbb.63.1395736042009;
        Tue, 25 Mar 2014 01:27:22 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.27.20
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:27:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244988>

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
 t/t3910-mac-os-precompose.sh |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t3910-mac-os-precompose.sh b/t/t3910-mac-os-precompose.s=
h
index e4ba601..96941e9 100755
--- a/t/t3910-mac-os-precompose.sh
+++ b/t/t3910-mac-os-precompose.sh
@@ -14,13 +14,13 @@ then
 fi
=20
 # create utf-8 variables
-Adiarnfc=3D`printf '\303\204'`
-Adiarnfd=3D`printf 'A\314\210'`
+Adiarnfc=3D$(printf '\303\204')
+Adiarnfd=3D$(printf 'A\314\210')
=20
-Odiarnfc=3D`printf '\303\226'`
-Odiarnfd=3D`printf 'O\314\210'`
-AEligatu=3D`printf '\303\206'`
-Invalidu=3D`printf '\303\377'`
+Odiarnfc=3D$(printf '\303\226')
+Odiarnfd=3D$(printf 'O\314\210')
+AEligatu=3D$(printf '\303\206')
+Invalidu=3D$(printf '\303\377')
=20
=20
 #Create a string with 255 bytes (decomposed)
@@ -35,7 +35,7 @@ Alongc=3D$Alongc$Alongc$Alongc$Alongc$Alongc         =
  #250 Byte
 Alongc=3D$Alongc$AEligatu$AEligatu                     #254 Byte
=20
 test_expect_success "detect if nfd needed" '
-	precomposeunicode=3D`git config core.precomposeunicode` &&
+	precomposeunicode=3D$(git config core.precomposeunicode) &&
 	test "$precomposeunicode" =3D true &&
 	git config core.precomposeunicode true
 '
@@ -146,7 +146,7 @@ test_expect_success "respect git config --global co=
re.precomposeunicode" '
 	git config --global core.precomposeunicode true &&
 	rm -rf .git &&
 	git init &&
-	precomposeunicode=3D`git config core.precomposeunicode` &&
+	precomposeunicode=3D$(git config core.precomposeunicode) &&
 	test "$precomposeunicode" =3D "true"
 '
=20
--=20
1.7.10.4
