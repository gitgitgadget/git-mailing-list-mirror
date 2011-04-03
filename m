From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 13/51] i18n: git-pull die messages
Date: Sun,  3 Apr 2011 16:45:37 +0000
Message-ID: <1301849175-1697-14-git-send-email-avarab@gmail.com>
References: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 18:49:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6QUZ-0005ya-WF
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 18:49:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753348Ab1DCQss convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Apr 2011 12:48:48 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:59126 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752757Ab1DCQqn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 12:46:43 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1505877ewy.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 09:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=PLaT+6y8bYMXKwNj1orDvyKDF0SYGjRWAG+mHrtrHjI=;
        b=jf3HPUqqRkOoUo6d0MwfdwBaibg3FlLAhzGht3D9HfholgZyE8IKnhLcD13Vf/6Jch
         +snwS1ImmhuCCpfj8M2w6wrENm6SE3j9/ZVrdI5LVLLbNZqi5BqKixgUG43AlsWosXya
         XcFNZMPfPRot6AkSTdtY4MbOEG0NMqKlk2ljg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=mrD+4omi3ypKMRVQra19BXtyhMVp0lqTiyMbY/TptzVX9NoCBAed60Bmyfxw+HTUrQ
         iwxBtqz+Pg2F/PAC03ieC5kBCzBrx+DEiOwVsyj3DvW++nCFMiDgVGKVtTk2Lz7qTLOH
         wBGgLPEmQvDFAiaNohbZmlozXGImpPUAfKux8=
Received: by 10.213.97.7 with SMTP id j7mr3173318ebn.112.1301849203012;
        Sun, 03 Apr 2011 09:46:43 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id w59sm2750567eeh.24.2011.04.03.09.46.42
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 09:46:42 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170752>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-pull.sh |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 0b623bf..b19e097 100755
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
@@ -207,9 +207,10 @@ test true =3D "$rebase" && {
 		# On an unborn branch
 		if test -f "$GIT_DIR/index"
 		then
-			die "updating an unborn branch with changes added to the index"
+			die "$(gettext "updating an unborn branch with changes added to the=
 index")"
 		fi
 	else
+		# XXX: This is an abomination
 		require_clean_work_tree "pull with rebase" "Please commit or stash t=
hem."
 	fi
 	oldremoteref=3D &&
@@ -263,11 +264,11 @@ case "$merge_head" in
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
1.7.4.1
