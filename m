From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 14/48] i18n: git-pull die messages
Date: Sat, 21 May 2011 18:43:55 +0000
Message-ID: <1306003469-22939-15-git-send-email-avarab@gmail.com>
References: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 20:47:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNrCr-0001Bj-6t
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 20:47:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757228Ab1EUSrO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 May 2011 14:47:14 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:50211 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755403Ab1EUSpP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 14:45:15 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1451108ewy.19
        for <git@vger.kernel.org>; Sat, 21 May 2011 11:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=KtMCxfuaf1L3ewx5t0Xgz0CEwxaAK7Me0XOdOJa/X+U=;
        b=rDR1/t6PO3gkHRDgF2X1RCPjyv26hNj5gjTN6iys9ZxCjcrpvB98Yu2GVXYHgt6fTe
         ZvMTrNbAo+OCTd89rz0tuQjWtT8/isNsDh5iDA8bZCPieMZLCNrR4hT4bd+YQ1ZsOFQ9
         U7jcmtfUq0ncM4Lj6HBguX7oGfMlPu/jjczSE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=lDlIUAtESsIYjzCXYqHtGmeIcw6IKQ3Xz32H8lX/jxUeCnoo+MTyaQd0E5mV/4BMT/
         /9loXgN+tj3zKwKV/EosynXt7B+mv25OjB2sDhgKy76QUgZ7XTG3teM2jTyf3uJqlFK2
         B01DSNLgJEFv2uyolEHFFEiY5Qm5E82v0j6IY=
Received: by 10.213.30.16 with SMTP id s16mr597545ebc.138.1306003514989;
        Sat, 21 May 2011 11:45:14 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id y14sm1130434eeh.3.2011.05.21.11.45.14
        (version=SSLv3 cipher=OTHER);
        Sat, 21 May 2011 11:45:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174163>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-pull.sh |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 05011b1..acb0c37 100755
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
@@ -186,7 +186,7 @@ test true =3D "$rebase" && {
 		# On an unborn branch
 		if test -f "$GIT_DIR/index"
 		then
-			die "updating an unborn branch with changes added to the index"
+			die "$(gettext "updating an unborn branch with changes added to the=
 index")"
 		fi
 	else
 		require_clean_work_tree "pull with rebase" "Please commit or stash t=
hem."
@@ -242,11 +242,11 @@ case "$merge_head" in
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
1.7.5.1
