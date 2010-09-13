From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 2/8] gettextize: git-pull die messages
Date: Mon, 13 Sep 2010 19:35:52 +0000
Message-ID: <1284406558-23684-3-git-send-email-avarab@gmail.com>
References: <1284406558-23684-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 13 21:36:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvEpO-0005HT-Ie
	for gcvg-git-2@lo.gmane.org; Mon, 13 Sep 2010 21:36:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755192Ab0IMTgP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Sep 2010 15:36:15 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:52169 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755187Ab0IMTgN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Sep 2010 15:36:13 -0400
Received: by wwd20 with SMTP id 20so201266wwd.1
        for <git@vger.kernel.org>; Mon, 13 Sep 2010 12:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=DlKeef8AbgPE5hCkT6hZQnwEBoEeCv8xgeEAg7aIBMw=;
        b=HzRHqN50VKyjSPn/WPte4hsQpJVLzMDSnzGqcSdb0bHQB/yKEwn8InG6LQU9pDVLyH
         pKPn2Yv5t9gPuDBVt40sOjIsVEJc5eYUoi2sCOche8tML5ylKBHBCgil2yRldIbZ5xPo
         87c7myLbrjrhm2gTyHSdo65AZL6enRStTZsDU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=H25wsuEKv8+hZfSdQ615+aj7mD4s1TvnUdOanPv0XTQq2oDO2rAfrqw4fMQSOFC+BV
         7jqb2xMNQWk2Z/Okpga4pRC98K8F2pYIIJkYBGRKEJUmdMtAZ5qI2EJtJbFar5YSeBo/
         OEBQFuA6oP7zAqpDm6z9msjI9KXzYZjm+4VzY=
Received: by 10.216.154.133 with SMTP id h5mr4607787wek.93.1284406572225;
        Mon, 13 Sep 2010 12:36:12 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id k7sm4178195wej.2.2010.09.13.12.36.11
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 13 Sep 2010 12:36:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc1.110.g6776a.dirty
In-Reply-To: <1284406558-23684-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156119>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-pull.sh |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 544b73f..324ac95 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -18,20 +18,20 @@ cd_to_toplevel
 die_conflict () {
     git diff-index --cached --name-status -r --ignore-submodules HEAD =
--
     if [ $(git config --bool --get advice.resolveConflict || echo true=
) =3D "true" ]; then
-	die "Pull is not possible because you have unmerged files.
+	die "$(gettext "Pull is not possible because you have unmerged files.
 Please, fix them up in the work tree, and then use 'git add/rm <file>'
-as appropriate to mark resolution, or use 'git commit -a'."
+as appropriate to mark resolution, or use 'git commit -a'.")"
     else
-	die "Pull is not possible because you have unmerged files."
+	die "$(gettext "Pull is not possible because you have unmerged files.=
")"
     fi
 }
=20
 die_merge () {
     if [ $(git config --bool --get advice.resolveConflict || echo true=
) =3D "true" ]; then
-	die "You have not concluded your merge (MERGE_HEAD exists).
-Please, commit your changes before you can merge."
+	die "$(gettext "You have not concluded your merge (MERGE_HEAD exists)=
=2E
+Please, commit your changes before you can merge.")"
     else
-	die "You have not concluded your merge (MERGE_HEAD exists)."
+	die "$(gettext "You have not concluded your merge (MERGE_HEAD exists)=
=2E")"
     fi
 }
=20
@@ -199,13 +199,13 @@ test true =3D "$rebase" && {
 		# On an unborn branch
 		if test -f "$GIT_DIR/index"
 		then
-			die "updating an unborn branch with changes added to the index"
+			die "$(gettext "updating an unborn branch with changes added to the=
 index")"
 		fi
 	else
 		git update-index --ignore-submodules --refresh &&
 		git diff-files --ignore-submodules --quiet &&
 		git diff-index --ignore-submodules --cached --quiet HEAD -- ||
-		die "refusing to pull with rebase: your working tree is not up-to-da=
te"
+		die "$(gettext "refusing to pull with rebase: your working tree is n=
ot up-to-date")"
 	fi
 	oldremoteref=3D &&
 	. git-parse-remote &&
@@ -258,11 +258,11 @@ case "$merge_head" in
 ?*' '?*)
 	if test -z "$orig_head"
 	then
-		die "Cannot merge multiple branches into empty head"
+		die "$(gettext "Cannot merge multiple branches into empty head")"
 	fi
 	if test true =3D "$rebase"
 	then
-		die "Cannot rebase onto multiple branches"
+		die "$(gettext "Cannot rebase onto multiple branches")"
 	fi
 	;;
 esac
--=20
1.7.3.rc1.110.g6776a.dirty
