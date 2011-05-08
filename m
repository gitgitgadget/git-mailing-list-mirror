From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 37/48] i18n: git-stash drop_stash say/die messages
Date: Sun,  8 May 2011 12:21:09 +0000
Message-ID: <1304857280-14773-38-git-send-email-avarab@gmail.com>
References: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 14:23:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ30r-0004Hv-QE
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 14:23:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753909Ab1EHMW1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 08:22:27 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:50701 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753430Ab1EHMWI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 08:22:08 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1327021ewy.19
        for <git@vger.kernel.org>; Sun, 08 May 2011 05:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=/5U+t5kPfWPzGy89ZP165bwmtdhOyrZdtX+Ngo2o440=;
        b=XZgwjsXwkEo8a2lTp6hzc4DtSZvzxh49iR0csXXvosj3K22smTn/jF3duy2K7gC96x
         7nA9BsdmaNTioJP7fzO4jHBYTrAFAyntkC9MZjr9MVHP2Dd0NjJPx1B0Ckw6TudLOKl6
         GvRBruw/YJlgVQf75Cgx1aN1AVdzrgXG0vsdQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=SIzIHdiLNMI0yW4HI1PWIGpqbC2Y3AFl3A3XwmlfpqaGAuN9NBfbh2JzcW4rBJdUZF
         Y8KC4N14DHnrPAp5sEmvYQbGPyhGUIak8oUbgmR1zlEEqams/JQI2+YH8Y+Q/rxWYIVy
         7IgTvgFc8CIueAM2/yj1Zmz1mnugbvxKcMFV4=
Received: by 10.213.26.213 with SMTP id f21mr1956378ebc.70.1304857327776;
        Sun, 08 May 2011 05:22:07 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id n55sm2690046een.2.2011.05.08.05.22.06
        (version=SSLv3 cipher=OTHER);
        Sun, 08 May 2011 05:22:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173128>

Gettextize the say/die eval_gettext messages in the drop_stash
function. Since making these translatable would result in a long line
I've wrapped this into two lines.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-stash.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 73fa2ce..0b575cf 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -422,7 +422,8 @@ drop_stash () {
 	assert_stash_ref "$@"
=20
 	git reflog delete --updateref --rewrite "${REV}" &&
-		say "Dropped ${REV} ($s)" || die "${REV}: Could not drop stash entry=
"
+		say "$(eval_gettext "Dropped \${REV} (\$s)")" ||
+		die "$(eval_gettext "\${REV}: Could not drop stash entry")"
=20
 	# clear_stash if we just dropped the last stash entry
 	git rev-parse --verify "$ref_stash@{0}" > /dev/null 2>&1 || clear_sta=
sh
--=20
1.7.4.4
