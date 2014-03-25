From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 091/144] t7406-submodule-update.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:25:36 -0700
Message-ID: <1395735989-3396-92-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:29:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMjo-0001Q1-I5
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:29:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753351AbaCYI3a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:29:30 -0400
Received: from mail-pb0-f41.google.com ([209.85.160.41]:41463 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753945AbaCYI2R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:28:17 -0400
Received: by mail-pb0-f41.google.com with SMTP id jt11so134163pbb.14
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=LkcmQl7B8eFGYz5JTz0O4m1JxkG7gyuykHA39tLqIAc=;
        b=sepWpD3jCfWPflqt3sFA38OWJXUqCWBPutL05iB/IowyzatSQWpymjdIzRLFAJBYTh
         h4g7UpFtqXhEHn27l6ve8UvON3gXmrijFM8FKMcpj3BG7NTJV+IfULtrIrG/5cw1Vf1v
         Fv5u6UlLg9MSNB+I0JuN+kNizpI+BAlfaz3KLusBICCv79rUnKNzkuph38VGM/50Odsc
         bxVmu/wpP6mE8aYxhvdQK6pkwXPXfBrlxyPrA35PnasARl3oqOl1ThfOP5utxdVio+eV
         DK2oXL8HUHrpfPnDYDaPypP3whidhk1/6o4Cf/d5bi3Im+MlwMg5WByESkH1h57Vw6RW
         XrbQ==
X-Received: by 10.68.200.133 with SMTP id js5mr14404524pbc.138.1395736096408;
        Tue, 25 Mar 2014 01:28:16 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.28.15
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:28:15 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244947>

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
 t/t7406-submodule-update.sh |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 28ca763..294a4a6 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -14,8 +14,8 @@ submodule and "git submodule update --rebase/--merge"=
 does not detach the HEAD.
=20
 compare_head()
 {
-    sha_master=3D`git rev-list --max-count=3D1 master`
-    sha_head=3D`git rev-list --max-count=3D1 HEAD`
+    sha_master=3D$(git rev-list --max-count=3D1 master)
+    sha_head=3D$(git rev-list --max-count=3D1 HEAD)
=20
     test "$sha_master" =3D "$sha_head"
 }
--=20
1.7.10.4
