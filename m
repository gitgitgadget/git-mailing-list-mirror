From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 36/51] i18n: git-stash die + eval_gettext messages
Date: Sun,  3 Apr 2011 16:46:00 +0000
Message-ID: <1301849175-1697-37-git-send-email-avarab@gmail.com>
References: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 18:48:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6QTS-0005RJ-Jv
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 18:48:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753267Ab1DCQsI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Apr 2011 12:48:08 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:59126 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753078Ab1DCQrH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 12:47:07 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1505877ewy.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 09:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=KkMusRu6xsoM+w8rS7TATmheS33/q3ha2yvECuo8j5M=;
        b=vf9wicgws8ZxEbx7X5uyXvKNacZvrXR+Enxu3HYZsGMHOv1Vw4Q+7wecdvuOZnAsYg
         zxCZ6ezYtOl4NSSyYXQnZXEzfq0qDfG77zpVt24/yx1iWTFSRtUqWhaDS6qMdg9dCFz8
         54tqaAWri15jUVI6yhAlgpkn3OsKHiVBIRw14=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=cGngR7sd8Hk2icGq7J7Yg65pj2UExtJfD0Q84ShSM0TKz1QDjozWUSGpkJw6FcP5R7
         mEj2oKwaNGITsDXaq7jN08KcVuWCEAmfRHfUynKlBcnPbOXPKFtAtx2YAz1xd3vw325g
         t90p3MfZFt9dkmrsqgTRthsCwm2/+wmTqIAnE=
Received: by 10.213.22.71 with SMTP id m7mr1162257ebb.123.1301849227100;
        Sun, 03 Apr 2011 09:47:07 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id w59sm2750567eeh.24.2011.04.03.09.47.03
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 09:47:06 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170741>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-stash.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 753ddf2..06f00ae 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -294,7 +294,7 @@ parse_flags_and_rev()
 			:
 		;;
 		*)
-			die "Too many revisions specified: $REV"
+			die "$(eval_gettext "Too many revisions specified: \$REV")"
 		;;
 	esac
=20
@@ -318,7 +318,7 @@ parse_flags_and_rev()
 		# this condition with a non-zero status code but as of 1.7.2.1 it
 		# it did not. So, we use non-empty stderr output as a proxy for the
 		# condition of interest.
-		test -z "$(git rev-parse "$REV" 2>&1 >/dev/null)" || die "$REV does =
not exist in the stash log"
+		test -z "$(git rev-parse "$REV" 2>&1 >/dev/null)" || die "$(eval_get=
text "\$REV does not exist in the stash log")"
 	fi
=20
 }
--=20
1.7.4.1
