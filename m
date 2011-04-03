From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 07/51] i18n: git-am cannot_fallback messages
Date: Sun,  3 Apr 2011 16:45:31 +0000
Message-ID: <1301849175-1697-8-git-send-email-avarab@gmail.com>
References: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 18:49:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6QUb-0005ya-MA
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 18:49:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753365Ab1DCQs7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Apr 2011 12:48:59 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:57591 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752582Ab1DCQqi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 12:46:38 -0400
Received: by eyx24 with SMTP id 24so1502912eyx.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 09:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=ErcKmeoGPljQTA2DNZwfs67rs++mk/oEOBWnjpUZ7Sg=;
        b=BUOW1hYYqXgnwnzV0Dp0H1Dz2F3s2R6v/aN4jgJI6kzfEWgqpCQWKzqoHLbQFnEAwP
         04GWGnq9BK9pYiqliPSUffExxz/mY3wyNAmI1DxLGZB6VAehWee4pPAHdVqR7Sfap3gW
         znq+k6mWN9O14NTjUVCfJXgIOaJdGbr3r26Zg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=YovVvd67Ql8Jw/n+cjl0HeVC6L6u2PCWqOMcHBBWv87Y6jeyiCckw+fHGk6bzb45/A
         P4IElaK7Y/K4VdZ2KLRXFX8yX0gf61aAXnjIRe/c4BH9EoI3eEehR5n5i6Sc939gsEPE
         CvpKsO1fbMZXRBOO7QMm+6EFXzbOI/poBqePk=
Received: by 10.213.103.138 with SMTP id k10mr1162027ebo.125.1301849196864;
        Sun, 03 Apr 2011 09:46:36 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id w59sm2750567eeh.24.2011.04.03.09.46.36
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 09:46:36 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170754>

Translate messages with gettext(1) before they're passed to the
cannot_fallback function, just like we handle the die function.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-am.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index cbd48a9..5c06eda 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -130,7 +130,7 @@ fall_back_3way () {
 	"$dotest/patch" &&
     GIT_INDEX_FILE=3D"$dotest/patch-merge-tmp-index" \
     git write-tree >"$dotest/patch-merge-base+" ||
-    cannot_fallback "Repository lacks necessary blobs to fall back on =
3-way merge."
+    cannot_fallback "$(gettext "Repository lacks necessary blobs to fa=
ll back on 3-way merge.")"
=20
     say Using index info to reconstruct a base tree...
     if GIT_INDEX_FILE=3D"$dotest/patch-merge-tmp-index" \
@@ -139,8 +139,8 @@ fall_back_3way () {
 	mv "$dotest/patch-merge-base+" "$dotest/patch-merge-base"
 	mv "$dotest/patch-merge-tmp-index" "$dotest/patch-merge-index"
     else
-        cannot_fallback "Did you hand edit your patch?
-It does not apply to blobs recorded in its index."
+        cannot_fallback "$(gettext "Did you hand edit your patch?
+It does not apply to blobs recorded in its index.")"
     fi
=20
     test -f "$dotest/patch-merge-index" &&
--=20
1.7.4.1
