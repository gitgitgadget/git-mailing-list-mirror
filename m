From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 05/12] gettextize: git-submodule $update_module say + die messages
Date: Mon, 13 Sep 2010 22:09:11 +0000
Message-ID: <1284415758-20931-6-git-send-email-avarab@gmail.com>
References: <1284415758-20931-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 14 00:10:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvHEC-0006xe-4T
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 00:10:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753647Ab0IMWKK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Sep 2010 18:10:10 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44144 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751931Ab0IMWKI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Sep 2010 18:10:08 -0400
Received: by mail-wy0-f174.google.com with SMTP id 22so6742715wyf.19
        for <git@vger.kernel.org>; Mon, 13 Sep 2010 15:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=ZDEW/5pHGgAlVovSRbIsX+C5KoyPYKrYDoqAaZC7hOI=;
        b=ghsGhgnlYL5sEIPdjDXqOG3cnirgxiYQikh6v2fIf3SOFDMfTXv4H0qp9lgPtQ+nx+
         ytTG8qjJVC0u/wXzCCypqGsKCcn8vlChrwgp8aAU7fkHYY2Oi+UdH7Mi5HLOx+OzNseD
         oZ653Fl/qwlX8Hm1xOPb7lWdB5AzSsTesN/Ws=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=vUlycz4ToolWMFNhPttyZmiedfNCj7xzbyCJwn/5sp5P80vu4E1w/6iYS8jZN9tZ4X
         yb7Ib2r7LLLrR6O1f2wujkJYj+aMDj85naVSwtuCDBxquaOPVlHGL/ckO6LYsEfppMQd
         Gpa6KpBnmqSbgNQ609Lp02BUhNFNZk0jnYxCg=
Received: by 10.216.26.194 with SMTP id c44mr4763049wea.104.1284415807806;
        Mon, 13 Sep 2010 15:10:07 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id w14sm4296416weq.9.2010.09.13.15.10.05
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 13 Sep 2010 15:10:06 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc1.220.gb4d42
In-Reply-To: <1284415758-20931-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156138>

Gettextize $update_module say and die messages. These messages needed
to be split up to make them translatable.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-submodule.sh |   17 ++++++++---------
 1 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 1b3132f..2b33c5f 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -479,24 +479,23 @@ cmd_update()
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
1.7.3.rc1.220.gb4d42
