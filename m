From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 18/48] i18n: git-submodule echo + eval_gettext messages
Date: Sat, 21 May 2011 18:43:59 +0000
Message-ID: <1306003469-22939-19-git-send-email-avarab@gmail.com>
References: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 20:45:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNrB8-0000JJ-F6
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 20:45:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756772Ab1EUSp0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 May 2011 14:45:26 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:47760 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450Ab1EUSpT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 14:45:19 -0400
Received: by ewy4 with SMTP id 4so1451135ewy.19
        for <git@vger.kernel.org>; Sat, 21 May 2011 11:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=XHuMfPFpz7ZEbRq8TKhKQ7NXjIip5nCB0+K5xd9Xk/I=;
        b=fQKd4la2FNGYkkAtSGZfwXiMnYXY+zG7z8ANXtxCs6QdGOesuRMv4OsEqbw36875NK
         pQ1H43sVKZyF1NZghINYuUvzFh4yDXCy6wOZa028ixRL7k81n8cR8Eiign6NchWdT1da
         PrYCgSLLXRnSCeKxJqgZ4LUD5+lgqi5xGzh6U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=L8rvw8RU52hRtS/d9GYfWhSnP6767GWFdAhZ/9xGCWHWiHO82G9iOPrFt/OeHmxApn
         HlYrLaA5Y6oUupj3C9QMSHApFoIrsqRZA+02X9epmUlaw3656i8R64HQa42LfDcz0Smz
         j//EH0v8KIER6TeQhvdZEYYo3Y5xgE3Bxp3R0=
Received: by 10.14.11.28 with SMTP id 28mr279182eew.86.1306003518753;
        Sat, 21 May 2011 11:45:18 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id y14sm1130434eeh.3.2011.05.21.11.45.17
        (version=SSLv3 cipher=OTHER);
        Sat, 21 May 2011 11:45:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174124>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-submodule.sh |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 816ab3d..547f5cb 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -234,7 +234,7 @@ cmd_add()
 	then
 		if test -d "$path"/.git -o -f "$path"/.git
 		then
-			echo "Adding existing repo at '$path' to the index"
+			eval_gettext "Adding existing repo at '\$path' to the index"; echo
 		else
 			die "'$path' already exists and is not a valid git repo"
 		fi
@@ -658,7 +658,10 @@ cmd_summary() {
 				;; # removed
 			*)
 				# unexpected type
-				echo >&2 "unexpected mode $mod_dst"
+				(
+					eval_gettext "unexpected mode \$mod_dst" &&
+					echo
+				) >&2
 				continue ;;
 			esac
 		fi
--=20
1.7.5.1
