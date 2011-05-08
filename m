From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 14/48] i18n: git-pull die messages
Date: Sun,  8 May 2011 12:20:46 +0000
Message-ID: <1304857280-14773-15-git-send-email-avarab@gmail.com>
References: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 14:22:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ304-0003rg-JB
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 14:22:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753533Ab1EHMVu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 08:21:50 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:35010 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753048Ab1EHMVp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 08:21:45 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1327054ewy.19
        for <git@vger.kernel.org>; Sun, 08 May 2011 05:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=7SYxy+P5lbV3xTggNId/F+6K2J5mo/d5g5mSGrpO2s8=;
        b=JAyhqxKObdsun7dMj/yqGUweAkV6EG146/4Rk7ffMlhooxBIzG7loU4TKHUs1qFhqH
         JgSgQAjZHfaFFLlglak5MQJVmaEaONKheeKqe9+cSOVktNvg4deI+Xdhkt6xE3FonCdX
         AS0FIawzZPoGc4J2PC8jguiHbW6gNDfr6qAs0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=EcCIb8kOUDPeglnbpQEX+anB6HsboTu7y0w4L+CLhcHZ7ZRgtEepgk4FqmG2ahktrN
         hqdeF0tnPsTwcaGUoc/JRGfyt27WDEq+7hUvQ5FyJAVSiamaJt0I14gruJ5ALjwUVXMw
         yIBwuBLNfVZRAXWCj9cIevNOb/ud3l9L1bgpo=
Received: by 10.213.8.207 with SMTP id i15mr653297ebi.129.1304857304349;
        Sun, 08 May 2011 05:21:44 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id n55sm2690046een.2.2011.05.08.05.21.43
        (version=SSLv3 cipher=OTHER);
        Sun, 08 May 2011 05:21:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173113>

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
1.7.4.4
