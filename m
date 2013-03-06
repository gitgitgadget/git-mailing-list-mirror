From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] git-push.txt: mention about remote.*.push when no refspec is given
Date: Wed,  6 Mar 2013 19:44:08 +0700
Message-ID: <1362573848-21793-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 06 13:43:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDDgx-00063E-QM
	for gcvg-git-2@plane.gmane.org; Wed, 06 Mar 2013 13:43:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753442Ab3CFMnG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Mar 2013 07:43:06 -0500
Received: from mail-pb0-f41.google.com ([209.85.160.41]:54544 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752345Ab3CFMnD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Mar 2013 07:43:03 -0500
Received: by mail-pb0-f41.google.com with SMTP id um15so6013429pbc.28
        for <git@vger.kernel.org>; Wed, 06 Mar 2013 04:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=bxVesSpCfq5tVx7GenBJxt9tJ1Es9qChXl6gCPE++CI=;
        b=XSw3TenAm3N+lZ4QD+/cQPanvb9q8FPVqhJx9Wan5icAj3THhv93I+enkdDWomxP28
         HAjiQX7LYTCDw0glUnd8McoU7OcY5po7WBchl7uzUjbNdnWCjsSkjSn7fSO46cDL45P3
         dIcEJfjXNK/P5uQScwecovrSuYabnfU1iUEsk6TJkbl4AMxxgm4UudK1jB4PnyEZxndv
         Ae/Hzg8iFGor/1C3UMQvinoiggy0W/eG6vTyIHQ9xkzwncF6UuuqHjdvYht2sdeSXpgp
         bX66X4Eudj5ODJY0RcwexEjak5V0hnpc+VFKtkFFRxyIdFVXVMkTohIAjqs7fowfd3+k
         CGoQ==
X-Received: by 10.68.191.9 with SMTP id gu9mr46343151pbc.23.1362573782791;
        Wed, 06 Mar 2013 04:43:02 -0800 (PST)
Received: from lanh ([115.74.63.193])
        by mx.google.com with ESMTPS id ol7sm31189614pbb.14.2013.03.06.04.42.59
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 06 Mar 2013 04:43:01 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 06 Mar 2013 19:44:10 +0700
X-Mailer: git-send-email 1.8.1.2.536.gf441e6d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217523>

remote.*.push is considered before push.default, but there's no
mention about that, except a bit in the examples. The description
of push.default does say something about this, but it would be easier
to find out if it's described here.

The first paragraph describing refspec format is moved down, so that
the new first paragraph is about unspsecified refspec and the
remaining paragraphs refspec format.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-push.txt | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 1398025..20bf2f5 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -33,13 +33,16 @@ OPTIONS[[OPTIONS]]
 	of a remote (see the section <<REMOTES,REMOTES>> below).
=20
 <refspec>...::
-	The format of a <refspec> parameter is an optional plus
-	`+`, followed by the source ref <src>, followed
-	by a colon `:`, followed by the destination ref <dst>.
-	It is used to specify with what <src> object the <dst> ref
-	in the remote repository is to be updated.  If not specified,
-	the behavior of the command is controlled by the `push.default`
-	configuration variable.
+	Specify how how refs are pushed. If not specified and
+	configuration variable `remote.<remote>.push` is set, the
+	variable is used as default refspec. If not specified and the
+	variable is not set, the behavior of the command is controlled
+	by the `push.default` configuration variable.
++
+The format of a <refspec> parameter is an optional plus `+`, followed
+by the source ref <src>, followed by a colon `:`, followed by the
+destination ref <dst>.  It is used to specify with what <src> object
+the <dst> ref in the remote repository is to be updated.
 +
 The <src> is often the name of the branch you would want to push, but
 it can be any arbitrary "SHA-1 expression", such as `master~4` or
--=20
1.8.1.2.536.gf441e6d
