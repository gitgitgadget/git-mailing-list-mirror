From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 24/51] i18n: git-submodule $update_module say + die messages
Date: Sun,  3 Apr 2011 16:45:48 +0000
Message-ID: <1301849175-1697-25-git-send-email-avarab@gmail.com>
References: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 18:49:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6QUX-0005ya-7K
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 18:49:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753069Ab1DCQs3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Apr 2011 12:48:29 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:33259 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752870Ab1DCQqy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 12:46:54 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1505908ewy.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 09:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=l4Urq4fNs3TkIXhG99P4Xm53ShKCTvYuMA6rJkZP+mY=;
        b=gNFFQkgSw2eX0qgNKFbGK+sNqMmpFoEgqQ0vK4cgXDBKMU8oLYEcYMdPv7qqUYzFsd
         q5u8dgyTtRpF8e0EBbHAcS1ue1zhSNOn+WYMNjk8+4vt2p34XBq8wPB200D9Epa+IFHN
         swCy7M7P9TnOJBJ+yM8yEc4jIfVfHEteLYJ5I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=VBOCPcmxSaXrGx5pUwsTVAMYM9l1amuTJkCUflxqbgLqAeTrOxQicMXklkoWbBSBcR
         SksUM9gxYOig9W48SudJkWepKa+4ZXyc2F1OAXdTQl4dIRcB16Zkw6KEcVgdjKp4eQuv
         2lPcmKdMDtrX4EDyW6ZfOU7FzS+nH9Nyiv2fk=
Received: by 10.213.98.84 with SMTP id p20mr3163601ebn.32.1301849213491;
        Sun, 03 Apr 2011 09:46:53 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id w59sm2750567eeh.24.2011.04.03.09.46.52
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 09:46:52 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170747>

Gettextize $update_module say and die messages. These messages needed
to be split up to make them translatable.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-submodule.sh |   17 ++++++++---------
 1 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index dcdda53..c35fab0 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -482,24 +482,23 @@ cmd_update()
 			case "$update_module" in
 			rebase)
 				command=3D"git rebase"
-				action=3D"rebase"
-				msg=3D"rebased onto"
+				die_msg=3D"$(eval_gettext "Unable to rebase '\$sha1' in submodule =
path '\$path'")"
+				say_msg=3D"$(eval_gettext "Submodule path '\$path': rebased into '=
\$sha1'")"
 				;;
 			merge)
 				command=3D"git merge"
-				action=3D"merge"
-				msg=3D"merged in"
+				die_msg=3D"$(eval_gettext "Unable to rebase '\$sha1' in submodule =
path '\$path'")"
+				say_msg=3D"$(eval_gettext "Submodule path '\$path': merged in '\$s=
ha1'")"
 				;;
 			*)
 				command=3D"git checkout $force -q"
-				action=3D"checkout"
-				msg=3D"checked out"
+				die_msg=3D"$(eval_gettext "Unable to rebase '\$sha1' in submodule =
path '\$path'")"
+				say_msg=3D"$(eval_gettext "Submodule path '\$path': checked out '\=
$sha1'")"
 				;;
 			esac
=20
-			(clear_local_git_env; cd "$path" && $command "$sha1") ||
-			die "Unable to $action '$sha1' in submodule path '$path'"
-			say "Submodule path '$path': $msg '$sha1'"
+			(clear_local_git_env; cd "$path" && $command "$sha1") || die $die_m=
sg
+			say $say_msg
 		fi
=20
 		if test -n "$recursive"
--=20
1.7.4.1
